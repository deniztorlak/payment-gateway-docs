using System;
using System.IO;
using System.Net;
using System.Text;

public partial class _3DModel : System.Web.UI.Page
{
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //string apiServerUrl = "https://testsanalpos.est.com.tr/servlet/est3Dgate";    //Url of the API server
        string apiServerUrl = "https://entegrasyon.asseco-see.com.tr/fim/est3dgate";    //Url of the API server

        string clientId = "130012345";                   //Merchant Id defined by bank to user
        string amount = "9.95";                         //Transaction amount
        string oid = "";                                //Order Id. Must be unique. If left blank, system will generate a unique one.
        string okUrl = "http://localhost:3087/3DModelSample/3dModelPaymentPage.aspx";                      //URL which client be redirected if authentication is successful
        string failUrl = "http://localhost:3087/3DModelSample/3dModelPaymentPage.aspx";                    //URL which client be redirected if authentication is not successful

        string storekey = "SKEY12345";                    //Store key value, defined by bank.
        string storetype = "3d";
        string lang = "tr";                             //Language parameter, "tr" for Turkish (default), "en" for English
        string currency = "949";                        //Currency code, 949 for TL, ISO_4217 standard

        string description = "";                        //Description
        string xid = "";                                //Order tracking number, if left blank system will generate it
        string email = "";                              //Customer email address
        string userid = "";                             //Id for tracking users

        string rnd = DateTime.Now.ToString();           //A random number, such as date/time

        string hashstr = clientId + oid + amount + okUrl + failUrl + rnd + storekey;
        System.Security.Cryptography.SHA1 sha = new System.Security.Cryptography.SHA1CryptoServiceProvider();
        byte[] hashbytes = System.Text.Encoding.GetEncoding("ISO-8859-9").GetBytes(hashstr);
        byte[] inputbytes = sha.ComputeHash(hashbytes);

        string hash = Convert.ToBase64String(inputbytes);   //Hash value used for validation
               
        string postData = String.Empty;

        postData += "pan=" + txtCardNumber.Text + "&";
        postData += "cv2=" + txtCVV.Text + "&";
        postData += "Ecom_Payment_Card_ExpDate_Year=" + txtExpireYear.Text + "&";
        postData += "Ecom_Payment_Card_ExpDate_Month=" + txtExpireMonth.Text + "&";
        postData += "cardType=" + ddlCardType.SelectedValue + "&";
        postData += "clientid=" + clientId + "&";
        postData += "amount=" + amount + "&";
        postData += "oid=" + oid + "&";
        postData += "okUrl=" + okUrl + "&";
        postData += "failUrl=" + failUrl + "&";
        postData += "rnd=" + rnd + "&";
        postData += "hash=" + hash + "&";
        postData += "storetype=" + storetype + "&";
        postData += "lang=" + lang + "&";
        postData += "currency=" + currency;

        byte[] postByteArray = Encoding.UTF8.GetBytes(postData);

        WebRequest webRequest = WebRequest.Create(apiServerUrl);
        webRequest.Method = "POST";
        webRequest.ContentType = "application/x-www-form-urlencoded";
        webRequest.ContentLength = postByteArray.Length;

        Stream dataStream = webRequest.GetRequestStream();
        dataStream.Write(postByteArray, 0, postByteArray.Length);
        dataStream.Close();

        WebResponse webResponse = webRequest.GetResponse();

        dataStream = webResponse.GetResponseStream();
        StreamReader reader = new StreamReader(dataStream);
        string responseFromServer = reader.ReadToEnd();

        Response.ClearContent();
        Response.Write(responseFromServer);

        reader.Close();
        dataStream.Close();
        webResponse.Close();        

    }
}