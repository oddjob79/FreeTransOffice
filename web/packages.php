<?php

	require_once('../obj/packagesform.inc');
	require_once('../obj/basepage.inc');
	
	$packagespage = new BasePage();
	$packagespage -> Display();
	$packagespage -> checkLoggedIn();
	
	$packagesform = new PackagesForm();
	
	if($_SERVER['REQUEST_METHOD'] == 'POST') {

		// check to see if the record was a new add or an update
		$recordexists = $packagesform->doesRecordExist();	

		// get posted values relating to the address
		$packages = array("packagename", "packagenotes");
		
		// get the values that were posted on the form
		$postedvalues = $packagesform->getPostedValues($packages, true);
		
		// if new package - run address add logic and insert package info
		if ($recordexists === false) {
			
			// instantiate the dbconnect class, set the output variable array, and call the insert sp		
			$sql = new Dbconnect();
			$out = array("@u_package_id");
			$newrecord = $sql->callSP('sys_packages_create', $out, $postedvalues);
			
			// check if a new record was created.	
			$packagesform->recordCreated($newrecord, 'package');
			
		} else {

		// update package logic
		
			// add package_id to $postedvalues array
			array_unshift($postedvalues, $_POST['recordid']);
			$sql = new Dbconnect();
			$out = array();
			$updatepackage = $sql->callSP('sys_packages_update', $out, $postedvalues);
			$sql = ""; $out = ""; $updatepackage = ""; $postedvalues = "";

			$packagespage->redirect("packages.php?packageid=".$_POST['recordid']);
			
		}
		$packagespage -> endPage();

	} else {
		$packagesform -> showPackagesForm();
		$packagespage -> endPage();
	}
		
	
?>