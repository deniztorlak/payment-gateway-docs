<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>3D Pay Hosting Sample Page</title>
    <style type="text/css">
        body {
            border-style: none;
            color: #6B7983;
            font-family: Tahoma,Arial,Verdana,Sans-Serif;
            font-size: 12px;
            font-weight: normal;
        }

        tableClass {
            margin: 0;
        }

        .trHeader td {
            color: #FFA92D;
            font-weight: bold;
        }

        span {
            margin: 0px 0px 6px 0px;
            font-size: 14px;
            font-weight: bold;
        }

        td {
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

        h3 {
            margin: 0px 0px 6px 0px;
            font-size: 14px;
            font-weight: bold;
            color: #518ccc;
        }

        h1 {
            font-family: Calibri, Tahoma, Arial, Verdana, Sans-Serif;
            font-size: 24px;
            font-weight: normal;
            color: #51596a;
        }

        .buttonClass {
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
        System.Security.Cryptography.SHA1 sha = new System.Security.Cryptography.SHA1CryptoServiceProvider();

        string clientId = "500100000";                   //Merchant Id defined by bank to user
        string amount = "1.00";                         //Transaction amount
        string currency = "949";                        //Currency code, 949 for TL, ISO_4217 standard
        string instalmentCount = "";                    //Instalment count, if there is no instalment should left blank
        string islemtipi = "Auth";                      //Transaction type
        string storekey = "123456";                     //Store key value, defined by bank.

        string pan = "4546711234567894";
        string Ecom_Payment_Card_ExpDate_Year = "26";
        string Ecom_Payment_Card_ExpDate_Month = "12";
        string cv2 = "001";
    %>

    <h1>3D Pay Hosting Sample Page</h1>

    <h2>Working Form</h2>
    <%
        string oid = "";
        string okUrl = "https://localhost:44322/3DPayHostingResultPage.aspx?status=ok";
        string failUrl = "https://localhost:44322/3DPayHostingResultPage.aspx?status=fail";
        string callbackurl = "https://localhost:44322/3DPayHostingResultPage.aspx?status=callback";
        string rnd = DateTime.Now.ToString();

        string hashstr = clientId + oid + amount + okUrl + failUrl + islemtipi + instalmentCount + rnd + callbackurl + storekey;
        byte[] hashbytes = System.Text.Encoding.GetEncoding("ISO-8859-9").GetBytes(hashstr);
        byte[] inputbytes = sha.ComputeHash(hashbytes);

        String hash = Convert.ToBase64String(inputbytes); //Hash value used for validation

    %>
    <form id="paymentForm" method="post" action="https://entegrasyon.asseco-see.com.tr/fim/est3Dgate">
        <input type="hidden" name="amount" value="1.00" />
        <input type="hidden" name="clientid" value="500100000" />
        <input type="hidden" name="currency" value="949" />
        <input type="hidden" name="cv2" value="<%=cv2 %>" />
        <input type="hidden" name="Ecom_Payment_Card_ExpDate_Year" value="<%=Ecom_Payment_Card_ExpDate_Year %>" />
        <input type="hidden" name="Ecom_Payment_Card_ExpDate_Month" value="<%=Ecom_Payment_Card_ExpDate_Month %>" />
        <input type="hidden" name="failUrl" value="https://localhost:44322/3DPayHostingResultPage.aspx?status=fail" />

        <input type="hidden" name="oid" value="" />
        <input type="hidden" name="okUrl" value="https://localhost:44322/3DPayHostingResultPage.aspx?status=ok" />
        <input type="hidden" name="pan" value="<%=pan %>" />

        <input type="hidden" name="rnd" value="<%=rnd%>" />
        <input type="hidden" name="storetype" value="3d_pay_hosting" />
        <input type="hidden" name="hash" value="<%=hash%>" />

        <input type="hidden" name="islemtipi" value="Auth" />
        <input type="hidden" name="callbackurl" value="https://localhost:44322/3DPayHostingResultPage.aspx?status=callback" />
        <input type="hidden" name="taksit" value="" />
        <input type="hidden" name="refreshtime" value="0" />

        <input type="submit" value="Submit" class="buttonClass" />

    </form>

    <h2>Test Form</h2>
    <%
        string oid2 = "dAGLqu_b9337e33_4c47_42f7_9766_44a3b";
        string okUrl2 = "https://localhost:44322/3DPayHostingResultPage.aspx";
        string failUrl2 = "https://localhost:44322/3DPayHostingResultPage.aspx";
        string callbackurl2 = "https://localhost:44322/3DPayHostingResultPage.aspx";
        string rnd2 = "30.01.2024 12:47:39";
        string hashstr2 = clientId + oid2 + amount + okUrl2 + failUrl2 + islemtipi + instalmentCount + rnd2 + callbackurl2 + storekey;

        byte[] hashbytes2 = System.Text.Encoding.GetEncoding("ISO-8859-9").GetBytes(hashstr2);
        byte[] inputbytes2 = sha.ComputeHash(hashbytes2);

        String hash2 = Convert.ToBase64String(inputbytes2); //Hash value used for validation

    %>

    <form id="form1" method="post" action="https://entegrasyon.asseco-see.com.tr/fim/est3dgate">
        <input type="submit" value="Submit2" class="buttonClass" />


        <input type="hidden" name="ReferenceNumber" id="ReferenceNumber" value="dAGLqu"><br>
        <input type="hidden" name="threeDControl" id="threeDControl" value="True"><br>
        <input type="hidden" name="clientid" id="clientid" value="190100000"><br>
        <input type="hidden" name="storetype" id="storetype" value="3d_pay_hosting"><br>
        <input type="hidden" name="hash" id="hash" value="VG6QGfrHeqK4yMOwBE0vOby9mfU="><br>
        <input type="hidden" name="amount" id="amount" value="1.00"><br>
        <input type="hidden" name="currency" id="currency" value="949"><br>
        <input type="hidden" name="oid" id="oid" value="dAGLqu_b9337e33_4c47_42f7_9766_44a3b"><br>
        <input type="hidden" name="okUrl" id="okUrl" value="https://localhost:44300/CustomerPayment/CustomerPaymentVoucher/dAGLqu"><br>
        <input type="hidden" name="failUrl" id="failUrl" value="https://localhost:44300/CustomerPayment/CustomerPaymentVoucher/dAGLqu/true"><br>
        <input type="hidden" name="lang" id="lang" value="tr"><br>
        <input type="hidden" name="rnd" id="rnd" value="30.01.2024 12:47:39"><br>
        <input type="hidden" name="pan" value="<%=pan %>"><br>
        <input type="hidden" name="cv2" value="<%=cv2 %>"><br>
        <input type="hidden" name="Ecom_Payment_Card_ExpDate_Year" value="<%=Ecom_Payment_Card_ExpDate_Year %>"><br>
        <input type="hidden" name="Ecom_Payment_Card_ExpDate_Month" value="<%=Ecom_Payment_Card_ExpDate_Month %>"><br>


    </form>
</body>
</html>
