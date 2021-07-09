using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

public partial class _3DModelPaymentPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Display3DResult();
            BindRequestParametersRepeater();

            MakePayment();
        }
    }

    private void BindRequestParametersRepeater()
    {
        string result = String.Empty;

        IEnumerator e = Request.Form.GetEnumerator();

        while (e.MoveNext())
        {
            String xkey = (String)e.Current;
            String xval = Request.Form.Get(xkey);
            result += "<tr><td>" + xkey + "</td><td>" + xval + "</td></tr>" + Environment.NewLine;
        }

        ltrRequestParameters.Text = result;
    }

    private void Display3DResult()
    {
        //Result of the 3D Secure authentication. 1,2,3,4 are successful; 5,6,7,8,9,0 are unsuccessful.
        string mdstatus = Request.Form.Get("mdStatus");

        if (mdstatus == "1" || mdstatus == "2" || mdstatus == "3" || mdstatus == "4")
        {
            lbl3DResult.Text = "3D authentication succesful.";
            lbl3DResult.ForeColor = System.Drawing.Color.Green;

        }
        else
        {
            lbl3DResult.Text = "3D authentication unsuccesful.";
            lbl3DResult.ForeColor = System.Drawing.Color.Red;
        }
    }

    private void MakePayment()
    {
        //Required parameters for payment
        string storekey = "SKEY12345";       

        string nameval = "testapi";                         //API user name
        string passwordval = "TEST1234";                     //API password
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

        string apiUrl = "https://testsanalpos.est.com.tr/servlet/cc5ApiServer"; //"https://<server_name>/<apiserver_path>"; //API server path

        //Result of the 3D Secure authentication. 1,2,3,4 are successful; 5,6,7,8,9,0 are unsuccessful.
        string mdstatus = Request.Form.Get("mdStatus");

        //checking hash
        string hashparams = Request.Form.Get("HASHPARAMS");
        string hashparamsval = Request.Form.Get("HASHPARAMSVAL");
        
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
                lblPaymentResult.Text = "Security warning. Hash values mismatch.";
                lblPaymentResult.ForeColor = System.Drawing.Color.Red;
            }
        }
        else
        {
            lblPaymentResult.Text = "Hash values error. Please check parameters posted to 3D secure page.";
            lblPaymentResult.ForeColor = System.Drawing.Color.Red;
        }


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
            #region generate XML
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

            System.Net.HttpWebResponse resp = null;
            try
            {
                System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(apiUrl);

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
                ltrResponse.Text = list[0].InnerText;

                list = response.GetElementsByTagName("AuthCode");
                ltrAuthCode.Text = list[0].InnerText;

                list = response.GetElementsByTagName("HostRefNum");
                ltrHostRefNum.Text = list[0].InnerText;

                list = response.GetElementsByTagName("ProcReturnCode");
                ltrProcReturnCode.Text = list[0].InnerText;

                list = response.GetElementsByTagName("TransId");
                ltrTransId.Text = list[0].InnerText;

                list = response.GetElementsByTagName("ErrMsg");
                ltrErrMsg.Text = list[0].InnerText;

                if (ltrProcReturnCode.Text == "99")
                {
                    lblPaymentResult.Text = "Payment unsuccesful.";
                    lblPaymentResult.ForeColor = System.Drawing.Color.Red;
                }
                else if (ltrProcReturnCode.Text == "00")
                {
                    lblPaymentResult.Text = "Payment succesful.";
                    lblPaymentResult.ForeColor = System.Drawing.Color.Green;
                }
            }
            catch (Exception ex)
            {
                lblPaymentResult.Text = "An error occured: <i>" + ex.ToString() + "</i>";
                lblPaymentResult.ForeColor = System.Drawing.Color.Red;
            }
            finally
            {
                if (resp != null)
                {
                    resp.Close();
                }
            }
        }
        else
        {
            lblPaymentResult.Text = "3D authentication unsuccesful. Payment request not sent."; 
            lblPaymentResult.ForeColor = System.Drawing.Color.Red;
        }
    }
}