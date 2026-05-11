using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;

namespace PayFlex.Mpi.Sample.Application
{
    public partial class TempSucessUrl : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack && Request.Form.Count <= 0)
            {
                return;
            }

            Status.Value = Request.Form["Status"];
            MerchantId.Value = Request.Form["MerchantId"];
            VerifyEnrollmentRequestId.Value = Request.Form["VerifyEnrollmentRequestId"];
            Xid.Value = Request.Form["Xid"];
            PurchAmount.Value = Request.Form["PurchAmount"];
            Xid.Value = Request.Form["Xid"];
            SessionInfo.Value = Request.Form["SessionInfo"];
            PurchCurrency.Value = Request.Form["PurchCurrency"];
            Pan.Value = Request.Form["Pan"];
            ExpiryDate.Value = Request.Form["Expiry"];
            Eci.Value = Request.Form["Eci"];
            Cavv.Value = Request.Form["Cavv"];
            InstallmentCount.Value = Request.Form["InstallmentCount"];
        }
    }
}