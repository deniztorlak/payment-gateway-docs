<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>3D Model Sample Page</title>
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
        .buttonClass
        {
            background: none repeat scroll 0 0 #2B5576;
            border: 1px solid #346B96;
            color: #FFFFFF;
            font-size: 11px;
            font-weight: bold;
            padding: 1px;
            text-align: center;
        }
    </style>
</head>
<body>
    <%
        //This the sample 3d secure page. Parameters should be updated before testing.

        string clientId = "100100000";                   //Merchant Id defined by bank to user
        string amount = "9.95";                         //Transaction amount
        string oid = "";                       //Order Id. Must be uniuqe. If left blank, system will generate a unique one.
        string okUrl = "http://localhost:3384/3DModelSample/3dModelPaymentPage.aspx";                      //URL which client be redirected if authentication is successful
        string failUrl = "http://localhost:3384/3DModelSample/3dModelPaymentPage.aspx";                    //URL which client be redirected if authentication is not successful
        string rnd = DateTime.Now.ToString();           //A random number, such as date/time

        string storekey = "123456";                    //Store key value, defined by bank.
        string storetype = "3d";
        string lang = "tr";                             //Language parameter, "tr" for Turkish (default), "en" for English        
        string currency = "949";                        //Currency code, 949 for TL, ISO_4217 standard
        
        string hashstr = clientId + oid + amount + okUrl + failUrl + rnd + storekey;
        System.Security.Cryptography.SHA1 sha = new System.Security.Cryptography.SHA1CryptoServiceProvider();
        byte[] hashbytes = System.Text.Encoding.GetEncoding("ISO-8859-9").GetBytes(hashstr);
        byte[] inputbytes = sha.ComputeHash(hashbytes);

        string hash = Convert.ToBase64String(inputbytes);   //Hash value used for validation     
    %>
    <form method="post" action="https://entegrasyon.asseco-see.com.tr/fim/est3Dgate">
    <center>
        <h1>
            3D Model Sample Page</h1>
        <table class="tableClass">
            <tr class="trHeader">
                <td>
                    Credit Card Number:
                </td>
                <td>
                    <input type="text" name="pan" size="20" />
                </td>
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
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <input type="submit" value="Submit" class="buttonClass" />
                </td>
            </tr>
        </table>
        <input type="hidden" name="clientid" value="<%=clientId%>" />
        <input type="hidden" name="amount" value="<%=amount%>" />
        <input type="hidden" name="oid" value="<%=oid%>" />
        <input type="hidden" name="okUrl" value="<%=okUrl%>" />
        <input type="hidden" name="failUrl" value="<%=failUrl%>" />
        <input type="hidden" name="rnd" value="<%=rnd%>" />
        <input type="hidden" name="hash" value="<%=hash%>" />
        <input type="hidden" name="storetype" value="<%= storetype %>" />
        <input type="hidden" name="lang" value="<%= lang %>" />
        <input type="hidden" name="currency" value="<%= currency %>" />
    </center>
    </form>
</body>
</html>
