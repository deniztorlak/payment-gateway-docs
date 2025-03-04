package com.ykb.posnet.merchant.xml;

import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;
import java.io.StringWriter;
import java.util.Calendar;

/**
 * This class provides methods to prepare an xml string suitable to send to Posnet XML service. It also provides a main method which demonstrates sample usage.
 */
public class RequestMaker {

    /**
     * Sample usage of this class. All transaction values are burried in the code. You should actually receive these values from a web form.
     */
    public static void main(String[] args) {
        try {
            //check parameters:
            if (args.length != 1) {
                //printUsage:
                System.err.println("Usage: java RequestMaker <xml_server>");
                System.exit(1);
            }
            String serverAddress = args[0];

            //construct a sample request:
            RequestBean request =
            //RequestBeanForSale()
            //RequestBeanForAuth()
            //RequestBeanForCapt()
            //RequestBeanForReverse(XMLConstants.POINT_USE)
            //RequestBeanForPointInquiry()
            //RequestBeanForPointUsage()
            //RequestBeanForVFTQuery()
            //RequestBeanForVFTTransaction();
            RequestBeanForPointGainInqUsage();
                
            //Prepare XML content from the request bean:
            String xmlContent = RequestMaker.prepareRequestXML(request);
            System.out.println("XML content to send:\n" + xmlContent);

            //Send xml content to server and receive the response
            System.out.println("Sending xml content to server...");
            xmlContent = ResponseParser.sendToPosnet(serverAddress, xmlContent);
            System.out.println("XML Content received:\n" + xmlContent);

            //Parse and print response
            System.out.println(ResponseParser.parsePosnetXMLResponse(xmlContent));
        } catch (Throwable t) {
            t.printStackTrace();
        }
    }

    /**
     * Returns a sample request bean for Sale transaction
     */
    protected static RequestBean RequestBeanForSale() {
        RequestBean request = RequestBeanForAuth();
        request.setTranType(XMLConstants.SALE);

        return request;
    }

    /**
     * Returns a sample request bean for Authorization transaction
     */
    protected static RequestBean RequestBeanForAuth() {
        RequestBean request = new RequestBean();
        request.setMid("6700000067");
        request.setTid("67000067");
        request.setTranType(XMLConstants.AUTH);
        request.setCcNo("4506349116608409");
        request.setExpDate("0703");
        request.setCvc("XXX");
        /*
         * Specify fields below if you will make installment: request.installment = "02";
         */
        request.setOrderID(prepareOrderID(request.getTid()));
        request.setAmount("2451");
        request.setCurrencyCode("YT");
        /*
         * Specify fields below if you will give multiple or extra points: request.multiplePoint = ""; request.extraPoint = "";
         */

        return request;
    }

    /**
     * Returns a sample request bean for Capture transaction
     */
    protected static RequestBean RequestBeanForCapt() {
        RequestBean request = new RequestBean();
        request.setMid("6700000067");
        request.setTid("67000067");
        request.setTranType(XMLConstants.CAPT);
        request.setHostLogKey("0000000002P0502111");
        request.setAmount("2451");
        request.setCurrencyCode("YT");
        /*
         * Specify fields below if you will give multiple or extra points: request.multiplePoint = ""; request.extraPoint = "";
         */
        /*
         * Specify fields below if you will make installment: request.installment = "02";
         */

        return request;
    }

    /**
     * Returns a sample request bean for Reverse transaction
     * 
     * @param String
     *            tranTypeToReverse Transaction type to reverse. See XMLConstants class for possible values.
     */
    protected static RequestBean RequestBeanForReverse(String tranTypeToReverse) {
        RequestBean request = new RequestBean();
        request.setMid("6700000067");
        request.setTid("67000067");
        request.setTranType(XMLConstants.REVERSE);
        request.setTranTypeToReverse(tranTypeToReverse);
        request.setHostLogKey("050211100855318258");
        request.setAuthCode("005653");

        return request;
    }

    /**
     * Returns a sample request bean for Point Inquiry transaction
     */
    protected static RequestBean RequestBeanForPointInquiry() {
        RequestBean request = new RequestBean();
        request.setMid("6700000067");
        request.setTid("67000067");
        request.setTranType(XMLConstants.POINT_INQ);
        request.setCcNo("4506349116649981");
        request.setExpDate("0703");

        return request;
    }

    /**
     * Returns a sample request bean for Point Usage transaction
     */
    protected static RequestBean RequestBeanForPointUsage() {
        RequestBean request = new RequestBean();
        request.setMid("6700000067");
        request.setTid("67000067");
        request.setTranType(XMLConstants.POINT_USE);
        request.setCcNo("4506349116649981");
        request.setExpDate("0703");
        request.setAmount("2451");
        request.setCurrencyCode("YT");
        request.setOrderID(prepareOrderID(request.getTid()));

        return request;
    }

    /**
     * Returns a sample request bean for Point Usage transaction
     */
    protected static RequestBean RequestBeanForPointGainInqUsage() {
        RequestBean request = new RequestBean();
        request.setMid("6700000067");
        request.setTid("67000067");
        request.setTranType(XMLConstants.POINT_GAIN_INQ);
        request.addPgiAmount("123");
        request.addPgiTranType("S");
        request.addPgiAmount("345");
        request.addPgiTranType("D");
        
        return request;
    }
    
    /**
     * Returns a sample request bean for VFT Query transaction
     */
    protected static RequestBean RequestBeanForVFTQuery() {
        RequestBean request = new RequestBean();
        request.setMid("6700000067");
        request.setTid("67000067");
        request.setTranType(XMLConstants.VFT_INQ);
        request.setCcNo("4506349116608409");
        request.setInstalment("02");
        request.setVftCode("K001");
        request.setAmount("1546");

        return request;
    }

    /**
     * Returns a sample request bean for VFT transaction
     */
    protected static RequestBean RequestBeanForVFTTransaction() {
        RequestBean request = new RequestBean();
        request.setMid("6700000067");
        request.setTid("67000067");
        request.setTranType(XMLConstants.VFT_TXN);
        request.setCcNo("4506349116608409");
        request.setExpDate("0703");
        request.setCvc("XXX");
        request.setInstalment("02");
        request.setVftCode("K001");
        request.setAmount("1546");
        request.setCurrencyCode("YT");
        request.setOrderID(prepareOrderID(request.getTid()));

        return request;
    }

    /**
     * Returns xml request string to send to posnet system.
     * 
     * <p>
     * This method adds all required fields of <code>request</code> parameter to their corresponding places in xml string to be returned. It forces you to specify all required fields in
     * <code>request</code>. To see what fields are mandatory in which transaction, see online Posnet documentation.
     * 
     * @throws IOException
     *             When an IO error occurs.
     * @throws IllegalArgumentException
     *             When <code>request</code> parameter does not specify a mandatory field.
     */
    public static String prepareRequestXML(RequestBean request) throws java.io.IOException, IllegalArgumentException {
        org.w3c.dom.Document doc = new org.apache.xerces.dom.DocumentImpl();
        org.w3c.dom.Element root = doc.createElement("posnetRequest");

        //
        //add child nodes:
        //
        org.w3c.dom.Element node;
        node = doc.createElement("mid");
        node.appendChild(doc.createTextNode(request.getMid()));
        root.appendChild(node);
        node = doc.createElement("tid");
        node.appendChild(doc.createTextNode(request.getTid()));
        root.appendChild(node);

        if (request.getUsername() != null && request.getUsername().length() > 0) {
            node = doc.createElement("username");
            node.appendChild(doc.createTextNode(request.getUsername()));
            root.appendChild(node);
        }
        if (request.getPassword() != null && request.getPassword().length() > 0) {
            node = doc.createElement("password");
            node.appendChild(doc.createTextNode(request.getPassword()));
            root.appendChild(node);
        }
        //
        //transaction nodes:
        org.w3c.dom.Element nodeTran = doc.createElement(request.getTranType());
        //
        if (request.getTranType().equals(XMLConstants.AUTH) || request.getTranType().equals(XMLConstants.SALE)) {
            if (request.getCcNo() == null || request.getCcNo().length() == 0)
                throw new IllegalArgumentException("Parameter not found: ccno");
            node = doc.createElement("ccno");
            node.appendChild(doc.createTextNode(request.getCcNo()));
            nodeTran.appendChild(node);

            if (request.getCvc() == null || request.getCvc().length() == 0)
                throw new IllegalArgumentException("Parameter not found: cvc");
            node = doc.createElement("cvc");
            node.appendChild(doc.createTextNode(request.getCvc()));
            nodeTran.appendChild(node);

            if (request.getExpDate() == null || request.getExpDate().length() == 0)
                throw new IllegalArgumentException("Parameter not found: expDate");
            node = doc.createElement("expDate");
            node.appendChild(doc.createTextNode(request.getExpDate()));
            nodeTran.appendChild(node);

            if (request.getInstalment() != null && request.getInstalment().length() > 0) {
                node = doc.createElement("installment");
                node.appendChild(doc.createTextNode(request.getInstalment()));
                nodeTran.appendChild(node);
            }

            if (request.getOrderID() == null || request.getOrderID().length() == 0)
                throw new IllegalArgumentException("Parameter not found: orderID");
            node = doc.createElement("orderID");
            node.appendChild(doc.createTextNode(request.getOrderID()));
            nodeTran.appendChild(node);

            if (request.getAmount() == null || request.getAmount().length() == 0)
                throw new IllegalArgumentException("Parameter not found: amount");
            node = doc.createElement("amount");
            node.appendChild(doc.createTextNode(request.getAmount()));
            nodeTran.appendChild(node);

            if (request.getCurrencyCode() == null || request.getCurrencyCode().length() == 0)
                throw new IllegalArgumentException("Parameter not found: currencyCode");
            node = doc.createElement("currencyCode");
            node.appendChild(doc.createTextNode(request.getCurrencyCode()));
            nodeTran.appendChild(node);

            if (request.getMultiplePnt() != null && request.getMultiplePnt().length() > 0) {
                node = doc.createElement("multiplePoint");
                node.appendChild(doc.createTextNode(request.getMultiplePnt()));
                nodeTran.appendChild(node);
            }

            if (request.getExtraPnt() != null && request.getExtraPnt().length() > 0) {
                node = doc.createElement("extraPoint");
                node.appendChild(doc.createTextNode(request.getExtraPnt()));
                nodeTran.appendChild(node);
            }

            if (request.getKoiCode() != null && request.getKoiCode().length() > 0) {
                node = doc.createElement("koiCode");
                node.appendChild(doc.createTextNode(request.getKoiCode()));
                nodeTran.appendChild(node);
            }
        } else if (request.getTranType().equals(XMLConstants.CAPT)) {
            if (request.getHostLogKey() == null || request.getHostLogKey().length() == 0)
                throw new IllegalArgumentException("Parameter not found: hostLogKey");
            node = doc.createElement("hostLogKey");
            node.appendChild(doc.createTextNode(request.getHostLogKey()));
            nodeTran.appendChild(node);

            if (request.getAmount() == null || request.getAmount().length() == 0)
                throw new IllegalArgumentException("Parameter not found: amount");
            node = doc.createElement("amount");
            node.appendChild(doc.createTextNode(request.getAmount()));
            nodeTran.appendChild(node);

            if (request.getCurrencyCode() == null || request.getCurrencyCode().length() == 0)
                throw new IllegalArgumentException("Parameter not found: currencyCode");
            node = doc.createElement("currencyCode");
            node.appendChild(doc.createTextNode(request.getCurrencyCode()));
            nodeTran.appendChild(node);

            if (request.getMultiplePnt() != null && request.getMultiplePnt().length() > 0) {
                node = doc.createElement("multiplePoint");
                node.appendChild(doc.createTextNode(request.getMultiplePnt()));
                nodeTran.appendChild(node);
            }

            if (request.getExtraPnt() != null && request.getExtraPnt().length() > 0) {
                node = doc.createElement("extraPoint");
                node.appendChild(doc.createTextNode(request.getExtraPnt()));
                nodeTran.appendChild(node);
            }

            if (request.getInstalment() != null && request.getInstalment().length() > 0) {
                node = doc.createElement("installment");
                node.appendChild(doc.createTextNode(request.getInstalment()));
                nodeTran.appendChild(node);
            }
        } else if (request.getTranType().equals(XMLConstants.REVERSE)) {
            if (request.getTranTypeToReverse() == null || request.getTranTypeToReverse().length() == 0)
                throw new IllegalArgumentException("Parameter not found: transaction");
            node = doc.createElement("transaction");
            node.appendChild(doc.createTextNode(request.getTranTypeToReverse()));
            nodeTran.appendChild(node);

            if (request.getAuthCode() != null && request.getAuthCode().length() > 0) {
                node = doc.createElement("authCode");
                node.appendChild(doc.createTextNode(request.getAuthCode()));
                nodeTran.appendChild(node);
            }

            if (request.getHostLogKey() == null || request.getHostLogKey().length() == 0)
                throw new IllegalArgumentException("Parameter not found: hostLogKey");
            node = doc.createElement("hostLogKey");
            node.appendChild(doc.createTextNode(request.getHostLogKey()));
            nodeTran.appendChild(node);
        } else if (request.getTranType().equals(XMLConstants.POINT_INQ)) {
            if (request.getCcNo() == null || request.getCcNo().length() == 0)
                throw new IllegalArgumentException("Parameter not found: ccno");
            node = doc.createElement("ccno");
            node.appendChild(doc.createTextNode(request.getCcNo()));
            nodeTran.appendChild(node);

            if (request.getExpDate() == null || request.getExpDate().length() == 0)
                throw new IllegalArgumentException("Parameter not found: expDate");
            node = doc.createElement("expDate");
            node.appendChild(doc.createTextNode(request.getExpDate()));
            nodeTran.appendChild(node);
        } else if (request.getTranType().equals(XMLConstants.POINT_USE)) {
            if (request.getCcNo() == null || request.getCcNo().length() == 0)
                throw new IllegalArgumentException("Parameter not found: ccno");
            node = doc.createElement("ccno");
            node.appendChild(doc.createTextNode(request.getCcNo()));
            nodeTran.appendChild(node);

            if (request.getExpDate() == null || request.getExpDate().length() == 0)
                throw new IllegalArgumentException("Parameter not found: expDate");
            node = doc.createElement("expDate");
            node.appendChild(doc.createTextNode(request.getExpDate()));
            nodeTran.appendChild(node);

            if (request.getAmount() == null || request.getAmount().length() == 0)
                throw new IllegalArgumentException("Parameter not found: amount");
            node = doc.createElement("amount");
            node.appendChild(doc.createTextNode(request.getAmount()));
            nodeTran.appendChild(node);

            if (request.getCurrencyCode() == null || request.getCurrencyCode().length() == 0)
                throw new IllegalArgumentException("Parameter not found: currencyCode");
            node = doc.createElement("currencyCode");
            node.appendChild(doc.createTextNode(request.getCurrencyCode()));
            nodeTran.appendChild(node);

            if (request.getOrderID() == null || request.getOrderID().length() == 0)
                throw new IllegalArgumentException("Parameter not found: orderID");
            node = doc.createElement("orderID");
            node.appendChild(doc.createTextNode(request.getOrderID()));
            nodeTran.appendChild(node);
        } else if (request.getTranType().equals(XMLConstants.POINT_GAIN_INQ)) {
            org.w3c.dom.Element nodeAmountDataForWPInq = null;
            
            if (request.getLengthOfAmountDatasForWPInq() == 0)
                throw new IllegalArgumentException("Parameter not found: amountDataForWPInq");
            
            if (request.multiplePointForSale == null || request.multiplePointForSale.length() == 0)
                request.multiplePointForSale = "00";
            node = doc.createElement("multiplePointForSale");
            node.appendChild(doc.createTextNode(request.multiplePointForSale));
            nodeTran.appendChild(node);
            
            if (request.extraPointForSale == null || request.extraPointForSale.length() == 0)
                request.extraPointForSale = "000000";
            node = doc.createElement("extraPointForSale");
            node.appendChild(doc.createTextNode(request.extraPointForSale));
            nodeTran.appendChild(node);
            
            if (request.multiplePointForInstSale == null || request.multiplePointForInstSale.length() == 0)
                request.multiplePointForInstSale = "00";
            node = doc.createElement("multiplePointForInstSale");
            node.appendChild(doc.createTextNode(request.multiplePointForSale));
            nodeTran.appendChild(node);
            
            if (request.extraPointForInstSale == null || request.extraPointForInstSale.length() == 0)
                request.extraPointForInstSale = "000000";
            node = doc.createElement("extraPointForInstSale");
            node.appendChild(doc.createTextNode(request.extraPointForInstSale));
            nodeTran.appendChild(node);
            
            for(int i = 0; i < request.getLengthOfAmountDatasForWPInq(); i++)
            {
                nodeAmountDataForWPInq = doc.createElement("amountDataForWPInq");
                nodeAmountDataForWPInq.setAttribute("id", ""+(i+1));
                node = doc.createElement("pgiAmount");
                node.appendChild(doc.createTextNode(request.getPgiAmount(i)));
                nodeAmountDataForWPInq.appendChild(node);
                node = doc.createElement("pgiTranType");
                node.appendChild(doc.createTextNode(request.getPgiTranType(i)));
                nodeAmountDataForWPInq.appendChild(node);
                nodeTran.appendChild(nodeAmountDataForWPInq);
            }
        } else if (request.getTranType().equals(XMLConstants.VFT_INQ)) {
            if (request.getCcNo() == null || request.getCcNo().length() == 0)
                throw new IllegalArgumentException("Parameter not found: ccno");
            node = doc.createElement("ccno");
            node.appendChild(doc.createTextNode(request.getCcNo()));
            nodeTran.appendChild(node);

            if (request.getInstalment() == null || request.getInstalment().length() == 0)
                throw new IllegalArgumentException("Parameter not found: installment");
            node = doc.createElement("installment");
            node.appendChild(doc.createTextNode(request.getInstalment()));
            nodeTran.appendChild(node);

            if (request.getVftCode() == null || request.getVftCode().length() == 0)
                throw new IllegalArgumentException("Parameter not found: vftCode");
            node = doc.createElement("vftCode");
            node.appendChild(doc.createTextNode(request.getVftCode()));
            nodeTran.appendChild(node);

            if (request.getAmount() == null || request.getAmount().length() == 0)
                throw new IllegalArgumentException("Parameter not found: amount");
            node = doc.createElement("amount");
            node.appendChild(doc.createTextNode(request.getAmount()));
            nodeTran.appendChild(node);
        } else if (request.getTranType().equals(XMLConstants.VFT_TXN)) {
            if (request.getCcNo() == null || request.getCcNo().length() == 0)
                throw new IllegalArgumentException("Parameter not found: ccno");
            node = doc.createElement("ccno");
            node.appendChild(doc.createTextNode(request.getCcNo()));
            nodeTran.appendChild(node);

            if (request.getCvc() == null || request.getCvc().length() == 0)
                throw new IllegalArgumentException("Parameter not found: cvc");
            node = doc.createElement("cvc");
            node.appendChild(doc.createTextNode(request.getCvc()));
            nodeTran.appendChild(node);

            if (request.getExpDate() == null || request.getExpDate().length() == 0)
                throw new IllegalArgumentException("Parameter not found: expDate");
            node = doc.createElement("expDate");
            node.appendChild(doc.createTextNode(request.getExpDate()));
            nodeTran.appendChild(node);

            if (request.getInstalment() == null || request.getInstalment().length() == 0)
                throw new IllegalArgumentException("Parameter not found: installment");
            node = doc.createElement("installment");
            node.appendChild(doc.createTextNode(request.getInstalment()));
            nodeTran.appendChild(node);

            if (request.getVftCode() == null || request.getVftCode().length() == 0)
                throw new IllegalArgumentException("Parameter not found: vftCode");
            node = doc.createElement("vftCode");
            node.appendChild(doc.createTextNode(request.getVftCode()));
            nodeTran.appendChild(node);

            if (request.getAmount() == null || request.getAmount().length() == 0)
                throw new IllegalArgumentException("Parameter not found: amount");
            node = doc.createElement("amount");
            node.appendChild(doc.createTextNode(request.getAmount()));
            nodeTran.appendChild(node);

            if (request.getCurrencyCode() == null || request.getCurrencyCode().length() == 0)
                throw new IllegalArgumentException("Parameter not found: currencyCode");
            node = doc.createElement("currencyCode");
            node.appendChild(doc.createTextNode(request.getCurrencyCode()));
            nodeTran.appendChild(node);

            if (request.getOrderID() == null || request.getOrderID().length() == 0)
                throw new IllegalArgumentException("Parameter not found: orderID");
            node = doc.createElement("orderID");
            node.appendChild(doc.createTextNode(request.getOrderID()));
            nodeTran.appendChild(node);

            if (request.getKoiCode() != null && request.getKoiCode().length() > 0) {
                node = doc.createElement("koiCode");
                node.appendChild(doc.createTextNode(request.getKoiCode()));
                nodeTran.appendChild(node);
            }
        } else if (request.getTranType().equals(XMLConstants.RETURN) ||
                request.getTranType().equals(XMLConstants.VFT_RETURN)
                ) {
            if (request.getOrderID() != null && request.getOrderID().length() > 0) {
	            node = doc.createElement("orderID");
	            node.appendChild(doc.createTextNode(request.getOrderID()));
	            nodeTran.appendChild(node);
            }
            else {
	            if (request.getHostLogKey() == null || request.getHostLogKey().length() == 0)
	                throw new IllegalArgumentException("Parameter not found: hostLogKey");
		            node = doc.createElement("hostLogKey");
		            node.appendChild(doc.createTextNode(request.getHostLogKey()));
		            nodeTran.appendChild(node);
	            }
            if (request.getTranType().equals(XMLConstants.VFT_RETURN)) {
                if (request.getAuthCode() == null || request.getAuthCode().length() > 0)
                    throw new IllegalArgumentException("Parameter not found: authCode");
		        node = doc.createElement("authCode");
                node.appendChild(doc.createTextNode(request.getAuthCode()));
                nodeTran.appendChild(node);
            }
            
            if (request.getAmount() == null || request.getAmount().length() == 0)
                throw new IllegalArgumentException("Parameter not found: amount");
            node = doc.createElement("amount");
            node.appendChild(doc.createTextNode(request.getAmount()));
            nodeTran.appendChild(node);

            if (request.getCurrencyCode() == null || request.getCurrencyCode().length() == 0)
                throw new IllegalArgumentException("Parameter not found: currencyCode");
            node = doc.createElement("currencyCode");
            node.appendChild(doc.createTextNode(request.getCurrencyCode()));
            nodeTran.appendChild(node);
        } else if (request.getTranType().equals(XMLConstants.HAZIRKART_KONTOR)) {
            if (request.getCcNo() == null || request.getCcNo().length() == 0)
                throw new IllegalArgumentException("Parameter not found: ccno");
            node = doc.createElement("ccno");
            node.appendChild(doc.createTextNode(request.getCcNo()));
            nodeTran.appendChild(node);

            if (request.getCvc() == null || request.getCvc().length() == 0)
                throw new IllegalArgumentException("Parameter not found: cvc");
            node = doc.createElement("cvc");
            node.appendChild(doc.createTextNode(request.getCvc()));
            nodeTran.appendChild(node);

            if (request.getExpDate() == null || request.getExpDate().length() == 0)
                throw new IllegalArgumentException("Parameter not found: expDate");
            node = doc.createElement("expDate");
            node.appendChild(doc.createTextNode(request.getExpDate()));
            nodeTran.appendChild(node);

            if (request.getOrderID() == null || request.getOrderID().length() == 0)
                throw new IllegalArgumentException("Parameter not found: orderID");
            node = doc.createElement("orderID");
            node.appendChild(doc.createTextNode(request.getOrderID()));
            nodeTran.appendChild(node);
            
            if (request.getKontor() == null || request.getKontor().length() == 0)
                throw new IllegalArgumentException("Parameter not found: kontor");
            node = doc.createElement("kontor");
            node.appendChild(doc.createTextNode(request.getKontor()));
            nodeTran.appendChild(node);

            if (request.getGsmno() == null || request.getGsmno().length() == 0)
                throw new IllegalArgumentException("Parameter not found: gsmNo");
            node = doc.createElement("gsmNo");
            node.appendChild(doc.createTextNode(request.getGsmno()));
            nodeTran.appendChild(node);
        } else if (request.getTranType().equals(XMLConstants.KOI_INQUIRY)) {
            if (request.getCcNo() == null || request.getCcNo().length() == 0)
                throw new IllegalArgumentException("Parameter not found: ccno");
            node = doc.createElement("ccno");
            node.appendChild(doc.createTextNode(request.getCcNo()));
            nodeTran.appendChild(node);
        } else if (request.getTranType().equals(XMLConstants.TDS_TRANSACTION)) {
            if (request.getBankData() == null || request.getBankData().length() == 0)
                throw new IllegalArgumentException("Parameter not found: bankData");
            node = doc.createElement("bankData");
            node.appendChild(doc.createTextNode(request.getBankData()));
            nodeTran.appendChild(node);

            node = doc.createElement("wpAmount");
            if (request.getWorldPointAmount() != null && request.getWorldPointAmount().length() != 0)
                node.appendChild(doc.createTextNode(request.getWorldPointAmount()));
            else
                node.appendChild(doc.createTextNode("0"));
            nodeTran.appendChild(node);
        } else
            throw new IllegalArgumentException("Invalid Type : " + request.getTranType());

        root.appendChild(nodeTran);

        doc.appendChild(root);

        //convert doc to string and return:
        OutputFormat format = new OutputFormat(doc); //Serialize DOM
        StringWriter stringOut = new StringWriter(); //Writer will be a String
        XMLSerializer serial = new XMLSerializer(stringOut, format);
        serial.asDOMSerializer(); // As a DOM Serializer
        serial.serialize(doc.getDocumentElement());
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
    public static String prepareOrderID(String tid) {
        java.util.Calendar rightNow = java.util.Calendar.getInstance(); //Total
        return "prg_" //4 char	4
                + tid //8 char	12
                + Integer.toString( //2 char	14
                        rightNow.get(Calendar.YEAR)).substring(2) + padString( //2 char	16
                        Integer.toString(rightNow.get(Calendar.MONTH) + 1), 2, '0', false) + padString( //2 char	18
                        Integer.toString(rightNow.get(Calendar.DAY_OF_MONTH)), 2, '0', false) + padString( //2 char	20
                        Integer.toString(rightNow.get(Calendar.HOUR_OF_DAY)), 2, '0', false) + padString( //2 char	22
                        Integer.toString(rightNow.get(Calendar.MINUTE)), 2, '0', false) + padString( //2 char	24 OK!!
                        Integer.toString(rightNow.get(Calendar.SECOND)), 2, '0', false);
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
    public static String padString(String s, int newLength, char charToPad, boolean padToEnd) {
        String don = s;
        for (int i = 0; i < newLength - s.length(); i++) {
            don = (padToEnd) ? don + charToPad : charToPad + don;
        }
        return don;
    }
}
