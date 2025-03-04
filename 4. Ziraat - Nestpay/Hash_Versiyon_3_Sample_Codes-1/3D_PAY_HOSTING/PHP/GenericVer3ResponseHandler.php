<html>
<head>
<title>HASH RESULT</title>
<meta http-equiv="Content-Language" content="tr">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="now">
</head>

<body>
	<table>
		<?php
			$postParams = array();
			foreach ($_POST as $key => $value){
				array_push($postParams, $key);				
				echo "<tr><td>" . $key ."</td><td>" . $value . "</td></tr>";
			}
			
			natcasesort($postParams);		
			
			$hashval = "";					
			foreach ($postParams as $param){				
				$paramValue = $_POST[$param];
				$escapedParamValue = str_replace("|", "\\|", str_replace("\\", "\\\\", $paramValue));	
					
				$lowerParam = strtolower($param);
				if($lowerParam != "hash" && $lowerParam != "encoding" )	{
					$hashval = $hashval . $escapedParamValue . "|";
				}
			}
			
			$storeKey = "TEST1234";
			$escapedStoreKey = str_replace("|", "\\|", str_replace("\\", "\\\\", $storeKey));	
			$hashval = $hashval . $escapedStoreKey;
			
			$calculatedHashValue = hash('sha512', $hashval);  
			$actualHash = base64_encode (pack('H*',$calculatedHashValue));
			
			$retrievedHash = $_POST["HASH"];
			if($retrievedHash == $actualHash )	{
				echo "<h4>HASH is successfull</h4>"  . " <br />\r\n";	
			}else {
				echo "<h4>Security Alert. The digital signature is not valid.</h4>"  . " <br />\r\n";
			}		
		?>
	</table>

</body>

</html>
