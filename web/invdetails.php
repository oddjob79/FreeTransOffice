<?php

	require_once('../obj/invoiceform.inc');
	require_once('../obj/basepage.inc');
	
	$invdetailpage = new BasePage();
	$invdetailpage -> Display();
	$invdetailpage -> checkLoggedIn();
	
	$invdetailform = new InvoiceForm();
	
	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		
		if ($_POST['voidinvoice'] == 'void') {
			
			$sql = new Dbconnect();
			$params = array($_SESSION['domain_id'], $_POST['recordid']);
			$out = array();
			$sql->callSP('sp_void_invoice', $out, $params);
			
			$invdetailpage->redirect("invdetails.php?invoiceid=".$_POST['recordid']);
			
		} else {
		
			// get posted values relating to the invoice
			$invdetail = array("dummy_invoicenumber", "dummy_invoicedate", "dummy_clientid", "dummy_invoicetotal", "receivedamount", "invreceiveddate", "dummy_invstatus", "dummy_attachment", "invnotes");
			
			// get the values that were posted on the form
			$postedvalues = $invdetailform->getPostedValues($invdetail, true);
			
		// update invoice logic
			// add invoice_id to $postedvalues array
			array_unshift($postedvalues, $_POST['recordid']);
			$sql = new Dbconnect();
			$out = array();
			$updaterecord = $sql->callSP('sys_invoices_update', $out, $postedvalues);
			$sql = ""; $out = ""; $updaterecord = ""; $postedvalues = "";

			$invdetailpage->redirect("invdetails.php?invoiceid=".$_POST['recordid']);
			$invdetailpage -> endPage();
		}
	} else {
		$invdetailform -> showInvoiceForm();
		$invdetailpage -> endPage();
	}
		
	
?>