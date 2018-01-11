<?php

class Dbconnect {
	
	protected static $conn;
	
	//make the constructor private and empty so that no code will create an object of this class.
	
	protected function connect() {
		// send config file to $config array
		$config = parse_ini_file('/home/rmturner/config/toconfig.ini');
		if (is_null($config)) {
			print 'Unable to connect to the database - error reading config file</br>';
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
	
	protected function execStatement($spname, &$outparams, &$params) {

		// make sure array is set as an ordinal array as we are using positional parameters
		$params = array_values($params);
		
		// build question mark parameters for CALL Statement
		$qmstr = '';
		foreach($params as $param) {
			$qmstr .= "?, ";
		}
		// remove last ", " from $qmstr (if $qmstr has a value)
		if (strlen($qmstr) > 0) { $qmstr = substr($qmstr, 0, -2); }


		// build prepare statement based on existence of OUT parameters in SP
		if (!empty($outparams)) {
			$prepstr = "CALL ".$spname."(".implode(",", $outparams).", ".$qmstr.")";
		} else {
			$prepstr = "CALL ".$spname."(".$qmstr.")";
		}
		
		// debugging
//		 echo "prepstr ".$prepstr."<br>";
//		 print_r($params);

		try {
		
			// connect to db
			$pdo = $this->connect();
			
			// prepare call statement
			$sql = $pdo->prepare($prepstr);

			// execute prepared statement
			$sql->execute($params);
			
		} catch (PDOException $e) {
			echo $e;
		}
			
		return $sql;
	}

	
	// Generic function which should be usable for all basic insert, update & read sp's
	// pass in procedure name and all parameters in array
	public function callSP($spname, &$outparams, &$params) {
		
		try {
			// call execution method
			$sql = $this->execStatement($spname, $outparams, $params);
		} catch (PDOException $e) {
			echo "SQL EXECUTION ERROR: ".$e."<br>";
		}

		// debug
//		print_r($sql->errorInfo()); echo"<br>";
		
		// write results to $row array
		$result = $sql->fetchAll(PDO::FETCH_ASSOC);
		return $result;
	}	
	
	public function returnFirstRow($result) {
		$i=0;
		foreach ($result as $row) {
			if ($i==0) {
				return $row;
			}
			$i++;
		}
	}
	
	// move from here (Dbconnect probably)
	public function getEntityDetails(&$getvalues, $spname) {
		// set parameters for sp (implode value(s) retrieved from _GET)
		array_push($getvalues, $_SESSION['domain_id']);
		$out = array();
		// call client details sp
		$datadets = $this->callSP($spname, $out, $getvalues);
		// add results to array
		$datarow = $this->returnFirstRow($datadets);
		return $datarow;
	}	
	
}
	

?>