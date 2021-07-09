<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
        <tr>
            <td>
                <b>Parameter Name:</b>
            </td>
            <td>
                <b>Parameter Value:</b>
            </td>
        </tr>
        <%
            string[] paymentParameters = new String[] { "AuthCode", "Response", "HostRefNum", "ProcReturnCode", "TransId", "ErrMsg" };
            IEnumerator e = Request.Form.GetEnumerator();
            while (e.MoveNext())
            {
                String xkey = (String)e.Current;
                String xval = Request.Form.Get(xkey);
                bool ok = true;
                for (int i = 0; i < paymentParameters.Length; i++)
                {
                    if (xkey.Equals(paymentParameters[i]))
                    {
                        ok = false;
                        break;
                    }
                }
                if (ok)
                {
                    Response.Write("<tr><td>" + xkey + "</td><td>" + xval + "</td></tr>");
                }
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
                        string clientidval = Request.Form.Get("clientid");  //Merchant Id
                        string expiresval = Request.Form.Get("Ecom_Payment_Card_ExpDate_Month") + "/" + Request.Form.Get("Ecom_Payment_Card_ExpDate_Year"); //Credit card expire date should be in mm/yy format
                        string cv2val = Request.Form.Get("cv2");            //CVV value
                        string totalval = Request.Form.Get("amount");       //Transaction amount
                        string numberval = Request.Form.Get("md");          //In 3D model, returning "md" value should be used instead of credit card number

                        Session["xmlAuthCode"] = String.Empty;
                        Session["xmlHostRefNum"] = String.Empty;
                        Session["xmlProcReturnCode"] = String.Empty;
                        Session["xmlTransId"] = String.Empty;
                        Session["xmlErrMsg"] = String.Empty;

                        if (mdstatus.Equals("1") || mdstatus.Equals("2") || mdstatus.Equals("3") || mdstatus.Equals("4"))
                        {
                            try
                            {
                                Session["xmlAuthCode"] = Request.Form.Get("AuthCode");
                                Session["xmlHostRefNum"] = Request.Form.Get("HostRefNum");
                                Session["xmlProcReturnCode"] = Request.Form.Get("ProcReturnCode");
                                Session["xmlTransId"] = Request.Form.Get("TransId");
                                Session["xmlErrMsg"] = Request.Form.Get("ErrMsg");

                                if (Request.Form.Get("Response") == "Approved")
                                {
                                    Response.Write("<font color=\"green\">Payment is successful. </font>");
                                }
                                else
                                {
                                    Response.Write("<font color=\"red\">Payment is unsuccessful. </font>");
                                }
                            }
                            catch (Exception ex)
                            {
                                Response.Write("<font color=\"red\">An error occured: <i>" + ex.ToString() + " </i></font>");
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
        <%
            for (int i = 0; i < paymentParameters.Length; i++)
            {
                String paramname = paymentParameters[i];
                String paramval = Request.Form.Get(paramname);
                Response.Write("<tr><td>" + paramname + "</td><td>" + paramval + "</td></tr>");
            }
    
        %>
    </table>
</body>
</html>
