﻿Imports System
Imports System.Net
Imports System.Xml
Imports System.Security.Cryptography
Imports System.IO

Partial Public Class _3DPay
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim strMode As String = "PROD"
            Dim strApiVersion As String = "v0.01"
            Dim strTerminalProvUserID As String = "PROVAUT"
            Dim strType As String = "sales"
            Dim strAmount As String = "100" 'İşlem Tutarı 1.00 TL için 100 gönderilmelidir. 
            Dim strCurrencyCode As String = "949"
            Dim strInstallmentCount As String = "" 'Taksit Sayısı. Boş gönderilirse taksit yapılmaz
            Dim strTerminalUserID As String = "xxxxxx"
            Dim strOrderID As String = "DENEME"
            Dim strCustomeripaddress As String = Request.UserHostAddress 'Kullanıcının IP adresini alır
            Dim strcustomeremailaddress As String = "eticaret@garanti.com.tr"
            Dim strTerminalID As String = "XXXXXXXX" 'TerminalID 
            Dim _strTerminalID As String = "0" & strTerminalID
            Dim strTerminalMerchantID As String = "XXXXXXX" 'Üye İşyeri Numarası
            Dim strStoreKey As String = "XXXXXXXX" '3D Secure şifreniz
            Dim strProvisionPassword As String = "XXXXXXXX" 'TerminalProvUserID şifresi
            Dim strSuccessURL As String = "https://<sunucu_adresi>/3DPayResults.aspx"
            Dim strErrorURL As String = "https://<sunucu_adresi>/3DPayResults.aspx"
            Dim SecurityData As String = UCase(GetSHA1(strProvisionPassword + _strTerminalID))
            Dim HashData As String = UCase(GetSHA1(strTerminalID + strOrderID + strAmount + strSuccessURL + strErrorURL + strType + strInstallmentCount + strStoreKey + SecurityData))

            mode.Value = strMode
            apiversion.Value = strApiVersion
            terminalprovuserid.Value = strTerminalProvUserID
            terminaluserid.Value = strTerminalUserID
            terminalmerchantid.Value = strTerminalMerchantID
            txntype.Value = strType
            txnamount.Value = strAmount
            txncurrencycode.Value = strCurrencyCode
            txninstallmentcount.Value = strInstallmentCount
            customeripaddress.Value = strCustomeripaddress
            customeremailaddress.Value = strcustomeremailaddress
            orderid.Value = strOrderID
            terminalid.Value = strTerminalID
            successurl.Value = strSuccessURL
            errorurl.Value = strErrorURL
            secure3dhash.Value = HashData

        End If
    End Sub

    Public Function GetSHA1(ByVal SHA1Data As String) As String

        Dim sha As SHA1 = New SHA1CryptoServiceProvider()
        Dim HashedPassword As String = SHA1Data
        Dim hashbytes As Byte() = Encoding.GetEncoding("ISO-8859-9").GetBytes(HashedPassword)
        Dim inputbytes As Byte() = sha.ComputeHash(hashbytes)
        Return GetHexaDecimal(inputbytes)

    End Function

    Public Shared Function GetHexaDecimal(ByVal bytes As Byte()) As String

        Dim s As New StringBuilder()
        Dim length As Integer = bytes.Length
        For n As Integer = 0 To length - 1
            s.Append([String].Format("{0,2:x}", bytes(n)).Replace(" ", "0"))
        Next
        Return s.ToString()

    End Function

End Class