<html>
<head>
    <title></title>
</head>
<body>
    <?php
        $strMode = "TEST";
        $strApiVersion = "v0.01";
        $strTerminalProvUserID = "PROVOOS";
        $strType = "gpdatarequest";
        $strAmount = "100"; //Ýþlem Tutarý 1.00 TL için 100 girilmelidir. 
        $strCurrencyCode = "949";
        $strInstallmentCount = ""; //Taksit Sayýsý. Boþ gönderilirse taksit yapýlmaz
        $strTerminalUserID = "PROVOOS";
        $strOrderID = "a".rand();  //her iþlemde farklý bir deðer gönderilmeli
        $strcompanyname = "TradeSiS";
        $strcustomeremailaddress = "eticaret@garanti.com.tr";
        $strCustomeripaddress = "127.0.0.1";
        $strTerminalID = "30690133";
        $strTerminalID_ = "030690133"; //Baþýna 0 eklenerek 9 digite tamamlanmalýdýr.
        $strTerminalMerchantID = "3424113"; //Üye Ýþyeri Numarasý        
        $strStoreKey = "12345678"; //3D Secure þifreniz
        $strProvisionPassword = "123qweASD/"; //TerminalProvUserID þifresi
        $strSuccessURL = "https://<sunucu_adresi>/Gate3DEngineCallBack.php";
        $strErrorURL = "https://<sunucu_adresi>/Gate3DEngineCallBack.php";
        $strtimestamp = strtotime(date("Y-m-d H:i:s")); //Random ve Unique bir deðer olmalý
        $strLang = "tr"; 
        $SecurityData = strtoupper(sha1($strProvisionPassword.$strTerminalID_));
        $HashData = strtoupper(sha1($strTerminalID.$strOrderID.$strAmount.$strSuccessURL.$strErrorURL.$strType.$strInstallmentCount.$strStoreKey.$SecurityData));
    ?>
    <form action="https://sanalposprovtest.garanti.com.tr/servlet/gt3dengine" method="post">
        3D Security Level: 
        <select name="secure3dsecuritylevel">
            <option value="CUSTOM_PAY">CUSTOM_PAY</option>
        </select>
        <br />

        <input id="submit" type="submit" value="İslemi Gönder" />
        <input type="text" name="mode"  id="mode"  value="<?php echo $strMode ?>" />
        <input type="text" name="apiversion" id="<?php echo $strApiVersion ?>" />
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
		<input type="text" name="refreshtime"  id="refreshtime" value="4"><br>
	
    txnSubType <input type="text" name="txnsubtype"  id="txnsubtype" value="sales"><br>
    garantipay<input type="text" name="garantipay" id="garantipay" value="Y"><br>
    bnsuseflag<input type="text" name="bnsuseflag" id="bnsuseflag" value="Y"><br>
    fbbuseflag<input type="text" name="fbbuseflag" id="fbbuseflag" value="Y"><br>
    chequeuseflag<input type="text" name="chequeuseflag" id="chequeuseflag" value="Y"><br>
    mileuseflag<input type="text" name="mileuseflag" id="mileuseflag" value="Y"><br>
    addcampaigninstallment<input type="text" name="addcampaigninstallment" id="addcampaigninstallment" value="Y"><br>
    totallinstallmentcount<input type="text" name="totallinstallmentcount" id="totallinstallmentcount" value="8"><br>
    installmentnumber1<input type="text" name="installmentnumber1" id="installmentnumber1"  value="2"><br>
    installmentamount1<input type="text" name="installmentamount1" id="installmentamount1"  value="101"><br>
    installmentratewithreward1<input type="text" name="installmentratewithreward1" id="installmentratewithreward1" value="1000"><br>
    installmentnumber2<input type="text" name="installmentnumber2" id="installmentnumber1"  value="4"><br>
    installmentamount2<input type="text" name="installmentamount2" id="installmentamount1" value="102"><br>
    installmentratewithreward2<input type="text" name="installmentratewithreward2" id="installmentratewithreward2" value="2000"><br>
    installmentnumber3<input type="text" name="installmentnumber3" id="installmentnumber1"  value="6"><br>
    installmentamount3<input type="text" name="installmentamount3" id="installmentamount1"  value="103"><br>
    installmentratewithreward3<input type="text" name="installmentratewithreward3" id="installmentratewithreward3" value="3000"><br>
    installmentnumber4<input type="text" name="installmentnumber4" id="installmentnumber1"  value="7"><br>
    installmentamount4<input type="text" name="installmentamount4" id="installmentamount1"  value="104"><br>
    installmentratewithreward4<input type="text" name="installmentratewithreward4" id="installmentratewithreward4" value=""><br>
    installmentnumber5<input type="text" name="installmentnumber5" id="installmentnumber1"  value="5"><br>
    installmentamount5<input type="text" name="installmentamount5" id="installmentamount1"  value="105"><br>
    installmentratewithreward5<input type="text" name="installmentratewithreward5" id="installmentratewithreward5" value=""><br>
    installmentnumber6<input type="text" name="installmentnumber6" id="installmentnumber1"  value="6"><br>
    installmentamount6<input type="text" name="installmentamount6" id="installmentamount1"  value="106"><br>
    installmentnumber7<input type="text" name="installmentnumber7" id="installmentnumber1"  value="7"><br>
    installmentamount7<input type="text" name="installmentamount7" id="installmentamount1"  value="107"><br>
    installmentnumber8<input type="text" name="installmentnumber8" id="installmentnumber1"  value="8"><br>
    installmentamount8<input type="text" name="installmentamount8" id="installmentamount1"  value="108"><br>
    motoind <input type="text" name="txnmotoind"  id="txnmotoind" value="N"><br>            
    mobilind <input type="text" name="mobilind"  id="mobilind"  value="N"><br>              
    orderitemcount <input type="text" name="orderitemcount"  id="orderitemcount"  value="2"><br>
    orderitemnumber1 <input type="text" name="orderitemnumber1"   id="orderitemnumber1"  value="1"><br>
    orderitemproductid1 <input type="text" name="orderitemproductid1"  id="orderitemproductid1"  value="A1"><br>
    orderitemproductcode1 <input type="text" name="orderitemproductcode1"  id="orderitemproductcode1"  value="A1"><br>
    orderitemquantity1 <input type="text" name="orderitemquantity1"  id="orderitemquantity1"    value="1"><br>
    orderitemprice1 <input type="text" name="orderitemprice1"  id="orderitemprice1"  value="100"><br>
    orderitemtotalamount1 <input type="text" name="orderitemtotalamount1"  id="orderitemtotalamount1"  value="100"><br>
    orderitemdescription1 <input type="text" name="orderitemdescription1"  id="orderitemdescription1"  value="AAA"><br>
    orderitemnumber2 <input type="text" name="orderitemnumber2"  id="orderitemnumber2"  value="2"><br>
    orderitemproductid2 <input type="text" name="orderitemproductid2"   id="orderitemproductid2"  value="A2"><br>
    orderitemproductcode2 <input type="text"  name="orderitemproductcode2"  id="orderitemproductcode2"  value="A2"><br>
    orderitemquantity2 <input type="text" name="orderitemquantity2"  id="orderitemquantity2"  value="1"><br>
    orderitemprice2 <input type="text" name="orderitemprice2"  id="orderitemprice2" value="200"><br>
    orderitemtotalamount2 <input type="text" name="orderitemtotalamount2"  id="orderitemtotalamount2"  value="200"><br>     

    </form>
</html>
