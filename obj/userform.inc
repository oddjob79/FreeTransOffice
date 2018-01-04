<?php

require_once('htmlform.inc');

class UserForm extends HtmlForm {
	
	public function newUserForm() {
		
		$this->formFormat('New User');
		
		$sqsql = new Dbconnect();
		$spparams = array("-1");
		$out = array();
		$securityqs = $sqsql->callSP('sys_securityquestions_read', $out, $spparams);
		
		echo "<form method='post' action='newuser.php'>";
		echo "<div class='form-group'>";
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>First Name: <input class='form-control' placeholder='Enter your first name' type='text' name='firstname' size='80' required = 'true' maxlength='50' /></p>";
		echo "</div><div class='col'>";
			echo "<p>Last Name: <input class='form-control' placeholder='Enter your last name' type='text' name='lastname' size='80' required = 'true' maxlength='80' /></p>";
		echo "</div></div><div class='row'>\n<div class='col'>";
			echo "<p>Email Address: <input class='form-control' placeholder='Enter your email address' type='email' name='email' size='120' required = 'true' maxlength='120' /></p>";
		echo "</div><div class='col'>";
			echo "<p>Username: <input class='form-control' placeholder='Enter your new username' type='text' name='username' size='30' required = 'true' maxlength='30' /></p>";
		echo "</div></div><div class='row'>\n<div class='col'>";
			echo "<p>Password: <input class='form-control' placeholder='Enter a secure password' type='text' name='password' size='30' required = 'true' maxlength='30' />";
		echo "</div><div class='col'>";
			echo " Confirm Password: <input class='form-control' placeholder='Confirm your password' type='text' name='confirmpw' size='30' required = 'true' maxlength='30' /></p>";
		echo "</div></div><div class='row'>\n<div class='col'>";
			echo "<p>Security Question: <select class='form-control' name='secquestion' required = 'true'>";
				foreach ($securityqs as $secquestion) {
					echo "<option value=".$secquestion['security_question_id'].">".$secquestion['security_question']."</option>";
				} 
			echo "</select></p>";
		echo "</div></div><div class='row'>\n<div class='col'>";			
			echo "<p>Security Answer: <input class='form-control' placeholder='Enter your answer' type='text' name='secanswer' size='120' required = 'true' maxlength='120' /></p>";
		echo "</div></div><div class='row'>\n<div class='col'>";		
			echo "</br><input class='btn btn-outline-primary' type='submit' value='Save' />";
		echo "</div></div></div></form>";
	}	
	
}

?>