<?php

class Tables {

	private function tableFormat($tableheader) {
		echo "<div class='col'>";
		echo "<div class='row'>\n<div class='col'>";
			echo "<h3 class='p-2 mb-2 bg-light text-dark'>".$tableheader."</h3>";
		echo "</div></div>";
//		echo "<div class='p-3 mb-2 bg-light text-dark'>";
	}
	
	public function entityList($theaders, $fieldnames, &$listdata, $url, $entity) {
		$this->tableFormat($entity."s");
		echo "<table class='table table-hover'>";
			echo "<thead class='table-primary'><tr>";
			// add <th> element for each table header sent through via the array
			foreach ($theaders as $theader) {
				echo "<th>".$theader."</th>";
			}
			echo "</tr></thead>";
		// for each row of data retrieved from the database
		foreach ($listdata as $datarow) {
			// run through each field name sent through in array
			foreach ($fieldnames as $fieldname) {
				// if the field name matches the entity name plus "id" then treat it as the identifier and use it to send to the details page
				if ($fieldname == strtolower($entity)."_id") {
					echo "<tr class='clickable-row' data-url='".$url."?".strtolower($entity)."id=".$datarow[$fieldname]."'>";
				} else {
					// otherwise push the data to a <td> element
					echo "<td>".$datarow[$fieldname]."</td>";
				}
			}
			echo "</tr>";
		} 
		echo "</table>";
		// use the entity name to name the "new record" button
		echo "<a href='".$url."' class='btn btn-primary' role='button'>New ".$entity."</a>";
	}
	
	public function updateDateFormat(&$entitydetails, $datefields) {
		// loop through each row of data and split up each associative array by their key-value pair
		foreach ($entitydetails as $key => $val) {
			// loop through each date field passed to method
			foreach ($datefields as $fieldname) {
				// set the value of the date field to the substr (date only - no time)
				$entitydetails[$key][$fieldname] = substr($val[$fieldname], 0, 10);
			}
		}
	}
	
	public function formatPrice(&$entitydetails, $pricefields) {
		// loop through each row of data and split up each associative array by their key-value pair
		foreach ($entitydetails as $key => $val) {
			// loop through each date field passed to method
			foreach ($pricefields as $fieldname) {
				// set the price field to 2dp and join with the currency code
				$entitydetails[$key][$fieldname] = number_format((float)$val[$fieldname], 2, '.', '') . " " . $entitydetails[$key]['currency_code'] ;
			}
		}
	}
	
	public function setIntToYorN(&$entitydetails, $yornfields) {
		// loop through each row of data and split up each associative array by their key-value pair
		foreach ($entitydetails as $key => $val) {
			// loop through each date field passed to method
			foreach ($yornfields as $fieldname) {
				// set the field value to "Y" if the data is 1 otherwise "N"
				if ($val[$fieldname] == 1) {
					$entitydetails[$key][$fieldname] = "Y";
				} else {
					$entitydetails[$key][$fieldname] = "N";
				}
			}
		}		
	}
	
}

?>

