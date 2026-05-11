<%@ Page Language="C#" AutoEventWireup="true" CodeFile="3DPay.aspx.cs" Inherits="_3DPay" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>3D Pay Sample Page</title>
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
    <form id="paymentForm" runat="server">
    <center>
        <h1>
            3D Pay Sample Page</h1>
        <table class="tableClass">
            <tr class="trHeader">
                <td>
                    Credit Card Number:
                </td>
                <td>
                    <asp:TextBox ID="txtCardNumber" runat="server" MaxLength="20" AutoCompleteType="None"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCreditCardNumber" runat="server" ControlToValidate="txtCardNumber"
                        Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    CVV Value:
                </td>
                <td>
                    <asp:TextBox ID="txtCVV" runat="server" MaxLength="4" AutoCompleteType="None"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCVV" runat="server" ControlToValidate="txtCVV"
                        Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Expire Month:
                </td>
                <td>
                    <asp:TextBox ID="txtExpireMonth" runat="server" MaxLength="2" AutoCompleteType="None"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvExpireMonth" runat="server" ControlToValidate="txtExpireMonth"
                        Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Expire Year:
                </td>
                <td>
                    <asp:TextBox ID="txtExpireYear" runat="server" MaxLength="4" AutoCompleteType="None"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvExpireYear" runat="server" ControlToValidate="txtExpireYear"
                        Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Card Type:
                </td>
                <td>
                    <asp:DropDownList ID="ddlCardType" runat="server">
                        <asp:ListItem Text="Visa" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="MasterCard" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="buttonClass" Text="Submit" CausesValidation="true"
                        OnClick="btnSubmit_Click" />
                </td>
            </tr>
        </table>
    </center>
    </form>
</body>
</html>
