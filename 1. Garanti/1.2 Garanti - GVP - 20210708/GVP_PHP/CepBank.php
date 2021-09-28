<html>
<head>
    <title>CepBank</title>
</head>
<body>
    <?php
        $strMode = "PROD";
        $strVersion = "v0.01";
        $strTerminalID = "XXXXXXXXX";
        $strTerminalID_ = "0XXXXXXXX"; //Ba��na 0 eklenerek 9 digite tamamlanmal�d�r.
        $strProvUserID = "PROVAUT";
        $strProvisionPassword = "XXXXXXXX"; //Terminal UserID �ifresi
        $strUserID = "XXXXXX";
        $strMerchantID = "XXXXXXXX"; //�ye ��yeri Numaras�
        $strCustomerName = "Yahya EK�NC�";
        $strIPAddress = "192.168.1.1";
        $strEmailAddress = "eticaret@garanti.com.tr";
        $strOrderID = "Deneme";
        $strInstallmentCnt = ""; //Taksit Say�s�. Bo� g�nderilirse taksit yap�lmaz
        $strGSMNumber = $_POST['txtGSMNumber'];
        $strPaymentType = $_POST['ddlPaymentType'];
        $strAmount = "100"; //��lem Tutar�
        $strType = "cepbank";
        $strCurrencyCode = "949";
        $strCardholderPresentCode = "0";
        $strMotoInd = "N";
        $strHostAddress = "https://sanalposprov.garanti.com.tr/VPServlet";
        $SecurityData = strtoupper(sha1($strProvisionPassword.$strTerminalID_));
        $HashData = strtoupper(sha1($strOrderID.$strTerminalID.$strNumber.$strAmount.$SecurityData));
        $xml= "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
        <GVPSRequest>
        <Mode>$strMode</Mode><Version>$strVersion</Version>
        <Terminal><ProvUserID>$strProvUserID</ProvUserID><HashData>$HashData</HashData><UserID>$strUserID</UserID><ID>$strTerminalID</ID><MerchantID>$strMerchantID</MerchantID></Terminal>
        <Customer><IPAddress>$strIPAddress</IPAddress><EmailAddress>$strEmailAddress</EmailAddress></Customer>
        <Card><Number></Number><ExpireDate></ExpireDate><CVV2></CVV2></Card>
        <Order><OrderID>$strOrderID</OrderID><GroupID></GroupID></Order>
        <Transaction>
        <Type>$strType</Type><InstallmentCnt>$strInstallmentCnt</InstallmentCnt><Amount>$strAmount</Amount><CurrencyCode>$strCurrencyCode</CurrencyCode><CardholderPresentCode>$strCardholderPresentCode</CardholderPresentCode><MotoInd>$strMotoInd</MotoInd><Description></Description><OriginalRetrefNum></OriginalRetrefNum>
        <CepBank><GSMNumber>$strGSMNumber</GSMNumber><PaymentType>$strPaymentType</PaymentType></CepBank>
        </Transaction>
        </GVPSRequest>";
    
        If ($_POST['IsFormSubmitted'] == ""){
        }
        else {
        
        $ch=curl_init();
        curl_setopt($ch, CURLOPT_URL, $strHostAddress);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1) ;
        curl_setopt($ch, CURLOPT_POSTFIELDS, "data=".$xml);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        $results = curl_exec($ch);
        curl_close($ch);

        echo "<b>Giden �stek </b><br />";
        echo $xml;
        echo "<br /><b>Gelen Yan�t </b><br />";
        echo $results;
        }
    ?>
    <form action="?" method="post">
        GSM Number: <input name="txtGSMNumber" type="text" />
        <br />
        Payment Type :
        <select name="ddlPaymentType">
            <option value="K">Kredi Kart�</option>
            <option value="D">Debit Kart</option>
            <option value="V">Vadesiz Hesap</option>
        </select>
        <br />
        <input type="hidden" name="IsFormSubmitted" value="submitted" />
        <input id="submit" type="submit" value="G�nder" />
    </form>
</body>
</html>