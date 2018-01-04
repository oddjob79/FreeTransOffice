<?php

require_once('htmlform.inc');

class JobTypeForm extends HtmlForm {
	
	public function showJobTypeForm() {

		// retrieve the job type id from the URL and pass to $getvalues
		$getnames = array('jobtypeid');
		$getvalues = $this -> getGetValues($getnames);
	
		// retrieve job type details
		$sql = new Dbconnect();
		if (!empty($getvalues['jobtypeid'])) {
			$jobtypedata = $sql->getEntityDetails($getvalues, 'sys_job_types_read');
		}

		// form header and format are set
		$this->formFormat('Job Type');
		
		// set array to "select all" -1 and domain_id to retrieve all records for this domain only
		$domparams = array("-1", $_SESSION['domain_id']);
		$out = array();
		$jobtypes = $sql->callSP('sys_job_types_read', $out, $domparams);

		$this -> jobtypeFormBuilder($jobtypedata, $jobtypes);
		
	}

	private function jobtypeFormBuilder(&$jobtypedata, &$jobtypes) {
	
		echo "<form method='post' action='jobtypes.php'>";
		echo "<div class='form-group'>";
		
		// Job Type
		echo "<div class='row'>\n<div class='col-6 settingsview'>";
		// only shown in view mode
			echo "<p>Job Type: <select class='form-control settingsselectors' name='jobtypeid'>";
				echo "<option value=''></option>";			
				foreach ($jobtypes as $jobtype) {
					$getjobtype = (empty($_GET['jobtypeid'])) ? '' : $_GET['jobtypeid'];
					if ($jobtype['job_type_id'] == $getjobtype) {
						echo "<option value=".$jobtype['job_type_id']." selected='selected'>".$jobtype['job_type']."</option>";
					} else {
						echo "<option value=".$jobtype['job_type_id'].">".$jobtype['job_type']."</option>";
					}
				} 
			echo "</select></p>";
//		echo "</div></div>";
//		if (!empty($jobtypedata['domain_id'])) {
			echo "<p><input type='hidden' name='settingsdomainid' value='".$jobtypedata['domain_id']."' /></p>";
//		}
		echo "</div>";
		// only shown in edit mode
		echo "<div class='col-6 settingsedit' style='display: none;'>";		
			echo "<p>Job Type: <input class='form-control' type='text' name='jobtypename' value='".$jobtypedata['job_type']."' size='40' required = 'true' maxlength='40' /></p>";
			echo "<p><input class='form-control' type='hidden' name='recordid' value='".$jobtypedata['job_type_id']."' /></p>";
		echo "</div></div>";
		
		// Words Per Hour
		echo "<div class='row'>\n<div class='col-6'>";		
			echo "<p>Words Per Hour: <input class='form-control settingfield' type='number' name='wordsperhour' value='".$jobtypedata['words_per_hour']."' size='40' readonly maxlength='11' /></p>";
		echo "</div></div>";		
		
		// Notes
		echo "<div class='row'>\n<div class='col'>";
			echo "<p>Notes: <textarea class='form-control settingfield' name='jobtypenotes' rows='5' cols='30' readonly>".$jobtypedata['notes']."</textarea></p>";
		echo "</div></div>";
		
		
		// New / Edit buttons - only shown when in 'view' mode
		echo "<div class='row'>\n<div class='col-auto mr-auto settingsview'>";
			echo "<input class='btn btn-outline-primary' type='button' value='New' name='newsettingsbtn' /> ";
			echo " <input class='btn btn-outline-primary' type='button' value='Edit' name='editsettingsbtn' />";
		echo "</div></div>";
		
		// save / reset / cancel buttons - only shown when in edit mode	
		echo "<div class='row settingsedit' style='display: none;'>\n<div class='col-auto mr-auto'>";		
			echo "</br><input class='btn btn-outline-primary' type='submit' value='Save' /> ";
		echo "</div><div class='col-auto'>";
			echo "<br> <input class='btn btn-outline-primary' type='reset' value='Reset' /> ";
			echo " <a class='btn btn-outline-primary' href='../web/jobtypes.php?jobtypeid=".$jobtypedata['job_type_id']."' role='button'>Cancel</a> ";
		echo "</div></div></div></form>";
	}	

}

?>