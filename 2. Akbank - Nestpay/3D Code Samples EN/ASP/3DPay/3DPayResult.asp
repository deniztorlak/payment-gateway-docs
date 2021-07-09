<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>3D Pay Result Page</title>
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
        3D Pay Result Page</h1>
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
                    Dim name,password,clientid,lip,email,oid,optype,amountVal,cv2,instalment,mdStatus,xid,eci,cavv,md,req,ox,mode,obj,hashparams,hashparamsval,hash,index1,index2,storekey,hashparam,val,hashval,paramsval, responseVal
                    
                    storekey = "400DX9820"
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
	                paramsval = paramsval + val
	                index1 = index2 + 1	
	                Wend
	
	                hashval = paramsval & storekey                  'store key is added to the hash parameters
	                hash = b64_sha1(hashval)
	
	                if (hash <> hashparam or paramsval <> hashparamsval) then
                    
		                response.write("<font color=""red"">Security warning. Hash values mismatch. </font>") 
                    
	                else
                    
	                    mdStatus=request.form("mdStatus")       	'Result of the 3D Secure authentication. 1,2,3,4 are successful; 5,6,7,8,9,0 are unsuccessful.
						

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

            responseVal = request.form("Response")
            authcode = request.form("AuthCode")
            hostrefnum = request.form("HostRefNum")
            procreturncode = request.form("ProcReturnCode")
            transid = request.form("TransId")
            errmsg = request.form("ErrMsg")

           
            if (mdStatus = 1 or mdStatus = 2 or mdStatus = 3 or mdStatus = 4)  then
            
                if (responseVal = "Approved") then                
                    response.write("<font color=""green"">Your payment is approved.</font>")                
                else 
                
                   response.write("<font color=""red"">Your payment is not approved.</font>")
                end if

                response.write("</span><tr><td><b>Parameter Name:</b></td><td><b>Parameter Value:</b></td>")
                 response.write("</tr><tr><td>AuthCode</td><td>" & authcode & "</td></tr>")
                 response.write("</tr><tr><td>Response</td><td>" & authresponseValcode & "</td></tr>")
                 response.write("</tr><tr><td>HostRefNum</td><td>" & hostrefnum & "</td></tr>")
                 response.write("</tr><tr><td>ProcReturnCode</td><td>" & procreturncode & "</td></tr>")
                 response.write("</tr><tr><td>TransId</td><td>" & transid & "</td></tr>")
                 response.write("</tr><tr><td>ErrMsg</td><td>" & errmsg & "</td></tr>")
                 response.write("</table>")
            else
             response.write("<font color=""red"">3D Authentication is not successful. Payment request not sent. </font>")
            
            end if	
       %>
</body>
</html>
