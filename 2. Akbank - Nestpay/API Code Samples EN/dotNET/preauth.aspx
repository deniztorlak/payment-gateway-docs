<%@ Page Language="VB" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<script language="VB" runat="server">
	Sub Page_Load(Sender As Object, E As EventArgs)
            dim mycc5pay as new ePayment.cc5payment()

			mycc5pay.host="https://TEST_SERVER_INFO"
			mycc5pay.name="TEST_NAME"
			mycc5pay.password="1111111"
			mycc5pay.clientid="80030"
			mycc5pay.orderresult="0"

			mycc5pay.oid="dotnettest0001"
			mycc5pay.cardnumber = "4242424242424242"
			mycc5pay.expmonth = "10"
			mycc5pay.expyear = "09"
			mycc5pay.cv2 = "005"
			mycc5pay.subtotal = 4444
			mycc5pay.currency = 949
			mycc5pay.chargetype = "PreAuth"
			
			'mycc5pay.taksit = "5"
			
			'mycc5pay.addpborder("0","12","W","3")
				

			
			'mycc5pay.additem("0","0mall","12000","3","123","4444","36000")
			'mycc5pay.additem("1","1mall","12000","3","123","4444","36000")
			'mycc5pay.additem("2","2mall","12000","3","123","4444","36000")
			'mycc5pay.additem("3","3mall","12000","3","123","4444","36000")
			'mycc5pay.additem("4","4mall","12000","3","123","4444","36000")
			
			'mycc5pay.bname = "BillToName"
			'mycc5pay.baddr1 = "baddr1"
			'mycc5pay.baddr2 = "baddr2"
			'mycc5pay.baddr3 = "baddr3"
			'mycc5pay.bcity = "bcity"
			'mycc5pay.bcompany = "EST"
			'mycc5pay.phone = "phone"
			'mycc5pay.fax = "fax"
			
			'mycc5pay.sname = "ShipToName"
			'mycc5pay.saddr1 = "saddr1"
			'mycc5pay.saddr2 = "saddr2"
			'mycc5pay.saddr3 = "saddr3"
			'mycc5pay.scity = "scity"
									
			mycc5pay.putextra("EXTRA1","VALUE1")
			
			Result1.Text= mycc5pay.processorder()
			
			Procreturncode.Text = mycc5pay.procreturncode
			ErrMsg.Text=mycc5pay.errmsg
			Oid1.Text = mycc5pay.oid
			GroupId.Text = mycc5pay.groupid
			appr1.Text = mycc5pay.appr
			refno.Text = mycc5pay.refno
			transid.Text = mycc5pay.transid
			Extra.Text = mycc5pay.Extra("HOSTMSG")
		
			Mesaj.Text = "TRANSACTION RESULT"
			
			if Result1.Text = "1" and appr1.Text = "Approved" then
				Mesaj.Text="THE TRANSACTION IS SENT SUCCESSFULLY AND APPROVED !!!"
			else if Result1.Text = "1" and appr1.Text = "Declined" then
				Mesaj.Text="THE TRANSACTION IS SENT SUCCESSFULLY BUT DECLINED !!!"
			else if Result1.Text = "1" and appr1.Text = "Error" then
				Mesaj.Text="THE TRANSACTION IS SENT SUCCESSFULLY BUT ERROR OCCURED !!!"
			else if Result1.Text = "1" and Procreturncode.Text <> "00" then
				Mesaj.Text="THE TRANSACTION IS SENT SUCCESSFULLY BUT NOT APPROVED !!!"
			else  if Result1.Text = "0" then
				Mesaj.Text="TRANSACTION IS NOT SENT, CONNECTION ERROR WITH THE BANK !!!"
			end if
			
        End Sub
</script>


<HTML>
	<HEAD>
		<title>Pre Authorization(Preauth) Example Page</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			
			<asp:Label id="Label1" style="Z-INDEX: 101; LEFT: 50px; POSITION: absolute; TOP: 40px" runat="server"
				Width="85px" Height="22px">FunctionResult</asp:Label>
			<asp:TextBox id="Result1" style="Z-INDEX: 102; LEFT: 300px; POSITION: absolute; TOP: 40px" runat="server"
				Width="511px" Height="25px"></asp:TextBox>
			
			<asp:Label id="Label2" style="Z-INDEX: 108; LEFT: 50px; POSITION: absolute; TOP: 80px" runat="server"
				Width="85px" Height="22px">procreturncode</asp:Label>
			<asp:TextBox id="Procreturncode" style="Z-INDEX: 100; LEFT: 300px; POSITION: absolute; TOP: 80px" runat="server"
				Width="511px" Height="25px"></asp:TextBox>
								
			<asp:Label id="Label3" style="Z-INDEX: 108; LEFT: 50px; POSITION: absolute; TOP: 120px" runat="server"
				Width="85px" Height="22px">ErrMsg</asp:Label>
			<asp:TextBox id="ErrMsg" style="Z-INDEX: 100; LEFT: 300px; POSITION: absolute; TOP: 120px" runat="server"
				Width="511px" Height="25px"></asp:TextBox>
				
			<asp:Label id="Label4" style="Z-INDEX: 104; LEFT: 50px; POSITION: absolute; TOP: 160px" runat="server"
				Width="85px" Height="22px">Oid</asp:Label>
			<asp:TextBox id="Oid1" style="Z-INDEX: 103; LEFT: 300px; POSITION: absolute; TOP: 160px" runat="server"
				Width="511px" Height="25px"></asp:TextBox>
				
			<asp:Label id="Label5" style="Z-INDEX: 104; LEFT: 50px; POSITION: absolute; TOP: 200px" runat="server"
				Width="85px" Height="22px">GroupId</asp:Label>
			<asp:TextBox id="GroupId" style="Z-INDEX: 103; LEFT: 300px; POSITION: absolute; TOP: 200px" runat="server"
				Width="511px" Height="25px"></asp:TextBox>
							
			<asp:Label id="Label6" style="Z-INDEX: 106; LEFT: 50px; POSITION: absolute; TOP: 240px" runat="server"
				Width="85px" Height="22px">Result</asp:Label>
			<asp:TextBox id="appr1" style="Z-INDEX: 107; LEFT: 300px; POSITION: absolute; TOP: 240px" runat="server"
				Width="511px" Height="25px"></asp:TextBox>
				
			<asp:Label id="Label7" style="Z-INDEX: 109; LEFT: 50px; POSITION: absolute; TOP: 280px" runat="server"
				Width="85px" Height="22px">refno</asp:Label>
			<asp:TextBox id="refno" style="Z-INDEX: 102; LEFT: 300px; POSITION: absolute; TOP: 280px" runat="server"
				Width="511px" Height="25px"></asp:TextBox>	

			<asp:Label id="Label8" style="Z-INDEX: 109; LEFT: 50px; POSITION: absolute; TOP: 320px" runat="server"
				Width="85px" Height="22px">transid</asp:Label>
			<asp:TextBox id="transid" style="Z-INDEX: 102; LEFT: 300px; POSITION: absolute; TOP: 320px" runat="server"
				Width="511px" Height="25px"></asp:TextBox>	
				
			<asp:Label id="Label9" style="Z-INDEX: 109; LEFT: 50px; POSITION: absolute; TOP: 360px" runat="server"
				Width="85px" Height="22px">XID</asp:Label>
			<asp:TextBox id="Extra" style="Z-INDEX: 102; LEFT: 300px; POSITION: absolute; TOP: 360px" runat="server"
				Width="511px" Height="25px"></asp:TextBox>	
			
			<asp:Label id="Label10" style="Z-INDEX: 109; LEFT: 50px; POSITION: absolute; TOP: 400px" runat="server"
				Width="85px" Height="22px">NEXTINSTALLMENTAMOUNTS</asp:Label>
			<asp:TextBox id="Extra2" style="Z-INDEX: 102; LEFT: 300px; POSITION: absolute; TOP: 400px" runat="server"
				Width="511px" Height="25px"></asp:TextBox>
			
			<asp:Label id="Label11" style="Z-INDEX: 109; LEFT: 50px; POSITION: absolute; TOP: 440px" runat="server"
				Width="85px" Height="22px">MESAJ</asp:Label>
			<asp:TextBox id="Mesaj" style="Z-INDEX: 102; LEFT: 300px; POSITION: absolute; TOP: 440px" runat="server"
				Width="511px" Height="25px"></asp:TextBox>	
		
		</form>
	</body>
</HTML>