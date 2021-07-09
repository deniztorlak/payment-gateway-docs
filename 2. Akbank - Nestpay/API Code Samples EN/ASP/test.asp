<%
Set pay = Server.CreateObject("epayapi.payment")

*** THE INFORMATION AT THE BELOW MIGHT NOT BE TOTALY CORRECT. ***

The parameter information at the below are different for test,prod and url. For tests, you can use the user information documents that the bank have shared with you. For prods, you can use the account and url information that the bank have created for you.


pay.clientid="TEST_ID"
pay.name="TEST_NAME"
pay.password="TEST_PASSWORD"
pay.host="TEST_URL"


pay.OrderResult=0
pay.chargetype="PreAuth"
pay.cardnumber= "4242424242424242"
pay.expmonth="01"
pay.expyear="09"
pay.cv2="000"
pay.subtotal="12.04"
pay.currency=949
retval=pay.processorder

if pay.err = "00" then
	myStr = "Test is successful: The connection with Virtual POS has been made!"
Else
	myStr = ""
	myStr = myStr & "URL addresses might be wrong<br>"
	myStr = myStr & "There might not be connection on 443. port!<br>"
	myStr = myStr & "<br>"
	myStr = myStr & "The .dll that you have registered might having problems!<br>"
	myStr = myStr & "<br>"
	myStr = myStr & "After you have checked all these possibilities,<br>"
	myStr = myStr & "if you still having problem,<br>"
	myStr = myStr & "you might get assistance from your support unit.<br>"
End if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>  Virtual POS Test </TITLE>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-9">
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1254">
</HEAD>

<BODY>

<h1>Test transaction result:</h1>
<br>
<h1><% =myStr %></h1>
<hr>
<%
if pay.err <> "" then
response.write("<b>Response Parameters</b>")
response.write("<pre>")
response.write("<br>retval : " & retval)
response.write("<br>err    : " & pay.err)
response.write("<br>errmsg : " & pay.errmsg)
response.write("<br>code   : " & pay.code)
response.write("<br>appr   : " & pay.appr)
response.write("<br>HostMsg: " & pay.Extra("HostMsg"))
response.write("<br>OrderID: " & pay.oid)
response.write("<br>rrn    : " & pay.refno)
response.write("</pre>")
end if
%>
</BODY>
</HTML>