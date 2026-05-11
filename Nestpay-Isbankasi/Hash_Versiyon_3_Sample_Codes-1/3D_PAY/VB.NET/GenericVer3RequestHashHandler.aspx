<%@ Page Language="vb" ValidateRequest="false" %>

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

            Dim sortedList As New SortedList()

            For Each paramName As String In Request.Form.AllKeys
                sortedList.Add(paramName, Request.Form(paramName))
            Next

            Dim hashval As String = ""

            Dim i As Integer
            For i = 0 To sortedList.Count - 1
                Dim lowerKey As String = sortedList.GetKey(i).ToString.ToLower()
                If (Not lowerKey.Equals("hash") And Not lowerKey.Equals("encoding")) Then
                    Response.Write("<input type='hidden' name='" & sortedList.GetKey(i) & "' value='" & sortedList.GetByIndex(i) & "' /><br />")
                    hashval += sortedList.GetByIndex(i) + "|"
                End If
            Next i


            Dim storekey As String = "TEST1234"
            storekey = storekey.Replace("\", "\\").Replace("|", "\|")
            hashval += storekey

            Dim result As Byte()

            Dim sha As New System.Security.Cryptography.SHA512Managed()

            result = sha.ComputeHash(System.Text.Encoding.UTF8.GetBytes(hashval))
            Dim hashValue As String = Convert.ToBase64String(result)
            Response.Write("<input type='hidden' name='hash' value='" & hashValue & "' /><br />")

        %>

        <noscript>
            <input type="submit" value="Complete Payment" />
        </noscript>
    </form>



</body>

</html>


