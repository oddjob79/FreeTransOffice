<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/invoiceform.inc');
	
	// instantiate the base page content and display header and menu items
	$geninvoicepage = new BasePage();
	$geninvoicepage -> Display();
	$geninvoicepage -> checkLoggedIn();
	
	$submitinvoice = new InvoiceForm();
	$cancelled = $submitinvoice->submitInvoice();
	
	if ($cancelled == 'cancelled') {
		$geninvoicepage->redirect('../web/geninvoices.php');
	}
	
	
	
?>