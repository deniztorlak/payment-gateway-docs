<%@ Page Language="vb" ValidateRequest="false" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>HASH RESULT</title>
</head>
<body>

    <table border="1">

        <%

            Dim sortedList As New SortedList()

            For Each paramName As String In Request.Form.AllKeys
                sortedList.Add(paramName, Request.Form(paramName))
                Response.Write("<tr><td>" + paramName + "</td><td>" + Request.Form(paramName) + "</td></tr>")
            Next

            Dim hashval As String = ""

            Dim i As Integer
            For i = 0 To sortedList.Count - 1
                Dim lowerKey As String = sortedList.GetKey(i).ToString.ToLower()
                If (Not lowerKey.Equals("hash") And Not lowerKey.Equals("encoding")) Then
                    hashval += sortedList.GetByIndex(i) + "|"
                End If
            Next i


            Dim storekey As String = "TEST1234"
            storekey = storekey.Replace("\", "\\").Replace("|", "\|")
            hashval += storekey

            Dim result As Byte()

            Dim sha As New System.Security.Cryptography.SHA512Managed()

            result = sha.ComputeHash(System.Text.Encoding.UTF8.GetBytes(hashval))
            Dim actualHashValue As String = Convert.ToBase64String(result)

            Dim retrievedHash As String = Request.Form("HASH")

            If (Not retrievedHash.Equals(actualHashValue)) Then
                Response.Write("<h4>Security Alert. The digital signature is not valid.</h4>")
            Else
                Response.Write("<h4>HASH is Successfull</h4>")
            End If
        %>
    </table>

</body>

</html>


