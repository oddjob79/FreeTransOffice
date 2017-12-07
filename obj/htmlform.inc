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
			// had to change !empty to !isset to account for posted zeroes being treated as NULLS. May have to use strlen() > 0
			// check if the field was set in the form, and assign appropriate value to the key-value pair, otherwise set the fieldname key to null
//			if (!empty($_POST[$postedname])){
			if (strlen($_POST[$postedname]) > 0) {
				// check if the value of the field is an integer. If true, set data type as int
				if (strlen(filter_input(INPUT_POST, $postedname, FILTER_VALIDATE_INT)) > 0) {
					$postedvals[$postedname] = (int)$_POST[$postedname];
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