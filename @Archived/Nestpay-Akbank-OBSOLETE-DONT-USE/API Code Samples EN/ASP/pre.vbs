Set pay = CreateObject("epayapi.payment")

'baglanti bilgileri
pay.name="esttest"
pay.password="EST741852"
pay.clientid="4444"
pay.host="testsanalpos.est.com.tr"


'alisverisi yapanin ip'si
'pay.ip="192.169.0.48"

pay.OrderResult=0

'pay.oid="BA_006"



pay.chargetype="PreAuth"
pay.cardnumber="4242424242424242"
pay.expmonth="01"
pay.expyear="09"
pay.cv2="000"

pay.bstate="CA"
pay.bcity="Istanbul"


pay.subtotal="12.04"
pay.currency=949

retval=pay.processorder

wscript.echo "err: " & pay.err & Chr(13) & "errmsg: " & pay.errmsg & Chr(13) &"appr: " & pay.appr _
& Chr(13) &"OrderID: " & pay.oid & Chr(13) &"rrn: " & pay.refno & Chr(13) &"HostMsg: " & pay.Extra("HOSTMSG")