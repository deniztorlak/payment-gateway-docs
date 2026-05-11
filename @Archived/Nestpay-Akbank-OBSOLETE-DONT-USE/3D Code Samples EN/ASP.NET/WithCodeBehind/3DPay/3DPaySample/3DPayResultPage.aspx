<%@ Page Language="C#" AutoEventWireup="true" CodeFile="3DPayResultPage.aspx.cs" Inherits="_3DPayResultPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1
-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
                <asp:Label ID="lbl3DResult" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <h3>
                    3D Parameters:</h3>
            </td>
        </tr>
        <tr class="trHeader">
            <td>
                <b>Parameter Name:</b>
            </td>
            <td>
                <b>Parameter Value:</b>
            </td>
        </tr>
        <asp:Literal ID="ltrRequestParameters" runat="server"></asp:Literal>
    </table>
    <br /><br />
    <table class="tableClass">
        <tr>
            <td>
                <h3>
                    Payment Result:&nbsp;</h3>
            </td>
            <td>
                <asp:Label ID="lblPaymentResult" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <h3>
                    Payment Parameters:</h3>
            </td>
        </tr>
        <tr class="trHeader">
            <td>
                <b>Parameter Name:</b>
            </td>
            <td>
                <b>Parameter Value:</b>
            </td>
        </tr>
        <tr>
            <td>
                AuthCode
            </td>
            <td>
                <asp:Literal ID="ltrAuthCode" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td>
                Response
            </td>
            <td>
                <asp:Literal ID="ltrResponse" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td>
                HostRefNum
            </td>
            <td>
                <asp:Literal ID="ltrHostRefNum" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td>
                ProcReturnCode
            </td>
            <td>
                <asp:Literal ID="ltrProcReturnCode" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td>
                TransId
            </td>
            <td>
                <asp:Literal ID="ltrTransId" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td>
                ErrMsg
            </td>
            <td>
                <asp:Literal ID="ltrErrMsg" runat="server"></asp:Literal>
            </td>
        </tr>
    </table>
</body>
</html>
