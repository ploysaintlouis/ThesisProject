แก้ config db ใน ThesisProject\application\config\database.php
**ไฟล์ db.bak อยู่ที่ ThesisProject\db.bak

http://localhost:81/ThesisProject/index.php/
username : ploy
password : 1234

1.ThesisProject\application\controllers\ChangeManagement.php  //ส่งตัวแปรกับ urlผ่าน postCURL ไปยัง common.php

2.ThesisProject\application\libraries\common.php  // function postCURL

3.ThesisProject\application\controllers\ChangeAPI.php  //รับค่าจาก common เพื่อนำค่าไปวิเคราะห์ข้อมูลใน db แล้วจะ return ค่ากลับไปยัง ChangeManagement.php  เพื่อจะแสดงผล

