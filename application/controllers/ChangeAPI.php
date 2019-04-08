<?php

//defined('BASEPATH') OR exit('No direct script access allowed');
header("Content-Type:application/json");

$data = json_decode(file_get_contents('php://input'), true);
//echo json_encode($data);
if (isset($_GET['projectInfo']) && $_GET['projectInfo']!="") {
/*
            $strsql = "SELECT * FROM M_PROJECT where projectId = '$projectInfo' ";
            echo $strsql;
            $objQuery = $this->db->query($strsql);
            if(!$objQuery){
                echo "<script language='javascript'>alert('Code Correct.');</script>";
            }
            return $objQuery->result_array();	*/
}else{
            response(NULL, NULL, 400,"Invalid Request",$data);
}
function response($order_id,$amount,$response_code,$response_desc,$data){
	/*$response['order_id'] = $order_id;
	$response['amount'] = $amount;
	$response['response_code'] = $response_code;
	$response['response_desc'] = $response_desc;
	$response['order_id'] = "1";
	$response['amount'] = "2";
	$response['response_code'] = "3";
	$response['response_desc'] = $response_desc;
	$response['projectInfo'] =$data['projectInfo'];
	$response['typeData'] =$data['changeRequestInfo[inputs][1][typeData]'];*/

/*
	if ($data['changeRequestInfo[inputs][][changeType]'] == 'edit'){
	$json_response = json_encode($response);
	//$json_response= str_replace(/,\/,/,\n/,$json_response);
	echo "$json_response";
	*/

		$functionNo = $data['changeRequestInfo[functionNo]'];
		$functionVersion = $data['changeRequestInfo[functionVersion]'];
		
		ECHO $functionNo;
	$strsql = " SELECT * FROM M_FN_REQ_DETAIL 
	            WHERE functionNo = '$functionNo'
			      AND activeflag = '1' 
			      AND functionVersion =  '$functionVersion'
				";
	echo $strsql;
			$response = $data;

	//$response = 
		//$HeaderChange = array();

	$json_response = json_encode($response);
	//echo "$json_response";

}
?>