<?php
	
	require_once('../database/dbconnect.inc');
	require_once('../obj/session.inc');
	
	class BasePage {
		public $content;
		protected $version = "v1.0";
		protected $title = 'FreeTransOffice';
		protected $keywords = 'FreeTransOffice - Invoicing and Project Management Tool for Freelance Translation Professionals';		
		
		protected $mainmenuitems = array('Contacts' 	=>	'contactlist.php',
									'Clients'	=>	'clientlist.php',
									'Jobs'		=>	'joblist.php',
									'Invoices'	=>	'invoicelist.php'
								);
		
		protected $clientsubitems = array(
//									'Clients' =>	'clientlist.php',
									'End Clients' =>	'cl_endclients.php',
									'Contacts'	=>	'cl_contacts.php',
									'Jobs'		=>	'cl_jobs.php',
									'Invoices'	=>	'cl_invoices.php'
								);
		protected $invsubitems = array(
//									'Invoices' 	=>	'invoicelist.php',
									'Generate Invoices'	=>	'geninvoices.php'
								);

// certain options removed as functionality will be implemented at a later date
		protected $setsubitems = array('User Settings' 	=>	'usersettings.php',
									'Report Configuration'	=>	'reportconfig.php',
									'Packages'		=>	'packages.php',
									'Job Types'		=>	'jobtypes.php'//,
	//								'Profiles'		=>	'profiles.php',
	//							'User Defined Fields'	=>	'userdefined.php'
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
			?>
				<!-- Bootstrap CSS -->
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
				<link rel="stylesheet" href="/inc/bootstrap/css/bootstrap-datepicker.standalone.min.css" type="text/css">
				<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css">				
			
				<!-- Optional JavaScript -->
				<!-- jQuery first, then Popper.js, then Bootstrap JS -->
				<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script> 
				<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
				<script src="/inc/bootstrap/js/bootstrap-datepicker.min.js"></script>
				<!-- custom javascript library add ?rndstr=135 when making changes to js-->
				<script src="/inc/transoffice.js?rndstr=144"></script>
				
				<!-- ensures sclaing to mobile devices -->
				<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
				
			<?php
		}

		protected function displayBanner() {
			echo '<div class="pl-3 py-2 mb-2 bg-info text-white">';
			echo '<div class="row">';
				echo '<div class="col-3">';
					echo '<h2><a style="text-decoration:none;color:white;" href="joblist.php">FreeTransOffice</a></h2>';
				echo '</div>';
				$this->displayNavMenu();
				echo '<div class="col-2">';
					$this->displayUser();
			echo '</div></div></div>';
		}

		protected function displayNavMenu() {
			echo '<div class="col-7 btn-group">';
				$this->simpleNavLink('contact');
				$this->dropdownNavLink('client', $this->clientsubitems);
				$this->simpleNavLink('job');
				$this->dropdownNavLink('invoice', $this->invsubitems);
				$this->dropdownNavLink('settings', $this->setsubitems);
			echo '</div>';
		}
		
		private function simpleNavLink($menuitem) {
			echo '<a class="btn btn-info" role="button" href="'.$menuitem.'list.php" >'.ucfirst($menuitem).'s</a>';
		}
		
		private function dropdownNavLink($menuitem, $submenuitems) {
			echo '<div class="btn-grp">';
			if ($menuitem == 'settings') {
				echo '<a class="btn btn-info dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Settings</a>';
			} else {
				echo '<a class="btn btn-info" role="button" href="'.$menuitem.'list.php" >'.ucfirst($menuitem).'s</a>';
				echo '<button type="button" class="btn btn-info dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">';
				echo '<span class="sr-only">Toggle Dropdown</span></button>';
			}
			echo '<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">';
			foreach ($submenuitems as $name=>$url) {
				echo "<a class='dropdown-item' href ='".htmlentities($url)."'>$name</a></li>";
			}
		echo '</div></div>';
		}

		
		// no longer in use - replaced by displayNavMenu
/*		protected function displayMenu($mainmenuitems) {
			// additional functionality needed - 1. active status for links based on URL. 2. maintaining show / hide collapse on page load
			?>
			<div class="row">
			<div class='col-2'>
				<div class="p-3 mb-2 bg-light text-dark">
				<nav style="font-size:18px;" class="nav flex-column">
					<a class="py-3 pl-1 nav-link" href="contactlist.php">Contacts</a>
<!--					<a class="py-3 pl-1 nav-link" data-toggle="collapse" href="#collapseClient" aria-expanded="false" aria-controls="collapseClient" onclick="window.location.href='clientlist.php'">Clients</a> -->
					<a class="py-3 pl-1 nav-link" data-toggle="collapse" href="#collapseClient" aria-expanded="false" aria-controls="collapseClient">Clients</a>					
					<div class="collapse" id="collapseClient">
							<nav class="nav flex-column">
							<?php
							foreach ($this->clientsubitems as $name=>$url) {
								echo "<a style='font-size:16px;' class='p-2 nav-link text-secondary' href ='".htmlentities($url)."'>$name</a></li>\n";
							}
							?>
							</nav>
						</div>					
					<a class="py-3 pl-1 nav-link" href="joblist.php">Jobs</a>
					<a class="py-3 pl-1 nav-link" data-toggle="collapse" href="#collapseInvoice" aria-expanded="false" aria-controls="collapseInvoice">Invoices</a>
						<div class="collapse" id="collapseInvoice">
							<nav class="nav flex-column">
							<?php
							foreach ($this->invsubitems as $name=>$url) {
								echo "<a style='font-size:16px;' class='p-2 nav-link text-secondary' href ='".htmlentities($url)."'>$name</a></li>\n";
							}
							?>
							</nav>
						</div>							
					<a class="py-3 pl-1 nav-link" data-toggle="collapse" href="#collapseSettings" aria-expanded="false" aria-controls="collapseSettings">Settings</a>
						<div class="collapse" id="collapseSettings">
							<nav class="nav flex-column">
							<?php
							foreach ($this->setsubitems as $name=>$url) {
								echo "<a style='font-size:16px;' class='p-2 nav-link text-secondary' href ='".htmlentities($url)."'>$name</a></li>\n";
							}
							?>
							</nav>
						</div>							
				</nav>
			</div></div>
		<?php		
		}
*/
		
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

			//instantiate new Dbconnect object
			$sql = new Dbconnect();
			
			if (isset($_SESSION['user_id']) and substr($_SERVER['PHP_SELF'], -10) != 'logout.php') {
				$svparams = array($_SESSION['user_id']);
				$out = array();
				$userdetails = $sql->callSP('sys_users_read', $out, $svparams);
				$userarray = $sql->returnFirstRow($userdetails);
				
				echo "<div class='dropdown'>";
				echo "<button class='btn btn-info dropdown toggle' type='button' id='usermenubutton' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>";
				echo "User: ".$userarray['user_name']."</button>";
				echo "<div class='dropdown-menu' aria-labelledby='usermenubutton'>";
				echo "<a class='dropdown-item' href='usersettings.php'>User Settings</a>";
				echo "<a class='dropdown-item' href='#aboutFTOModal' data-toggle='modal' data-target='#aboutFTOModal'>About FreeTransOffice</a>";
				echo "<a class='dropdown-item' href='logout.php'>Logout</a>";
				echo "</div></div>";
				$this->aboutModal();

			}
			$sql = ''; $svparams=''; $userdetails='';$userarray='';
		}

		private function aboutModal() {
			echo "<div id='aboutFTOModal' class='modal fade' role='dialog'>";
				echo "<div class='modal-dialog'>";
					echo "<div class='modal-content'>";
						echo "<div class='modal-header dropdown-item'>";
							echo "<h5 class='modal-title'>About FreeTransOffice</h5>";
							echo "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>";
								echo "<span aria-hidden='true'>&times;</span>";
							echo "</button>";
						echo "</div>";
					echo "<div class='modal-body dropdown-item'>";
						echo "<p>FreeTransOffice - version 1.0 - February 2018</p>";
						//echo "<p>FreeTransOffice is an open source application for Freelance Translators,<br>built and maintained by Kennet Technology Services.</p>";
					echo "</div>";
			  echo "<div class='modal-footer'>";
				echo "<button type='button' class='btn btn-primary' data-dismiss='modal'>OK</button>";
			  echo "</div></div></div></div>";	
		}
		
		protected function displayVersion() {
			echo "<tr><td>FreeTransOffice version".$this->version."</td></tr>";
		}
		
		// function used to close out div tags at the end of each page
		public function endPage() {
//			echo "</div></div>\n</body>\n</html>\n"; 
			echo "</div>\n</body>\n</html>\n"; 			
		}
		
		// method needed for page redirects which includes a workaround for when the headers are also loaded
		public function redirect($url){
				if (headers_sent()){
					die('<script type="text/javascript">window.location.href="' . $url . '";</script>');
				} else {
					header('Location: ' . $url);
					die();
				}    
			}

		// currently set on all pages. Should be moved to display() function
		public function checkLoggedIn() {
			$this->logoutIfTimedOut();
			
			if (empty($_SESSION['user_id'])) {
				$this->redirect('login.php');
			}
		}
		
		private function logoutIfTimedOut() {
			if (isset($_SESSION['LAST_ACTIVITY']) && (time() - $_SESSION['LAST_ACTIVITY'] > 18000)) { // change to 1800
				// last request was more than 20 minutes ago
				session_unset();     // unset $_SESSION variable for the run-time 
				session_destroy();   // destroy session data in storage
			}
		}
		
		public function display()
		{
			echo "<!DOCTYPE html>\n<html lang='en'>\n<head>\n";
			$this -> displayTitle();
			$this -> displayKeywords();
			$this -> displayStyles();
//			echo "</head>\n<body>\n<div class='container-fluid'>\n\t<div class='row-fluid'>\n\t";
			echo "</head>\n<body>\n<div class='container-fluid'>\n\t";			
			$this->displayBanner();
//			$this -> displayMenu($this->mainmenuitems);
//			$this -> logoutIfTimedOut();
//			$this -> checkLoggedIn();
//			echo "</div></div>";
//			echo "<div class='col'>";
//			echo $this->content;
/*			echo "<div class='footer'>";
			echo "<table width='10%' bgcolor='white' cellpadding='4' cellspacing='4'>\n";
			$this -> displayUser();
			$this -> displayVersion();
			echo "</table></div>"; */
			//echo "</div></div>\n</body>\n</html>\n"; 
		}
		
	}

	
	
?>