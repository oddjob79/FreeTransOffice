<?php

include('basepage.inc');

class HtmlForm extends BasePage {
	
	public $postedname;
	public $postedvals; 
	
	public function loginForm() {
		echo "<form method='post' action='login.php'>";
		echo "<p>Username: <input type='text' name='username' size='100' maxlength='30' /></p>";
		echo "<p>Password: <input type='text' name='password' size='100' maxlength='30' /></p></br>";
		echo "</br><input type='submit' value='Login' />";
		echo "</form>";
		?>
		<input type="button" value="New User" onclick="window.location.href='newuser.php'">
		<?php
	}
	
	public function newUserForm() {
		
		$sqsql = new Dbconnect();
		$spparams = [];
		$spparams = array("-1");
		$securityqs = $sqsql->callReadSp('sys_securityquestions_read', $spparams);
		
		echo "<form method='post' action='newuser.php'>";
		echo "<p>First Name: <input type='text' name='firstname' size='80' maxlength='50' /></p>";
		echo "<p>Last Name: <input type='text' name='lastname' size='80' maxlength='80' /></p>";
		echo "<p>Username: <input type='text' name='username' size='30' maxlength='30' /></p>";
		echo "<p>Password: <input type='text' name='password' size='30' maxlength='30' />";
		echo " Confirm Password: <input type='text' name='confirmpw' size='30' maxlength='30' /></p>";
		echo "<p>Email Address: <input type='text' name='email' size='120' maxlength='120' /></p>";
		echo "<p>Security Question: <select name='secquestion'>";
		foreach ($securityqs as $secquestion) {
			echo "<option value=".$secquestion['security_question_id'].">".$secquestion['security_question']."</option>";
		} 
		echo "</select></p>";
		echo "<p>Security Answer: <input type='text' name='secanswer' size='120' maxlength='120' /></p>";
		echo "</br><input type='submit' value='Save' />";
		echo "</form>";
	}	
	
	public function getPostedValues(&$inputnames) {
		$postedvals = array();
		foreach ($inputnames as $postedname) {
			if (isset($_POST[$postedname])){
				$postedvals[$postedname] = $_POST[$postedname];
			}
		}
		return($postedvals);
	}
	
	
	
}

?>