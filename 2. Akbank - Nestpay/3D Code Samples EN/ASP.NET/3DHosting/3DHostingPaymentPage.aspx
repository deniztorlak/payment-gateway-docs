<%@ page language="C#" autoeventwireup="true" inherits="odemesayfasi3dmodel, App_Web_fr4klrwv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>3D Model</title>
</head>
<body>
<h1>3D Payment Page</h1>
    
    
    <h3>3D Return Parameters and Values</h3>
    <table border="1">
        <tr>
            <td><b>Parameter Name : </b></td>
            <td><b>Parameter Value : </b></td>
        </tr>
<%
            IEnumerator e = Request.Form.GetEnumerator();
            while (e.MoveNext())
            {
                String xkey = (String)e.Current;
                String xval = Request.Form.Get(xkey);
                Response.Write("<tr><td>" +xkey +"</td><td>"+ xval+"</td></tr>");
            }
%>               
        </table>
<%
        
        String hashparams = Request.Form.Get("HASHPARAMS");
        String hashparamsval = Request.Form.Get("HASHPARAMSVAL");
        String storekey = "12345BKT";
        String paramsval = "";
        int index1 = 0, index2 = 0;
        
        do
        {
            index2 = hashparams.IndexOf(":", index1);
            String val = Request.Form.Get(hashparams.Substring(index1, index2-index1)) == null ? "" : Request.Form.Get(hashparams.Substring(index1, index2-index1));
            paramsval += val;
            index1 = index2 + 1;
        }
        while (index1 < hashparams.Length);

        String hashval = paramsval + storekey;
        String hashparam = Request.Form.Get("HASH");
        
        System.Security.Cryptography.SHA1 sha = new System.Security.Cryptography.SHA1CryptoServiceProvider();
        byte[] hashbytes = System.Text.Encoding.GetEncoding("ISO-8859-9").GetBytes(hashval);
        byte[] inputbytes = sha.ComputeHash(hashbytes);

        String hash = Convert.ToBase64String(inputbytes);	// Hash value
        
        if(!paramsval.Equals(hashparamsval)|| !hash.Equals(hashparam)) // Hash control section..
        {
                Response.Write("<h4>Security Warning. Digital Signature is NOT Valid !</h4>");
        }
        
		/*	
			Variables below for payment phase. In this model payment is done by merchant's developer.  So, these values must be change according to merchant's setting and needs.
		*/        		
        String nameval = "testapi";		// Merchant's API username
        String passwordval = "TEST1234";	// Merchant's API password
        String clientidval = Request.Form.Get("clientid");	// Merchant ID
        String modeval = "P";	// Default P
        String typeval = "Auth"; // Transaction type
		/*
			There are seven type of transactions : Auth, Void, Credit, PreAuth, PostAuth, OrderStatus, OrderHistory
			A unique transastion id returns after each transaction, it is used for reference purposes for some sort of transactions, explained below.
			Auth : Sale
			Void : Canceling sale, it must be done in same day that sale was done.  Sale's order id must be provided.
			Credit : Canceling sale and refunding provisioned amount  during sale process.  It can be done after settlement. Transaction id must be provided.
			PreAuth : Pre Authorization, it starts a sale request but it doesn't end process.
			PostAuth : Post Authorization, it ends sale process started before by Pre Authorization, transaction id must be provided.
			OrderStatus : Reporting request for order's status.
			OrderHistory : Reporting request for order's history.	
		*/
		
		String orderidval 	= "";							// Order id. If you do not set it system returns an order id, if you set it system uses it.
		
        String expiresval	= Request.Form.Get("Ecom_Payment_Card_ExpDate_Month") + "/" + Request.Form.Get("Ecom_Payment_Card_ExpDate_Year"); // Expire date, it must be  in mm/yy format
        String cv2val		= Request.Form.Get("cv2");		// CVV2 Number
        String totalval		= Request.Form.Get("amount");	// Total Amount
        String numberval	= Request.Form.Get("md");		// If 3D authentication is successful then md value is sent to payment process. It does not need to send card number, expire date and CVV2 number
        String taksitval	= "";							// Installment (  how many installments will be for this sale ) for sales without any installment it must ve EMPTY, NOT zero, NOT "0", NOT space
        String currencyval	= "946";						// TL : 949, RON : 946


        String mdstatus = Request.Form.Get("mdStatus");	// if mdStatus 1,2,3,4 then 3D authentication is successful, if mdStatus 5,6,7,8,9,0 then 3D authentication is FAILED
                
        if (mdstatus.Equals("1") || mdstatus.Equals("2") || mdstatus.Equals("3") || mdstatus.Equals("4")) // If 3D authentication is successful do payment things..
        {
            Response.Write("<h5>3D Auth is Successful.</h5><br/>");
            String cardholderpresentcodeval = "13";
            String payersecuritylevelval = Request.Form.Get("eci"); 		// PayerSecurityLevel
            String payertxnidval = Request.Form.Get("xid"); 				// PayerTxnId
            String payerauthenticationcodeval = Request.Form.Get("cavv"); 	// PayerAuthenticationCode
								
            String ipaddressval = "";	// Shopper's client IP adress
            String emailval = "";
            String groupidval = "";
            String transidval = "";		// Transaction ID
            String useridval = "";

            // Billing Information
            String billnameval = "";      // Billing name
            String billstreet1val = "";   // Address Line 1
            String billstreet2val = "";   //  Address Line 2
            String billstreet3val = "";   //  Address Line 3
            String billcityval = "";      // City
            String billstateprovval = ""; // State
            String billpostalcodeval = "";// Postal code

            // Shipping Information
            String shipnameval = "";      // Shipping Name
            String shipstreet1val = "";   //Address Line 1
            String shipstreet2val = "";   //Address Line 2
            String shipstreet3val = "";   //Address Line 3
            String shipcityval = "";      // City
            String shipstateprovval = ""; // State
            String shippostalcodeval = "";// Postal code

            String extraval = "";

            // XML request template preparing section

            System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
            System.Xml.XmlDeclaration dec = doc.CreateXmlDeclaration("1.0", "ISO-8859-9", "yes");
            doc.AppendChild(dec);
            System.Xml.XmlElement cc5Request = doc.CreateElement("CC5Request");
            doc.AppendChild(cc5Request);

            System.Xml.XmlElement name = doc.CreateElement("Name");
            name.AppendChild(doc.CreateTextNode(nameval));
            cc5Request.AppendChild(name);

            System.Xml.XmlElement password = doc.CreateElement("Password");
            password.AppendChild(doc.CreateTextNode(passwordval));
            cc5Request.AppendChild(password);

            System.Xml.XmlElement clientid = doc.CreateElement("ClientId");
            clientid.AppendChild(doc.CreateTextNode(clientidval));
            cc5Request.AppendChild(clientid);

            System.Xml.XmlElement ipaddress = doc.CreateElement("IPAddress");
            ipaddress.AppendChild(doc.CreateTextNode(ipaddressval));
            cc5Request.AppendChild(ipaddress);

            System.Xml.XmlElement email = doc.CreateElement("Email");
            email.AppendChild(doc.CreateTextNode(emailval));
            cc5Request.AppendChild(email);

            System.Xml.XmlElement mode = doc.CreateElement("Mode");
            mode.AppendChild(doc.CreateTextNode(modeval));
            cc5Request.AppendChild(mode);

            System.Xml.XmlElement orderid = doc.CreateElement("OrderId");
            orderid.AppendChild(doc.CreateTextNode(orderidval));
            cc5Request.AppendChild(orderid);

            System.Xml.XmlElement groupid = doc.CreateElement("GroupId");
            groupid.AppendChild(doc.CreateTextNode(groupidval));
            cc5Request.AppendChild(groupid);

            System.Xml.XmlElement transid = doc.CreateElement("TransId");
            transid.AppendChild(doc.CreateTextNode(transidval));
            cc5Request.AppendChild(transid);

            System.Xml.XmlElement userid = doc.CreateElement("UserId");
            userid.AppendChild(doc.CreateTextNode(useridval));
            cc5Request.AppendChild(userid);

            System.Xml.XmlElement type = doc.CreateElement("Type");
            type.AppendChild(doc.CreateTextNode(typeval));
            cc5Request.AppendChild(type);

            System.Xml.XmlElement number = doc.CreateElement("Number");
            number.AppendChild(doc.CreateTextNode(numberval));
            cc5Request.AppendChild(number);

            System.Xml.XmlElement expires = doc.CreateElement("Expires");
            expires.AppendChild(doc.CreateTextNode(expiresval));
            cc5Request.AppendChild(expires);

            System.Xml.XmlElement cvv2val = doc.CreateElement("Cvv2Val");
            cvv2val.AppendChild(doc.CreateTextNode(cv2val));
            cc5Request.AppendChild(cvv2val);

            System.Xml.XmlElement total = doc.CreateElement("Total");
            total.AppendChild(doc.CreateTextNode(totalval));
            cc5Request.AppendChild(total);

            System.Xml.XmlElement currency = doc.CreateElement("Currency");
            currency.AppendChild(doc.CreateTextNode(currencyval));
            cc5Request.AppendChild(currency);

            System.Xml.XmlElement taksit = doc.CreateElement("Taksit");
            taksit.AppendChild(doc.CreateTextNode(taksitval));
            cc5Request.AppendChild(taksit);

            System.Xml.XmlElement payertxnid = doc.CreateElement("PayerTxnId");
            payertxnid.AppendChild(doc.CreateTextNode(payertxnidval));
            cc5Request.AppendChild(payertxnid);

            System.Xml.XmlElement payersecuritylevel = doc.CreateElement("PayerSecurityLevel");
            payersecuritylevel.AppendChild(doc.CreateTextNode(payersecuritylevelval));
            cc5Request.AppendChild(payersecuritylevel);

            System.Xml.XmlElement payerauthenticationcode = doc.CreateElement("PayerAuthenticationCode");
            payerauthenticationcode.AppendChild(doc.CreateTextNode(payerauthenticationcodeval));
            cc5Request.AppendChild(payerauthenticationcode);

            System.Xml.XmlElement cardholderpresentcode = doc.CreateElement("CardholderPresentCode");
            cardholderpresentcode.AppendChild(doc.CreateTextNode(cardholderpresentcodeval));
            cc5Request.AppendChild(cardholderpresentcode);

            System.Xml.XmlElement billto = doc.CreateElement("BillTo");
            cc5Request.AppendChild(billto);

            System.Xml.XmlElement billname = doc.CreateElement("Name");
            billname.AppendChild(doc.CreateTextNode(billnameval));
            billto.AppendChild(billname);

            System.Xml.XmlElement billstreet1 = doc.CreateElement("Street1");
            billstreet1.AppendChild(doc.CreateTextNode(billstreet1val));
            billto.AppendChild(billstreet1);

            System.Xml.XmlElement billstreet2 = doc.CreateElement("Street2");
            billstreet2.AppendChild(doc.CreateTextNode(billstreet2val));
            billto.AppendChild(billstreet2);

            System.Xml.XmlElement billstreet3 = doc.CreateElement("Street3");
            billstreet3.AppendChild(doc.CreateTextNode(billstreet3val));
            billto.AppendChild(billstreet3);

            System.Xml.XmlElement billcity = doc.CreateElement("City");
            billcity.AppendChild(doc.CreateTextNode(billcityval));
            billto.AppendChild(billcity);

            System.Xml.XmlElement billstateprov = doc.CreateElement("StateProv");
            billstateprov.AppendChild(doc.CreateTextNode(billstateprovval));
            billto.AppendChild(billstateprov);

            System.Xml.XmlElement billpostalcode = doc.CreateElement("PostalCode");
            billpostalcode.AppendChild(doc.CreateTextNode(billpostalcodeval));
            billto.AppendChild(billpostalcode);

            System.Xml.XmlElement shipto = doc.CreateElement("ShipTo");
            cc5Request.AppendChild(shipto);

            System.Xml.XmlElement shipname = doc.CreateElement("Name");
            shipname.AppendChild(doc.CreateTextNode(shipnameval));
            shipto.AppendChild(shipname);

            System.Xml.XmlElement shipstreet1 = doc.CreateElement("Street1");
            shipstreet1.AppendChild(doc.CreateTextNode(shipstreet1val));
            shipto.AppendChild(shipstreet1);

            System.Xml.XmlElement shipstreet2 = doc.CreateElement("Street2");
            shipstreet2.AppendChild(doc.CreateTextNode(shipstreet2val));
            shipto.AppendChild(shipstreet2);

            System.Xml.XmlElement shipstreet3 = doc.CreateElement("Street3");
            shipstreet3.AppendChild(doc.CreateTextNode(shipstreet3val));
            shipto.AppendChild(shipstreet3);

            System.Xml.XmlElement shipcity = doc.CreateElement("City");
            shipcity.AppendChild(doc.CreateTextNode(shipcityval));
            shipto.AppendChild(shipcity);

            System.Xml.XmlElement shipstateprov = doc.CreateElement("StateProv");
            shipstateprov.AppendChild(doc.CreateTextNode(shipstateprovval));
            shipto.AppendChild(shipstateprov);

            System.Xml.XmlElement shippostalcode = doc.CreateElement("PostalCode");
            shippostalcode.AppendChild(doc.CreateTextNode(shippostalcodeval));
            shipto.AppendChild(shippostalcode);


            System.Xml.XmlElement extra = doc.CreateElement("Extra");
            extra.AppendChild(doc.CreateTextNode(extraval));
            cc5Request.AppendChild(extra);

            String xmlval = doc.OuterXml;     // XML request string..

            // Payment connection and posting..
            String url = "https://entegrasyon.asseco-see.com.tr/fim/api";
            System.Net.HttpWebResponse resp = null;
            try
            {
                System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(url);
                   
                string postdata = "DATA=" + xmlval.ToString();
                byte[] postdatabytes = System.Text.Encoding.GetEncoding("ISO-8859-9").GetBytes(postdata);
                request.Method = "POST";
                request.ContentType = "application/x-www-form-urlencoded";
                request.ContentLength = postdatabytes.Length;
                System.IO.Stream requeststream = request.GetRequestStream();
                requeststream.Write(postdatabytes, 0, postdatabytes.Length);
                requeststream.Close();

                resp = (System.Net.HttpWebResponse)request.GetResponse();
                System.IO.StreamReader responsereader = new System.IO.StreamReader(resp.GetResponseStream(), System.Text.Encoding.GetEncoding("ISO-8859-9"));

                String gelenXml = responsereader.ReadToEnd();	// Taking XML response as string

                System.Xml.XmlDocument gelen = new System.Xml.XmlDocument();
                gelen.LoadXml(gelenXml);    

                System.Xml.XmlNodeList list = gelen.GetElementsByTagName("Response");
                String xmlResponse = list[0].InnerText;
                list = gelen.GetElementsByTagName("AuthCode");
                String xmlAuthCode = list[0].InnerText;
                list = gelen.GetElementsByTagName("HostRefNum");
                String xmlHostRefNum = list[0].InnerText;
                list = gelen.GetElementsByTagName("ProcReturnCode");
                String xmlProcReturnCode = list[0].InnerText;
                list = gelen.GetElementsByTagName("TransId");
                String xmlTransId = list[0].InnerText;
                list = gelen.GetElementsByTagName("ErrMsg");
                String xmlErrMsg = list[0].InnerText;
%>
                <h3>Payment Result</h3>
                <table border="1">
                    <tr>
                        <td><b>Parameter Name : </b></td>
                        <td><b>Parameter Value : </b></td>
                    </tr>
                    
                    <tr>
                        <td>AuthCode</td>
                        <td><%Response.Write(xmlAuthCode); %></td>
                    </tr>
                    
                    <tr>
                        <td>Response</td>
                        <td><%Response.Write(xmlResponse);%></td>
                    </tr>
                    
                    <tr>
                        <td>HostRefNum</td>
                        <td><%Response.Write(xmlHostRefNum);%></td>
                    </tr>
                    
                    <tr>
                        <td>ProcReturnCode</td>
                        <td><%Response.Write(xmlProcReturnCode);%></td>
                    </tr>
                    
                    <tr>
                        <td>TransId</td>
                        <td><%Response.Write(xmlTransId);%></td>
                    </tr>
                    
                    <tr>
                        <td>ErrMsg</td>
                        <td><%Response.Write(xmlErrMsg); %></td>
                    </tr>                    
                </table>  
<%          
		   if("Approved".Equals(xmlResponse))
		   {
			   Response.Write("Payment is Successful.");
		   }
		   else
		   {
			   Response.Write("Payment is NOT Successful.");
		   }                           
			resp.Close();
		}
		catch (Exception ex)
		{
			Console.Write(ex.ToString());
		}
		finally
		{
			if (resp != null)
				resp.Close();
		}
	}
	else
	{
		Response.Write("3D Authentication is NOT Successful !");
	}
%>
</body>
</html>
