<%@page contentType="text/html;charset=ISO-8859-9"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
        <title>3D Model</title>
    </head>
    <body>
    <%
        
        //This the sample 3d secure page. Parameters should be updated before testing.
                
        String clientId = "XXXXXXXX";     	//Merchant Id defined by bank to user
        String amount = "9.95";       		//Transaction amount
        String oid = "";       				//Order Id. Must be uniuqe. If left blank, system will generate a unique one.
        String okUrl = "XXXXXXXXX";   		//URL which client be redirected if authentication is successful
        String failUrl = "XXXXXXXXX"; 		//URL which client be redirected if authentication is not successful
        String rnd = new java.util.Date().toString(); //A random number, such as date/time
        
        String storekey="xxxxxx";       	//Store key value, defined by bank.
                
        String storetype="3d";          
                
        String hashstr = clientId + oid + amount + okUrl + failUrl + rnd + storekey;
        java.security.MessageDigest sha1 = java.security.MessageDigest.getInstance("SHA-1");
        
        String hash = (new sun.misc.BASE64Encoder()).encode(sha1.digest(hashstr.getBytes())); //Hash value used for validation
                
        String description = ""; 			//Description
        String xid = "";    				//Order tracking number, if left blank system will generate it
        String lang="";     				//Display language, "en" for English, "tr" for Turkish
        String email="";    				//Customer email address
        String userid="";   				//Id for tracking users
             
    %>
        <center>
            <form method="post" action="https://entegrasyon.asseco-see.com.tr/fim/est3Dgate">
			  <!-- URL of the 3D secure server -->
                <table>
                   <tr>
                <td>
                    Credit Card Number:
                </td>
                <td>
                    <input type="text" name="pan" size="20" />
            </tr>
            <tr>
                <td>
                    CVV Value:
                </td>
                <td>
                    <input type="text" name="cv2" size="4" value="" />
                </td>
            </tr>
            <tr>
                <td>
                    Expire Year:
                </td>
                <td>
                    <input type="text" name="Ecom_Payment_Card_ExpDate_Year" value="" />
                </td>
            </tr>
            <tr>
                <td>
                    Expire Month:
                </td>
                <td>
                    <input type="text" name="Ecom_Payment_Card_ExpDate_Month" value="" />
                </td>
            </tr>
            <tr>
                <td>
                    Card Type:
                </td>
                <td>
                    <select name="cardType">
                        <option value="1">Visa</option>
                        <option value="2">MasterCard</option>
                    </select>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <input type="submit" value="Submit" />
                </td>
            </tr>
                </table>
                <input type="hidden" name="clientid" value="<%=clientId%>">
                <input type="hidden" name="amount" value="<%=amount%>">
                <input type="hidden" name="oid" value="<%=oid%>">	
                <input type="hidden" name="okUrl" value="<%=okUrl%>">
                <input type="hidden" name="failUrl" value="<%=failUrl%>">
                <input type="hidden" name="rnd" value="<%=rnd%>" >
                <input type="hidden" name="hash" value="<%=hash%>" >
                
                <input type="hidden" name="storetype" value="3d" >		
                <input type="hidden" name="lang" value="tr">
				<input type="hidden" name="currency" value="949">
                
                
            </form>
            <br>
            <b>Hidden parameters used in the form</b>
            <br>
            
            &lt;input type="hidden" name="clientid" value=""&gt;<br>
                &lt;input type="hidden" name="amount" value=""&gt;<br>
                &lt;input type="hidden" name="oid" value=""&gt;	<br>
                &lt;input type="hidden" name="okUrl" value=""&gt;<br>
                &lt;input type="hidden" name="failUrl" value=""&gt;<br>
                &lt;input type="hidden" name="rnd" value="" &gt;<br>
                &lt;input type="hidden" name="hash" value="" &gt;<br>
                
                &lt;input type="hidden" name="storetype" value="" &gt;	<br>	
                &lt;input type="hidden" name="lang" value=""&gt;<br>
        </center>
    </body>
</html>
