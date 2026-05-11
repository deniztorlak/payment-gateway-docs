<%-- 
    Document   : SampleVposRequest
    Created on : Apr 2, 2014, 2:56:02 PM
    Author     : bsonmez
--%>

<%@page import="java.util.HashMap"%>
<%@page import="example.HTTPRequest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ã–rnek VPOS Request</title>
    </head>
    <body>
        <%
            String PostUrl = "";	//Dokümanda yer alan VPOS urli
            String PosXML = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                    + "<VposRequest>"
                    + "<MerchantId>" + request.getParameter("IsyeriNo") + "</MerchantId>"
                    + "<Password>" + request.getParameter("IsyeriSifre") + "</Password>"
                    + "<TerminalNo>" + request.getParameter("TerminalNo") + "</TerminalNo>"
                    + "<TransactionType>" + request.getParameter("IslemTipi") + "</TransactionType>"
                    + "<TransactionId>" + request.getParameter("SiparID") + "</TransactionId>"
                    + "<CurrencyAmount>" + request.getParameter("Tutar") + "</CurrencyAmount>" //3D Secure işyerlerimizin bu parametreyi kullanmasına lüzum yoktur.
                    + "<CurrencyCode>" + request.getParameter("TutarKodu") + "</CurrencyCode>" //3D Secure işyerlerimizin bu parametreyi kullanmasına lüzum yoktur.
                    + "<Pan>" + request.getParameter("KartNo") + "</Pan>" //3D Secure işyerlerimizin bu parametreyi kullanmasına lüzum yoktur.
                    + "<Cvv>" + request.getParameter("KartCvv") + "</Cvv>"
                    + "<Expiry>" + request.getParameter("KartYil") + request.getParameter("KartAy") + "</Expiry>" //3D Secure işyerlerimizin bu parametreyi kullanmasına lüzum yoktur.
                    + "<TransactionDeviceSource>0</TransactionDeviceSource>"
                    + "</VposRequest>";

            HTTPRequest regtransReq = new HTTPRequest();

            // Post request query parametreleri hashmap olarak belirleniyor.
            HashMap<String, String> params = new HashMap<String, String>();
            params.put("prmstr", PosXML);
            String result = regtransReq.sendPostRequest(PostUrl, params);

        %>
        <h1>Xml formatÄ± </h1>
        <textarea rows="15" cols="60"><%=PosXML%></textarea>
        <h1>SonuÃ§ deÄŸerleri</h1>
        <textarea rows="15" cols="60"><%=result%></textarea>
    </body>
</html>
