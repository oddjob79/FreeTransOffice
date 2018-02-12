<?php

	require_once('../obj/usersetform.inc');
	require_once('../obj/basepage.inc');
	require_once('../obj/addressdata.inc');
	
	$usersetpage = new BasePage();
	$usersetpage -> Display();
	$usersetpage -> checkLoggedIn();
	
	$usersetform = new UserSetForm();
	$useraddress = new AddressData();
	
	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		
		// get posted values relating to the address
		$addrposted = $useraddress->getAddressPostedInfo();
		$userset = array("firstname", "lastname", "phonenumber", "addressid", "companyname", "currency", "timezone", "logo", "jobnum_prefix", "jobnum_next", "invnum_prefix", "invnum_next", "userudf1", "userudf2", "userudf3");
		
		// get the values that were posted on the form
		$postedvalues = $usersetform->getPostedValues($userset, false);

		// should all be moved to addressdata class
		// update address logic (if there is an address associated with the user)
		if (!empty($_POST['addressid'])) {
			array_unshift($addrposted, $_POST['addressid']);
			$useraddress->updateAddress($addrposted);
		} else {
			// insert address if a new one has been added
			$newaddress_id = $useraddress->insertAddress($addrposted);
			
			// add the newly added address_id to the postedvalues array
			$postedvalues['address_id'] = $newaddress_id;
	
		}
		
		// add user_id to the $postedvalues array
		array_unshift($postedvalues, $_SESSION['user_id'], $_SESSION['domain_id']);
		$sql = new Dbconnect();
		$out = array();
		$updateuser = $sql->callSP('sys_users_update', $out, $postedvalues);
		
//		$usersetpage->redirect("../web/usersettings.php");
		
	} else {
		// if no posted information available
		$usersetform->showUserSetForm();
	}
	
?>