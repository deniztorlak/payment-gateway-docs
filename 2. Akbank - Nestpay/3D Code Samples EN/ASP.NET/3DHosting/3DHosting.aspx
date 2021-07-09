<%@ page language="C#" autoeventwireup="true" inherits="_3DHosting, App_Web_fr4klrwv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>3D Hosting</title>
</head>
<body>
<%
    
	/*
		Below there are values that must be set for 3D and auth and payment processes. There are some optional values as well.	
		Some values are set for testing purposes.
		Hidden form field names are fixed and should not change.
		This code sample is used for EST 3D PAY HOSTING model.
		 Merchant must change field values according to his own actual valeus, for instance merchant id, username, password must be set  with values that bank gave.
	*/

	/*
		Mandatory variables that merchant must provide to start valid transaction
		--- START ---
	 */
	
	String clientId = "520040000";	// Merchant ID
	String amount = "9.95";      	// Total Amount
	String oid = "";				// Order Number, may be produced by some sort of code and set here, if it doesn't exist gateway produces it and returns
	String okUrl = "http://<sunucu_adresi>/3DHostingPaymentPage.aspx";		// return page ( hosted at merchant's server ) when process finished successfully, process means 3D authentication and payment after 3D auth
	String failUrl = "http://<sunucu_adresi>/3DHostingPaymentPage.aspx";	// return page ( hosted at merchant's server ) when process finished UNsuccessfully, process means 3D authentication and payment after 3D auth
	String rnd = DateTime.Now.ToString();	// Random Value
	
	String taksit = "";	// Installment (  how many installments will be for this sale )
	String islemtipi = "Auth";	// Transacation Type 
	
	/*
		There are seven type of transactions : Auth, Void, Credit, PreAuth, PostAuth, OrderStatus, OrderHistory
		A unique transastion id returns after each transaction, it is used for reference purposes for some sort of transactions, explained below.
		Auth : Sale
		Void : Canceling sale, it must be done in same day that sale was done.  Sale's order id must be provided.
		Credit : Canceling sale and refunding provisioned amount  during sale process.  It can be done after settlement. Transaction id must be provided.
		PreAuth : Pre Authorization, it starts a sale request but it doesn't end process.
		PostAuth : Post Authorization, it ends sale process started before by Pre Authorization, transaction id must be provided.
		OrderStatus : Reporting request for order's status.
		OrderHistory : Reporting request for order's history.	
	*/
		
	String storekey="12345BKT";	//  Merchant's store key, it must be produced using merchant reporting interface and set here.
	String hashstr = clientId + oid + amount + okUrl + failUrl + islemtipi + taksit + rnd + storekey; // hash string 
	System.Security.Cryptography.SHA1 sha = new System.Security.Cryptography.SHA1CryptoServiceProvider();
	byte[] hashbytes = System.Text.Encoding.GetEncoding("ISO-8859-9").GetBytes(hashstr);
	byte[] inputbytes = sha.ComputeHash(hashbytes);
	
	String hash = Convert.ToBase64String(inputbytes); // hash value
		
	/*
		Mandatory variables that merchant must provide to start valid transaction
		--- END ---
	*/
			
%>
    <center>
			<form method="post" action="https://entegrasyon.asseco-see.com.tr/fim/est3Dgate">
                <input type="hidden" name="clientid" value="<%=clientId%>">
                <input type="hidden" name="amount" value="<%=amount%>">

                <input type="hidden" name="oid" value="<%=oid%>">	
                <input type="hidden" name="okUrl" value="<%=okUrl%>" >
                <input type="hidden" name="failUrl" value="<%=failUrl%>" >
                <input type="hidden" name="islemtipi" value="<%=islemtipi%>" >
                <input type="hidden" name="taksit" value="<%=taksit%>">
                <input type="hidden" name="rnd" value="<%=rnd%>" >
                <input type="hidden" name="hash" value="<%=hash%>" >
	
                <input type="hidden" name="storetype" value="3d_hosting" >
	
                <input type="hidden" name="refreshtime" value="10" >
				 <input type="hidden" name="currency" value="008" >
                <input type="hidden" name="lang" value="tr">
                <input type="hidden" name="firmaadi" value="Benim Firmam">
	
                <input type="hidden" name="Fismi" value="is">
                <input type="hidden" name="faturaFirma" value="faturaFirma">
                <input type="hidden" name="Fadres" value="XXX">
                <input type="hidden" name="Fadres2" value="XXX">
                <input type="hidden" name="Fil" value="XXX">

                <input type="hidden" name="Filce" value="XXX">
                <input type="hidden" name="Fpostakodu" value="postakod93013">
                <input type="hidden" name="tel" value="XXX">
                <input type="hidden" name="fulkekod" value="tr">

                <input type="hidden" name="nakliyeFirma" value="na fi">
                <input type="hidden" name="tismi" value="XXX">
                <input type="hidden" name="tadres" value="XXX">
                <input type="hidden" name="tadres2" value="XXX">

                <input type="hidden" name="til" value="XXX">
                <input type="hidden" name="tilce" value="XXX">
                <input type="hidden" name="tpostakodu" value="ttt postakod93013">
                <input type="hidden" name="tulkekod" value="usa">
	
                <input type="hidden" name="itemnumber1" value="a1">
                <input type="hidden" name="productcode1" value="a2">
                <input type="hidden" name="qty1" value="3">
                <input type="hidden" name="desc1" value="a4 desc">
                <input type="hidden" name="id1" value="a5">

                <input type="hidden" name="price1" value="6.25">
                <input type="hidden" name="total1" value="7.50">
                
                <input type="submit" value="Devam" />
                
            </form>
            
            <b>Hidden Form Fields Used in Form</b>
            <br>
                
                &lt;input type="hidden" name="clientid" value=""&gt;<br>
                &lt;input type="hidden" name="amount" value=""&gt;<br>

                &lt;input type="hidden" name="oid" value="hla56bu"&gt;	<br>
                &lt;input type="hidden" name="okUrl" value="" &gt;<br>
                &lt;input type="hidden" name="failUrl" value="" &gt;<br>
                &lt;input type="hidden" name="islemtipi" value="" &gt;<br>
                &lt;input type="hidden" name="taksit" value=""&gt;<br>
                &lt;input type="hidden" name="rnd" value="" &gt;<br>
                &lt;input type="hidden" name="hash" value="" &gt;<br>
	
                &lt;input type="hidden" name="storetype" value="3d_pay_hosting" &gt;<br>
	
                &lt;input type="hidden" name="refreshtime" value="" &gt;<br>
		
                &lt;input type="hidden" name="lang" value=""&gt;<br>
                &lt;input type="hidden" name="firmaadi" value=""&gt;<br>
	
                &lt;input type="hidden" name="Fismi" value=""&gt;<br>
                &lt;input type="hidden" name="faturaFirma" value=""&gt;<br>
                &lt;input type="hidden" name="Fadres" value=""&gt;<br>
                &lt;input type="hidden" name="Fadres2" value=""&gt;<br>
                &lt;input type="hidden" name="Fil" value=""&gt;<br>

                &lt;input type="hidden" name="Filce" value=""&gt;<br>
                &lt;input type="hidden" name="Fpostakodu" value=""&gt;<br>
                &lt;input type="hidden" name="tel" value=""&gt;<br>
                &lt;input type="hidden" name="fulkekod" value=""&gt;<br>

                &lt;input type="hidden" name="nakliyeFirma" value=""&gt;<br>
                &lt;input type="hidden" name="tismi" value=""&gt;<br>
                &lt;input type="hidden" name="tadres" value=""&gt;<br>
                &lt;input type="hidden" name="tadres2" value=""&gt;<br>

                &lt;input type="hidden" name="til" value=""&gt;<br>
                &lt;input type="hidden" name="tilce" value=""&gt;<br>
                &lt;input type="hidden" name="tpostakodu" value=""&gt;<br>
                &lt;input type="hidden" name="tulkekod" value=""&gt;<br>
	
                &lt;input type="hidden" name="itemnumber1" value=""&gt;<br>
                &lt;input type="hidden" name="productcode1" value=""&gt;<br>
                &lt;input type="hidden" name="qty1" value=""&gt;<br>
                &lt;input type="hidden" name="desc1" value=""&gt;<br>
                &lt;input type="hidden" name="id1" value=""&gt;<br>

                &lt;input type="hidden" name="price1" value=""&gt;<br>
                &lt;input type="hidden" name="total1" value=""&gt;<br>
            
        </center>
		
		<center>
		Hidden Field Details<BR>
		
			<table border="1" bordercolor="#FF9900" style="background-color:#FFFFFF" cellpadding="1" cellspacing="0">

				<tr>
					<td align=center><b>Form Field Name ( Fixed )</b></td>
					<td align=center><b>Description</b></td>
				</tr>				
				<tr>
					<td>clientId</td>
					<td>Merchant ID</td>
				</tr>
				<tr>
					<td>amount</td>
					<td>Total amount ( shopping total, checkout total )</td>
				</tr>
				<tr>
					<td>oid</td>
					<td>Order Number, may be produced by some sort of code and set, if it doesn't exist, gateway produces it and returns.</td>
				</tr>
				<tr>
					<td>okUrl</td>
					<td>Return page ( hosted at merchant's server ) when process finished successfully, process means 3D authentication and payment after 3D auth</td>
				</tr>
				
				<tr>
					<td>failUrl</td>
					<td>Return page ( hosted at merchant's server ) when process finished UNsuccessfully, process means 3D authentication and payment after 3D auth</td>
				</tr>
				<tr>
					<td>islemtipi</td>
					<td>Transaction Type ( Auth, Void, Credit, PreAuth, PostAuth, OrderStatus, OrderHistory )</td>
				</tr>
				<tr>
					<td>taksit</td>
					<td>Installment Count ( how many installments will be for this sale ) </td>
				</tr>
				<tr>
					<td>rnd</td>
					<td>Random Value</td>
				</tr>
				<tr>
					<td>hash</td>
					<td>Hash Value</td>
				</tr>
				<tr>
					<td>storetype</td>
					<td>Store Type ( 3D -> 3d, 3D Pay -> 3d_pay, 3D Pay Hosting -> 3d_pay_hosting )</td>
				</tr>
				<tr>
					<td>refreshtime</td>
					<td>Page Auto Refresh Time</td>
				</tr>
				<tr>
					<td>lang</td>
					<td>Page Language That User See, for Turkish tr, for Romanian ro, for English en</td>
				</tr>
				<tr>
					<td>firmaadi</td>
					<td>Company Name</td>
				</tr>
				<tr>
					<td>Fismi</td>
					<td>Company Name ( To Be Used for Billing ) </td>
				</tr>
				<tr>
					<td>faturaFirma</td>
					<td>Company Name That Bill Will Be Sent</td>
				</tr>
				<tr>
					<td>Fadres</td>
					<td>Billing Address</td>
				</tr>
				<tr>
					<td>Fadres2</td>
					<td>Billing Address 2</td>
				</tr>
				<tr>
					<td>Fil</td>
					<td>Billing Address - City</td>
				</tr>
				<tr>
					<td>Filce</td>
					<td>Billing Address - Town</td>
				</tr>				
				<tr>
					<td>Fpostakodu</td>
					<td>Billing Address - Post Code</td>
				</tr>
				<tr>
					<td>tel</td>
					<td>Telephone</td>
				</tr>
				<tr>
					<td>fulkekod</td>
					<td>Billing Address - Country Code</td>
				</tr>
				<tr>
					<td>nakliyeFirma</td>
					<td>Shipping Address - Company Name</td>
				</tr>
				<tr>
					<td>tismi</td>
					<td>Company Name For Shipment</td>
				</tr>
				<tr>
					<td>tadres</td>
					<td>Shipment Address</td>
				</tr>
				<tr>
					<td>tadres2</td>
					<td>Shipment Address 2</td>
				</tr>
				<tr>
					<td>til</td>
					<td>Shipment Address - City</td>
				</tr>
				<tr>
					<td>tilce</td>
					<td>Shipment Address - Town</td>
				</tr>
				
				<tr>
					<td>tpostakodu</td>
					<td>Shipping Address - Postal Code</td>
				</tr>
				<tr>
					<td>tulkekod</td>
					<td>Shipping Address - Country Code</td>
				</tr>				
				<tr>
					<td>itemnumber1</td>
					<td>Item Number 1, item number for corresponding item on shopping list / basket, incremental, for second item itemnumber2..</td>
				</tr>
				<tr>
					<td>productcode1</td>
					<td>Product Code 1, product number for corresponding item</td>
				</tr>
				<tr>
					<td>qty1</td>
					<td>Quantity for corresponding product, for instance three iPhone, two mouse, four cooking book etc.. incremental</td>
				</tr>
				<tr>
					<td>desc1</td>
					<td>Description for corresponding product, incremental</td>
				</tr>
				<tr>
					<td>id1</td>
					<td>ID for corresponding product, incremental</td>
				</tr>
				<tr>
					<td>price1</td>
					<td>Price for corresponding product, incremental</td>
				</tr>
				<tr>
					<td>total1, incremental</td>
					<td>Total for corresponding product group, for instance three iPhone from 400USD, 1200USD</td>
				</tr>										
			</table>
			
		</center>
		
</body>
</html>
