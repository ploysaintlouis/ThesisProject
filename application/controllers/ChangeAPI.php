<?php

defined('BASEPATH') OR exit('No direct script access allowed');

//require(APPPATH.'libraries/REST_Controller.php');
require(APPPATH.'libraries/Format.php');
use ThesisProject\Libraries\REST_Controller;

class ChangeAPI extends REST_Controller
{
    function __construct(){
        parent:: __construct();

        $this->load->library('session');
    }

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

        $query = "SELECT * FROM m_users";
        $result = $this->db->query($query);

        if($result->num_rows() > 0){
            foreach($result->result_array() as $row)
            {
                echo $row['userId'];
                echo $row['Firstname'];
            }
        }
       $this->response($data, 200);
        return $result;
        // แสดงรายการข่าวทั้งหมด
    }

    public function index_post()
    {
        // สร้างรายการใหม่
    }
  
    public function index_put()
    {
        // แก้ไขรายการ
    }
  
    public function index_delete()
    {
        // ลบรายการ
    }
 
}

?>