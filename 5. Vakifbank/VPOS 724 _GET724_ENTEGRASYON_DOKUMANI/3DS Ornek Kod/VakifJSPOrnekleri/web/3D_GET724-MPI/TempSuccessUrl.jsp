<%-- 
    Document   : TempSuccessUrl
    Created on : Apr 2, 2014, 1:38:05 PM
    Author     : bsonmez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MPI İşlemi Başarılı</title>
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
                    <span><input type="text" id="Status" name="Status" value="<%=request.getParameter("Status")%>" /></span>
                </div>
                <div>
                    <span class="innerSpan">Merchant Id</span>
                    <span><input type="text" id="MerchantId" name="MerchantId" value="<%=request.getParameter("MerchantId")%>" /></span>
                </div>
                <div>
                    <span class="innerSpan">VerifyEnrollmentRequestId</span>
                    <span><input type="text" id="VerifyEnrollmentRequestId" name="VerifyEnrollmentRequestId" value="<%=request.getParameter("VerifyEnrollmentRequestId")%>" /></span>
                </div>
                <div>
                    <span class="innerSpan">Purchase Amount</span>
                    <span><input type="text" id="PurchAmount" name="PurchAmount" value="<%=request.getParameter("PurchAmount")%>" /></span>
                </div>
                <div>
                    <span class="innerSpan">Xid</span>
                    <span><input type="text" id="Xid" name="Xid" value="<%=request.getParameter("Xid")%>" /></span>
                </div>
                <div>
                    <span class="innerSpan">InstallmentCount</span>
                    <span><input type="text" id="InstallmentCount" name="InstallmentCount" value="<%=request.getParameter("InstallmentCount")%>" /></span>
                </div>
                <div>
                    <span class="innerSpan">Session Info</span>
                    <span><input type="text" id="SessionInfo" name="SessionInfo" value="<%=request.getParameter("SessionInfo")%>" /></span>
                </div>
                <div>
                    <span class="innerSpan">Purchase Currency</span>
                    <span><input type="text" id="PurchCurrency" name="PurchCurrency" value="<%=request.getParameter("PurchCurrency")%>" /></span>
                </div>
                <div>
                    <span class="innerSpan">Pan</span>
                    <span><input type="text" id="Pan" name="Pan" value="<%=request.getParameter("Pan")%>"/></span>
                </div>
                <div>
                    <span class="innerSpan">Expire Date</span>
                    <span><input type="text" id="ExpiryDate" name="ExpiryDate" value="<%=request.getParameter("Expiry")%>" /></span>
                </div>
                <div>
                    <span class="innerSpan">Eci</span>
                    <span><input type="text" id="Eci" name="Eci" value="<%=request.getParameter("Eci")%>" /></span>
                </div>
                <div>
                    <span class="innerSpan">Cavv</span>
                    <span><input type="text" id="Cavv" name="Cavv" value="<%=request.getParameter("Cavv")%>" /></span>
                </div>
            </div>
        </form>
    </body>
</html>
