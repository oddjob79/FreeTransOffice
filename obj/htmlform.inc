<?php

class HtmlForm {
	
	public $postedname;
	public $postedvals; 

	public function loginFormat() {
		echo "<div class='col-1'></div>";
		echo "<div class='col-6'>";
		echo "<div class='p-3 mb-2 bg-light text-dark'>";
	}
	
	public function formFormat($formheader) {
		echo "<div class='col-8'>";
		echo "<div class='row'>\n<div class='col'>";
			echo "<h3 class='p-3 mb-2 bg-light text-dark'>".$formheader."</h3>";
		echo "</div></div>";
		echo "<div class='p-3 mb-2 bg-light text-dark'>";
	}
	
	public function loginForm() {
		echo "<form method='post' action='login.php'>";
		echo "<div class='form-group'>";
		echo "<p>Username: <input class='form-control' placeholder='Enter Username' type='text' name='username' size='100' maxlength='30' /></p>";
		echo "<p>Password: <input class='form-control' placeholder='Enter Password' type='text' name='password' size='100' maxlength='30' /></p></br>";
		echo "<input class='btn btn-outline-primary' type='submit' value='Login' />";
		?> <button type="button" class="btn btn-outline-primary" onclick="window.location.href='newuser.php'" 
			data-toggle="tooltip" data-placement="bottom" title="Click here to register for TransOffice">New User</button><?php
		echo "</div></form>";
		echo "</div></div>";
	}

// pass in array containing all field names from form and passes back variables of the same name set to either integers or strings, depending on data type	
	public function getPostedValues(&$inputnames) {
		$postedvals = array();
		foreach ($inputnames as $postedname) {
			// check if the field was set in the form, and assign appropriate value to the key-value pair, otherwise set the fieldname key to null
			if (!empty($_POST[$postedname])){
				// check if the value of the field is an integer. If true, set data type as int
				if (!empty(filter_input(INPUT_POST, $postedname, FILTER_VALIDATE_INT))) {
					$postedvals[$postedname] = (int)$_POST[$postedname];
				} else {
				$postedvals[$postedname] = $_POST[$postedname];
				}
			} else {
				$postedvals[$postedname] = NULL;
			}
//			debugging for data type
//			echo $postedname. " - ". $postedvals[$postedname] . ' datatype = ' . gettype($postedvals[$postedname])."<br>";
		}
		return($postedvals);
	}
	
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