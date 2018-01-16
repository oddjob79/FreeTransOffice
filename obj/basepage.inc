<?php
	
	require_once('../database/dbconnect.inc');
	require_once('../obj/session.inc');
	
	class BasePage {
		public $content;
		protected $version = "v1.0";
		protected $title = 'TransOffice';
		protected $keywords = 'TransOffice - Invoicing and Project Management Tool for Freelance Translation Professionals';		
		
		protected $mainmenuitems = array('Contacts' 	=>	'../web/contacts.php',
									'Clients'	=>	'../web/clients.php',
									'Jobs'		=>	'../web/jobs.php',
									'Invoices'	=>	'../web/invoices.php',
									'Settings'	=>	'../web/settings.php'
								);
		
		protected $clientsubitems = array(
									'Clients' =>	'../web/clientlist.php',
									'End Clients' =>	'../web/cl_endclients.php',
									'Contacts'	=>	'../web/cl_contacts.php',
									'Jobs'		=>	'../web/cl_jobs.php',
									'Invoices'	=>	'../web/cl_invoices.php'
								);
		protected $invsubitems = array('Invoices' 	=>	'../web/invoicelist.php',
									'Generate Invoices'	=>	'../web/geninvoices.php'
								);

// certain options removed as functionality will be implemented at a later date
		protected $setsubitems = array('User Settings' 	=>	'../web/usersettings.php',
	//								'Report Setup'	=>	'../web/reportsetup.php',
									'Packages'		=>	'../web/packages.php',
									'Job Types'		=>	'../web/jobtypes.php'//,
	//								'Profiles'		=>	'../web/profiles.php',
	//							'User Defined Fields'	=>	'../web/userdefined.php'
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
				<link rel="stylesheet" href="../inc/bootstrap/css/bootstrap-datepicker.standalone.min.css" type="text/css">
				<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css">				
			
				<!-- Optional JavaScript -->
				<!-- jQuery first, then Popper.js, then Bootstrap JS -->
				<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script> 
				<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
				<script src="../inc/bootstrap/js/bootstrap-datepicker.min.js"></script>
				<!-- custom javascript library -->
				<script src="../inc/transoffice.js?rndstr=117"></script>
				
				<!-- ensures sclaing to mobile devices -->
				<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
				
			<?php
		}

		protected function displayBanner() {
			echo '<div class="pl-3 py-2 mb-2 bg-info text-white">';
//			echo '<div class="pb-0 mb-0 bg-info text-white">';
			echo '<div class="row">';
				echo '<div class="col-2">';
					echo '<h2><a style="text-decoration:none;color:white;" href="../web/login.php">TransOffice</a></h2>';
				echo '</div><div class="col"></div>';
				echo '<div class="col-1">';
					echo $this->version;
				echo '</div><div class="col-2">';
					$this->displayUser();
			echo '</div></div></div>';
		}
		
		
		protected function displayMenu($mainmenuitems) {
			// additional functionality needed - 1. active status for links based on URL. 2. maintaining show / hide collapse on page load
			?>
			<div class="row">
			<div class='col-2'>
				<div class="p-3 mb-2 bg-light text-dark">
				<nav style="font-size:18px;" class="nav flex-column">
					<a class="py-3 pl-1 nav-link" href="../web/contactlist.php">Contacts</a>
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
					<a class="py-3 pl-1 nav-link" href="../web/joblist.php">Jobs</a>
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
				echo "<a class='dropdown-item' href='../web/usersettings.php'>User Settings</a>";
				echo "<a class='dropdown-item' href='../web/logout.php'>Logout</a>";
				echo "</div></div>";
			}
			$sql = ''; $svparams=''; $userdetails='';$userarray='';
		}
		
		protected function displayVersion() {
			echo "<tr><td>TransOffice version".$this->version."</td></tr>";
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

		public function checkLoggedIn() {
			if (empty($_SESSION['user_id'])) {
				$this->redirect('../web/login.php');
			}
		}
		
		public function setClientSessionId($clientid) {
			$client_sess = new Session();
			$client_sess -> setClientId($clientid);
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
			$this -> displayMenu($this->mainmenuitems);
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