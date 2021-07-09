<%@page contentType="text/html;charset=ISO-8859-9"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
        <title>3D Hosting</title>
    </head>
    <body>
        <%
        //This the sample 3d secure page. Parameters should be updated before testing.
       
        String clientId = "XXXXXXXX";     	//Merchant Id defined by bank to user
        String amount = "9.95";            	//Transaction amount
        String oid = "";                   	//Order Id. Must be uniuqe. If left blank, system will generate a unique one.
        String okUrl = "XXXXXXXX";    		//URL which client be redirected if authentication is successful
        String failUrl = "XXXXXXXX"; 		//URL which client be redirected if authentication is not successful
        String rnd = new java.util.Date().toString();    //A random number, such as date/time
        
        
        String taksit = "";                 //Instalment count, if there is no instalment should left blank
        String islemtipi = "Auth";          //Transaction type
        String storekey="xxxxxx";           //Store key value, defined by bank.
        
        String hashstr = clientId + oid + amount + okUrl + failUrl + islemtipi + taksit + rnd + storekey;
        java.security.MessageDigest sha1 = java.security.MessageDigest.getInstance("SHA-1");
        
        String hash = (new sun.misc.BASE64Encoder()).encode(sha1.digest(hashstr.getBytes())); //Hash value used for validation
        
        
        %>
   
        <center>
            <form method="post" action="https://entegrasyon.asseco-see.com.tr/fim/est3Dgate">
			<!-- URL of the 3D secure server -->
                <input type="hidden" name="clientid" value="<%=clientId%>">
                <input type="hidden" name="amount" value="<%=amount%>">

                <input type="hidden" name="oid" value="<%=oid%>">	
                <input type="hidden" name="okUrl" value="<%=okUrl%>" >
                <input type="hidden" name="failUrl" value="<%=failUrl%>" >
                <input type="hidden" name="islemtipi" value="<%=islemtipi%>" >
                <input type="hidden" name="taksit" value="<%=taksit%>">
                <input type="hidden" name="rnd" value="<%=rnd%>" >
                <input type="hidden" name="hash" value="<%=hash%>" >
	
                <input type="hidden" name="storetype" value="3d_pay_hosting" >
	
                <input type="hidden" name="refreshtime" value="10" >
		
                <input type="hidden" name="lang" value="tr">
				<input type="hidden" name="currency" value="949">
                <input type="hidden" name="firmaadi" value="My Company">
	
                <input type="hidden" name="Fismi" value="is">
                <input type="hidden" name="faturaFirma" value="billingCompany">
                <input type="hidden" name="Fadres" value="XXX">
                <input type="hidden" name="Fadres2" value="XXX">
                <input type="hidden" name="Fil" value="XXX">

                <input type="hidden" name="Filce" value="XXX">
                <input type="hidden" name="Fpostakodu" value="postalcode93013">
                <input type="hidden" name="tel" value="XXX">
                <input type="hidden" name="fulkekod" value="tr">

                <input type="hidden" name="nakliyeFirma" value="na fi">
                <input type="hidden" name="tismi" value="XXX">
                <input type="hidden" name="tadres" value="XXX">
                <input type="hidden" name="tadres2" value="XXX">

                <input type="hidden" name="til" value="XXX">
                <input type="hidden" name="tilce" value="XXX">
                <input type="hidden" name="tpostakodu" value="ttt postalcode93013">
                <input type="hidden" name="tulkekod" value="usa">
	
                <input type="hidden" name="itemnumber1" value="a1">
                <input type="hidden" name="productcode1" value="a2">
                <input type="hidden" name="qty1" value="3">
                <input type="hidden" name="desc1" value="a4 desc">
                <input type="hidden" name="id1" value="a5">

                <input type="hidden" name="price1" value="6.25">
                <input type="hidden" name="total1" value="7.50">
                
                <input type="submit" value="Devam" />
                
            </form>
            
            <b>Hidden parameters used in the form</b>
            <br>
                
                &lt;input type="hidden" name="clientid" value=""&gt;<br>
                &lt;input type="hidden" name="amount" value=""&gt;<br>

                &lt;input type="hidden" name="oid" value="hla56bu"&gt;	<br>
                &lt;input type="hidden" name="okUrl" value="" &gt;<br>
                &lt;input type="hidden" name="failUrl" value="" &gt;<br>
                &lt;input type="hidden" name="islemtipi" value="" &gt;<br>
                &lt;input type="hidden" name="taksit" value=""&gt;<br>
                &lt;input type="hidden" name="rnd" value="" &gt;<br>
                &lt;input type="hidden" name="hash" value="" &gt;<br>
	
                &lt;input type="hidden" name="storetype" value="3d_pay_hosting" &gt;<br>
	
                &lt;input type="hidden" name="refreshtime" value="" &gt;<br>
		
                &lt;input type="hidden" name="lang" value=""&gt;<br>
                &lt;input type="hidden" name="firmaadi" value=""&gt;<br>
	
                &lt;input type="hidden" name="Fismi" value=""&gt;<br>
                &lt;input type="hidden" name="faturaFirma" value=""&gt;<br>
                &lt;input type="hidden" name="Fadres" value=""&gt;<br>
                &lt;input type="hidden" name="Fadres2" value=""&gt;<br>
                &lt;input type="hidden" name="Fil" value=""&gt;<br>

                &lt;input type="hidden" name="Filce" value=""&gt;<br>
                &lt;input type="hidden" name="Fpostakodu" value=""&gt;<br>
                &lt;input type="hidden" name="tel" value=""&gt;<br>
                &lt;input type="hidden" name="fulkekod" value=""&gt;<br>

                &lt;input type="hidden" name="nakliyeFirma" value=""&gt;<br>
                &lt;input type="hidden" name="tismi" value=""&gt;<br>
                &lt;input type="hidden" name="tadres" value=""&gt;<br>
                &lt;input type="hidden" name="tadres2" value=""&gt;<br>

                &lt;input type="hidden" name="til" value=""&gt;<br>
                &lt;input type="hidden" name="tilce" value=""&gt;<br>
                &lt;input type="hidden" name="tpostakodu" value=""&gt;<br>
                &lt;input type="hidden" name="tulkekod" value=""&gt;<br>
	
                &lt;input type="hidden" name="itemnumber1" value=""&gt;<br>
                &lt;input type="hidden" name="productcode1" value=""&gt;<br>
                &lt;input type="hidden" name="qty1" value=""&gt;<br>
                &lt;input type="hidden" name="desc1" value=""&gt;<br>
                &lt;input type="hidden" name="id1" value=""&gt;<br>

                &lt;input type="hidden" name="price1" value=""&gt;<br>
                &lt;input type="hidden" name="total1" value=""&gt;<br>
                
               
            
        </center>
    </body>
</html>
