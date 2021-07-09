Imports _PosnetDotNetModule

Partial Class _Aspxsample
    Inherits System.Web.UI.Page

    Protected Sub Submit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Submit.Click

        Dim posnetObj As New C_Posnet, result As Boolean = False

        Me.EventView.Text = ""

        posnetObj.SetURL(Me.HostURL.Text)
        posnetObj.SetMid(Me.MerchantID.Text)
        posnetObj.SetTid(Me.TerminalID.Text)

        If Me.trantype.SelectedItem.Value = "Sale" Then
            If Me.koicode.SelectedValue.Length > 0 Then
                posnetObj.SetKOICode(Me.koicode.SelectedValue)
            End If
            result = posnetObj.DoSaleTran(Me.ccno.Text, Me.expdate.Text, Me.cvc.Text, Me.orderid.Text, Me.amount.Text, Me.currencyCode.Text, Me.instNumber.Text)
        ElseIf Me.trantype.SelectedItem.Value = "Authorization" Then
            If Me.koicode.SelectedValue.Length > 0 Then
                posnetObj.SetKOICode(Me.koicode.SelectedValue)
            End If
            result = posnetObj.DoAuthTran(Me.ccno.Text, Me.expdate.Text, Me.cvc.Text, Me.orderid.Text, Me.amount.Text, Me.currencyCode.Text, Me.instNumber.Text)
        ElseIf Me.trantype.SelectedItem.Value = "Capture" Then
            result = posnetObj.DoCaptTran(Me.hostlogkey.Text, Me.authcode.Text, Me.amount.Text, Me.currencyCode.Text, Me.instNumber.Text)
        ElseIf Me.trantype.SelectedItem.Value = "Return" Then
            result = posnetObj.DoReturnTran(Me.hostlogkey.Text, Me.amount.Text, Me.currencyCode.Text)
        ElseIf Me.trantype.SelectedItem.Value = "Sale Rev" Then
            result = posnetObj.DoSaleReverseTran(Me.hostlogkey.Text, Me.authcode.Text)
        ElseIf Me.trantype.SelectedItem.Value = "Authorization Rev" Then
            result = posnetObj.DoAuthReverseTran(Me.hostlogkey.Text, Me.authcode.Text)
        ElseIf Me.trantype.SelectedItem.Value = "Capture Rev" Then
            result = posnetObj.DoCaptReverseTran(Me.hostlogkey.Text, Me.authcode.Text)
        ElseIf Me.trantype.SelectedItem.Value = "Return Rev" Then
            result = posnetObj.DoReturnReverseTran(Me.hostlogkey.Text, Me.authcode.Text)
        ElseIf Me.trantype.SelectedItem.Value = "Point Usage" Then
            result = posnetObj.DoPointUsageTran(Me.ccno.Text, Me.expdate.Text, Me.orderid.Text, Me.amount.Text, Me.currencyCode.Text)
        ElseIf Me.trantype.SelectedItem.Value = "Point Reverse" Then
            result = posnetObj.DoPointReverseTran(Me.hostlogkey.Text)
        ElseIf Me.trantype.SelectedItem.Value = "Point Inquiry" Then
            result = posnetObj.DoPointInquiryTran(Me.ccno.Text, Me.expdate.Text)
        ElseIf Me.trantype.SelectedItem.Value = "VFT Inquiry" Then
            result = posnetObj.DoVFTInquiry(Me.ccno.Text, Me.expdate.Text, Me.instNumber.Text, Me.vftcode.Text)
        ElseIf Me.trantype.SelectedItem.Value = "VFT Sale" Then
            If Me.koicode.SelectedValue.Length > 0 Then
                posnetObj.SetKOICode(Me.koicode.SelectedValue)
            End If
            result = posnetObj.DoVFTSale(Me.ccno.Text, Me.expdate.Text, Me.cvc.Text, Me.orderid.Text, Me.amount.Text, Me.currencyCode.Text, Me.instNumber.Text, Me.vftcode.Text)
        ElseIf Me.trantype.SelectedItem.Value = "VFT Sale Rev" Then
            result = posnetObj.DoVFTSaleReverse(Me.hostlogkey.Text, Me.authcode.Text)
        ElseIf Me.trantype.SelectedItem.Value = "KOI Inquiry" Then
            result = posnetObj.DoKOIInquiry(Me.ccno.Text)
        End If

        Me.EventView.Text &= ("XML Request : " & posnetObj.GetXMLRequest & ControlChars.NewLine & ControlChars.NewLine)
        If result Then
            Me.EventView.Text &= ("XML Response : " & posnetObj.GetXMLResponse & ControlChars.NewLine & ControlChars.NewLine)
        End If

        WriteResponseParamToEventView(posnetObj)

        Me.EventView.Focus()

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub WriteResponseParamToEventView(ByVal posnetObj As C_Posnet)

        Me.EventView.Text &= ("Approved Code : " & posnetObj.GetApprovedCode & ControlChars.NewLine)

        If posnetObj.GetResponseCode.Length > 0 Then
            Me.EventView.Text &= ("Error Code : " & posnetObj.GetResponseCode & ControlChars.NewLine)
        End If

        If posnetObj.GetResponseText.Length > 0 Then
            Me.EventView.Text &= ("Error Message : " & posnetObj.GetResponseText & ControlChars.NewLine)
        End If

        If posnetObj.GetHostlogkey.Length > 0 Then
            Me.hostlogkey.Text = posnetObj.GetHostlogkey
            Me.EventView.Text &= ("Hostlogkey : " & posnetObj.GetHostlogkey & ControlChars.NewLine)
        End If

        If posnetObj.GetAuthcode.Length > 0 Then
            Me.authcode.Text = posnetObj.GetAuthcode
            Me.EventView.Text &= ("Authcode : " & posnetObj.GetAuthcode & ControlChars.NewLine)
        End If

        If posnetObj.GetPoint.Length > 0 Then
            Me.EventView.Text &= ("Point : " & posnetObj.GetPoint & ControlChars.NewLine)
        End If

        If posnetObj.GetPointAmount.Length > 0 Then
            Me.EventView.Text &= ("Point Amount : " & posnetObj.GetPointAmount & ControlChars.NewLine)
        End If

        If posnetObj.GetTotalPoint.Length > 0 Then
            Me.EventView.Text &= ("Total Point : " & posnetObj.GetTotalPoint & ControlChars.NewLine)
        End If

        If posnetObj.GetTotalPointAmount.Length > 0 Then
            Me.EventView.Text &= ("Total Point Amount : " & posnetObj.GetTotalPointAmount & ControlChars.NewLine)
        End If

        If posnetObj.GetInstalmentNumber.Length > 0 Then
            Me.EventView.Text &= ("Instalment Number : " & posnetObj.GetInstalmentNumber & ControlChars.NewLine)
        End If

        If posnetObj.GetInstalmentAmount.Length > 0 Then
            Me.EventView.Text &= ("Instalment Amount : " & posnetObj.GetInstalmentAmount & ControlChars.NewLine)
        End If

        If posnetObj.GetVFTAmount.Length > 0 Then
            Me.EventView.Text &= ("VFT Amount : " & posnetObj.GetVFTAmount & ControlChars.NewLine)
        End If

        If posnetObj.GetVFTRate.Length > 0 Then
            Me.EventView.Text &= ("VFT Rate : " & posnetObj.GetVFTRate & ControlChars.NewLine)
        End If

        If posnetObj.GetVFTDayCount.Length > 0 Then
            Me.EventView.Text &= ("Day Count : " & posnetObj.GetVFTDayCount & ControlChars.NewLine)
        End If

        If posnetObj.GetCampMessageCount > 0 Then
            Me.EventView.Text &= ("KOI Campaigns :" & ControlChars.NewLine)
            For i As Integer = 1 To posnetObj.GetCampMessageCount
                Me.EventView.Text &= (i & ". [" & posnetObj.GetCampCode(i) & "] -- { " & posnetObj.GetCampMessage(i) & " }" & ControlChars.NewLine)
            Next
        End If

        If posnetObj.GetWorldCampMessageCount > 0 Then
            Me.EventView.Text &= ("World Campaigns Messages :" & ControlChars.NewLine)
            For i As Integer = 1 To posnetObj.GetWorldCampMessageCount
                Me.EventView.Text &= (i & ". { " & posnetObj.GetWorldCampMessage(i) & " }" & ControlChars.NewLine)
            Next
        End If

    End Sub

End Class
