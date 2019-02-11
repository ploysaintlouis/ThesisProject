<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/*
|--------------------------------------------------------------------------
| Display Debug backtrace
|--------------------------------------------------------------------------
|
| If set to TRUE, a backtrace will be displayed along with php errors. If
| error_reporting is disabled, the backtrace will not display, regardless
| of this setting
|
*/
defined('SHOW_DEBUG_BACKTRACE') OR define('SHOW_DEBUG_BACKTRACE', TRUE);

/*
|--------------------------------------------------------------------------
| File and Directory Modes
|--------------------------------------------------------------------------
|
| These prefs are used when checking and setting modes when working
| with the file system.  The defaults are fine on servers with proper
| security, but you may wish (or even need) to change the values in
| certain environments (Apache running a separate process for each
| user, PHP under CGI with Apache suEXEC, etc.).  Octal values should
| always be used to set the mode correctly.
|
*/
defined('FILE_READ_MODE')  OR define('FILE_READ_MODE', 0644);
defined('FILE_WRITE_MODE') OR define('FILE_WRITE_MODE', 0666);
defined('DIR_READ_MODE')   OR define('DIR_READ_MODE', 0755);
defined('DIR_WRITE_MODE')  OR define('DIR_WRITE_MODE', 0755);

/*
|--------------------------------------------------------------------------
| File Stream Modes
|--------------------------------------------------------------------------
|
| These modes are used when working with fopen()/popen()
|
*/
defined('FOPEN_READ')                           OR define('FOPEN_READ', 'rb');
defined('FOPEN_READ_WRITE')                     OR define('FOPEN_READ_WRITE', 'r+b');
defined('FOPEN_WRITE_CREATE_DESTRUCTIVE')       OR define('FOPEN_WRITE_CREATE_DESTRUCTIVE', 'wb'); // truncates existing file data, use with care
defined('FOPEN_READ_WRITE_CREATE_DESTRUCTIVE')  OR define('FOPEN_READ_WRITE_CREATE_DESTRUCTIVE', 'w+b'); // truncates existing file data, use with care
defined('FOPEN_WRITE_CREATE')                   OR define('FOPEN_WRITE_CREATE', 'ab');
defined('FOPEN_READ_WRITE_CREATE')              OR define('FOPEN_READ_WRITE_CREATE', 'a+b');
defined('FOPEN_WRITE_CREATE_STRICT')            OR define('FOPEN_WRITE_CREATE_STRICT', 'xb');
defined('FOPEN_READ_WRITE_CREATE_STRICT')       OR define('FOPEN_READ_WRITE_CREATE_STRICT', 'x+b');

/*
|--------------------------------------------------------------------------
| Exit Status Codes
|--------------------------------------------------------------------------
|
| Used to indicate the conditions under which the script is exit()ing.
| While there is no universal standard for error codes, there are some
| broad conventions.  Three such conventions are mentioned below, for
| those who wish to make use of them.  The CodeIgniter defaults were
| chosen for the least overlap with these conventions, while still
| leaving room for others to be defined in future versions and user
| applications.
|
| The three main conventions used for determining exit status codes
| are as follows:
|
|    Standard C/C++ Library (stdlibc):
|       http://www.gnu.org/software/libc/manual/html_node/Exit-Status.html
|       (This link also contains other GNU-specific conventions)
|    BSD sysexits.h:
|       http://www.gsp.com/cgi-bin/man.cgi?section=3&topic=sysexits
|    Bash scripting:
|       http://tldp.org/LDP/abs/html/exitcodes.html
|
*/
defined('EXIT_SUCCESS')        OR define('EXIT_SUCCESS', 0); // no errors
defined('EXIT_ERROR')          OR define('EXIT_ERROR', 1); // generic error
defined('EXIT_CONFIG')         OR define('EXIT_CONFIG', 3); // configuration error
defined('EXIT_UNKNOWN_FILE')   OR define('EXIT_UNKNOWN_FILE', 4); // file not found
defined('EXIT_UNKNOWN_CLASS')  OR define('EXIT_UNKNOWN_CLASS', 5); // unknown class
defined('EXIT_UNKNOWN_METHOD') OR define('EXIT_UNKNOWN_METHOD', 6); // unknown class member
defined('EXIT_USER_INPUT')     OR define('EXIT_USER_INPUT', 7); // invalid user input
defined('EXIT_DATABASE')       OR define('EXIT_DATABASE', 8); // database error
defined('EXIT__AUTO_MIN')      OR define('EXIT__AUTO_MIN', 9); // lowest automatically-assigned error code
defined('EXIT__AUTO_MAX')      OR define('EXIT__AUTO_MAX', 125); // highest automatically-assigned error code

//***COMMON***
define('BG_COLOR_ADD', '#D5F5E3');
define('BG_COLOR_DELETE', '#FADBD8');

define('ACTIVE_STATUS', 'Active');
define('UNACTIVE_STATUS', 'Inactive');
define('ACTIVE_CODE', 1);
define('UNACTIVE_CODE', 0);

define('START_FLAG', 1); //Start Project 

define('LENGTH_FR_NO', 50);
define('LENGTH_FR_DESC', 100);
define('LENGTH_INPUT_NAME', 50);
define('LENGTH_INPUT_DATA_TYPE', 50);
define('LENGTH_TC_NO', 50);
define('LENGTH_TC_DESC', 255);

define('MISC_DATA_INPUT_DATA_TYPE', 'inputDataType');

define('RUNNING_TYPE_CHANGE_REQUEST_NO', 'ChangeRequestNo');

define('MAX_DECIMAL_PRECISION', 38);
define('MAX_WIDTH_CHARACTER_STRING', 8000);
define('MAX_WIDTH_UNICODE_STRING', 4000);
define('MAX_TABLE_NAME', 128);
define('MAX_FIELD_NAME', 128);
define('MAX_INPUT_NAME', 50);

define('INITIAL_VERSION', 1);

define('DATA_TYPE_CATEGORY_NUMERICS', "Numerics");
define('DATA_TYPE_CATEGORY_STRINGS', "Strings");
define('DATA_TYPE_CATEGORY_DATE', "Date");

define('CHANGE_TYPE_ADD', 'add');
define('CHANGE_TYPE_EDIT', 'edit');
define('CHANGE_TYPE_DELETE', 'delete');

define('CHANGE_STATUS_CLOSE', 'CLS');
define('CHANGE_STATUS_CANCEL', 'CCL');

define('EDIT_FLAG_ENABLE', 1);
define('EDIT_FLAG_DISABLE', 0);

define('PLEASE_SELECT', '--Please Select--');

//***ERROR MESSAGE***
define('ER_MSG_001', 'Please input any search criteria.');
define('ER_MSG_002', 'Please enter start date < end Date.');
define('ER_MSG_003', 'Register process failed.');
define('ER_MSG_004', 'Duplication Error. Project Name that you input already exist. Please enter different value.');
define('ER_MSG_005', 'Error concurrent: Data is already in use by another user.');
define('ER_MSG_006', 'Search not found.');
define('ER_MSG_007', 'Error concurrent: Project ID was not found.');
define('ER_MSG_008', 'Import process failed.');
define('ER_MSG_009', 'Import process succuess.');
define('ER_MSG_010', 'Please enter data in a CSV file to upload.');
define('ER_MSG_011', 'An error occurred while parsing incomplete parameter.');
define('ER_MSG_012', 'Data not found.');
define('ER_MSG_013', 'There is a problem when save data, Please try to save again.');
define('ER_MSG_014', 'Problem effected because could not find miscellaneous data.');
define('ER_MSG_015', 'Delete process failed.');
define('ER_MSG_016', 'Problem occurred while changing functional requirement inputs: {0} Error, Please try to save again.');
define('ER_MSG_017', 'Error concurrent: Change Request No. was not found.');
define('ER_MSG_018', 'This section has no any effect.');
define('ER_MSG_019', 'Cancel process failed: {0} Error, Please try to save again.');

//**KEY COLUMN FOR UPLOAD FUNCTIONAL REQUIREMENT
//define('NUMBER_OF_UPLOADED_COLUMN_FR', 6);
define('NUMBER_OF_UPLOADED_COLUMN_FR', 9);
define('NUMBER_OF_UPLOADED_COLUMN_DB', 12);
//define('NUMBER_OF_UPLOADED_COLUMN_TC', 6);
define('NUMBER_OF_UPLOADED_COLUMN_TC', 7);
define('NUMBER_OF_UPLOADED_COLUMN_RTM', 3);
define('KEY_FR_NO', 'functionalRequirementId');
define('KEY_FR_DESC', 'functionalRequirementDescription');
define('KEY_FR_INPUT_NAME', 'dataName');
define('KEY_FR_INPUT_TYPE', 'dataType');
define('KEY_FR_INPUT_LENGTH', 'dataLength');
define('KEY_FR_DECIMAL_POINT', 'decimalPoint');
define('KEY_FR_INPUT_UNIQUE', 'unique');
define('KEY_FR_INPUT_DEFAULT', 'defaultValue');
define('KEY_FR_INPUT_NULL', 'notNull');
define('KEY_FR_INPUT_MIN_VALUE', 'minValue');
define('KEY_FR_INPUT_MAX_VALUE', 'maxValue');
define('KEY_FR_INPUT_TABLE_NAME', 'referTableName');
define('KEY_FR_INPUT_FIELD_NAME', 'referColumnName');
define('KEY_DB_TABLE_NAME', 'tableName');
define('KEY_DB_COLUMN_NAME', 'columnName');
define('KEY_DB_ISPRIMARY_KEY', 'primaryKey');
define('KEY_FR_TYPEDATE','typeData');

define('KEY_TC_TESTCASE_NO', 'TestCaseID');
define('KEY_TC_TESTCASE_DESC', 'TestCaseDescription');
define('KEY_TC_EXPECTED_RESULT', 'ExpectedResult');
define('KEY_TC_INPUT_NAME', 'dataName');
define('KEY_TC_TYPEDATA', 'typeData');
define('KEY_TC_TEST_DATA', 'TestData');

define('KEY_FR_ID', 'FunctionalRequirementID');

//Error Import
define('ER_IMP_001', "Functional Requirements' ID is not same.");
define('ER_IMP_002', "Functional Requirements' ID length exceeded");
define('ER_IMP_003', "Functional Requirements' Description length exceeded");
define('ER_IMP_004', "Number of uploaded columns does not match with specified header.");
define('ER_IMP_005', "Functional Requirements' ID not found in CSV.");
define('ER_IMP_006', "Project and Functional Requirements' ID duplicate in system");
define('ER_IMP_007', "Functional Requirements' Description not found in CSV.");
define('ER_IMP_008', "Input Name not found in CSV.");
define('ER_IMP_009', "Input Name length exceeded.");
define('ER_IMP_010', "Duplicate Input Name in CSV file.");
define('ER_IMP_011', "Data Type not found in CSV.");
define('ER_IMP_012', "Data Type length exceeded.");
define('ER_IMP_013', "Data Type is not predefined format.");
define('ER_IMP_014', "Data Length not found in CSV.");
define('ER_IMP_015', "Data Length must be from 1 - 8000");
define('ER_IMP_016', "Data Length must be from 1 - 4000");
define('ER_IMP_017', "Data Length must be from 1 - 38");
define('ER_IMP_018', "Scale (right of the decimal point) must be less than length.");
define('ER_IMP_019', "The UNIQUE Constraint not found in CSV.");
define('ER_IMP_020', "The UNIQUE Constraint is in wrong format ('Y'or'N').");
define('ER_IMP_021', "The DEFAULT Constraint is incorrectly formed.");
define('ER_IMP_022', "The NOT NULL Constraint not found in CSV.");
define('ER_IMP_023', "The NOT NULL Constraint is in wrong format ('Y'or'N').");
define('ER_IMP_024', "The conflict occurred in CHECK Constraint for MIN value.");
define('ER_IMP_025', "The conflict occurred in CHECK Constraint for MAX value.");
define('ER_IMP_026', "Table Name of Database Target was not found in CSV.");
define('ER_IMP_027', "Table Name of Database Target length exceeded.");
define('ER_IMP_028', "Column Name of Database Target was not found in CSV.");
define('ER_IMP_029', "Column Name of Database Target length exceeded.");
define('ER_IMP_030', "Data matching error: Data does not match current Input Data in database.");

define('ER_IMP_031', "Table Name is not the same name.");
define('ER_IMP_032', "Duplicate Column Name in CSV file.");
define('ER_IMP_033', "The PRIMARY KEY Constraint not found in CSV.");
define('ER_IMP_034', "The PRIMARY KEY Constraint is in wrong format ('Y'or'N').");
define('ER_IMP_035', "Please input Min Value < Max Value");
define('ER_IMP_036', "Duplicate Table and Column Name in CSV file.");

define('ER_IMP_037', "Duplication Error. Table or Column data that you input already exist. Please enter correct Input Name.");
define('ER_IMP_038', "Existence Error. Table or Column data that you input does not exist in DB Schema Master. Please try again.");

define('ER_IMP_039', "Test Case's ID not found in CSV.");
define('ER_IMP_040', "Test Case's ID is not same.");
define('ER_IMP_041', "Test Case's ID length exceeded");
define('ER_IMP_042', "Test Case's Description is not same.");
define('ER_IMP_043', "Test Case's Description length exceeded.");
define('ER_IMP_044', "Expected Result data not found in CSV.");
define('ER_IMP_045', "Expected Result data in wrong format ('valid'or'invalid').");
define('ER_IMP_046', "Input Name not found in CSV.");
define('ER_IMP_047', "Duplicate Input Name in CSV file.");
define('ER_IMP_048', "Input Name does not exist in master.");
define('ER_IMP_049', "Test Data not found in CSV.");
define('ER_IMP_050', "Duplication Error. Test Case ID and Input Name that you input already exist.");

define('ER_IMP_051', "Existence Error. Functional Requirement's ID not exist in Database.");
define('ER_IMP_052', "Existence Error. Test Case's ID not exist in Database.");
define('ER_IMP_053', "Duplication Error. Test Case that you input already exist in RTM.");

define('ER_IMP_054', "Can't start project because functional requirement data doesn't exists.");
define('ER_IMP_055', "Can't start project because test case data doesn't exists.");
define('ER_IMP_056', "Can't start project because RTM data doesn't exists.");

//Error Transaction
define('ER_TRN_001', "Can't save because this Functional Requirement's Input already exist in Change List.");
define('ER_TRN_002', "Input Name is required.");
define('ER_TRN_003', "Input Name length exceeded.");
define('ER_TRN_004', "Table and Column that you enter does not match with current Input in database.");
define('ER_TRN_005', "This Data already exist in Functional Requirement.");
define('ER_TRN_006', "This Data already exist in Change List.");
define('ER_TRN_007', "Input data does not match existing Schema Information.");
define('ER_TRN_008', "Data Type is required.");
define('ER_TRN_009', "No change on existing data.");

define('ER_TRN_010', "Change process fail. Please enter Functional Requirement's Input change at least one record.");
define('ER_TRN_011', "Change process fail. This Functional Requirement is changed by another user.");
define('ER_TRN_012', "Change process fail. The latest functional requirement data not found.");
define('ER_TRN_013', "Change process fail. Unable to connect to database target. Please check the access to the database.");

//**INFORMATION MESSAGE
define('IF_MSG_001', 'This change request has been successfully cancelled.');
define('IF_MSG_002', "The Functional Requirement' Inputs has been successfully changed.");
define('IF_MSG_003', "Database Schema, Table: '{0}' imported successfully.");
define('IF_MSG_004', "Functional Requirement ID: '{0}' imported successfully.");
define('IF_MSG_005', "Test Case ID: '{0}' imported successfully.");