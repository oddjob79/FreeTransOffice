<?php

	require_once('../database/dbconnect.inc');
	require_once('../obj/loginform.inc');
	require_once('../obj/basepage.inc');

	// instantiate the base page content and display header and menu items
	$loginpage = new BasePage();
	$loginpage -> Display();
	
	// instantiate a new html form
	$loginform = new LoginForm();
	
	// check to see if a login has already been attempted
	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		
		// build array of names on form
		$inputnames = array();
		array_push($inputnames, "username", "password");
		
		// get the values that were posted on the form
		$postedvalues = $loginform->getPostedValues($inputnames, false);

		// instantiate a new Dbconnect object & call read SP to gather user & domain ids to pass to session
		$uvsql = new DbConnect();
		$uvparams = array($postedvalues['username']);
		$out = array();
		$uservars = $uvsql->callSP('sp_validateUser', $out, $uvparams);

		// gather only first row from array passed back from SP results (should only ever be one row)
		$loginvars = $uvsql->returnFirstRow($uservars);
		$user_id = $loginvars['user_id'];
		$domain_id = $loginvars['domain_id'];
		$passwordhash = $loginvars['password_hash'];
		
		// if login successful, load the joblist page, if not present the login form again with message asking to log in again or reset password
		if (password_verify($postedvalues['password'], $passwordhash)) {
			// set session variables
			$session = new Session();
			$session->setSessionVars($user_id, $domain_id);
			
			//redirect to joblist page - additional js added if headers have already been loaded
			$loginpage->redirect('../web/joblist.php');
//			header( "Location: joblist.php" ); die;
			
			
		} else {
			$loginform->loginformat();
			echo "<h3><b>Invalid Login</b>. Please <a href='resetpassword.php'>click</a> to reset password</h3>";
			$loginform->showLoginForm();
		}
		
	// if not, present the login page as new
	} else {
		
		if (isset($sessvars['user_id'])) { 
			session_destroy();
		}
		
	
		// page content goes here
		$loginform->loginformat();
		echo "<h3>Login to TransOffice</h3>";
		$loginform->showLoginForm();
		
		// close out page with ending html tags
		$loginpage->endPage();
		
	}	
	

?>