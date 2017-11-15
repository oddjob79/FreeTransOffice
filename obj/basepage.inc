<?php
	
	require_once('../database/dbconnect.inc');
	require_once('../obj/session.inc');
	
	class BasePage {
		
		protected $version = "1.0";
		protected $title = 'TransOffice';
		protected $keywords = 'TransOffice - Invoicing and Project Management Tool for Freelance Translation Professionals';		
		
		protected $mainmenuitems = array('Contacts' 	=>	'../web/contacts.php',
									'Clients'	=>	'../web/clients.php',
									'Jobs'		=>	'../web/jobs.php',
									'Invoices'	=>	'../web/invoices.php',
									'Settings'	=>	'../web/settings.php'
								);
		
		protected $clientsubitems = array('End Clients' =>	'../web/cl_endclients.php',
									'Contacts'	=>	'../web/cl_contacts.php',
									'Jobs'		=>	'../web/cl_jobs.php',
									'Invoices'	=>	'../web/cl_invoices.php'
								);
		protected $invsubitems = array('Invoiced Jobs' 	=>	'../web/invoiced_jobs.php',
									'Generate Invoices'	=>	'../web/gen_invoices.php'
								);

		protected $setsubitems = array('User Settings' 	=>	'../web/user_settings.php',
									'Report Setup'	=>	'../web/report_setup.php',
									'Packages'		=>	'../web/packages.php',
									'Job Types'		=>	'../web/job_types.php',
									'Profiles'		=>	'../web/profiles.php',
									'User Defined Fields'	=>	'../web/user_defined.php'
								);								
		

		protected function displayTitle()
		{
			echo "<title>".$this->title."</title>";
		}
		
		protected function displayKeywords()
		{
			echo "<meta name=\"keywords\" content=\" ".htmlentities($this->keywords)."\" />";
		}
		
		protected function displayStyles()
		{
			echo "<link rel='stylesheet' type='text/css' href='../inc/transoffice.css' media='screen'/>";
		}

		
		protected function displayMenu($mainmenuitems) {
			echo "<div class='mainmenu'><table width='10%' bgcolor='white' cellpadding='4' cellspacing='4'>\n";
			echo "<tr><td><a href='../web/login.php'><img src='logo.png' alt='TOLogo' height='70' width='100'></a></td></tr>";			
			
			foreach ($mainmenuitems as $name=>$url) {
				//echo "<tr><td height><a href ='".htmlentities($url)."'><span class='mainmenu'>$name</span></a></td></tr>\n";
				echo "<tr><td height><a href ='".htmlentities($url)."'>$name</a></td></tr>\n";
			}
			
			echo "</table></div>\n";
		}
		
		protected function IsURLCurrentPage($url)
		{
			if (strpos($_SERVER['PHP_SELF'], $url) == false) {
				return false;
			} else {
				return true;
			}
		}
		
		protected function displayUser() {
			
			// instatiate new Session object & add user_id & domain_id to $sessvars array
			$session = new Session();
			$sessvars = $session->getSessionVars();
			$svparams = array($sessvars['user_id']);

			//instantiate new Dbconnect object
			$svsql = new Dbconnect();
			// if session variables are set, read user info using the user_id from the session 
			if (isset($sessvars['user_id'])) {
				$userdetails = $svsql->callReadSp('sys_users_read', $svparams);
			}
			
			if (isset($sessvars['user_id'])) {
//				while ($userarray = mysqli_fetch_array($userdetails)) {
				$userarray = $svsql->returnFirstRow($userdetails);
				echo "<tr><td>User: ".$userarray['user_name']."</td></tr>";
//				}
			}
		}
		
		protected function displayVersion() {
			echo "<tr><td>TransOffice version".$this->version."</td></tr>";
		}
		
		public function display()
		{
			echo "<html>\n<head>\n";
			$this -> displayTitle();
			$this -> displayKeywords();
			$this -> displayStyles();
			echo "</head>\n<body>\n";
			$this -> displayMenu($this->mainmenuitems);
			echo "<div class='footer'>";
			echo "<table width='10%' bgcolor='white' cellpadding='4' cellspacing='4'>\n";
			$this -> displayUser();
			$this -> displayVersion();
			echo "</table></div>";
//			echo "</body>\n</html>\n"; 
		}
			
	}

	$basepage = new BasePage();
	$basepage->display();
	echo "<div class='body'>";
	
	
?>