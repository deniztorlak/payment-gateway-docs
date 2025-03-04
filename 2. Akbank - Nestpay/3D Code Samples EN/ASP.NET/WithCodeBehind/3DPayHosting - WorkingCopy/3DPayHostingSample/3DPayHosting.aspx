<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>3D Pay Hosting Sample Page</title>
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
       System.Security.Cryptography.SHA1 sha = new System.Security.Cryptography.SHA1CryptoServiceProvider();

       string clientId = "500100000";                   //Merchant Id defined by bank to user
       string amount = "1.00";                         //Transaction amount
       string oid = "";                                //Order Id. Must be unique. If left blank, system will generate a unique one.
       string okUrl = "https://localhost:44322/3DPayHostingResultPage.aspx?status=ok";                      //URL which client be redirected if authentication is successful
       string failUrl = "https://localhost:44322/3DPayHostingResultPage.aspx?status=fail";                    //URL which client be redirected if authentication is not successful
       string callbackurl = "https://localhost:44322/3DPayHostingResultPage.aspx?status=callback";                    //URL which client be redirected if authentication is not successful
       string rnd = DateTime.Now.ToString();           //A random number, such as date/time

       string currency = "949";                        //Currency code, 949 for TL, ISO_4217 standard
       string instalmentCount = "";                    //Instalment count, if there is no instalment should left blank
       string islemtipi = "Auth";                      //Transaction type
       string storekey = "123456";                     //Store key value, defined by bank.

       string hashstr = clientId + oid + amount + okUrl + failUrl + islemtipi + instalmentCount + rnd + callbackurl + storekey;
       byte[] hashbytes = System.Text.Encoding.GetEncoding("ISO-8859-9").GetBytes(hashstr);
       byte[] inputbytes = sha.ComputeHash(hashbytes);

       String hash = Convert.ToBase64String(inputbytes); //Hash value used for validation

       //Parameters needed for payment and 3D authentication       
   %>

   <h1>3D Pay Hosting Sample Page</h1>
   <table class="tableClass">
       <tr class="trHeader">
           <td colspan="2">This sample page submits client Id, transaction type, amount, okUrl, failUrl, order
                   Id, instalment count and store key.
                   <br />
               Credit card information will be asked in the 3d secure page.
           </td>
       </tr>
       <tr>
           <td align="center" colspan="2"></td>
       </tr>
   </table>
   <h1>Working Form</h1>
   <form id="paymentForm" method="post" action="https://entegrasyon.asseco-see.com.tr/fim/est3Dgate">
       <input type="hidden" name="amount" value="1.00" />
       <input type="hidden" name="clientid" value="500100000" />
       <input type="hidden" name="currency" value="949" />
       <input type="hidden" name="cv2" value="001" />
       <input type="hidden" name="Ecom_Payment_Card_ExpDate_Year" value="26" />
       <input type="hidden" name="Ecom_Payment_Card_ExpDate_Month" value="12" />
       <input type="hidden" name="failUrl" value="https://localhost:44322/3DPayHostingResultPage.aspx?status=fail" />

       <input type="hidden" name="oid" value="" />
       <input type="hidden" name="okUrl" value="https://localhost:44322/3DPayHostingResultPage.aspx?status=ok" />
       <input type="hidden" name="pan" value="4546711234567894" />

       <input type="hidden" name="rnd" value="<%=rnd%>" />
       <input type="hidden" name="storetype" value="3d_pay_hosting" />
       <input type="hidden" name="hash" value="<%=hash%>" />

       <input type="hidden" name="islemtipi" value="Auth" />
       <input type="hidden" name="callbackurl" value="https://localhost:44322/3DPayHostingResultPage.aspx?status=callback" />
       <input type="hidden" name="taksit" value="" />
       <input type="hidden" name="refreshtime" value="0" />


       <input type="submit" value="Submit" class="buttonClass" />

   </form>
</body>
</html>
