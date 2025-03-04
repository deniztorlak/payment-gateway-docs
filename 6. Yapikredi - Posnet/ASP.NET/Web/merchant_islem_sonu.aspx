<%@ Page Language="VB" AutoEventWireup="false" CodeFile="merchant_islem_sonu.aspx.vb" Inherits="merchant_islem_sonu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Üye İşyeri Sayfası</title>
</head>
<body>
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tbody>
		<tr>
			<td width="40" height="39"></td>
			<td height="39" width="641" bgcolor="#d4d0c8"><b>Üye İşyeri Sayfasına Dönülen Parametreler :</b></td>
		</tr>
		<tr>
			<td width="40" height="28"></td>
			<td height="28" width="641">
			<br>
			<% 
			    Dim i As Integer
			    For i = 0 To Request.Form.Count - 1
			        Response.Write("<b>" & Request.Form.Keys(i) & "</b> : " & Request.Form(i))
			        Response.Write("<br><br>")
			    Next
			%>
			</td>
		</tr>
	</tbody>
</table>
<p align="center"><a href="merchant.html">merchant.html</a></p>
</body>
</html>
