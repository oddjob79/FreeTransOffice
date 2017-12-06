<?php

	require_once('../obj/basepage.inc');
	//require_once('../database/dbconnect.inc');
	require_once('../obj/tables.inc');
	
	// instantiate the base page content and display header and menu items
	$clientlistpage = new BasePage();
	$clientlistpage -> Display();
	$clientlistpage -> checkLoggedIn();
	
	$clienttable = new Tables();
	
	$sql = new Dbconnect();
	$params = array($_SESSION['domain_id']);
	$clientlist = $sql->callReadSp('sp_client_list', $params);
	
	// set arrays to store all table headers and field names from database
	$theaders = array('Client Names', 'City', 'Country', 'Currency', 'Status', 'Last Completed Job', 'Last Invoice');
	$fieldnames = array('client_id','client_name', 'city', 'country_name', 'currency_code', 'status_name', 'last_completed_job', 'last_invoice');	
	
	// set the date format for all fields included in the $datefields array
	$datefields = array('last_completed_job', 'last_invoice');
	$clienttable->updateDateFormat($clientlist, $datefields);
	
	// send the headers, field names, data, url for redirects and the entity name to the entityList method for processing
	$clienttable->entityList($theaders, $fieldnames, $clientlist, '../web/clientdetails.php', 'Client');
	
	$clientlistpage -> endPage();
?>
	
