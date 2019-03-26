<?php

defined('BASEPATH') OR exit('No direct script access allowed');
//require(APPPATH.'libraries/REST_Controller.php');

class ChangeAPI extends REST_Controller
{
    public function index_get()
    {
        $data = array(
            array(
                "id"=>1,
                "topic"=>"หัวข้อข่าวที่ 1"
            ),
            array(
                "id"=>2,
                "topic"=>"หัวข้อข่าวที่ 2"
            ),
            array(
                "id"=>3,
                "topic"=>"หัวข้อข่าวที่ 3"
            ),
        );
        $this->response($data, 200);
        // แสดงรายการข่าวทั้งหมด
    }
 
}

?>