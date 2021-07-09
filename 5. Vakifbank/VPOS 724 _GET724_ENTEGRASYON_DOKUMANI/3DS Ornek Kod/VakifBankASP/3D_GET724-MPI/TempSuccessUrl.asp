<%@ Language=VBScript %>
<html>
<head>
    <title>Report</title>
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
   <form id="form1" method="post" action="TempSucessUrl.asp">
    <div class="mainDiv">
        <div>
            <span class="innerSpan">Status</span>
            <span><input type="text" id="Status" name="Status" value="<%=Request.Form("Status")%>" /></span>
         </div>
        <div>
            <span class="innerSpan">Merchant Id</span>
            <span><input type="text" id="MerchantId" name="MerchantId" value="<%=Request.Form("MerchantId")%>" /></span>
         </div>
         <div>
            <span class="innerSpan">VerifyEnrollmentRequest Id</span>
            <span><input type="text" id="VerifyEnrollmentRequestId" name="VerifyEnrollmentRequestId" value="<%=Request.Form("VerifyEnrollmentRequestId")%>" /></span>
         </div>
         <div>
            <span class="innerSpan">Purchase Amount</span>
            <span><input type="text" id="PurchAmount" name="PurchAmount" value="<%=Request.Form("PurchAmount")%>" /></span>
         </div>
          <div>
            <span class="innerSpan">Xid</span>
            <span><input type="text" id="Xid" name="Xid" value="<%=Request.Form("Xid")%>" /></span>
         </div>
          <div>
            <span class="innerSpan">InstallmentCount</span>
            <span><input type="text" id="InstallmentCount" name="InstallmentCount" value="<%=Request.Form("InstallmentCount")%>" /></span>
         </div>
           <div>
            <span class="innerSpan">Session Info</span>
            <span><input type="text" id="SessionInfo" name="SessionInfo" value="<%=Request.Form("SessionInfo")%>" /></span>
         </div>
         <div>
            <span class="innerSpan">Purchase Currency</span>
            <span><input type="text" id="PurchCurrency" name="PurchCurrency" value="<%=Request.Form("PurchCurrency")%>" /></span>
         </div>
         <div>
            <span class="innerSpan">Pan</span>
            <span><input type="text" id="Pan" name="Pan" value="<%=Request.Form("Pan")%>"/></span>
         </div>
          <div>
            <span class="innerSpan">Expire Date</span>
            <span><input type="text" id="ExpiryDate" name="ExpiryDate" value="<%=Request.Form("Expiry")%>" /></span>
         </div>
         <div>
            <span class="innerSpan">Eci</span>
            <span><input type="text" id="Eci" name="Eci" value="<%=Request.Form("Eci")%>" /></span>
         </div>
         <div>
            <span class="innerSpan">Cavv</span>
            <span><input type="text" id="Cavv" name="Cavv" value="<%=Request.Form("Cavv")%>" /></span>
         </div>
    </div>
    </form>
</body>
</html>