<?php

require_once('htmlform.inc');

class RptConfigForm extends HtmlForm {
	
	public function showRptConfigForm() {

		// retrieve the report id from the URL and pass to $getvalues
		$getnames = array('reportid');
		$getvalues = $this -> getGetValues($getnames);
	
		// retrieve report details. This will be used to complete the data in the form
		$sql = new Dbconnect();
		if (!empty($getvalues['reportid'])) {
			$reportdata = $sql->getEntityDetails($getvalues, 'sys_report_config_read');
		}

		// form header and format are set
		$this->formFormat('Report Config');

		// retrieve all field names used in report config
		$emptyarr = array();
		$detailfields = $sql->callSP('sp_read_invoice_report_details', $emptyarr, $emptyarr);
		$headerfields = $sql->callSP('sp_read_invoice_report_headers', $emptyarr, $emptyarr);
		
		// set spparam array to pass to the callSP procedure
		$spparams = array("-1");
		$rptformats = $sql->callSP('sys_report_formats_read', $emptyarr, $spparams);
		
		// set array to "select all" -1 and domain_id to retrieve all records for this domain only. This will be used to complete the report drop down / selector
		$domparams = array("-1", $_SESSION['domain_id']);
		$reportlist = $sql->callSP('sys_report_config_read', $emptyarr, $domparams);

		$this -> rptconfFormBuilder($reportdata, $reportlist, $rptformats, $detailfields, $headerfields);
		
	}

	private function rptconfFormBuilder(&$reportdata, &$reportlist, $rptformats, $detailfields, $headerfields) {
	
		echo "<form method='post' action='reportconfig.php'>";
		echo "<div class='form-group'>";	
		
		// list	of available reports
		echo "<div class='row'>\n<div class='col-6 settingsview'>";
		// only shown in view mode
			echo "<p>Report: (required)<select class='form-control settingsselectors' name='reportid'>";
			echo "<option value=''></option>";
				foreach ($reportlist as $report) {
					$getreport = (empty($_GET['reportid'])) ? '' : $_GET['reportid'];
					if ($report['report_id'] == $getreport) {
						echo "<option value=".$report['report_id']." selected='selected'>".$report['report_name']."</option>";
					} else {
						echo "<option value=".$report['report_id'].">".$report['report_name']."</option>";
					}
				} 
			echo "</select></p>";
			echo "<p><input type='hidden' name='settingsdomainid' value='".$reportdata['domain_id']."' /></p>";
		echo "</div>";
		
		// only shown in edit mode - Report Name
		echo "<div class='col-6 settingsedit' style='display: none;'>";		
			echo "<p>Report Name: (required)<input class='form-control' type='text' name='reportname' value='".$reportdata['report_name']."' size='80' required = 'true' maxlength='120' />";
			echo "<small class='form-text text-muted'>Give your report format a name</small></p>";
			echo "<p><input class='form-control' type='hidden' name='recordid' value='".$reportdata['report_id']."' /></p>";
		echo "</div></div>";

		// hidden fields - report type & template (may change in future)
		echo '<input type="hidden" name="reporttypeid" value="1" />'; // report type - defaulted to invoice
		echo '<input type="hidden" name="templateid" value="1" />'; // template - defaulted to defaultinvoice.php
		
		// Report Format & Date Format
		echo "<div class='row'><div class='col'>";
		echo "<p>Report Format: (required)<select class='form-control' name='reportformatid'>";
			foreach ($rptformats as $rptformat) {
					if ($rptformat['report_format_id'] == $reportdata['report_format_id']) {
						echo "<option value=".$rptformat['report_format_id']." selected='selected'>".$rptformat['report_format']."</option>";						
					} else {
						echo "<option value=".$rptformat['report_format_id'].">".$rptformat['report_format']."</option>";
					}
				}
			echo "</select><small class='form-text text-muted'>Select what file format your invoice should be generated in</small></p>";
		echo "</div><div class='col'>";
			echo "<p>Date Format: (required)<select class='form-control' name='dateformat'>";
			echo "<option value=1>DD/MM/YYYY - 31/12/2018</option>";
			echo "<option value=2>MM/DD/YYYY - 12/31/2018</option>";
			echo "<option value=3>DD Month YYYY - 31 December 2018</option>";
			echo "</select><small class='form-text text-muted'>Select what format your dates should appear on the invoice</small>";
		echo "</div></div>";
		
		// Greeting text
		echo "<div class='row'><div class='col'>";
			echo "<p>Greeting text: <input class='form-control' placeholder='Enter a greeting message' type='text' name='greetingtext' value='".$reportdata['greeting_text']."' maxlength='120' />";
			echo "<small class='form-text text-muted'>E.g. Dear Sir / Madam,</small></p>";		
		echo "</div></div>";
		
		// Opening text
		$this->insertTextBox("Opening text", "E.g. Please see below an invoice for all completed work within the last 30 days.", $reportdata);
		
		// Invoice number label
		echo "<div class='row'><div class='col'>";
			echo "<p>Invoice number label: <input class='form-control' placeholder='Enter Invoice Number label' type='text' name='invnumlabel' value='".$reportdata['invoice_number_label']."' maxlength='30' />";
			echo "<small class='form-text text-muted'>E.g. Invoice number or Rechnungsnummer</small></p>";
		echo "</div><div class='col'>";		
			echo "<p>Invoice total label: <input class='form-control' placeholder='Enter Invoice Total label' type='text' name='invtotallabel' value='".$reportdata['invoice_total_label']."' maxlength='30' />";
			echo "<small class='form-text text-muted'>E.g. Invoice total or Rechnungsbetrag</small></p>";				
		echo "</div></div>";
		
		// Columns containing job information
		echo "<hr><h5>Job Information</h5>";
		echo "<p><small class='form-text text-muted'>Select Job information to be included in the invoice. Add column headers in the label boxes. Select the information to appear in the columns from the drop downs.</small></p>";

		$this->columnSelectFields("a", $reportdata, $detailfields);
		$this->columnSelectFields("b", $reportdata, $detailfields);
		$this->columnSelectFields("c", $reportdata, $detailfields);
		$this->columnSelectFields("d", $reportdata, $detailfields);
		$this->columnSelectFields("e", $reportdata, $detailfields);
		$this->columnSelectFields("f", $reportdata, $detailfields);
		$this->columnSelectFields("g", $reportdata, $detailfields);
		$this->columnSelectFields("h", $reportdata, $detailfields);
		
		// sections A & B
		echo "<hr><h5>Additional Information</h5>";
		echo "<p><small class='form-text text-muted'>Add any additional information you would like to appear on the invoice. These can be included in sections with section headers. E.g. Employee Information</small></p>";
		
		echo "<div class='row'><div class='col-6'>";
			echo "<p>Section A label: <input class='form-control' placeholder='Enter Section A label' type='text' name='sectionalabel' value='".$reportdata['section_a_label']."' maxlength='30' />";
		echo "</div></div>";
		
		$this->sectionSelectFields("a", 1, $reportdata, $headerfields);
		$this->sectionSelectFields("a", 2, $reportdata, $headerfields);
		$this->sectionSelectFields("a", 3, $reportdata, $headerfields);
		
		echo "<br><div class='row'><div class='col-6'>";
			echo "<p>Section B label: <input class='form-control' placeholder='Enter Section B label' type='text' name='sectionblabel' value='".$reportdata['section_b_label']."' maxlength='30' />";
		echo "</div></div>";

		$this->sectionSelectFields("b", 1, $reportdata, $headerfields);
		$this->sectionSelectFields("b", 2, $reportdata, $headerfields);
		$this->sectionSelectFields("b", 3, $reportdata, $headerfields);		


		// Closing Text
		$this->insertTextBox("Closing text", "E.g. Best Regards, Your Name, Your Email", $reportdata);

		
		// New / Edit buttons - only shown when in 'view' mode
		echo "<div class='row'>\n<div class='col-auto mr-auto settingsview'>";
			echo "<input class='btn btn-outline-primary' type='button' value='New' name='newsettingsbtn' /> ";
			echo " <input class='btn btn-outline-primary' type='button' value='Edit' name='editsettingsbtn' />";
		echo "</div></div>";
		
		// save / reset / cancel buttons - only shown when in edit mode	
		echo "<div class='row settingsedit' style='display: none;'>\n<div class='col-auto mr-auto'>";		
			echo "</br><input class='btn btn-outline-primary' type='submit' value='Save' /> ";
		echo "</div><div class='col-auto settingsedit'>";
			echo "<br> <input class='btn btn-outline-primary' type='reset' value='Reset' /> ";
			echo " <a class='btn btn-outline-primary' href='../web/reportconfig.php?reportid=".$reportdata['report_id']."' role='button'>Cancel</a> ";
		echo "</div></div></div></form>";
	}	

	private function columnSelectFields($col, $reportdata, $detailfields) {
		$column_array = array(
			"fieldheader" => "Column ".strtoupper($col)." label: ",
			"placeholder" => "Enter Column ".strtoupper($col)." label",
			"labelname" => "col".$col."label",
			"labelelement" => "col_".$col."_label",
			"fieldname" => "col".$col."field",
			"fieldelement" => "col_".$col."_field"
			);
		$this->selectBuilder($column_array, $reportdata, $detailfields);
	}

	private function sectionSelectFields($sec, $field, $reportdata, $headerfields) {
		$section_array = array(
			"fieldheader" => "Section ".strtoupper($sec)." field ".$field." label: ",
			"placeholder" => "Enter Section ".strtoupper($sec)." field ".$field." label",
			"labelname" => "sec".$sec."fldlab".$field,
			"labelelement" => "section_".$sec."_field_label_".$field,
			"fieldname" => "sec".$sec."fld".$field,
			"fieldelement" => "section_".$sec."_field_".$field
			);
		$this->selectBuilder($section_array, $reportdata, $headerfields);
	}
	
	private function selectBuilder($labelarray, $reportdata, $fieldlist) {
		extract($labelarray, EXTR_OVERWRITE);
		
		echo "<div class='row'><div class='col'>";
			echo "<p>".$fieldheader."<input class='form-control' placeholder='".$placeholder."' type='text' name='".$labelname."' value='".$reportdata[$labelelement]."' maxlength='30' />";
		echo "</div><div class='col'>";
			echo "<br><select class='form-control' name='".$fieldname."'>";
			echo "<option value=''></option>";
			foreach ($fieldlist as $fieldname) {
				if ($fieldname['column_name'] == $reportdata[$fieldelement]) {
					echo "<option value=".$fieldname['column_name']." selected='selected'>".$fieldname['column_name']."</option>";
				} else {
					echo "<option value=".$fieldname['column_name'].">".$fieldname['column_name']."</option>";
				}
			}
			echo "</select></p>";
		echo "</div></div>";
	}
	
	private function insertTextBox($label, $helptext, $reportdata) {
		$sqlname = strtolower(str_replace(" ", "_", $label));
		$postname = strtolower(str_replace(" ", "", $label));
		$textboxdisplay = (empty($reportdata[$sqlname])) ? 'Enter '.strtolower($label) : $reportdata[$sqlname];
		
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>".$label.": <textarea class='form-control' name='".$postname."' rows='5' cols='30'>".$textboxdisplay."</textarea>";
			echo "<small class='form-text text-muted'>".$helptext."</small></p>";
		echo "</div></div>";			
	}
	
}

?>