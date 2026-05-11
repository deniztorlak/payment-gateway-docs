<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?php error_reporting(E_ALL ^ E_NOTICE);
session_start();
header('Content-Type: text/html; charset=utf-8');
 ?>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
    <style>
        .mainDiv
        {
            width:400px;
            height:240px;
            position:absolute;
            left:50%;
            margin-left:-250px;
            color: black; 
            border:6px inset red; 
            border-radius: 15px;
            display: inline;
            padding:15px;
            box-shadow: 10px 10px 5px #888; 
        }
        .innerSpan
        {
            width:200px;
            float:left;
            padding:4px 0 0 0;
			height:15px;
        }
		.rightSpan
        {
            width:200px;
            float:right;
            padding:4px 0 0 0;
			height:15px;
        }
    </style>
</head>
<body>
   <form id="form1" runat="server" method="post" action="ReturnUrl.php">
   
   <?php 
   $sessionData = $_SESSION['$_POST["VerifyEnrollmentRequestId"]'];
	$sessionArray = explode('&', $sessionData);
   ?>
   <?php


$PostUrl      = 'https://sp-test.innova.com.tr/VAKIFBANK_V4/VposWeb/v3/Vposreq.aspx';
$IsyeriNo     = $sessionArray[4];
$IsyeriSifre  = $sessionArray[3];
$TerminalNo    = $sessionArray[8];
$KartNo       = $sessionArray[0];
$KartExpiry   = '20'.$sessionArray[1];
$KartCvv      = $sessionArray[2];
$Tutar        = $sessionArray[6];
$SiparID      = $_POST["VerifyEnrollmentRequestId"];
$IslemTipi    = 'Sale';
$TutarKodu    = $sessionArray[7];
$ClientIp     = "127.0.0.1";

 
 $PosXML = 'prmstr=<VposRequest><ECI>'.$_POST["Eci"].'</ECI>
 <CAVV>'.$_POST["Cavv"].'</CAVV>
 <MerchantId>'.$IsyeriNo.'</MerchantId>
 <Password>'.$IsyeriSifre.'</Password>
 <TerminalNo>'.$TerminalNo.'</TerminalNo>
 <TransactionType>'.$IslemTipi.'</TransactionType>
 <MpiTransactionId>'.$SiparID.'</MpiTransactionId>
 <CurrencyAmount>'.$Tutar.'</CurrencyAmount>
 <CurrencyCode>'.$TutarKodu.'</CurrencyCode>
 <Pan>'.$KartNo.'</Pan>
 <Cvv>'.$KartCvv.'</Cvv>
 <Expiry>'.$KartExpiry.'</Expiry>
 <TransactionDeviceSource>0</TransactionDeviceSource>
 <ClientIp>'.$ClientIp.'</ClientIp>
 </VposRequest>';

$ch = curl_init();
						   
curl_setopt($ch, CURLOPT_URL,$PostUrl);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS,$PosXML);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 5);
curl_setopt($ch, CURLOPT_TIMEOUT, 59);
//curl_setopt($ch, curl.options,array("CURLOPT_SSLVERSION"=>"CURL_SSLVERSION_DEFAULT"));
curl_setopt($ch, CURLOPT_SSLVERSION, 6);
curl_setopt ($ch, CURLOPT_CAINFO, "../cacert.pem");
//İhtiyaç olması halinde aşağıdaki gibi proxy açabilirsiniz.
/*$proxy = "iproxy:8080";
$proxy = explode(':', $proxy);
curl_setopt($ch, CURLOPT_PROXY, $proxy[0]);
curl_setopt($ch, CURLOPT_PROXYPORT, $proxy[1]);*/

if($_POST["Status"]=='Y')
{
	$result = curl_exec($ch);
}
// Check for errors and display the error message
if($errno = curl_errno($ch)) {
    //$error_message = curl_strerror($errno);
    echo "cURL error ({$errno}):\n";// {$error_message}";
}
curl_close($ch);

?>
    <div class="mainDiv">
	<div>
            <span class="innerSpan">Vpos Request</span>
            <span class="rightSpan"><input type="text" id="VposRequest" name="VposRequest" value="<?php print_r($PosXML) ?>" /></span>
         </div>
        <div>
            <span class="innerSpan">Vpos Response</span>
            <span class="rightSpan"><?php echo '<textarea rows="15" cols="60">'.$result.'</textarea>'; ?></span>
         </div>
    </form>

</body>
</html>
