<?php

//require_once('../obj/basepage.inc');

class Tables {

/*	private function tableFormat($tableheader) {
		echo "<div class='col-10'>";
		echo "<div class='row'>\n<div class='col-10'>";
			echo "<h3 class='p-2 mb-2 bg-light text-dark'>".$tableheader."</h3>";
		echo "</div></div>";
//		echo "<div class='p-3 mb-2 bg-light text-dark'>";
	}
*/

	private function tableFormat($tableheader) {
		echo "<div class='col-10'>";
		echo "<div class='row'>\n<div class='col'>";
			echo "<h3 class='p-2 mb-2 bg-light text-dark'>".$tableheader."</h3>";
		echo "</div></div>";
//		echo "<div class='row'>\n<div class='col-10'>";		
	}
	
	public function entityList($theaders, $fieldnames, &$listdata, $url, $entity, $filter = 'none') {
		$this->tableFormat($entity."s");
		if ($filter == 'client') {
			$this->clientList();
		} else if ($filter == 'invoice') {
			$this->invoiceList();
		}
		echo "<table class='table table-hover table-responsive' id='elementlist'>";
		echo "<thead class='table-primary'><tr>";
			// add <th> element for each table header sent through via the array
			foreach ($theaders as $theader) {
				echo "<th>".$theader."</th>";
			}
//			echo "</tr></thead><tbody>"; replaced with line below for test of column filtering
// 			echo "</tr></thead>"; - further testing

// test for column filtering

//		echo "<tfoot><tr>";
/*		echo "</tr><tr>";
			// add <th> element for each table header sent through via the array
			foreach ($theaders as $theader) {
				echo "<th>".$theader."</th>";
			}
*/			
			echo "</tr></thead><tbody>";

// end test

			// for each row of data retrieved from the database
		foreach ($listdata as $datarow) {
			// run through each field name sent through in array
			foreach ($fieldnames as $fieldname) {
				// if the field name matches the entity name plus "id" then treat it as the identifier and use it to send to the details page
				if ($fieldname == strtolower(str_replace(" ", "_", $entity))."_id") {	
					echo "<tr data-url='".$url."?".strtolower(str_replace(" ", "", $entity))."id=".$datarow[$fieldname]."'>";
				} else {
					// otherwise push the data to a <td> element
					echo "<td>".$datarow[$fieldname]."</td>";
				}
			}
			echo "</tr>";
		} 
		echo "</tbody></table>";

		// use the entity name to name the "new record" button
		$filtergetvar = $filter."id";
		if ($filter != 'none' && !empty($_GET[$filtergetvar])) {
			$url = $url."?".$filtergetvar."=".$_GET[$filtergetvar];
		}
		
		// ensures jquery only run when there is a filter on the page
		if ($filter == 'none') {
			echo "<a href='".$url."' class='btn btn-primary' type='button' role='button'>New ".$entity."</a>";
		} else {
			echo "<a href='".$url."' class='btn btn-primary' id='entitylistnewbutton' type='button' role='button'>New ".$entity."</a>";
		}
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
	
	private function clientList() {
		$sql = new Dbconnect();
		// set array to "select all" -1 and domain_id to retrieve all records for this domain only
		$domparams = array($_SESSION['domain_id']);
		$clients = $sql->callSP('sp_client_list', $out, $domparams);	

		echo "<div class='row'>\n<div class='col-6'>";
			echo "<p>Client: <select class='form-control' id='clientselect' name='clientid'>";
			echo "<option value=''></option>";
				foreach ($clients as $client) {
					if ($client['client_id'] == $_GET['clientid']) {
						echo "<option value=".$client['client_id']." selected='selected'>".$client['client_name']."</option>";
					} else {
						echo "<option value=".$client['client_id'].">".$client['client_name']."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div></div>";
	}
	
}

?>

