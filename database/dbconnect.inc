<?php

class Dbconnect {
	
	protected static $conn;
	
	//make the constructor private and empty so that no code will create an object of this class.
	
	protected function connect() {
		// send config file to $config array
		$config = parse_ini_file('/home/rmturner/config/toconfig.ini');
		if (is_null($config)) {
			print 'Unable to connect to the databse - error reading config file</br>';
		} else {
			$host = $config['server'];
			$dbname = $config['dbname'];
			$username = $config['username'];
			$password = $config['password'];

		try {
			self::$conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
//			echo "Connected to $dbname at $host successfully.</br>";
		} catch (PDOException $pe) {
			die("Could not connect to the database $dbname :" . $pe->getMessage()."</br>");
			}
		}
		return self::$conn;
	}
	
	protected function prepareStatement($spname, &$params) {
		// build question mark parameters for CALL Statement
		$qmstr = '';
		foreach($params as $param) {
			$qmstr .= "?, ";
		}
		// remove last ", " from $qmstr (if $qmstr has a value
		if (strlen($qmstr) > 0) { $qmstr = substr($qmstr, 0, -2); }
		// build prepare statement
		$prepstr = "CALL ".$spname."(".$qmstr.")";
		return $prepstr;
	}
	
	// Generic function which should be usable for all basic read sp's
	// pass in procedure name and all parameters in array in format (datatype, name)
	public function callReadSp($spname, &$params) {

	$prepstr = $this->prepareStatement($spname, $params);
	
	try {
			// connect to db
			$pdo = $this->connect();
			
			// prepare call statement
			$sql = $pdo->prepare($prepstr);
			
			// execute prepared statement
			$sql->execute($params);
			
			// write results to $row array
			$row = $sql->fetchAll(PDO::FETCH_ASSOC);
			
		} 	catch (PDOException $e) {
			die ("Error occurred: " . $e->getMessage());
		}
		return $row;
	}

	public function returnFirstRow($row) {
		$i=0;
		foreach ($row as $result) {
			if ($i==0) {
				return $result;
			}
			$i++;
		}
	}
	
}
	

?>