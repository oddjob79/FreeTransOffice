<?php

	require_once('../obj/htmlform.inc');
	
	$basepage = new BasePage();
	$basepage->display();
	$newuserform = new HtmlForm();
	echo "<div class='newuser'>";	
	
	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		
		$newuser = array("firstname", "lastname", "username", "password", "email", "secquestion", "secanswer");
		
		// get the values that were posted on the form
		$postedvalues = $newuserform->getPostedValues($newuser);
		$postedvalues['password'] = password_hash($postedvalues['password'], PASSWORD_BCRYPT);
		$postedvalues['secquestion'] = (int)$postedvalues['secquestion'];
		$postedvalues['secanswer'] = password_hash($postedvalues['secanswer'], PASSWORD_BCRYPT);
		
		$nusql = new Dbconnect();
		$outuser = array("@u_user_id");
		$addnewuser = $nusql->callInsertSp('sp_create_user', $outuser, $postedvalues);
		
		if (!empty($addnewuser)) {
			$uservar = $nusql->returnFirstRow($addnewuser);
			echo "User " . $uservar['user_name'] . " created successfully!";
		} else {
			echo "There was a problem somewhere";
		}
		
	} else {
		// if no posted information available
		$newuserform->newUserForm();
	}
	echo "</div>";	
?>