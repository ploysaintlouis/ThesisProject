<html>
<head>
<body>
<?php
	function __construct(){
		parent::__construct();
		$this->load->model('Miscellaneous_model', 'mMisc');

		$this->load->library('form_validation', null, 'FValidate');
		$this->load->library('session');
	}

		$dataTypeList = $this->mMisc->searchMiscellaneous(MISC_DATA_INPUT_DATA_TYPE, '');
		$dataTypeCombo = '
			<select name="inputDataType" id="inputDataType" class="form-control">
				<option value="">--Select Data Type--</option>';
		foreach ($dataTypeList as $value) {
			$dataTypeCombo .= '<option value="'.$value['miscValue1'].'">'.$value['miscValue1'].'</option>';
		}
		$dataTypeCombo .= '</select>';
?>
			<input type="hidden" name="changeProjectId" value="'.$row["projectId"].'">
			<input type="hidden" name="changeType" id="changeType" value="'.$mode.'">
			<input type="hidden" name="changeFunctionId" value="'.$row["functionId"].'">
			<input type="hidden" name="changeFunction" value="'.$row["functionVersion"].'">
			<input type="hidden" name="changetypeData" value="'.$row["typeData"].'">  
			<input type="hidden" name="changeSchemaVersionId" value="'.$row["schemaVersionId"].'">

			<table style="width:100%">
			<tr height="40">
	
				<td>
					<div class="radio">
						<label style="font-weight:700;">
						<input type="radio" id="changetypeData" name="changetypeData" value="1" class="checkbox">Input Name
						</label>

						&nbsp;&nbsp;
						
						<label style="font-weight:700;">
						<input type="radio" id="changetypeData" name="changetypeData" value="2" class="checkbox">Output Name
						</label>
					</div>
				</td>	
				<td>
					<input type="text" name="dataName" id="dataName" class="form-control" style="display:'.$displayFlag.'" maxlength="'.MAX_INPUT_NAME.'" />
				</td>	
			</tr>
			<tr height="40">
				<td>
					<label>Data Type: 
					<p class="text-green" style="margin:0;"></p>
					</label>
				</td>
				<td>
				<?php		
				$dataTypeList = $this->mMisc->searchMiscellaneous(MISC_DATA_INPUT_DATA_TYPE, '');
				$dataTypeCombo = '
					<select name="inputDataType" id="inputDataType" class="form-control">
						<option value="">--Select Data Type--</option>';
				foreach ($dataTypeList as $value) {
					$dataTypeCombo .= '<option value="'.$value['miscValue1'].'">'.$value['miscValue1'].'</option>';
				}
				$dataTypeCombo .= '</select>';
		
					echo $dataTypeCombo; ?>
				</td>
			</tr>
			<tr height="40">
				<td>
					<label>Data Length: <?php echo $row["schemaVersionId"]; ?>
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
						<input type="checkbox" id="inputUnique" name="inputUnique" value="'.$checkUnique.'" >Unique
						<p class="text-green" style="margin:0;"></p>
						</label>

						&nbsp;&nbsp;
						
						<label style="font-weight:700;">
						<input type="checkbox" id="inputNotNull" name="inputNotNull" value="'.$checkNotNull.'" >NOT NULL
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
			</table>
			</body>
			</head>
</html>