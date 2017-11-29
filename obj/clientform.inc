<?php

require_once('htmlform.inc');

class ClientForm extends HtmlForm {
	
		public function newClientForm() {
		
		$sqsql = new Dbconnect();
		
		// set spparam array to pass to the callReadSp procedure
		$spparams = array("-1");
		$countries = $sqsql->callReadSp('sys_countries_read', $spparams);
		$statuses = $sqsql->callReadSp('sys_statuses_read', $spparams);
		$currencies = $sqsql->callReadSp('sys_currencies_read', $spparams);
		
		// set array to "select all" -1 and domain_id to retrieve all records for this domain only
		$domparams = array("-1", $_SESSION['domain_id']);
		$packages = $sqsql->callReadSp('sys_packages_read', $domparams);
		$reports = $sqsql->callReadSp('sys_report_config_read', $domparams);
		
		// gather timezone array for use in timezone select list
		$timezones = $this->generate_timezone_list();
		
/*	----------- BUILD FORM ---------- */
		echo "<form method='post' action='newclient.php'>";
		echo "<div class='form-group'>";
		
		// client name
		echo "<div class='row'>\n<div class='col-6'>";
			echo "<p>Client Name: <input class='form-control' placeholder='Enter the client name' type='text' name='clientname' size='80' maxlength='100' /></p>";
		echo "</div></div>";
		echo "<hr>";
		
		// collapse address
		echo "<h4><a data-toggle='collapse' href='#addresscollapse' aria-expanded='false' aria-controls='addresscollapse'>Address Info</a></h4>";
		echo "<div class='collapse.show' id='addresscollapse'>";

		// Country select
		echo "<div class='row'>\n<div class='col-4'>";
			echo "<p>Country: <select class='form-control' name='country'>";
				foreach ($countries as $country) {
					echo "<option value=".$country['country_id'].">".$country['country_name']."</option>";
				} 
			echo "</select></p>";
		echo "</div></div>";

		// address
		echo "<div class='row'>\n<div class='col-6'>";			
			echo "<p>Address: <input class='form-control' placeholder='Enter client address' type='text' name='address1' size='80' maxlength='80' />";
		echo "</div></div>";
		echo "<div class='row'>\n<div class='col-6'>";
			echo "<input class='form-control' placeholder='Enter client address' type='text' name='address2' size='80' maxlength='80' /></p>";
		echo "</div></div>";
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>City: <input class='form-control' placeholder='Enter client city' type='text' name='city' maxlength='30' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>State / Region: <input class='form-control' placeholder='Enter state / region' type='text' name='region' maxlength='30' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Zip / Postal Code: <input class='form-control' placeholder='Postcode' type='text' name='postcode' maxlength='10' /></p>";
		echo "</div></div></div>";
		echo "<hr>";

		// collapse client info
		echo "<h4><a data-toggle='collapse' href='#clientinfocollapse' aria-expanded='false' aria-controls='clientinfocollapse'>Client Info</a></h4>";
		echo "<div class='collapse.show' id='clientinfocollapse'>";

		//package & status		
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Package: <select class='form-control' name='package'>";
				foreach ($packages as $package) {
					echo "<option value=".$package['package_id'].">".$package['package_name']."</option>";
				} 
			echo "</select></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Status: <select class='form-control' name='status'>";
				// limit so we only see Active, Inactive & Dormant
				foreach ($statuses as $status) {
					echo "<option value=".$status['status_id'].">".$status['status_name']."</option>";
				}
			echo "</select></p>";
		echo "</div></div>";
		
		//currency, timezone & last completed job
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Currency: <select class='form-control' name='currency'>";
				foreach ($currencies as $currency) {
					echo "<option value=".$currency['currency_id'].">".$currency['currency_code']." - ".$currency['currency_name']."</option>";
				}
			echo "</select></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>TimeZone: <select class='form-control' name='timezone'>";
				foreach ($timezones as $timezone) {
					echo "<option value=".$timezone.">".$timezone."</option>";
				} 
			echo "</select></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Last Completed Job: <input class='form-control' placeholder='Last Completed Job' data-provide='datepicker' data-date-format='yyyy-mm-dd' type='text' name='lastjob' maxlength='10' /></p>";
		echo "</div></div>";

		// Notes
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Notes: <textarea class='form-control' name='clientnotes' rows='5' cols='30'>Enter client notes here... </textarea></p>";
		echo "</div></div>";
		
		//UDFs - Need to be updated so lables reflect what is set in the settings per domain
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>User-Defined 1: <input class='form-control' placeholder='User-defined 1' type='text' name='clientudf1' maxlength='50' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>User-Defined 2: <input class='form-control' placeholder='User-defined 2' type='text' name='clientudf3' maxlength='50' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>User-Defined 3: <input class='form-control' placeholder='User-defined 3' type='text' name='clientudf3' maxlength='50' /></p>";
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
			echo "<br><input class='form-control' placeholder='Enter Invoice Email' type='text' name='invtoemail' size='80' maxlength='80' />";
		echo "</div></div>";
		
		// Invoice Notes
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Invoice Notes: <textarea class='form-control' name='clientinvnotes' rows='5' cols='30'>Enter client invoice notes here... </textarea></p>";
		echo "</div></div>";
		
		// Invoice Report & Last Invoice Date
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Invoice Report: <select class='form-control' name='invoicereport'>";
				foreach ($reports as $report) {
					echo "<option value=".$report['report_id'].">".$report['report_name']."</option>";
				}
			echo "</select></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Last Completed Invoice: <input class='form-control' placeholder='Last Completed Invoice' data-provide='datepicker' data-date-format='yyyy-mm-dd' type='text' name='lastinv' maxlength='10' /></p>";
		echo "</div></div>";

		// Invoice by & Invoice paid day
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Invoice by (day of month): <input class='form-control' placeholder='Invoice by date' type='text' name='invoiceby' maxlength='10' /></p>";		
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Invoice Paid by (day of month): <input class='form-control' placeholder='Invoice paid date' type='text' name='invoicepaid' maxlength='10' /></p>";
		echo "</div></div></div>";
		
		// submit
		echo "<div class='row'>\n<div class='col'>";		
			echo "</br><input class='btn btn-outline-primary' type='submit' value='Save' />";
		echo "</div></div></div></form>";
	}	
	
}

?>