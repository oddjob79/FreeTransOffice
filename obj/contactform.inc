<?php

require_once('htmlform.inc');

class ContactForm extends HtmlForm {
	
	public function showContactForm() {

		// retrieve the contact id from the URL and pass to $getvalues
		$getnames = array('contactid', 'clientid');
		$getvalues = $this -> getGetValues($getnames);
		// get rid of empty key / value pairs (e.g. clientid or contactid)
		$getvalues = array_filter($getvalues);
		
		// if we have a contact id then we load the data from the contact record, if we have a client id, use the client id to load the client data only
		$sql = new Dbconnect();
		if (!empty($getvalues['contactid'])) {
			// add -1 "null" value to pass to the sp for client_id (contact does not have to have a client)
			array_push($getvalues, "-1");
			$contactdata = $sql->getEntityDetails($getvalues, 'sp_contact_details');
			$displaydata = $contactdata['first_name'] . ' ' . $contactdata['last_name'];
		} else if (!empty($getvalues['clientid'])) {
			$clientdata = $sql->getEntityDetails($getvalues, 'sp_client_details');
			$displaydata = $clientdata['client_name'] . ' - ';
		} else {
			$displaydata = null;
		}

		// form header and format are set
		$formheader = $this -> setFormHeader('Contact', $displaydata);
		$this->formFormat($formheader);

		
		// set spparam array to pass to the callSP procedure
		$spparams = array("-1");
		$out = array();
		$statuses = $sql->callSP('sys_statuses_read', $out, $spparams);
		$sortorder = array(1,2,3);
		$statuses = $this->statusSort($statuses, $sortorder);		
		
		$languages = $sql->callSP('sys_languages_read', $out, $spparams);
		
		// set array to "select all" -1 and domain_id to retrieve all records for this domain only
		$domparams = array($_SESSION['domain_id']);
		$clients = $sql->callSP('sp_client_list', $out, $domparams);
		
		$this -> contactFormBuilder(
			$contactdata,
			$statuses,
			$languages,
			$clients,
			$clientdata
		);
	}

	private function contactFormBuilder(&$contactdata, &$statuses, &$languages, &$clients, &$clientdata) {
	
		echo "<form method='post' action='contactdetails.php'>";
		echo "<div class='form-group'>";
		
		$clientid = $this->emptyParam($clientdata['client_id'], $contactdata['client_id'], $clientdata['client_id']);
		// Client select
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Client Name: <select class='form-control' name='clientid'>";
			echo "<option value=''></option>";
				foreach ($clients as $client) {
//					if ($client['client_id'] == $contactdata['client_id']) {
					if ($client['client_id'] == $clientid) {
						echo "<option value=".$client['client_id']." selected='selected'>".$client['client_name']."</option>";
					} else {
						echo "<option value=".$client['client_id'].">".$client['client_name']."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div>";
			echo "<div class='col'><br><label class='form-check-label'>";
			echo "<input type='hidden' name='primarycontact' value='0' />";			
			if ($contactdata['primary_contact'] == 1) {
				echo "<input class='form-check-input' type='checkbox' name='primarycontact' value='1' checked='checked'>Primary Contact?</label>";
			} else {
				echo "<input class='form-check-input' type='checkbox' name='primarycontact' value='1'>Primary Contact?</label>";
			}
		echo "</div></div>";

		// First & Last Names
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>First Name: (required)<input class='form-control' placeholder='Enter First Name' type='text' name='first_name' value='".$contactdata['first_name']."' required = 'true' maxlength='50' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Last Name: (required)<input class='form-control' placeholder='Enter Last Name' type='text' name='last_name' value='".$contactdata['last_name']."' required = 'true' maxlength='80' /></p>";
		echo "</div></div>";
		echo "<hr>";

		// Email & Phone
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Email: <input class='form-control' placeholder='Enter Email' type='text' name='email' value='".$contactdata['email']."' maxlength='120' /></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Phone: <input class='form-control' placeholder='Enter Phone No.' type='text' name='phone' value='".$contactdata['phone']."' maxlength='20' /></p>";
		echo "</div></div>";
		echo "<hr>";

		// Position
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Position: <input class='form-control' placeholder='Enter Position Held' type='text' name='position_held' value='".$contactdata['position_held']."' maxlength='80' /></p>";
		echo "</div></div>";

		// Language & status		
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Language: <select class='form-control' name='language'>";
			echo "<option value=''></option>";
				foreach ($languages as $language) {
					if ($language['language_id'] == $contactdata['language_id']) {
						echo "<option value=".$language['language_id']." selected='selected'>".$language['language_name']."</option>";
					} else {
						echo "<option value=".$language['language_id'].">".$language['language_name']."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div>";
		echo "<div class='col'>";
			echo "<p>Status: (required)<select class='form-control' name='status'>";
				// limit so we only see Active, Inactive & Dormant
				foreach ($statuses as $status) {
					if ($status['status_id'] == $contactdata['contact_status']) {
						echo "<option value=".$status['status_id']." selected='selected'>".$status['status_name']."</option>";						
					} else {
						echo "<option value=".$status['status_id'].">".$status['status_name']."</option>";
					}
				}
			echo "</select></p>";
		echo "</div></div>";

		// Notes
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Notes: <textarea class='form-control' name='contactnotes' rows='5' cols='30'>".$contactdata['notes']."</textarea></p>";
		echo "</div></div>";
		
		
		// hidden contactid - determine if an update or insert is needed
		echo "<input type='hidden' name='recordid' value='".$contactdata['contact_id']."'>";
		// hidden clientid - determine if update or insert is needed for client_contacts table
		echo "<input type='hidden' name='origclientid' value='".$contactdata['client_id']."'>";
		
		// submit
		echo "<div class='row'>\n<div class='col-auto mr-auto'>";		
			echo "</br><input class='btn btn-outline-primary' type='submit' value='Save' /> ";
		echo "</div><div class='col-auto'>";
			echo "<br> <input class='btn btn-outline-primary' type='reset' value='Reset' /> ";
			echo " <a class='btn btn-outline-primary' href='contactlist.php' role='button'>Cancel</a> ";
			if (!empty($_GET['contactid'])) {
				echo " <a class='btn btn-outline-primary' href='contactdetails.php' role='button'>New</a> ";
			}
		echo "</div></div></div></form>";
	}	

		public function contactRecordCreated(&$newrecord, $entity, &$clientcontactposted) {
		if (!empty($newrecord)) {
			$sql = new Dbconnect();
			$basepage = new BasePage();
			// retrieve the newly created contact id
			$newrecrow = $sql->returnFirstRow($newrecord);
		// set entity string to lower case and set the $outparam for use in redirect and sql results retrieval
			$entity = strtolower($entity);
			$outparam = "u_".$entity."_id";
		// add the newly created contact id to the $clientcontactposted array
			array_unshift($clientcontactposted, $newrecrow[$outparam]);
		// insert the clientcontact record
			$clcnout = array();
//			print_r($clientcontactposted); echo "<br>";
			$sql->callSP('sys_client_contacts_create', $clcnout, $clientcontactposted);
		// finally redirect to saved record
			$basepage->redirect("".$entity."details.php?".$entity."id=".$newrecrow[$outparam]);
//				echo "Contact ".$contactposted[1]." created successfully"; // need to change this so this displays in an "infobar" at top of newly loaded page
		} else {
			echo "There was a problem creating the record.<br><br>";
		}
//		$sql = ""; $out = ""; $newrecord = ""; $jobposted = "";		
	}
	
}

?>