<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/contactform.inc');
	
	// instantiate the base page content and display header and menu items	
	$contactpage = new BasePage();
	$contactpage -> Display();
	$contactpage -> checkLoggedIn();

	// instantiate a new html form
	$contactform = new ContactForm();
	
	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		
		// check to see if the record was a new add or an update
		$recordexists = $contactform->doesRecordExist();
		
		// set array for contact create sp & get the values that were posted on the form
		$newcontact = array("first_name", "last_name", "email", "phone", "language", "position_held", "status", "contactnotes");
		$contactposted = $contactform->getPostedValues($newcontact, true);
		
		// set array for client_contact create sp & get the values that were posted on the form
		$newclientcontact = array("clientid", "primarycontact");
		$clientcontactposted = $contactform->getPostedValues($newclientcontact, false);
		
		// if new contact - add contact record then client_contact record
		if ($recordexists === false) {
			
			// instantiate the dbconnect class, set the output variable array, and call the insert sp		
			$sql = new Dbconnect();
			$out = array("@u_contact_id");
			$newrecord = $sql->callSP('sys_contacts_create', $out, $contactposted);
			
			// check if a new record was created. Redirect to details page with the id included		
			if (!empty($newrecord)) {
				// retrieve the newly created contact id
				$newrecrow = $sql->returnFirstRow($newrecord);
				// add the newly created contact id to the $clientcontactposted array
				array_unshift($clientcontactposted, $newrecrow['u_contact_id']);
				// insert the clientcontact record
				$clcnout = array();
				$sql->callSP('sys_client_contacts_create', $clcnout, $clientcontactposted);
				// redirect to the newly created record
				$contactpage->redirect("../web/contactdetails.php?contactid=".$newrecrow['u_contact_id']);
//				echo "Contact ".$contactposted[1]." created successfully"; // need to change this so this displays in an "infobar" at top of newly loaded page
			} else {
				echo "There was a problem creating the record.<br><br>";
			}
			$sql = ""; $out = ""; $newrecord = ""; $contactposted = ""; $clcnout = "";
		}
		
		
		// if existing record, update contact details, then either update or delete client_contact record
		
	} else {
		$contactform->showContactForm();
		$contactpage->endPage();
	}
		
// next - complete insert / update logic and add logic to add client_contact record
// also... test!!!!