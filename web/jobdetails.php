<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/jobform.inc');
	
	// instantiate the base page content and display header and menu items	
	$jobpage = new BasePage();
	$jobpage -> Display();
	$jobpage -> checkLoggedIn();

	// instantiate a new html form
	$jobform = new jobForm();

	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		
		// check to see if the record was a new add or an update
		$recordexists = $jobform->doesRecordExist();		
		
		// set array for contact create sp & get the values that were posted on the form
		$newjob = array("jobnumber", "clientid", "endclientid", "clientjobnumber", "jobtypeid", "jobdescription", "package", 
		"datereceived", "datedue", "wordcount", "currencyid", "price", "jobprofileid", "estimatedtime", "actualtime", "status", 
		"completeddate", "invoiceid", "jobnotes", "jobudf1", "jobudf2", "jobudf3");
		$jobposted = $jobform->getPostedValues($newjob, true);		

		// if new contact - add job
		if ($recordexists === false) {
			
			// instantiate the dbconnect class, set the output variable array, and call the insert sp		
			$sql = new Dbconnect();
			$out = array("@u_job_id");
			$newrecord = $sql->callSP('sys_jobs_create', $out, $jobposted);	
			
			// check if a new record was created. Redirect to details page with the id included		
			if (!empty($newrecord)) {
				// retrieve the newly created contact id
				$newrecrow = $sql->returnFirstRow($newrecord);
				// redirect to the newly created record
				$jobpage->redirect("../web/jobdetails.php?jobid=".$newrecrow['u_job_id']);
//				echo "Contact ".$contactposted[1]." created successfully"; // need to change this so this displays in an "infobar" at top of newly loaded page
			} else {
				echo "There was a problem creating the record.<br><br>";
			}
			$sql = ""; $out = ""; $newrecord = ""; $jobposted = "";
		} else {
			// *UPDATE* - add hidden posted job_id to the array of posted values
			array_unshift($jobposted, $_POST['recordid']);
			
			$sql = new Dbconnect();
			$out = array();
			$sql->callSP('sys_jobs_update', $out, $jobposted);
		
			$jobpage -> endPage();
			$jobpage->redirect("../web/jobdetails.php?jobid=".$_POST['recordid']);		
		}
	} else {	
		$jobform -> showJobForm();
		$jobpage -> endPage();
	}
	
?>