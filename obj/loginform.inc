<?php

require_once('htmlform.inc');

class LoginForm extends HtmlForm {

	public function loginFormat() {
//		echo "<div class='col-1'></div>";
		echo "<div class='container'>";
//		echo "<div class='col-6'>";
		echo "<div class='p-3 mb-2 bg-light text-dark'>";
	}
	
	public function showLoginForm() {
		echo "<form method='post' action='login.php'>";
		echo "<div class='form-group'>";
		echo "<p>Username: <input class='form-control' placeholder='Enter Username' type='text' name='username' size='50' maxlength='30' /></p>";
		echo "<p>Password: <input class='form-control' placeholder='Enter Password' type='password' name='password' size='50' maxlength='30' /></p>";
		echo "<small class='form-text text-muted'>By logging into this site, you are agreeing to our terms of use, as specified <a href='#' data-toggle='modal' data-target='#tandcmodal'>here</a></small></br>";
		$modalhead = '<b>Terms and Conditions</b>';
		$this->buildAlertModal('tandcmodal', $modalhead, $this->getTandC());
		
		echo "<input class='btn btn-outline-primary' type='submit' value='Login' />";
		echo "  <a class='btn btn-outline-primary' href='../web/newuser.php' role='button' data-toggle='tooltip' data-placement='bottom' title='Click here to register for TransOffice'>New User</a>";
		
		echo "</div></form>";
		echo "</div></div>";
	}
}

?>