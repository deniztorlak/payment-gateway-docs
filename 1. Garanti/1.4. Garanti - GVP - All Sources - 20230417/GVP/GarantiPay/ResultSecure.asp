<html>
<head>
<title>3D Pay �deme Sayfasi</title>
<meta http-equiv="Content-Language" content="tr">
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv="Expires" content="now">

3D_PAY / 3D_HALF / 3D_FULL / 3D_OOS_FULL / 3D_OOS_PAY /3D_OOS_HALF ve OOS_PAY ICIN GUVENLIK DOGRULAMALI DONUS SAYFASIDIR...
</head>
<body>
   <!-- #include file = "MACSHA1.asp" -->
    <%

        strMDStatus = Request.Form("mdstatus")
	model = Request.Form("secure3dsecuritylevel")
	If Not model = "OOS_PAY" Then
	Response.Write("<br>")
	Response.write STRING(60, "-")
	Response.Write("<br>mdstatus i�in �nemli not: bu de�er sadece 3d sifre dogrulamas� ilgili sonu� verir.")
	Response.Write("<br>")
	Response.write STRING(60, "-") & ("<br>")

	Response.Write("<br>3d sorgulamas�n�n d�n�� bilgisi: ")
	

        If strMDStatus = 1 Then  
	 Response.Write("<br>3D d�n�s mdstatus 1 Tam Do�rulama ")
        ElseIf strMDStatus = 2 Then
            Response.Write("<br>3D d�n�s mdstatus 2 Kart Sahibi veya bankas� sisteme kay�tl� de�il")
        ElseIf strMDStatus = 3 Then
            Response.Write("<br>3D d�n�s mdstatus 3 Kart�n bankas� sisteme kay�tl� de�il")
        ElseIf strMDStatus = 4 Then
            Response.Write("<br>3D d�n�s mdstatus 4 Do�rulama denemesi, kart sahibi sisteme daha sonra kay�t olmay� se�mis")
        ElseIf strMDStatus = 5 Then
            Response.Write("<br>3D d�n�s mdstatus 5 Do�rulama yap�lam�yor")
	        ElseIf strMDStatus = 6 Then
            Response.Write("<br>3D d�n�s mdstatus 6 3D kayd�n�z hen�z tamamlanmam�s, ilk tan�mlamada visa master kayd� 7-10 g�n s�rebilmektedir..")
        ElseIf strMDStatus = 7 Then
            Response.Write  ("<br> !!!!!3D Al�nan hata mdstatus 7 - bu durumda �nce mderrormessage bak�n�z !!!!!")
	    Response.Write("<br> * Kullan�m tipi desteklenmiyor ise kullan�lan 3d modeliniz hatal� veya 3d tan�m�n�z bulunmuyor")
	    Response.Write("<br> * Guvenlik Kodu hatali mesaj� i�in 8. sayfa faydal� olacakt�r http://www.garantipos.com.tr/mailing/Gvpkullanim.pdf <br>")
	 
        ElseIf strMDStatus = 8 Then
            Response.Write("<br>Bilinmeyen Kart No")
        ElseIf strMDStatus = 0 Then
            Response.Write("<br>3D Do�rulama Basar�s�z, 3-D Secure imzas� ge�ersiz. mdstatus 0 ")
        End If
	
	else
	Response.Write UCase ("<br>OOS_PAY 3d sorgulamasIz modeldir..")
      End If 

    %>

    <%

detail = "1"   ' d�nen t�m de�erleri yazd�rmak i�in 1 olmal� hata ay�klamak i�in.

	Response.Write("<br><br> Provizyon do�rulama:<br>")
    	sonuc = ""
	isValidHash = False
	responseHashparams =  request.form("hashparams")
	responseHashparams = LCase (responseHashparams)
	responseHashparamsval = request.form("hashparamsval")
	responseHash = request.form("hash")
	storekey = "12345678" //TODO STORE KEY OF TERMINAL /store key de�erimiz.
	

	br = "<br>"
        
	If Not IsEmpty(request.form("hashparams")) Then 
			digestData = ""
			paramList = Split(responseHashparams,":")
            paramCount = Ubound(paramList)
			
            for i = 0 to paramCount
                param = paramList(i)
                value = request.form(param)
                if(value = null) then
                   value = ""
                end if 
                digestData = digestData & value
            next			
            
		hashCalculated = b64_sha1(digestData & storekey)
	
			

			if(responseHash = hashCalculated) then 
				Response.Write(br & "***Mesaj Bankadan Geliyor***")
				sonuc = request.form("procreturncode")
				isValidHash = True
			else
				Response.Write(br & "!!!!!Dikkat Mesaj Bankadan Gelmiyor!!!!!")
				Response.Write(br & "!!!!!veya store keyiniz hatal� !!!!!")
				Response.Write(br & "RESPONSE HASH : [" & responseHash & "]")
				Response.Write(br & "CALCULATED HASH : ["& hashCalculated &"]")
			end if 
	  		else
			Response.Write(br & "!!!!!FATAL ERROR/INTEGRATION ERROR!!!!!")
			Response.Write(br & "response :" &request.form("response"))
			Response.Write(br & "procreturncode :" & request.form("procreturncode"))
			Response.Write(br & "mderrormessage :" & request.form("mderrormessage"))
	  		end if 
	  
	  Response.Write(br & " Validation :" & isValidHash)
		
	Response.Write(br)

	if isValidHash = True then

	        'isValidHash True  ve  procreturncode 00 d�nd���nde i�lem ba�ar�l�d�r.
           	If sonuc = "00" Then
                Response.Write "��lem Onayland�"
		Response.Write(br & "Onay no :" & request.form("authcode"))
           	Else
		Response.Write "Red onaylanmad� <br />"
               	Response.Write "��lem Ba�ar�s�z.. "
		Response.Write(br & "Hata kodu :" & request.form("procreturncode") & br & br)
	      
               Response.Write strErrorMsg ' Veya strSysErrMsg Veya kendi mesaj�m�z� da yazabiliriz.
			 '  Response.Redirect "http://localhost/asp/asptest/HATA.asp"
           	End If
	
	End If	 
	
	if detail = 1 Then 
	%>
	<td><b><br> Yap�y� anlamak i�in d�nen t�m de�erlerin listesi : </b></td><br>
        <table border="1">
        <tr>
            <td><b>Parametre Ismi</b></td>
            <td><b>Parametre Degeri</b></td>
        </tr>
	<%

	        For each obj in request.form
           	response.write("<tr><td>" & obj &"</td><td>" & request.form(obj) & "</td></tr>")
        Next
	End If	


    %>


</body>
</html>