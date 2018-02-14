<?php

	require_once('../obj/basepage.inc');
	
	// instantiate the base page content and display header and menu items
	$logoutpage = new BasePage();
	$logoutpage -> Display();

	session_unset();
	session_destroy();
	
	if (empty($_SESSION['user_id'])) {
		echo "You have been successfully logged out. <br>";
	} else { echo "Something went wrong during logout. Please try again."; }

?>