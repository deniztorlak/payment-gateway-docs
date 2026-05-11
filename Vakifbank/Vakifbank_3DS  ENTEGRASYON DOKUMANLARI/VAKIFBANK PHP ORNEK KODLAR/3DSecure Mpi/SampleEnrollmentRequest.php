<?php
error_reporting(E_ALL ^ E_NOTICE);
session_start();
// MPI'dan dönen XML cevabını yorumlayıp gerekli alanları bir dizi içerisinde döndürür
function SonucuOku($result)
{
	$resultDocument = new DOMDocument();
	$resultDocument->loadXML($result);		

	//Status Bilgisi okunuyor
	$statusNode = $resultDocument->getElementsByTagName("Status")->item(0);				
	$status = "";	
	if( $statusNode != null )
		$status = $statusNode->nodeValue;							
	
	//PAReq Bilgisi okunuyor
	$PAReqNode = $resultDocument->getElementsByTagName("PaReq")->item(0);			
	$PaReq = "";
	if( $PAReqNode != null )
		$PaReq = $PAReqNode->nodeValue;
	
	//ACSUrl Bilgisi okunuyor
	$ACSUrlNode = $resultDocument->getElementsByTagName("ACSUrl")->item(0);
	$ACSUrl = "";
	if( $ACSUrlNode != null )
		$ACSUrl = $ACSUrlNode->nodeValue;
		
	//Term Url Bilgisi okunuyor
	$TermUrlNode = $resultDocument->getElementsByTagName("TermUrl")->item(0);
	$TermUrl = "";
	if( $TermUrlNode != null )
		$TermUrl = $TermUrlNode->nodeValue;
	
	//MD Bilgisi okunuyor
	$MDNode = $resultDocument->getElementsByTagName("MD")->item(0);
	$MD = "";
	if( $MDNode != null )
		$MD = $MDNode->nodeValue;
	
	//MessageErrorCode Bilgisi okunuyor
	$messageErrorCodeNode = $resultDocument->getElementsByTagName("MessageErrorCode")->item(0);
	$messageErrorCode = "";
	if( $messageErrorCodeNode != null )
		$messageErrorCode = $messageErrorCodeNode->nodeValue;

	// Sonuç dizisi oluşturuluyor
	$result = array
	(
		"Status"=>$status,
		"PaReq"=>$PaReq,
		"ACSUrl"=>$ACSUrl,
		"TermUrl"=>$TermUrl,
		"MerchantData"=>$MD	,
		"MessageErrorCode"=>$messageErrorCode
	);
	return $result;	
}


	if($_POST["form"]=="send"){
		$_SESSION['$_POST["VerifyEnrollmentRequestId"]'] =  $_POST["Pan"].'&'.$_POST["ExpiryDate"].'&'.$_POST["KartCvv"].'&'.$_POST["MerchantPassword"].'&'.$_POST["MerchantId"].'&'.$_POST["InstallmentCount"].'&'.$_POST["PurchaseAmount"].'&'.$_POST["Currency"].'&'.$_POST["TerminalNo"];
	
		
		$mpiServiceUrl=	"https://sp-test.innova.com.tr/VAKIFBANK/MpiWeb/MPI_Enrollment.aspx";
		$krediKartiNumarasi = $_POST["Pan"];//Kredi kart numarası
		$sonKullanmaTarihi = $_POST["ExpiryDate"];//Kartın son kulanım değeri YYAA formatında olmalıdır.
		$kartCvv = $_POST["KartCvv"];//Kart cvv değeri
		$kartTipi = $_POST["BrandName"];//Kart Türü Visa 100 MasterCard 200
		$tutar = $_POST["PurchaseAmount"];//Çekilmesi istenen Tutar noktalı formatta olmalıdır
		$paraKodu = $_POST["Currency"];//Para kodu 949 TL 840 USD 978 EUR
		$taksitSayisi = $_POST["InstallmentCount"];//Taksit datasını taşıyan değişken
		$islemNumarasi = $_POST["VerifyEnrollmentRequestId"];//Her işlem başına unique olması gereken data
		$uyeIsyeriNumarasi = $_POST["MerchantId"];//Üye işyeri numarası
		$uyeIsYeriSifresi = $_POST["MerchantPassword"];//Üye işyeri şifresi
		$SuccessURL = $_POST["SuccessURL"];//3d secure adımı başarılı olursa dataların döneceği adres
		$FailureURL = $_POST["FailureURL"];//3d secure adımı başarısız olursa dataların döneceği adres
		$ekVeri = $_POST["SessionInfo"]; // Opsiyonel bir alandır kart ile hiçbir data bu değişken içinde kullanılmamalıdır.
		
		$ch = curl_init();
		curl_setopt($ch,CURLOPT_URL,$mpiServiceUrl);
		curl_setopt($ch,CURLOPT_POST,1);	
		curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,0);
		curl_setopt($ch,CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($ch,CURLOPT_HTTPHEADER,array("Content-Type"=>"application/x-www-form-urlencoded"));
		curl_setopt($ch,CURLOPT_RETURNTRANSFER,TRUE);
		curl_setopt ($ch, CURLOPT_CAINFO, "../cacert.pem");
		curl_setopt($ch,CURLOPT_POSTFIELDS,"Pan=$krediKartiNumarasi&ExpiryDate=$sonKullanmaTarihi&PurchaseAmount=$tutar&Currency=$paraKodu&BrandName=$kartTipi&VerifyEnrollmentRequestId=$islemNumarasi&MerchantId=$uyeIsyeriNumarasi&MerchantPassword=$uyeIsYeriSifresi&SuccessUrl=$SuccessURL&FailureUrl=$FailureURL&InstallmentCount=$taksitSayisi");
		//İhtiyaç olması halinde aşağıdaki gibi proxy açabilirsiniz.
		/*$proxy = "iproxy:8080";
		$proxy = explode(':', $proxy);
		curl_setopt($ch, CURLOPT_PROXY, $proxy[0]);
		curl_setopt($ch, CURLOPT_PROXYPORT, $proxy[1]);*/

		// İşlem isteği MPI'a gönderiliyor
		$resultXml = curl_exec($ch);	
		// Check for errors and display the error message
		if($errno = curl_errno($ch)) {
			//$error_message = curl_strerror($errno);
			echo "cURL error ({$errno}):\n";// {$error_message}";
		}
		curl_close($ch);		

		// Sonuç XML'i yorumlanıp döndürülüyor
		$result = SonucuOku($resultXml);
		
	if($result["Status"]=="Y")
	{
		// Kart 3D-Secure Programına Dahil		
		echo $result["Status"];
?>
<html>
	<head>
		<title>PayFlex 3D-Secure İşlem Sayfası</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	</head>
	<body>
	
		<form name="downloadForm" action="<?php echo $result['ACSUrl']?>" method="POST">
<!--		<noscript>-->
		<br>
		<br>
		<div id="image1" style="position:absolute; overflow:hidden; left:0px; top:0px; width:180px; height:180px; z-index:0"><img src="http://sanalpos.innova.com.tr/images/basarili.png" alt="" title="" border=0 width=180 height=180></div>
		<center>
		<h1>3-D Secure İşleminiz yapılıyor</h1>
		<h2>
		Tarayıcınızda Javascript kullanımı engellenmiştir.
		<br></h2>
		<h3>
			3D-Secure işleminizin doğrulama aşamasına geçebilmek için Gönder butonuna basmanız gerekmektedir
		</h3>
		<input type="submit" value="Gönder">
		</center>
<!--</noscript>-->
		<input type="hidden" name="PaReq" value="<?php echo $result['PaReq']?>">
		<input type="hidden" name="TermUrl" value="<?php echo $result['TermUrl']?>">
		<input type="hidden" name="MD" value="<?php echo $result['MerchantData']?>">
		</form>
	<SCRIPT LANGUAGE="Javascript" >
		//document.downloadForm.submit();
	</SCRIPT>
	</body>
</html>				
<?php				
		} else  {
			print("3D-Secure Verify Enrollment Sonucu :");print($result["Status"] + ": " + $result["MessageErrorCode"]);print("<br>");
			print("Post ettiginiz islem 3D Secure asamasinden gecemedi. Olasi sebepler;");;print("<br>");
			print("1-Siparis numarasi (VerifyEnrollmentRequestId) daha once kullanilmis olabilir.");;print("<br>");
			print("2-Kullanilan kartin 3D Secure tanimi olmayabilir.");;print("<br>");
			print("Bu durumlari kontrol edip yeniden islem deneyiniz.");;print("<br>");
		}
	} else {
	?>
<html>
	<head>
		<title>PayFlex 3D-Secure İşlem Sayfası</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
	</head>
	<body>
		<form action="" method="post">
			<input type="hidden" name="form" value="send">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="10" height="10" bgcolor="#FBFBFB" class="Basliklar">&nbsp;</td>
					<td width="1" bgcolor="#FBFBFB" class="AltCizgi">&nbsp;</td>
					<B><td bgcolor="#FBFBFB" class="AltCizgi">3D Entegrasyon Pos islem Uye is yeri bilgileri</td></B>
				</tr>
				<tr>
					<td width="100" height="25" class="Basliklar">Uye Isyeri No</td>
					<td width="1" class="AltCizgi">:</td>
					<td class="AltCizgi">
					<input class="input_yeni" type="text" name="MerchantId" size="49" value="000000000006528"></td>
				</tr>
				<tr>
					<td width="100" height="25" class="Basliklar">Isyeri Sifre</td>
					<td width="1" class="AltCizgi">:</td>
					<td class="AltCizgi">
					<input class="input_yeni" type="text" name="MerchantPassword" size="49" value="123456"></td>
				</tr>
				<tr>
					<td width="100" height="25" class="Basliklar">Terminal No</td>
					<td width="1" class="AltCizgi">:</td>
					<td class="AltCizgi">
					<input class="input_yeni" type="text" name="TerminalNo" size="49" value="VP000095"></td>
				</tr>
				<tr>
					<td width="100" height="25" class="Basliklar">SuccessURL</td>
					<td width="1" class="AltCizgi">:</td>
					<td class="AltCizgi"><input class="input_yeni" type="text" name="SuccessURL" size="50" value="http://localhost:8081/php_V4/3DSecure/ReturnUrl.php"></td>
				</tr>
				<tr>
					<td width="100" height="25" class="Basliklar">FailureURL</td>
					<td width="1" class="AltCizgi">:</td>
					<td class="AltCizgi"><input class="input_yeni" type="text" name="FailureURL" size="50" value="http://localhost:8081/php_V4/3DSecure/ReturnUrl.php"></td>
				</tr>
				<td width="10" height="10" bgcolor="#FBFBFB" class="Basliklar">&nbsp;</td>
					<td width="1" bgcolor="#FBFBFB" class="AltCizgi">&nbsp;</td>
				<B><td bgcolor="#FBFBFB" class="AltCizgi">Kart Bilgileri</td></B>
				<tr>
					<td width="100" height="25" class="Basliklar">Kart No</td>
					<td width="1" class="AltCizgi">:</td>
					<td class="AltCizgi">
					<input class="input_yeni" type="text" name="Pan" size="49" value="5421190137763354"></td>
				</tr>
				<tr>
					<td width="100" height="25" class="Basliklar">Son K.Tarihi</td>
					<td width="1" class="AltCizgi"></td>
					<td class="AltCizgi">
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td width="33">
							<input class="input_yeni" type="text" name="ExpiryDate" size="12" value="2409"></td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td width="100" height="25" class="Basliklar">Kart Cvv</td>
					<td width="1" class="AltCizgi">:</td>
					<td class="AltCizgi"><input class="input_yeni" type="text" name="KartCvv" size="12" value="411"></td>
				</tr>
				<tr>
					<td width="100" height="25" class="Basliklar">Tutar</td>
					<td width="1" class="AltCizgi">:</td>
					<td class="AltCizgi"><input class="input_yeni" type="text" name="PurchaseAmount" size="12" value="1.20"></td>
				</tr>
				<tr>
					<td width="100" height="25" class="Basliklar">Kart Tipi</td>
					<td width="1" class="AltCizgi">:</td>
					<td class="AltCizgi"><input class="input_yeni" type="text" name="BrandName" size="12" value="100"></td>
				</tr>
				<tr>
					<td width="100" height="25" class="Basliklar">Para Kodu</td>
					<td width="1" class="AltCizgi">:</td>
					<td class="AltCizgi">
					<input class="input_yeni" type="text" name="Currency" size="50" value="949"></td>
				</tr>
				<tr>
					<td width="100" height="25" class="Basliklar">Taksit</td>
					<td width="1" class="AltCizgi">:</td>
					<td class="AltCizgi"><input class="input_yeni" type="text" name="InstallmentCount" size="4" value=""></td>
				</tr>
				<tr>
					<td width="100" height="25" class="Basliklar">Siparis No</td>
					<td width="1" class="AltCizgi">:</td>
					<td class="AltCizgi"><input class="input_yeni" type="text" name="VerifyEnrollmentRequestId" size="50" value="SIP_ID1234567897100"></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td class="AltCizgi"><input type="submit" value="Gönder" name="B1"></td>
				</tr>
			</table>
		</form>
	</body>
	<?php } ?>
</html>