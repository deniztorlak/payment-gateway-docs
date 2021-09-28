<html>
<head>
    <title></title>
</head>
<body>
    <?php
        $strMode = "PROD";
        $strVersion = "v0.01";
        $strTerminalID = "XXXXXXXX";
        $strTerminalID_ = "0XXXXXXXX"; //TerminalID ba��na 0 eklenerek 9 digite tamamlanmal�d�r.
        $strProvUserID = "PROVAUT";
        $strProvisionPassword = "XXXXXXX"; //ProvUserID �ifresi
        $strUserID = "XXXXXX";
        $strMerchantID = "XXXXXXX"; //�ye ��yeri Numaras�
        $strIPAddress = "192.168.1.1";  //M��teri IP si 
        $strEmailAddress = "eticaret@garanti.com.tr";
        $strOrderID = "Deneme";
        $strInstallmentCnt = ""; //Taksit Say�s�. Bo� g�nderilirse taksit yap�lmaz
        $strNumber = $_POST['cardnumber'];
        $strExpireDate = $_POST['cardexpiredatemonth'].$_POST['cardexpiredateyear'];
        $strCVV2 = $_POST['cardcvv2'];
        $strAmount = "100"; //��lem Tutar� 1.00 TL i�in 100 g�nderilmelidir. 
        $strType = "sales";
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
        <Card><Number>$strNumber</Number><ExpireDate>$strExpireDate</ExpireDate><CVV2>$strCVV2</CVV2></Card>
        <Order><OrderID>$strOrderID</OrderID><GroupID></GroupID><AddressList><Address><Type>S</Type><Name></Name><LastName></LastName><Company></Company><Text></Text><District></District><City></City><PostalCode></PostalCode><Country></Country><PhoneNumber></PhoneNumber></Address></AddressList></Order><Transaction><Type>$strType</Type><InstallmentCnt>$strInstallmentCnt</InstallmentCnt><Amount>$strAmount</Amount><CurrencyCode>$strCurrencyCode</CurrencyCode><CardholderPresentCode>$strCardholderPresentCode</CardholderPresentCode><MotoInd>$strMotoInd</MotoInd><Description></Description><OriginalRetrefNum></OriginalRetrefNum></Transaction>
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
        
        $xml_parser = xml_parser_create();
        xml_parse_into_struct($xml_parser,$results,$vals,$index);
        xml_parser_free($xml_parser);
        
        //Sadece ReasonCode de�erini al�yoruz.
        $strReasonCodeValue = $vals[$index['REASONCODE'][0]]['value'];
        
        echo "<br /><b>��lem Sonucu </b><br />";
        if($strReasonCodeValue == "00")
        { 
            echo "��lem Ba�ar�l�";
        } else {
            echo "��lem Ba�ar�s�z"; 
        }
        }
    ?>
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