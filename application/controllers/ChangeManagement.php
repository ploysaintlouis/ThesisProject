<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
* Change Management Controller
**/
class ChangeManagement extends CI_Controller{
	
	function __construct(){
		parent::__construct();
		$this->load->model('RTM_model', 'mRTM');
		$this->load->model('Project_model', 'mProject');
		$this->load->model('TestCase_model', 'mTestCase');
		$this->load->model('DatabaseSchema_model', 'mDB');
		$this->load->model('Miscellaneous_model', 'mMisc');
		$this->load->model('ChangeManagement_model', 'mChange');
		$this->load->model('FunctionalRequirement_model', 'mFR');

		$this->load->library('form_validation', null, 'FValidate');
		$this->load->library('session');
	}

	public function index(){
		$data['error_message'] = '';
		$data['resultList'] = null;
		$this->openView($data, 'search');
	}

	public function search(){
		$error_message = '';
		$result = null;

		$projectId = $this->input->post('inputProject');
		$this->FValidate->set_rules('inputProject', null, 'required');
		if($this->FValidate->run()){
			$param = (object) array('projectId' => $projectId, 'status' => ACTIVE_CODE);
			$result = $this->mFR->searchFunctionalRequirementHeaderInfo($param);
			
			if(0 == count($result)){
				$error_message = ER_MSG_006;
			}

			$data['selectedProjectId'] = $projectId;
		}
		$formObj = (object) array('projectId' => $projectId);
		$data['formData'] = $formObj;
		$data['functionList'] = $result;
		$data['error_message'] = $error_message;
		$this->openView($data, 'search');
	}

	function viewFunctionDetail($projectId, $functionId){
		//var_dump(str_replace("{0}", "Database Schema", ER_MSG_016));
		$this->reloadPage('', $projectId, $functionId);
	}

	function checkRelatesOtherFRs(){
		$output = "N";
		$functionId = $this->input->post('functionId');
		$functionVersion = $this->input->post('functionVersion');
		$userId = $this->session->userdata('userId');

		if(!empty($functionVersion) && !empty($functionId)){
			$param = (object) array(
				'userId' => $userId,
				'functionId' => $functionId,
				'functionVersion' => $functionVersion);
			$result = $this->mChange->searchRelatedChangeFRInputs($param);
			if(null != $result && 0 < count($result)){
				$output = "Y";
			}
		}
		echo $output;
	}

	function updateTempFRChangeList($projectId,$functionId,$functionVersion){

			$rowResult = $this->mChange->updateTempFRInputChangeList($functionId,$functionVersion);
			if(0 < $rowResult){
				echo "<script type='text/javascript'>alert('Save Successful!')</script>";
				//redirect ( "index.php/ChangeManagement/viewFunctionDetail/" + $projectId + "/" + $functionId);
				//$url = "index.php/ChangeManagement/viewFunctionDetail/" + $projectId + "/" + $functionId;
				$this->reloadPage('', $projectId, $functionId,$functionVersion);
			}else{
				echo "error";
			}
	}

	function doChangeProcess(){ //requestChangeFRInputs
		$errorFlag = false;
		$success_message = '';
		$error_message = '';

		$functionNo = '';
		$changeRequestNo = '';
		$userId = $this->session->userdata('userId');
		$projectId = $this->input->post('projectId');
		$functionId = $this->input->post('functionId');
		$functionVersion = $this->input->post('functionVersion');

		//$this->load->library('common');
		//echo $functionId;
		try{
			/** 1.Validate
			*** 1.1 Check Temp Change List Data
			**/
			$criteria = (object) array('userId' => $userId, 'functionId' => $functionId, 'functionVersion' => $functionVersion);
			$resultExistTempChangeList = $this->mChange->searchTempFRInputChangeList($criteria);
			if(null == $resultExistTempChangeList || 0 == count($resultExistTempChangeList)){
				$error_message = ER_TRN_010;
				$this->reloadPage($error_message, $projectId, $functionId, $functionVersion);
				return false;
			}

			/* 1.2 Check status of Requirement Header */
			$criteria->status = '1';
			$resultReqHeader = $this->mFR->searchFunctionalRequirementHeaderInfo($criteria);
			if(null == $resultReqHeader || 0 == count($resultReqHeader)){
				$error_message = ER_TRN_011;
				$this->reloadPage($error_message, $projectId, $functionId, $functionVersion);
				return false;
			}else{
				$functionNo = $resultReqHeader[0]['functionNo'];
			}

			/** 2.Call Change API */
			$param = (object) array(
				'projectId' 	  => $projectId,
				'functionId' 	  => $functionId,
				'functionNo' 	  => $functionNo,
				'functionVersion' => $functionVersion,
				'changeRequestNo' => '',
				'userId'		  => $userId,
				'type' 	 		  => 1 //1 = Change, 2 = Cancel
				);
			$changeResult = $this->callChangeAPI($param);
			
			/** 3.Control Version*/
			/** 4.Save Change Request */
			/** 5.Save Change History */
			//echo $changeResult;
			//echo $projectId;
			
			if(null != $changeResult && !empty($changeResult)){
				//if('Y' == $changeResult->result->isSuccess){
					$user = $this->session->userdata('username');
					$staffflag = $this->session->userdata('staffflag');

					$changeInfo = (object) array(
						'userId' => $userId,
						'projectId' => $projectId,
						'functionId' => $functionId,
						'functionVersion' => $functionVersion,
						'staffflag' => $staffflag);
//echo $projectId;
					$projectInfo = $this->mProject->searchProjectDetail($projectId);
					$result = $this->mChange->changeProcess($changeInfo, $changeResult, $projectInfo, $user, $error_message, $changeRequestNo);

					if($result == true){ //Change success
						
						/** 6.Remove Test Change list */
						$paramDelete = (object) array(
							'userId' => $userId,
							'functionId' => $functionId,
							'functionVersion' => $functionVersion);
						$this->mChange->deleteTempFRInputChangeList($paramDelete);

						/** 7.Display Result */
						$this->displayChangeResult($changeRequestNo);
						return false;
					}
				//}else{
				//	$error_message = $changeResult->result->error_message;
				//}
			}else{
				$errorFlag = true;
				$error_message = str_replace("{0}", "Request Web Service", ER_MSG_016);
			}

		}catch(Exception $e){
			$errorFlag = true;
			$error_message = $e;
		}

		$data['success_message'] = $success_message;
		$data['error_message'] = $error_message;
		$this->reloadPage($error_message, $projectId, $functionId, $functionVersion);	
	}

	//When Successfully change Functional Requirement's Inputs
	function displayChangeResult($changeRequestNo = ''){
		$success_message = '';
		$error_message = '';
		$changeRequestInfo = array();
		$changeInputList = array();

		$affectedRTM = array();
		$affectedFnReqList = array();
		$affectedSchemaList = array();
		$affectedTestCaseList = array();

		if(!empty($changeRequestNo)){
			//1.Get Change Information
			$changeRequestInfo = $this->mChange->getChangeRequestInformation($changeRequestNo);
			if(0 == count($changeRequestInfo)){
				$error_message = ER_MSG_017;
			}else{
				$changeInputList = $this->mChange->getChangeRequestInputList($changeRequestNo);
				$affectedFnReqList = $this->mChange->getChangeHistoryFnReqHeaderList($changeRequestNo);
				$affectedSchemaList = $this->mChange->getChangeHistoryDatabaseSchemaList($changeRequestNo);
				$affectedTestCaseList = $this->mChange->getChangeHistoryTestCaseList($changeRequestNo);
				$affectedRTM = $this->mChange->getChangeHistoryRTM($changeRequestNo);

				$success_message = IF_MSG_002;
			}
		}else{
			$error_message = ER_MSG_011;
		}

		$data['changeInfo'] = $changeRequestInfo;
		$data['changeInputList'] = $changeInputList;
		$data['affectedRTM'] = $affectedRTM;
		$data['affectedFnReqList'] = $affectedFnReqList;
		$data['affectedSchemaList'] = $affectedSchemaList;
		$data['affectedTestCaseList'] = $affectedTestCaseList;

		$data['success_message'] = $success_message;
		$data['error_message'] = $error_message;
		$this->openView($data, 'result');
	}

	function reloadPage($errorMessage, $projectId, $functionId, $functionVersion = ''){
		$resultHeader = array();
		$resultList = array();
		$inputChangeList = array();

		$userId = $this->session->userdata('userId'); //echo $_SESSION['userId'] ;
		$staffflag = $this->session->userdata('staffflag'); //echo $_SESSION['staffflag'] ;
		
		if(!empty($projectId) && !empty($functionId)){
			$projectInfo = $this->mProject->searchProjectDetail($projectId);
			$data['projectInfo'] = $projectInfo;
			
			$param = (object) array('projectId' => $projectId, 'functionId' => $functionId);
			$resultList = $this->mFR->searchFunctionalRequirementDetail($param);

			if(null != $resultList && 0 < count($resultList)){
				
				$resultHeader = (object) array(
				'functionId' => $resultList[0]['functionId'],
				'functionNo' => $resultList[0]['functionNo'],
				'functionDescription' => $resultList[0]['functionDescription'],
				'functionVersion' => $resultList[0]['functionVersion'],
				'schemaVersionId' => $resultList[0]['schemaVersionId']);

				$functionVersion = (!empty($functionVersion)? $functionVersion : $resultList[0]['functionVersion']);

				//get temp change list
				$criteria = (object) array('userId' => $userId, 'functionId' => $functionId, 'functionVersion' => $functionVersion);
				$inputChangeList = $this->mChange->searchTempFRInputChangeList($criteria);
			}else{
				$error_message = ER_MSG_012;
			}
		}else{
			$error_message = ER_MSG_011;
		}

		$hfield = array('projectId' => $projectId, 'functionId' => $functionId, 'functionVersion' => $functionVersion);
		$data['hfield'] = $hfield;
		$data['error_message'] = $errorMessage;
		$data['resultHeader'] = $resultHeader;
		$data['resultDetail'] = $resultList;
		$data['staffflag'] = $staffflag;
		$data['inputChangeList'] = $inputChangeList;
		$this->openView($data, 'detail');
	}

	function addFRInputDetail(){
		$output = '';
		var_dump($this->input->post('projectId'));
		var_dump($this->input->post('functionId'));
		var_dump($this->input->post('functionVersion'));
		var_dump($this->input->post('schemaVersionId'));
	
		$projectId = $this->input->post('projectId');
		$functionId = $this->input->post('functionId');
		$functionVersion = $this->input->post('functionVersion');
		$schemaVersionId = $this->input->post('schemaVersionId');

		$param = array(
			'projectId' => $projectId,
			'functionId' => $functionId,
			'functionVersion' => $functionVersion,
			'typeData' => '',
			'dataId' => '',
			'dataName' => '',
			'schemaVersionId' => $schemaVersionId,
			'dataType' => '',
			'dataLength' => '',
			'decimalPoint' => '',
			'constraintUnique' => '', 
			'constraintNull' => '',
			'constraintDefault' => '',
			'constraintMinValue' => '',
			'constraintMaxValue' => '',
			'refTableName' => '',
			'refColumnName' => ''
		);

		$output = $this->setFRInputDetailForm($param, CHANGE_TYPE_ADD);
		echo $output;
	}

	function viewFRInputDetail(){
		$output = '';
		$keyId = $this->input->post('keyId');
		//var_dump($keyId);
		if(null !== $keyId && !empty($keyId)){
			$keyList = explode("|", $keyId);
			//inputid
			
			$param = (object) array('projectId' => $keyList[0], 'dataId' => $keyList[1], 'schemaVersionId' => $keyList[2], 'functionId' => $keyList[3], 'typeData' => $keyList[4]);

			$result = $this->mFR->searchFunctionalRequirementDetail($param);

			if(0 < count($result)){
				$row = $result[0];
				$output = $this->setFRInputDetailForm($row, CHANGE_TYPE_EDIT);
			}
			echo $output;
		}
	}

	function setFRInputDetailForm($row, $mode){
		//set Data Type combo
		$dataTypeList = $this->mMisc->searchMiscellaneous(MISC_DATA_INPUT_DATA_TYPE, '');
		$dataTypeCombo = '
			<select name="inputDataType" id="inputDataType" class="form-control">
				<option value="">--Select Data Type--</option>';
		foreach ($dataTypeList as $value) {
			$dataTypeCombo .= '<option value="'.$value['miscValue1'].'">'.$value['miscValue1'].'</option>';
		}
		$dataTypeCombo .= '</select>';

		$checkUnique = ($row["constraintUnique"] == "Y")? 'checked' : '';
		$checkNotNull = ($row["constraintNull"] == "Y")? 'checked' : '';

		$displayFlag = (CHANGE_TYPE_ADD == $mode)? 'block': 'none';
		$requiredField = (CHANGE_TYPE_ADD == $mode)? '<span style="color:red;">*</span>': '';

		if ($row["typeData"] == 1 ) {
			$displayInput = 'Input Name';
		} else {
			$displayInput = 'Output Name';
		}
		//echo $_SESSION['userId'] ;

		if (CHANGE_TYPE_ADD == $mode) {
			$resultList = $this->mFR->searchLatestFunctionalRequirementMaxId();
			$row["dataId"] = $resultList + 1 ;
		}
		
//modify 20181217 add output
	if($mode == "edit" ){
		$output = '
			<input type="hidden" name="changeProjectId" id="changeProjectId" value="'.$row["projectId"].'">
			<input type="hidden" name="changeType" id="changeType" value="'.$mode.'">
			<input type="hidden" name="changeFunctionId" id="changeFunctionId" value="'.$row["functionId"].'">
			<input type="hidden" name="changeFunction" id="changeFunction" value="'.$row["functionVersion"].'">
			<input type="hidden" name="changedataId" id="changedataId" value="'.$row["dataId"].'">
			<input type="hidden" name="changetypeData" id="changetypeData" value="'.$row["typeData"].'">  
			<input type="hidden" name="changeSchemaVersionId" id="changeSchemaVersionId" value="'.$row["schemaVersionId"].'">
			<input type="hidden" name="userId" id="userId"  value="'.$_SESSION['userId'].'">
			<input type="hidden" name="user" id="user"  value="'.$_SESSION['username'].'">

			<input type="hidden" name="oldDataType" id="oldDataType"	value="'.$row["dataType"].'">
			<input type="hidden" name="oldDataLength" id="oldDataLength"	value="'.$row["dataLength"].'">
			<input type="hidden" name="oldScale" 	id="oldScale"	value="'.$row["decimalPoint"].'">
			<input type="hidden" name="oldDefaultValue" id="oldDefaultValue" value="'.$row["constraintDefault"].'">
			<input type="hidden" name="oldMin" id="oldMin"	value="'.$row["constraintMinValue"].'">
			<input type="hidden" name="oldMax" 	id="oldMax" value="'.$row["constraintMaxValue"].'">
			<input type="hidden" id="oldNotNullValue" name="oldNotNullValue" value="'.$row["constraintNull"].'">
			<input type="hidden" id="oldUniqueValue" name="oldUniqueValue" value="'.$row["constraintUnique"].'">
			<input type="hidden" id="inputTableName" name="inputTableName" value="'.$row["refTableName"].'">
			<input type="hidden" id="inputColumnName" name="inputColumnName" value="'.$row["refColumnName"].'">

			<table style="width:100%">
			<tr height="40">

				<td>
					<label >'.$displayInput.' : '.$requiredField.'
					<p class="text-green" style="margin:0;">'.$row["dataName"].'</p>
					</label>
				</td>
				
				<td>
					<input type="text" name="dataName" id="dataName" class="form-control" value="'.$row["dataName"].'" maxlength="'.MAX_INPUT_NAME.'" />
				</td>	

			</tr>
			<tr height="40">
				<td>
					<label>Data Type: '.$requiredField.'
					<p class="text-green" style="margin:0;">'.$row["dataType"].'</p>
					</label>
				</td>
				<td>
					'.$dataTypeCombo.'
				</td>
			</tr>
			<tr height="40">
				<td>
					<label>Data Length: 
					<p class="text-green" style="margin:0;">'.$row["dataLength"].'</p>
					</label>
				</td>
				<td>
					<input type="number" min="1" step="1" name="inputDataLength" id="inputDataLength" class="form-control"/>
				</td>
			</tr>
			<tr height="40">
				<td>
					<label>Scale (if any*)
					<p class="text-green" style="margin:0;">'.$row["decimalPoint"].'</p>
					</label>
				</td>
				<td>
					<input type="number" min="1" step="1" name="inputScale" id="inputScale" class="form-control" placeholder="Enter when data Type is \'Decimal\'"/>
				</td>
			</tr>
			<tr height="40">
				<td>&nbsp;</td>
				<td>
					<div class="checkbox">
						<label style="font-weight:700;">
						<input type="checkbox" id="inputUnique" name="inputUnique[]" value="Y" '.$checkUnique.' >Unique
						<p class="text-green" style="margin:0;">'.$row["constraintUnique"].'</p>
						</label>

						&nbsp;&nbsp;
						
						<label style="font-weight:700;">
						<input type="checkbox" id="inputNotNull" name="inputNotNull[]" value="Y" '.$checkNotNull.' >NOT NULL
						<p class="text-green" style="margin:0;">'.$row["constraintNull"].'</p>
						</label>
					</div>
				</td>
			</tr>
			<tr height="40">
				<td>
					<label>Default Value:
					<p class="text-green" style="margin:0;">'.$row["constraintDefault"].'</p>
					</label>
				</td>
				<td>
					<input type="text" id="inputDefault" name="inputDefault" class="form-control"/>
				</td>
			</tr>
			<tr height="40">
				<td>
					<label>Min Value:
					<p class="text-green" style="margin:0;">'.$row["constraintMinValue"].'</p>
					</label>
				</td>
				<td>
					<input type="number" step="0.01" id="inputMinValue" name="inputMinValue" class="form-control"/>
				</td>
			</tr>
			<tr height="40">
				<td>
					<label>Max Value:
					<p class="text-green" style="margin:0;">'.$row["constraintMaxValue"].'</p>
					</label>
				</td>
				<td>
					<input type="number" step="0.01" id="inputMaxValue" name="inputMaxValue" class="form-control"/>
				</td>
			</tr>
			<tr height="40">
				<td>
					<label>Table Name: '.$requiredField.'
					<p class="text-green" style="margin:0;">'.$row["refTableName"].'</p>
					</label>
				</td>
			</tr>
			<tr height="40">
				<td>
					<label>Column Name: '.$requiredField.'
					<p class="text-green" style="margin:0;">'.$row["refColumnName"].'</p>
					</label>
				</td>
			</tr>
			</table>';
		}else {
			$output = '
				<input type="hidden" name="changeProjectId" id="changeProjectId" value="'.$row["projectId"].'">
				<input type="hidden" name="changeType" id="changeType" value="'.$mode.'">
				<input type="hidden" name="changeFunctionId" id="changeFunctionId" value="'.$row["functionId"].'">
				<input type="hidden" name="changeFunction" id="changeFunction" value="'.$row["functionVersion"].'">
				<input type="hidden" name="changedataId" id="changedataId" value="'.$row["dataId"].'">
	
				<input type="hidden" name="changeSchemaVersionId" id="changeSchemaVersionId" value="1">
	
				<input type="hidden" name="userId" id="userId"  value="'.$_SESSION['userId'].'">
				<input type="hidden" name="user" id="user"  value="'.$_SESSION['username'].'">
	
				<input type="hidden" name="oldDataType" id="oldDataType"	value="'.$row["dataType"].'">
				<input type="hidden" name="oldDataLength" id="oldDataLength"	value="'.$row["dataLength"].'">
				<input type="hidden" name="oldScale" 	id="oldScale"	value="'.$row["decimalPoint"].'">
				<input type="hidden" name="oldDefaultValue" id="oldDefaultValue" value="'.$row["constraintDefault"].'">
				<input type="hidden" name="oldMin" id="oldMin"	value="'.$row["constraintMinValue"].'">
				<input type="hidden" name="oldMax" 	id="oldMax" value="'.$row["constraintMaxValue"].'">
				<input type="hidden" id="oldNotNullValue" name="oldNotNullValue" value="'.$row["constraintNull"].'">
				<input type="hidden" id="oldUniqueValue" name="oldUniqueValue" value="'.$row["constraintUnique"].'">
	
				<table style="width:100%">
				<tr height="40">
		
					<td>
						<div class="radio">
							<label style="font-weight:700;">
							<input type="radio" id="changetypeData" name="changetypeData" value="1">Input Name
							</label>
	
							&nbsp;&nbsp;
							
							<label style="font-weight:700;">
							<input type="radio" id="changetypeData" name="changetypeData" value="2">Output Name
							</label>
	
						</div>
					</td>	
					<td>'.$row["typeData"].'
						<input type="text" name="dataName" id="dataName" class="form-control" style="display:'.$displayFlag.'" maxlength="'.MAX_INPUT_NAME.'" />
					</td>	
				</tr>
				<tr height="40">
					<td>
						<label>Data Type: '.$requiredField.'
						<p class="text-green" style="margin:0;"></p>
						</label>
					</td>
					<td>
						'.$dataTypeCombo.'
	
					</td>
				</tr>
				<tr height="40">
					<td>
						<label>Data Length: 
						<p class="text-green" style="margin:0;"></p>
						</label>
					</td>
					<td>
						<input type="number" min="1" step="1" name="inputDataLength" id="inputDataLength" class="form-control"/>
					</td>
				</tr>
				<tr height="40">
					<td>
						<label>Scale (if any*)
						<p class="text-green" style="margin:0;"></p>
						</label>
					</td>
					<td>
						<input type="number" min="1" step="1" name="inputScale" id="inputScale" class="form-control" placeholder="Enter when data Type is \'Decimal\'"/>
					</td>
				</tr>
				<tr height="40">
					<td>&nbsp;</td>
					<td>
						<div class="checkbox">
							<label style="font-weight:700;">
							<input type="checkbox" id="inputUnique" name="inputUnique[]" value="'.$checkUnique.'" >Unique
							<p class="text-green" style="margin:0;"></p>
							</label>
	
							&nbsp;&nbsp;
							
							<label style="font-weight:700;">
							<input type="checkbox" id="inputNotNull" name="inputNotNull[]" value="'.$checkNotNull.'" >NOT NULL
							<p class="text-green" style="margin:0;"></p>
							</label>
						</div>
					</td>
				</tr>
				<tr height="40">
					<td>
						<label>Default Value:
						<p class="text-green" style="margin:0;"></p>
						</label>
					</td>
					<td>
						<input type="text" id="inputDefault" name="inputDefault" class="form-control"/>
					</td>
				</tr>
				<tr height="40">
					<td>
						<label>Min Value:
						<p class="text-green" style="margin:0;"></p>
						</label>
					</td>
					<td>
						<input type="number" step="0.01" id="inputMinValue" name="inputMinValue" class="form-control"/>
					</td>
				</tr>
				<tr height="40">
					<td>
						<label>Max Value:
						<p class="text-green" style="margin:0;"></p>
						</label>
					</td>
					<td>
						<input type="number" step="0.01" id="inputMaxValue" name="inputMaxValue" class="form-control"/>
					</td>
				</tr>
				<tr height="40">
					<td>
						<label>Table Name:
						<p class="text-green" style="margin:0;"></p>
						</label>
					</td>
					<td>
						<input type="text" id="inputTableName" name="inputTableName" class="form-control" />
					</td>
				</tr>
				<tr height="40">
					<td>
						<label>Column Name:
						<p class="text-green" style="margin:0;"></p>
						</label>
					</td>
					<td>
						<input type="text" id="inputColumnName" name="inputColumnName" class="form-control"/>
					</td>
				</tr>
				</table>';
			}
			return $output;
		}

	function saveTempFRInput_edit(){
		$output = '';
		$error_message = '';
		
		if(!empty($_POST))
		{
			try{
				$changeType = $this->input->post('changeType');
				
				$userId = $this->session->userdata('userId');
				$functionId = $this->input->post('changeFunctionId');
				$functionVersion = $this->input->post('changeFunction');
				$dataId = $this->input->post('changedataId');
				$typeData = $this->input->post('changetypeData');
				$schemaVersionId = $this->input->post('changeSchemaVersionId');

				$dataName = trim($this->input->post('dataName'));
				$dataType = $this->input->post('inputDataType');
				$dataLength = $this->input->post('inputDataLength');
				$scalePoint = $this->input->post('inputScale');
				$unique = $this->input->post('inputUnique');
				$notNull = $this->input->post('inputNotNull');
				$defaultValue = trim($this->input->post('inputDefault'));
				$minValue = $this->input->post('inputMinValue');
				$maxValue = $this->input->post('inputMaxValue');
				$tableName = trim($this->input->post('inputTableName'));
				$columnName = trim($this->input->post('inputColumnName'));

				$oldUnique = $this->input->post('oldUniqueValue');
				$oldNotNull = $this->input->post('oldNotNullValue');

				$unique = empty($unique)? "N": "Y";
				$notNull = empty($notNull)? "N": "Y";

				$user = $this->session->userdata('username');

				$param = (object) array(
					'userId' => $userId,
					'functionId' => $functionId,
					'functionVersion' => $functionVersion,
					'typeData' => $typeData,
					'dataId' => $dataId,
					'dataName' => $dataName,
					'schemaVersionId' => $schemaVersionId,
					'dataType' => $dataType,
					'dataLength' => $dataLength,
					'scaleLength' => $scalePoint,
					'unique' => $unique,
					'notNull' => $notNull,
					'default' => $defaultValue,
					'min' => $minValue,
					'max' => $maxValue,
					'table' => $tableName,
					'column' => $columnName,
					'changeType' => '',
					'user' => $user);

				if(CHANGE_TYPE_ADD == $changeType){ 
					//*******Change Type: Add
					//Validate
			
					$projectId = $this->input->post('changeProjectId');
					$resultValidate = $this->validateNewFRInput($projectId, $param, $error_message);
				
					if($resultValidate){
						
						//Save
						$param->changeType = CHANGE_TYPE_ADD;
						$saveResult = $this->mChange->insertTempFRInputChange($param);
						if($saveResult){
							//refresh Change List
							$output = $this->setInputChangeListData($userId, $functionId, $functionVersion);
						}else{
							$output = 'error|'.ER_MSG_013;
						}
						
					}else{
						$output = 'error|'.$error_message;
					}

				}else{ 
					
					//*******Change Type: Edit
					//validate duplicate 
					$oldDataType = $this->input->post('oldDataType');
					$oldDataLength = $this->input->post('oldDataLength');
					$oldScale = $this->input->post('oldScale');
					$oldDefaultValue = $this->input->post('oldDefaultValue');
					$oldMinValue = $this->input->post('oldMin');
					$oldMaxValue = $this->input->post('oldMax');

					if($oldDataType == $dataType
						|| (!empty($oldDataLength) && !empty($dataLength) && ((int)$dataLength == (int)$oldDataLength))
						|| (!empty($oldScale) && !empty($scalePoint) && ((int)$scalePoint == (int)$oldScale))
						|| (!empty($oldDefaultValue) && !empty($defaultValue) && ($oldDefaultValue == $defaultValue))
						|| (!empty($oldMinValue) && !empty($minValue) && ((int)$oldMinValue == (int)$minValue))
						|| (!empty($oldMaxValue) && !empty($maxValue) && ((int)$oldMaxValue == (int)$maxValue)))
						//return true;
					{
						echo 'error|'.ER_TRN_009;
						return false;
					}

					//validate check exist
					$criteria = (object) array(
						'userId' => $userId, 
						'functionId' => $functionId,
						'functionVersion' => $functionVersion,
						'dataId' => $dataId,
						'typeData' => $typeData,
						'schemaVersionId' => $schemaVersionId);
					$records = $this->mChange->searchTempFRInputChangeList($criteria);
				
					if(0 == count($records)){
						
						$param->unique = ($unique == $oldUnique)? "": $unique;
						$param->notNull = ($notNull == $oldNotNull)? "": $notNull;
						$param->changeType = CHANGE_TYPE_EDIT;
						
						$saveResult = $this->mChange->insertTempFRInputChange($param);
					
						if($saveResult){
							//refresh Change List
							$output = $this->setInputChangeListData($userId, $functionId, $functionVersion);
							
						}else{
							
							$output = 'error|'.ER_MSG_013;
						}
					}else{
						//Error already change
						$output = 'error|'.ER_TRN_001;
					}
				}
			}catch (Exception $e){
				$output = 'error|'.ER_MSG_013.'<br/>'.$e;
			}
		}
		//echo $output;
		return false;
	}

	function saveTempFRInput_delete(){
		$output = '';
		
		if(!empty($_POST)){
			$keyList = explode("|", $this->input->post('keyId'));

			$userId = $this->session->userdata('userId');
			$functionId = $this->input->post('functionId');
			$functionVersion = $this->input->post('functionVersion');
			$dataId = $keyList[1];
			$typeData = $keyList[4];
			$schemaVersionId = $keyList[2];
			//$functionId = $keyList[3];

			$user = $this->session->userdata('username');
/*
			var_dump($this->input->post('keyId'));
			var_dump($this->input->post('functionId'));
			var_dump($this->input->post('functionVersion'));
			var_dump($keyList[1]);
			var_dump(	$typeData );
			var_dump($schemaVersionId );*/
			//validate check exist
			$criteria = (object) array(
				'userId' => $userId,
				'functionId' => $functionId,
				'functionVersion' => $functionVersion,
				'dataId' => $dataId,
				'typeData' => $typeData,
				'schemaVersionId' => $schemaVersionId);
			$records = $this->mChange->searchTempFRInputChangeList($criteria);
			if(0 == count($records)){
				$inputInfo = $this->mFR->searchFRInputDetailByCriteria($criteria);
				echo $inputInfo['dataName'];
				echo $inputInfo['dataType'];
				echo $inputInfo['dataLength'];
				echo $inputInfo['decimalPoint'];
				echo $inputInfo['constraintUnique'];
				echo $inputInfo['constraintNull'];
				echo $inputInfo['constraintDefault'];
				echo $inputInfo['constraintMinValue'];
				echo $inputInfo['constraintMaxValue'];
				echo $inputInfo['refTableName'];
				echo $inputInfo['refColumnName'];
				$param = (object) array(
					'userId' => $userId,
					'functionId' => $functionId,
					'functionVersion' => $functionVersion,
					'typeData' => $typeData,
					'dataId' => $dataId,
					'dataName' => $inputInfo['dataName'],
					'schemaVersionId' => $schemaVersionId,
					'dataType' => $inputInfo['dataType'],
					'dataLength' => $inputInfo['dataLength'],
					'scaleLength' => $inputInfo['decimalPoint'],
					'unique' => $inputInfo['constraintUnique'],
					'notNull' => $inputInfo['constraintNull'],
					'default' => $inputInfo['constraintDefault'],
					'min' => $inputInfo['constraintMinValue'],
					'max' => $inputInfo['constraintMaxValue'],
					'table' => $inputInfo['refTableName'],
					'column' => $inputInfo['refColumnName'],
					'changeType' => CHANGE_TYPE_DELETE,
					'user' => $user);				
				$saveResult = $this->mChange->insertTempFRInputChange($param);
				if($saveResult){
					//refresh Change List
					$output = $this->setInputChangeListData($userId, $functionId, $functionVersion);
				}else{
					$output = 'error|'.ER_MSG_013;
				}
			}else{
				$output = 'error|'.ER_TRN_001;
			}
		}
		return false;

	}

	function deleteTempFRInputList(){
		$output = '';

		if(!empty($_POST)){
			$userId = $this->session->userdata('userId');
			$functionId = $this->input->post('functionId');
			$functionVersion = $this->input->post('functionVersion');
			$lineNumber = $this->input->post('lineNumber');

			$param = (object) array('userId' => $userId,
				'functionId' => $functionId,
				'functionVersion' => $functionVersion,
				'lineNumber' => $lineNumber);
			$recordDelete = $this->mChange->deleteTempFRInputChangeList($param);
			if(0 < $recordDelete){
				//refresh Change List
				$output = $this->setInputChangeListData($userId, $functionId, $functionVersion);
			}else{
				$output = 'error|'.ER_MSG_015;
			}
		}

		echo $output;
	}

	private function setInputChangeListData($userId, $functionId, $functionVersion){

		$criteria = (object) array(
			'userId' => $userId, 
			'functionId' => $functionId,
			'functionVersion' => $functionVersion);

		$lineNo = 1;
		$changeList = $this->mChange->searchTempFRInputChangeList($criteria);

		$inputChangeOutput = '
			<table class="table table-condensed">
			<tbody>
			<tr>
				<th>#</th>
				<th>Type of Data</th>
				<th>Data Name</th>
				<th>Data Type</th>
				<th>Data Length</th>
				<th>Scale</th>
				<th>Unique</th>
				<th>NOT NULL</th>
				<th>Default value</th>
				<th>Min</th>
				<th>Max</th>
				<th style="text-align: center;">Change Type</th>
				<th></th>
			</tr>';
		foreach ($changeList as $value) {
			$labelType = ('add' == $value['changeType'])? 'label-success': (('edit' == $value['changeType'])? 'label-warning' : 'label-danger');

			$inputChangeOutput .= '
			<tr>
				<td>'.$lineNo++.'</td>
				<td> echo "if ('.$value['typeData'].' = "1") {
						echo "Input";
					}else{
						echo "Output";
					}
				</td>
				<td>'.$value['dataName'].'</td>
				<td>'.$value['newDataType'].'</td>
				<td>'.$value['newDataLength'].'</td>
				<td>'.$value['newScaleLength'].'</td>
				<td>'.$value['newUnique'].'</td>
				<td>'.$value['newNotNull'].'</td>
				<td>'.$value['newDefaultValue'].'</td>
				<td>'.$value['newMinValue'].'</td>
				<td>'.$value['newMaxValue'].'</td>
				<td style="text-align: center;">
					<small class="label '.$labelType.'">
						'.$value['changeType'].'
					</small>
				</td>
				<td>
					<span id="'.$value['lineNumber'].'" class="glyphicon glyphicon-trash deleteTmpFRInputChg">
					</span>
				</td>
			</tr>';
		}
		$inputChangeOutput .= '</tbody></table>';
		return $inputChangeOutput;
	}

	private function validateNewFRInput($projectId, &$param, &$errorMsg){
		//validate
		$this->load->library('common');
		
		$correctFRInput = false;
		//$dataId = '';

		//1. Check Existing in Selected Functional Requirement
		$param->inputActiveFlag = ACTIVE_CODE;
		//echo $param->dataName;
		$resultExist = $this->mFR->searchExistFRInputInFunctionalRequirement($param);

		if(0 < count($resultExist)){
			$errorMsg = ER_TRN_005;
			
			return false;
		}
		
		//2. Check Existing in Current Change List
		/* $criteria = (object) array(
			'userId' => $param->userId, 
			'functionId' => $param->functionId,
			'functionVersion' => $param->functionVersion,
			'dataName' => $param->dataName,
			'table' => $param->table,
			'column' => $param->column);
		
		$criteria = (object) array(
			'userId' => $param->userId, 
			'functionId' => $param->functionId,
			'functionVersion' => $param->functionVersion,
			'dataName' => $param->dataName);*/
		$criteria = (object) array(
				'userId' => $param->userId, 
				'functionId' => $param->functionId,
				'functionVersion' => $param->functionVersion,
				'dataName' => $param->dataName,
				'schemaVersionId' => $param->schemaVersionId);

		$resultExist = $this->mChange->searchTempFRInputChangeList($criteria);
		if(0 < count($resultExist)){
			$errorMsg = ER_TRN_006;
			return false;
		}

		//3. Check input name match with table & column or not? (REQ INPUT DB)
		if ((null != $param->table) && (null != $param->column) )
		{
			$resultInputInfo = $this->mFR->searchFRInputInformation($projectId, $param->dataName, ACTIVE_CODE);
			if(0 < count($resultInputInfo)){
				$referTableName = $resultInputInfo->refTableName;
				$referColumnName = $resultInputInfo->refColumnName;
				
				if($referTableName != strtoupper($param->table)
					|| $referColumnName != strtoupper($param->column)){
					$errorMsg = ER_TRN_004;
					return false;
				}else{
					$param->dataId = $resultInputInfo->dataId;
					$correctFRInput = TRUE;
				}
			}
		}

		//4. Check table & column name match with input data (REQ INPUT DB)
		if ((null != $param->table) && (null != $param->column) )
		{
			if(!$correctFRInput){
				$resultInputInfo = $this->mFR->searchExistFRInputsByTableAndColumnName(
					$param->table, $param->column, $projectId, ACTIVE_CODE);
				if(0 <  count($resultInputInfo)){
					if($param->dataName == $resultInputInfo->dataName){
						$param->dataId = $resultInputInfo->dataId;
						$param->typeData = $resultInputInfo->typeData;
						$correctFRInput = TRUE;
					}else{
						$errorMsg = ER_TRN_005;
						return false;
					}
				}
			}
		}

		//5. Check table & column name match with Schema data (DB SCHEMA)
/*		$resultSchemaInfo = $this->mDB->searchExistDatabaseSchemaInfo($param->table, $param->column, $projectId);

		if(null != $resultSchemaInfo && !empty($resultSchemaInfo)){
			//5.1 Validate against Existing FR Input
			if($param->dataType !== $resultSchemaInfo->dataType 
				|| $param->dataLength !== $this->common->nullToEmpty($resultSchemaInfo->dataLength)
				|| $param->scaleLength !== $this->common->nullToEmpty($resultSchemaInfo->decimalPoint)
				|| $param->unique !== $resultSchemaInfo->constraintUnique
				|| $param->notNull !== $resultSchemaInfo->constraintNull
				|| $param->default !== $this->common->nullToEmpty($resultSchemaInfo->constraintDefault)
				|| $param->min !== $this->common->nullToEmpty($resultSchemaInfo->constraintMinValue)
				|| $param->max !==  $this->common->nullToEmpty($resultSchemaInfo->constraintMaxValue))
			{
				$errorMsg = ER_TRN_007;
				return false;
			}
		}
*/
		//5. Check table & column name match with Schema data (DB SCHEMA)

		if ((null != $param->table) && (null != $param->column)) 
		{
			$resultSchemaInfo = $this->mDB->searchExistDatabaseSchemaInfo($param->table, $param->column, $projectId);

			if(null != $resultSchemaInfo && !empty($resultSchemaInfo)){
				//5.1 Validate against Existing FR Input
				if($param->trim(dataType) !== $resultSchemaInfo->dataType
				|| $param->dataLength !== $resultSchemaInfo->dataLength
				|| $param->scaleLength !== $this->common->nullToEmpty($resultSchemaInfo->decimalPoint)
				|| $param->unique !== $resultSchemaInfo->constraintUnique
				|| $param->notNull !== $resultSchemaInfo->constraintNull
				|| $param->default !== $this->common->nullToEmpty($resultSchemaInfo->constraintDefault)
				|| $param->min !== $this->common->nullToEmpty($resultSchemaInfo->constraintMinValue)
				|| $param->max !==  $this->common->nullToEmpty($resultSchemaInfo->constraintMaxValue))
				{
					$errorMsg = ER_TRN_007;
					return false;
				}
			}
		}	
		//6. Validate New FR Input and Schema Info
		$exceptInputSize = array("date", "datetime", "int", "float", "real");
		//6.1 [Validate DataType]
		if(!in_array($param->dataType, $exceptInputSize)){
			if(empty($param->dataLength)){
				$errorMsg = ER_TRN_008;
				return false;
			}else{
				$dataLength = (int)$param->dataLength;
				if("char" == $param->dataType || "varchar" == $param->dataType){
					if($dataLength < 1 || $dataLength > 8000){
						$errorMsg = ER_IMP_015;
						return false;
					}
				}else if("nchar" == $param->dataType || "nvarchar" == $param->dataType){
					if($dataLength< 1 || $dataLength > 4000 ){
						$errorMsg = ER_IMP_016;
						return false;
					}
				}else{
					if($dataLength < 1 || $dataLength > 38){
						$errorMsg = ER_IMP_017;
						return false;
					}else{
						//6.2 [Validate Scale] for Decimal Type. If NULL, default value will be '0'.
						if(!empty($param->scaleLength)){
							$scale = (int)$param->scaleLength;
							if($scale < 0 || $scale > $dataLength){
								$errorMsg = ER_IMP_018;
								return false;
							}
						}else{
							$param->scaleLength = 0;
						}
					}
				}
			}
		}

		$dataTypeCategory = '';
		$result = $this->mMisc->searchMiscellaneous(MISC_DATA_INPUT_DATA_TYPE, $param->dataType);
		if(null != $result && !empty($result)){
			$dataTypeCategory = $result[0]['miscValue2'];
		}else{
			$errorMsg = ER_MSG_014;
			return false;
		}
		
		//6.3 [Validate Default Value]
		if(!empty($param->default)){
			if(DATA_TYPE_CATEGORY_NUMERICS == $dataTypeCategory){
				if(!is_numeric($param->default)){
					$errorMsg = ER_IMP_021;
					return false;
				}else if('decimal' == $param->dataType && is_float((float)$param->default)){
					$decimalFotmat = explode(".", $param->default);
					if(strlen($decimalFotmat[0]) > $param->dataLength){
						$errorMsg = ER_IMP_021;
					return false;
					}
				}	
			}else if(DATA_TYPE_CATEGORY_STRINGS == $dataTypeCategory
				&& strlen($param->default) > $param->dataLength){
				$errorMsg = ER_IMP_021;
				return false;
			}else{
				// Date Type
				if("getdate()" != strtolower($param->default)){
					$errorMsg = ER_IMP_021;
					return false;
				}
			}
		}

		//6.4 [Validate Min Value]
		if(!empty($param->min) && DATA_TYPE_CATEGORY_NUMERICS != $dataTypeCategory){
			$errorMsg = ER_IMP_024;
			return false;
		}

		//6.5 [Validate Max Value]
		if(!empty($param->max) && DATA_TYPE_CATEGORY_NUMERICS != $dataTypeCategory){
			$errorMsg = ER_IMP_025;
			return false;
		}

		if(!empty($param->min) && !empty($param->max)){
			if((float)$param->min > (float)$param->max){
				$errorMsg = ER_IMP_035;
				return false;
			}
		}

		return true;
	}

	function callChangeAPI($param){
		$passData = array();
		$allFRHeader = array();
		$allFRDetail = array();
		$allTCHeader = array();
		$allTCDetail = array();
		$allRTM = array();
		$changeList = array();

		$this->load->library('common');

		$passData['callType'] = $param->type;
		//1.Project Information
		$projectInfo = $this->mProject->searchProjectDetail($param->projectId);
		$passData['projectInfo'] = $param->projectId;
		$passData['connectDatabaseInfo'] = array(
			'databaseName' 	=> $projectInfo->databaseName, 
			'hostname' 		=> $projectInfo->hostname, 
			'port' 			=> $projectInfo->port, 
			'username' 		=> $projectInfo->username, 
			'password' 		=> $projectInfo->password);
		
		//2. All Functional Requirements Header data
		/*$criteria = (object) array('projectId' => $param->projectId, 'status' => '1');
		$frHeaderList = $this->mFR->searchFunctionalRequirementHeaderInfo($criteria);
		foreach($frHeaderList as $value){
			$allFRHeader[$value['functionNo']] = array(
				'functionVersion' 	=> $value['functionVersion'], 
				'functionDesc' 		=> $value['fnDesc']);
		}
		$passData['FRHeader'] = $allFRHeader;*/

		$criteria = (object) array('projectId' => $param->projectId, 'status' => '1','functionId' => $param->functionId);
		$frHeaderList = $this->mFR->searchFunctionalRequirementHeaderInfo($criteria);
		foreach($frHeaderList as $value){
			$allFRHeader[$value['functionNo']] = array(
				'functionVersion' 	=> $value['functionVersion'], 
				'functionDesc' 		=> $value['fnDesc']);
		}
		$passData['FRHeader'] = $allFRHeader;
		$functionVersion_FR = $allFRHeader[$value['functionNo']]['functionVersion'];

		//$passData['FRHeader'][$value['functionNo']]['functionVersion'];
		//3. All Functional Requirements Detail data
		$functionNo = '';
		$frDetailList = $this->mFR->searchFunctionalRequirementDetail($criteria);
		foreach($frDetailList as $value){
			if ($value['dataName'] <> null) {
			$allFRDetail[$value['functionNo']][$value['dataName']] = array( 
				'dataType' 		=> $value['dataType'],
				'dataLength' 	=> $value['dataLength'],
				'scale' 		=> $value['decimalPoint'],
				'unique' 		=> $value['constraintUnique'],
				'notNull' 		=> $value['constraintNull'],
				'default' 		=> $value['constraintDefault'],
				'min' 			=> $value['constraintMinValue'],
				'max' 			=> $value['constraintMaxValue'],
				'tabelName' 	=> $value['refTableName'],
				'columnName' 	=> $value['refColumnName'],
				'typeData'		=> $value['typeData']);		
			}
		}
		$passData['FRDetail'] = $allFRDetail;

		//6. All RTM data
		//$rtmList = $this->mRTM->searchRTMInfoByCriteria($param->projectId);
		$rtmList = $this->mRTM->searchRTMInfoByCriteria($param->projectId,$param->functionId,$functionVersion_FR);
		foreach($rtmList as $value){
			$allRTM = array('functionId' => $value['functionId'], 'testCaseNo' => $value['testCaseNo'],'testCaseversion' => $value['testCaseversion'],'functionversion' => $value['functionversion']);
		}
		$passData['RTM'] = $allRTM;
		//echo $passData['RTM']['testCaseNo'];

		//4. All Test Case Header data
		$tcHeaderList = $this->mTestCase->searchTestCaseInfoByCriteria($param->projectId, '1',$passData['RTM']['testCaseNo'],$passData['RTM']['testCaseversion']);
		foreach($tcHeaderList as $value){
			$allTCHeader[$value['testCaseNo']] = array(
				'testCaseVersion' 	=> $value['testCaseVersion'], 
				'testCaseDesc' 	 	=> $value['testCaseDescription'],
				'expectedResult' 	=> $value['expectedResult']);
		}
		$passData['TCHeader'] = $allTCHeader;
		
		//5. All Test Case Detail data
		$tcDetailList = $this->mTestCase->searchExistTestCaseDetail($param->projectId,$passData['RTM']['testCaseNo'],$passData['RTM']['testCaseversion']);
		
		foreach ($tcDetailList as $value) {
		//	$allTCDetail[$value['testCaseNo']][$value['refInputName']] = $value['testData'];
			$allTCDetail[$value['testCaseNo']][$value['refdataName']] = $value['testData'];	
		}
		$passData['TCDetail'] = $allTCDetail;


		//7. Change Request Information
		$modifyFlag = EDIT_FLAG_ENABLE;

		$criteria->userId = $param->userId;
		$criteria->functionId = $param->functionId;
		$criteria->functionVersion = $param->functionVersion;
		// $criteria->functionVersion;
		$changeFRInputsList = $this->mChange->searchTempFRInputChangeList($criteria);
		//echo $changeFRInputsList['dataName'];

		$changeList = array(
			'functionNo' => $param->functionNo, 
			'functionVersion' => $param->functionVersion);
			
		foreach($changeFRInputsList as $value){
			$changeList['inputs'][] = array(
				'changeType' 	=> $value['changeType'],
				'dataName' 		=> $value['dataName'],
				'typeData' 		=> $value['typeData'],
				'dataId' 		=> $value['dataId'],
				'dataType' 		=> $value['newDataType'],
				'dataLength' 	=> $value['newDataLength'],
				'scale' 		=> $value['newScaleLength'],
				'unique'	 	=> $value['newUnique'],
				'notNull' 		=> $value['newNotNull'],
				'default' 		=> $value['newDefaultValue'],
				'min' 			=> $value['newMinValue'],
				'max' 			=> $value['newMaxValue'],
				'tableName' 	=> $value['tableName'],
				'columnName' 	=> $value['columnName'],
				'modifyFlag' 	=> $modifyFlag
			);
		}

		$passData['changeRequestInfo'] = $changeList;

		//$url = 'http://localhost:81/StubService/ChangeAPI.php';
		$url = 'http://localhost:81/Stubservice/ChangeAPI.php';

		$json = $this->common->postCURL($url, $passData);
		//echo $json;
		$json = json_decode($json);
		
		//var_dump($json);

		$this->writeJsonFile($passData, $json, $param->functionId);

		return $json;

		//echo '<br><hr><h2>'.$this->postCURL($url, $passData).'</h2><br><hr><br>';
	}

	private function openView($data, $view){
		if('search' == $view){
			$data['html'] = 'ChangeManagement/changeRequestSearch_view';
			$data['projectCombo'] = $this->mProject->searchStartProjectCombobox();
		}else if('result' == $view){
			$data['html'] = 'ChangeManagement/changeRequestResult_view';
		}
		else{
			$data['html'] = 'ChangeManagement/changeRequestDetail_view';
		}
		
		$data['active_title'] = 'ChangeManagement';
		$data['active_page'] = 'trns001';
		$this->load->view('template/header');
		$this->load->view('template/body', $data);
		$this->load->view('template/footer');
	}

	private function writeJsonFile($outputData, $inputData, $changedFunctionId){
		try{
			$datetime = date('YmdHis');
			$outputFileName = "log/change/requestDataJson".$changedFunctionId."_".$datetime.".txt";

			$encodedString = json_encode($outputData);
			file_put_contents($outputFileName, $encodedString);

			$encodedString = json_encode($inputData);
			$inputFileName = "log/change/responseDataJson_".$changedFunctionId."_".$datetime.".txt";
			file_put_contents($inputFileName, $encodedString);
		}catch(Exception $e){
			echo 'Caught exception: ',  $e->getMessage(), "\n";
		}
	}
}

?>