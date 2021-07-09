<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1
-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
    <h1>
        3D Model Payment Page</h1>
    <table class="tableClass">
        <tr>
            <td>
                <h3>
                    3D Authentication Result:&nbsp;
                    </h3>
            </td>
            <td>
                <span>
                    <%
                        //Result of the 3D Secure authentication. 1,2,3,4 are successful; 5,6,7,8,9,0 are unsuccessful.
                        string mdstatus = Request.Form.Get("mdStatus");
                        if (mdstatus.Equals("1") || mdstatus.Equals("2") || mdstatus.Equals("3") || mdstatus.Equals("4"))
                        {
                            Response.Write("<font color=\"green\">3D authentication succesful. </font>");
                        }
                        else
                        {
                            Response.Write("<font color=\"red\">3D authentication unsuccesful. </font>");
                        }

                        string hashparams = Request.Form.Get("HASHPARAMS");
                        string hashparamsval = Request.Form.Get("HASHPARAMSVAL");
                        string storekey = "123456";
                        string paramsval = "";
                        int index1 = 0, index2 = 0;

                        //values which will be used in hash validation is being parsed

                        if (hashparams != null)
                        {
                            do
                            {
                                index2 = hashparams.IndexOf(":", index1);
                                string val = Request.Form.Get(hashparams.Substring(index1, index2 - index1)) == null ? "" : Request.Form.Get(hashparams.Substring(index1, index2 - index1));
                                paramsval += val;
                                index1 = index2 + 1;
                            }
                            while (index1 < hashparams.Length);

                            string hashval = paramsval + storekey;              //Store key is being added to hash value
                            string hashparam = Request.Form.Get("HASH");

                            System.Security.Cryptography.SHA1 sha = new System.Security.Cryptography.SHA1CryptoServiceProvider();
                            byte[] hashbytes = System.Text.Encoding.GetEncoding("ISO-8859-9").GetBytes(hashval);
                            byte[] inputbytes = sha.ComputeHash(hashbytes);

                            string hash = Convert.ToBase64String(inputbytes);   //Hash value used for validation

                            if (!paramsval.Equals(hashparamsval) || !hash.Equals(hashparam)) //hash generated in this page, hash returned and hash generated from parsed parameters should be same
                            {
                                Response.Write("<font color=\"red\">Security warning. Hash values mismatch. </font>");
                            }
                        }
                        else
                        {
                            Response.Write("<font color=\"red\">Hash values error. Please check parameters posted to 3D secure page. </font>");
                        }
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
            IEnumerator e = Request.Form.GetEnumerator();
            while (e.MoveNext())
            {
                string xkey = (string)e.Current;
                string xval = Request.Form.Get(xkey);
                Response.Write("<tr><td>" + xkey + "</td><td>" + xval + "</td></tr>");
            }
        %>
    </table>
    <br />
    <br />
    <table class="tableClass">
        <tr>
            <td>
                <h3>
                    Payment Result:&nbsp;</h3>
            </td>
            <td>
                <span>
                    <%
                        //Required parameters for payment

                        string nameval = "AKTESTAPI";                         //API user name
                        string passwordval = "AKTEST123";                     //API password
                        string clientidval = Request.Form.Get("clientid");  //Merchant Id
                        string modeval = "P";                               //P is constant
                        string typeval = "Auth";                            //Transaction type
                        string expiresval = Request.Form.Get("Ecom_Payment_Card_ExpDate_Month") + "/" + Request.Form.Get("Ecom_Payment_Card_ExpDate_Year"); //Credit card expire date should be in mm/yy format
                        string cv2val = Request.Form.Get("cv2");            //CVV value
                        string totalval = Request.Form.Get("amount");       //Transaction amount
                        string numberval = Request.Form.Get("md");          //In 3D model, returning "md" value should be used instead of credit card number
                        string taksitval = "";                              //Instalment count. If there's no instalment, empty string should be passed
                        string currencyval = "949";                         //Currency code, 949 for TL, ISO_4217 standard
                        string orderidval = "";                             //Order Id. Must be unique. If left blank, system will generate a unique one

                        Session["xmlResponse"] = String.Empty;
                        Session["xmlAuthCode"] = String.Empty;
                        Session["xmlHostRefNum"] = String.Empty;
                        Session["xmlProcReturnCode"] = String.Empty;
                        Session["xmlTransId"] = String.Empty;
                        Session["xmlErrMsg"] = String.Empty;

                        if (mdstatus.Equals("1") || mdstatus.Equals("2") || mdstatus.Equals("3") || mdstatus.Equals("4"))
                        {
                            string payersecuritylevelval = Request.Form.Get("eci");
                            string payertxnidval = Request.Form.Get("xid");
                            string payerauthenticationcodeval = Request.Form.Get("cavv");

                            string ipaddressval = "";
                            string emailval = "";
                            string groupidval = "";
                            string transidval = "";
                            string useridval = "";

                            //Billing information (optional)
                            string billnameval = "";
                            string billstreet1val = "";
                            string billstreet2val = "";
                            string billstreet3val = "";
                            string billcityval = "";
                            string billstateprovval = "";
                            string billpostalcodeval = "";

                            //Shipping information (optional)
                            string shipnameval = "";
                            string shipstreet1val = "";
                            string shipstreet2val = "";
                            string shipstreet3val = "";
                            string shipcityval = "";
                            string shipstateprovval = "";
                            string shippostalcodeval = "";


                            string extraval = "";


                            //Payment request XML is being generated:
                            #region generate xml
                            System.Xml.XmlDocument doc = new System.Xml.XmlDocument();

                            System.Xml.XmlDeclaration dec =
                                doc.CreateXmlDeclaration("1.0", "ISO-8859-9", "yes");

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

                            #endregion

                            string xmlval = doc.OuterXml;     //Reading generated XML


                            string url = "https://entegrasyon.asseco-see.com.tr/fim/api"; //API server path
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


                                string responseXML = responsereader.ReadToEnd(); //Response read as XML string

                                System.Xml.XmlDocument response = new System.Xml.XmlDocument();
                                response.LoadXml(responseXML);    //string parsed as XML document

                                System.Xml.XmlNodeList list = response.GetElementsByTagName("Response");
                                Session["xmlResponse"] = list[0].InnerText;

                                list = response.GetElementsByTagName("AuthCode");
                                Session["xmlAuthCode"] = list[0].InnerText;

                                list = response.GetElementsByTagName("HostRefNum");
                                Session["xmlHostRefNum"] = list[0].InnerText;

                                list = response.GetElementsByTagName("ProcReturnCode");
                                Session["xmlProcReturnCode"] = list[0].InnerText;

                                list = response.GetElementsByTagName("TransId");
                                Session["xmlTransId"] = list[0].InnerText;

                                list = response.GetElementsByTagName("ErrMsg");
                                Session["xmlErrMsg"] = list[0].InnerText;

                                if (Session["xmlResponse"].ToString() == "Approved")
                                {
                                    Response.Write("<font color=\"green\">Payment is successful. </font>");
                                }
                                else
                                {
                                    Response.Write("<font color=\"red\">Payment is unsuccessful. </font>");
                                }
                                resp.Close();
                            }
                            catch (Exception ex)
                            {
                                Response.Write("<font color=\"red\">An error occured: <i>" + ex.ToString() + " </i></font>");
                            }

                            finally
                            {
                                if (resp != null)
                                    resp.Close();
                            }
                        }
                        else
                        {
                            Response.Write("<font color=\"red\">3D Authentication is not successful. Payment request not sent. </font>");
                        }
                    %>
                </span>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <h3>
                    Payment Parameters:</h3>
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
        <tr>
            <td>
                AuthCode
            </td>
            <td>
                <%= Session["xmlAuthCode"].ToString() %>
            </td>
        </tr>
        <tr>
            <td>
                Response
            </td>
            <td>
                <%= Session["xmlResponse"].ToString() %>
            </td>
        </tr>
        <tr>
            <td>
                HostRefNum
            </td>
            <td>
                <%= Session["xmlHostRefNum"].ToString() %>
            </td>
        </tr>
        <tr>
            <td>
                ProcReturnCode
            </td>
            <td>
                <%= Session["xmlProcReturnCode"].ToString() %>
            </td>
        </tr>
        <tr>
            <td>
                TransId
            </td>
            <td>
                <%= Session["xmlTransId"].ToString() %>
            </td>
        </tr>
        <tr>
            <td>
                ErrMsg
            </td>
            <td>
                <%= Session["xmlErrMsg"].ToString()%>
            </td>
        </tr>
    </table>
</body>
</html>
