<?php
// The parameters that will be written on virtual pos XML request

$name="TEST_NAME";       			//Virtual pos API user name
$password="TRps0030";    			//Virtual pos API user password
$clientid="80030";    			//Virtual pos merchant ID
$lip=GetHostByName($REMOTE_ADDR);  	//IP Address of the last user
$email="";  						//Email
$oid= $_POST['oid'];				//Order ID has to be different for every transaction,
                                    //If it would be sent as empty, it will be created by system.
$type="Auth";   					//Auth: Sales PreAuth Pre Authorization
 $ccno=$_POST['cardno'];             //Credit Card's Number
 $ccay=$_POST['expmonth'];           //Credit Card's Expire Month
$ccyil=$_POST['expyear'];           //Credit Card's Expire Year
$tutar=$_POST['total'];  			//As penny separator "." (dot) has to be used.
$cv2=$_POST['cv2'];                 //Credit Card's Security Code
 $taksit="";           //Installment amount. It has to be empty on sales, "0" is not acceptable.
                                    //Whenever authorization is not approved; If installment amount would be changed,
                                    //then order ID has to be changed as well.


// XML request template
$request= "DATA=<?xml version=\"1.0\" encoding=\"ISO-8859-9\"?>
<CC5Request>
<Name>{NAME}</Name>
<Password>{PASSWORD}</Password>
<ClientId>{CLIENTID}</ClientId>
<IPAddress>{IP}</IPAddress>
<Email>{EMAIL}</Email>
<Mode>P</Mode>
<OrderId>{OID}</OrderId>
<GroupId></GroupId>
<TransId></TransId>
<UserId></UserId>
<Type>{TYPE}</Type>
<Number>{CCNO}</Number>
<Expires>{CCTAR}</Expires>
<Cvv2Val>{CV2}</Cvv2Val>
<Total>{TUTAR}</Total>
<Currency>949</Currency>
<Taksit>{TAKSIT}</Taksit>
<BillTo>
<Name></Name>
<Street1></Street1>
<Street2></Street2>
<Street3></Street3>
<City></City>
<StateProv></StateProv>
<PostalCode></PostalCode>
<Country></Country>
<Company></Company>
<TelVoice></TelVoice>
</BillTo>
<ShipTo>
<Name></Name>
<Street1></Street1>
<Street2></Street2>
<Street3></Street3>
<City></City>
<StateProv></StateProv>
<PostalCode></PostalCode>
<Country></Country>
</ShipTo>
<Extra>
<MAILORDER>TRUE</MAILORDER>
</Extra>
</CC5Request>
";



//Writing parameters to the XML template

      $request=str_replace("{NAME}",$name,$request);
      $request=str_replace("{PASSWORD}",$password,$request);
      $request=str_replace("{CLIENTID}",$clientid,$request);
      $request=str_replace("{IP}",$lip,$request);
      $request=str_replace("{OID}",$oid,$request);
      $request=str_replace("{TYPE}",$type,$request);
      $request=str_replace("{CCNO}",$ccno,$request);
      $request=str_replace("{CCTAR}","$ccay/$ccyil",$request);
      $request=str_replace("{CV2}","$cv2",$request);
      $request=str_replace("{TUTAR}",$tutar,$request);
      $request=str_replace("{TAKSIT}",$taksit,$request);


		// Connection establishment to the virtual pos address
        // Test $url = "https://TEST_URL"
        // $url for production environment = "https://TEST_URL"

        $url = "TEST_URL";  //TEST

		$ch = curl_init();    // initialize curl handle
		
		curl_setopt($ch, CURLOPT_URL,$url); // set url to post to
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST,1);
		
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER,0);
		
		curl_setopt($ch, CURLOPT_RETURNTRANSFER,1); // return into a variable
		curl_setopt($ch, CURLOPT_TIMEOUT, 90); // times out after 90s
		curl_setopt($ch, CURLOPT_POSTFIELDS, $request); // add POST fields

		$result = curl_exec($ch); // run the whole process


       if (curl_errno($ch)) {
           print curl_error($ch);
       } else {
           curl_close($ch);
       }


 $Response ="";
 $OrderId ="";
 $AuthCode  ="";
 $ProcReturnCode    ="";
 $ErrMsg  ="";
 $HOSTMSG  ="";

$response_tag="Response";
$posf = strpos (  $result, ("<" . $response_tag . ">") );
$posl = strpos (  $result, ("</" . $response_tag . ">") ) ;
$posf = $posf+ strlen($response_tag) +2 ;
$Response = substr (  $result, $posf, $posl - $posf) ;

$response_tag="OrderId";
$posf = strpos (  $result, ("<" . $response_tag . ">") );
$posl = strpos (  $result, ("</" . $response_tag . ">") ) ;
$posf = $posf+ strlen($response_tag) +2 ;
$OrderId = substr (  $result, $posf , $posl - $posf   ) ;

$response_tag="AuthCode";
$posf = strpos (  $result, "<" . $response_tag . ">" );
$posl = strpos (  $result, "</" . $response_tag . ">" ) ;
$posf = $posf+ strlen($response_tag) +2 ;
$AuthCode = substr (  $result, $posf , $posl - $posf   ) ;

$response_tag="ProcReturnCode";
$posf = strpos (  $result, "<" . $response_tag . ">" );
$posl = strpos (  $result, "</" . $response_tag . ">" ) ;
$posf = $posf+ strlen($response_tag) +2 ;
$ProcReturnCode = substr (  $result, $posf , $posl - $posf   ) ;

$response_tag="ErrMsg";
$posf = strpos (  $result, "<" . $response_tag . ">" );
$posl = strpos (  $result, "</" . $response_tag . ">" ) ;
$posf = $posf+ strlen($response_tag) +2 ;
$ErrMsg = substr (  $result, $posf , $posl - $posf   ) ;


echo "Response:".$Response."<br>";
echo "ProcReturnCode:".$ProcReturnCode."<br>";
echo "ErrMsg:".$ErrMsg."<br>";




?>

<br>
</body>
</html>

