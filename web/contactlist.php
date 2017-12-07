<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/tables.inc');
	
	// instantiate the base page content and display header and menu items
	$contactlistpage = new BasePage();
	$contactlistpage -> Display();
	$contactlistpage -> checkLoggedIn();
	
	$contacttable = new Tables();
	
	$sql = new Dbconnect();
	$params = array("-1", $_SESSION['domain_id']);
	$out = array();
	$contactlist = $sql->callSP('sp_contact_details', $out, $params);
	
	// set arrays to store all table headers and field names from database
	$theaders = array('First Name', 'Last Name', 'Client', 'Email', 'Phone', 'Status', 'Primary Contact');
	$fieldnames = array('contact_id','first_name', 'last_name', 'client_name', 'email', 'phone', 'status_name', 'primary_contact' );	
	
	// set the format to Y or N for all fields in the $yornfields array
	$yornfields = array('primary_contact');
	$contacttable->setIntToYorN($contactlist, $yornfields);
		
	// send the headers, field names, data, url for redirects and the entity name to the entityList method for processing
	$contacttable->entityList($theaders, $fieldnames, $contactlist, '../web/contactdetails.php', 'Contact');
	
	$contactlistpage -> endPage();
	
?>
	
