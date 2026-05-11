<%@ Language=VBScript %>
<%
Function GetGuid() 
        Set TypeLib = CreateObject("Scriptlet.TypeLib") 
        GetGuid = "SipID_1389" + Replace(Replace(Replace(Left(CStr(TypeLib.Guid), 32),"{",""),"}",""),"-","") 
        Set TypeLib = Nothing 
End Function

' This function sends the requestXML to the service
 Function iPosProcess(serviceUrl, requestXML)
  Set PostConnection = CreateObject("MSXML2.ServerXMLHTTP")
  serviceUrl = serviceUrl
  PostConnection.Open "POST", serviceUrl, False
  PostConnection.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  PostConnection.Send requestXML
  iPosProcess = PostConnection.responseText
  Set PostConnection = Nothing
End Function
 
dim PostUrl 
dim IsyeriNo 
dim TerminalNo
dim IslemTipi
dim TutarKodu 
dim IsyeriSifre 
dim KartNo
dim KartAy 
dim KartYil 
dim KartCvv 
dim Tutar 
dim SiparID
dim PosXML
dim result
   
	    PostUrl="https://onlineodeme.vakifbank.com.tr:4443/VposService/v3/Vposreq.aspx"
		IsyeriNo=Request.Form("IsyeriNo")
		TerminalNo=Request.Form("TerminalNo")
		IsyeriSifre=Request.Form("IsyeriSifre")
		KartNo=Request.Form("KartNo")
		KartAy=Request.Form("KartAy")
		KartYil=Request.Form("KartYil")
		KartCvv=Request.Form("KartCvv")
		Tutar=Request.Form("Tutar") 
		SiparID=GetGuid()
		IslemTipi=Request.Form("IslemTipi")
		TutarKodu=Request.Form("TutarKodu")

	PosXML ="<?xml version=""1.0"" encoding=""utf-8""?>" + "<VposRequest>" + "<MerchantId>" + IsyeriNo + "</MerchantId>" + "<Password>" + IsyeriSifre + "</Password>" + "<TerminalNo>"+TerminalNo+"</TerminalNo>" + "<TransactionType>"+IslemTipi+"</TransactionType>" + "<TransactionId>" + SiparID + "</TransactionId>"
	PosXML= PosXML + "<CurrencyAmount>" + Tutar + "</CurrencyAmount>" + "<CurrencyCode>"+TutarKodu+"</CurrencyCode>" + "<Pan>" + KartNo + "</Pan>" + "<Expiry>" + KartYil + KartAy + "</Expiry>" '3D Secure işyerlerimizin bu parametreyi kullanmasına lüzum yoktur.
	PosXML=PosXML + "<Cvv>" + KartCvv + "</Cvv><TransactionDeviceSource>0</TransactionDeviceSource></VposRequest>"

	Response.Write("<h1>Xml formati </h1>")
	Response.Write(PostUrl + "<br>")
	Response.Write("<textarea rows=""15"" cols=""60"">" + PosXML + "</textarea>")

	result = iPosProcess(PostUrl,  "prmstr=" + PosXML)

	Response.Write("<h1>Sonuc Degerleri</h1>")
	Response.Write("<textarea rows=""15"" cols=""60"">" + result + "</textarea>")


%>
