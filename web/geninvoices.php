<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/tables.inc');
	
	// instantiate the base page content and display header and menu items
	$geninvoicepage = new BasePage();
	$geninvoicepage -> Display();
	$geninvoicepage -> checkLoggedIn();
	
	// Generate Invoices button clicked - show confirm invoice page (invoice has not been confirmed or canceled
	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		
		require_once('../obj/invoiceform.inc');
		$invform = new InvoiceForm();
		$tempinvoice = new Tables();		

		$jobidstr = implode(',', $_POST['invjob']);
		
// build the temporary invoice and return array of invoice details 		
		$tempinvparams = array($_SESSION['domain_id'], $_SESSION['client_id'], $jobidstr);
		$out = array();
		$sql = new Dbconnect();
		$result = $sql->callSP('sp_create_temp_invoices', $out, $tempinvparams);
		
		$joblines = array();
		foreach ($result as $invlines) {
			if ($invlines['linetype'] == 'header') {
				$invheader = array_slice($invlines, 1, 5);
			} else if ($invlines['linetype'] == 'job') {
				array_push($joblines, array_slice($invlines, 6));
			}
		}

		// find next invoice number		
		$lastinv = (empty($invheader['invoice_number']) ? '' : $invheader['invoice_number']);
		$invheader['invoice_number'] = $invform->findNextInvNum($lastinv);
		
		
		// set the date format for all fields included in the $datefields array
		$datefields = array('date_received', 'completed_date');
		$tempinvoice->updateDateFormat($joblines, $datefields);
		
		$theaders = array('Date Received', 'Job Number', 'Client Job No.', 'Job Description', 'End Client', 'Job Type', 'Word Count', 'Price', 'Completed Date');
		$tempinvoice->confirmInvoiceTable($invheader, $theaders, $joblines);

	// initial generate invoice page - show list of jobs. Also shown when invoice has been canceled
	} elseif ($_SERVER['REQUEST_METHOD'] != 'POST') {	
	
		$geninvoicetable = new Tables();
		
		$entitydetailsurl = '../web/jobdetails.php';
		$entityname = 'Job';
		$entityfilter = 'invoice';
		$clientid = $geninvoicetable->getsetClientId();
		
		// retrieve all job data for this domain (-1)
		$params = array("-1", $clientid, $_SESSION['domain_id']);
		$out = array();
		$sql = new Dbconnect();
		$entitylist = $sql->callSP('sp_job_details', $out, $params);
		
		// set arrays to store all table headers and field names from database
		$theaders = array('Date Received', 'Client Job No.', 'Job Description', 'End Client', 'Job Type', 'Word Count', 'Price', 'Due Date', 'Status', 'Completed Date');
		$fieldnames = array('job_id','date_received', 'client_job_number', 'description', 'end_client_name', 'job_type', 'word_count', 'price', 'date_due', 'status_name', 'completed_date' );	
		
		// set the date format for all fields included in the $datefields array
		$datefields = array('date_received', 'date_due', 'completed_date');
		$geninvoicetable->updateDateFormat($entitylist, $datefields);
		
		// set the price format for all fields in the $pricefields array
		$pricefields = array('price');
		$geninvoicetable->formatPrice($entitylist, $pricefields);

		// send the headers, field names, data, url for redirects and the entity name to the entityList method for processing
		$geninvoicetable->entityList($theaders, $fieldnames, $entitylist, $entitydetailsurl, $entityname, $entityfilter);
		
		$geninvoicepage->endPage();
	}
?>