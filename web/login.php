<?php

	require_once('../database/dbconnect.inc');
	require_once('../obj/htmlform.inc');
	
	// loads menu items and css	
	$loginpage = new BasePage();
	// displays menu	
	$loginpage->display();

	echo "<div class='login'>";
	// instantiate a new html form
	$loginform = new htmlform();
	
	// check to see if a login has already been attempted
	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		
		// build array of names on form
		$inputnames = array();
		array_push($inputnames, "username", "password");
		
		// get the values that were posted on the form
		$postedvalues = $loginform->getPostedValues($inputnames);

		// instantiate a new Dbconnect object & call read SP to gather user & domain ids to pass to session
		$uvsql = new DbConnect();
		$uvparams = array($postedvalues['username'], $postedvalues['password']);
		$uservars = $uvsql->callReadSp('sp_validateUser', $uvparams);
		
		// gather only first row from array passed back from SP results (should only ever be one row)
		$loginvars = $uvsql->returnFirstRow($uservars);
		$user_id = $loginvars['user_id'];
		$domain_id = $loginvars['domain_id'];
		
		// if login successful, load the joblist page, if not present the login form again with message asking to log in again or reset password
		if (!empty($uservars)) {
			// set session variables
			$session = new Session();
			$session->setSessionVars($user_id, $domain_id);
			
			//redirect to joblist page
			header( "Location: joblist.php" ); die;
		} else {
			echo "<h3 class='invalidlogin'>Invalid Login. Please <a href='resetpassword.php'>click</a> to reset password</h3>";
			$loginform->loginForm();
		}
		
	// if not, present the login page as new
	} else {
		
		session_destroy();
		
		echo "<h3>Login to TransOffice</h3>";
		$loginform->loginForm();
	}	
	

?>