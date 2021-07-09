<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TempSucessUrl.aspx.cs" Inherits="PayFlex.Mpi.Sample.Application.TempSucessUrl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style>
        .mainDiv
        {
            width:360px;
            height:300px;
            position:absolute;
            left:50%;
            margin-left:-250px;
            color: black; 
            border:6px inset red; 
            border-radius: 15px;
            display: inline;
            padding:15px;
            box-shadow: 10px 10px 5px #888; 
        }
        .innerSpan
        {
            width:175px;
            float:left;
            padding:4px 0 0 0;
        }
    </style>
</head>
<body>
   <form id="form1" runat="server" method="post" action="TempSucessUrl.aspx">
    <div class="mainDiv">
        <div>
            <span class="innerSpan">Status</span>
            <span><input type="text" runat="server" id="Status" name="Status" value="" /></span>
         </div>
        <div>
            <span class="innerSpan">Merchant Id</span>
            <span><input type="text" runat="server" id="MerchantId" name="MerchantId" value="" /></span>
         </div>
         <div>
            <span class="innerSpan">VerifyEnrollmentRequest Id</span>
            <span><input type="text" runat="server" id="VerifyEnrollmentRequestId" name="VerifyEnrollmentRequestId" /></span>
         </div>
         <div>
            <span class="innerSpan">Purchase Amount</span>
            <span><input type="text" runat="server" id="PurchAmount" name="PurchAmount" /></span>
         </div>
          <div>
            <span class="innerSpan">Xid</span>
            <span><input type="text" runat="server" id="Xid" name="Xid" /></span>
         </div>
          <div>
            <span class="innerSpan">InstallmentCount</span>
            <span><input type="text" runat="server" id="InstallmentCount" name="InstallmentCount" /></span>
         </div>
           <div>
            <span class="innerSpan">Session Info</span>
            <span><input type="text" runat="server" id="SessionInfo" name="SessionInfo" /></span>
         </div>
         <div>
            <span class="innerSpan">Purchase Currency</span>
            <span><input type="text" runat="server" id="PurchCurrency" name="PurchCurrency" /></span>
         </div>
         <div>
            <span class="innerSpan">Pan</span>
            <span><input type="text" runat="server" id="Pan" name="Pan"  value=""/></span>
         </div>
          <div>
            <span class="innerSpan">Expire Date</span>
            <span><input type="text" runat="server" id="ExpiryDate" name="ExpiryDate" value="" /></span>
         </div>
         <div>
            <span class="innerSpan">Eci</span>
            <span><input type="text" runat="server" id="Eci" name="Eci" /></span>
         </div>
         <div>
            <span class="innerSpan">Cavv</span>
            <span><input type="text" runat="server" id="Cavv" name="Cavv" /></span>
         </div>
    </div>
    </form>
</body>
</html>
