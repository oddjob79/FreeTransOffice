<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/clientform.inc');
	require_once('../obj/addressdata.inc');
	
	// instantiate the base page content and display header and menu items	
	$clientpage = new BasePage();
	$clientpage -> Display();
	$clientpage -> checkLoggedIn();

	// instantiate a new html form
	$clientform = new ClientForm();
	$addressdata = new AddressData();

	if($_SERVER['REQUEST_METHOD'] == 'POST') {
	
		// check to see if the record was a new add or an update
		$recordexists = $clientform->doesRecordExist();
		
		// get posted values relating to the address
		$addrposted = $addressdata->getAddressPostedInfo();

		// set array for client create sp & get the values that were posted on the form
		$newclient = array("clientname", "othername", "addressid", "package", "vendorcode", "status", "lastjob", "currency", "timezone", "invoiceto", 
		"invtoemail", "clientinvnotes", "invoicereport", "invoiceby", "invoicepaid", "lastinv", "clientnotes", "clientudf1", "clientudf2", "clientudf3");
		$clientposted = $clientform->getPostedValues($newclient, true);
		
		// if new client - run address add logic and insert client info
		if ($recordexists === false) {
			// checks to see if address already exists. Inserts if new address, or returns addressid if exists. If partial match, address is updated and addressid is returned
			$clientposted['addressid'] = $addressdata->addressInsertUpdate($addrposted);
			
			// instantiate the dbconnect class, set the output variable array, and call the insert sp		
			$sql = new Dbconnect();
			$out = array("@u_client_id");
			$newrecord = $sql->callSP('sys_clients_create', $out, $clientposted);
			
			// check if a new record was created.	
			$clientform->recordCreated($newrecord, 'client');
			
		} else {

		// update client logic

			// checks to see if address already exists. Inserts if new address, or returns addressid if exists. If partial match, address is updated and addressid is returned
			$clientposted['addressid'] = $addressdata->addressInsertUpdate($addrposted);
		
			// add client_id to $clientposted array
			array_unshift($clientposted, $_POST['recordid']);
			$sql = new Dbconnect();
			$out = array();
			$updateclient = $sql->callSP('sys_clients_update', $out, $clientposted);
			$sql = ""; $out = ""; $updateclient = ""; $clientposted = "";

			$clientpage->redirect("../web/clientdetails.php?clientid=".$_POST['recordid']);
			
		}
		$clientpage -> endPage();

	} else {	
		$clientform -> showClientForm();
		$clientpage -> endPage();
	}

?>