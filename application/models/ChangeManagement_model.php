<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
* Change Management Model
*/
class ChangeManagement_model extends CI_Model{
	
	function __construct(){
		parent::__construct();

		$this->load->model('FunctionalRequirement_model', 'mFR');
		$this->load->model('DatabaseSchema_model', 'mDB');
		$this->load->model('Miscellaneous_model', 'mMisc');
		$this->load->model('TestCase_model', 'mTestCase');
		$this->load->model('RTM_model', 'mRTM');
		$this->load->model('Common_model', 'mCommon');
	}

	function searchTempFRInputChangeList($param){

		if(!empty($param->userId)){
			$where[] = "userId = $param->userId";
		}

		if(!empty($param->functionId)){
			$where[] = "functionId = $param->functionId";
		}

		if(!empty($param->functionVersion)){
			$where[] = "functionVersion = $param->functionVersion";
		}

		if(!empty($param->dataId)){
			$where[] = "dataId = $param->dataId";
		}

		if(!empty($param->schemaVersionId)){
			$where[] = "schemaVersionId = $param->schemaVersionId";
		}

		//For Adding new input
	/*	if(!empty($param->dataName) && !empty($param->table) && !empty($param->column)){
			$where[] = "((dataName = '$param->dataName') 
				OR (tableName = '$param->table' AND columnName = '$param->column'))";
		}
		*/
		if(!empty($param->dataName)){
			$where[] = "dataName = '$param->dataName'";
		}
		$where_clause = implode(' AND ', $where);

		$sqlStr = "SELECT *
			FROM T_TEMP_CHANGE_LIST
			WHERE $where_clause
			ORDER BY lineNumber";
		//	echo $sqlStr;
		$result = $this->db->query($sqlStr);
		return $result->result_array();
	}

	function searchFRInputChangeList($param){
		if(!empty($param->userId)){
			$where[] = "userId = '$param->userId'";
		}
		if(!empty($param->functionId)){
			$where[] = "functionId = '$param->functionId'";
		}
		if(!empty($param->functionVersion)){
			$where[] = "functionVersion = '$param->functionVersion'";
		}
		if(!empty($param->dataId)){
			$where[] = "dataId = $param->dataId";
		}

		if(!empty($param->schemaVersionId)){
			$where[] = "schemaVersionId = $param->schemaVersionId";
		}
		if(!empty($param->dataName)){
			$where[] = "dataName = '$param->dataName'";
		}
		$where_clause = implode(' AND ', $where);

		$sqlStr = "SELECT *
			FROM T_TEMP_CHANGE_LIST
			WHERE $where_clause
			ORDER BY lineNumber";
			echo $sqlStr;
		$result = $this->db->query($sqlStr);
		return $result->row();
	}

	function searchChangeRequestList(){
		$sqlStr = "SELECT 
				top 10
				p.projectName, 
				p.projectNameAlias, 
				i.changeRequestNo,
				i.changeStatus, 
				i.changeUserId,
				CONVERT(nvarchar, i.changeDate, 120) as changeDate,
				CONCAT(u.firstname, '   ', u.lastname) as changeUser
			FROM T_CHANGE_REQUEST_HEADER i
			INNER JOIN M_PROJECT p
			ON i.projectId = p.projectId
			INNER JOIN M_USERS u
			ON i.changeUserId = u.userId
			ORDER BY i.createDate desc";
		$result = $this->db->query($sqlStr);
		return $result->result_array();
	}

	function searchRelatedChangeFRInputs($param){
		/*$sqlStr = "SELECT  t.functionId, d.functionId, d.inputId
			FROM T_TEMP_CHANGE_LIST t 
			INNER JOIN M_FN_REQ_DETAIL d
			ON t.inputId = d.inputId
			AND d.functionId <> t.functionId
			AND d.activeFlag = '1'
			WHERE t.changeType IN ('edit', 'delete')
			AND t.userId = $param->userId
			AND t.functionId = $param->functionId
			AND t.functionVersion = $param->functionVersion";
			*/
		$sqlStr = "SELECT  t.functionId, d.functionId, d.dataId
			FROM T_TEMP_CHANGE_LIST t 
			INNER JOIN M_FN_REQ_DETAIL d
			ON t.dataId = d.dataId
			AND d.functionId = t.functionId
			AND d.activeFlag = '1'
			WHERE t.changeType IN ('edit', 'delete')
			AND t.confirmflag = '1'
			AND t.userId = $param->userId
			AND t.functionId = $param->functionId
			AND t.functionVersion = $param->functionVersion";
			//echo $sqlStr;
		$result = $this->db->query($sqlStr);
		return $result->result_array();	
	}

	function deleteTempFRInputChangeList($param){
		if(!empty($param->userId)){
			$where[] = "userId = $param->userId";
		}

		if(!empty($param->functionId)){
			$where[] = "functionId = $param->functionId";
		}

		if(!empty($param->functionVersion)){
			$where[] = "functionVersion = $param->functionVersion";
		}

		if(!empty($param->lineNumber)){
			$where[] = "lineNumber = $param->lineNumber";
		}

		$where_condition = implode(' AND ', $where);

		$sqlStr = "DELETE FROM T_TEMP_CHANGE_LIST
			WHERE $where_condition";
		$result = $this->db->query($sqlStr);
		return $this->db->affected_rows();
	}

	function insertTempFRInputChange($param){
		$currentDateTime = date('Y-m-d H:i:s');

		$schemaVersionId = !empty($param->schemaVersionId)? $param->schemaVersionId : "NULL";
		$dataType = !empty($param->dataType)? "'".$param->dataType."'" : "NULL";
		$dataLength = !empty($param->dataLength)? $param->dataLength : "NULL";
		$scale = !empty($param->scaleLength)? $param->scaleLength : "NULL";
		$unique = !empty($param->unique)? "'".$param->unique."'" : "NULL";
		$notNull = !empty($param->notNull)? "'".$param->notNull."'" : "NULL";
		$default = !empty($param->default)? "'".$param->default."'" : "NULL";
		$min = !empty($param->min)? "'".$param->min."'" : "NULL";
		$max = !empty($param->max)? "'".$param->max."'" : "NULL";
		$tableName = !empty($param->table)? "'".$param->table."'" : "NULL";
		$columnName = !empty($param->column)? "'".$param->column."'" : "NULL";

		$dataLength = !empty($dataLength)? $dataLength : "NULL";

		$sqlStr = "INSERT INTO T_TEMP_CHANGE_LIST (userId, functionId, functionVersion,typeData, dataName, schemaVersionId, newDataType, newDataLength, 
		newScaleLength, newUnique, newNotNull, newDefaultValue, newMinValue, newMaxValue, tableName, columnName, changeType, createUser, createDate,dataId,confirmflag,approveflag) 
			VALUES (
				'$param->userId', 
				'$param->functionId',
				'$param->functionVersion',
				'$param->typeData',
				'$param->dataName',
				$schemaVersionId,
				$dataType,
				$dataLength,
				$scale,
				$unique,
				$notNull,
				$default,
				$min,
				$max,
				$tableName,
				$columnName,
				'$param->changeType',
				'$param->user', 
				'$currentDateTime',
				'$param->dataId',
				NULL,
				NULL)";
echo $sqlStr;
		$result = $this->db->query($sqlStr);
		return $result;
	}

	function insertChangeRequestHeader($param){
		
		$sqlStr = "INSERT INTO T_CHANGE_REQUEST_HEADER (changeRequestNo, changeUserId, changeDate, projectId, changeFunctionId, changeFunctionNo, changeFunctionVersion, changeStatus, createUser, createDate, updateUser, updateDate) VALUES ('$param->changeRequestNo', $param->changeUser, '$param->changeDate', $param->projectId, $param->changeFunctionId, '$param->changeFunctionNo', '$param->changeFunctionVersion', '$param->changeStatus', '$param->user', '$param->currentDate', '$param->user', '$param->currentDate')";
		
		$result = $this->db->query($sqlStr);
		return $result;
	}

	function insertChangeRequestDetail($param){

		$dataId = !empty($param->dataId)? $param->dataId : "NULL";
		$schemaVersionId = !empty($param->schemaVersionId)? $param->schemaVersionId : "NULL";

		$dataType = !empty($param->dataType)? "'".$param->dataType."'" : "NULL";
		$dataLength = !empty($param->dataLength)? $param->dataLength : "NULL";
		$scale = !empty($param->scale)? $param->scale : "NULL";
		$unique = !empty($param->unique)? "'".$param->unique."'" : "NULL";
		$notNull = !empty($param->notNull)? "'".$param->notNull."'" : "NULL";
		$default = !empty($param->default)? "'".$param->default."'" : "NULL";
		$min = !empty($param->min)? "'".$param->min."'" : "NULL";
		$max = !empty($param->max)? "'".$param->max."'" : "NULL";
		$tableName = !empty($param->tableName)? "'".$param->tableName."'" : "NULL";
		$columnName = !empty($param->columnName)? "'".$param->columnName."'" : "NULL";

		$sqlStr = "INSERT INTO T_CHANGE_REQUEST_DETAIL (changeRequestNo, sequenceNo, changeType,typeData, refdataId, refSchemaVersionId, dataName, dataType, dataLength, scale, constraintUnique, constraintNotNull, constraintDefault, constraintMin, constraintMax, refTableName, refColumnName) VALUES ('$param->changeRequestNo', $param->sequenceNo, '$param->changeType','$param->typeData', $dataId, $schemaVersionId, '$param->dataName', $dataType, $dataLength, $scale, $unique, $notNull, $default, $min, $max, $tableName, $columnName)";
		$result = $this->db->query($sqlStr);
		return $result;
	}

	function insertChangeHistory_RequirementsHeader($param){
		$sqlStr = "INSERT INTO T_CHANGE_HISTORY_REQ_HEADER (changeRequestNo, functionId, functionNo, oldFunctionVersion, newFunctionVersion) VALUES ('$param->changeRequestNo', $param->functionId, '$param->functionNo', $param->oldFnVersionNumber, $param->newFnVersionNumber)";
		$result = $this->db->query($sqlStr);
		if($result){
			$query = $this->db->query("SELECT IDENT_CURRENT('T_CHANGE_HISTORY_REQ_HEADER') as last_id");
			$resultId = $query->result();
			return $resultId[0]->last_id;
		}
		return NULL;
	}

	function insertChangeHistory_RequirementsDetail($param){
		$sqlStr = "INSERT INTO T_CHANGE_HISTORY_REQ_DETAIL (fnReqHistoryId, sequenceNo, changeType, inputName, refTableName, refColumnName) VALUES ($param->fnReqHistoryId, $param->sequenceNo, '$param->changeType', '$param->inputName', '$param->refTableName', '$param->refColumnName')";
		$result = $this->db->query($sqlStr);
		return $result;
	}

	function insertChangeHistory_Schema($param){
		$oldVersionNumber = !empty($param->oldSchemaVersionNumber)? $param->oldSchemaVersionNumber : "NULL";
		$newVersionNumber = !empty($param->newSchemaVersionNumber)? $param->newSchemaVersionNumber : "NULL";

		$sqlStr = "INSERT INTO T_CHANGE_HISTORY_SCHEMA (changeRequestNo, sequenceNo, tableName, columnName, oldSchemaVersionNumber, newSchemaVersionNumber, changeType) VALUES ('$param->changeRequestNo', $param->sequenceNo, '$param->tableName', '$param->columnName', $oldVersionNumber, $newVersionNumber, '$param->changeType') ";
		$result = $this->db->query($sqlStr);
		return $result;
	}

	function insertChangeHistory_TestCase($param){
		$oldTCVerNumber = !empty($param->oldTestCaseVersionNo)? $param->oldTestCaseVersionNo : "NULL";
		$newTCVerNumber = !empty($param->newTestCaseVersionNo)? $param->newTestCaseVersionNo : "NULL";

		$sqlStr = "INSERT INTO T_CHANGE_HISTORY_TESTCASE (changeRequestNo, testCaseId, testCaseNo, oldTestCaseVersionNumber, newTestCaseVersionNumber, changeType) VALUES ('$param->changeRequestNo', $param->testCaseId, '$param->testCaseNo', $oldTCVerNumber, $newTCVerNumber, '$param->changeType')";
		$result = $this->db->query($sqlStr);
		return $result;
	}

	function insertChangeHistory_RTMHeader($param){
		$sqlStr = "INSERT INTO T_CHANGE_HISTORY_RTM_HEADER (changeRequestNo, projectId, oldVersionNumber, newVersionNumber) VALUES ('$param->changeRequestNo', $param->projectId, $param->oldVersionNumber, $param->newVersionNumber)";
		$result = $this->db->query($sqlStr);
		if($result){
			$query = $this->db->query("SELECT IDENT_CURRENT('T_CHANGE_HISTORY_RTM_HEADER') as last_id");
			$resultId = $query->result();
			return $resultId[0]->last_id;
		}
		return NULL;
	}

	function updateChangeRequestHeader($param){
		$sqlStr = "UPDATE T_CHANGE_REQUEST_HEADER
			SET changeStatus = '$param->status',
				reason 		 = '$param->reason',
				updateDate 	 = '$param->updateDate',
				updateUser 	 = '$param->user'
			WHERE changeRequestNo = '$param->changeRequestNo'
			AND updateDate = '$param->updateDateCondition'";
		$result = $this->db->query($sqlStr);
		return $this->db->affected_rows();
	}

	function insertChangeHistory_RTMDetail($param){
		$sqlStr = "INSERT INTO T_CHANGE_HISTORY_RTM_DETAIL (rtmHistoryId, sequenceNo, functionId, testCaseId, changeType) VALUES ($param->rtmHistoryId, $param->sequenceNo, $param->functionId, $param->testCaseId, '$param->changeType')";
		$result = $this->db->query($sqlStr);
		return $result;
	}

	function getLastDatabaseSchemaVersion($projectId, $tableName, $columnName){
		$sqlStr = "SELECT schemaVersionId, schemaVersionNumber, updateDate
			FROM M_DATABASE_SCHEMA_VERSION
			WHERE activeFlag = '1'
			AND projectId = $projectId
			AND tableName = '$tableName'
			AND columnName = '$columnName'";
		$result = $this->db->query($sqlStr);
		return $result->row();
	}

	function getLastFunctionalRequirementVersion($functionId){
		/*$sqlStr = "SELECT functionVersionId, functionVersionNumber, updateDate
			FROM M_FN_REQ_VERSION
			WHERE functionId = $functionId
			AND activeFlag = '1'";
*/
		$sqlStr = "SELECT functionId, functionVersionNumber, updateDate
		FROM M_FN_REQ_VERSION
		WHERE functionId = $functionId
		AND activeFlag = '1'";

		$result = $this->db->query($sqlStr);
		return $result->row();
	}
	function getFunctionalRequirementNo($functionId){
		/*$sqlStr = "SELECT functionVersionId, functionVersionNumber, updateDate
			FROM M_FN_REQ_VERSION
			WHERE functionId = $functionId
			AND activeFlag = '1'";
*/
		$sqlStr = "SELECT functionId, functionNo, updateDate
		FROM M_FN_REQ_HEADER
		WHERE functionId = $functionId
		AND activeFlag = '1'";

		$result = $this->db->query($sqlStr);
		return $result->row();
	}
	function getLastFunctionalRequirementNo($functionId){
		/*$sqlStr = "SELECT functionVersionId, functionVersionNumber, updateDate
			FROM M_FN_REQ_VERSION
			WHERE functionId = $functionId
			AND activeFlag = '1'";
*/
		$sqlStr = "SELECT Max(functionNo) AS functionNo
		FROM M_FN_REQ_HEADER
		WHERE activeFlag = '1'";

		$result = $this->db->query($sqlStr);
		return $result->row();
	}	
	function getLastTestCaseVersion($projectId, $testCaseNo, $testCaseVersionNo){
		$sqlStr = "SELECT h.testCaseId,v.testCaseVersion,v.testCaseVersionNumber, v.updateDate
			FROM M_TESTCASE_HEADER h
			INNER JOIN M_TESTCASE_VERSION v
			ON h.testCaseId = v.testCaseId
			WHERE v.activeFlag = '1'
			AND h.projectId = $projectId
			AND h.testCaseNo = '$testCaseNo'
			AND v.testCaseVersion = $testCaseVersionNo";
		$result = $this->db->query($sqlStr);	
		return $result->row();
	}

	function getLastRTMVersion($projectId){
		$sqlStr = "SELECT 
				rtmVersionId,
				rtmVersionNumber,
				updateDate
			FROM M_RTM_VERSION 
			WHERE projectId = $projectId
			AND activeFlag = '1'";
		$result = $this->db->query($sqlStr);	
		return $result->row();
	}

	function getChangeRequestInformation($changeRequestNo){
		$sqlStr = "SELECT 
				h.changeRequestNo,
				CONVERT(nvarchar, h.changeDate, 103) as changeDate,
				CONCAT(u.firstname, '   ', u.lastname) as changeUser,
				h.changeStatus,
				h.changeFunctionId,
				h.changeFunctionNo,
				h.changeFunctionVersion,
				fh.functionDescription,
				h.updateDate
			FROM T_CHANGE_REQUEST_HEADER h 
			INNER JOIN M_USERS u 
			ON h.changeUserId = u.userId 
			INNER JOIN M_FN_REQ_HEADER fh 
			ON h.changeFunctionId = fh.functionId 
			WHERE h.changeRequestNo = '$changeRequestNo'";
		$result = $this->db->query($sqlStr);
		return $result->first_row();
	}

	function getChangeRequestInputList($changeRequestNo){
		$sqlStr = "SELECT *
			FROM T_CHANGE_REQUEST_DETAIL
			WHERE changeRequestNo = '$changeRequestNo' 
			ORDER BY sequenceNo";
		$result = $this->db->query($sqlStr);
		return $result->result_array();
	}

	function getChangeHistoryFnReqHeaderList($changeRequestNo){
		$sqlStr = "SELECT c.*, f.functionDescription 
			FROM T_CHANGE_HISTORY_REQ_HEADER c 
			INNER JOIN M_FN_REQ_HEADER f 
			ON c.functionId = f.functionId
			WHERE c.changeRequestNo = '$changeRequestNo' 
			ORDER BY c.functionNo";
		$result = $this->db->query($sqlStr);
		return $result->result_array();	
	}

	function getChangeHistoryFnReqDetailList($fnReqHistoryId){
		$sqlStr = "SELECT *
			FROM T_CHANGE_HISTORY_REQ_DETAIL
			WHERE fnReqHistoryId = $fnReqHistoryId
			ORDER BY sequenceNo";
		$result = $this->db->query($sqlStr);
		return $result->result_array();	
	}

	function getChangeHistoryDatabaseSchemaList($changeRequestNo){
		$sqlStr = "SELECT * FROM T_CHANGE_HISTORY_SCHEMA 
			WHERE changeRequestNo = '$changeRequestNo'
			AND changeType <> ''
			ORDER BY tableName, columnName";
		$result = $this->db->query($sqlStr);
		return $result->result_array();	
	}

	function getChangeHistoryTestCaseList($changeRequestNo){
		$sqlStr = "SELECT ht.*, rh.functionNo  
			FROM T_CHANGE_HISTORY_TESTCASE ht
			INNER JOIN M_RTM r
			ON ht.testCaseId = r.testCaseId
			INNER JOIN M_FN_REQ_HEADER rh
			ON r.functionId = rh.functionId
			WHERE ht.changeRequestNo = '$changeRequestNo'
			ORDER BY ht.testCaseNo";
		$result = $this->db->query($sqlStr);
		return $result->result_array();	
	}

	function getChangeHistoryRTM($changeRequestNo){
		$sqlStr = "SELECT 
				h.changeRequestNo, 
				h.oldVersionNumber,
				h.newVersionNumber,
				d.testCaseId,
				t.testCaseNo,
				d.functionId,
				r.functionNo,
				d.changeType 
			FROM T_CHANGE_HISTORY_RTM_HEADER h
			INNER JOIN T_CHANGE_HISTORY_RTM_DETAIL d
			ON h.rtmHistoryId = d.rtmHistoryId 
			INNER JOIN M_FN_REQ_HEADER r
			ON d.functionId = r.functionId
			INNER JOIN M_TESTCASE_HEADER t
			ON d.testCaseId = t.testCaseId
			WHERE h.changeRequestNo = '$changeRequestNo'
			ORDER BY r.functionNo, t.testCaseNo";
		$result = $this->db->query($sqlStr);
		return $result->result_array();
	}

	function getChangeHistoryRTMDetail($changeRequestNo){
		$sqlStr = "SELECT h.changeRequestNo, h.projectId, h.oldVersionNumber, h.newVersionNumber, d.functionId, d.testCaseId, d.changeType 
			FROM T_CHANGE_HISTORY_RTM_HEADER h
			INNER JOIN T_CHANGE_HISTORY_RTM_DETAIL d
			ON h.rtmHistoryId = d.rtmHistoryId
			WHERE h.changeRequestNo = '$changeRequestNo'";
		$result = $this->db->query($sqlStr);
		return $result->result_array();
	}

	function changeProcess($changeInfo, &$changeResult, $connectionDB, $user, &$error_message, &$changeRequestNo){
		$this->db->trans_begin();

		$resultSuccess = $this->controlVersionCaseChangeRequest($changeResult, $connectionDB, $user, $error_message);

		if($resultSuccess){
			//Save ChangeRequest & ChangeHistory
			$resultSuccess = $this->saveChangeRequestInformation($changeInfo, $changeResult, $user, $error_message, $changeRequestNo);
		}

    	$trans_status = $this->db->trans_status();
	    if($trans_status == FALSE || !$resultSuccess){
	    	$this->db->trans_rollback();
	    	return false;
	    }else{
	   		$this->db->trans_commit();
	   		return true;
	    }
	}

	private function controlVersionCaseChangeRequest(&$changeResult, $connectionDB, $user, &$error_message){
		//$this->db->trans_start(); //Starting Transaction
		
		$errorFlag = false;
		$affectedProjectId = $changeResult->projectInfo;
		$affectedRequirements = $changeResult->affectedRequirement;
		$affectedSchemaList = $changeResult->affectedSchema;
		$affectedTestCase = $changeResult->affectedTestCase;
		$affectedRTM = $changeResult->affectedRTM;

		$newCurrentDate = date('Y-m-d H:i:s');

		//**[Version Control of Database Schema]
		foreach($affectedSchemaList as $value){
			$oldDBVersionNumber = '';

			$lastDBVersionInfo = $this->getLastDatabaseSchemaVersion($affectedProjectId, $value->tableName, $value->columnName);

			if(empty($value->affectedAction)){
				if(0 == count($lastDBVersionInfo)){
					$newDBVersionNumber = INITIAL_VERSION;
				}else{
					$value->oldSchemaVersionNo = $lastDBVersionInfo->schemaVersionNumber;
					$value->newSchemaVersionNo = '';
					continue;
				}
			}else{
				if(0 < count($lastDBVersionInfo)){
					$oldDBVersionId = $lastDBVersionInfo->schemaVersionId;
					$oldDBVersionNumber = $lastDBVersionInfo->schemaVersionNumber;
					$oldDBUpdateDate = $lastDBVersionInfo->updateDate;

					//update old version
					$dbParam = (object) array(
						'effectiveEndDate' => $newCurrentDate,
						'tableName' => $value->tableName,
						'columnName' => $value->columnName,
						'currentDate' => $newCurrentDate,
						'activeFlag' => UNACTIVE_CODE,
						'user' => $user,
						'projectId' => $affectedProjectId,
						'oldSchemaVersionId' => $oldDBVersionId,
						'oldUpdateDate' => $oldDBUpdateDate);
					$rowUpdate = $this->mDB->updateDatabaseSchemaVersion($dbParam);
					if(0 == $rowUpdate){
						$errorFlag = true;
						$error_message = str_replace("{0}", "Database Schema", ER_MSG_016);
						break;
					}
					$newDBVersionNumber = (int)$oldDBVersionNumber + 1;
				}else{
					$newDBVersionNumber = INITIAL_VERSION;
				}
			}
			
			if(CHANGE_TYPE_DELETE != $value->affectedAction){
				$value->oldSchemaVersionNo = $oldDBVersionNumber;
				$value->newSchemaVersionNo = $newDBVersionNumber;

				//insert database schema data
				$dbParam = (object) array(
						'projectId' => $affectedProjectId,
						'tableName' => $value->tableName,
						'columnName' => $value->columnName,
						'schemaVersionNo' => $newDBVersionNumber,
						'previousVersionId' => $oldDBVersionId,
						'status' => ACTIVE_CODE);
				$resultInsert = $this->mDB->insertDatabaseSchemaVersion($dbParam, $user);
				if(null != $resultInsert){
					$schemaVersionId = $resultInsert;
				}else{
					$errorFlag = true;
					$error_message = str_replace("{0}", "Database Schema", ER_MSG_016);
					break;
				}

				//insert database schema detail**(get direct from database target)
				$dbSchemaDetail = $this->mDB->getSchemaFromDatabaseTarget($connectionDB, $value->tableName, $value->columnName);
				if(!empty($dbSchemaDetail)){
					$dataLength = '';
					$scaleLength = '';
					$defaultValue = '';

					$miscResult = $this->mMisc->searchMiscellaneous(MISC_DATA_INPUT_DATA_TYPE, $dbSchemaDetail['dataType']);
					$dataTypeCategory = $miscResult[0]['miscValue2'];
					if(DATA_TYPE_CATEGORY_STRINGS == $dataTypeCategory){
						$dataLength = $dbSchemaDetail['charecterLength'];
					}else if(DATA_TYPE_CATEGORY_NUMERICS == $dataTypeCategory){
						if("decimal" == $dbSchemaDetail['dataType']){
							$dataLength = $dbSchemaDetail['numericPrecision'];
							$scaleLength = $dbSchemaDetail['numericScale'];
						}
					}

					$defaultValue = $dbSchemaDetail['columnDefault'];
					if(!empty($dbSchemaDetail['columnDefault'])){
						if(DATA_TYPE_CATEGORY_DATE == $dataTypeCategory){
							$defaultValue = substr($defaultValue, 1, -1);
						}else{
							$replaceStr = array('(', ')', "'");
							$defaultValue = str_replace($replaceStr, '', $defaultValue);
						}
					}

					$param = (object) array(
						'tableName' => strtoupper($dbSchemaDetail['tableName']),
						'columnName' => strtoupper($dbSchemaDetail['columnName']),
						'schemaVersionId' => $schemaVersionId,
						'dataType' => $dbSchemaDetail['dataType'],
						'dataLength' => $dataLength,
						'scale' => $scaleLength,
						'defaultValue' => $defaultValue,
						'minValue' => $dbSchemaDetail['minValue'],
						'maxValue' => $dbSchemaDetail['maxValue'],
						'primaryKey' => $dbSchemaDetail['isPrimaryKey'],
						'unique' => $dbSchemaDetail['isUnique'],
						'null' => $dbSchemaDetail['isNotNull']);
					$resultInsert = $this->mDB->insertDatabaseSchemaInfo($param, $affectedProjectId);
				}else{
					$errorFlag = true;
					$error_message = ER_TRN_013;
					break;
				}
			}else{
				$value->oldSchemaVersionNo = $oldDBVersionNumber;
				$value->newSchemaVersionNo = '';
			}
		}//endforeach; (database schema)

		//**[Version Control of Functional Requirements]
		if(!$errorFlag){
		foreach($affectedRequirements as $keyFunctionNo => $functionInfoVal){
			$keyFunctionId = '';
//echo $keyFunctionId;
			$existFR = $this->mFR->searchExistFunctionalRequirement($keyFunctionNo, $affectedProjectId);

			if(null != $existFR && !empty($existFR)){
				$oldFunctionId = $existFR[0]['functionId'];
			}else{
				$errorFlag = true;
				$error_message = str_replace("{0}", "Functional Requirements", ER_MSG_016);
				break;
			}

			//3.1 get latest function version id
			$oldFnVersionNumber = $functionInfoVal->functionVersion;
			$resultLastFRInfo = $this->getLastFunctionalRequirementVersion($oldFunctionId, $oldFnVersionNumber);
			if($value->changeType = 'add'){
				$resultLastFRNo = $this->getLastFunctionalRequirementNo($oldFunctionId, $oldFnVersionNumber);
			}else{
				$resultLastFRNo = $this->getFunctionalRequirementNo($oldFunctionId, $oldFnVersionNumber);
			}

			if(null == $resultLastFRInfo || 0 == count($resultLastFRInfo)){
				$errorFlag = true;
				$error_message = ER_TRN_012;
				break;
			}

			//$oldFRVersionId = $resultLastFRInfo->functionVersionId;
			$oldFRVersionId = $resultLastFRInfo->functionId;
			$oldFRVersionUpdateDate = $resultLastFRInfo->updateDate;
			$newFRVersionNumber = (int)$resultLastFRInfo->functionVersionNumber + 1;
			if($value->changeType = 'add'){
				$newFRNo = substr($resultLastFRNo->functionNo,0,7).(substr($resultLastFRNo->functionNo,7,7)+1);
			}else{
				$newFRNo = $resultLastFRNo->functionNo;
			}
			//3.1.1 Create new version of function
	/*		$param = (object) array(
				'functionId' => $oldFunctionId,
				'functionVersionNo' => $newFRVersionNumber,
				'effectiveStartDate' => $newCurrentDate,
				'effectiveEndDate' => '',
				'activeFlag' => ACTIVE_CODE,
				'previousVersionId' => $oldFRVersionId,
				'currentDate' => $newCurrentDate,
				'user' => $user);
			$newFRVersionId = $this->mFR->insertFRVersion($param);
			
			//3.1.2 Update disabled previous version
			$param->effectiveEndDate = $newCurrentDate;
			$param->activeFlag = UNACTIVE_CODE;
			//condition
			$param->oldFunctionVersionId = $oldFRVersionId;
			$param->oldUpdateDate = $oldFRVersionUpdateDate;

			$rowUpdate = $this->mFR->updateFunctionalRequirementsVersion($param);
			if(0 == $rowUpdate){
				$errorFlag = true;
				$error_message = str_replace("{0}", "Functional Requirements", ER_MSG_016);
				break;
			}
*/
			$param = (object) array(
				'functionId' => $oldFunctionId,
				'functionVersionNo' => $newFRVersionNumber,
				'effectiveStartDate' => $newCurrentDate,
				'effectiveEndDate' => '',
				'functionDescription' =>'',
				'activeFlag' => ACTIVE_CODE,
				'previousVersionId' => $oldFRVersionId,
				'currentDate' => $newCurrentDate,
				'user' => $user,
				'functionNo' => $newFRNo,
				'projectId' => $affectedProjectId);
			//$newFRVersionId = $this->mFR->insertFRVersion($param);
			$newFRVersionId = $this->mFR->insertFRHeader($param);
		//echo $newFRVersionId;
			//3.1.2 Update disabled previous version
			$param->effectiveEndDate = $newCurrentDate;
			$param->activeFlag = UNACTIVE_CODE;
			//condition
			$param->oldFunctionVersionId = $oldFRVersionId;
			$param->oldUpdateDate = $oldFRVersionUpdateDate;

			//$rowUpdate = $this->mFR->updateFunctionalRequirementsVersion($param);
			$rowUpdate = $this->mFR->updateFunctionalRequirementsNo($param);

			if(0 == $rowUpdate){
				$errorFlag = true;
				$error_message = str_replace("{0}", "Functional Requirements", ER_MSG_016);
				break;
			}
			//3.2 Create new input of FR information
		//echo $functionInfoVal->functionData;
		foreach($functionInfoVal->functionData as $keyInputName => $value){
			//echo $keyInputName;
/*echo $keyInputName;
				$resultExistInput = $this->mFR->searchFRInputInformation($affectedProjectId, $keyInputName, ACTIVE_CODE);
				var_dump($affectedProjectId."|".$keyInputName);
				var_dump($resultExistInput);


				if(null == $resultExistInput || 0 == count($resultExistInput)){
					//insert new input (case: never has input before)
					$paramFRData = (object) array(
						'projectId' => $affectedProjectId,
					//	'inputName' => $keyInputName,
						'typeData' => $value->typeData,
						'dataName' => $keyInputName,
						'referTableName' => $value->tableName,
						'referColumnName' => $value->columnName,
						'user' => $user,
						'functionNo' => $newFRNo,
						'dataType'=>$value->dataType);
					$resultDataId = $this->mFR->insertFRInput($newFRVersionId,$paramFRData);
					$dataId = $resultDataId;
				}else{
					//$inputId = $resultExistInput->inputId;
					$dataId = $resultExistInput->dataId;

					$paramFRInputCondition = (object) array(
						'functionId' => $oldFunctionId,
						'inputName' => $keyInputName,
						'inputActiveFlag' => ACTIVE_CODE);
					$resultFRInput = $this->mFR->searchExistFRInputInFunctionalRequirement($paramFRInputCondition);
					if(null != $resultFRInput && 0 < count($resultFRInput)){
						$oldSchemaVersionId = $resultFRInput[0]['schemaVersionId'];
					}
				}
*/
				if("add" == $value->changeType || "edit" == $value->changeType){

					//find latest version of reference schema that related with function's input
					//$resultSchemaInfo = $this->mDB->searchExistDatabaseSchemaInfo($value->refTableName, $value->refColumnName, $affectedProjectId);
					if (null != $value->tableName){
						$resultSchemaInfo = $this->mDB->searchExistDatabaseSchemaInfo($value->tableName, $value->columnName, $affectedProjectId);
						$schemaVersionId = $resultSchemaInfo->schemaVersionId;
					}else{
						$schemaVersionId = null;
					}	
					//Check exist InputId and SchemaVersionId
					$criteria = (object) array(
						'functionId' 	  => $oldFunctionId,
						//'dataId' 	 	  => $dataId, 
						'dataName'			=> $keyInputName,
						'schemaVersionId' => $schemaVersionId);
					$resultFRInputDetail = $this->mFR->searchExistFRInputInFunctionalRequirement($criteria);
					if(null != $resultFRInputDetail && 0 < count($resultFRInputDetail)){
						//Update input detail
						$paramFRDetail = (object) array(
							'user' => $user,
							'activeFlag' => ACTIVE_CODE,
							'currentDate' => $newCurrentDate,
							'effectiveEndDate' => '',
						//	'dataId' => $dataId,
							'functionId' => $oldFunctionId,
							'oldSchemaVersionId' => $oldSchemaVersionId);
						$resultUpdate = $this->mFR->updateFunctionalRequirementsDetail($paramFRDetail);
						if(0 == $resultUpdate){
							$errorFlag = true;
							$error_message = str_replace("{0}", "Functional Requirements", ER_MSG_016);
							break 2;
						}
					}else{
						//echo $keyInputName;
						//echo $oldFRVersionId;
						$paramSearch = (object) array(
							'functionId' => $oldFunctionId,
							'functionVersion' => $oldFnVersionNumber,
							'dataName' =>$keyInputName
							);
						$ChangeList = $this->searchFRInputChangeList($paramSearch);				
						//echo $tmpChangeList->newDataType;
						//insert new version input detail
						$paramFRDetail = (object) array(
							//'dataId' => $dataId,
							'projectId' =>$affectedProjectId,
							'functionNo'=>$newFRNo,
							'dataName'			=> $keyInputName,
							'schemaVersionId' => $schemaVersionId,
							'effectiveStartDate' => $newCurrentDate,
							'effectiveEndDate' => '',
							'activeFlag' => ACTIVE_CODE,
							'user' => $user,
							'typeData'=>$ChangeList->typeData,
							'schemaVersionId' => $ChangeList->schemaVersionId,
							'dataType'=>$ChangeList->newDataType,
							'dataLength'=>$ChangeList->newDataLength,
							'decimalPoint'=>$ChangeList->newScaleLength,
							'constraintPrimaryKey'=>'',
							'constraintUnique'=>$ChangeList->newUnique,
							'constraintDefault'=>$ChangeList->newDefaultValue,
							'constraintNull'=>$ChangeList->newNotNull,
							'constraintMinValue'=>$ChangeList->newMinValue,
							'constraintMaxValue'=>$ChangeList->newMaxValue,
							'referTableName'=>$ChangeList->tableName,
							'referColumnName'=>$ChangeList->columnName);
						//insertFRDetail
						//$resultInsert = $this->mFR->insertFRDetail($oldFunctionId, $paramFRDetail);
						$resultInsert = $this->mFR->insertFRInput($oldFunctionId, $paramFRDetail);
					}
				}

				if("edit" == $value->changeType || "delete" == $value->changeType){
					//update disabled input
					$paramFRDetail = (object) array(
						'user' => $user,
						'activeFlag' => UNACTIVE_CODE,
						'currentDate' => $newCurrentDate,
						'effectiveEndDate' => $newCurrentDate,
						'functionId' => $oldFunctionId,
						'dataId' => $dataId,
						'oldSchemaVersionId' => $oldSchemaVersionId);
					$resultUpdate = $this->mFR->updateFunctionalRequirementsDetail($paramFRDetail);
					if(0 == $resultUpdate){
						$errorFlag = true;
						$error_message = str_replace("{0}", "Functional Requirements", ER_MSG_016);
						break 2;
					}
				}
			}
		}//endforeach; (functional requirement)
		}
		
		//**[Version Control of Test Cases]
		if(!$errorFlag){
		foreach($affectedTestCase as $keyTestCaseNo => $testcaseInfoVal){
			$testCaseId = '';
			$oldTCVersionNumber = '';
			$newTCVersionNumber = '';

			if(CHANGE_TYPE_ADD == $testcaseInfoVal->changeType){
				//insert new TEST CASE header
				$param = (object) array(
					'testCaseNo' => $keyTestCaseNo,
					'testCaseDescription' => $testcaseInfoVal->testCaseDesc,
					'expectedResult' => $testcaseInfoVal->expectedResult,
					'projectId' => $affectedProjectId);
				$testCaseId = $this->mTestCase->insertTestCaseHeader($param, $user);
				if(null == $testCaseId){
					$errorFlag = true;
					$error_message = str_replace("{0}", "Test Case", ER_MSG_016);
					break;
				}
				$oldTCVersionId = '';
				$newTCVersionNumber = INITIAL_VERSION;
			}else{
				$resultLastTCVersion = $this->getLastTestCaseVersion($affectedProjectId, $keyTestCaseNo, $testcaseInfoVal->testCaseVersion);
				if(null == $resultLastTCVersion || 0 == count($resultLastTCVersion)){
					$errorFlag = true;
					$error_message = str_replace("{0}", "Test Case", ER_MSG_016);
					break;
				}

				$testCaseId = $resultLastTCVersion->testCaseId;
				//$oldTCVersionId = $resultLastTCVersion->testCaseVersionId;
				$oldTCVersionId = $resultLastTCVersion->testCaseVersion;
				$oldTCVersionNumber = (int)$resultLastTCVersion->testCaseVersionNumber;
				$newTCVersionNumber = $oldTCVersionNumber + 1;
				$oldUpdateDate = $resultLastTCVersion->updateDate;
			}

			$testcaseInfoVal->testCaseId = $testCaseId;
			$testcaseInfoVal->oldVerNO = $oldTCVersionNumber;
			if(CHANGE_TYPE_DELETE != $testcaseInfoVal->changeType){
				$testcaseInfoVal->newVerNO = $newTCVersionNumber;
			}else{
				$testcaseInfoVal->newVerNO = '';
			}
			$New_TCNo = $this->mTestCase->searchFRMAXTCNo();
			//echo $New_TCNo->Max_TCNO;

			//Insert Test Case Version.
			if(CHANGE_TYPE_ADD == $testcaseInfoVal->changeType 
				|| CHANGE_TYPE_EDIT == $testcaseInfoVal->changeType){

				$paramInsert = (object) array(
					'testCaseId' 		 => $testCaseId,
					'initialVersionNo' 	 => $newTCVersionNumber,
					'effectiveStartDate' => $newCurrentDate,
					'previousVersionId'  => $oldTCVersionId,
					'activeStatus' 		 => ACTIVE_CODE,
					'testCaseNo'		=> $New_TCNo->Max_TCNO);
				$result = $this->mTestCase->insertTestCaseVersion($paramInsert, $user);
			}
			
			//Disabled Old Test Case Version.
			if(CHANGE_TYPE_EDIT == $testcaseInfoVal->changeType 
				|| CHANGE_TYPE_DELETE == $testcaseInfoVal->changeType){
				$paramUpdate = (object) array(
					'effectiveEndDate' 	=> $newCurrentDate,
					'activeFlag' 		=> UNACTIVE_CODE,
					'updateDate' 		=> $newCurrentDate,
					'updateUser' 		=> $user,
					'testCaseId' 		=> $testCaseId,
					'testCaseVersionId' => $oldTCVersionId,
					'updateDateCondition' 	=> $oldUpdateDate);
				$rowUpdate = $this->mTestCase->updateTestCaseVersion($paramUpdate);
				if(0 == $rowUpdate){
					$errorFlag = true;
					$error_message = str_replace("{0}", "Test Case", ER_MSG_016);
					break;
				}
			}

			//Insert or Update Test Case Detail
			//echo  $testcaseInfoVal->testCaseDetails;
			foreach($testcaseInfoVal->testCaseDetails as $keyInputName => $value){
echo $keyInputName;
				$resultInputInfo = $this->mFR->searchFRInputInformation($affectedProjectId, $keyInputName, ACTIVE_CODE);
				if(null == $resultInputInfo || 0 == count($resultInputInfo)){
					$errorFlag = true;
					$error_message = str_replace("{0}", "Test Case", ER_MSG_016);
					break 2;
				}

				if(CHANGE_TYPE_EDIT == $value->changeType 
					|| CHANGE_TYPE_DELETE == $value->changeType){
					$paramUpdateDetail = (object) array(
						'effectiveEndDate' 	=> $newCurrentDate, 
						'activeFlag' 		=> UNACTIVE_CODE, 
						'updateDate' 		=> $newCurrentDate, 
						'updateUser' 		=> $user, 
						'testCaseId' 		=> $testCaseId, 
						'inputId' 			=> $resultInputInfo->inputId, 
						'activeFlagCondition' => ACTIVE_CODE);

					$rowUpdate =  $this->mTestCase->updateTestCaseDetail($paramUpdateDetail);
					If(0 == $rowUpdate){
						$errorFlag = true;
						$error_message = str_replace("{0}", "Test Case", ER_MSG_016);
						break;
					}
				}

				if(CHANGE_TYPE_ADD == $value->changeType 
					|| CHANGE_TYPE_EDIT == $value->changeType){
					$paramInsertDetail = (object) array(
						'testCaseId' 	=> $testCaseId, 
						'refInputId' 	=> $resultInputInfo->inputId, 
						'refInputName' 	=> $keyInputName, 
						'testData' 		=> $value->testData, 
						'effectiveStartDate' => $newCurrentDate, 
						'activeStatus' 	=> ACTIVE_CODE);
					$resultInsert = $this->mTestCase->insertTestCaseDetail($paramInsertDetail, $user);
				}
			}
		}//endforeach; (test case)
		}

		//**[Version Control of RTM]
		if(!$errorFlag 
			&& isset($affectedRTM) 
			&& 0 < count($affectedRTM) 
			&& !empty($affectedRTM->details)){
		
			//Get Latest RTM Info
			$resultLastRTMInfo = $this->getLastRTMVersion($affectedProjectId);
			$newRTMVersionNumber = (int)$resultLastRTMInfo->rtmVersionNumber + 1;
			$oldRtmVersionId = $resultLastRTMInfo->rtmVersionId;
			$oldRtmUpdateDate = $resultLastRTMInfo->updateDate;

			$affectedRTM->oldRTMVerNO = $resultLastRTMInfo->rtmVersionNumber;
			$affectedRTM->newRTMVerNO = $newRTMVersionNumber;

			//Update Disabled Old RTM Version
			$paramUpdate = (object) array(
				'effectiveEndDate' => $newCurrentDate,
				'activeFlag' => UNACTIVE_CODE,
				'updateDate' => $newCurrentDate,
				'user' => $user,
				'rtmVersionIdCondition' => $oldRtmVersionId,
				'projectId' => $affectedProjectId,
				'updateDateCondition' => $oldRtmUpdateDate);

			$rowUpdate = $this->mRTM->updateRTMVersion($paramUpdate);
			if(1 != $rowUpdate){
				$errorFlag = true;
				$error_message = str_replace("{0}", "RTM", ER_MSG_016);
				break;
			}

			//Insert New RTM Version
			$paramInsert = (object) array(
				'projectId' 		 => $affectedProjectId,
				'versionNo' 	 	 => $newRTMVersionNumber,
				'effectiveStartDate' => $newCurrentDate, 
				'activeFlag' 		 => ACTIVE_CODE,
				'previousVersionId'  => $oldRtmVersionId);

			$this->mRTM->insertRTMVersion($paramInsert, $user);

			foreach($affectedRTM->details as $value){
				$functionId = "";
				$testCaseId = "";

				//get Functional Requirement Info
				$resultFRInfo = $this->mFR->searchExistFunctionalRequirement($value->functionNo, $affectedProjectId);
				if(null == $resultFRInfo || 0 == count($resultFRInfo)){
					$errorFlag = true;
					$error_message = str_replace("{0}", "RTM", ER_MSG_016);
					break;
				}

				$functionId = $resultFRInfo[0]['functionId'];

				//get Test Case Info
				$resultTCInfo = $this->mTestCase->searchExistTestCaseHeader($affectedProjectId, $value->testCaseNo);
				if(null == $resultTCInfo || 0 == count($resultTCInfo)){
					$errorFlag = true;
					$error_message = str_replace("{0}", "RTM", ER_MSG_016);
					break;
				}

				$testCaseId = $resultTCInfo->testCaseId;

				//set Function Id & Test case Id
				$value->functionId = $functionId;
				$value->testCaseId = $testCaseId;

				//Insert RTM Info
				if(CHANGE_TYPE_ADD == $value->changeType){
					$paramInsert = (object) array(
						'projectId' 			=> $affectedProjectId,
						'functionId' 			=> $functionId,
						'testCaseId' 			=> $testCaseId,
						'effectiveStartDate' 	=> $newCurrentDate,
						'activeFlag' 			=> ACTIVE_CODE);
					$this->mRTM->insertRTMInfo($paramInsert, $user);
				}

				//Update RTM Info
				if(CHANGE_TYPE_DELETE == $value->changeType){
					$paramUpdate = (object) array(
						'effectiveEndDate'  => $newCurrentDate,
						'activeFlag' 		=> UNACTIVE_CODE,
						'updateDate' 		=> $newCurrentDate,
						'user' 				=> $user,
						'projectId' 		=> $affectedProjectId,
						'functionId' 		=> $functionId,
						'testCaseId' 		=> $testCaseId);
					$rowUpdate = $this->mRTM->updateRTMInfo($paramUpdate);
					if(1 != $rowUpdate){
						$errorFlag = true;
						$error_message = str_replace("{0}", "RTM", ER_MSG_016);
						break;
					}
				}
			}
		}

		//**[Update FR Input's Status]
		foreach($affectedSchemaList as $value) {
			if(CHANGE_TYPE_DELETE == $value->affectedAction){
				$inputInfo = $this->mFR->searchExistFRInputsByTableAndColumnName($value->tableName, $value->columnName, $affectedProjectId, ACTIVE_CODE);

				//Disable ACTIVE FLAG of FR INPUT
				$paramUpdate = (object) array(
					'activeFlag' => UNACTIVE_CODE, 
					'updateDate' => $newCurrentDate, 
					'updateUser' => $user,
					'projectId'  => $affectedProjectId,
					'inputId'    => $inputInfo->inputId);
				//var_dump($value->tableName."|".$value->columnName."|".$affectedProjectId);
				$rowUpdate = $this->mFR->updateStatusFRInput($paramUpdate);
				if(1 !== $rowUpdate){
					$errorFlag = true;
					$error_message = str_replace("{0}", "Update FR Input's status", ER_MSG_016);
					break;
				}
			}
		}

		//return result;
		if($errorFlag) {
			return false;
		}else{
			return true;
		}
		
	}

	private function saveChangeRequestInformation($changeInfo, $changeResult, $user, &$error_message, &$changeRequestNo = ''){
		
		$newCurrentDate = date('Y-m-d H:i:s');

		$affectedProjectId = $changeResult->projectInfo;
		$affectedRequirements = $changeResult->affectedRequirement;
		$affectedSchemaList = $changeResult->affectedSchema;
		$affectedTestCase = $changeResult->affectedTestCase;
		$affectedRTM = $changeResult->affectedRTM;

		//1. save change request header.
		$changeRequestNo = $this->mCommon->getChangeRequestNo(RUNNING_TYPE_CHANGE_REQUEST_NO);
		if(empty($changeRequestNo)){
			$error_message = str_replace("{0}", "Change Request", ER_MSG_016);
			return false;
		}

		$paramSearch = (object) array(
			'userId' => $changeInfo->userId,
			'functionId' => $changeInfo->functionId,
			'functionVersion' => $changeInfo->functionVersion,
			'staffflag' => $changeInfo->staffflag);
		$tmpChangeList = $this->searchTempFRInputChangeList($paramSearch);
		if(0 == count($tmpChangeList)){
			$error_message = str_replace("{0}", "Change Request", ER_MSG_016);
			return false;
		}

		$resultFnReq = $this->db->query("SELECT functionNo FROM M_FN_REQ_HEADER WHERE functionId = $changeInfo->functionId")->row();

		$paramInsert = (object) array(
			'changeRequestNo' => $changeRequestNo,
			'changeUser' => $changeInfo->userId,
			'changeDate' => $newCurrentDate,
			'projectId' => $changeInfo->projectId,
			'changeFunctionId' => $changeInfo->functionId,
			'changeFunctionNo' => $resultFnReq->functionNo,
			'changeFunctionVersion' => $changeInfo->functionVersion,
			'changeStatus' => CHANGE_STATUS_CLOSE,
			'user' => $user,
			'currentDate' => $newCurrentDate);
		$this->insertChangeRequestHeader($paramInsert);

		//2. save change request details.
		$i = 1;
		foreach($tmpChangeList as $value){
			$paramInsert = (object) array(
				'changeRequestNo' => $changeRequestNo,
				'sequenceNo' => $i++,
				'changeType' => $value['changeType'],
				'dataId' => $value['dataId'],
				'dataName' => $value['dataName'], 
				'schemaVersionId' => $value['schemaVersionId'],
				'dataType' => $value['newDataType'],
				'dataLength' => $value['newDataLength'],
				'scale' => $value['newScaleLength'],
				'unique' => $value['newUnique'],
				'notNull' => $value['newNotNull'],
				'default' => $value['newDefaultValue'],
				'min' => $value['newMinValue'],
				'max' => $value['newMaxValue'],
				'tableName' => $value['tableName'],
				'columnName' => $value['columnName']);
			$this->insertChangeRequestDetail($paramInsert);
		}

		//3. save change history requirement header
		foreach($affectedRequirements as $keyFunctionNo => $functionDetailValue){
			
			$existFR = $this->mFR->searchExistFunctionalRequirement($keyFunctionNo, $affectedProjectId);

			$resultNewVersion = $this->searchRelatedNewVersion_FnReq($existFR[0]['functionId'], $functionDetailValue->functionVersion);

			$paramInsert = (object) array(
				'changeRequestNo' 	 => $changeRequestNo,
				'functionNo'		 => $keyFunctionNo,
				'functionId' 		 => $existFR[0]['functionId'],
				'oldFnVersionNumber' => $functionDetailValue->functionVersion,
				'newFnVersionNumber' => $resultNewVersion->functionVersionNumber);

			$fnReqHistoryId = $this->insertChangeHistory_RequirementsHeader($paramInsert);
			if(empty($fnReqHistoryId)){
				$error_message = str_replace("{0}", "Change Request", ER_MSG_016);
				return false;
			}

			//3.1 save change history requirement detail
			$i = 1;
			foreach($functionDetailValue->functionData as $keyInputName => $value){

				$paramInsert = (object) array(
				'fnReqHistoryId' 	 => $fnReqHistoryId,
				'sequenceNo' 	 	 => $i++,
				'changeType'  	 	 => $value->changeType,
				'inputName' 	 	 => $keyInputName,
				'refTableName' 	 	 => $value->refTableName,
				'refColumnName' 	 => $value->refColumnName);

				$this->insertChangeHistory_RequirementsDetail($paramInsert);
			}
		}

		//4. save change history database schema
		$i = 1;
		foreach($affectedSchemaList as $value){
			$paramInsert = (object) array(
				'changeRequestNo' => $changeRequestNo,
				'sequenceNo' => $i++,
				'changeType' => $value->affectedAction,
				'tableName'  => $value->tableName,
				'columnName' => $value->columnName,
				'oldSchemaVersionNumber' => $value->oldSchemaVersionNo,
				'newSchemaVersionNumber' => $value->newSchemaVersionNo);

			$this->insertChangeHistory_Schema($paramInsert);
		}

		//5. save change history test case
		foreach($affectedTestCase as $keyTestCaseNo => $value){
			$paramInsert = (object) array(
				'changeRequestNo' => $changeRequestNo,
				'testCaseId' => $value->testCaseId,
				'testCaseNo' => $keyTestCaseNo,
				'oldTestCaseVersionNo' => $value->oldVerNO,
				'newTestCaseVersionNo' => $value->newVerNO,
				'changeType' => $value->changeType);
			$this->insertChangeHistory_TestCase($paramInsert);
		}

		//6. save change history RTM header and detail
		if(isset($affectedRTM) && 0 < count($affectedRTM) && !empty($affectedRTM->details)){

			$paramInsert = (object) array(
				'changeRequestNo' => $changeRequestNo,
				'projectId' => $affectedProjectId,
				'oldVersionNumber' => $affectedRTM->oldRTMVerNO,
				'newVersionNumber' => $affectedRTM->newRTMVerNO);

			$rtmHistoryId = $this->insertChangeHistory_RTMHeader($paramInsert);

			$i = 1;
			foreach($affectedRTM->details as $value){
				$paramInsert = (object) array(
					'rtmHistoryId' => $rtmHistoryId,
					'sequenceNo' => $i++,
					'functionId' => $value->functionId,
					'testCaseId' => $value->testCaseId,
					'changeType' => $value->changeType);
				$this->insertChangeHistory_RTMDetail($paramInsert);
			}
		}

		return true;
	}

	private function searchRelatedNewVersion_FnReq($functionId, $functionVersion){
		$sqlStr = "SELECT b.functionVersionNumber
			FROM M_FN_REQ_VERSION a
			INNER JOIN M_FN_REQ_VERSION b
			ON a.functionVersionId = b.previousVersionId
			and a.functionId = b.functionId
			WHERE a.functionId = $functionId 
			AND a.functionVersionNumber = $functionVersion";
		$result = $this->db->query($sqlStr);
		return $result->row();
	}

	function updateTempFRInputChangeList($functionId, $functionVersion){
		$this->db->trans_start(); //Starting Transaction
		$this->db->trans_strict(FALSE);

		$sql = "UPDATE T_TEMP_CHANGE_LIST
			SET confirmflag = '1'
			WHERE functionId = $functionId 
			AND functionVersion = $functionVersion";
//echo $functionId;
		$this->db->query($sql);
		$this->db->trans_complete();
    	$trans_status = $this->db->trans_status();
	    if($trans_status == FALSE){
	    	$this->db->trans_rollback();
	    	return FALSE;
	    }else{
	   		$this->db->trans_commit();
	   		return TRUE;
	    }
	}

	private function updateApproveInputChangeList($functionId, $functionVersion){
		$this->db->trans_start(); //Starting Transaction
		$this->db->trans_strict(FALSE);

		$sql = "UPDATE T_TEMP_CHANGE_LIST
			SET approveflag = '1'
			WHERE functionId = $functionId 
			AND functionVersion = $functionVersion
			AND activeflag = '1' ";

		$this->db->query($sql);
		$this->db->trans_complete();
    	$trans_status = $this->db->trans_status();
	    if($trans_status == FALSE){
	    	$this->db->trans_rollback();
	    	return FALSE;
	    }else{
	   		$this->db->trans_commit();
	   		return TRUE;
	    }		
	}
}
?>