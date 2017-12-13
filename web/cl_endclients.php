<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/tables.inc');
	
	// instantiate the base page content and display header and menu items
	$endclientlistpage = new BasePage();
	$endclientlistpage -> Display();
	$endclientlistpage -> checkLoggedIn();
	
	$endclienttable = new Tables();
//	$endclienttable->clientList();
	
	$entitydetailsurl = '../web/endclientdetails.php';
	$entityname = 'End Client';
	$entityfilter = 'client';
	$clientid = (empty($_GET['clientid'])) ? "-1" : $_GET['clientid'];
	
	$params = array('-1', $clientid, $_SESSION['domain_id']);
	$out = array();
	$sql = new Dbconnect();
	$entitylist = $sql->callSP('sp_end_client_details', $out, $params);
	
	// set arrays to store all table headers and field names from database (include entity id in fieldnames for use in url to entity record)
	$theaders = array('End Client Name', 'Industry', 'First Job', 'Last Job');
	$fieldnames = array('end_client_id','end_client_name', 'industry_name', 'date_first_job', 'date_last_job');	
	
	// set the date format for all fields included in the $datefields array
	$datefields = array('date_first_job', 'date_last_job');
	$endclienttable->updateDateFormat($entitylist, $datefields);
	
	// send the headers, field names, data, url for redirects and the entity name to the entityList method for processing
	$endclienttable->entityList($theaders, $fieldnames, $entitylist, $entitydetailsurl, $entityname, $entityfilter);
	
	$endclientlistpage -> endPage();
?>
	
