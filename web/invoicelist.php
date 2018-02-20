<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/tables.inc');
	
	// instantiate the base page content and display header and menu items
	$invlistpage = new BasePage();
	$invlistpage -> Display();
	$invlistpage -> checkLoggedIn();
	
	$invtable = new Tables();
	
	$entitydetailsurl = 'invdetails.php';
	$entityname = 'Invoice';
	
	// retrieve all job data for this domain (-1)
	$params = array("-1", "-1", $_SESSION['domain_id']);
	$out = array();
	$sql = new Dbconnect();
	$entitylist = $sql->callSP('sp_invoice_details', $out, $params);
	
	// set arrays to store all table headers and field names from database
	$theaders = array('Invoice Num', 'Invoice Date', 'Client Name', 'Invoice Amount', 'Received Amount', 'Received Date', 'Status');
	$fieldnames = array('invoice_id','invoice_number', 'invoice_date', 'client_name', 'invoice_total', 'received_amount', 'received_date', 'status_name' );	
	
	// set the date format for all fields included in the $datefields array
	$datefields = array('invoice_date', 'received_date');
	$invtable->updateDateFormat($entitylist, $datefields);
	
	// send the headers, field names, data, url for redirects and the entity name to the entityList method for processing
	$invtable->entityList($theaders, $fieldnames, $entitylist, $entitydetailsurl, $entityname);
	
	$invlistpage->endPage();
	
?>