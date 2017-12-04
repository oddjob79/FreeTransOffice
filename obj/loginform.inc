<?php

require_once('htmlform.inc');

class LoginForm extends HtmlForm {

	public function loginFormat() {
		echo "<div class='col-1'></div>";
		echo "<div class='col-6'>";
		echo "<div class='p-3 mb-2 bg-light text-dark'>";
	}

	public function showLoginForm() {
		echo "<form method='post' action='login.php'>";
		echo "<div class='form-group'>";
		echo "<p>Username: <input class='form-control' placeholder='Enter Username' type='text' name='username' size='100' maxlength='30' /></p>";
		echo "<p>Password: <input class='form-control' placeholder='Enter Password' type='text' name='password' size='100' maxlength='30' /></p></br>";
		echo "<input class='btn btn-outline-primary' type='submit' value='Login' />";
		?> <button type="button" class="btn btn-outline-primary" onclick="window.location.href='newuser.php'" 
			data-toggle="tooltip" data-placement="bottom" title="Click here to register for TransOffice">New User</button><?php
		echo "</div></form>";
		echo "</div></div>";
	}
}

?>