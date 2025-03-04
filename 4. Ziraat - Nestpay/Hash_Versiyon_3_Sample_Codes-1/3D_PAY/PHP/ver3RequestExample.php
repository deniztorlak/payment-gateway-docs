<html>

<head>

<title>3D PAY</title>

<meta http-equiv="Content-Language" content="tr">


<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">


<meta http-equiv="Pragma" content="no-cache">


<meta http-equiv="Expires" content="now">


</head>


<body>

	<?php
	
		$orgClientId  =   "100200127";
  		$orgAmount = "91.96";
  		$orgOkUrl =  "https://<host_address>/GenericVer3ResponseHandler.php";
  		$orgFailUrl = "https://<host_address>/GenericVer3ResponseHandler.php";
  		$orgTransactionType = "Auth";
  		$orgInstallment = "";
  		$orgRnd =  microtime();
  		$orgCallbackUrl = "https://<host_address>/callback.php";
  		$orgCurrency = "949";
		
	?>


	<center>

		<form method="post" action="https://<host_address>/GenericVer3RequestHashHandler.php">
			<table>
				<tr>

					<td>Credit Card Number</td>

					<td><input type="text" name="pan" size="20" />
				</tr>

				<tr>

					<td>CVV</td>

					<td><input type="text" name="cv2" size="4" value="" /></td>
				</tr>
				<tr>

					<td>Expiration Date Year</td>

					<td><input type="text" name="Ecom_Payment_Card_ExpDate_Year"
						value="" /></td>
				</tr>

				<tr>

					<td>Expiration Date Month</td>

					<td><input type="text" name="Ecom_Payment_Card_ExpDate_Month"
						value="" /></td>
				</tr>

				<tr>

					<td>Choosing Visa / Master Card</td> 
					<td><select name="cardType">

							<option value="1">Visa</option>
							<option value="2">MasterCard</option>
					</select>
				</tr>

				<tr>

					<td align="center" colspan="2"><input type="submit"
						value="Complete Payment" /></td>
				</tr>

			</table>

				<input type="hidden" name="clientid" value="<?php echo $orgClientId ?>"> 
				<input type="hidden" name="amount" value="<?php echo $orgAmount ?>">
				<input type="hidden" name="okurl" value="<?php echo $orgOkUrl ?>">
				<input type="hidden" name="failUrl" value="<?php echo $orgFailUrl ?>">
				<input type="hidden" name="TranType" value="<?php echo $orgTransactionType ?>">
				<input type="hidden" name="Instalment" value="<?php echo $orgInstallment ?>">
				<input type="hidden" name="callbackUrl" value="<?php echo $orgCallbackUrl ?>">
				<input type="hidden" name="currency" value="<?php echo $orgCurrency ?>">
				<input type="hidden" name="rnd" value="<?php echo $orgRnd ?>">
				<input type="hidden" name="storetype" value="3D_PAY">
				<input type="hidden" name="hashAlgorithm" value="ver3">
				<input type="hidden" name="lang" value="tr">
				<input type="hidden" name="BillToName" value="name">
				<input type="hidden" name="BillToCompany" value="billToCompany">
		</form>

	</center>

</body>

</html>
