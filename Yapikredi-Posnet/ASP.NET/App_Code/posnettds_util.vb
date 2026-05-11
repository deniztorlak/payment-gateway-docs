Imports Microsoft.VisualBasic

Public Class posnettds_util
    Shared Function GetReturnURL(ByVal Request As HttpRequest) As String
        Dim url As String, regEx As Regex

        Dim domainName As String = Request.ServerVariables("SERVER_NAME")
        url = Request.ServerVariables("URL")

        Dim protocol As String = "http"
        If (Request.ServerVariables("HTTPS") = "on") Then
            protocol = "https"
        End If

        Dim port As String = ""
        If (((protocol <> "https") And (Request.ServerVariables("SERVER_PORT") <> "80")) _
            Or ((protocol = "https") And (Request.ServerVariables("SERVER_PORT") <> "443"))) Then
            port = ":" & Request.ServerVariables("SERVER_PORT")
        End If

        url = protocol & "://" & domainName & port & url

        regEx = New Regex(".aspx", RegexOptions.IgnoreCase)
        Return regEx.Replace(url, "_resp.aspx")
    End Function

    Shared Function ConvertYTLToYKR(ByVal amount As String) As String
        If (Len(amount) > 0) Then
            Return CDbl(Replace(amount, ".", "")) * 100
        Else
            Return amount
        End If

    End Function

    Shared Function GetCurrencyText(ByVal currencyCode As String) As String

        If (currencyCode = "YT" Or currencyCode = "TL") Then
            Return "TL"
        ElseIf (currencyCode = "US") Then
            Return "USD"
        ElseIf (currencyCode = "EU") Then
            Return "EUR"
        Else
            Return ""
        End If
    End Function

    Shared Function CurrencyFormat(ByVal amount As String, ByVal currencyCode As String, ByVal addCurrency As String) As String
        If amount Is Nothing Or amount = "" Then
            Return ""
        End If

        amount = CDbl(amount)

        If (amount = "-1") Then
            Return ""
        Else
            If (Len(amount) = 2) Then
                amount = "0" & amount
            ElseIf (Len(amount) < 2) Then
                amount = "00" & amount
            End If

            If (currencyCode = "YT" Or currencyCode = "TL" Or currencyCode = "US" Or currencyCode = "EU") Then
                CurrencyFormat = Left(amount, Len(amount) - 2) & "," & Right(amount, 2)
                If (addCurrency) Then
                    Return CurrencyFormat & " " & GetCurrencyText(currencyCode)
                Else
                    Return CurrencyFormat
                End If
            Else
                Return amount
            End If
        End If
    End Function

    Shared Function ThreeDSecureCheck(ByVal threeDMdStatus As String) As Boolean
        Dim strArray As Array

        If (Not posnettds_config.TD_SECURE_CHECK) Then
            ThreeDSecureCheck = True
        Else
            strArray = Split(posnettds_config.TD_SECURE_CHECK_MASK, ":")
            Dim i As Short
            For i = 0 To UBound(strArray)
                If (strArray(i) = threeDMdStatus) Then
                    ThreeDSecureCheck = True
                End If
            Next
            ThreeDSecureCheck = False
        End If
    End Function
End Class
