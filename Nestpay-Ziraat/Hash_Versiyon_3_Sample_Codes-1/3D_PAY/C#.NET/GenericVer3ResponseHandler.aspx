<%@ Page Language="C#" ValidateRequest="false" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>HASH RESULT</title>
</head>
<body>

    <table border="1">


        <%
            List<KeyValuePair<String, String>> postParams = new List<KeyValuePair<String, String>>();
            foreach (string key in Request.Form.AllKeys)
            {
                Response.Write("<tr><td>" + key + "</td><td>" + Request.Form[key] + "</td></tr>");
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
            String actualHash = System.Convert.ToBase64String(inputbytes);

            String retrievedHash = Request.Form["HASH"];
            if (!actualHash.Equals(retrievedHash))
            {
                Response.Write("<h4>Security Alert. The digital signature is not valid. HASH mismatch</h4>");
            }
            else
            {
                Response.Write("<h4>Hash is SUCCESSFULL.</h4>");
            }
        %>
    </table>




</body>

</html>


