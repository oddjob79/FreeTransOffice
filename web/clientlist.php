<?php

	require_once('../obj/basepage.inc');
	require_once('../database/dbconnect.inc');
	require_once('../obj/tables.inc');
	
	// instantiate the base page content and display header and menu items
	$clientlistpage = new BasePage();
	$clientlistpage -> Display();
	$clientlistpage -> checkLoggedIn();
	
	$clienttable = new Tables();
	$clienttable -> tableFormat('Clients');
	
	$sql = new Dbconnect();
	$params = array($_SESSION['domain_id']);
	$clientlist = $sql->callReadSp('sp_client_list', $params);
	
	echo "<table class='table table-hover'>";
		echo "<thead class='table-primary'><tr>";
			echo "<th>Client Names</th>";
			echo "<th>City</th>";
			echo "<th>Country</th>";
			echo "<th>Currency</th>";
			echo "<th>Status</th>";
			echo "<th>Last Completed Job</th>";
			echo "<th>Last Invoice</th>";
		echo "</tr></thead>";
	foreach ($clientlist as $client) {
		echo "<tr class='clickable-row' data-url='../web/clientdetails.php?clientid=".$client['client_id']."'>";
			echo "<td>".$client['client_name']."</td>";
			echo "<td>".$client['city']."</td>";
			echo "<td>".$client['country_name']."</td>";
			echo "<td>".$client['currency_code']."</td>";
			echo "<td>".$client['status_name']."</td>";
			echo "<td>".substr($client['last_completed_job'],0, 10)."</td>";
			echo "<td>".substr($client['last_invoice'],0, 10)."</td>";
		echo "</tr>";
	}
	echo "</table>";
	echo "<a href='../web/newclient.php' class='btn btn-primary' role='button'>New Client</a>";
	$clientlistpage -> endPage();
?>
	
<!--
<script type="text/javascript">

	// snippet below allows table row to become clickable and create a link from the whole row
	
	jQuery(document).ready(function($) {
	$(".clickable-row").click(function() {
		window.location = $(this).data("url");
		});
	});
	
	
</script>
-->