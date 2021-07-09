<%@page contentType="text/html;charset=ISO-8859-9"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.est.jpay"%>
<%@page import="java.util.Enumeration"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
        <title>3D Model Payment Page</title>
    </head>
    <body>

    <h1>3D Model Payment Page</h1>    
    <h3>3D Parameters</h3>
    <table border="1">
        <tr>
            <td><b>Parameter Name:</b></td>
            <td><b>Parameter Value:</b></td>
        </tr>
    <%
    	Enumeration enu = request.getParameterNames();
    	while (enu.hasMoreElements()) {
    		String param = (String) enu.nextElement();
    		String val = (String) request.getParameter(param);
    		out.println("<tr><td>" + param + "</td>" + "<td>" + val + "</td></tr>");
    	}
    %>
    </table>
    <br>
    <br>
    <%
    	String hashparams = request.getParameter("HASHPARAMS");
    	String hashparamsval = request.getParameter("HASHPARAMSVAL");
    	String storekey = "12345BKT";
    	String paramsval = "";
    	int index1 = 0, index2 = 0;
		
    	//values which will be used in hash validation is being parsed
    	do {
    		index2 = hashparams.indexOf(":", index1);
    		String val = request.getParameter(hashparams.substring(index1,
    		index2)) == null ? "" : request.getParameter(hashparams
    		.substring(index1, index2));
    		paramsval += val;
    		index1 = index2 + 1;
    	} while (index1 < hashparams.length());

    	//out.println("hashparams="+hashparams+"<br/>");
    	//out.println("hashparamsval="+hashparamsval+"<br/>");
    	//out.println("paramsval="+paramsval+"<br/>");
    	String hashval = paramsval + storekey; //Store key is being added to hash value
    	String hashparam = request.getParameter("HASH");
    	java.security.MessageDigest sha1 = java.security.MessageDigest
    			.getInstance("SHA-1");

    	String hash = (new sun.misc.BASE64Encoder()).encode(sha1
    			.digest(hashval.getBytes()));
    	if (paramsval.equals(hashparamsval) && hash.equals(hashparam)) //hash generated in this page, hash returned and hash generated from parsed parameters should be same
    	{
    		out.println("<h4>Security warning. Digital signature is wrong.</h4>");
			
    		String name = "testapi"; 		//API user name
    		String password = "TEST1234"; 	//API password
    		String clientId = request.getParameter("clientid"); //Merchant Id
    		String mode = "P"; 				//P is constant
    		String islemtipi = "Auth"; 		//Transaction type
    		String expires = request.getParameter("Ecom_Payment_Card_ExpDate_Month") + "/" + request.getParameter("Ecom_Payment_Card_ExpDate_Year"); //Credit card expire date should be in mm/yy format
    		String cv2 = request.getParameter("cv2"); 		//CVV value
    		String amount = request.getParameter("amount"); //Transaction amount

    		String taksit = "4"; 			//Instalment count. If there is no instalment, empty string should be passed
    		String oid = request.getParameter("oid"); //Order Id. Must be uniuqe. If left blank, system will generate a unique one

    		String mdStatus = request.getParameter("mdStatus"); //Result of the 3D Secure authentication. 1,2,3,4 are successful; 5,6,7,8,9,0 are unsuccessful.
    		if (mdStatus != null
    		&& (mdStatus.equals("1") || mdStatus.equals("2")
    				|| mdStatus.equals("3") || mdStatus.equals("4"))) 
    		{
    %>
                <h5>3D Authentication is successful.</h5><br/>
            <%
               String paymentHost = "testsanalpos2.est.com.tr"; //payment gateway server name (like: testsanalpos.est.com.tr)
               String api = "servlet/cc5ApiServer"; 		//api server path (like: /servlet/cc5ApiServer)
               int port = 443;							//port info for the payment gateway
               jpay myjpay = new jpay();
               myjpay.setDebug(true);


               myjpay.setName(name);
               myjpay.setPassword(password);
               myjpay.setClientId(clientId);
               myjpay.setMode(mode);
               myjpay.setType(islemtipi);
               myjpay.setNumber(request.getParameter("md")); //Credit card number should not be send. Instead "md" value from 3D page should be passed.
               myjpay.setExpires(""); 						//Expire date and CVV values should not be send.
               myjpay.setCvv2Val(""); 
               myjpay.setTotal(amount);
               myjpay.setCurrency("949"); 					//949 for Turkish Lira

               // 3d için deme alanları
               myjpay.setPayerSecurityLevel(request.getParameter("eci")); //3D Secure special field: PayerSecurityLevel
               myjpay.setPayerTxnId(request.getParameter("xid")); 		  //3D Secure special field: PayerTxnId
               myjpay.setPayerAuthenticationCode(request.getParameter("cavv")); //3D Secure special field: PayerAuthenticationCode

               myjpay.setTaksit("4");		//Instalment count. If there is no instalment, empty string should be passed
               myjpay.setOrderId(oid);
               myjpay.setGroupId("");
               myjpay.setTransId("");
               myjpay.setIPAddress("");
               myjpay.setUserId("");
               myjpay.setComments("");
               myjpay.setBName("XXXXX");
               myjpay.setBStreet1("");
               myjpay.setBStreet2("");
               myjpay.setBStreet3("");
               myjpay.setBCity("");
               myjpay.setBPostalCode("");
               myjpay.setBStateProv("");
               myjpay.setSName("");
               myjpay.setSStreet1("");
               myjpay.setSStreet2("");
               myjpay.setSStreet3("");
               myjpay.setSCity("");
               myjpay.setSPostalCode("");
               myjpay.setSStateProv("");
               //myjpay.setExtra("","");

               int val = myjpay.processTransaction(paymentHost, port, api);
               if (val > 0) {
      %>
                
                <h3>Payment Result</h3>
                <table border="1">
                    <tr>
                        <td><b>Parameter Name:</b></td>
                        <td><b>Parameter Value:</b></td>
                    </tr>
                    
                    <tr>
                        <td>AuthCode</td>
                        <td><%=myjpay.getAuthCode()%></td>
                    </tr>
                    
                    <tr>
                        <td>Response</td>
                        <td><%=myjpay.getResponse()%></td>
                    </tr>
                    
                    <tr>
                        <td>HostRefNum</td>
                        <td><%=myjpay.getHostRefNum()%></td>
                    </tr>
                    
                    <tr>
                        <td>ProcReturnCode</td>
                        <td><%=myjpay.getProcReturnCode()%></td>
                    </tr>
                    
                    <tr>
                        <td>TransId</td>
                        <td><%=myjpay.getTransId()%></td>
                    </tr>
                    
                    <tr>
                        <td>ErrMsg</td>
                        <td><%=myjpay.getErrMsg()%></td>
                    </tr>
                    
                </table>
                
                
                <%
               		if ("Approved".equalsIgnoreCase(myjpay.getResponse())) {
               		out
               		.println("<b>Your payment is approved.</b>");
               	} else {
               		out
               		.println("<b>Your payment is not approved.</b> ");
               	}
               		} else {
               	out.println("<b>Connection Error</b>");
               		}

               	} else {
               		out.println("3D Authentication is unsuccessful.");
               	}
               } else {
               	out
               	.println("Hash value mismatch. Operation can not proceed.");
               }
             %>
    </body>
</html>







