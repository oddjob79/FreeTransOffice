<?php

	require_once('../obj/basepage.inc');
	require_once('../obj/tables.inc');
	
	// instantiate the base page content and display header and menu items
	$contactlistpage = new BasePage();
	$contactlistpage -> Display();
	$contactlistpage -> checkLoggedIn();
	
	$contacttable = new Tables();
	$contacttable -> tableFormat('Contacts');
	
	$sql = new Dbconnect();
	$params = array($_SESSION['domain_id']);
	$out = array();
	$contactlist = $sql->callSP('sp_contact_list', $out, $params);
	
	echo "<table class='table table-hover'>";
		echo "<thead class='table-primary'><tr>";
			echo "<th>First Name</th>";
			echo "<th>Last Name</th>";
			echo "<th>Client</th>";
			echo "<th>Email</th>";
			echo "<th>Phone</th>";
			echo "<th>Status</th>";
			echo "<th>Primary Contact</th>";
		echo "</tr></thead>";
	foreach ($contactlist as $contact) {
		echo "<tr class='clickable-row' data-url='../web/contactdetails.php?contactid=".$contact['contact_id']."'>";
			echo "<td>".$contact['first_name']."</td>";
			echo "<td>".$contact['last_name']."</td>";
			echo "<td>".$contact['client_name']."</td>";
			echo "<td>".$contact['email']."</td>";
			echo "<td>".$contact['phone']."</td>";
			echo "<td>".$contact['status_name']."</td>";
			if ($contact['primary_contact'] == 1) { echo "<td>Y</td>"; } else { echo "<td>N</td>"; }
		echo "</tr>";
	}
	echo "</table>";
	echo "<a href='../web/contactdetails.php' class='btn btn-primary' role='button'>New Contact</a>";
	
	$contactlistpage -> endPage();
?>
	
