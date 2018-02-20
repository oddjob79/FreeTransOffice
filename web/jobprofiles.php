<?php

	require_once('../obj/jobprofileform.inc');
	require_once('../obj/basepage.inc');
	
	$jobprofilepage = new BasePage();
	$jobprofilepage -> Display();
	$jobprofilepage -> checkLoggedIn();
	
	$jobprofileform = new JobProfileForm();
	
	// check to see if the record was a new add or an update
	$recordexists = $jobprofileform->doesRecordExist();
	
	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		
		// get posted values relating to the address
		$jobprofile = array("jobprofilename", "jobtypeid", "clientid", "endclientid", "packageid", "wordsperhour", "jobtypemultiplier", "jobprofilenotes");
		
		// get the values that were posted on the form
		$postedvalues = $jobprofileform->getPostedValues($jobprofile, true);
		
		// if new job type - run address add logic and insert job type info
		if ($recordexists === false) {
			
			// instantiate the dbconnect class, set the output variable array, and call the insert sp		
			$sql = new Dbconnect();
			$out = array("@u_job_type_id");
			$newrecord = $sql->callSP('sys_job_profiles_create', $out, $postedvalues);
			
			// check if a new record was created.	
			$jobprofileform->recordCreated($newrecord, 'job_type');
			
		} else {

		// update job type logic
		
			// add job_type_id to $postedvalues array
			array_unshift($postedvalues, $_POST['recordid']);
			$sql = new Dbconnect();
			$out = array();
			$updaterecord = $sql->callSP('sys_job_profiles_update', $out, $postedvalues);
			$sql = ""; $out = ""; $updaterecord = ""; $postedvalues = "";

			$jobprofilepage->redirect("jobprofiles.php?jobprofileid=".$_POST['recordid']);
			
		}
		$jobprofilepage -> endPage();

	} else {
		$jobprofileform -> showJobProfileForm();
		$jobprofilepage -> endPage();
	}
		
	
?>