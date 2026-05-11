Set pay = CreateObject("epayapi.payment")


'baglanti bilgileri

pay.clientid="800100000"
pay.name="DENIZTEST"
pay.password="TRps0030"
pay.ip="1.1.1.1"
pay.host="testsanalpos.est.com.tr"

'alisverisi yapanin ip'si
'pay.ip="192.168.0.13"

pay.OrderResult=0

'pay.oid="Sipariþ Numarasýný siz veya boþ býrakýp server kendisi atayabilir."

pay.oid=""


pay.chargetype="Auth"
pay.cardnumber="4242424242424242"
pay.expmonth="01"
pay.expyear="09"
pay.cv2="000"

pay.subtotal="12"
pay.currency=949

pay.taksit=""

retval=pay.processorder

wscript.echo "err: " & pay.err & Chr(13) & "errmsg: " & pay.errmsg & Chr(13) &"appr: " & pay.appr _
& Chr(13) &"HostMsg: " & pay.Extra("HostMsg") & Chr(13) &"OrderID: " & pay.oid & Chr(13) &"rrn: " & pay.refno

