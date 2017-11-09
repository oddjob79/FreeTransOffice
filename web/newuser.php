<?php

	require_once('../obj/htmlform.inc');
	
	$basepage = new BasePage();
	$basepage->display();
	$newuserform = new HtmlForm();
	echo "<div class='newuser'>";	
	
	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		echo "1</br>";
		
		$inputnames = array();
		array_push($inputnames, "firstname", "lastname", "username", "password", "email", "secquestion", "secanswer");
		
		// get the values that were posted on the form
		$postedvalues = $newuserform->getPostedValues($inputnames);
		$postedvalues['password'] = password_hash($postedvalues['password'], PASSWORD_BCRYPT);
		$postedvalues['secquestion'] = (int)$postedvalues['secquestion'];
		$postedvalues['secanswer'] = password_hash($postedvalues['secanswer'], PASSWORD_BCRYPT);
		print_r($postedvalues);
		echo '</br></br>';
		
		$sql = new Dbconnect();
		$addnewuser = $sql->prepareSP('sp_create_user', $postedvalues);
		
	} else {
		// if no posted information available
		$newuserform->newUserForm();
	}
	echo "</div>";	
?>