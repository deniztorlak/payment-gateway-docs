package com.ykb.posnet.merchant.sample.xml;

/**
 * Sample Posnet XML Service client which provides methods
 * to parse Posnet XML service responses.
 * 
 * <p>It also provides a main method, therefore it is runnable.
 * For the sake of simplicity, its main method takes
 * an xml file to send to posnet system as a command line
 * argument. It does not deal with constructing xml request.
 * It then contacts Posnet XML Service
 * and sends the xml file. It finally receives and parses
 * the response.
 */
public class ResponseParser {

	/**
	 * This sample program does
	 * <li>Read xml content from a file
	 * <li>Send xml content to server and receive the response
	 * <li>Parse and print response
	 */
	public static void main(String[] args) {
		try{
			//check parameters:
			if (args.length != 2) {
				//printUsage:
				System.err.println("Usage: java ResponseParser <xml_server> <xml_file>");
				System.exit(1);
			}
			String serverAddress	= args[0];
			String xmlFileName		= args[1];
			
			//Read xml content from a file
			String xmlContent = "";
			java.io.FileReader in = new java.io.FileReader(xmlFileName);
			int c;
			while ((c = in.read()) != -1)
				xmlContent += (char)c;
			System.out.println("XML Content to send:\n"+xmlContent);
			
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
	 * This method sends xml content to posnet system and returns
	 * the response of posnet system. It is also used by other samples in this package.
	 * 
	 * @param String serverAddress
	 * 		Address of server, together with virtual path. 
	 * 		E.g. http://setmpos.ykb.com/PosnetWebService/XML
	 * @param String xmlContent
	 * 		XML to send.
	 */
	public static String sendToPosnet(String serverAddress, String xmlContent)
	throws Exception{
		String urlToSend	//url where xml will be sent
			= serverAddress+"?xmldata="
			+ java.net.URLEncoder.encode(xmlContent,"UTF-8");
			
		java.net.URL url = new java.net.URL(urlToSend);
		java.net.URLConnection conn = url.openConnection();
		
		//receive response:
		xmlContent = "";	//same string is used to store response
		java.io.InputStream input = conn.getInputStream();
		int ch;
		while ((ch = input.read()) != -1)
			xmlContent += (char) ch;
			
		return xmlContent;
	}

	/**
	 * This method parses xml response of posnet system and returns
	 * a readable string. It is also used by other samples in this package.
	 */
	public static String parsePosnetXMLResponse(String xmlContent)
	throws Exception{
		String result = "";
		
		javax.xml.parsers.DocumentBuilder parser
			= javax.xml.parsers.DocumentBuilderFactory.newInstance().newDocumentBuilder();
		org.w3c.dom.Document doc = parser.parse(
			new org.xml.sax.InputSource(new java.io.StringReader(xmlContent)));
		
		//approved?
		if (valueOf(doc, "approved") == null
			|| !valueOf(doc, "approved").equals("1")){
			//NO! Not approved:
			result += "Not approved!\n";
			
			//print error code and message:
			//NOTE: These values should actually be saved
			//and reported to YKB if you can not understand 
			//the reason of error.
			result += "respCode: "
				+valueOf(doc, "respCode")+"\n";
			result += "respTest: "
				+valueOf(doc, "respText")+"\n";
			
			return result;
		}
		result += "Approved.\n";
		
		//print appropriate data:
		result += "Hostlogkey: "
			+valueOf(doc, "hostlogkey")+"\n";
			
		return result;
	}

	/**
	 * This method returns the value of the specified element
	 * in the specified document. It makes code more readable.
	 * It simply lets its user replace code 
	 * <code>doc.getElementsByTagName(element).item(0).getFirstChild().getNodeValue()</code>
	 * with
	 * <code>ResponseParser.valueOf(doc, element)</code>
	 * and prevents NullPointerException when the element is not found.
	 */
	protected static String valueOf(org.w3c.dom.Document doc, String element){
		org.w3c.dom.NodeList list = doc.getElementsByTagName(element);
		if (list == null)
			return null;
			
		org.w3c.dom.Node elem = list.item(0);
		if (elem == null)
			return null;
			
		elem = elem.getFirstChild();
		if (elem == null)
			return null;
		return elem.getNodeValue();
	}
}

