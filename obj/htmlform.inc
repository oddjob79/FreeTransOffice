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
		echo "<div class='col-8'>";
		echo "<div class='row'>\n<div class='col'>";
			echo "<h3 class='p-3 mb-2 bg-light text-dark'>".$formheader."</h3>";
		echo "</div></div>";
		echo "<div class='p-3 mb-2 bg-light text-dark'>";
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
//		$getvals = array_filter($getvals);
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
			$basepage->redirect("../web/".$entity."details.php?".$entity."id=".$newrecrow[$outparam]);
//				echo "Contact ".$contactposted[1]." created successfully"; // need to change this so this displays in an "infobar" at top of newly loaded page
		} else {
			echo "There was a problem creating the record.<br><br>";
		}
//		$sql = ""; $out = ""; $newrecord = ""; $jobposted = "";		
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
	
}

?>