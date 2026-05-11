using System;
using System.Collections;
using System.Web.UI;

public partial class _3DPayResultPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Display3DResult();
            BindRequestParametersRepeater();

            DisplayPaymentResult();
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

    private void DisplayPaymentResult()
    {
        string storekey = "123456";

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
            try
            {   
                ltrAuthCode.Text = Request.Form.Get("AuthCode");
                ltrHostRefNum.Text = Request.Form.Get("HostRefNum");
                ltrProcReturnCode.Text = Request.Form.Get("ProcReturnCode");
                ltrTransId.Text = Request.Form.Get("TransId");
                ltrErrMsg.Text = Request.Form.Get("ErrMsg");

                if (Request.Form.Get("Response") == "Approved")
                {
                    lblPaymentResult.Text = "Payment succesful.";
                    lblPaymentResult.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblPaymentResult.Text = "Payment unsuccesful.";
                    lblPaymentResult.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblPaymentResult.Text = "An error occured: <i>" + ex.ToString() + "</i>";
                lblPaymentResult.ForeColor = System.Drawing.Color.Red;
            }
        }
        else
        {
            lblPaymentResult.Text = "3D authentication and payment unsuccesful.";
            lblPaymentResult.ForeColor = System.Drawing.Color.Red;
        }
    }
}