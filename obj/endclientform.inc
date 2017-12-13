<?php

require_once('htmlform.inc');

class EndClientForm extends HtmlForm {
	
	public function showEndClientForm() {
		
		// retrieve the end_client_id from the URL and pass to $getvalues
		$getnames = array('endclientid', 'clientid');
		$getvalues = $this -> getGetValues($getnames);
		
		// if we have an end client id then we load the data from the end client record, if we have a client id, use the client id to load the client data only
		$sql = new Dbconnect();
		if (!empty($getvalues['endclientid'])) {
			// use end_client_id to retrieve all the end client details
			$endclientdata = $sql->getEntityDetails($getvalues, 'sp_end_client_details');
		} else if (!empty($getvalues['clientid'])) {
		// get rid of empty key / value pairs
			$getvalues = array_filter($getvalues);
			$clientdata = $sql->getEntityDetails($getvalues, 'sp_client_details');
		}
			
		// form header and format are set
		$displaydata = (empty($endclientdata['end_client_id'])) ? '' : $endclientdata['client_name'] . ' - ' . $endclientdata['end_client_name'];
		$formheader = $this -> setFormHeader('End Client', $displaydata);
		$this->formFormat($formheader);
		
		// set spparam array to pass to the callSP procedure
		$spparams = array("-1");
		$out = array();
		$industries = $sql->callSP('sys_industries_read', $out, $spparams);
		
		$this -> endclientFormBuilder(
			$endclientdata,
			$clientdata,
			$industries
		);
	}

	private function endclientFormBuilder(&$endclientdata, &$clientdata, &$industries) {
	
		echo "<form method='post' action='endclientdetails.php'>";
		echo "<div class='form-group'>";
		
		// Client name
		$clientname = $this->emptyParam($clientdata['client_name'], $endclientdata['client_name'], $clientdata['client_name']);
		$clientid = $this->emptyParam($clientdata['client_id'], $endclientdata['client_id'], $clientdata['client_id']);
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Client Name: <input class='form-control' type='text' name='clientname' value='".$clientname."' readonly /></p>";
			// hidden clientid
			echo "<input type='hidden' name='clientid' value='".$clientid."'>";			
		echo "</div></div>";
		

		// End Client Name
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>End Client Name: <input class='form-control' placeholder='Enter End Client Name' type='text' name='endclientname' value='".$endclientdata['end_client_name']."' required = 'true' maxlength='120' /></p>";
		echo "</div></div>";

		// Industry		
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Industry: <select class='form-control' name='industry'>";
				foreach ($industries as $industry) {
					if ($industry['industry_id'] == $endclientdata['industry_id']) {
						echo "<option value=".$industry['industry_id']." selected='selected'>".$industry['industry_name']."</option>";
					} else {
						echo "<option value=".$industry['industry_id'].">".$industry['industry_name']."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div></div>";

		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Date First Job: <input class='form-control' placeholder='Date First Job' data-provide='datepicker' data-date-format='yyyy-mm-dd' type='text' name='datefirstjob' value='".substr($endclientdata['date_first_job'], 0, 10)."' maxlength='10' /></p>";
		echo "</div><div class='col'>";
			echo "<p>Date Last Job: <input class='form-control' placeholder='Date Last Job' data-provide='datepicker' data-date-format='yyyy-mm-dd' type='text' name='datelastjob' value='".substr($endclientdata['date_last_job'], 0, 10)."' maxlength='10' /></p>";		
		echo "</div></div>";		
		
		
		// Notes
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Notes: <textarea class='form-control' name='endclientnotes' rows='5' cols='30'>".$endclientdata['notes']."</textarea></p>";
		echo "</div></div>";
		
		// hidden end_client_id - determine if an update or insert is needed
		echo "<input type='hidden' name='recordid' value='".$endclientdata['end_client_id']."'>";
		
		// submit
		echo "<div class='row'>\n<div class='col-auto mr-auto'>";		
			echo "</br><input class='btn btn-outline-primary' type='submit' value='Save' /> ";
		echo "</div><div class='col-auto'>";
			echo "<br> <input class='btn btn-outline-primary' type='reset' value='Reset' /> ";
			echo " <a class='btn btn-outline-primary' href='../web/cl_endclients.php' role='button'>Cancel</a> ";
			if (!empty($_GET['end_client_id'])) {
				echo " <a class='btn btn-outline-primary' href='../web/endclientdetails.php' role='button'>New</a> ";
			}
		echo "</div></div></div></form>";
	}	

	
}

?>