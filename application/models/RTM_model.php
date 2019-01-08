<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
* Requirements Traceability Matrix Model
*/
class RTM_model extends CI_Model{
	
	function __construct(){
		parent::__construct();
		$this->load->model('FunctionalRequirement_model', 'mFR');
		$this->load->model('TestCase_model', 'mTestCase');
	}

	function searchRTMInfoByCriteria($projectId){
		/*$sqlStr = "SELECT 
				f.functionNo,
				t.testCaseNo,
				CONVERT(nvarchar, r.createDate, 120) as createDate,
				CONCAT(u.firstname, '  ', u.lastname) as createUser
			FROM M_RTM r
			INNER JOIN M_FN_REQ_HEADER f
			ON r.functionId = f.functionId
			INNER JOIN M_TESTCASE_HEADER t
			ON r.testCaseId = t.testCaseId
			LEFT JOIN M_USERS u
			ON r.createUser = u.username
			WHERE r.projectId = '$projectId'
			AND r.activeFlag = '1'"; */
	$sqlStr = "SELECT 
					a.testCaseversion,b.testCaseNo,
					a.functionversion,a.functionId,c.functionNo,
					a.effectiveStartDate as createDate
					FROM M_RTM_VERSION a
					LEFT JOIN M_FN_REQ_HEADER c
					ON a.functionId = c.functionId
					LEFT JOIN M_TESTCASE_HEADER b
					on a.testCaseId = b.testCaseId
					where a.projectid = '$projectId'
					and a.activeFlag = '1' ";

		$result = $this->db->query($sqlStr);
		return $result->result_array();
	}

	function searchExistRTMInfoByTestCaseId($projectId, $testCaseId){
		$sqlStr = "SELECT *
			FROM M_RTM r
			WHERE r.projectId = $projectId
			AND r.testCaseId= $testCaseId";
	 	$result = $this->db->query($sqlStr);
		return $result->result_array();
	}

	function searchExistRTMVersion($projectId,$testCaseId,$functionId){
		$sqlStr = "SELECT *
			FROM M_RTM_VERSION 
			WHERE projectId = $projectId
			AND testCaseId = $testCaseId
			AND functionId = $functionId
			AND activeFlag = '1'";
		$result = $this->db->query($sqlStr);
		return $result->row();
	}

	function searchRTMVersionInfo($param){
		$sqlStr = "SELECT *
			FROM M_RTM_VERSION 
			WHERE projectId = $param->projectId
			";
		$result = $this->db->query($sqlStr);
		return $result->row();
	}

	function searchRTMVersionInfoByCriteria($param){
		/* $sqlStr = "SELECT 
			new.rtmVersionId as new_rtmVersionId, 
			new.effectiveStartDate, 
			new.effectiveEndDate, 
			old.rtmVersionId as old_rtmVersionId, 
			old.updateDate as old_updateDate
			FROM M_RTM_VERSION new
			INNER JOIN M_RTM_VERSION old
			ON new.previousVersionId = old.rtmVersionId
			WHERE new.projectId = {$param->projectId}
			AND new.rtmVersionNumber = {$param->rtmVersionNumber}"; */

			$sqlStr ="SELECT 
					a.testCaseversion,b.testCaseNo,
					a.functionversion,a.functionId,c.functionNo,
					a.effectiveStartDate, 
					a.effectiveEndDate, a.activeFlag
					FROM M_RTM_VERSION a
					LEFT JOIN M_FN_REQ_HEADER c
					ON a.functionId = c.functionId
					LEFT JOIN M_TESTCASE_HEADER b
					on a.testCaseId = b.testCaseId
					where a.projectid = $param->projectId ";
		$result = $this->db->query($sqlStr);
		//return $result->row();
		return $result->result_array();
	}	

	function insertRTMInfo($param, $user){
		$currentDateTime = date('Y-m-d H:i:s');
		$sqlStr = "INSERT INTO M_RTM (projectId, functionId, testCaseId, effectiveStartDate, effectiveEndDate, activeFlag, createDate, createUser, updateDate, updateUser) 
		VALUES ($param->projectId, $param->functionId, $param->testCaseId, '$param->effectiveStartDate', NULL, '$param->activeFlag', '$currentDateTime', '$user', '$currentDateTime', '$user') ";
		$result = $this->db->query($sqlStr);
		return $result;
	}

	function insertRTMVersion($param, $user){
		$currentDateTime = date('Y-m-d H:i:s');
		$previousVersionId = !empty($param->previousVersionId)? $param->previousVersionId : 'NULL';

//		$sqlStr = "INSERT INTO M_RTM_VERSION (projectId, rtmVersionNumber, effectiveStartDate, effectiveEndDate, activeFlag, previousVersionId, createDate,	createUser, updateDate, updateUser) VALUES ($param->projectId, $param->versionNo, '$param->effectiveStartDate', NULL, '$param->activeFlag', $previousVersionId, '$currentDateTime', '$user', '$currentDateTime', '$user')";

		$sqlStr = "INSERT INTO M_RTM_VERSION (projectId, testCaseId,testCaseversion,functionId,functionVersion,effectiveStartDate, effectiveEndDate, 
		activeFlag, createDate,	createUser, updateDate, updateUser)
		VALUES ($param->projectId, '$param->testCaseId','$param->testCaseversion','$param->functionId','$param->functionversion', '$param->effectiveStartDate', NULL, 
		'$param->activeFlag', '$currentDateTime', '$user', '$currentDateTime', '$user')";
		$result = $this->db->query($sqlStr);
		return $result;
	}

	function updateRTMInfo($param){
		$effectiveEndDate = !empty($param->effectiveEndDate)? "'".$param->effectiveEndDate."'": "NULL";
		$sqlStr = "UPDATE M_RTM
			SET effectiveEndDate = $effectiveEndDate,
				activeFlag = '$param->activeFlag',
				updateDate = '$param->updateDate',
				updateUser = '$param->user'
			WHERE projectId = $param->projectId 
			AND functionId = $param->functionId 
			AND testCaseId = $param->testCaseId";
		$result = $this->db->query($sqlStr);
		return $this->db->affected_rows();
	}

	function updateRTMVersion($param){
		$effectiveEndDate = !empty($param->effectiveEndDate)? "'".$param->effectiveEndDate."'": "NULL";

		$sqlStr = "UPDATE M_RTM_VERSION
			SET effectiveEndDate = $effectiveEndDate,
				activeFlag = '$param->activeFlag',
				updateDate = '$param->updateDate',
				updateUser = '$param->user'
			WHERE rtmVersionId = $param->rtmVersionIdCondition 
			AND projectId = $param->projectId 
			AND updateDate = '$param->updateDateCondition'";
		$result = $this->db->query($sqlStr);
		return $this->db->affected_rows();
	}

	function deleteRTMVersion($param){
		$sqlStr = "DELETE FROM M_RTM_VERSION
			WHERE projectId = $param->projectId
			AND rtmVersionId = $param->rtmVersionId";
		$result = $this->db->query($sqlStr);
		return $this->db->affected_rows();
	}

	function deleteRTMInfo($param){
		$sqlStr = "DELETE FROM M_RTM
			WHERE projectId = {$param->projectId}
			AND functionId = {$param->fucntionId}
			AND testCaseId = {$param->testCaseId}";
		$result = $this->db->query($sqlStr);
		return $this->db->affected_rows();	
	}

	function searchExistFunctionalRequirement($fnId, $projectId){

		if(null != $projectId && !empty($projectId)){
			$where[] = "projectId = '$projectId'";
		}
		if(null != $fnId && !empty($fnId)){
			$where[] = "functionNo = '$fnId'";
		}
		$where_clause = implode(' AND ', $where);
		
		$queryStr = "SELECT * 
			FROM M_FN_REQ_HEADER 
			WHERE $where_clause";
		//echo $queryStr;
		$result = $this->db->query($queryStr);
		return $result->row();
	}

	function uploadRTM($param, $user){
		$this->db->trans_begin(); //Starting Transaction
		$effectiveStartDate = '';

	//	echo $param[0]->functionId;
	//	echo $param[0]->testCaseId;
		$resultfunction = $this->searchExistFunctionalRequirement($param[0]->functionId,$param[0]->projectId);
		//3.1 Update Version
		$param[0]->functionversion = $resultfunction->functionversion;
		$param[0]->functionId = $resultfunction->functionId;

		$resulttestcase = $this->mTestCase->searchExistTestCaseHeader($param[0]->projectId,$param[0]->testCaseId);
		$param[0]->testCaseversion = $resulttestcase->testcaseVersion;
		$param[0]->testCaseId = $resulttestcase->testCaseId;

	//	echo $param[0]->functionId;
	//	echo $param[0]->testCaseId;
		//Check Existing RTM Version
		$result = $this->searchExistRTMVersion($param[0]->projectId,$param[0]->testCaseId ,$param[0]->functionId);
		if((NULL != $result) && (0 < count($result))){
			$effectiveStartDate = $result->effectiveStartDate;
		}else{
			$effectiveStartDate = date('Y-m-d H:i:s');
			$param[0]->effectiveStartDate = $effectiveStartDate;
		}
		
		foreach ($param as $value) {
			
			$value->functionId = $param[0]->functionId ;
			$value->testCaseId = $param[0]->testCaseId ;

			$value->effectiveStartDate = $effectiveStartDate;
			$resultInsertRTMVersion = $this->insertRTMVersion($param[0], $user);
			$resultInsertRTMInfo = $this->insertRTMInfo($value, $user);
		}

    	$trans_status = $this->db->trans_status();
	    if($trans_status == FALSE){
	    	$this->db->trans_rollback();
	    	return false;
	    }else{
	   		$this->db->trans_commit();
	   		return true;
	    }
	}
}

?>