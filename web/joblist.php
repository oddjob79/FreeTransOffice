<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/tables.inc');
	
	// instantiate the base page content and display header and menu items
	$joblistpage = new BasePage();
	$joblistpage -> Display();
	$joblistpage -> checkLoggedIn();
	
	$jobtable = new Tables();
	
	$entitydetailsurl = '../web/jobdetails.php';
	$entityname = 'Job';
	
	// retrieve all job data for this domain (-1)
	$params = array("-1", "-1", $_SESSION['domain_id']);
	$out = array();
	$sql = new Dbconnect();
	$entitylist = $sql->callSP('sp_job_details', $out, $params);
	
	// set arrays to store all table headers and field names from database
	$theaders = array('Date Received', 'Client Job No.', 'Client Name', 'Job Description', 'End Client', 'Job Type', 'Word Count', 'Price', 'Due Date', 'Status', 'Invoice No.');
	$fieldnames = array('job_id','date_received', 'client_job_number', 'client_name', 'description', 'end_client_name', 'job_type', 'word_count', 'price', 'date_due', 'status_name', 'invoice_number' );	
	
	// set the date format for all fields included in the $datefields array
	$datefields = array('date_received', 'date_due');
	$jobtable->updateDateFormat($entitylist, $datefields);
	
	// set the price format for all fields in the $pricefields array
	$pricefields = array('price');
	$jobtable->formatPrice($entitylist, $pricefields);

	// send the headers, field names, data, url for redirects and the entity name to the entityList method for processing
	$jobtable->entityList($theaders, $fieldnames, $entitylist, $entitydetailsurl, $entityname);
	
	$joblistpage->endPage();
	
?>