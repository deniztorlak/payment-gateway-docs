package com.ykb.posnet.merchant.sample.xml;

import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;
import java.io.StringWriter;
import java.util.Calendar;

/**
 * This class provides methods to prepare
 * an xml string suitable to send to Posnet
 * XML service. It also provides a main method
 * which demonstrates sample usage.
 */
public class RequestMaker {
	
	/**
	 * Sample usage of this class. All transaction
	 * values are burried in the code. You should 
	 * actually receive these values from a web form.
	 */
	public static void main(String[] args) {
		try{
			//check parameters:
			if (args.length != 1) {
				//printUsage:
				System.err.println("Usage: java RequestMaker <xml_server>");
				System.exit(1);
			}
			String serverAddress	= args[0];

			//construct a sample request:
			RequestBean request = 
				//RequestBeanForSale()
				//RequestBeanForAuth()
				//RequestBeanForCapt()
				//RequestBeanForReverse(XMLConstants.POINT_USE)
				//RequestBeanForPointInquiry()
				//RequestBeanForPointUsage()
				//RequestBeanForVFTQuery()
				RequestBeanForVFTTransaction()
				;
		
			//Prepare XML content from the request bean:	
			String xmlContent 
				= RequestMaker.prepareRequestXML(request);
			System.out.println("XML content to send:\n"+xmlContent);
			
			//Send xml content to server and receive the response
			System.out.println("Sending xml content to server...");
			xmlContent = ResponseParser.sendToPosnet(serverAddress, xmlContent);
			System.out.println("XML Content received:\n"+xmlContent);
			
			//Parse and print response
			System.out.println(
				ResponseParser.parsePosnetXMLResponse(xmlContent));
		}
		catch(Throwable t){
			t.printStackTrace();
		}
	}
	
	/**
	 * Returns a sample request bean for 
	 * Sale transaction
	 */
	protected static RequestBean RequestBeanForSale(){
		RequestBean request = RequestBeanForAuth();
		request.tranType	= XMLConstants.SALE;
		
		return request;
	}
	
	/**
	 * Returns a sample request bean for 
	 * Authorization transaction
	 */
	protected static RequestBean RequestBeanForAuth(){
		RequestBean request = new RequestBean();
		request.mid		= "6700000067";
		request.tid		= "67000067";
		request.username	= "aaaaaaaa";
		request.password	= "aaaaaaaa";
		request.tranType	= XMLConstants.AUTH;
		request.ccno		= "4506349116608409";
		request.cvc			= "XXX";
		request.expDate		= "0703";
		/*Specify fields below 
		if you will make installment:
		request.installment	= "02";*/
		request.orderID		= prepareOrderID(request.tid);
		request.amount		= "2451";
		request.currencyCode	= "YT";
		/*Specify fields below 
		if you will give multiple or extra points:
		request.multiplePoint	= "";
		request.extraPoint		= "";*/
		
		return request;
	}
	
	/**
	 * Returns a sample request bean for 
	 * Capture transaction
	 */
	protected static RequestBean RequestBeanForCapt(){
		RequestBean request = new RequestBean();
		request.mid		= "6700000067";
		request.tid		= "67000067";
		request.username	= "aaaaaaaa";
		request.password	= "aaaaaaaa";
		request.tranType	= XMLConstants.CAPT;
		request.hostlogkey	= "0000000002P0502111";
		request.amount		= "2451";
		request.currencyCode	= "YT";
		/*Specify fields below 
		if you will give multiple or extra points:
		request.multiplePoint	= "";
		request.extraPoint		= "";*/
		/*Specify fields below 
		if you will make installment:
		request.installment	= "02";*/
		
		return request;
	}
	
	/**
	 * Returns a sample request bean for 
	 * Reverse transaction
	 * 
	 * @param String tranTypeToReverse
	 * 			Transaction type to reverse. See XMLConstants
	 * 			class for possible values.
	 */
	protected static RequestBean RequestBeanForReverse(String tranTypeToReverse){
		RequestBean request = new RequestBean();
		request.mid		= "6700000067";
		request.tid		= "67000067";
		request.username	= "aaaaaaaa";
		request.password	= "aaaaaaaa";
		request.tranType	= XMLConstants.REVERSE;
		request.tranTypeToReverse = tranTypeToReverse;
		request.hostlogkey	= "050211100855318258";
		request.authCode	= "005653";
		
		return request;
	}
	
	/**
	 * Returns a sample request bean for 
	 * Point Inquiry transaction
	 */
	protected static RequestBean RequestBeanForPointInquiry(){
		RequestBean request = new RequestBean();
		request.mid		= "6700000067";
		request.tid		= "67000067";
		request.username	= "aaaaaaaa";
		request.password	= "aaaaaaaa";
		request.tranType	= XMLConstants.POINT_INQ;
		request.ccno		= "4506349116649981";
		request.expDate		= "0703";
		
		return request;
	}
	
	/**
	 * Returns a sample request bean for 
	 * Point Usage transaction
	 */
	protected static RequestBean RequestBeanForPointUsage(){
		RequestBean request = new RequestBean();
		request.mid		= "6700000067";
		request.tid		= "67000067";
		request.username	= "aaaaaaaa";
		request.password	= "aaaaaaaa";
		request.tranType	= XMLConstants.POINT_USE;
		request.ccno		= "4506349116649981";
		request.expDate		= "0703";
		request.amount		= "2451";
		request.currencyCode	= "YT";
		request.orderID		= prepareOrderID(request.tid);
		
		return request;
	}
	
	/**
	 * Returns a sample request bean for 
	 * VFT Query transaction
	 */
	protected static RequestBean RequestBeanForVFTQuery(){
		RequestBean request = new RequestBean();
		request.mid		= "6700000067";
		request.tid		= "67000067";
		request.username	= "aaaaaaaa";
		request.password	= "aaaaaaaa";
		request.tranType	= XMLConstants.VFT_INQ;
		request.ccno		= "4506349116608409";
		request.installment	= "02";
		request.vftCode		= "K001";
		request.amount		= "1546";
		
		return request;
	}
	
	/**
	 * Returns a sample request bean for 
	 * VFT transaction
	 */
	protected static RequestBean RequestBeanForVFTTransaction(){
		RequestBean request = new RequestBean();
		request.mid		= "6700000067";
		request.tid		= "67000067";
		request.username	= "aaaaaaaa";
		request.password	= "aaaaaaaa";
		request.tranType	= XMLConstants.VFT_TXN;
		request.ccno		= "4506349116608409";
		request.expDate		= "0703";
		request.cvc			= "XXX";
		request.installment	= "02";
		request.vftCode		= "K001";
		request.amount		= "1546";
		request.currencyCode	= "YT";
		request.orderID		= prepareOrderID(request.tid);
		
		return request;
	}
	
	/**
	 * Returns xml request string to send to posnet system.
	 * 
	 * <p>This method adds all required fields of <code>request</code> parameter
	 * to their corresponding places in xml string to be returned. It forces you
	 * to specify all required fields in <code>request</code>. To see what fields
	 * are mandatory in which transaction, see online Posnet documentation.
	 * 
	 * @throws IOException 
	 * 				When an IO error occurs.
	 * @throws IllegalArgumentException 
	 * 				When <code>request</code> parameter does not
	 * 				specify a mandatory field.
	 */
	public static String prepareRequestXML(RequestBean request)
	throws java.io.IOException, IllegalArgumentException
	{
		org.w3c.dom.Document doc 
			= new org.apache.xerces.dom.DocumentImpl();
		org.w3c.dom.Element root
			= doc.createElement("posnetRequest");
		
		//
		//add child nodes:
		//
		org.w3c.dom.Element node;
		node = doc.createElement("mid");
		node.appendChild(doc.createTextNode(request.mid));
		root.appendChild(node);
		node = doc.createElement("tid");
		node.appendChild(doc.createTextNode(request.tid));
		root.appendChild(node);
		
		if (request.username != null && request.username.length() > 0){
			node = doc.createElement("username");
			node.appendChild(doc.createTextNode(request.username));
			root.appendChild(node);
		}
		if (request.password != null && request.password.length() > 0){
			node = doc.createElement("password");
			node.appendChild(doc.createTextNode(request.password));
			root.appendChild(node);
		}
		//
		//transaction nodes:
		org.w3c.dom.Element nodeTran = doc.createElement(request.tranType);
		//
		if (request.tranType.equals(XMLConstants.AUTH)
		||  request.tranType.equals(XMLConstants.SALE))
		{
			if (request.ccno == null || request.ccno.length() == 0)
				throw new IllegalArgumentException("Parameter not found: ccno");
			node = doc.createElement("ccno");
			node.appendChild(doc.createTextNode(request.ccno));
			nodeTran.appendChild(node);
			
			if (request.cvc == null || request.cvc.length() == 0)
				throw new IllegalArgumentException("Parameter not found: cvc");
			node = doc.createElement("cvc");
			node.appendChild(doc.createTextNode(request.cvc));
			nodeTran.appendChild(node);
	
			if (request.expDate == null || request.expDate.length() == 0)
				throw new IllegalArgumentException("Parameter not found: expDate");
			node = doc.createElement("expDate");
			node.appendChild(doc.createTextNode(request.expDate));
			nodeTran.appendChild(node);
	
			if (request.installment != null && request.installment.length() > 0){
				node = doc.createElement("installment");
				node.appendChild(doc.createTextNode(request.installment));
				nodeTran.appendChild(node);
			}
	
			if (request.orderID == null || request.orderID.length() == 0)
				throw new IllegalArgumentException("Parameter not found: orderID");
			node = doc.createElement("orderID");
			node.appendChild(doc.createTextNode(request.orderID));
			nodeTran.appendChild(node);
			
			if (request.amount == null || request.amount.length() == 0)
				throw new IllegalArgumentException("Parameter not found: amount");
			node = doc.createElement("amount");
			node.appendChild(doc.createTextNode(request.amount));
			nodeTran.appendChild(node);
	
			if (request.currencyCode == null || request.currencyCode.length() == 0)
				throw new IllegalArgumentException("Parameter not found: currencyCode");
			node = doc.createElement("currencyCode");
			node.appendChild(doc.createTextNode(request.currencyCode));
			nodeTran.appendChild(node);
	
			if (request.multiplePoint != null && request.multiplePoint.length() > 0){
				node = doc.createElement("multiplePoint");
				node.appendChild(doc.createTextNode(request.multiplePoint));
				nodeTran.appendChild(node);
			}
	
			if (request.extraPoint != null && request.extraPoint.length() > 0){
				node = doc.createElement("extraPoint");
				node.appendChild(doc.createTextNode(request.extraPoint));
				nodeTran.appendChild(node);
			}
			
			if (request.koiCode != null && request.koiCode.length() > 0){
				node = doc.createElement("koiCode");
				node.appendChild(doc.createTextNode(request.koiCode));
				nodeTran.appendChild(node);
			}
		}
		else
		if (request.tranType.equals(XMLConstants.CAPT))
		{
			if (request.hostlogkey == null || request.hostlogkey.length() == 0)
				throw new IllegalArgumentException("Parameter not found: hostLogKey");
			node = doc.createElement("hostLogKey");
			node.appendChild(doc.createTextNode(request.hostlogkey));
			nodeTran.appendChild(node);
	
			if (request.amount == null || request.amount.length() == 0)
				throw new IllegalArgumentException("Parameter not found: amount");
			node = doc.createElement("amount");
			node.appendChild(doc.createTextNode(request.amount));
			nodeTran.appendChild(node);
	
			if (request.currencyCode == null || request.currencyCode.length() == 0)
				throw new IllegalArgumentException("Parameter not found: currencyCode");
			node = doc.createElement("currencyCode");
			node.appendChild(doc.createTextNode(request.currencyCode));
			nodeTran.appendChild(node);
	
			if (request.multiplePoint != null && request.multiplePoint.length() > 0){
				node = doc.createElement("multiplePoint");
				node.appendChild(doc.createTextNode(request.multiplePoint));
				nodeTran.appendChild(node);
			}
	
			if (request.extraPoint != null && request.extraPoint.length() > 0){
				node = doc.createElement("extraPoint");
				node.appendChild(doc.createTextNode(request.extraPoint));
				nodeTran.appendChild(node);
			}
	
			if (request.installment != null && request.installment.length() > 0){
				node = doc.createElement("installment");
				node.appendChild(doc.createTextNode(request.installment));
				nodeTran.appendChild(node);
			}
		}
		else
		if (request.tranType.equals(XMLConstants.REVERSE))
		{
			if (request.tranTypeToReverse == null || request.tranTypeToReverse.length() == 0)
				throw new IllegalArgumentException("Parameter not found: transaction");
			node = doc.createElement("transaction");
			node.appendChild(doc.createTextNode(request.tranTypeToReverse));
			nodeTran.appendChild(node);
	
			if (request.authCode != null && request.authCode.length() > 0){
				node = doc.createElement("authCode");
				node.appendChild(doc.createTextNode(request.authCode));
				nodeTran.appendChild(node);
			}
			
			if (request.hostlogkey == null || request.hostlogkey.length() == 0)
				throw new IllegalArgumentException("Parameter not found: hostLogKey");
			node = doc.createElement("hostLogKey");
			node.appendChild(doc.createTextNode(request.hostlogkey));
			nodeTran.appendChild(node);
		}
		else
		if (request.tranType.equals(XMLConstants.POINT_INQ))
		{
			if (request.ccno == null || request.ccno.length() == 0)
				throw new IllegalArgumentException("Parameter not found: ccno");
			node = doc.createElement("ccno");
			node.appendChild(doc.createTextNode(request.ccno));
			nodeTran.appendChild(node);
			
			if (request.expDate == null || request.expDate.length() == 0)
				throw new IllegalArgumentException("Parameter not found: expDate");
			node = doc.createElement("expDate");
			node.appendChild(doc.createTextNode(request.expDate));
			nodeTran.appendChild(node);
		}
		else
		if (request.tranType.equals(XMLConstants.POINT_USE))
		{
			if (request.ccno == null || request.ccno.length() == 0)
				throw new IllegalArgumentException("Parameter not found: ccno");
			node = doc.createElement("ccno");
			node.appendChild(doc.createTextNode(request.ccno));
			nodeTran.appendChild(node);
			
			if (request.expDate == null || request.expDate.length() == 0)
				throw new IllegalArgumentException("Parameter not found: expDate");
			node = doc.createElement("expDate");
			node.appendChild(doc.createTextNode(request.expDate));
			nodeTran.appendChild(node);
	
			if (request.amount == null || request.amount.length() == 0)
				throw new IllegalArgumentException("Parameter not found: amount");
			node = doc.createElement("amount");
			node.appendChild(doc.createTextNode(request.amount));
			nodeTran.appendChild(node);
	
			if (request.currencyCode == null || request.currencyCode.length() == 0)
				throw new IllegalArgumentException("Parameter not found: currencyCode");
			node = doc.createElement("currencyCode");
			node.appendChild(doc.createTextNode(request.currencyCode));
			nodeTran.appendChild(node);
	
			if (request.orderID == null || request.orderID.length() == 0)
				throw new IllegalArgumentException("Parameter not found: orderID");
			node = doc.createElement("orderID");
			node.appendChild(doc.createTextNode(request.orderID));
			nodeTran.appendChild(node);
		}			
		else
		if (request.tranType.equals(XMLConstants.VFT_INQ))
		{
			if (request.ccno == null || request.ccno.length() == 0)
				throw new IllegalArgumentException("Parameter not found: ccno");
			node = doc.createElement("ccno");
			node.appendChild(doc.createTextNode(request.ccno));
			nodeTran.appendChild(node);
	
			if (request.installment == null || request.installment.length() == 0)
				throw new IllegalArgumentException("Parameter not found: installment");
			node = doc.createElement("installment");
			node.appendChild(doc.createTextNode(request.installment));
			nodeTran.appendChild(node);
	
			if (request.vftCode == null || request.vftCode.length() == 0)
				throw new IllegalArgumentException("Parameter not found: vftCode");
			node = doc.createElement("vftCode");
			node.appendChild(doc.createTextNode(request.vftCode));
			nodeTran.appendChild(node);
			
			if (request.amount == null || request.amount.length() == 0)
				throw new IllegalArgumentException("Parameter not found: amount");
			node = doc.createElement("amount");
			node.appendChild(doc.createTextNode(request.amount));
			nodeTran.appendChild(node);
		}			
		else
		if (request.tranType.equals(XMLConstants.VFT_TXN))
		{
			if (request.ccno == null || request.ccno.length() == 0)
				throw new IllegalArgumentException("Parameter not found: ccno");
			node = doc.createElement("ccno");
			node.appendChild(doc.createTextNode(request.ccno));
			nodeTran.appendChild(node);
			
			if (request.cvc == null || request.cvc.length() == 0)
				throw new IllegalArgumentException("Parameter not found: cvc");
			node = doc.createElement("cvc");
			node.appendChild(doc.createTextNode(request.cvc));
			nodeTran.appendChild(node);
	
			if (request.expDate == null || request.expDate.length() == 0)
				throw new IllegalArgumentException("Parameter not found: expDate");
			node = doc.createElement("expDate");
			node.appendChild(doc.createTextNode(request.expDate));
			nodeTran.appendChild(node);
	
			if (request.installment == null || request.installment.length() == 0)
				throw new IllegalArgumentException("Parameter not found: installment");
			node = doc.createElement("installment");
			node.appendChild(doc.createTextNode(request.installment));
			nodeTran.appendChild(node);
	
			if (request.vftCode == null || request.vftCode.length() == 0)
				throw new IllegalArgumentException("Parameter not found: vftCode");
			node = doc.createElement("vftCode");
			node.appendChild(doc.createTextNode(request.vftCode));
			nodeTran.appendChild(node);
			
			if (request.amount == null || request.amount.length() == 0)
				throw new IllegalArgumentException("Parameter not found: amount");
			node = doc.createElement("amount");
			node.appendChild(doc.createTextNode(request.amount));
			nodeTran.appendChild(node);
	
			if (request.currencyCode == null || request.currencyCode.length() == 0)
				throw new IllegalArgumentException("Parameter not found: currencyCode");
			node = doc.createElement("currencyCode");
			node.appendChild(doc.createTextNode(request.currencyCode));
			nodeTran.appendChild(node);
	
			if (request.orderID == null || request.orderID.length() == 0)
				throw new IllegalArgumentException("Parameter not found: orderID");
			node = doc.createElement("orderID");
			node.appendChild(doc.createTextNode(request.orderID));
			nodeTran.appendChild(node);
			
			if (request.koiCode != null && request.koiCode.length() > 0){
				node = doc.createElement("koiCode");
				node.appendChild(doc.createTextNode(request.koiCode));
				nodeTran.appendChild(node);
			}
		}
		else
		if (request.tranType.equals(XMLConstants.RETURN))
		{
			if (request.amount == null || request.amount.length() == 0)
				throw new IllegalArgumentException("Parameter not found: amount");
			node = doc.createElement("amount");
			node.appendChild(doc.createTextNode(request.amount));
			nodeTran.appendChild(node);
			
			if (request.currencyCode == null || request.currencyCode.length() == 0)
				throw new IllegalArgumentException("Parameter not found: currencyCode");
			node = doc.createElement("currencyCode");
			node.appendChild(doc.createTextNode(request.currencyCode));
			nodeTran.appendChild(node);
	
			if (request.hostlogkey == null || request.hostlogkey.length() == 0)
				throw new IllegalArgumentException("Parameter not found: hostLogKey");
			node = doc.createElement("hostLogKey");
			node.appendChild(doc.createTextNode(request.hostlogkey));
			nodeTran.appendChild(node);
		}
		else
		if (request.tranType.equals(XMLConstants.KOI_INQUIRY))
		{
			if (request.ccno == null || request.ccno.length() == 0)
				throw new IllegalArgumentException("Parameter not found: ccno");
			node = doc.createElement("ccno");
			node.appendChild(doc.createTextNode(request.ccno));
			nodeTran.appendChild(node);
		}
	
		root.appendChild(nodeTran);
		
		doc.appendChild(root);
		
		//convert doc to string and return:
		OutputFormat    format  = new OutputFormat( doc );   //Serialize DOM
		StringWriter  stringOut = new StringWriter();        //Writer will be a String
		XMLSerializer    serial = new XMLSerializer( stringOut, format );
		serial.asDOMSerializer();                            // As a DOM Serializer
		serial.serialize( doc.getDocumentElement() );
		return stringOut.toString();
	}
	
	/**
	 * This method returns an order id suitable to use
	 * in a posnet transaction. It returns an order id like
	 * 
	 * <p><center>
	 * <code> "prg_"+tid+2_digits_of_year+month+day+hour+minute+second</code>
	 * </center>
	 * 
	 * <p>prg_ prefix means that this transaction was made 
	 * programmatically. This is not mandatory, but is good 
	 * practice. Note that online transactions made from posnet 
	 * admin pages are given orderID's with prefix "pye_"
	 * 
	 * @param tid 
	 * 		Tid of your company. Note that in test environment,
	 * 		all firms are given a static tid: 67000067. Therefore,
	 * 		in test environment, you should use your actual (production)
	 * 		tid. If you don't know your production tid, then
	 * 		leave this as 67000067
	 */
	public static String prepareOrderID(String tid)
	{
		java.util.Calendar rightNow 
			= java.util.Calendar.getInstance();			//Total
		return "prg_"						//4 char	4
			+tid							//8 char	12
			+Integer.toString(				//2 char	14
				rightNow.get(Calendar.YEAR)
				).substring(2)
			+padString(						//2 char	16
				Integer.toString(
					rightNow.get(Calendar.MONTH)+1
					)
				,2, '0', false
				)
			+padString(						//2 char	18
				Integer.toString(
					rightNow.get(Calendar.DAY_OF_MONTH)
					)
				,2, '0', false
				)
			+padString(						//2 char	20
				Integer.toString(
					rightNow.get(Calendar.HOUR_OF_DAY)
					)
				,2, '0', false
				)
			+padString(						//2 char	22
				Integer.toString(
					rightNow.get(Calendar.MINUTE)
					)
				,2, '0', false
				)
			+padString(						//2 char	24 OK!!
				Integer.toString(
					rightNow.get(Calendar.SECOND)
					)
				,2, '0', false
				)
			;
	}
	
	/**
	 * Pads given string to given new length.
	 * Helper method.
	 * @return java.lang.String
	 * @param s java.lang.String
	 * @param newLength int
	 * @param charToPad char
	 * @param padToEnd boolean
	 */
	public static String padString(
		  String s
		, int newLength
		, char charToPad
		, boolean padToEnd) 
	{
		String don = s;
		for (int i = 0; i < newLength-s.length(); i++){
			don = (padToEnd)
				? don+charToPad
				: charToPad+don;
		}
		return don;
	}
}

