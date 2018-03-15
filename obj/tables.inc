<?php

//require_once('../obj/basepage.inc');

class Tables {

	private function tableFormat($tableheader) {
		if ($tableheader != 'Jobs' && $tableheader != 'Generate Invoices') {
			echo "<div class='container'>";
		}
		echo "<div class='row'>\n<div class='col'>";
			echo "<h3 class='p-2 mb-2 bg-light text-dark'>".$tableheader."</h3>";
		echo "</div></div>";
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
			// loop through each price field passed to method
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
					// use the client as taken from the URL or if none there, take from the Session var, else no default client shown
					if ($client['client_id'] == $_GET['clientid']) {
						echo "<option value=".$client['client_id']." selected='selected'>".$client['client_name']."</option>";
					} else if ($client['client_id'] == $_SESSION['client_id'] && empty($_GET['clientid'])) {
						echo "<option value=".$client['client_id']." selected='selected'>".$client['client_name']."</option>";
					} else {
						echo "<option value=".$client['client_id'].">".$client['client_name']."</option>";
					}
				} 
			echo "</select></p>";
		echo "</div></div>";
	}
	
	public function getsetClientId() {
		// get the client id from the URL, if no id in URL, use the client id session var (set from the client details page), if nothing here, set to -1 (null)
		$clientid = (empty($_GET['clientid'])) ? ((empty($_SESSION['client_id'])) ? "-1" : $_SESSION['client_id']) : $_GET['clientid'];
		
		if (!empty($clientid) && $clientid != "-1") {
			$_SESSION['client_id'] = $clientid;
		}
		return $clientid;
	}

	public function entityList($theaders, $fieldnames, &$listdata, $url, $entity, $filter = 'none') {
		// depending on filter type, choose the headers
		if ($filter == 'client') {
			$this->tableFormat($entity."s");			
			$this->clientList();
		} else if ($filter == 'invoice') {
			$this->tableFormat("Generate Invoices");
			echo "<form method='post' action='geninvoices.php'>";
			$this->clientList();
		} else {
			$this->tableFormat($entity."s");
		}

		// build the actual table
		$this->buildTable($theaders, $fieldnames, $listdata, $url, $entity, $filter);

		// add buttons at end of table
		$this->footerButtons($url, $entity, $filter);
		
		echo "</form>";
		
	}
	
	private function footerButtons ($url, $entity, $filter) {
/*		
		$filtergetvar = $filter."id";
		if ($filter != 'none' && !empty($_GET[$filtergetvar])) {
			$url = $url."?".$filtergetvar."=".$_GET[$filtergetvar];
		}
*/		
		$clientid = $this->getsetClientId();
		
		// use the entity name to name the "new record" button
		// ensures jquery only run when there is a filter on the page
		if ($entity == 'Invoice') {
			echo "<a href='geninvoices.php' class='btn btn-outline-primary' type='button' role='button'>Generate Invoices</a>";
		} else {
			if ($filter == 'none') {
				echo "<a href='".$url."' class='btn btn-outline-primary' type='button' role='button'>New ".$entity."</a>";
			} elseif ($filter == 'client') {
				echo "<a href='".$url."?clientid=".$clientid."' class='btn btn-outline-primary' id='entitylistnewbutton' type='button' role='button'>New ".$entity."</a>";
			} elseif ($filter == 'invoice') {
				echo "<input type='button' class='btn btn-outline-primary selectallinv' value='Check all' />";
				echo "  <input class='btn btn-outline-primary' type='submit' id='geninvoicebutton' value='Generate Invoices' /> ";
			}
		}			
	}
	
	private function buildTable($theaders, $fieldnames, &$listdata, $url, $entity, $filter)
	{
		echo "<table class='table table-hover table-responsive' id='elementlist'>";
		echo "<thead class='table-primary'><tr>";
			// add <th> element for each table header sent through via the array
			foreach ($theaders as $theader) {
				echo "<th>".$theader."</th>";
			}
			if ($filter == 'invoice') {
				echo "<th></th>";
			}
			echo "</tr></thead><tbody>";
		// for each row of data retrieved from the database
		foreach ($listdata as $datarow) {
			// run through each field name sent through in array
			foreach ($fieldnames as $fieldname) {
				// if the field name matches the entity name plus "id" then treat it as the identifier and use it to send to the details page
				if ($fieldname == strtolower(str_replace(" ", "_", $entity))."_id") {
					$entityid = $datarow[$fieldname];
					echo "<tr data-url='".$url."?".strtolower(str_replace(" ", "", $entity))."id=".$entityid."'>";
				} else {
					// otherwise push the data to a <td> element
					echo "<td>".$datarow[$fieldname]."</td>";
				}
			}
			if ($filter =='invoice') {
				echo "<td class='invcheck'><input class='invcheck' type='checkbox' name='invjob[]' value='".$entityid."' /></td>";
			}
			echo "</tr>";
		} 
		echo "</tbody></table>";
	}

	public function confirmInvoiceTable($invheader, $theaders, &$listdata) {
		$this->tableFormat("Confirm Invoice");
				
		echo "<h5 class='p-2 mb-2 bg-light text-dark'><div class='row'><div class='col'>";
			echo "<b>Client:</b> ".$invheader['client_name'];
		echo "</div><div class ='col'>";
			echo "<b>Inv Num:</b> ".$invheader['invoice_number'];
		echo "</div><div class ='col'>";
			echo "<b>Inv Date:</b> ".$invheader['invoice_date'];
		echo "</div><div class ='col'>";
			echo "<b>Inv Total:</b> ".$invheader['invoice_total'];
		echo "</div></div></h5>";
			
		echo "<table class='table table-responsive'";
		echo "<thead><tr>";
			// add <th> element for each table header sent through via the array
			foreach ($theaders as $theader) {
				echo "<th>".$theader."</th>";
			}
			echo "</tr></thead><tbody>";
			foreach($listdata as $datarow) {
				echo "<tr>";
				foreach ($datarow as $element) {
					echo "<td>".$element."</td>";
				}
				echo "</tr>";
			}
		echo "</tbody></table>";
		
		echo "<form method='post' action='submitinvoice.php'>";
		echo "<input type='hidden' name='tempinvoiceid' value='".$invheader['temp_invoice_id']."' />";
		echo "<input type='hidden' name='newinvoicenum' value='".$invheader['invoice_number']."' />";
		echo "<input type='hidden' name='invconfirmcancel' id='invconfirmcancel' />";
		echo "<br><input type='submit' class='btn btn-outline-primary' id='invconfirm' value='Confirm' />";
		echo "  <input type='submit' class='btn btn-outline-primary' id='invcancel' value='Cancel' /></form>";
		
	}

	
}

?>

