<?php

require_once('htmlform.inc');

class PackagesForm extends HtmlForm {
	
	public function showPackagesForm() {

		// retrieve the package id from the URL and pass to $getvalues
		$getnames = array('packageid');
		$getvalues = $this -> getGetValues($getnames);
	
		// retrieve package details
		$sql = new Dbconnect();
		if (!empty($getvalues['packageid'])) {
			$packagedata = $sql->getEntityDetails($getvalues, 'sys_packages_read');
		}

		// form header and format are set
		$this->formFormat('Packages');
		
		// set array to "select all" -1 and domain_id to retrieve all records for this domain only
		$domparams = array("-1", $_SESSION['domain_id']);
		$out = array();
		$packages = $sql->callSP('sys_packages_read', $out, $domparams);

		$this -> packagesFormBuilder($packagedata, $packages);
		
	}

	private function packagesFormBuilder(&$packagedata, &$packages) {
	
		echo "<form method='post' action='packages.php'>";
		echo "<div class='form-group'>";	
		
		// package	
		echo "<div class='row'>\n<div class='col-6 settingsview'>";
		// only shown in view mode
			echo "<p>Package: <select class='form-control settingsselectors' name='package'>";
			echo "<option value=''></option>";
				foreach ($packages as $package) {
					$getpack = (empty($_GET['packageid'])) ? '' : $_GET['packageid'];
					if ($package['package_id'] == $getpack) {
						echo "<option value=".$package['package_id']." selected='selected'>".$package['package_name']."</option>";
					} else {
						echo "<option value=".$package['package_id'].">".$package['package_name']."</option>";
					}
				} 
			echo "</select></p>";
			echo "<p><input type='hidden' name='settingsdomainid' value='".$packagedata['domain_id']."' /></p>";
		echo "</div>";
		// only shown in edit mode
		echo "<div class='col-6 settingsedit' style='display: none;'>";		
			echo "<p>Package: (required)<input class='form-control' type='text' name='packagename' value='".$packagedata['package_name']."' size='80' required = 'true' maxlength='100' /></p>";
			echo "<p><input class='form-control' type='hidden' name='recordid' value='".$packagedata['package_id']."' /></p>";
		echo "</div></div>";
		
		// Notes
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Notes: <textarea class='form-control settingfield' name='packagenotes' rows='5' cols='30' readonly>".$packagedata['notes']."</textarea></p>";
		echo "</div></div>";
		
		// New / Edit buttons - only shown when in 'view' mode
		echo "<div class='row'>\n<div class='col-auto mr-auto settingsview'>";
			echo "<input class='btn btn-outline-primary' type='button' value='New' name='newsettingsbtn' /> ";
			echo " <input class='btn btn-outline-primary' type='button' value='Edit' name='editsettingsbtn' />";
		echo "</div></div>";
		
		// save / reset / cancel buttons - only shown when in edit mode	
		echo "<div class='row settingsedit' style='display: none;'>\n<div class='col-auto mr-auto'>";		
			echo "</br><input class='btn btn-outline-primary' type='submit' value='Save' /> ";
		echo "</div><div class='col-auto settingsedit'>";
			echo "<br> <input class='btn btn-outline-primary' type='reset' value='Reset' /> ";
			echo " <a class='btn btn-outline-primary' href='../web/packages.php?packageid=".$packagedata['package_id']."' role='button'>Cancel</a> ";
		echo "</div></div></div></form>";
	}	

}

?>