<?php

require_once('../database/dbconnect.inc');
require_once('../obj/session.inc');

$sql = new Dbconnect();

// instatiate new Session object & add user_id & domain_id to $sessvars array
$session = new Session();
$sessvars = $session->getSessionVars();

// retrieve invoice_id from url
$invoiceid = $_GET['invoiceid'];

// set parameters
$params = array($invoiceid, $_SESSION['domain_id']);
$out = array();

// retrieve invoice header data
$result = $sql->callSP('sp_rpt_invoice_header', $out, $params);
// get first row
$invheader = $sql->returnFirstRow($result);

// retrieve invoice details data
$invdetails = $sql->callSP('sp_rpt_invoice_details', $out, $params);

// call report
$reporttemplate = $invheader['template_path'];

require_once($reporttemplate);
$report = new DefInvoice();
$filepath = $report->defaultInvoice($invheader, $invdetails);

$filepath = '../reports/'.$filepath;
echo "filepath is ".$filepath."<br>";

$docinsparams = array($_SESSION['domain_id'], $filepath, $invoiceid);
$out = array('@u_document_id');
$result = $sql->callSP('sp_add_invoice_attachment', $out, $docinsparams);
$newdocumentid = $sql->returnFirstRow($result);

print_r($documentid);


?>