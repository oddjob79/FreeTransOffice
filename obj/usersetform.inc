<?php

require_once('htmlform.inc');

class UserSetForm extends HtmlForm {
	
	public function showUserSetForm() {

		// retrieve user details
		$sql = new Dbconnect();
		$entityid = array($_SESSION['user_id']);
		$userdata = $sql->getEntityDetails($entityid, 'sp_user_details');

		// form header and format are set
		$this->formFormat('User Settings');
		
		// set spparam array to pass to the callSp procedure
		$spparams = array("-1");
		$out = array();
		$countries = $sql->callSP('sys_countries_read', $out, $spparams);
		$currencies = $sql->callSP('sys_currencies_read', $out, $spparams);
		
		// gather timezone array for use in timezone select list
		$timezones = $this->generate_timezone_list();
		
		$this -> usersetFormBuilder(
			$userdata,
			$countries,
			$currencies,
			$timezones
		);
		
	}

	private function usersetFormBuilder(&$userdata, &$countries, &$currencies, &$timezones) {
	
		echo "<form method='post' action='usersettings.php'>";
		echo "<div class='form-group'>";
		
		// readonly user details
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>User Name: <input class='form-control' type='text' name='username' value='".$userdata['user_name']."' size='80' maxlength='100' readonly /></p>";
		echo "</div><div class='col'>";
			echo "<br><a href='' class='supportalert'>Change Username</a>";
		echo "</div></div>";
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Password: <input class='form-control' type='text' name='password' value='**************' size='80' maxlength='100' readonly /></p>";
		echo "</div><div class='col'>";
			echo "<br><a href='' class='supportalert'>Change Password</a>";
		echo "</div></div>";
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Email: <input class='form-control' type='text' name='email' value='".$userdata['email']."' size='80' maxlength='100' readonly /></p>";
		echo "</div><div class='col'>";
			echo "<br><a href='' class='supportalert'>Change Email address</a>";
		echo "</div></div>";

		// Names
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>First Name: <input class='form-control' placeholder='Enter your first name here' type='text' name='firstname' value='".$userdata['first_name']."' size='80' maxlength='50' /></p>";
		echo "</div><div class='col'>";
			echo "<p>Last Name: <input class='form-control' placeholder='Enter your last name here' type='text' name='lastname' value='".$userdata['last_name']."' size='80' maxlength='80' /></p>";
		echo "</div></div>";
		echo "<div class='row'>\n<div class='col-6'>";
			echo "<p>Company Name: <input class='form-control' placeholder='Enter your company name here' type='text' name='companyname' value='".$userdata['company_name']."' size='80' maxlength='120' /></p>";
		echo "</div></div>";
		echo "<hr>";
		
		// collapse address
		echo "<h4><a data-toggle='collapse' href='#addresscollapse' aria-expanded='false' aria-controls='addresscollapse'>Address Info</a></h4>";
		echo "<div class='collapse.show' id='addresscollapse'>";

		// Country select
		echo "<div class='row'>\n<div class='col-4'>";
			echo "<p>Country: <select class='form-control' name='country'>";
			echo "<option value=''></option>";
				foreach ($countries as $country) {
					if ($country['country_id'] == $userdata['country_id']) {
						echo "<option value=".$country['country_id']." selected='selected'>".$country['country_name']."</option>";
					} else {
						echo "<option value=".$country['country_id'].">".$country['country_name']."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div></div>";

		// address
		echo "<div class='row'>\n<div class='col-6'>";			
			echo "<p>Address: <input class='form-control' placeholder='Enter your address' type='text' name='address1' value='".$userdata['address_1']."' size='80' maxlength='80' />";
		echo "</div></div>";
		echo "<div class='row'>\n<div class='col-6'>";
			echo "<input class='form-control' placeholder='Enter your address' type='text' name='address2' value='".$userdata['address_2']."' size='80' maxlength='80' /></p>";
		echo "</div></div>";
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>City: <input class='form-control' placeholder='Enter your city' type='text' name='city' value='".$userdata['city']."' maxlength='30' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>State / Region: <input class='form-control' placeholder='Enter state / region' type='text' name='region' value='".$userdata['region']."' maxlength='30' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Zip / Postal Code: <input class='form-control' placeholder='Postcode' type='text' name='postcode' value='".$userdata['postalcode']."' maxlength='10' /></p>";
		echo "</div></div></div>";
		echo "<hr>";

		//currency, timezone & last completed job
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Currency: <select class='form-control' name='currency' required = 'true'>";
				foreach ($currencies as $currency) {
					if ($currency['currency_id'] == $userdata['currency_id']) {
						echo "<option value=".$currency['currency_id']." selected='selected'>".$currency['currency_code']." - ".$currency['currency_name']."</option>";
					} else {
						echo "<option value=".$currency['currency_id'].">".$currency['currency_code']." - ".$currency['currency_name']."</option>";
					}
				}
			echo "</select></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>TimeZone: <select class='form-control' name='timezone' required = 'true'>";
				foreach ($timezones as $key => $value) {
					if ($key == $userdata['timezone']) {
						echo "<option value=".$key." selected='selected'>".$value."</option>";
					} else {
						echo "<option value=".$key.">".$value."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div></div>";

		// logo - not implemented yet
		echo "<div class='row'>\n<div class='col-6'>";
			echo "<p>Logo: <input class='form-control' placeholder='Enter company logo' type='file' name='logo' value='".$userdata['document_path']."' height='10' width='10' /></p>";
		echo "</div>";
		
		// job & Inv prefixes and next numbers
		echo "<div col-1>";
			echo "<br><p>Job No.</p>";
			echo "<br><p>Inv No.</p>";
		echo "</div><div col-3>";
			echo "<p>Prefix: <input class='form-control' type='text' name='jobprefix' value='".$userdata['jobnum_prefix']."' size='5' maxlength='5' /></p>";
			echo "<p><input class='form-control' type='text' name='invprefix' value='".$userdata['invnum_prefix']."' size='5' maxlength='5' /></p>";
		echo "</div><div col-3>";
			echo "<p>Next No: <input class='form-control' type='text' name='jobnext' value='".$userdata['jobnum_next']."' size='5' maxlength='5' /></p>";
			echo "<p><input class='form-control' type='text' name='invnext' value='".$userdata['invnum_next']."' size='5' maxlength='5' /></p>";
		echo "</div></div>";
		
		
		// hidden address_id - used for address updates
		echo "<input type='hidden' name='addressid' value='".$userdata['address_id']."'>";
		
		// submit
		echo "<div class='row'>\n<div class='col-auto mr-auto'>";		
			echo "</br><input class='btn btn-outline-primary' type='submit' value='Save' /> ";
		echo "</div><div class='col-auto'>";
			echo "<br> <input class='btn btn-outline-primary' type='reset' value='Reset' /> ";
			echo " <a class='btn btn-outline-primary' href='../web/usersettings.php' role='button'>Cancel</a> ";
		echo "</div></div></div></form>";
	}	

	private function getClientDetails(&$getvalues) {
		//instantiate sql connection
		$sql = new Dbconnect();
		// set parameters for sp (implode value(s) retrieved from _GET)
		$spparams = array(implode($getvalues), $_SESSION['domain_id']);
		$out = array();
		// call client details sp
		$clientdets = $sql->callSp('sp_client_details', $out, $spparams);
		// add results to array
		$clientrow = $sql->returnFirstRow($clientdets);
		return $clientrow;
	}
	
}

?>