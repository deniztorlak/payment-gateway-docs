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
        strMode = "TEST"
        strApiVersion = "v0.01"
        strTerminalProvUserID = "PROVOOS"
        strType = "gpdatarequest"
        strAmount = "100" 'Ýþlem Tutarý
        strCurrencyCode = "949"
        strInstallmentCount = "" 'Taksit Sayýsý. Boþ gönderilirse taksit yapýlmaz
        strTerminalUserID = "PROVOOS"
        strOrderID = "5944_12717"
	    strCompanyName = "Malkoc Bebe"  'Ödeme sayfasýna çikacak firma adý
        strcustomeremailaddress = "eticaret@garanti.com.tr"
        strCustomeripaddress = "176.240.70.81"  'Kullanýcý IP adresi 
        strTerminalID = "30690133"
        strTerminalID_ = "030690133" 'TerminalID baþýna 0 ile 9 digit yapýlmalý
        strTerminalMerchantID = "3424113" 'MerchantID (Üye iþyeri) 
        strStoreKey = "12345678" '3D Secure þifreniz
        strProvisionPassword = "123qweASD/" 'SanalPos þifreniz (PROVOOS Kullanýcýsýnýn resetlenen þifresi) 
        strSuccessURL = "https://........./ResultSecure.asp" 'https://eticaret.garanti.com.tr/destek/postback.aspx
        strErrorURL = "https://........./ResultSecure.asp"  'https://eticaret.garanti.com.tr/destek/postback.aspx
        strtimestamp = now() 'Random ve Unique bir deðer olmalý
        strLang = "tr"
        SecurityData = hex_sha1(strProvisionPassword + strTerminalID_)
        HashData = hex_sha1(strTerminalID + strOrderID + strAmount + strSuccessURL + strErrorURL + strType + strInstallmentCount + strStoreKey + SecurityData)
       
		response.write(strOrderID )

	%>
    <form action="https://sanalposprovtest.garanti.com.tr/servlet/gt3dengine" method="post">
        3D Security Level: 
        <select name="secure3dsecuritylevel">
            <option value="CUSTOM_PAY">CUSTOM_PAY</option>
                </select>

        <input name="refreshtime" type="hidden" value="3" />
		<input type="hidden" name="orderid"" value="<%=strOrderID  %>" />
        <input id="submit" type="submit" value="submit" />
        <input type="hidden" name="mode" value="<%=strMode %>" />
        <input type="hidden" name="apiversion" value="<%=strApiVersion %>" />
        <input type="hidden" name="terminalprovuserid" value="<%=strTerminalProvUserID %>" />
        <input type="hidden" name="terminaluserid" value="<%=strTerminalUserID %>" />
        <input type="hidden" name="terminalid" value="<%=strTerminalID %>" />
        <input type="hidden" name="terminalmerchantid" value="<%=strTerminalMerchantID %>" />
        <input type="hidden" name="customeremailaddress" value="<%=strcustomeremailaddress %>" />
        <input type="hidden" name="customeripaddress" value="<%=strCustomeripaddress %>" />
        <input type="hidden" name="txnamount" value="<%=strAmount %>" />
        <input type="hidden" name="txncurrencycode" value="<%=strCurrencyCode %>" />
        <input type="hidden" name="companyname" value="<%=strcompanyname %>" />
        <input type="hidden" name="txninstallmentcount" value="<%=strInstallmentCount %>" />
        <input type="hidden" name="successurl" value="<%=strSuccessURL %>" />
        <input type="hidden" name="errorurl" value="<%=strErrorURL %>" />
        <input type="hidden" name="secure3dhash" value="<%=HashData %>" />
        <input type="hidden" name="lang" value="<%=strLang %>" />
        <input type="hidden" name="txntimestamp" value="<%=strtimestamp %>" />
		<input type="hidden" name="garantipay" value="Y" />
	    <input type="hidden" name="bnsuseflag" value="Y" />
        <input type="hidden" name="fbbuseflag" value="N" />
        <input type="hidden" name="chequeuseflag" value="N" />
		<input type="hidden" name="mileuseflag" value="N" />
		<input type="hidden" name="addcampaigninstallment" value="Y" />
        <input type="hidden" name="txntype" value="<%=strType %>" />
        <input type="hidden" name="txnsubtype" value="sales" />
		<input type="hidden" name="totallinstallmentcount"" value="3" />
        <input type="hidden" name="installmentnumber1" value="2" />
        <input type="hidden" name="installmentamount1" value="100" />
        <input type="hidden" name="installmentnumber2" value="3" />
        <input type="hidden" name="installmentamount2" value="100" />
		<input type="hidden" name="installmentnumber3" value="4" />
        <input type="hidden" name="installmentamount3" value="100" />

    </form>
</body>
</html>