<?php

require_once('htmlform.inc');

class ClientForm extends HtmlForm {
	
	public function showClientForm() {

		// retrieve the client id from the URL and pass to $getvalues
		$getnames = array('clientid');
		$getvalues = $this -> getGetValues($getnames);

		// set client_id as session variable for use with submenus -- needs reworking as this is dupe code from basepage
		$_SESSION['client_id'] = $getvalues['clientid'];
		
		// use client id to retrieve all the client details
		$sql = new Dbconnect();
		
		if (!empty($getvalues['clientid'])) {
			$clientdata = $sql->getEntityDetails($getvalues, 'sp_client_details');
			$displaydata = $clientdata['client_name'];			
		} else {
			$displaydata = null;
		}
		
		// form header and format are set
//		$displaydata = $clientdata['client_name'];
		$formheader = $this -> setFormHeader('Client', $displaydata);
		$this->formFormat($formheader);
		
		// set spparam array to pass to the callSp procedure
		$spparams = array("-1");
		$out = array();
		$countries = $sql->callSP('sys_countries_read', $out, $spparams);
		$statuses = $sql->callSP('sys_statuses_read', $out, $spparams);
		$sortorder = array(1,2,3);
		$statuses = $this->statusSort($statuses, $sortorder);		
		
		$currencies = $sql->callSP('sys_currencies_read', $out, $spparams);
		
		// set array to "select all" -1 and domain_id to retrieve all records for this domain only
		$domparams = array("-1", $_SESSION['domain_id']);
		$packages = $sql->callSP('sys_packages_read', $out, $domparams);
		$reports = $sql->callSP('sys_report_config_read', $out, $domparams);
		
		// gather timezone array for use in timezone select list
		$timezones = $this->generate_timezone_list();
		
		// contacts yet to be built
		$contacts = array();
		
		$this -> clientFormBuilder(
			$clientdata,
			$countries,
			$statuses,
			$currencies,
			$packages,
			$contacts,
			$reports,
			$timezones
		);
		
	}

	private function clientFormBuilder(&$clientdata, &$countries, &$statuses, &$currencies, &$packages, &$contacts, &$reports, &$timezones) {
	
		echo "<form method='post' action='clientdetails.php'>";
		echo "<div class='form-group'>";
		
		// client name
		echo "<div class='row'>\n<div class='col-6'>";
			echo "<p>Client Name: <input class='form-control' placeholder='Enter the client name' type='text' name='clientname' value='".$clientdata['client_name']."' size='80' required = 'true' maxlength='100' /></p>";
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
					if ($country['country_id'] == $clientdata['country_id']) {
						echo "<option value=".$country['country_id']." selected='selected'>".$country['country_name']."</option>";
					} else {
						echo "<option value=".$country['country_id'].">".$country['country_name']."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div></div>";

		// address
		echo "<div class='row'>\n<div class='col-6'>";			
			echo "<p>Address: <input class='form-control' placeholder='Enter client address' type='text' name='address1' value='".$clientdata['address_1']."' size='80' maxlength='80' />";
		echo "</div></div>";
		echo "<div class='row'>\n<div class='col-6'>";
			echo "<input class='form-control' placeholder='Enter client address' type='text' name='address2' value='".$clientdata['address_2']."' size='80' maxlength='80' /></p>";
		echo "</div></div>";
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>City: <input class='form-control' placeholder='Enter client city' type='text' name='city' value='".$clientdata['city']."' maxlength='30' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>State / Region: <input class='form-control' placeholder='Enter state / region' type='text' name='region' value='".$clientdata['region']."' maxlength='30' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Zip / Postal Code: <input class='form-control' placeholder='Postcode' type='text' name='postcode' value='".$clientdata['postalcode']."' maxlength='10' /></p>";
		echo "</div></div></div>";
		echo "<hr>";

		// collapse client info
		echo "<h4><a data-toggle='collapse' href='#clientinfocollapse' aria-expanded='false' aria-controls='clientinfocollapse'>Client Info</a></h4>";
		echo "<div class='collapse.show' id='clientinfocollapse'>";

		//package & status		
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Package: <select class='form-control' name='package'>";
				foreach ($packages as $package) {
					if ($package['package_id'] == $clientdata['package_id']) {
						echo "<option value=".$package['package_id']." selected='selected'>".$package['package_name']."</option>";
					} else {
						echo "<option value=".$package['package_id'].">".$package['package_name']."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Status: <select class='form-control' name='status'>";
				// limit so we only see Active, Inactive & Dormant
				foreach ($statuses as $status) {
					if ($status['status_id'] == $clientdata['client_status']) {
						echo "<option value=".$status['status_id']." selected='selected'>".$status['status_name']."</option>";						
					} else {
						echo "<option value=".$status['status_id'].">".$status['status_name']."</option>";
					}
				}
			echo "</select></p>";
		echo "</div></div>";
		
		//currency, timezone & last completed job
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Currency: <select class='form-control' name='currency' required = 'true'>";
				foreach ($currencies as $currency) {
					if ($currency['currency_id'] == $clientdata['currency_id']) {
						echo "<option value=".$currency['currency_id']." selected='selected'>".$currency['currency_code']." - ".$currency['currency_name']."</option>";
					} else {
						echo "<option value=".$currency['currency_id'].">".$currency['currency_code']." - ".$currency['currency_name']."</option>";
					}
				}
			echo "</select></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>TimeZone: 2 <select class='form-control' name='timezone' required = 'true'>";
				foreach ($timezones as $key => $value) {
					if ($key == $clientdata['timezone']) {
						echo "<option value=".$key." selected='selected'>".$value."</option>";
					} else {
						echo "<option value=".$key.">".$value."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Last Completed Job: <input class='form-control' placeholder='Last Completed Job' data-provide='datepicker' data-date-format='yyyy-mm-dd' type='text' name='lastjob' value='".substr($clientdata['last_completed_job'], 0, 10)."' maxlength='10' /></p>";
		echo "</div></div>";

		// Notes
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Notes: <textarea class='form-control' name='clientnotes' rows='5' cols='30'>".$clientdata['notes']."</textarea></p>";
		echo "</div></div>";
		
		//UDFs - Need to be updated so lables reflect what is set in the settings per domain
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>User-Defined 1: <input class='form-control' placeholder='User-defined 1' type='text' name='clientudf1' value='".$clientdata['user_defined_1']."' maxlength='50' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>User-Defined 2: <input class='form-control' placeholder='User-defined 2' type='text' name='clientudf2'  value='".$clientdata['user_defined_2']."'maxlength='50' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>User-Defined 3: <input class='form-control' placeholder='User-defined 3' type='text' name='clientudf3'  value='".$clientdata['user_defined_3']."'maxlength='50' /></p>";
		echo "</div></div></div>";
		echo "<hr>";
		
		// collapse invoice info
		echo "<h4><a data-toggle='collapse' href='#invoiceinfocollapse' aria-expanded='false' aria-controls='invoiceinfocollapse'>Invoice Info</a></h4>";
		echo "<div class='collapse.show' id='invoiceinfocollapse'>";
		
		// Invoice info
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Invoice To: <select class='form-control' name='invoiceto'>";
//				foreach ($countries as $country) {
//					echo "<option value=".$country['country_id'].">".$country['country_name']."</option>";
//				}
			echo "</select></p>";
		echo "</div>"; 
		echo "<div class='col'>";
			echo "<br><input class='form-control' placeholder='Enter Invoice Email' type='text' name='invtoemail' value='".$clientdata['invoice_to_email']."' size='80' maxlength='80' />";
		echo "</div></div>";
		
		// Invoice Notes
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Invoice Notes: <textarea class='form-control' name='clientinvnotes' rows='5' cols='30'>".$clientdata['invoice_notes']."</textarea></p>";
		echo "</div></div>";
		
		// Invoice Report & Last Invoice Date
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Invoice Report: <select class='form-control' name='invoicereport'>";
				foreach ($reports as $report) {
					if ($report['report_id'] == $clientdata['inv_report_id']) {
						echo "<option value=".$report['report_id']." selected='selected'>".$report['report_name']."</option>";						
					} else {
						echo "<option value=".$report['report_id'].">".$report['report_name']."</option>";
					}
				}
			echo "</select></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Last Completed Invoice: <input class='form-control' placeholder='Last Completed Invoice' data-provide='datepicker' data-date-format='yyyy-mm-dd' type='text' name='lastinv' value='".substr($clientdata['last_invoice'], 0, 10)."' maxlength='10' /></p>";
		echo "</div></div>";

		// Invoice by & Invoice paid day
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Invoice by (day of month): <input class='form-control' placeholder='Invoice by date' type='text' name='invoiceby' value='".$clientdata['invoice_by']."' maxlength='10' /></p>";		
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Invoice Paid by (day of month): <input class='form-control' placeholder='Invoice paid date' type='text' name='invoicepaid' value='".$clientdata['invoice_paid']."' maxlength='10' /></p>";
		echo "</div></div></div>";
		
		// hidden clientid - determine if an update or insert is needed
		echo "<input type='hidden' name='recordid' value='".$clientdata['client_id']."'>";
		// hidden address_id - used for address updates
		echo "<input type='hidden' name='addressid' value='".$clientdata['address_id']."'>";
		
		// submit
		echo "<div class='row'>\n<div class='col-auto mr-auto'>";		
			echo "</br><input class='btn btn-outline-primary' type='submit' value='Save' /> ";
		echo "</div><div class='col-auto'>";
			echo "<br> <input class='btn btn-outline-primary' type='reset' value='Reset' /> ";
			echo " <a class='btn btn-outline-primary' href='../web/clientlist.php' role='button'>Cancel</a> ";
			if (!empty($_GET['clientid'])) {
				echo " <a class='btn btn-outline-primary' href='../web/clientdetails.php' role='button'>New</a> ";
			}
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