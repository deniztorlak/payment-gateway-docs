<%@ Page Language="VB" AutoEventWireup="false" CodeFile="aspxsample.aspx.vb" Inherits="_Aspxsample" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Posnet Integration for ASP.Net</title>
    <style type="text/css">
        #form1
        {
            height: 135px;
        }
            .style1
            {
            width: 75px;
        }
        .style2
        {
            width: 226px;
        }
        .style3
        {
            width: 172px;
            font-size: xx-small;
        }
        .style4
        {
            width: 113px;
        }
        .style11
        {
            height: 11px;
        }
        .style12
        {
            width: 172px;
            height: 11px;
            font-size: xx-small;
        }
        .style13
        {
            width: 113px;
            height: 11px;
        }
        .style14
        {
            height: 34px;
        }
        .style15
        {
            width: 172px;
            height: 34px;
            font-size: xx-small;
        }
        .style16
        {
            width: 113px;
            height: 34px;
        }
        .style17
        {
            height: 203px;
        }
        .style18
        {
            font-size: xx-small;
        }
        .style22
        {
            height: 36px;
        }
        .style23
        {
            height: 31px;
        }
        .style26
        {
            width: 670px;
            height: 101px;
        }
        .style27
        {
            color: #CC0000;
            font-weight: bold;
        }
        .style28
        {
            height: 26px;
        }
        .style29
        {
            width: 172px;
            height: 26px;
            font-size: xx-small;
        }
        .style30
        {
            width: 113px;
            height: 26px;
        }
        .style31
        {
            height: 26px;
            font-size: xx-small;
        }
        .style37
        {
            height: 28px;
        }
        .style38
        {
            width: 172px;
            height: 28px;
            font-size: xx-small;
        }
        .style39
        {
            height: 28px;
            font-size: xx-small;
        }
        .style41
        {
            width: 113px;
            height: 28px;
        }
        </style>
</head>
<script language=javascript type = "text/javascript">
function findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}
function OrderIDHesapla(){
	var simdi = new Date();
	var yil = new String(simdi.getFullYear());
	yil = yil.slice(2, 4);
	var ay = new String(simdi.getMonth()+1);
	if (ay.length == 1) ay = "0"+ay;
	var gun = new String(simdi.getDate());
	if (gun.length == 1) gun = "0"+gun;
	var sa = new String(simdi.getHours());
	if (sa.length == 1) sa = "0"+sa;
	var dk = new String(simdi.getMinutes());
	if (dk.length == 1) dk = "0"+dk;
	var sn = new String(simdi.getSeconds());
	if (sn.length == 1) sn = "0"+sn;
	
	findObj("orderid").value = "YKBTEST_0000"
		+yil+ay+gun+sa+dk+sn;
}
</script>
<body onload="OrderIDHesapla()">
    <form id="myForm" runat="server">
  <p align="center"><font color="#0066ff" size="6">Posnet Integration for ASP.Net</font></p>
  <table width="669" border="0" align="center" 
      style="font-family: Arial, Helvetica, sans-serif; font-size: small;">
    <tr> 
      <td colspan="2" class="style22"><font color="#0066ff" size="5">Connection Parameters :</font></td>
    </tr>
    <tr> 
      <td height="22" class="style1"> HostName : </td>
      <td height="22" class="style2"> 
          <asp:TextBox ID="HostURL" runat="server" Width="327px">http://kaan_oztemir_xp:7070/PosnetWebService/XML</asp:TextBox>
        </td>
    </tr>
    <tr> 
      <td height="22" class="style1">Mid :</td>
      <td height="22" valign="top" class="style2">
          <asp:TextBox ID="MerchantID" runat="server" Width="81px">6707780182</asp:TextBox>
        </td>
    </tr>
    <tr> 
      <td height="30" valign="top" class="style1">Tid :</td>
      <td height="30" valign="top" class="style2"> 
          <asp:TextBox ID="TerminalID" runat="server" Width="66px">67778470</asp:TextBox>
        </td>
    </tr>
    </table>

  &nbsp;
  <table width="670" border="0" align="center" class="style17" 
      style="font-family: Arial, Helvetica, sans-serif; font-size: small;">
    <tr> 
      <td colspan="4" width="635" class="style23"> <p><font color="#0066ff" size="5">Transaction 
          Inputs :</font></p></td>
    </tr>
    <tr> 
      <td width="128" class="style37">CCNo : </td>
      <td class="style38"> 
          <asp:TextBox ID="ccno" runat="server" Width="123px">4912065000104101</asp:TextBox>
&nbsp;</td>
      <td class="style41">Order ID : </td>
      <td width="208" class="style39"> 
          <asp:TextBox ID="orderid" runat="server" Width="207px"></asp:TextBox>
              </td>
    </tr>
    <tr> 
      <td width="128" class="style37"> Exp Date (YYMM) : </td>
      <td class="style38"> 
          <asp:TextBox ID="expdate" runat="server" Width="40px">0912</asp:TextBox>
&nbsp;</td>
      <td class="style41"> Hostlogkey :</td>
      <td class="style39">  
          <asp:TextBox ID="hostlogkey" runat="server" Width="154px"></asp:TextBox>
              </td>
    </tr>
    <tr> 
      <td width="128" class="style37">CVC : </td>
      <td class="style38"> 
          <asp:TextBox ID="cvc" runat="server" Width="31px">XXX</asp:TextBox>
&nbsp;</td>
      <td class="style37">AuthCode :</td>
      <td class="style39">  
          <asp:TextBox ID="authcode" runat="server" Width="60px"></asp:TextBox>
              </td>
    </tr>
    <tr> 
      <td width="128" class="style11">Amount : </td>
      <td class="style12"> 
          <asp:TextBox ID="amount" runat="server" Width="81px">1500</asp:TextBox>
          <span lang="en-us">&nbsp;<br />
          <span class="style27">(13,7 YTL icin 1370 yaziniz)</span></span></td>
      <td class="style13">VFT Code :</td>
      <td class="style18">  
          <asp:TextBox ID="vftcode" runat="server" Width="41px">K001</asp:TextBox>
              </td>
    </tr>
    <tr> 
      <td width="128" class="style28">Inst. Number :</td>
      <td class="style29"> 
          <asp:TextBox ID="instNumber" runat="server" Width="26px">00</asp:TextBox>
        </td>
      <td class="style30">KOI Code :</td>
      <td class="style31">
          <asp:DropDownList ID="koicode" runat="server">
              <asp:ListItem Selected="True"></asp:ListItem>
              <asp:ListItem Value="1">1 - Ek Taksit</asp:ListItem>
              <asp:ListItem Value="2">2 - Taksit Atlatma</asp:ListItem>
              <asp:ListItem Value="3">3 - Ekstra Puan</asp:ListItem>
              <asp:ListItem Value="4">4 - Kontur Kazanım</asp:ListItem>
              <asp:ListItem Value="5">5 - Ekstre Erteleme</asp:ListItem>
              <asp:ListItem Value="6">6 - Özel Vade Farkı</asp:ListItem>
          </asp:DropDownList>
              </td>
    </tr>
    <tr> 
      <td width="128" class="style14">Tran. Type :</td>
      <td class="style15"> 
          <asp:DropDownList ID="trantype" runat="server">
              <asp:ListItem Value="Authorization">Provizyon</asp:ListItem>
              <asp:ListItem Value="AuthRev">Provizyon İptal</asp:ListItem>
              <asp:ListItem Value="Capture">Finansallaştırma</asp:ListItem>
              <asp:ListItem Value="Capture Rev">Finansallaştırma İptal</asp:ListItem>
              <asp:ListItem Value="Sale" Selected="True">Satış</asp:ListItem>
              <asp:ListItem Value="Sale Rev">Satış İptal</asp:ListItem>
              <asp:ListItem Value="Return">İade</asp:ListItem>
              <asp:ListItem Value="Return Rev">İade İptal</asp:ListItem>
              <asp:ListItem Value="Point Inquiry">Puan Sorgulama</asp:ListItem>
              <asp:ListItem Value="Point Usage">Puan Kullanım</asp:ListItem>
              <asp:ListItem Value="Point Reverse">Puan Kullanım İptal</asp:ListItem>
              <asp:ListItem Value="VFT Inquiry">VFT Sorgulama</asp:ListItem>
              <asp:ListItem Value="VFT Sale">VFT Satis</asp:ListItem>
              <asp:ListItem Value="VFT Sale Rev">VFT Iptal</asp:ListItem>
              <asp:ListItem Value="KOI Inquiry">Joker Vadaa Sorgulama</asp:ListItem>
          </asp:DropDownList>
              </td>
      <td class="style16"></td>
      <td class="style14"></td>
    </tr>
    <tr> 
      <td width="128" height="29">Currency Code : </td>
      <td height="29" class="style3"> 
          <asp:TextBox ID="currencyCode" runat="server" Width="26px">YT</asp:TextBox>
          <br />
          <span lang="en-us"><span class="style27">(YT, US, EU)</span></span></td>
      <td height="29" class="style4">&nbsp;</td>
      <td height="29">&nbsp;</td>
    </tr>
  </table>
  <p align="center">
      <asp:Button ID="Submit" runat="server" Text="Submit" />
  </p>
  <table border="0" align="center" class="style26" 
          style="font-family: Arial, Helvetica, sans-serif; font-size: small;" 
          width="670">
    <tr> 
      <td class="style22"><font color="#0066ff" size="5"><span lang="en-us">Transaction Result</span> :</font></t :</font></td>
    </tr>
    <tr> 
        <td height="22"> 
            <asp:TextBox ID="EventView" runat="server" Font-Names="helvetica" 
                Height="175px" TextMode="MultiLine" Width="664px"></asp:TextBox>
        </td>
    </tr>
    </table>
    </form>
</body>
</html>
