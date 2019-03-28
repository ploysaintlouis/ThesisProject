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