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

		// checks to see if address already exists. Inserts if new address, or returns addressid if exists. If partial match, address is updated and addressid is returned
		$postedvalues['addressid'] = $useraddress->addressInsertUpdate($addrposted);
		
		// add user_id to the $postedvalues array
		array_unshift($postedvalues, $_SESSION['user_id'], $_SESSION['domain_id']);
		$sql = new Dbconnect();
		$out = array();
		$updateuser = $sql->callSP('sys_users_update', $out, $postedvalues);
		
		$usersetpage->redirect("usersettings.php");
		
	} else {
		// if no posted information available
		$usersetform->showUserSetForm();
	}
	
?>