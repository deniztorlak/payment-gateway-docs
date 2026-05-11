Imports _PosnetDotNetTDSOOSModule

Partial Class Moduler_posnettds_resp
    Inherits System.Web.UI.Page

    Private message As String = "YKB Posnet <font color='#FF0000'>3D-Secure</font>  sisteminde, Kredi Kartı 'nızın doğrulaması yapılmıştır. İşlemi onlayıp, Kredi Kartı çekiminin yapılması için lütfen aşağıdaki linke tıklayınız. <BR>"
    Private message2 As String = "<font color='#FF0000'>3D-Secure</font> doğrulaması yapılamadığı için işleminize devam edilememektedir. Lütfen Kredi Kartı bilgilerinizi kontrol ediniz. <BR>"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Me.Table1.Rows.Item(3).Visible = False
        Me.Table1.Rows.Item(4).Visible = False

        Dim posnetOOSTDSObj As New C_PosnetOOSTDS

        Dim merchantPacket As String, bankPacket As String, sign As String, tranType As String

        merchantPacket = Request.Form.Get("MerchantPacket")
        bankPacket = Request.Form.Get("BankPacket")
        sign = Request.Form.Get("Sign")
        tranType = Request.Form.Get("TranType")
        
        Me.merchantPacket.Value = merchantPacket
        Me.bankPacket.Value = bankPacket
        Me.sign.Value = sign
        Me.tempTranType.Value = tranType

        posnetOOSTDSObj.SetMid(posnettds_config.MERCHANT_ID)
        posnetOOSTDSObj.SetTid(posnettds_config.TERMINAL_ID)
        posnetOOSTDSObj.SetPosnetID(posnettds_config.POSNET_ID)
        posnetOOSTDSObj.SetKey(posnettds_config.ENCKEY)
        posnetOOSTDSObj.SetURL(posnettds_config.XML_SERVICE_URL)
        'İşlem bilgilerinin çözümlenmesi
        If (Me.cctran.Value <> "") Then

            Dim WPAmount As String = posnettds_util.ConvertYTLToYKR(Request.Form("WPAmount"))
            If (WPAmount <> "") Then
                posnetOOSTDSObj.SetPointAmount(WPAmount)
            End If

            Response.Write("<html>")
            Response.Write("<head>")
            Response.Write("<META HTTP-EQUIV='Content-Type' content='text/html; charset=Windows-1254'>")

            Response.Write("<script language='JavaScript'>")

            Response.Write("function submitForm(form) {")
            Response.Write("	 form.submit();")
            Response.Write("}")

            Response.Write("</script>")

            Response.Write("<title>YKB - POSNET Redirector</title></head>")
            Response.Write("<body bgcolor='#02014E' OnLoad='submitForm(document.form2);' >")

            '3DS Kredi kartı onay İşlemini başlat
            posnetOOSTDSObj.ConnectAndDoTDSTransaction(merchantPacket, bankPacket, sign)

            Response.Write(" <form name='form2' method='post' action='" & posnettds_config.MERCHANT_RETURN_URL & "' >")
            Response.Write("   <input type='hidden' name='XID' value='" & posnetOOSTDSObj.GetXID() & "'>")
            Response.Write("   <input type='hidden' name='Amount' value='" & posnetOOSTDSObj.GetAmount() & "'>")
            Response.Write("   <input type='hidden' name='WPAmount' value='" & WPAmount & "'>")
            Response.Write("   <input type='hidden' name='Currency' value='" & posnetOOSTDSObj.GetCurrencyCode() & "'>")

            Response.Write("   <input type='hidden' name='ApprovedCode' value='" & posnetOOSTDSObj.GetApprovedCode() & "'>")
            Response.Write("   <input type='hidden' name='AuthCode' value='" & posnetOOSTDSObj.GetAuthcode() & "'>")
            Response.Write("   <input type='hidden' name='HostLogKey' value='" & posnetOOSTDSObj.GetHostlogkey() & "'>")
            Response.Write("   <input type='hidden' name='RespCode' value='" & posnetOOSTDSObj.GetResponseCode() & "'>")
            Response.Write("   <input type='hidden' name='RespText' value='" & posnetOOSTDSObj.GetResponseText() & "'>")

            Response.Write("   <input type='hidden' name='Point' value='" & posnetOOSTDSObj.GetPoint() & "'>")
            Response.Write("   <input type='hidden' name='PointAmount' value='" & posnetOOSTDSObj.GetPointAmount() & "'>")
            Response.Write("   <input type='hidden' name='TotalPoint' value='" & posnetOOSTDSObj.GetTotalPoint() & "'>")
            Response.Write("   <input type='hidden' name='TotalPointAmount' value='" & posnetOOSTDSObj.GetTotalPointAmount() & "'>")

            Response.Write("   <input type='hidden' name='InstalmentNumber' value='" & posnetOOSTDSObj.GetInstalmentNumber() & "'>")
            Response.Write("   <input type='hidden' name='InstalmentAmount' value='" & posnetOOSTDSObj.GetInstalmentAmount() & "'>")

            Response.Write("   <input type='hidden' name='VftAmount' value='" & posnetOOSTDSObj.GetVFTAmount() & "'>")
            Response.Write("   <input type='hidden' name='VftDayCount' value='" & posnetOOSTDSObj.GetVFTDayCount() & "'>")
            Response.Write(" </form>")
            Response.Write(" </body>")
            Response.Write(" </html>")
            Response.End()
        Else
            'İşlemin kredi kartı finansallanın başlatılması
            posnetOOSTDSObj.CheckAndResolveMerchantData(merchantPacket, bankPacket, sign)

            If (posnettds_util.ThreeDSecureCheck(posnetOOSTDSObj.GetTDSMDStatus())) Then
                Me.headerMessage.Text = message
            Else
                Me.headerMessage.Text = message2
            End If

            If (tranType = "SaleWP") Then
                Me.Table1.Rows.Item(3).Visible = True
            End If

            If (posnetOOSTDSObj.GetTDSMDStatus <> "9") Then
                Me.Table1.Rows.Item(4).Visible = True
            End If

            Me.tempTotalPointAmount.Value = posnetOOSTDSObj.GetTotalPointAmount()
            Me.tempAmount.Value = posnetOOSTDSObj.GetAmount()
            Me.cctran.Value = "1"
            Me.orderID.Text = posnetOOSTDSObj.GetXID()
            Me.amount.Text = posnettds_util.CurrencyFormat(posnetOOSTDSObj.GetAmount(), posnetOOSTDSObj.GetCurrencyCode(), True)
            Me.errorMessage.Text = posnetOOSTDSObj.GetResponseText()

            If (posnetOOSTDSObj.GetTotalPoint() = "-1") Then
                Me.totalPoint.Text = ""
                Me.totalPointAmount.Text = ""
            Else
                Me.totalPoint.Text = posnetOOSTDSObj.GetTotalPoint()
                If (Len(Me.totalPoint.Text) > 0) Then
                    Me.totalPoint.Text = CInt(Me.totalPoint.Text)
                End If
                Me.totalPointAmount.Text = posnettds_util.CurrencyFormat(posnetOOSTDSObj.GetTotalPointAmount(), posnetOOSTDSObj.GetCurrencyCode(), True)
            End If

            Me.currencyCode.Text = posnetOOSTDSObj.GetCurrencyCode()

            Try
                If (Int(posnetOOSTDSObj.GetTotalPointAmount()) = 0) Then
                    Me.WPAmount.Enabled = False
                End If
            Catch ex As InvalidCastException
                Me.WPAmount.Enabled = False
            End Try

            Me.tdsErrorCode.Text = posnetOOSTDSObj.GetTDSTXStatus()
            Me.tdsStatus.Text = posnetOOSTDSObj.GetTDSMDStatus()
            Me.tdsErrorMessage.Text = posnetOOSTDSObj.GetTDSMDErrorMessage()

            If (Not posnettds_util.ThreeDSecureCheck(posnetOOSTDSObj.GetTDSMDStatus())) Then
                Me.imageField.Visible = False
            End If

            Me.imageField.OnClientClick = "if(formKontrol()) { document.formResp.submit();this.disabled=true;} else {return false;}"

        End If
    End Sub
End Class
