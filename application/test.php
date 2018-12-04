<?php 
$serverName = '107-NANNAPHAT\SQL2018';   
$uid = 'sa';     
$pwd = 'password';    
$databaseName = 'test';
$connectionInfo = array( "UID"=>$uid, "PWD"=>$pwd, "Database"=>$databaseName); 

/* Connect using SQL Server Authentication. */    
$conn = sqlsrv_connect( $serverName, $connectionInfo);

$sqlStr = "select TABLE_NAME, COLUMN_NAME, COLUMN_DEFAULT, IS_NULLABLE 
	from INFORMATION_SCHEMA.COLUMNS
	where COLUMN_NAME = 'username' and TABLE_NAME = 'M_USERS'";
$stmt = sqlsrv_query( $conn, $sqlStr);    
/*if ( $stmt )    
{    
     echo "Statement executed.<br>\n";
    $sqlStr = "EXEC getCheckConstraint @constraintName = 'ChkGrade_field'";
	$result = sqlsrv_query($conn, $sqlStr);
	echo $result;    
}     
else     
{    
     echo "Error in statement execution.\n";    
     die( print_r( sqlsrv_errors(), true));    
} */

$sqlStr = "SELECT CHECK_CLAUSE 
	FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS 
	WHERE CONSTRAINT_NAME = 'CHK_JOB_MAX_SALARY'";
$result = sqlsrv_query( $conn, $sqlStr);
$result = $result[0]['CHECK_CLAUSE'];

if(strpos($result, ">=") > 0)
	{
    $nGreaterThan = strpos($result, '>=(');
}

if(strpos($result, "<=") > 0)
	{

}

/* Free statement and connection resources. */    
sqlsrv_free_stmt( $stmt);    
sqlsrv_close( $conn); 
?>