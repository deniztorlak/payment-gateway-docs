Imports _PosnetDotNetTDSOOSModule

Partial Class Moduler_posnettds
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim posnetOOSTDSObj As New C_PosnetOOSTDS

        Dim custName As String = Request.Form.Get("custName")
        Dim xid As String = Request.Form.Get("XID")

        Dim ccno As String = Request.Form.Get("ccno")
        Dim expdate As String = Request.Form.Get("expdate")
        Dim cvv As String = Request.Form.Get("cvv")

        Dim amount As String = Request.Form.Get("amount")
        Dim currencyCode As String = Request.Form.Get("currency")
        Dim instalment As String = Request.Form.Get("instalment")
        Dim tranType As String = Request.Form.Get("tranType")
        Dim vftCode As String = Request.Form.Get("vftCode")

        Me.imageField.OnClientClick = "submitFormEx(formName, " & posnettds_config.OPEN_NEW_WINDOW & ", 'YKBWindow');"

        posnetOOSTDSObj.SetMid(posnettds_config.MERCHANT_ID)
        posnetOOSTDSObj.SetTid(posnettds_config.TERMINAL_ID)
        posnetOOSTDSObj.SetPosnetID(posnettds_config.POSNET_ID)
        posnetOOSTDSObj.SetKey(posnettds_config.ENCKEY)

        Me.amount.Text = posnettds_util.CurrencyFormat(amount, currencyCode, True)
        Me.instNumber.Text = instalment
        Me.XID.Text = xid

        If (Not posnetOOSTDSObj.CreateTranRequestDatas(custName, amount, currencyCode, instalment, xid, tranType, _
                                               ccno, expdate, cvv)) Then
            Response.Write("Posnet Data 'ları olusturulamadi (" + posnetOOSTDSObj.GetResponseText() + ")<br>")
            Response.Write("Error Code : " + posnetOOSTDSObj.GetResponseCode())
            Response.End()

        End If
        'Hidden fields
        Me.mid.Value = posnettds_config.MERCHANT_ID
        Me.posnetID.Value = posnettds_config.POSNET_ID
        Me.posnetData.Value = posnetOOSTDSObj.GetPosnetData()
        Me.posnetData2.Value = posnetOOSTDSObj.GetPosnetData2()
        Me.digest.Value = posnetOOSTDSObj.GetSign()
        Me.vftCode.Value = vftCode
        Me.merchantReturnURL.Value = posnettds_util.GetReturnURL(Request)
        Me.openANewWindow.Value = posnettds_config.OPEN_NEW_WINDOW
    End Sub

End Class
