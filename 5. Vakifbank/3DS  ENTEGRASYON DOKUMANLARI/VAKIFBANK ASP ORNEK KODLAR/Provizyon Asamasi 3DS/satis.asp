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
' İhtiyaç duyulması halinde Proxy kullanımı aşağıdaki gibi açabilirsiniz.
  'PostConnection.setOption(2) = 13056
  'PostConnection.setProxy 2, "https=iproxy:80", ""
  serviceUrl = serviceUrl
  PostConnection.Open "POST", serviceUrl, False
  PostConnection.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  PostConnection.Send requestXML
  iPosProcess = PostConnection.responseText
  Set PostConnection = Nothing
End Function
 
dim PostUrl 
dim IsyeriNo 
dim ClientIp
dim IslemTipi
dim TutarKodu 
dim IsyeriSifre 
dim TerminalNo 
dim KartNo
dim KartAy 
dim KartYil 
dim KartCvv 
dim Tutar 
dim SiparID
dim PosXML
dim result
		
		'Test ortam adresi
	    PostUrl="https://sp-test.innova.com.tr/VAKIFBANK_V4/VposWeb/v3/Vposreq.aspx"
		IsyeriNo=Request.Form("IsyeriNo")
		IsyeriSifre=Request.Form("IsyeriSifre")
		TerminalNo=Request.Form("TerminalNo")
		KartNo=Request.Form("KartNo")
		KartAy=Request.Form("KartAy")
		KartYil=Request.Form("KartYil")
		KartCvv=Request.Form("KartCvv")
		Tutar=Request.Form("Tutar")
		SiparID=GetGuid()
		IslemTipi=Request.Form("IslemTipi")
		TutarKodu=Request.Form("TutarKodu")
		ClientIp = "127.0.0.1"

	PosXML ="<?xml version=""1.0"" encoding=""utf-8""?>" + "<VposRequest>" + "<MerchantId>" + IsyeriNo + "</MerchantId>" + "<Password>" + IsyeriSifre + "</Password>" + "<TerminalNo>" + TerminalNo + "</TerminalNo>" + "<TransactionType>"+IslemTipi+"</TransactionType>" + "<TransactionId>" + SiparID + "</TransactionId>" + "<CurrencyAmount>" + Tutar + "</CurrencyAmount>" + "<CurrencyCode>"+TutarKodu+"</CurrencyCode>" + "<Pan>" + KartNo + "</Pan>" + "<Cvv>" + KartCvv + "</Cvv>" + "<Expiry>" + KartYil + KartAy + "</Expiry><TransactionDeviceSource>0</TransactionDeviceSource><ClientIp>" + ClientIp + "</ClientIp></VposRequest>"

	Response.Write("<h1>Xml formati </h1>")
	Response.Write(PostUrl + "<br>")
	Response.Write("<textarea rows=""15"" cols=""60"">" + Server.HTMLEncode(PosXML) + "</textarea>")

	result = iPosProcess(PostUrl,  "prmstr=" + PosXML)

	Response.Write("<h1>Sonuc Degerleri</h1>")
	Response.Write("<textarea rows=""15"" cols=""60"">" + Server.HTMLEncode(result) + "</textarea>")


%>
