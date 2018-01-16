<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/tables.inc');
	
	// instantiate the base page content and display header and menu items
	$clientinvlistpage = new BasePage();
	$clientinvlistpage -> Display();
	$clientinvlistpage -> checkLoggedIn();
	
	$clientinvtable = new Tables();
	
	$entitydetailsurl = '../web/invdetails.php';
	$entityname = 'Invoice';
	$entityfilter = 'client';
	$clientid = $clientinvtable->getsetClientId();
	
	// retrieve all job data for this domain (-1)
	$params = array("-1", $clientid, $_SESSION['domain_id']);
	$out = array();
	$sql = new Dbconnect();
	$entitylist = $sql->callSP('sp_invoice_details', $out, $params);
	
	// set arrays to store all table headers and field names from database
	$theaders = array('Invoice Num', 'Invoice Date', 'Invoice Amount', 'Received Amount', 'Received Date', 'Status');
	$fieldnames = array('invoice_id','invoice_number', 'invoice_date', 'invoice_total', 'received_amount', 'received_date', 'status_name' );	
	
	// set the date format for all fields included in the $datefields array
	$datefields = array('invoice_date', 'received_date');
	$clientinvtable->updateDateFormat($entitylist, $datefields);

	// send the headers, field names, data, url for redirects and the entity name to the entityList method for processing
	$clientinvtable->entityList($theaders, $fieldnames, $entitylist, $entitydetailsurl, $entityname, $entityfilter);
	
	$clientinvlistpage->endPage();
	
?>