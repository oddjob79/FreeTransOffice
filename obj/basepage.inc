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
			?>
				<!-- Bootstrap CSS -->
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
				<link rel="stylesheet" href="../inc/bootstrap/css/bootstrap-datepicker.standalone.min.css" type="text/css">
			
				<!-- Optional JavaScript -->
				<!-- jQuery first, then Popper.js, then Bootstrap JS -->
				<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script> 
				<script src="../inc/bootstrap/js/bootstrap-datepicker.min.js"></script>

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
//					echo '<h2><a class="pl-0 pb-0 mb-0 bg-info text-white" style="text-decoration:none;color:white;" href="../web/login.php"><b>TransOffice</b></a></h2>';
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
			global $userid;
			$userid = $sessvars['user_id'];
			global $domainid;
			$domainid = $sessvars['domain_id'];
			
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
		
		// function used to close out div tags at the end of each page
		public function endPage() {
			echo "</div></div>\n</body>\n</html>\n"; 
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

		
		public function display()
		{
			echo "<!DOCTYPE html>\n<html lang='en'>\n<head>\n";
			$this -> displayTitle();
			$this -> displayKeywords();
			$this -> displayStyles();
			echo "</head>\n<body>\n<div class='container-fluid'>\n\t<div class='row-fluid'>\n\t";
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