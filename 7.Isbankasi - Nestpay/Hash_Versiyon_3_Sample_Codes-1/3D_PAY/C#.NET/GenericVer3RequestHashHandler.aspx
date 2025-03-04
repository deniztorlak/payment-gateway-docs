<%@ Page Language="C#" ValidateRequest="false" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Generic Hash Request Handler</title>
    <script type="text/javascript" language="javascript">
        function moveWindow() {
            document.pay_form.submit();
        }
    </script>
</head>
<body onload="javascript:moveWindow()">

    <form name="pay_form" method="post" action="https://<host_address>/<3dgate_path>">


        <%
            List<KeyValuePair<String, String>> postParams = new List<KeyValuePair<String, String>>();
            foreach (string key in Request.Form.AllKeys)
            {
                Response.Write("<input type=\"hidden\" name=\"" + key + "\" value=\"" + Request.Form[key] + "\" /><br />");
                KeyValuePair<String, String> newKeyValuePair = new KeyValuePair<String, String>(key, Request.Form[key]);
                postParams.Add(newKeyValuePair);

            }

            postParams.Sort(
                delegate (KeyValuePair<string, string> firstPair,
                KeyValuePair<string, string> nextPair)
                {
                    return firstPair.Key.CompareTo(nextPair.Key.ToLower(new System.Globalization.CultureInfo("en-US", false)));
                }
            );

            String hashVal = "";           
            String storeKey = "TEST1234";
            storeKey = storeKey.Replace("\\", "\\\\").Replace("|", "\\|");

            foreach (KeyValuePair<String, String> pair in postParams)
            {
                String escapedValue = pair.Value.Replace("\\", "\\\\").Replace("|", "\\|");
                String lowerValue = pair.Key.ToLower(new System.Globalization.CultureInfo("en-US", false));
                if (!"encoding".Equals(lowerValue) && !"hash".Equals(lowerValue))
                {                    
                    hashVal += escapedValue + "|";
                }
            }
            hashVal += storeKey;    
            
            System.Security.Cryptography.SHA512 sha = new System.Security.Cryptography.SHA512CryptoServiceProvider();
            byte[] hashbytes = System.Text.Encoding.GetEncoding("UTF-8").GetBytes(hashVal);
            byte[] inputbytes = sha.ComputeHash(hashbytes);
            String hash = System.Convert.ToBase64String(inputbytes);
            // add hash to hidden variable
            Response.Write("<input type=\"hidden\" name=\"hash\" value=\"" + hash + "\" /><br />");
        %>

        <noscript>
            <input type="submit" value="Complete Payment" />
        </noscript>
    </form>



</body>

</html>


