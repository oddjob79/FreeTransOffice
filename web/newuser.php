<?php

	require_once('../obj/userform.inc');
	require_once('../obj/basepage.inc');
	
	$newuserpage = new BasePage();
	$newuserpage -> Display();
	
	$newuserform = new UserForm();
	
	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		
		$newuser = array("firstname", "lastname", "username", "password", "email", "secquestion", "secanswer");
		
		// get the values that were posted on the form
		$postedvalues = $newuserform->getPostedValues($newuser, false);
		$postedvalues['password'] = password_hash($postedvalues['password'], PASSWORD_BCRYPT);
//		$postedvalues['secquestion'] = (int)$postedvalues['secquestion'];
		$postedvalues['secanswer'] = password_hash($postedvalues['secanswer'], PASSWORD_BCRYPT);
		
		$nusql = new Dbconnect();
		$outuser = array("@u_user_id");
		$addnewuser = $nusql->callSP('sp_create_user', $outuser, $postedvalues);
		
		if (!empty($addnewuser)) {
			echo "<br>User " . $postedvalues[2] . " created successfully. Please click the <a href='../web/login.php'>link</a> to login to the system.";
		} else {
			echo "There was a problem creating the user. Please contact support@kennettechservices.com for assistance.";
		}
		
	} else {
		// if no posted information available
		$newuserform->newUserForm();
	}
	
?>