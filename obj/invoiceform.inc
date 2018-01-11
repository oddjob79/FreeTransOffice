<?php

require_once('htmlform.inc');

class InvoiceForm extends HtmlForm {

	// hand in last invoice number, use to set next available invoice number
	public function findNextInvNum($lastinv) {
		if (date("Ym") == substr($lastinv, 0, 6)) {
			return ($lastinv+1);
		} else {
			return date("Ym").'0001';
		}		
	}
	
	// sets invconfirmcancel from posted value
	private function setInvConfirmCancel() {
		return $invconfirmcancel = (empty($_POST['invconfirmcancel']) ? '' : $_POST['invconfirmcancel']);
	}
	
	private function confirmInvoice($postedvalues) {
		$sql = new Dbconnect();
		$out = array("@u_invoice_id");
		$newrecord = $sql->callSP('sp_submit_invoice', $out, $postedvalues);
		
		// check if a new record was created.	
		$this->recordCreated($newrecord, 'invoice');
	}

	private function cancelInvoice($postedvalues) {
		$sql = new Dbconnect();
		$out = array();
		array_splice($postedvalues, 2);
		$sql->callSP('sp_delete_tempinvoice', $out, $postedvalues);
	}

	public function submitInvoice() {
		$invconfirmcancel = $this->setInvConfirmCancel();
		$submitinvfields = array("tempinvoiceid", "newinvoicenum");
		$postedvals = $this->getPostedValues($submitinvfields, true);

		if ($invconfirmcancel == 'confirm') {
			$this->confirmInvoice($postedvals);
		} elseif ($invconfirmcancel == 'cancel') {
			$this->cancelInvoice($postedvals);
			return 'cancelled';
		}
	}
	
	public function showInvoiceForm() {
		
		// retrieve the invoice id from the URL and pass to $getvalues
		$getnames = array('invoiceid');
		$getvalues = $this -> getGetValues($getnames);
		
		// use contact id to retrieve all the contact details
		$sql = new Dbconnect();

		if (!empty($getvalues['invoiceid'])) {
			$entityid = array($getvalues['invoiceid'], "-1");
			$invdata = $sql->getEntityDetails($entityid, 'sp_invoice_details');
			$displaydata = $invdata['client_name'] . ' - ' . $invdata['invoice_number'];			
		} else {
			$displaydata = null;
		}
		
		// form header and format are set
		$formheader = $this->setFormHeader('Invoice', $displaydata);
		$this->formFormat($formheader);
	
		$this -> invoiceFormBuilder($invdata);
	}

	private function invoiceFormBuilder(&$invdata) {
	
		echo "<form method='post' action='invdetails.php'>";
		echo "<div class='form-group'>";
		
		// Invoice Number & Invoice Date
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Invoice Number: <input class='form-control' type='text' name='invoicenumber' value='".$invdata['invoice_number']."' readonly /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Invoice Date: <input class='form-control' type='text' name='invoicedate' value='".substr($invdata['invoice_date'], 0, 10)."' readonly /></p>";
		echo "</div></div>";

		
		// Client Name
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Client: <input class='form-control' type='text' name='clientname' value='".$invdata['client_name']."' readonly /></p>";
		echo "</div></div>";

		//Invoice Total & Received Amount		
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Invoice Total: <input class='form-control' type='text' name='invoicetotal' value='".substr($invdata['invoice_total'], 0, -4)."' readonly /></p> ";
		echo "</div><div class='col'>";
			echo "<br><input class='form-control' type='text' name='clientcurr' value='".$invdata['client_currency']."' size='5' readonly />";
		echo "</div><div class='col'>";
			echo "<p>Received Amount: <input class='form-control' type='number' name='receivedamount' value='".substr($invdata['received_amount'], 0, -4)."' /></p>";
		echo "</div><div class='col'>";
			echo "<br><input class='form-control' type='text' name='usercurr' value='".$invdata['user_currency']."' size='5' readonly />";
		echo "</div></div>";

		// Date Received
		echo "<div class='row'>\n<div class='col-6'>";
			echo "<p>Received Date: <input class='form-control' placeholder='Date Payment Received' data-provide='datepicker' data-date-format='yyyy-mm-dd' type='text' name='invreceiveddate' value='".substr($invdata['received_date'], 0, 10)."' maxlength='10' /></p>";
		echo "</div></div>";
		
		// Status & attachment (not implemented yet)
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Status: <input class='form-control' type='text' name='invstatus' value='".$invdata['status_name']."' readonly /></p>";
		echo "</div><div class='col'>";
			echo "<p>Attachment: <input class='form-control' type='file' name='attachment' readonly='readonly' value='".$invdata['document_path']."' height='10' width='10' /></p>";
		echo "</div></div>";		
		
		// Notes
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Notes: <textarea class='form-control' name='invnotes' rows='5' cols='30'>".$invdata['notes']."</textarea></p>";
		echo "</div></div>";
		
		// hidden invoiceid - determine if an update or insert is needed
		echo "<input type='hidden' name='recordid' value='".$invdata['invoice_id']."'>";
		
		// submit
		echo "<div class='row'>\n<div class='col-auto mr-auto'>";		
			echo "</br><input class='btn btn-outline-primary' type='submit' value='Save' /> ";
		echo "</div><div class='col-auto'>";
			echo "<br> <input class='btn btn-outline-primary' type='reset' value='Reset' /> ";
			echo " <a class='btn btn-outline-primary' href='../web/invoicelist.php' role='button'>Cancel</a> ";
		echo "</div></div></div></form>";
	}	


	
}

?>