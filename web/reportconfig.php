<?php

	require_once('../obj/reportconfform.inc');
	require_once('../obj/basepage.inc');
	
	$rptconfpage = new BasePage();
	$rptconfpage -> Display();
	$rptconfpage -> checkLoggedIn();
	
	$rptconfform = new RptConfigForm();
	
	if($_SERVER['REQUEST_METHOD'] == 'POST') {

		// check to see if the record was a new add or an update
		$recordexists = $rptconfform->doesRecordExist();	

		
		// get all posted values from form
		$reportfields = array("reportname", "reporttypeid", "reportformatid", "templateid", "dateformat", "greetingtext", "openingtext", "invnumlabel", 
		"colalabel", "colafield", "colblabel", "colbfield", "colclabel", "colcfield", "coldlabel", "coldfield", "colelabel", "colefield", "colflabel", "colffield", "colglabel", "colgfield",
		"colhlabel", "colhfield", "invtotallabel", "sectionalabel", "secafldlab1", "secafld1", "secafldlab2", "secafld2", "secafldlab3", "secafld3", "sectionblabel", "secbfldlab1", "secbfld1", "secbfldlab2", "secbfld2",
		"secbfldlab3", "secbfld3", "closingtext");
		
		// get the values that were posted on the form
		$postedvalues = $rptconfform->getPostedValues($reportfields, true);
		
		// if new report - insert report info
		if ($recordexists === false) {
			
			// instantiate the dbconnect class, set the output variable array, and call the insert sp		
			$sql = new Dbconnect();
			$out = array("@u_report_id");
			$newrecord = $sql->callSP('sys_report_config_create', $out, $postedvalues);
			
			// check if a new record was created.	
			$rptconfform->recordCreated($newrecord, 'report');
			
		} else {

		// update report logic
		
			// add package_id to $postedvalues array
			array_unshift($postedvalues, $_POST['recordid']);
			$sql = new Dbconnect();
			$out = array();
			$updatereport = $sql->callSP('sys_report_config_update', $out, $postedvalues);
			$sql = ""; $out = ""; $updatereport = ""; $postedvalues = "";

			$rptconfpage->redirect("reportconfig.php?reportid=".$_POST['recordid']);
			
		}
		$rptconfpage -> endPage();

	} else {
		$rptconfform -> showRptConfigForm();
		$rptconfpage -> endPage();
	}
		
	
?>