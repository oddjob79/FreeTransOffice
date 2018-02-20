<?php

class HtmlForm {
	
	public $postedname;
	public $postedvals; 
	
	protected function setFormHeader($module, $displaydata = null) {
		if (!empty($displaydata)) {
			$formheader = $module . ' - '.$displaydata; 
		} else {
			$formheader = 'New '.$module;
		}
		return $formheader;
	}
	
	protected function formFormat($formheader) {
//		echo "<div class='col-10 '>";
		echo "<div class='container'>";
		echo "<div class='row'>\n<div class='col'>";
			echo "<h3 class='p-3 mb-2 bg-light text-dark'>".$formheader."</h3>";
		echo "</div></div>";
		echo "<div class='p-3 mb-2 bg-light text-dark'>";
	}

	protected function getTandC() {
		$termsandconditions = "<p><b>CONDITIONS OF USE</b></p>";
		$termsandconditions .= "<p>Welcome to FreeTransOffice! Kennet Technology Services offer this service to you subject to the following conditions. If you visit this website, you accept these conditions. Please read them carefully.</p>";
		$termsandconditions .= "<p><b>PRIVACY</b></p>";
		$termsandconditions .= "<p>Please review our Privacy Notice, which also governs your visit to our website, to understand our practices.</p>";
		$termsandconditions .= "<p><b>ELECTRONIC COMMUNICATIONS</b></p>";
		$termsandconditions .= "<p>When you visit freetransoffice.com or send e-mails to Kennet Technology Services, you are communicating with us electronically. You consent to receive communications from us electronically. ";
		$termsandconditions .= "We will communicate with you by e-mail or by posting notices on this site. You agree that all agreements, notices, disclosures and other communications that we provide to you electronically satisfy any legal requirement that such communications be in writing.</p>";
		$termsandconditions .= "<p><b>YOUR MEMBERSHIP ACCOUNT</b></p>";
		$termsandconditions .= "<p>If you use this site, you are responsible for maintaining the confidentiality of your account and password and for restricting access to your computer, and you agree to accept responsibility for all activities that occur under your account or password. ";
		$termsandconditions .= "If you are under 18, you may use our website only with involvement of a parent or guardian. Kennet Technology Services and its associates reserve the right to refuse service, terminate accounts, remove or edit content, or cancel orders in their sole discretion.</p>";
		$termsandconditions .= "DISCLAIMER OF WARRANTIES AND LIMITATION OF LIABILITY THIS SITE IS PROVIDED BY KENNET TECHNOLOGY SERVICES ON AN 'AS IS' AND 'AS AVAILABLE' BASIS. KENNET TECHNOLOGY SERVICES MAKES NO REPRESENTATIONS OR WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, AS TO THE OPERATION OF ";
		$termsandconditions .= "THIS SITE OR THE INFORMATION, CONTENT, MATERIALS, OR PRODUCTS INCLUDED ON THIS SITE. YOU EXPRESSLY AGREE THAT YOUR USE OF THIS SITE IS AT YOUR SOLE RISK. TO THE FULL EXTENT PERMISSIBLE BY APPLICABLE LAW, KENNET TECHNOLOGY SERVICES DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, ";
		$termsandconditions .= "INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. KENNET TECHNOLOGY SERVICES DOES NOT WARRANT THAT THIS SITE, ITS SERVERS, OR E-MAIL SENT FROM KENNET TECHNOLOGY SERVICES ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS. ";
		$termsandconditions .= "KENNET TECHNOLOGY SERVICES WILL NOT BE LIABLE FOR ANY DAMAGES OF ANY KIND ARISING FROM THE USE OF THIS SITE, INCLUDING, BUT NOT LIMITED TO DIRECT, INDIRECT, INCIDENTAL, PUNITIVE, AND CONSEQUENTIAL DAMAGES. CERTAIN STATE LAWS DO NOT ALLOW LIMITATIONS ON IMPLIED WARRANTIES OR THE ";
		$termsandconditions .= "EXCLUSION OR LIMITATION OF CERTAIN DAMAGES. IF THESE LAWS APPLY TO YOU, SOME OR ALL OF THE ABOVE DISCLAIMERS, EXCLUSIONS, OR LIMITATIONS MAY NOT APPLY TO YOU, AND YOU MIGHT HAVE ADDITIONAL RIGHTS.</p>";
		$termsandconditions .= "<p><b>APPLICABLE LAW</b></p>";
		$termsandconditions .= "<p>By visiting FreeTransOffice.com, you agree that the laws of the state of Wisconsin, USA, without regard to principles of conflict of laws, will govern these Conditions of Use and any dispute of any sort that might arise between you and Kennet Technology Services or its associates.</p>";
		$termsandconditions .= "<p><b>DISPUTES</b></p>";
		$termsandconditions .= "<p>Any dispute relating in any way to your visit to FreeTransOffice.com shall be submitted to confidential arbitration in Wisconsin, USA, except that, to the extent you have in any manner violated or threatened to violate Kennet Technology Services’ intellectual property rights, ";
		$termsandconditions .= "Kennet Technology Services may seek injunctive or other appropriate relief in any state or federal court in the state of Wisconsin, USA, and you consent to exclusive jurisdiction and venue in such courts. Arbitration under this agreement shall be conducted under the rules then prevailing of ";
		$termsandconditions .= "the American Arbitration Association. The arbitrators award shall be binding and may be entered as a judgment in any court of competent jurisdiction. To the fullest extent permitted by applicable law, no arbitration under this Agreement shall be joined to an arbitration involving any other ";
		$termsandconditions .= "party subject to this Agreement, whether through class arbitration proceedings or otherwise.</p>";
		$termsandconditions .= "<p><b>SITE POLICIES, MODIFICATION, AND SEVERABILITY</b></p>";
		$termsandconditions .= "<p>We reserve the right to make changes to our site, policies, and these Conditions of Use at any time. If any of these conditions shall be deemed invalid, void, or for any reason unenforceable, that condition shall be deemed severable and shall not affect the validity and enforceability of any remaining condition.</p>";
		$termsandconditions .= "<p><b>QUESTIONS</b></p>";
		$termsandconditions .= "<p>Questions regarding our Conditions of Usage, Privacy Policy, or other policy related material can be emailed to us at: support@kennettechservices.com.</p>";
		
		return $termsandconditions;
	}


	
	// update so only accessed by subclasses and make protected
	// pass in array containing all field names from form and passes back variables of the same name set to either integers or strings, depending on data type
	// $adddomain boolean chooses to add domain_id to beginning of array
	public function getPostedValues(&$inputnames, $adddomain) {
		$postedvals = array();
		foreach ($inputnames as $postedname) {
			// check if the field was set in the form, and assign appropriate value to the key-value pair, otherwise set the fieldname key to null
//			if (strlen($_POST[$postedname]) > 0) {
			if (isset($_POST[$postedname])) {
				// check if the value of the field is an integer. If true, set data type as int
				$range = array(
					'options' => array ( 'min_range' => 0, 'max_range' => 200000000000)
				);
				if (strlen(filter_input(INPUT_POST, $postedname, FILTER_VALIDATE_INT, $range)) > 0) {
					$postedvals[$postedname] = (int)$_POST[$postedname];
				} elseif ($_POST[$postedname] === ""){
					$postedvals[$postedname] = NULL;
				} else {
					$postedvals[$postedname] = htmlspecialchars($_POST[$postedname]);
				}
			} else {
				$postedvals[$postedname] = NULL;
			}
//			debugging for data type
//			echo $postedname. " - ". $postedvals[$postedname] . ' datatype = ' . gettype($postedvals[$postedname])."<br>";

		}
		
		if ($adddomain == true) {
			array_unshift($postedvals, $_SESSION['domain_id']);
		}
		return($postedvals);
	}
	
	protected function getGetValues(&$inputnames) {
		$getvals = array();
		foreach ($inputnames as $getname) {
			if (!empty($_GET[$getname])) {
				$getvals[$getname] = $_GET[$getname];
			} else {
				$getvals[$getname] = NULL;
			}
		}
		// gets rid of empty key / value pairs
	//	$getvals = array_filter($getvals);
		return ($getvals);
	}

	public function doesRecordExist() {
		if (!empty($_POST['recordid'])) {
			$recordexists = true;
		} else {
			$recordexists = false;
		}
		return $recordexists;
	}
	
	// re-write send in newrecrow. return redirect path. move returnFirstRow and redirect outside method. have child method for invoice with diff redirect string
	public function recordCreated(&$newrecord, $entity) {
		if (!empty($newrecord)) {
			$sql = new Dbconnect();
			$basepage = new BasePage();
			// retrieve the newly created contact id
			$newrecrow = $sql->returnFirstRow($newrecord);
			// redirect to the newly created record
			$entity = strtolower($entity);
			$outparam = "u_".$entity."_id";
			$entity = str_replace('_', '', $entity);
			if ($entity == 'invoice') {
				$redirecturl = "invdetails.php?".$entity."id=".$newrecrow[$outparam];
				return $redirecturl;
//				$basepage->redirect("invdetails.php?".$entity."id=".$newrecrow[$outparam]);
			} else {
				$basepage->redirect($_SERVER['PHP_SELF']."?".$entity."id=".$newrecrow[$outparam]);
			}

		} else {
			echo "There was a problem creating the record.<br><br>";
		}
	}
	
	protected function emptyParam($param, $ifempty, $iffull) {
		return (empty($param)) ? $ifempty : $iffull;
	}
	
	protected function statusSort(&$statuses, $sortorder) {
		// loop through all the potential statuses and unset the status name and id if they are not specified in the sort order
		foreach ($statuses as &$status) {
			if (!(in_array($status['status_id'], $sortorder))) {
				unset($status['status_id']);
				unset($status['status_name']);
			}
		}
		// remove empty arrays
		$statuses = array_filter($statuses);
		
		// sort the statuses according to the order set in the incoming parameter
		uasort($statuses, function($a, $b) use ($sortorder) {
			$pos_a = array_search($a['status_id'], $sortorder);
			$pos_b = array_search($b['status_id'], $sortorder);
			return $pos_a - $pos_b;
		});
		return $statuses;
	}
	
	// Generate list of TimeZones
	protected function generate_timezone_list()
	{
		static $regions = array(
			DateTimeZone::AFRICA,
			DateTimeZone::AMERICA,
			DateTimeZone::ANTARCTICA,
			DateTimeZone::ASIA,
			DateTimeZone::ATLANTIC,
			DateTimeZone::AUSTRALIA,
			DateTimeZone::EUROPE,
			DateTimeZone::INDIAN,
			DateTimeZone::PACIFIC,
		);

		$timezones = array();
		foreach( $regions as $region )
		{
			$timezones = array_merge( $timezones, DateTimeZone::listIdentifiers( $region ) );
		}

		$timezone_offsets = array();
		foreach( $timezones as $timezone )
		{
			$tz = new DateTimeZone($timezone);
			$timezone_offsets[$timezone] = $tz->getOffset(new DateTime);
		}

		// sort timezone by offset
		asort($timezone_offsets);

		$timezone_list = array();
		foreach( $timezone_offsets as $timezone => $offset )
		{
			$offset_prefix = $offset < 0 ? '-' : '+';
			$offset_formatted = gmdate( 'H:i', abs($offset) );

			$pretty_offset = "UTC${offset_prefix}${offset_formatted}";

			$timezone_list[$timezone] = "(${pretty_offset}) $timezone";
		}

		return $timezone_list;
	}

	protected function currencySort($currencies) {
		$currencies = array(48 => $currencies[48], // EUR
			51 => $currencies[51], // GBP
			148 => $currencies[148]) // USD
			+ $currencies;
		return $currencies;
	}
	
	private function modalHeader($modalid, $header) {
		echo "<div id='".$modalid."' class='modal fade' role='dialog'>";
		  echo "<div class='modal-dialog'>";
			echo "<div class='modal-content'>";
			  echo "<div class='modal-header'>";
			   echo "<h5 class='modal-title'>".$header."</h5>";
				echo "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>";
				  echo "<span aria-hidden='true'>&times;</span>";
				echo "</button>";
			  echo "</div>";		
	}
	
	private function modalBody($msg) {
	  echo "<div class='modal-body'>";
		echo "<p>".$msg."</p>";
	  echo "</div>";		
	}
	
	private function modalFooterConfirm($saveid, $value) {
	  echo "<div class='modal-footer'>";
		echo "<input class='btn btn-primary' type='submit' id='".$saveid."' value='".$value."' /> ";			  
//				echo "<button type='button' id='".$saveid."' class='btn btn-primary'>Save changes</button>";
		echo "<button type='button' class='btn btn-secondary' data-dismiss='modal'>Cancel</button>";
	  echo "</div></div></div></div>";		
	}
	
	private function modalFooterPrint($saveid, $value) {
	  echo "<div class='modal-footer'>";
		echo "<button type='button' id='".$saveid."' class='btn btn-primary' value='".$value."'>Invoice Details</button>";
	  echo "</div></div></div></div>";		
	}
	
	private function modalFooterAlert($saveid=null, $value=null) {
	  echo "<div class='modal-footer'>";
		echo "<button type='button' id='".$saveid."' class='btn btn-primary' data-dismiss='modal' value='".$value."'>OK</button>";
	  echo "</div></div></div></div>";		
	}
	
	protected function buildConfirmModal($modalid, $header, $msg, $saveid = null, $value = null) {
		$this->modalHeader($modalid, $header);
		$this->modalBody($msg);
		$this->modalFooterConfirm($saveid, $value);
	}
	
	public function buildPrintModal($modalid, $header, $msg, $saveid = null, $value = null) {
		$this->modalHeader($modalid, $header);
		$this->modalBody($msg);
		$this->modalFooterPrint($saveid, $value);
	}
	
	protected function buildAlertModal($modalid, $header, $msg, $saveid = null, $value = null) {
		$this->modalHeader($modalid, $header);
		$this->modalBody($msg);
		$this->modalFooterAlert();
	}
	
}

?>