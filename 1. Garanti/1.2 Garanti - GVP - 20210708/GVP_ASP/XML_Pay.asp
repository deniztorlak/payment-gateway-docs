<html>
<head>
    <title></title>
    <script language="javascript" type="text/javascript" runat="server">
        
        var hexcase = 1;
        var b64pad = "=";
        var chrsz = 8;

        function hex_sha1(s) { return binb2hex(core_sha1(str2binb(s), s.length * chrsz)); }
        function b64_sha1(s) { return binb2b64(core_sha1(str2binb(s), s.length * chrsz)); }
        function str_sha1(s) { return binb2str(core_sha1(str2binb(s), s.length * chrsz)); }
        function hex_hmac_sha1(key, data) { return binb2hex(core_hmac_sha1(key, data)); }
        function b64_hmac_sha1(key, data) { return binb2b64(core_hmac_sha1(key, data)); }
        function str_hmac_sha1(key, data) { return binb2str(core_hmac_sha1(key, data)); }

        function sha1_vm_test() {
            return hex_sha1("abc") == "a9993e364706816aba3e25717850c26c9cd0d89d";
        }

        function core_sha1(x, len) {

            x[len >> 5] |= 0x80 << (24 - len % 32);
            x[((len + 64 >> 9) << 4) + 15] = len;

            var w = Array(80);
            var a = 1732584193;
            var b = -271733879;
            var c = -1732584194;
            var d = 271733878;
            var e = -1009589776;

            for (var i = 0; i < x.length; i += 16) {
                var olda = a;
                var oldb = b;
                var oldc = c;
                var oldd = d;
                var olde = e;

                for (var j = 0; j < 80; j++) {
                    if (j < 16) w[j] = x[i + j];
                    else w[j] = rol(w[j - 3] ^ w[j - 8] ^ w[j - 14] ^ w[j - 16], 1);
                    var t = safe_add(safe_add(rol(a, 5), sha1_ft(j, b, c, d)),
                           safe_add(safe_add(e, w[j]), sha1_kt(j)));
                    e = d;
                    d = c;
                    c = rol(b, 30);
                    b = a;
                    a = t;
                }

                a = safe_add(a, olda);
                b = safe_add(b, oldb);
                c = safe_add(c, oldc);
                d = safe_add(d, oldd);
                e = safe_add(e, olde);
            }
            return Array(a, b, c, d, e);

        }

        function sha1_ft(t, b, c, d) {
            if (t < 20) return (b & c) | ((~b) & d);
            if (t < 40) return b ^ c ^ d;
            if (t < 60) return (b & c) | (b & d) | (c & d);
            return b ^ c ^ d;
        }

        function sha1_kt(t) {
            return (t < 20) ? 1518500249 : (t < 40) ? 1859775393 :
             (t < 60) ? -1894007588 : -899497514;
        }

        function core_hmac_sha1(key, data) {
            var bkey = str2binb(key);
            if (bkey.length > 16) bkey = core_sha1(bkey, key.length * chrsz);

            var ipad = Array(16), opad = Array(16);
            for (var i = 0; i < 16; i++) {
                ipad[i] = bkey[i] ^ 0x36363636;
                opad[i] = bkey[i] ^ 0x5C5C5C5C;
            }

            var hash = core_sha1(ipad.concat(str2binb(data)), 512 + data.length * chrsz);
            return core_sha1(opad.concat(hash), 512 + 160);
        }

        function safe_add(x, y) {
            var lsw = (x & 0xFFFF) + (y & 0xFFFF);
            var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
            return (msw << 16) | (lsw & 0xFFFF);
        }

        function rol(num, cnt) {
            return (num << cnt) | (num >>> (32 - cnt));
        }

        function str2binb(str) {
            var bin = Array();
            var mask = (1 << chrsz) - 1;
            for (var i = 0; i < str.length * chrsz; i += chrsz)
                bin[i >> 5] |= (str.charCodeAt(i / chrsz) & mask) << (32 - chrsz - i % 32);
            return bin;
        }

        function binb2str(bin) {
            var str = "";
            var mask = (1 << chrsz) - 1;
            for (var i = 0; i < bin.length * 32; i += chrsz)
                str += String.fromCharCode((bin[i >> 5] >>> (32 - chrsz - i % 32)) & mask);
            return str;
        }

        function binb2hex(binarray) {
            var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
            var str = "";
            for (var i = 0; i < binarray.length * 4; i++) {
                str += hex_tab.charAt((binarray[i >> 2] >> ((3 - i % 4) * 8 + 4)) & 0xF) +
               hex_tab.charAt((binarray[i >> 2] >> ((3 - i % 4) * 8)) & 0xF);
            }
            return str;
        }

        function binb2b64(binarray) {
            var tab = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwx  yz0123456789+/";
            var str = "";
            for (var i = 0; i < binarray.length * 4; i += 3) {
                var triplet = (((binarray[i >> 2] >> 8 * (3 - i % 4)) & 0xFF) << 16)
                    | (((binarray[i + 1 >> 2] >> 8 * (3 - (i + 1) % 4)) & 0xFF) << 8)
                    | ((binarray[i + 2 >> 2] >> 8 * (3 - (i + 2) % 4)) & 0xFF);
                for (var j = 0; j < 4; j++) {
                    if (i * 8 + j * 6 > binarray.length * 32) str += b64pad;
                    else str += tab.charAt((triplet >> 6 * (3 - j)) & 0x3F);
                }
            }
            return str;
        }
    </script>
</head>
<body>
    <%
        strMode = "PROD"
        strVersion = "v0.01"
        strTerminalID = "XXXXXXXX"
        strTerminalID_ = "0" & strTerminalID
        strProvUserID = "PROVAUT"
        strProvisionPassword = "" 'TerminalProvUserID �ifresi
        strUserID = "XXXXXX" 'SanaPos Kullan�c� Ad�n�z
        strMerchantID = "XXXXXX" '�ye ��yeri Numaras�
        strCustomerName = "Yahya EK�NC�"
        strIPAddress = Request.ServerVariables("REMOTE_ADDR")
        strEmailAddress = "eticaret@garanti.com.tr"
        strOrderID = "Deneme" 'Her sipari� i�in unique bir de�er g�nderilmelidir.
        strInstallmentCnt = "" 'Taksit Say�s�. Bo� g�nderilirse taksit yap�lmaz
        strNumber = Request.Form("cardnumber")
        strExpireDate = Request.Form("cardexpiredatemonth") & Request.Form("cardexpiredateyear")
        strCVV2 = Request.Form("cardcvv2")
        strAmount = "100" '��lem Tutar� 1.00 TL i�in 100 g�nderilmeli
        strType = "sales"
        strCurrencyCode = "949"
        strCardholderPresentCode = "0"
        strMotoInd = "N"
        strHostAddress = "https://sanalposprov.garanti.com.tr/VPServlet"
        SecurityData = hex_sha1(strProvisionPassword + strTerminalID_)
        HashData = hex_sha1(strOrderID + strTerminalID + strNumber + strAmount + SecurityData)
    
        If Not IsEmpty(Request.Form("IsFormSubmitted")) Then

        'Provizyona Post edilecek XML �ablonu
        strXML = "<?xml version=""1.0"" encoding=""UTF-8""?>" & _
                 "<GVPSRequest>" & _
                 "<Mode>" & strMode & "</Mode>" & _
                 "<Version>" & strVersion & "</Version>" & _
                 "<ChannelCode></ChannelCode>" & _
                 "<Terminal><ProvUserID>" & strProvUserID & "</ProvUserID><HashData>" & HashData & "</HashData><UserID>" & strUserID & "</UserID><ID>" & strTerminalID & "</ID><MerchantID>" & strMerchantID & "</MerchantID></Terminal>" & _
                 "<Customer><IPAddress>" & strIPAddress & "</IPAddress><EmailAddress>" & strEmailAddress & "</EmailAddress></Customer>" & _
                 "<Card><Number>" & strNumber & "</Number><ExpireDate>" & strExpireDate & "</ExpireDate><CVV2>" & strCVV2 & "</CVV2></Card>" & _
                 "<Order><OrderID>" & strOrderID & "</OrderID><GroupID></GroupID><AddressList><Address><Type>S</Type><Name></Name><LastName></LastName><Company></Company><Text></Text><District></District><City></City><PostalCode></PostalCode><Country></Country><PhoneNumber></PhoneNumber></Address></AddressList></Order>" & _
                 "<Transaction>" & _
                 "<Type>" & strType & "</Type><InstallmentCnt>" & strInstallmentCnt & "</InstallmentCnt><Amount>" & strAmount & "</Amount><CurrencyCode>" & strCurrencyCode & "</CurrencyCode><CardholderPresentCode>" & strCardholderPresentCode & "</CardholderPresentCode><MotoInd>" & strMotoInd & "</MotoInd>" & _
                 "<Secure3D><AuthenticationCode>" & strAuthenticationCode & "</AuthenticationCode><SecurityLevel>" & strSecurityLevel & "</SecurityLevel><TxnID>" & strTxnID & "</TxnID><Md>" & strMD & "</Md></Secure3D>" & _
                 "</Transaction>" & _
                 "</GVPSRequest>"

           Set SrvHTTPS = Server.CreateObject("MSXML2.ServerXMLHTTP")
           Set XMLSend = Server.CreateObject("MSXML2.DOMDocument")
          
           'SrvHTTPS.setOption 2, 13056 'baz� serverlarda d��ar�ya https ile veri g�nderirken hata al�rsan�z aktif edin.
           SrvHTTPS.open "POST", strHostAddress, false
           SrvHTTPS.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
           SrvHTTPS.send "data="+strXML
         
           Set xmlDoc2 = CreateObject("MSXML2.DOMDocument")
           xmlDoc2.setProperty "ServerHTTPRequest", True
           xmlDoc2.async = True
           xmlDoc2.LoadXML SrvHTTPS.responseText
           
           'Bu b�l�m m��teriye g�sterilmemeli. Sadece Giden �stek ve Gelen Yan�t� g�rebilmeniz i�in ekledik.
           Response.Write "<br><b>Giden �stek</b><br />"
           Response.Write strXML
           Response.Write "<br>"
           Response.Write "<br><b>Gelen Yan�t</b><br />"
           Response_Doc = SrvHTTPS.responseText
           Response_Doc = Replace (Response_Doc,"<","&lt;")
           Response_Doc = Replace (Response_Doc,">","&gt;")
           Response.Write Response_Doc & "<br />"

           Set GVPSNodes = xmlDoc2.selectNodes("//GVPSResponse/Transaction/Response/*")

           'Geri d�nen response tag de�erlerini bir d�ng� i�erisinden se�erek g�sterebiliriz.
           Response.Write "<br /><b>Gelen Yan�t ��erisinden Se�tiklerimiz</b><br />"
           
           For each entry in GVPSNodes
           
               If entry.tagName = "ReasonCode" then
                    strReasonCode = entry.text
               Elseif entry.tagName = "Message" then
                    strMessage = entry.text
               Elseif entry.tagName = "ErrorMsg" then
                    strErrorMsg = entry.text
               Elseif entry.tagName = "SysErrMsg" then
                    strSysErrMsg = entry.text
               End if
               
           Next

           'M��teriye g�sterilebilir ama Fraud riski a��s�ndan bu de�erleri g�stermeyelim.
           Response.Write "ReasonCode: " & strReasonCode & "<br />"
           Response.Write "Message: " & strMessage & "<br />"
           Response.Write "ErrorMsg: " & strErrorMsg & "<br />"
           Response.Write "SysErrMsg: " & strSysErrMsg & "<br />"

           Response.Write "<br /><b>Gelen Yan�t ��erisinden M��teriye G�sterilebilecek Sonu�</b><br />"
           
           '00 ReasonCode d�nd���nde i�lem ba�ar�l�d�r.
           If strReasonCode = "00" Then
                Response.Write "��lem Ba�ar�l�"
           Else
               Response.Write "��lem Ba�ar�s�z <br />"
               Response.Write strErrorMsg ' Veya strSysErrMsg Veya kendi mesaj�m�z� da yazabiliriz.
           End If

        End If
    %>
    <form action="?" method="post">
        Card Number: <input name="cardnumber" type="text" />
        <br />
        Expire Date (mm): <input name="cardexpiredatemonth" type="text" />
        <br />
        Expire Date (yy): <input name="cardexpiredateyear" type="text" />
        <br />
        CVV2: <input name="cardcvv2" type="text" />
        <br />
        <input type="hidden" name="IsFormSubmitted" value="submitted" />
        <input id="submit" type="submit" value="��lemi G�nder" />
    </form>
</body>
</html>