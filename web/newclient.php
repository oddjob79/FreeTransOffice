<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/clientform.inc');
	
	// instantiate the base page content and display header and menu items	
	$newclientpage = new BasePage();
	$newclientpage -> Display($header);
	$newclientpage -> checkLoggedIn();
	
	// instantiate a new html form
	$newclientform = new ClientForm();	
	
	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		
// add new address (will need to add logic to check if it exists already)
		
		// set array for address create sp
		$newaddress = array("address1", "address2", "city", "state", "postcode", "region", "county", "country");
		// get the values that were posted on the form
		$postedvalues = $newclientform->getPostedValues($newaddress);
		// insert domain_id at the beginning of the array
		array_unshift($postedvalues, $domainid);
		
		// instantiate the dbconnect class and call the insert sp
		$sql = new Dbconnect();
		$out = array("@u_address_id");
		$newrecord = $sql->callInsertSp('sys_addresses_create', $out, $postedvalues);
		
		// check if a new record was created. If so, add the newly created ID to a variable for use in the new client creation
		if (!empty($newrecord)) {
			$addressrow = $sql->returnFirstRow($newrecord);
			$newaddress_id = $addressrow['u_address_id'];
		} else {
			echo "There was an address add problem.<br>";
		}
		// cleanup query variables
		$sql=""; $out=""; $newrecord=""; $postedvalues="";

		
		// use new (or existing) address_id to add client record
		
		// set array for client create sp
		$newclient = array("clientname", "othername", "address_id", "package", "status", "lastjob", "currency", "timezone", "invoiceto", 
		"invtoemail", "clientinvnotes", "invoicereport", "invoiceby", "invoicepaid", "lastinv", "clientnotes", "clientudf1", "clientudf2", "clientudf3");

		// get the values that were posted on the form
		$postedvalues = $newclientform->getPostedValues($newclient);
		// insert domain_id at the beginning of the array
		array_unshift($postedvalues, $domainid);
		// add new address_id - additional logic needed
		$postedvalues['address_id'] = $newaddress_id;

// debugging
//		echo "params - ". implode(',<br>', $postedvalues)."<br>";

		// instantiate the dbconnect class and call the insert sp		
		$sql = new Dbconnect();
		$out = array("@u_client_id");
		$newrecord = $sql->callInsertSp('sys_clients_create', $out, $postedvalues);
		
		// check if a new record was created.		
		if (!empty($newrecord)) {
			echo "Client ".$postedvalues[1]." created successfully";
		} else {
			echo "There was a problem somewhere";
		}
		$sql = ""; $out = ""; $newrecord = ""; $postedvalues = "";
		
		$newclientpage -> endPage();

		
	} else {
		// if no posted information available
		$formheader = 'New Client';
		$newclientform->formFormat($formheader);
		$newclientform->newClientForm();
		$newclientpage -> endPage();
	}
	
?>