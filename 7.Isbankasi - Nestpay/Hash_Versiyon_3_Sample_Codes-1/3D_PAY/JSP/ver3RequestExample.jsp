<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.commons.codec.binary.Base64" %>
<%@page import="java.security.MessageDigest"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>3D PAY Model</title>
</head>
<body>
	<%
			//unEscaped values
		    String orgClientId = "100200127";			
		    String orgAmount = "95.93";
		    String orgOkUrl = "https://<host_address>/GenericVer3ResponseHandler";
		    String orgFailUrl = "https://<host_address>/GenericVer3ResponseHandler";
		    String orgTransactionType = "Auth";
		    String orgInstallment = "";
		    String orgRnd = new java.util.Date().toString();  
		    String orgCallbackUrl = "https://<host_address>/GateResponseControl.jsp";
		    String orgCurrency = "949";
	%>
	<center>
		<form method="post" action="https://<host_address>/GenericVer3RequestHashHandler">
			<table>
				<tr>
					<td>Credit Card Number</td>
					<td><input type="text" name="pan" size="20" value="" />
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
					<td align="center" colspan="2"><input type="submit"	value="Complete Payment" /></td>
				</tr>
			</table>

			<input type="hidden" name="clientid" value="<%=orgClientId%>">
			<input type="hidden" name="amount" value="<%=orgAmount%>">
			<input type="hidden" name="okurl" value="<%=orgOkUrl%>">
			<input type="hidden" name="failUrl" value="<%=orgFailUrl%>">
			<input type="hidden" name="TranType" value="<%=orgTransactionType%>">
			<input type="hidden" name="Instalment" value="<%=orgInstallment%>">
			<input type="hidden" name="callbackUrl" value="<%=orgCallbackUrl%>">
			<input type="hidden" name="currency" value="<%=orgCurrency%>">
			<input type="hidden" name="rnd" value="<%=orgRnd%>"> 
			<input type="hidden" name="storetype" value="3D_PAY"> 
			<input type="hidden" name="lang" value="tr">
			<input type="hidden" name="hashAlgorithm" value="ver3">
			<input type="hidden" name="BillToName" value="name">
			<input type="hidden" name="BillToCompany" value="billToCompany">
            <input type="hidden" name="refreshtime" value="5">
			

		</form>
	</center>
    </body>
</html>
