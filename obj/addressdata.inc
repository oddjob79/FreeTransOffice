<?php
require_once('htmlform.inc');

class AddressData extends HtmlForm {
	
		// stores all the posted address info in an array, together with the domain_id
	public function getAddressPostedInfo() {
		$addressarr = array("address1", "address2", "city", "state", "postcode", "region", "county", "country");
		$postedvalues = $this->getPostedValues($addressarr, true);
		//$postedvalues = $this->addDomainIdToArray($postedvalues);
		return $postedvalues;
	}

	// if address_1, city & country not entered - return false
	private function addressValidation($addrposted) {
		if (!empty($addrposted['address1']) and !empty($addrposted['country']) and !empty($addrposted['city'])) {
			return true;
		}
		echo "Incomplete Address Information - Address not added<br><br>";
		return false;
	}
	
	// inserts the address info and returns the newly added address_id
	public function insertAddress($addrposted) {
		
		// don't go any further if required data not included
		if ($this->addressValidation($addrposted) === false) {
			return;
		} else {
		
			// instantiate the dbconnect class, set the output variable array and call the insert sp
			$sql = new Dbconnect();
			$out = array("@u_address_id");
			$newrecord = $sql->callSP('sys_addresses_create', $out, $addrposted);
			
			// check if a new record was created. If so, return the newly created Address ID 
			if (!empty($newrecord)) {
				$addressrow = $sql->returnFirstRow($newrecord);
				return $addressrow['u_address_id'];
			} else {
				echo "There was an address add problem.<br><br>";
			}
			// cleanup query variables
			$sql=""; $out=""; $newrecord=""; $addrposted="";

		}
	}

	public function updateAddress($addrposted) {
		// don't go any further if required data not included
		if ($this->addressValidation($addrposted) === false) {
			return;
		} else {
			$sql = new Dbconnect();
			$out = array();
			$updateaddr = $sql->callSP('sys_addresses_update', $out, $addrposted);
			// cleanup query variables
			$sql=""; $out=""; $updateaddr=""; $addrposted="";
		}
	}

	
}

?>