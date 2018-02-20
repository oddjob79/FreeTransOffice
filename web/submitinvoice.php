<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/invoiceform.inc');
	
	// instantiate the base page content and display header and menu items
	$geninvoicepage = new BasePage();
	$geninvoicepage -> Display();
	$geninvoicepage -> checkLoggedIn();
	
	$submitinvoice = new InvoiceForm();
	// $submitted = either 'cancelled' or new invoice number
	$submitted = $submitinvoice->submitInvoice();
	
	if ($submitted == 'cancelled') {
		$geninvoicepage->redirect('geninvoices.php');
	} else {
		// Invoice confirmed
		$submitinvoice -> buildPrintModal('printinvmodal', 'Printing Invoice', 'Please validate invoice output and proceed to Invoice Details', 'invdetailsbutton', $submitted);
		// echo modal box to show report is being generated. Javascript will redirect to invoicedetails screen when button in modal is clicked
		echo "<script type='text/javascript'>$('#printinvmodal').modal('show');</script>";
		// load the report page
 		$geninvoicepage->redirect('../reports/invoicereport.php?invoiceid='.$submitted);		
		

	}
	
	
	
?>