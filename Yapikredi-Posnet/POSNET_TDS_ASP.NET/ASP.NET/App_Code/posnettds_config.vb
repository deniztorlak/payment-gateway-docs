Imports Microsoft.VisualBasic

Public Class posnettds_config
    Public Const MERCHANT_ID As String = "6706022701"
    Public Const TERMINAL_ID As String = "67002703"
    Public Const POSNET_ID As String = "109"
    Public Const ENCKEY As String = "10,10,10,10,10,10,10,10"

    'OOS/TDS sisteminin web adresi
    Public Const OOS_TDS_SERVICE_URL As String = "http://kaan_oztemir_xp:7070/3DSWebService/YKBPaymentService"
    'Posnet XML Servisinin web adresi
    Public Const XML_SERVICE_URL As String = "http://kaan_oztemir_xp:7070/PosnetWebService/XML"

    'Üye İşyeri sayfası başlangıç web adresi (hata durumunda bu sayfaya dönülür.)
    Public Const MERCHANT_INIT_URL As String = "../merchant.html"
    'Üye İşyeri dönüş sayfasının web adresi
    Public Const MERCHANT_RETURN_URL As String = "http://localhost:1751/Posnet.NetOOSTDS/merchant_islem_sonu.aspx"

    Public Const OPEN_NEW_WINDOW As String = "0"

    '3D-Secure kontrolleri
    Public Const TD_SECURE_CHECK As Boolean = False
    Public Const TD_SECURE_CHECK_MASK As String = "1:2:4"
End Class
