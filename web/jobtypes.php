<?php

	require_once('../obj/jobtypeform.inc');
	require_once('../obj/basepage.inc');
	
	$jobtypepage = new BasePage();
	$jobtypepage -> Display();
	$jobtypepage -> checkLoggedIn();
	
	$jobtypeform = new JobTypeForm();
	
	// check to see if the record was a new add or an update
	$recordexists = $jobtypeform->doesRecordExist();
	
	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		
		// get posted values relating to the address
		$jobtype = array("jobtypename", "wordsperhour", "jobtypenotes");
		
		// get the values that were posted on the form
		$postedvalues = $jobtypeform->getPostedValues($jobtype, true);
		
		// if new job type - run address add logic and insert job type info
		if ($recordexists === false) {
			
			// instantiate the dbconnect class, set the output variable array, and call the insert sp		
			$sql = new Dbconnect();
			$out = array("@u_job_type_id");
			$newrecord = $sql->callSP('sys_job_types_create', $out, $postedvalues);
			
			// check if a new record was created.	
			$jobtypeform->recordCreated($newrecord, 'job_type');
			
		} else {

		// update job type logic
		
			// add job_type_id to $postedvalues array
			array_unshift($postedvalues, $_POST['recordid']);
			$sql = new Dbconnect();
			$out = array();
			$updaterecord = $sql->callSP('sys_job_types_update', $out, $postedvalues);
			$sql = ""; $out = ""; $updaterecord = ""; $postedvalues = "";

			$jobtypepage->redirect("jobtypes.php?jobtypeid=".$_POST['recordid']);
			
		}
		$jobtypepage -> endPage();

	} else {
		$jobtypeform -> showJobTypeForm();
		$jobtypepage -> endPage();
	}
		
	
?>