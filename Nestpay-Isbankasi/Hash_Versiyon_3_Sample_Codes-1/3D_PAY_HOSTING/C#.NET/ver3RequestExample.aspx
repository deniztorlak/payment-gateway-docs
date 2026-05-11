<%@ Page Language="C#" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>3D PAY HOSTING Model</title>
</head>
<body>
    <form method="post" action="https://<host_address>/GenericVer3RequestHashHandler">
        <%

            //unEscaped values
            String orgClientId = "100200127";
            String orgAmount = "91.96";
            String orgOkUrl = "https://<host_address>/GenericVer3ResponseHandler";
            String orgFailUrl = "https://<host_address>/GenericVer3ResponseHandler";
            String orgTransactionType = "Auth";
            String orgInstallment = "";
            String orgRnd = DateTime.Now.ToString();
            String orgCallbackUrl = "https://<host_address>/callback.php";
            String orgCurrency = "949";
        %>

        <center>

     
            <table>     
                <tr>

                    <td align="center" colspan="2">
                        <input type="submit"
                               value="Complete Payment" />
                    </td>
                </tr>


            </table>

            <input type="hidden" name="clientid" value="<%=orgClientId%>" />
            <input type="hidden" name="amount" value="<%=orgAmount%>" />
            <input type="hidden" name="okurl" value="<%=orgOkUrl%>" />
            <input type="hidden" name="failUrl" value="<%=orgFailUrl%>" />
            <input type="hidden" name="TranType" value="<%=orgTransactionType%>" />
            <input type="hidden" name="Instalment" value="<%=orgInstallment%>" />
            <input type="hidden" name="callbackUrl" value="<%=orgCallbackUrl%>" />
            <input type="hidden" name="currency" value="<%=orgCurrency%>" />
            <input type="hidden" name="rnd" value="<%=orgRnd%>" />
            <input type="hidden" name="storetype" value="3D_PAY_HOSTING" />
            <input type="hidden" name="lang" value="tr" />
            <input type="hidden" name="hashAlgorithm" value="ver3" />
            <input type="hidden" name="BillToName" value="name">
			<input type="hidden" name="BillToCompany" value="billToCompany">
            <input type="hidden" name="refreshtime" value="5">
    </form>

    </center>

</body>

</html>


