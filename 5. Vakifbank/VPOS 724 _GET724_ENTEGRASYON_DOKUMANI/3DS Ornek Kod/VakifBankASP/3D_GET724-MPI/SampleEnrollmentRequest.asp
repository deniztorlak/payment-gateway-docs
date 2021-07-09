<%@ Language=VBScript %>
<html>
<head>
<title>3D Entegrasyon Vakifbank</title>
</head>
<%
' This function sends the requestXML to the service
 Function iPosProcess(serviceUrl, requestParams)
  Set PostConnection =server.CreateObject("MSXML2.ServerXMLHTTP")
  serviceUrl = serviceUrl
  PostConnection.Open "POST", serviceUrl, False
  PostConnection.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  PostConnection.Send requestParams
  iPosProcess = PostConnection.responseText
  Set PostConnection = Nothing
End Function

Function xmlParser(xmlString)
  	Set objDoc = server.createObject("Microsoft.XMLDOM")
 	
 	objDoc.loadXML(xmlString)
 	
 	dim resultDic
 	 statusNode = objDoc.getElementsByTagName("Status").item(0).text
 	 If statusNode="Y" Then

 	 ACSUrlNode = objDoc.getElementsByTagName("ACSUrl").item(0).text
 	 TermUrlNode = objDoc.getElementsByTagName("TermUrl").item(0).text
 	 MDNode = objDoc.getElementsByTagName("MD").item(0).text
 	 PAReqNode = objDoc.getElementsByTagName("PaReq").item(0).text
 	 MessageErrorCode = objDoc.getElementsByTagName("MessageErrorCode").item(0).text
 	 resultDic = Array(statusNode,PAReqNode,ACSUrlNode,TermUrlNode,MDNode,MessageErrorCode)
 	 Else
 	 MessageErrorCode = objDoc.getElementsByTagName("MessageErrorCode").item(0).text
 	 resultDic = Array(statusNode,MessageErrorCode)
 	 End If

 	xmlParser = resultDic
End Function

dim params
dim fname
dim result
dim resultXml
dim mpiServiceUrl
dim krediKartiNumarasi
dim sonKullanmaTarihi
dim kartTipi
dim tutar
dim paraKodu
dim taksitSayisi
dim islemNumarasi
dim ekVeri
dim uyeIsyeriNumarasi
dim uyeIsYeriSifresi
dim SuccessURL
dim FailureURL
dim IsRecurring
dim RecurringEndDate
dim RecurringFrequency

Function GetGuid() 
        Set TypeLib = CreateObject("Scriptlet.TypeLib") 
        GetGuid = "SIP_" + Replace(Replace(Replace(Left(CStr(TypeLib.Guid), 38),"{",""),"}",""),"-","") 
        Set TypeLib = Nothing 
End Function 

fname=Request.Form("form")
If fname="send" Then 

		mpiServiceUrl=	""
		krediKartiNumarasi = Request.Form("pan")
		sonKullanmaTarihi = Request.Form("ExpiryDate")
		kartTipi = Request.Form("BrandName")
		tutar = Request.Form("PurchaseAmount")
		paraKodu = Request.Form("Currency")
		taksitSayisi = Request.Form("InstallmentCount")
		islemNumarasi = Request.Form("VerifyEnrollmentRequestId")
		uyeIsyeriNumarasi = Request.Form("MerchantId")
		uyeIsYeriSifresi = Request.Form("MerchantPassword")
		SuccessURL = Request.Form("SuccessURL")
		FailureURL = Request.Form("FailureURL")
		ekVeri = Request.Form("SessionInfo")
		params = "Pan="+krediKartiNumarasi+"&ExpiryDate="+sonKullanmaTarihi+"&PurchaseAmount="+tutar+"&Currency="+paraKodu+"&BrandName="+kartTipi+"&VerifyEnrollmentRequestId="+islemNumarasi+"&SessionInfo="+ekVeri+"&MerchantId="+uyeIsyeriNumarasi+"&MerchantPassword="+uyeIsYeriSifresi+"&SuccessURL="+SuccessURL+"&FailureURL="+FailureURL+"&InstallmentCount="+taksitSayisi
		
		resultXml = iPosProcess(mpiServiceUrl,params)

		'resultXml = ""
		result = xmlParser(resultXml)
	If result(0)="Y" Then

%>
<html>
	<head>
		<title>iPay APM 3D-Secure Islem Sayfas,</title>
	</head>
	<body>
	
		<form name="downloadForm" action="<%=result(2) %>" method="POST">
<!--		<noscript>-->
		<br>
		<br>
		<div id="image1" style="position:absolute; overflow:hidden; left:0px; top:0px; width:180px; height:180px; z-index:0"><img src="http://sanalpos.innova.com.tr/iPayAPMTest/portal/images/basarili.png" alt="" title="" border=0 width=180 height=180></div>
		<center>
		<h1>3-D Secure Isleminiz yapiliyor</h1>
		<h2>
		Tarayicinizda Javascript kullanimi engellenmistir.
		<br></h2>
		<h3>
			3D-Secure isleminizin dogrulama asamasina gecebilmek icin Gonder butonuna basmaniz gerekmektedir
		</h3>
		<input type="submit" value="Gonder">
		</center>
<!--</noscript>-->
		<input type="hidden" name="PaReq" value="<%=result(1) %>">
		<input type="hidden" name="TermUrl" value="<%=result(3) %>">
		<input type="hidden" name="MD" value="<%=result(4) %>">
		</form>
	<SCRIPT LANGUAGE="Javascript" >
		//document.downloadForm.submit();
	</SCRIPT>
	</body>
</html>				
<%				
		 Else  
			Response.Write("3D-Secure Verify Enrollment Sonucu: ")
			Response.Write(result(0))
			Response.Write("<br>Hata Kodu: ")
			Response.Write(result(1))
			Response.Write("<br>")
			Response.Write("Islem Istegini Sanal Pos'a gonderiniz.")		
		 End If
	 Else 
	%>
<style>
.input_yeni {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 9pt;
	font-weight: bold;
	color: #666666;
	background-color: #FFFFFF;
	padding: 5px;
	border: 1px solid #CCCCCC;
}
.Basliklar {
	font-family: Tahoma;
	font-size: 9pt;
	font-weight: bold;
	color: #666666;
	padding-left: 10px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #EBEBEB;
	padding-top: 2px;
	text-align: right;
}
.AltCizgi {
	font-family: Tahoma;
	font-size: 9pt;
	font-weight: normal;
	color: #666666;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #EBEBEB;
	padding-top: 2px;
	padding-bottom: 2px;
	padding-left: 5px;
}
</style>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<form action="" method="post">
			<input type="hidden" name="form" value="send">
			<tr>
			<td width="10" height="10" bgcolor="#FBFBFB" class="Basliklar">&nbsp;</td>
			<td width="1" bgcolor="#FBFBFB" class="AltCizgi">&nbsp;</td>
			<B><td bgcolor="#FBFBFB" class="AltCizgi">3D Entegrasyon Vakifbank Pos islem Uye is yeri bilgileri</td></B>
		</tr>
		<tr>
			<td width="100" height="25" class="Basliklar">Uye Isyeri No</td>
			<td width="1" class="AltCizgi">:</td>
			<td class="AltCizgi">
			<input class="input_yeni" type="text" name="MerchantId" size="49" value="0"></td>
		</tr>
		<tr>
			<td width="100" height="25" class="Basliklar">İsyeri Sifre</td>
			<td width="1" class="AltCizgi">:</td>
			<td class="AltCizgi">
			<input class="input_yeni" type="text" name="MerchantPassword" size="49" value="0"></td>
		</tr>
		<tr>
			<td width="100" height="25" class="Basliklar">SuccessURL</td>
			<td width="1" class="AltCizgi">:</td>
			<td class="AltCizgi"><input class="input_yeni" type="text" name="SuccessURL" size="50" value="http://127.0.0.1/VakifBank/MPI/TempSuccessUrl.asp"></td>
		</tr>
		<tr>
			<td width="100" height="25" class="Basliklar">FailureURL</td>
			<td width="1" class="AltCizgi">:</td>
			<td class="AltCizgi"><input class="input_yeni" type="text" name="FailureURL" size="50" value="http://127.0.0.1/VakifBank/MPI/TempSuccessUrl.asp"></td>
		</tr>
		<td width="10" height="10" bgcolor="#FBFBFB" class="Basliklar">&nbsp;</td>
			<td width="1" bgcolor="#FBFBFB" class="AltCizgi">&nbsp;</td>
		<B><td bgcolor="#FBFBFB" class="AltCizgi">Kart Bilgileri</td></B>
		<tr>
			<td width="100" height="25" class="Basliklar">Kart No</td>
			<td width="1" class="AltCizgi">:</td>
			<td class="AltCizgi">
			<input class="input_yeni" type="text" name="pan" size="49" value="0"></td>
		</tr>
		<tr>
			<td width="100" height="25" class="Basliklar">Son K.Tarihi</td>
			<td width="1" class="AltCizgi"></td>
			<td class="AltCizgi">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="33">
					<input class="input_yeni" type="text" name="ExpiryDate" size="12" value="1412"></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td width="100" height="25" class="Basliklar">Kart Cvv</td>
			<td width="1" class="AltCizgi">:</td>
			<td class="AltCizgi"><input class="input_yeni" type="text" name="KartCvv" size="12" value="123"></td>
		</tr>
		<tr>
			<td width="100" height="25" class="Basliklar">Tutar</td>
			<td width="1" class="AltCizgi">:</td>
			<td class="AltCizgi"><input class="input_yeni" type="text" name="PurchaseAmount" size="12" value="18.00"></td>
		</tr>
		<tr>
			<td width="100" height="25" class="Basliklar">Kart Tipi</td>
			<td width="1" class="AltCizgi">:</td>
			<td class="AltCizgi"><input class="input_yeni" type="text" name="BrandName" size="12" value="100"></td>
		</tr>
		<tr>
			<td width="100" height="25" class="Basliklar">Para Turu</td>
			<td width="1" class="AltCizgi">:</td>
			<td class="AltCizgi">
			<input class="input_yeni" type="text" name="Currency" size="50" value="840"></td>
		</tr>
		<tr>
			<td width="100" height="25" class="Basliklar">Taksit</td>
			<td width="1" class="AltCizgi">:</td>
			<td class="AltCizgi"><input class="input_yeni" type="text" name="InstallmentCount" size="4" value=""></td>
		</tr>
		<tr>
			<td width="100" height="25" class="Basliklar">Siparis No</td>
			<td width="1" class="AltCizgi">:</td>
			<td class="AltCizgi"><input class="input_yeni" type="text" name="VerifyEnrollmentRequestId" size="50" value="<%=GetGuid()%>"></td>
		</tr>
		<tr>
			<td width="100" height="25" class="Basliklar">Session Info</td>
			<td width="1" class="AltCizgi">:</td>
			<td class="AltCizgi"><input class="input_yeni" type="text" name="SessionInfo" size="50" value="1"></td>
		</tr>
		            <br/> <input type="submit">
        </form>

    <%
    	
     End If %>
</html>