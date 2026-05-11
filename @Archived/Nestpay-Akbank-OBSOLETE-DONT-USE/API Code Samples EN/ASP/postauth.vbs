Set pay = CreateObject("epayapi.payment")

'baglanti bilgileri
pay.name="DENIZTEST"
pay.password="TRps0030"
pay.clientid="80030"


pay.host="testsanalpos.est.com.tr"



pay.OrderResult=0
pay.oid="1171717909419-192.168.0.1-217"

pay.chargetype="PostAuth"

pay.subtotal="12.04"
pay.currency=949

retval=pay.processorder


wscript.echo "err: " & pay.err & Chr(13) & "errmsg: " & pay.errmsg & Chr(13) &"appr: " & pay.appr _
& Chr(13) &"OrderID: " & pay.oid & Chr(13) &"rrn: " & pay.refno & Chr(13) &"HostMsg: " & pay.Extra("HOSTMSG")