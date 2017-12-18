<?php

require_once('htmlform.inc');

class JobForm extends HtmlForm {
	
	public function showJobForm() {
		
		// retrieve the contact id from the URL and pass to $getvalues
		$getnames = array('jobid', 'clientid');
		$getvalues = $this -> getGetValues($getnames);
		
		// use contact id to retrieve all the contact details
		$sql = new Dbconnect();

		if (!empty($getvalues['jobid'])) {
			$entityid = array($getvalues['jobid']);
			$jobdata = $sql->getEntityDetails($entityid, 'sp_job_details');
			$displaydata = $jobdata['client_name'] . ' - ' . $jobdata['client_job_number'];			
		} else {
			$displaydata = null;
		}
		
		// form header and format are set
		$formheader = $this->setFormHeader('Job', $displaydata);
		$this->formFormat($formheader);
	

	
		// set spparam array to pass to the callSP procedure
		$spparams = array("-1");
		$out = array();
		$statuses = $sql->callSP('sys_statuses_read', $out, $spparams);
		$sortorder = array(4, 5, 6, 2);
		$statuses = $this->statusSort($statuses, $sortorder);
		
		$currencies = $sql->callSP('sys_currencies_read', $out, $spparams);		
		
		// set array to "select all" -1 and domain_id to retrieve all records for this domain only
		$domparams = array("-1", $_SESSION['domain_id']);
		$clients = $sql->callSP('sp_client_details', $out, $domparams);
		$jobtypes = $sql->callSP('sys_job_types_read', $out, $domparams);
		$packages = $sql->callSP('sys_packages_read', $out, $domparams);	
		$jobprofiles = $sql->callSP('sp_job_profile_details', $out, $domparams);
		
		if (!empty($jobdata['client_id'])) {
			$jobclientid = $jobdata['client_id'];
		} else {
			$jobclientid = null;
		}
		$jobclientid = $this->emptyParam($getvalues['clientid'], $jobclientid, $getvalues['clientid']);
		
		$cldmparams = array("-1", $jobclientid, $_SESSION['domain_id']);
		$endclients = $sql->callSP('sp_end_client_details', $out, $cldmparams);

		
		// will need to update to account for timezones
		$jobnumsetarray = array(date('Ymd'), $_SESSION['domain_id']);
		$result = $sql->callSP('sp_find_next_jobnum', $out, $jobnumsetarray);
		$row = $sql->returnFirstRow($result);
		$nextjobnum = $this->emptyParam($row['new_job_number'], date('Ymd')."0001", $row['new_job_number']);

			
		$this -> jobFormBuilder(
			$jobdata,
			$statuses,
			$currencies,
			$clients,
			$jobtypes,
			$packages,
			$jobprofiles,
			$endclients,
			$nextjobnum,
			$jobclientid
		);
	}

	private function jobFormBuilder(&$jobdata, &$statuses, &$currencies, &$clients, &$jobtypes, &$packages, &$jobprofiles, &$endclients, $nextjobnum, $jobclientid) {
	
		echo "<form method='post' action='jobdetails.php'>";
		echo "<div class='form-group'>";
		
		// Client select & Job No
		$jobnumber = $this->emptyParam($jobdata['job_number'], $nextjobnum, $jobdata['job_number']);
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Client: <select class='form-control' id='clientselect' name='clientid' required = 'true'>";
			echo "<option value=''></option>";
				foreach ($clients as $client) {
					// if ($client['client_id'] == $jobdata['client_id']) {
					if ($client['client_id'] == $jobclientid) {
						echo "<option value=".$jobclientid." selected='selected'>".$client['client_name']."</option>";
					} else {
						echo "<option value=".$client['client_id'].">".$client['client_name']."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Job No: <input class='form-control' type='text' name='jobnumber' value='".$jobnumber."' readonly /></p>";
		echo "</div></div>";

		// End Client select
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>End Client: <select class='form-control' name='endclientid'>";
			echo "<option value=''></option>";
				foreach ($endclients as $endclient) {
					if ($endclient['end_client_id'] == $jobdata['end_client_id']) {
						echo "<option value=".$endclient['end_client_id']." selected='selected'>".$endclient['end_client_name']."</option>";
					} else {
						echo "<option value=".$endclient['end_client_id'].">".$endclient['end_client_name']."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div><div class='col'></div></div>";		

		// Client Job No & Job Type
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Client Job No: <input class='form-control' placeholder='Enter Client Job Number' type='text' name='clientjobnumber' value='".$jobdata['client_job_number']."' required = 'true' maxlength='20'/></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Job Type: <select class='form-control' name='jobtypeid' required = 'true'>";
				foreach ($jobtypes as $jobtype) {
					if ($jobtype['job_type_id'] == $jobdata['job_type_id']) {
						echo "<option value=".$jobtype['job_type_id']." selected='selected'>".$jobtype['job_type']."</option>";
					} else {
						echo "<option value=".$jobtype['job_type_id'].">".$jobtype['job_type']."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div></div>";

		
		// Description
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Description: <input class='form-control' placeholder='Enter Job Description' type='text' name='jobdescription' value='".$jobdata['description']."' maxlength='255' /></p>";
		echo "</div></div>";

		//package & status		
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Package: <select class='form-control' name='package'>";
				foreach ($packages as $package) {
					if ($package['package_id'] == $jobdata['package_id']) {
						echo "<option value=".$package['package_id']." selected='selected'>".$package['package_name']."</option>";
					} else {
						echo "<option value=".$package['package_id'].">".$package['package_name']."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Status: <select class='form-control' name='status'>";
				foreach ($statuses as $status) {
					if ($status['status_id'] == $jobdata['job_status']) {
						echo "<option value=".$status['status_id']." selected='selected'>".$status['status_name']."</option>";						
					} else {
						echo "<option value=".$status['status_id'].">".$status['status_name']."</option>";
					}
				}
			echo "</select></p>";
		echo "</div></div>";

		// Date Received & Date Due
		$datereceived = $this->emptyParam($jobdata['date_received'], date('Y-m-d'), substr($jobdata['date_received'], 0, 10));
		echo "<div class='row'><div class='col'>";
			echo "<p>Date Received: <input class='form-control' placeholder='Date Job Received' data-provide='datepicker' data-date-format='yyyy-mm-dd' type='text' name='datereceived' value='".$datereceived."' required = 'true' maxlength='10' /></p>";
		echo "</div><div class='col'>";
			echo "<p>Date Due: <input class='form-control' placeholder='Date Job Due' data-provide='datepicker' data-date-format='yyyy-mm-dd' type='text' name='datedue' value='".substr($jobdata['date_due'], 0, 10)."' required = 'true' maxlength='10' /></p>";		
		echo "</div></div>";		
		
		// Word Count & Currency / Price
		echo "<div class='row'><div class='col'>";
			echo "<p>Word Count: <input class='form-control' placeholder='Enter Word Count' type='text' name='wordcount' value='".$jobdata['word_count']."' maxlength='10' /></p>";		
		echo "</div><div class='col-2'>";
			echo "<p>Price: <select class='form-control' name='currencyid'>";
				foreach ($currencies as $currency) {
					if ($currency['currency_id'] == $jobdata['price_currency_id']) {
						echo "<option value=".$currency['currency_id']." selected='selected'>".$currency['currency_code']."</option>";
					} else {
						echo "<option value=".$currency['currency_id'].">".$currency['currency_code']."</option>";
					}
				} 
			echo "</select> </p>";
		echo "</div><div class='col-4'>";
			echo "<br><input class='form-control' type='text' name='price' value='".number_format((float)$jobdata['price'], 2, '.', '')."' maxlength='10' /></p>";		
		echo "</div></div>";
		
		// Job Profile & Estimated Time
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Job Profile: <select class='form-control' name='jobprofileid'>";
			echo "<option value=''></option>";
				foreach ($jobprofiles as $jobprofile) {
					if ($jobprofile['job_profile_id'] == $jobdata['job_profile_id']) {
						echo "<option value=".$jobprofile['job_profile_id']." selected='selected'>".$jobprofile['job_profile_name']."</option>";
					} else {
						echo "<option value=".$jobprofile['job_profile_id'].">".$jobprofile['job_profile_name']."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Estimated Time: <input class='form-control' placeholder='Enter Estimated Job Time' type='text' name='estimatedtime' value='".$jobdata['estimated_time']."' maxlength= '10' /></p>";
		echo "</div></div>";

		
		// Completed Date and Actual Time
		echo "<div class='row'><div class='col'>";
			echo "<p>Completed Date: <input class='form-control' placeholder='Date Job Completed' data-provide='datepicker' data-date-format='yyyy-mm-dd' type='text' name='completeddate' value='".substr($jobdata['completed_date'], 0, 10)."' maxlength='10' /></p>";
		echo "</div><div class='col'>";
			echo "<p>Actual Time: <input class='form-control' placeholder='Enter Actual Job Time' type='text' name='actualtime' value='".$jobdata['actual_time']."' maxlength= '10' /></p>";
		echo "</div></div>";	

		echo "<div class='row'><div class='col'>";
			echo "<p>Invoice No: <input class='form-control' type='text' name='invoicenumber' value='".$jobdata['invoice_number']."' readonly /></p>";
		echo "</div><div class='col'>";
			echo "<p>Invoice Date: <input class='form-control' type='text' name='invoicedate' value='".$jobdata['invoice_date']."' readonly /></p>";			
		echo "</div></div>";

		//UDFs - Need to be updated so lables reflect what is set in the settings per domain
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>User-Defined 1: <input class='form-control' placeholder='User-defined 1' type='text' name='jobudf1' value='".$jobdata['user_defined_1']."' maxlength='50' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>User-Defined 2: <input class='form-control' placeholder='User-defined 2' type='text' name='jobudf2'  value='".$jobdata['user_defined_2']."'maxlength='50' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>User-Defined 3: <input class='form-control' placeholder='User-defined 3' type='text' name='jobudf3'  value='".$jobdata['user_defined_3']."'maxlength='50' /></p>";
		echo "</div></div></div>";
		echo "<hr>";
		
		// Notes
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Notes: <textarea class='form-control' name='jobnotes' rows='5' cols='30'>".$jobdata['notes']."</textarea></p>";
		echo "</div></div>";
		
		
		// hidden contactid - determine if an update or insert is needed
		echo "<input type='hidden' name='recordid' value='".$jobdata['job_id']."'>";
		
		// submit
		echo "<div class='row'>\n<div class='col-auto mr-auto'>";		
			echo "</br><input class='btn btn-outline-primary' type='submit' value='Save' /> ";
		echo "</div><div class='col-auto'>";
			echo "<br> <input class='btn btn-outline-primary' type='reset' value='Reset' /> ";
			echo " <a class='btn btn-outline-primary' href='../web/joblist.php' role='button'>Cancel</a> ";
			if (!empty($_GET['jobid'])) {
				echo " <a class='btn btn-outline-primary' href='../web/jobdetails.php' role='button'>New</a> ";
			}
		echo "</div></div></div></form>";
	}	

	
}

?>