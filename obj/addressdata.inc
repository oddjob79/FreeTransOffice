<?php
require_once('htmlform.inc');

class AddressData extends HtmlForm {
	
	private $emptyarr = array();
	
	// stores all the posted address info in an array, together with the domain_id
	public function getAddressPostedInfo() {
		$addressarr = array("address1", "address2", "city", "state", "postcode", "region", "county", "country");
		$postedvalues = $this->getPostedValues($addressarr, true);
		//$postedvalues = $this->addDomainIdToArray($postedvalues);
		return $postedvalues;
	}

	// if address_1, city & country not entered - return false
	private function addressValidation($addrposted) {
		if (!empty($addrposted['address1']) && !empty($addrposted['country']) && !empty($addrposted['city'])) {
			return true;
		}
//		echo "Incomplete Address Information - Address not added<br><br>";
		return false;
	}
	
	// inserts the address info and returns the newly added address_id
	private function insertAddress($addrposted) {
		
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

	private function updateAddress($addrposted) {
		// don't go any further if required data not included
		if ($this->addressValidation($addrposted) === false) {
			return;
		} else {
			$sql = new Dbconnect();
			$out = array();
			$updateaddr = $sql->callSP('sys_addresses_update', $out, $addrposted);
			// cleanup query variables
			$sql=""; $updateaddr=""; $addrposted="";
		}
	}
	
	
	private function addressLookup($addrposted) {
		$addrkeyfields = array($_SESSION['domain_id'],
							$addrposted['address1'],
							$addrposted['city'],
							$addrposted['country']);
		$sql = new Dbconnect();							
		$result = $sql->callSP('sp_address_lookup', $emptyarr, $addrkeyfields);
		$addresult = $sql->returnFirstRow($result);
		
		return $addresult;
	}
		
	public function addressInsertUpdate($addrposted) {
		// check to see if address exists already
		$addresult = $this->addressLookup($addrposted);
		
		// if no address was found during lookup, insert new address and return the newly created address id
		if (empty($addresult)) {
			return $this->insertAddress($addrposted);
		} else {
			// check if non-key fields match between entered data and stored address data (address2, region, postalcode)
			if ($addresult['address_2'] == $addrposted['address2'] && $addresult['postalcode'] == $addrposted['postcode'] &&  $addresult['region'] == $addrposted['region']) {
				// return address_id
				return $addresult['address_id'];
			// if non-key fields do not match, update existing record with new information
			} else {
				array_unshift($addrposted, $addresult['address_id']);
				$this->updateAddress($addrposted);
				return $addresult['address_id'];
			}
		}
	}
		

	
}

?>