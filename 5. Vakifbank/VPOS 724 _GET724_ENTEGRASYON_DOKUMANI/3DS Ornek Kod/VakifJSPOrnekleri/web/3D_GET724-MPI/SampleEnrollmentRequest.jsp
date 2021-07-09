<%-- 
    Document   : SampleEnrollmentRequest
    Created on : Apr 2, 2014, 10:15:53 AM
    Author     : bsonmez
--%>

<%@page import="example.XMLReader"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="example.HTTPRequest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>iPay APM 3D-Secure İşlem Sayfası</title>
        <style>
            .input_yeni {
                font-family: Arial, Helvetica, sans-serif;
                font-size: 9pt;
                font-weight: bold;
                color: #666666;
                background-color: #FFFFFF;
                padding: 5px;
                border: 1px solid #CCCCCC;
            }
            .Basliklar {
                font-family: Tahoma;
                font-size: 9pt;
                font-weight: bold;
                color: #666666;
                padding-left: 10px;
                border-bottom-width: 1px;
                border-bottom-style: solid;
                border-bottom-color: #EBEBEB;
                padding-top: 2px;
                text-align: right;
            }
            .AltCizgi {
                font-family: Tahoma;
                font-size: 9pt;
                font-weight: normal;
                color: #666666;
                border-bottom-width: 1px;
                border-bottom-style: solid;
                border-bottom-color: #EBEBEB;
                padding-top: 2px;
                padding-bottom: 2px;
                padding-left: 5px;
            }
        </style>
    </head>
    <body>
        <%
            if (request.getParameter("form") != null && request.getParameter("form").equals("send")) {
                // Form gönderilmiş, enroll request için HTTP request gönderiyoruz.
                HTTPRequest enrollReq = new HTTPRequest();
                
                // Post request query parametreleri hashmap olarak belirleniyor.
                HashMap<String, String> params = new HashMap<String, String>();
                params.put("Pan", request.getParameter("pan"));
                params.put("ExpiryDate", request.getParameter("ExpiryDate"));
                params.put("PurchaseAmount", request.getParameter("PurchaseAmount"));
                params.put("Currency", request.getParameter("Currency"));
                params.put("BrandName", request.getParameter("BrandName"));
                params.put("VerifyEnrollmentRequestId", request.getParameter("VerifyEnrollmentRequestId"));
                params.put("SessionInfo", request.getParameter("SessionInfo"));
                params.put("MerchantId", request.getParameter("MerchantId"));
                params.put("MerchantPassword", request.getParameter("MerchantPassword"));
                params.put("SuccessUrl", request.getParameter("SuccessURL"));
                params.put("FailureUrl", request.getParameter("FailureURL"));
                params.put("InstallmentCount", request.getParameter("InstallmentCount"));
                String result = enrollReq.sendPostRequest("", params);	//Dok�manda yer alan Enrollment urli
                
                // Sonuç XMLReader classıyla okunuyor.
                XMLReader enrollReader = new XMLReader(result);
                String rStatus = enrollReader.readNode("Status");
                String rPaReq = enrollReader.readNode("PaReq");
                String rACSUrl = enrollReader.readNode("ACSUrl");
                String rTermUrl = enrollReader.readNode("TermUrl");
                String rMD = enrollReader.readNode("MD");
                String rMessageErrorCode = enrollReader.readNode("MessageErrorCode");
                
                if (rStatus.equals("Y")) {
        %>
        <form name="downloadForm" action="<%=rACSUrl%>" method="POST">
            <br>
            <br>
            <div id="image1" style="position:absolute; overflow:hidden; left:0px; top:0px; width:180px; height:180px; z-index:0"><img src="" alt="" title="" border=0 width=180 height=180></div>
            <center>
                <h1>3-D Secure İşleminiz yapılıyor</h1>
                <h3>
                    3D-Secure işleminizin doğrulama aşamasına geçebilmek için Gönder butonuna basmanız gerekmektedir.
                </h3>
                <input type="submit" value="Gönder">
            </center>
            <input type="hidden" name="PaReq" value="<%=rPaReq%>">
            <input type="hidden" name="TermUrl" value="<%=rTermUrl%>">
            <input type="hidden" name="MD" value="<%=rMD%>">
        </form>
        <%
                } else {
        %>
        <h2>HATA!</h2>
        <p>3D-Secure Verify Enrollment Sonucu : <%=rMessageErrorCode%></p>
        <%
                }
            } else {
        %>
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <form action="" method="post">
                <input type="hidden" name="form" value="send">
                <tr>
                    <td width="10" height="10" bgcolor="#FBFBFB" class="Basliklar">&nbsp;</td>
                    <td width="1" bgcolor="#FBFBFB" class="AltCizgi">&nbsp;</td>
                <B><td bgcolor="#FBFBFB" class="AltCizgi">3D Entegrasyon Vakifbank Pos islem Uye is yeri bilgileri</td></B>
                </tr>
                <tr>
                    <td width="100" height="25" class="Basliklar">Uye Isyeri No</td>
                    <td width="1" class="AltCizgi">:</td>
                    <td class="AltCizgi">
                        <input class="input_yeni" type="text" name="MerchantId" size="49" value="655500056"></td>
                </tr>
                <tr>
                    <td width="100" height="25" class="Basliklar">İsyeri Sifre</td>
                    <td width="1" class="AltCizgi">:</td>
                    <td class="AltCizgi">
                        <input class="input_yeni" type="text" name="MerchantPassword" size="49" value="123456"></td>
                </tr>
                <tr>
                    <td width="100" height="25" class="Basliklar">SuccessURL</td>
                    <td width="1" class="AltCizgi">:</td>
                    <td class="AltCizgi"><input class="input_yeni" type="text" name="SuccessURL" size="50" value="http://127.0.0.1:8080/VakifJSPOrnekleri/MPI/TempSuccessUrl.jsp"></td>
                </tr>
                <tr>
                    <td width="100" height="25" class="Basliklar">FailureURL</td>
                    <td width="1" class="AltCizgi">:</td>
                    <td class="AltCizgi"><input class="input_yeni" type="text" name="FailureURL" size="50" value="http://127.0.0.1:8080/VakifJSPOrnekleri/MPI/TempSuccessUrl.jsp"></td>
                </tr>
                <td width="10" height="10" bgcolor="#FBFBFB" class="Basliklar">&nbsp;</td>
                <td width="1" bgcolor="#FBFBFB" class="AltCizgi">&nbsp;</td>
                <B><td bgcolor="#FBFBFB" class="AltCizgi">Kart Bilgileri</td></B>
                <tr>
                    <td width="100" height="25" class="Basliklar">Kart No</td>
                    <td width="1" class="AltCizgi">:</td>
                    <td class="AltCizgi">
                        <input class="input_yeni" type="text" name="pan" size="49" value="4012001037141112"></td>
                </tr>
                <tr>
                    <td width="100" height="25" class="Basliklar">Son K.Tarihi</td>
                    <td width="1" class="AltCizgi"></td>
                    <td class="AltCizgi">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td width="33">
                                    <input class="input_yeni" type="text" name="ExpiryDate" size="12" value="1412"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="100" height="25" class="Basliklar">Kart Cvv</td>
                    <td width="1" class="AltCizgi">:</td>
                    <td class="AltCizgi"><input class="input_yeni" type="text" name="KartCvv" size="12" value="123"></td>
                </tr>
                <tr>
                    <td width="100" height="25" class="Basliklar">Tutar</td>
                    <td width="1" class="AltCizgi">:</td>
                    <td class="AltCizgi"><input class="input_yeni" type="text" name="PurchaseAmount" size="12" value="18.00"></td>
                </tr>
                <tr>
                    <td width="100" height="25" class="Basliklar">Kart Tipi</td>
                    <td width="1" class="AltCizgi">:</td>
                    <td class="AltCizgi"><input class="input_yeni" type="text" name="BrandName" size="12" value="100"></td>
                </tr>
                <tr>
                    <td width="100" height="25" class="Basliklar">Para Türü</td>
                    <td width="1" class="AltCizgi">:</td>
                    <td class="AltCizgi">
                        <input class="input_yeni" type="text" name="Currency" size="50" value="840"></td>
                </tr>
                <tr>
                    <td width="100" height="25" class="Basliklar">Taksit</td>
                    <td width="1" class="AltCizgi">:</td>
                    <td class="AltCizgi"><input class="input_yeni" type="text" name="InstallmentCount" size="4" value=""></td>
                </tr>
                <tr>
                    <td width="100" height="25" class="Basliklar">Siparis No</td>
                    <td width="1" class="AltCizgi">:</td>
                    <td class="AltCizgi"><input class="input_yeni" type="text" name="VerifyEnrollmentRequestId" size="50" value="SIP_ID12345698700020"></td>
                </tr>
                <tr>
                    <td width="100" height="25" class="Basliklar">Session Info</td>
                    <td width="1" class="AltCizgi">:</td>
                    <td class="AltCizgi"><input class="input_yeni" type="text" name="SessionInfo" size="50" value="1"></td>
                </tr>
                <br/> <input type="submit">
            </form>
        </table>
        <%
            }
        %>
    </body>
</html>
