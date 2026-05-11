<%@ Language=VBScript %>
<%
	
Function GetGuid() 
        Set TypeLib = CreateObject("Scriptlet.TypeLib") 
        GetGuid = "SipID_1000" + Replace(Replace(Replace(Left(CStr(TypeLib.Guid), 32),"{",""),"}",""),"-","") 
        Set TypeLib = Nothing 
End Function

' This function sends the requestXML to the service
 Function iPosProcess(serviceUrl, requestXML)
    Set PostConnection = server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
' Proxy ihtiyaç olursa açabilirsiniz
'  PostConnection.setOption(2) = 13056
'  PostConnection.setProxy 2, "https=iproxy:80", ""
  serviceUrl = serviceUrl
  PostConnection.Open "POST", serviceUrl, False
  PostConnection.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  PostConnection.Send requestXML
  iPosProcess = PostConnection.responseText
  Set PostConnection = Nothing
End Function
 
dim sessionData 
sessionData= Session(Request.Form("VerifyEnrollmentRequestId"))

dim sessionArray 
sessionArray= Split(sessionData,"&")
	
dim PostUrl 
dim IsyeriNo 
dim ClientIp
dim IslemTipi
dim TutarKodu 
dim IsyeriSifre 
dim TerminalNo 
dim KartExpiry
dim KartAy 
dim KartYil 
dim KartCvv 
dim Tutar 
dim SiparID
dim PosXML
dim result
		'Test ortam adresi
	    PostUrl="https://sp-test.innova.com.tr/VAKIFBANK_V4/VposWeb/v3/Vposreq.aspx" 
		IsyeriNo=sessionArray(4)
		IsyeriSifre=sessionArray(3)
		TerminalNo=sessionArray(8)
		KartNo=sessionArray(0)
		KartExpiry="20"+sessionArray(1)
		KartCvv=sessionArray(2)
		Tutar=sessionArray(6)
		SiparID=GetGuid()
		IslemTipi="Sale"
		TutarKodu=sessionArray(7)
		ClientIp = "127.0.0.1"
If Request.Form("Status")= "Y" Then

	PosXML ="<?xml version=""1.0"" encoding=""utf-8""?>" + "<VposRequest>"+ "<ECI>" + Request.Form("Eci") + "</ECI>" + "<CAVV>" + Request.Form("Cavv") + "</CAVV>" + "<MpiTransactionId>" + Request.Form("VerifyEnrollmentRequestId") + "</MpiTransactionId>"  + "<MerchantId>" + IsyeriNo + "</MerchantId>" + "<Password>" + IsyeriSifre + "</Password>" + "<TerminalNo>" + TerminalNo + "</TerminalNo>" + "<TransactionType>"+IslemTipi+"</TransactionType>" + "<TransactionId>" + SiparID + "</TransactionId>" + "<CurrencyAmount>" + Tutar + "</CurrencyAmount>" + "<CurrencyCode>"+TutarKodu+"</CurrencyCode>" + "<Pan>" + KartNo + "</Pan>" + "<Cvv>" + KartCvv + "</Cvv>" + "<Expiry>" + KartExpiry + "</Expiry><TransactionDeviceSource>0</TransactionDeviceSource><ClientIp>" + ClientIp + "</ClientIp></VposRequest>"

	Response.Write("<h1>Xml formati </h1>")
	Response.Write(PostUrl + "<br>")
	Response.Write("<textarea rows=""15"" cols=""60"">" + Server.HTMLEncode(PosXML) + "</textarea>")

	result = iPosProcess(PostUrl,  "prmstr=" + PosXML)

	Response.Write("<h1>Sonuc Degerleri</h1>")
	Response.Write("<textarea rows=""15"" cols=""60"">" + Server.HTMLEncode(result) + "</textarea>")
	End If

%>
<html>
<head>
    <title>Report</title>
    <style>
        .mainDiv
        {
            width:360px;
            height:300px;
            position:absolute;
            left:50%;
            margin-left:-250px;
            color: black; 
            border:6px inset red; 
            border-radius: 15px;
            display: inline;
            padding:15px;
            box-shadow: 10px 10px 5px #888; 
        }
        .innerSpan
        {
            width:175px;
            float:left;
            padding:4px 0 0 0;
        }
    </style>
</head>
<!-- 3d secure sonrası sanalposa dönecek değer aşağıdaki gibi olacaktır.-->
<!--<body>
   <form id="form1" method="post" action="TempSucessUrl.asp">
    <div class="mainDiv">
        <div>
            <span class="innerSpan">Status</span>
            <span><input type="text" id="Status" name="Status" value="<%=Request.Form("Status")%>" /></span>
         </div>
        <div>
            <span class="innerSpan">Merchant Id</span>
            <span><input type="text" id="MerchantId" name="MerchantId" value="<%=Request.Form("MerchantId")%>" /></span>
         </div>
         <div>
            <span class="innerSpan">VerifyEnrollmentRequest Id</span>
            <span><input type="text" id="VerifyEnrollmentRequestId" name="VerifyEnrollmentRequestId" value="<%=Request.Form("VerifyEnrollmentRequestId")%>" /></span>
         </div>
         <div>
            <span class="innerSpan">Purchase Amount</span>
            <span><input type="text" id="PurchAmount" name="PurchAmount" value="<%=Request.Form("PurchAmount")%>" /></span>
         </div>
          <div>
            <span class="innerSpan">Xid</span>
            <span><input type="text" id="Xid" name="Xid" value="<%=Request.Form("Xid")%>" /></span>
         </div>
          <div>
            <span class="innerSpan">InstallmentCount</span>
            <span><input type="text" id="InstallmentCount" name="InstallmentCount" value="<%=Request.Form("InstallmentCount")%>" /></span>
         </div>
           <div>
            <span class="innerSpan">Session Info</span>
            <span><input type="text" id="SessionInfo" name="SessionInfo" value="<%=Request.Form("SessionInfo")%>" /></span>
         </div>
         <div>
            <span class="innerSpan">Purchase Currency</span>
            <span><input type="text" id="PurchCurrency" name="PurchCurrency" value="<%=Request.Form("PurchCurrency")%>" /></span>
         </div>
         <div>
            <span class="innerSpan">Pan</span>
            <span><input type="text" id="Pan" name="Pan" value="<%=Request.Form("Pan")%>"/></span>
         </div>
          <div>
            <span class="innerSpan">Expire Date</span>
            <span><input type="text" id="ExpiryDate" name="ExpiryDate" value="<%=Request.Form("Expiry")%>" /></span>
         </div>
         <div>
            <span class="innerSpan">Eci</span>
            <span><input type="text" id="Eci" name="Eci" value="<%=Request.Form("Eci")%>" /></span>
         </div>
         <div>
            <span class="innerSpan">Cavv</span>
            <span><input type="text" id="Cavv" name="Cavv" value="<%=Request.Form("Cavv")%>" /></span>
         </div>
    </div>
    </form>
</body>-->
</html>