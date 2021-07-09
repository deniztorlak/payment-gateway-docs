<html>
<head>
    <title></title>
</head>
<body>
    <?php
        $strMode = "PROD";
        $strApiVersion = "v0.01";
        $strTerminalProvUserID = "PROVOOS";
        $strType = "sales";
        $strAmount = "100"; //��lem Tutar� 1.00 TL i�in 100 g�nderilmelidir.
        $strCurrencyCode = "949";
        $strInstallmentCount = ""; //Taksit Say�s�. Bo� g�nderilirse taksit yap�lmaz
        $strTerminalUserID = "XXXXXX";
        $strOrderID = "DENEME";  //her i�lemde farkl� bir de�er g�nderilmeli
        $strcompanyname = "TradeSiS";
        $strcustomeremailaddress = "eticaret@garanti.com.tr";
        $strCustomeripaddress = "127.0.0.1";
        $strTerminalID = "XXXXXXXX";
        $strTerminalID_ = "0XXXXXXXX"; //Ba��na 0 eklenerek 9 digite tamamlanmal�d�r.
        $strTerminalMerchantID = "XXXXXX"; //�ye ��yeri Numaras�
        $strStoreKey = "XXXXXX"; //3D Secure �ifreniz
        $strProvisionPassword = "XXXXXX"; //TerminalProvUserID �ifresi
        $strSuccessURL = "https://<sunucu_adresi>/Gate3DEngineCallBack.php";
        $strErrorURL = "https://<sunucu_adresi>/Gate3DEngineCallBack.php";
        $strtimestamp = "XXXXXX"; //Random ve Unique bir de�er olmal�
        $strLang = "tr";
        $SecurityData = strtoupper(sha1($strProvisionPassword.$strTerminalID_));
        $HashData = strtoupper(sha1($strTerminalID.$strOrderID.$strAmount.$strSuccessURL.$strErrorURL.$strType.$strInstallmentCount.$strStoreKey.$SecurityData));
    ?>
    <form action="https://sanalposprov.garanti.com.tr/servlet/gt3dengine" method="post">
        3D Security Level: 
        <select name="secure3dsecuritylevel">
            <option value="3D_OOS_PAY">3D_OOS_PAY</option>
            <option value="3D_OOS_FULL">3D_OOS_FULL</option>
            <option value="3D_OOS_HALF">3D_OOS_HALF</option>
        </select>
        <br />
        Refresh Time: <input name="refreshtime" type="text" />
        <br />
        <input id="submit" type="submit" value="��lemi G�nder" />
        <input type="hidden" name="mode" value="<?php echo $strMode ?>" />
        <input type="hidden" name="apiversion" value="<?php echo $strApiVersion ?>" />
        <input type="hidden" name="terminalprovuserid" value="<?php echo $strTerminalProvUserID ?>" />
        <input type="hidden" name="terminaluserid" value="<?php echo $strTerminalUserID ?>" />
        <input type="hidden" name="terminalid" value="<?php echo $strTerminalID ?>" />
        <input type="hidden" name="terminalmerchantid" value="<?php echo $strTerminalMerchantID ?>" />
        <input type="hidden" name="orderid" value="<?php echo $strOrderID ?>" />
        <input type="hidden" name="customeremailaddress" value="<?php echo $strcustomeremailaddress ?>" />
        <input type="hidden" name="customeripaddress" value="<?php echo $strCustomeripaddress ?>" />
        <input type="hidden" name="txntype" value="<?php echo $strType ?>" />
        <input type="hidden" name="txnamount" value="<?php echo $strAmount ?>" />
        <input type="hidden" name="txncurrencycode" value="<?php echo $strCurrencyCode ?>" />
        <input type="hidden" name="companyname" value="<?php echo $strcompanyname ?>" />
        <input type="hidden" name="txninstallmentcount" value="<?php echo $strInstallmentCount ?>" />
        <input type="hidden" name="successurl" value="<?php echo $strSuccessURL ?>" />
        <input type="hidden" name="errorurl" value="<?php echo $strErrorURL ?>" />
        <input type="hidden" name="secure3dhash" value="<?php echo $HashData ?>" />
        <input type="hidden" name="lang" value="<?php echo $strLang ?>" />
        <input type="hidden" name="txntimestamp" value="<?php echo $strtimestamp ?>" />
        <!---
        'Sipari�e y�nelik Fatura bilgilerini g�ndermek i�in ekteki opsiyonel alanlar kullan�labilir.
        'E�er birden �ok Fatura detay� g�nderilecekse orderaddresscount=2 yap�larak
        'T�m element isimlerindeki 1 rakam� 2 yap�lmal�d�r. �rn; orderaddresscity2 gibi...
        <input type="hidden" name="orderaddresscount" value="1" />
        <input type="hidden" name="orderaddresscity1" value="xxx" />
        <input type="hidden" name="orderaddresscompany1" value="xxx" />
        <input type="hidden" name="orderaddresscountry1" value="xxx" />
        <input type="hidden" name="orderaddressdistrict1" value="xxx" />
        <input type="hidden" name="orderaddressfaxnumber1" value="xxx" />
        <input type="hidden" name="orderaddressgsmnumber1" value="xxx" />
        <input type="hidden" name="orderaddresslastname1" value="xxx" />
        <input type="hidden" name="orderaddressname1" value="xxx" />
        <input type="hidden" name="orderaddressphonenumber1" value="xxx" />
        <input type="hidden" name="orderaddresspostalcode1" value="xxx" />
        <input type="hidden" name="orderaddresstext1" value="xxx" />
        <input type="hidden" name="orderaddresstype1" value="xxx" />
        --->
    </form>
</body>
</html>