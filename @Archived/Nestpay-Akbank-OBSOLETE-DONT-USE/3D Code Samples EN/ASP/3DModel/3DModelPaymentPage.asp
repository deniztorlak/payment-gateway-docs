<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>3D Model Payment Page</title>
    <style type="text/css">
        body
        {
            border-style: none;
            color: #6B7983;
            font-family: Tahoma,Arial,Verdana,Sans-Serif;
            font-size: 12px;
            font-weight: normal;
        }
        
        tableClass
        {
            margin: 0;
        }
        td
        {
            color: #6B7983;
            font-family: Tahoma,Arial,Verdana,Sans-Serif;
            font-size: 12px;
            font-weight: normal;
            vertical-align: top;
            background: none repeat scroll 0 0 #FFFFFF;
            border-color: #C3CBD1;
            border-style: solid;
            border-width: 0 1px 1px 0;
            padding: 8px 20px;
        }
        .trHeader td
        {
            color: #FFA92D;
            font-weight: bold;
        }
        span
        {
            margin: 0px 0px 6px 0px;
            font-size: 14px;
            font-weight: bold;
        }
        h3
        {
            margin: 0px 0px 6px 0px;
            font-size: 14px;
            font-weight: bold;
            color: #518ccc;
        }
        h1
        {
            font-family: Calibri, Tahoma, Arial, Verdana, Sans-Serif;
            font-size: 24px;
            font-weight: normal;
            color: #51596a;
        }
    </style>
</head>
<body>
    <!-- #include file = "hex_sha1_js.asp" -->
    <h1>
        3D Model Payment Page</h1>
    <table class="tableClass">
        <tr>
            <td>
                <h3>
                    3D Authentication Result:&nbsp;</h3>
            </td>
            <td>
                <span>
                    <%
                      'Checking hash
                    Dim name,password,clientid,lip,email,oid,optype,amountVal,cv2,instalment,mdStatus,xid,eci,cavv,md,req,ox,mode,obj,hashparams,hashparamsval,hash,index1,index2,storekey,hashparam,val,hashval,paramsval
                    
                    storekey = "123456"
                    index1 = 1
                    index2 = 1
                    hashparams = request.form("HASHPARAMS")
                    hashparamsval = request.form("HASHPARAMSVAL") 
                    hashparam = request.form("HASH")	
                    
                    paramsval = ""
	
	                while index1 < Len(hashparams)
		
	                index2 = InStr(index1,hashparams,":")
		
	                xvalx = Mid(hashparams,index1,index2 - index1)
		
	                val = request.form(xvalx)
		
	                if val = null then
	                val = ""
	                end if
	                paramsval = paramsval & val
	                index1 = index2 + 1	
	                Wend
	
	                hashval = paramsval & storekey                  'store key is added to the hash parameters
	                hash = b64_sha1(hashval)
	
	                if (hash <> hashparam or paramsval <> hashparamsval) then
                    
		                response.write("<font color=""red"">Security warning. Hash values mismatch. </font>") 
                    
	                else
                    
	                    name="testapi"       				   		'API user name
	                    password="TEST1234"    				        'API password
	                    clientid=request.form("clientid")  	        'Merchant Id
	                    lip= Request.Servervariables("REMOTE_HOST") 'Client's IP address
	                    oid= ""		                                'Order Id. Must be unique. If left blank, system will generate a unique one.                                    		
	                    optype="Auth"   							'Transaction type
	                    amountVal=request.form("amount")  				'"." should be used for currency decimal seperator
	                    instalment="0"           					'Instalment count. If there's no instalment, empty string should be passed
	                    mdStatus=request.form("mdStatus")       	'Result of the 3D Secure authentication. 1,2,3,4 are successful; 5,6,7,8,9,0 are unsuccessful.
												                    'If mdStatus is unsuccessful, please don't post values to API
	                    xid=request.form("xid")                 	'3D Secure special field: PayerTxnId
	                    eci=request.form("eci")                 	'3D Secure special field: PayerSecurityLevel
	                    cavv=request.form("cavv")               	'3D Secure special field: PayerAuthenticationCode
	                    md=request.form("md")                   	'Credit card number should not be send. Instead "md" value from 3D page should be passed.
												                    'Expire date and CVV values should not be send.

	                    mode = "P"                                  'P is constant
	                    currencyType = "949"						'Currency code, 949 for TL, ISO_4217 standard

	                    if(mdStatus = 1 or mdStatus = 2 or mdStatus = 3 or mdStatus = 4) Then
                        
	                    Response.write("<font color=""green"">3D Authentication is successful. </font>")
	                    
                        else
                        
                        Response.write("<font color=""red"">3D authentication unsuccesful. </font>")
                        end if
                    end if
                    %>
                </span>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <h3>
                    3D Parameters:</h3>
            </td>
        </tr>
        <tr class="trHeader">
            <td>
                <b>Parameter Name:</b>
            </td>
            <td>
                <b>Parameter Value:</b>
            </td>
        </tr>
        <%

		for each obj in request.form
			response.write("<tr><td>" & obj &"</td><td>" & request.form(obj) & "</td></tr>")
		next

        %>
    </table>
        <br />
        <br />
     
    <%
    
        Response.Write("<h3>Payment Result</h3><br /><br /><table class=""tableClass""><tr><td><h3> Payment Result:&nbsp;</h3></td><td><span>")
    
        if(mdStatus = 1 or mdStatus = 2 or mdStatus = 3 or mdStatus = 4) Then
        
            'XML Request template
            req="<?xml version=""1.0"" encoding=""ISO-8859-9""?><CC5Request><Name>{NAME}</Name><Password>{PASSWORD}</Password><ClientId>{CLIENTID}</ClientId><IPAddress>{IP}</IPAddress><Email>{EMAIL}</Email><Mode>P</Mode><OrderId>{OID}</OrderId><GroupId></GroupId><TransId></TransId><UserId></UserId><Type>{TYPE}</Type><Number>{MD}</Number><Expires></Expires><Cvv2Val></Cvv2Val><Total>{TUTAR}</Total><Currency>{CURRENCY}</Currency><Taksit>{TAKSIT}</Taksit><PayerTxnId>{XID}</PayerTxnId><PayerSecurityLevel>{ECI}</PayerSecurityLevel><PayerAuthenticationCode>{CAVV}</PayerAuthenticationCode><BillTo><Name></Name><Street1></Street1><Street2></Street2><Street3></Street3><City></City><StateProv></StateProv><PostalCode></PostalCode><Country></Country><Company></Company><TelVoice></TelVoice></BillTo><ShipTo><Name></Name><Street1></Street1><Street2></Street2><Street3></Street3><City></City><StateProv></StateProv><PostalCode></PostalCode><Country></Country></ShipTo><Extra></Extra></CC5Request>"
    
            'Replacing values in the XML template
    
                req=Replace(req,"{NAME}",name)      
                req=Replace(req,"{PASSWORD}",password)
                req=Replace(req,"{CLIENTID}",clientid)
                req=Replace(req,"{IP}",ip)
                req=Replace(req,"{OID}",oid)
                req=Replace(req,"{TYPE}",optype)
                req=Replace(req,"{XID}",xid)
                req=Replace(req,"{ECI}",eci)
                req=Replace(req,"{CAVV}",cavv)
                req=Replace(req,"{MD}",md)
                req=Replace(req,"{TUTAR}",amountVal)
                req=Replace(req,"{TAKSIT}",instalment)   
                req=Replace(req,"{CURRENCY}",currencyType)
            
            post(req)               'XML is being posted, payment operation commits 
       
        else
           Response.Write("<font color=""red"">3D Authentication is not successful. Payment request not sent. </font>")        
        end if
       
    %>
    <script language="javascript" runat="server">

        function post(x) {
            var xmlhttp = new ActiveXObject("MSXML2.ServerXMLHTTP");
            xmlhttp.open("POST", "https://entegrasyon.asseco-see.com.tr/fim/api", 0); //API server path
            xmlhttp.send("DATA=" + x);

            var response = getReply("Response", xmlhttp.responseText);
            var authcode = getReply("AuthCode", xmlhttp.responseText);
            var hostrefnum = getReply("HostRefNum", xmlhttp.responseText);
            var procreturncode = getReply("ProcReturnCode", xmlhttp.responseText);
            var transid = getReply("TransId", xmlhttp.responseText);
            var errmsg = getReply("ErrMsg", xmlhttp.responseText);

           
            if (mdStatus == 1 || mdStatus == 2 || mdStatus == 3 || mdStatus == 4) 
           { 
                if (response == "Approved") 
                {
                    Response.Write("<font color=\"green\">Your payment is approved.</font>");
                }
                else 
                {
                    Response.Write("<font color=\"red\">Your payment is not approved.</font>");
                }

                Response.Write("</span>" +
                 "<tr>" +
                 "<td><b>Parameter Name:</b></td>" +
                 "<td><b>Parameter Value:</b></td>" +
                 "</tr>" +
                 "<tr>" +
                 "<td>AuthCode</td>" +
                 "<td>" + authcode + "</td>" +
                 "</tr>" +
                 "<tr>" +
                 "<td>Response</td>" +
                 "<td>" + response + "</td>" +
                 "</tr>" +
                 "<tr>" +
                 "<td>HostRefNum</td>" +
                 "<td>" + hostrefnum + "</td>" +
                 "</tr>" +
                 "<tr>" +
                 "<td>ProcReturnCode</td>" +
                 "<td>" + procreturncode + "</td>" +
                 "</tr>" +
                 "<tr>" +
                 "<td>TransId</td>" +
                 "<td>" + transid + "</td>" +
                 "</tr>" +
                 "<tr>" +
                 "<td>ErrMsg</td>" +
                 "<td>" + errmsg + "</td>" +
                 "</tr>" +
                 "</table>");
            }
        }
        function getReply(value, coming) {
            var xf = "<" + value + ">";
            var xs = "</" + value + ">";
            var index1 = coming.indexOf(xf);
            var index2 = coming.indexOf(xs);
            return coming.substring(index1 + value.length + 2, index2);

        }
	
    </script>
</body>
</html>
