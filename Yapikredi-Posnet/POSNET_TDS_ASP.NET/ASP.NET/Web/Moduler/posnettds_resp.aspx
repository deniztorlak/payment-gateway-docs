<%@ Page Language="VB" AutoEventWireup="false" CodeFile="posnettds_resp.aspx.vb" Inherits="Moduler_posnettds_resp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>YKB Posnet 3D-Secure İşlem Onay Sayfası</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9"/>
<meta http-equiv="Content-Style-Type" content="text/css"/>
<meta http-equiv="expires" content="0"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="Pragma" content="no-cache"/>
<script language="JavaScript" type="text/JavaScript" src="scripts/util.js"></script>
<script language="JavaScript" type="text/JavaScript">
<!--
function giris(){
    findandfocus("WPAmount");
}

function tutarKarsilastirma(pamount, tpamount, amount){
    
    ykr_pamount = parseFloat(pamount);
    ykr_tpamount = parseFloat(tpamount);
    ykr_amount = parseFloat(amount);
    
    if(ykr_pamount > ykr_amount) {
        alert("Kullanılmak istenen Puan tutarı, İşlem tutarından büyük olamaz!");
        return false;
    }
    
	//Puan sorgulama yapılamadı (tpamount == -1) ise sadece işlem tutarı ile karşılaştırma yapılsın
    if(tpamount != -1 && ykr_pamount > ykr_tpamount) {
        alert("Kullanılmak istenen Puan tutarı, Kullanılabilir Puan tutarından büyük olamaz!");
        return false;
    }
    
    return true;
}

function formKontrol(){
    var tranTypeObj = findObj("tempTranType");
    if (tranTypeObj == null)
        return false;

    if (tranTypeObj.value == "SaleWP") {
        var puanTutariObj = findObj("WPAmount");
		if(puanTutariObj == null)
			return false;

        if(puanTutariObj.disabled)
			return true;

        if (tutarKontrol("WPAmount"))
		{
		    var totalPointAmountObj = findObj("tempTotalPointAmount");
		    if (totalPointAmountObj == null)
		        return false;

		    var amountObj = findObj("tempAmount");
		    if (amountObj == null)
		        return false;
		    
		    return tutarKarsilastirma(ykr(puanTutariObj.value),
						totalPointAmountObj.value, 
						amountObj.value
						);
		}
		else 
			return false;
	}
	else
		return true;
}
//-->
</script>
<link href="css/global.css" rel="stylesheet" type="text/css" />
<link href="css/globalsubpage.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.style2
        {
            margin: 0px;
            padding: 0px;
        text-align: left;
    }
INPUT.kutuTutar {
   BORDER-BOTTOM: #29598C 1px solid; 
	BORDER-LEFT: #29598C 1px solid; 
	BORDER-RIGHT: #29598C 1px solid; 
	BORDER-TOP: #29598C 1px solid;
	width: 50pt;
}
a {text-decoration:underline; color:#38546e; outline:none;}
a {outline:0;}
</style>
</head>
<body onload="giris()">
<form id="formResp" runat="server" method="post" name="formResp" onsubmit="return formKontrol();">
<center>
    <asp:HiddenField ID="merchantPacket" runat="server" />
    <asp:HiddenField ID="bankPacket" runat="server" />
    <asp:HiddenField ID="sign" runat="server" />
    <asp:HiddenField ID="cctran" runat="server" />
    <asp:HiddenField ID="tempTranType" runat="server" />
    <asp:HiddenField ID="tempTotalPointAmount" runat="server" />
    <asp:HiddenField ID="tempAmount" runat="server" />
    <br/>
    <asp:Table width="599" border="0" cellpadding="0" cellspacing="0" ID="Table1" runat="server">
        <asp:TableRow runat="server"> 
          <asp:TableCell runat="server" width="172" height="59" align="center" valign="middle" background="images/top_left.gif"> 
            <p>&nbsp;</p></asp:TableCell>
          <asp:TableCell runat="server" width="255" align="center" valign="middle" background="images/top_middle.gif">&nbsp;</asp:TableCell>
          <asp:TableCell runat="server" width="167" align="center" valign="middle" background="images/top_right.gif">&nbsp;</asp:TableCell>
          <asp:TableCell runat="server" width="5" align="center" valign="middle">&nbsp;</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server"> 
          <asp:TableCell runat="server" height="83" colspan="3" align="center" valign="middle" background="images/middle.gif"> 
            <h4>
                <asp:Label ID="headerMessage" runat="server" Text="[  ]"></asp:Label>
            </h4>
		  </asp:TableCell>
          <asp:TableCell runat="server" width="5" height="6" align="center" valign="middle">&nbsp;</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server"> 
          <asp:TableCell runat="server" height="90" colspan="3" align="center" valign="middle" background="images/middle.gif"> 
            <table width="260" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="90" height="25"><h5 class="style2">Sipariş No : </h5></td>
                <td width="169" height="25">
                  <h5 class="style2">&nbsp;<asp:Label ID="orderID" runat="server" Text="[  ]"></asp:Label></h5></td>
              </tr>
              <tr> 
                <td width="90" height="25"> <h5 class="style2">Tutar : <br/>
                  </h5></td>
                <td width="169" height="25">
                  <h5 class="style2">&nbsp;<asp:Label ID="amount" text="[  ]" runat="server"></asp:Label></h5></td>
              </tr>
              <tr> 
                <td width="90" height="25"><h5 class="style2">Hata Mesajı : </h5></td>
                <td width="169" height="25">
                  <h5 class="style2">&nbsp;<asp:Label ID="errorMessage" runat="server" Text="[  ]"></asp:Label></h5></td>
              </tr>
            </table>
          </asp:TableCell>
          <asp:TableCell runat="server" width="5" height="84" align="center" valign="middle">&nbsp;</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server"> 
          <asp:TableCell runat="server" colspan="3" align="center" valign="top" background="images/middle.gif"> 
              <table width="64%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="center" valign="middle"> <fieldset
					style="border: 1px solid #000000;">
                  <legend><font
					style="font-size:12px; color:#ff0000"> <B><font
					face="Arial, Helvetica, sans-serif">Puan Bilgileri</font></B></font> 
                  </legend>
                  <table width="348" height="79" border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td width="224" height="30"> <h5 class="style2">Kullanılabilir Toplam Puan 
                          : </h5></td>
                      <td width="124" height="30"> <h5 class="style2">&nbsp;<asp:Label ID="totalPoint" runat="server" Text="[  ]"></asp:Label></h5></td>
                    </tr>
                    <tr> 
                      <td width="224" height="30"> <h5 class="style2"> Kullanılabilir Toplam 
                          Puan Tutarı : <br/>
                        </h5></td>
                      <td width="124" height="30"> <h5 class="style2">&nbsp;<asp:Label ID="totalPointAmount" runat="server" Text="[  ]"></asp:Label></h5></td>
                    </tr>
                    <tr> 
                      <td height="30"> <h5 class="style2">Kullanılmak istenen Puan Tutarı : </h5></td>
                      <td height="30"> 
                        <h5 class="style2">
                          <asp:TextBox name="WPAmount" type="text" ID="WPAmount" size="8" maxlength="10" class="kutuTutar" onkeypress="return tutarKutuBicimle(this, event);" onkeydown="return tutarKutuBicimleSilme(this, event);" value="" runat="server"></asp:TextBox>
                          &nbsp;
                          <asp:Label ID="currencyCode" runat="server" Text="[  ]"></asp:Label>
                        </h5>
                      </td>
                    </tr>
                  </table>
                 </fieldset>
				 </td>
              </tr>
            </table>
          </asp:TableCell>
          <asp:TableCell runat="server" width="5" height="105" align="center" valign="middle">&nbsp;</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
          <asp:TableCell runat="server" colspan="3" align="center" valign="middle" background="images/middle.gif"> 
            <table width="64%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="center" valign="middle"> <fieldset
					style="border: 1px solid #000000;">
                  <legend><font
					style="font-size:12px; color:#ff0000"> <B><font
					face="Arial, Helvetica, sans-serif">3D-Secure Bilgileri</font></B></font> 
                  </legend>
                  <table width="348" border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td width="100" height="25"><h5 class="style2">Onay Statüsü : </h5></td>
                      <td width="248" height="25"><h5 class="style2">&nbsp;<asp:Label ID="tdsStatus" runat="server" Text="[  ]"></asp:Label></h5></td>
                    </tr>
                    <tr> 
                      <td width="100" height="25"> <h5 class="style2">Hata Kodu : <br/>
                        </h5></td>
                      <td width="248" height="25"><h5 class="style2">&nbsp;<asp:Label ID="tdsErrorCode" runat="server" Text="[  ]"></asp:Label></h5></td>
                    </tr>
                    <tr> 
                      <td width="100" height="25"><h5 class="style2">Hata Mesajı :</h5></td>
                      <td width="248" height="25"><h5 class="style2">&nbsp;<asp:Label ID="tdsErrorMessage" runat="server" Text="[  ]"></asp:Label></h5></td>
                    </tr>
                  </table>
                  </fieldset></td>
              </tr>
            </table>
          </asp:TableCell>
          <asp:TableCell runat="server" width="5" height="135" align="center" valign="middle">&nbsp;</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server"> 
          <asp:TableCell runat="server" height="38" colspan="3" align="center" valign="bottom" background="images/middle.gif"> 
            <asp:ImageButton ID="imageField" runat="server" 
                  Height="20" Width="67" BorderWidth="0px" 
                  ImageUrl="images/button_onayla.gif"/>
              &nbsp;
              <a href="<%=posnettds_config.MERCHANT_INIT_URL%>"> <img src="images/button_iptal.gif" width="67" height="20" border="0"/> 
            </a> 
          </asp:TableCell>
          <asp:TableCell runat="server" width="5" height="38" align="center" valign="middle">&nbsp;</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server"> 
          <asp:TableCell runat="server" height="43" align="center" valign="middle" background="images/bottom_left.gif">&nbsp;</asp:TableCell>
          <asp:TableCell runat="server" height="43" align="center" valign="middle" background="images/bottom_middle.gif">&nbsp;</asp:TableCell>
          <asp:TableCell runat="server" height="43" align="center" valign="middle" background="images/bottom_right.gif">&nbsp;</asp:TableCell>
          <asp:TableCell runat="server" width="5" height="43" align="center" valign="middle">&nbsp;</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server"> 
          <asp:TableCell runat="server" height="35" colspan="3" align="center" valign="middle"><img src="images/ykblogo.gif" width="115" height="17"></asp:TableCell>
          <asp:TableCell runat="server" width="5" align="center" valign="middle">&nbsp;</asp:TableCell>
        </asp:TableRow>
    </asp:Table>
</center>
</form>
</body>
</html>
