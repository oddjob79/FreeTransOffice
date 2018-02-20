<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/endclientform.inc');
	
	// instantiate the base page content and display header and menu items	
	$endclientpage = new BasePage();
	$endclientpage -> Display();
	$endclientpage -> checkLoggedIn();

	// instantiate a new html form
	$endclientform = new EndClientForm();

	if($_SERVER['REQUEST_METHOD'] == 'POST') {
	
		// check to see if the record was a new add or an update
		$recordexists = $endclientform->doesRecordExist();
		
		// set array for client create sp & get the values that were posted on the form
		$newendclient = array("endclientname", "clientid", "industry", "datefirstjob", "datelastjob", "endclientnotes");
		$endclientposted = $endclientform->getPostedValues($newendclient, true);
		
		// if new client - run address add logic and insert client info
		if ($recordexists === false) {

			// instantiate the dbconnect class, set the output variable array, and call the insert sp		
			$sql = new Dbconnect();
			$out = array("@u_end_client_id");
			$newrecord = $sql->callSP('sys_end_clients_create', $out, $endclientposted);
			
			$endclientform->recordCreated($newrecord, 'end_client');
		} else {

		// update client logic
			
			// add client_id to $clientposted array
			array_unshift($endclientposted, $_POST['recordid']);
			$sql = new Dbconnect();
			$out = array();
			$updateendclient = $sql->callSP('sys_end_clients_update', $out, $endclientposted);
			$sql = ""; $out = ""; $updateendclient = ""; $endclientposted = "";

			$endclientpage->redirect("endclientdetails.php?endclientid=".$_POST['recordid']);
			
		}
		$endclientpage -> endPage();

	} else {	
		$endclientform -> showEndClientForm();
		$endclientpage -> endPage();
	}

?>