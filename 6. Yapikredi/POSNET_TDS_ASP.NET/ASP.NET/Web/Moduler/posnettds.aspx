<%@ Page Language="VB" AutoEventWireup="false" CodeFile="posnettds.aspx.vb" Inherits="Moduler_posnettds" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>YKB Posnet 3D-Secure Yönlendirme Sayfası</title>
<link href="css/global.css" rel="stylesheet" type="text/css" />
<link href="css/globalsubpage.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript" src="scripts/posnet.js"></script>
<script language="JavaScript" type="text/JavaScript">
function submitFormEx(Form, OpenNewWindowFlag, WindowName) {
    	Form.action = "<%=posnettds_config.OOS_TDS_SERVICE_URL%>"
    	submitForm(Form, OpenNewWindowFlag, WindowName)
    	Form.submit();
}
</script>
<style type="text/css">

html {padding:0 0 20px 0;}
body {font-size:11px; color:#38546e; line-height:15px;}
body {
	background-repeat: repeat-x;
	background-position: center top;
	margin: 0px;
	padding: 0px;
	height: 100%;
	width: 100%;
	font-family: Tahoma, Verdana, Arial, sans-serif;
}
a {text-decoration:underline; color:#38546e; outline:none;}

a{outline:0;}

        .style1
        {
            margin: 0px;
            padding: 0px;
        }
        .style2
        {
            margin: 0px;
            padding: 0px;
            text-align: left;
        }
    </style>
</head>
<body>
<form id="formName" runat="server" name="formName" 
    target="YKBWindow" method="post">
<br/>      
<br/>      
<br/>
<center>
    <table width="599" height="309" border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr> 
          <td width="172" height="59" align="center" valign="middle" background="images/top_left.gif"> 
            <p>&nbsp;</p></td>
          <td width="255" height="59" align="center" valign="middle" background="images/top_middle.gif">
              &nbsp;</td>
          <td width="167" height="59" align="center" valign="middle" background="images/top_right.gif">
              &nbsp;</td>
          <td width="5" align="center" valign="middle">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="3" align="center" valign="middle" background="images/middle.gif"> 
			<h4 class="style1">YKB Posnet 3D-Secure sistemine 
              <br/>
              yönlenmek için lütfen aşağıdaki linke tıklayınız. </h4></td>
          <td width="5" height="68" align="center" valign="middle">&nbsp;</td>
        </tr>
        <tr> 
          <td height="60" colspan="3" align="center" valign="middle" background="images/middle.gif"> 
<table width="260" height="72" border="0" cellpadding="0" cellspacing="0">
<tr> 
                <td width="110" height="24"> 
<h5 class="style2">Tutar :</h5></td>
                <td width="150" height="24"> 
                  <h5 class="style2">
                      <asp:Label ID="amount" runat="server" Text=""></asp:Label>
                    </h5></td>
              </tr>
              <tr> 
                <td height="24"> <h5 class="style2">Taksit Sayısı :</h5></td>
                <td height="24"> <h5 class="style2">
                    <asp:Label ID="instNumber" runat="server"></asp:Label>
                    </h5></td>
              </tr>
              <tr> 
                <td width="107" height="24"> 
<h5 class="style2">Sipariş No :</h5></td>
                <td height="24"><h5 class="style2">
                    <asp:Label ID="XID" runat="server" Text=""></asp:Label>
                    </h5></td>
              </tr>
              <tr> 
                <td width="107" height="24" colspan="2"> 
                    <asp:HiddenField ID="posnetData" runat="server" />
                    <asp:HiddenField ID="posnetData2" runat="server" />
                    <asp:HiddenField ID="digest" runat="server" />
                    <asp:HiddenField ID="mid" runat="server" />
                    <asp:HiddenField ID="posnetID" runat="server" />
                    <asp:HiddenField ID="vftCode" runat="server" />
                    <!-- <asp:HiddenField ID="koiCode" runat="server" /> -->
                    <asp:HiddenField ID="merchantReturnURL" runat="server" />
                    <!-- Static Parameters -->
                    <asp:HiddenField ID="lang" runat="server" Value="tr" />
                    <asp:HiddenField ID="url" runat="server" />
                    <asp:HiddenField ID="openANewWindow" runat="server" />
                  </td>
              </tr>
            </table></td>
          <td width="5" height="60" align="center" valign="middle">&nbsp;</td>
        </tr>
        <tr> 
          <td height="38" colspan="3" align="center" valign="bottom" background="images/middle.gif"> 
              <asp:ImageButton ID="imageField" runat="server" 
                  Height="20" Width="67" BorderWidth="0px" 
                  ImageUrl="images/button_odeme_yap.gif" />
              &nbsp;
              <a href="<%=posnettds_config.MERCHANT_INIT_URL%>"> <img src="images/button_iptal.gif" width="67" height="20" border="0"/> 
            </a> </td>
          <td width="5" height="38" align="center" valign="middle">&nbsp;</td>
        </tr>
        <tr> 
          <td height="43" background="images/bottom_left.gif">&nbsp;</td>
          <td height="43" background="images/bottom_middle.gif">&nbsp;</td>
          <td height="43" background="images/bottom_right.gif">&nbsp;</td>
          <td width="5" height="43" align="center" valign="middle">&nbsp;</td>
        </tr>
        <tr> 
          <td height="35" colspan="3" align="center" valign="middle"><img src="images/ykblogo.gif" width="115" height="17"></td>
          <td width="5" align="center" valign="middle">&nbsp;</td>
        </tr>
      </tbody>
    </table>
</center>
</form>
</body>
</html>
