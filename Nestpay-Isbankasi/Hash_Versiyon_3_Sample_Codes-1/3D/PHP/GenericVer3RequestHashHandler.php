<html>
<head>
<title>Generic Hash Request Handler</title>
<meta http-equiv="Content-Language" content="tr">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="now">
</head>

<body onload="javascript:moveWindow()">

	<form name="pay_form" method="post" action="https://<host_address>/<3dgate_path>">
		<?php
			$postParams = array();
			foreach ($_POST as $key => $value){
				array_push($postParams, $key);
				echo "<input type=\"hidden\" name=\"" .$key ."\" value=\"" .$value."\" /><br />";
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
			$hash = base64_encode (pack('H*',$calculatedHashValue));
			
			echo "<input type=\"hidden\" name=\"HASH\" value=\"" .$hash."\" /><br />";			
		
		?>
	</form>
	
	  <script type="text/javascript" language="javascript">
        function moveWindow() {
           document.pay_form.submit();
        }
    </script>

</body>

</html>
