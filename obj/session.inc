<?php

class Session {
	
	public function setSessionVars($user_id, $domain_id) {
		if (!(isset($_SESSION))) {
			session_start();
		}
		
		$_SESSION['user_id'] = $user_id;
		$_SESSION['domain_id'] = $domain_id;
		
	}
	
	public function getSessionVars() {
		if (!(isset($_SESSION))) {
			session_start();
		}
		
		if (isset($_SESSION['user_id'])) {
			$sessvar['user_id'] = $_SESSION['user_id'];
			$sessvar['domain_id'] = $_SESSION['domain_id'];
			return $sessvar;
		}
	}
	
}

?>