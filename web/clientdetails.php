<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/clientform.inc');
	
	// instantiate the base page content and display header and menu items	
	$clientpage = new BasePage();
	$clientpage -> Display();
	$clientpage -> checkLoggedIn();

	// instantiate a new html form
	$clientform = new ClientForm();

	if($_SERVER['REQUEST_METHOD'] == 'POST') {
	
		// check to see if the record was a new add or an update
		$recordexists = $clientform->doesRecordExist();
		
		// get posted values relating to the address
		$addrposted = $clientform->getAddressPostedInfo();

		// set array for client create sp & get the values that were posted on the form
		$newclient = array("clientname", "othername", "address_id", "package", "status", "lastjob", "currency", "timezone", "invoiceto", 
		"invtoemail", "clientinvnotes", "invoicereport", "invoiceby", "invoicepaid", "lastinv", "clientnotes", "clientudf1", "clientudf2", "clientudf3");
		$clientposted = $clientform->getPostedValues($newclient, true);
		
		// if new client - run address add logic and insert client info
		if ($recordexists === false) {
			// insert address info (if exists)
			$newaddress_id = $clientform->insertAddress($addrposted);

			// add the newly added address_id to the clientposted array
			$clientposted['address_id'] = $newaddress_id;
			
			// instantiate the dbconnect class, set the output variable array, and call the insert sp		
			$sql = new Dbconnect();
			$out = array("@u_client_id");
			$newrecord = $sql->callInsertSp('sys_clients_create', $out, $clientposted);
			
			// check if a new record was created.		
			if (!empty($newrecord)) {
				$clientpage->redirect("../web/clientdetails.php?clientid=".$clientposted[0]);
				echo "Client ".$clientposted[1]." created successfully";
				// add redirect to clientdetails with clientid
			} else {
				echo "There was a problem creating the Client.<br><br>";
				print_r($sql->errorInfo());
			}
			$sql = ""; $out = ""; $newrecord = ""; $clientposted = "";
			
		} else {

		// update client logic
			
			// update address logic (if there is an address associated with the client)
			if (!empty($_POST['addressid'])) {

				array_unshift($addrposted, $_POST['addressid']);
				$clientform->updateAddress($addrposted);
			} else {
				// insert address if a new one has been added
				$newaddress_id = $clientform->insertAddress($addrposted);
				
				// add the newly added address_id to the clientposted array
				$clientposted['address_id'] = $newaddress_id;				
			}
		
			// add client_id to $clientposted array
			array_unshift($clientposted, $_POST['recordid']);
			$sql = new Dbconnect();
			$out = array();
			$updateclient = $sql->callSP('sys_clients_update', $out, $clientposted);
			$sql = ""; $out = ""; $updateclient = ""; $clientposted = "";

			$clientpage->redirect("../web/clientdetails.php?clientid=".$_POST['recordid']);
			
		}
		
		
		

		
		


		
		// use new (or existing) address_id to add client record
		


// debugging
//		echo "params - ". implode(',<br>', $clientposted)."<br>";


		
		// add showClientForm method
		$clientpage -> endPage();

	} else {	

	$clientform -> showClientForm();
	$clientpage -> endPage();
	
	}

?>