Set pay = CreateObject("epayapi.payment")


'baglanti bilgileri
pay.name="testapi"
pay.password="TEST1234"
pay.clientid="521234567"


pay.host="testsanalpos2.est.com.tr"



pay.OrderResult=0
pay.oid="++++++"

pay.chargetype="Auth"

pay.subtotal="12.04"
pay.currency=978



pay.putextra "ORDERSTATUS","SOR"
retval=pay.processorder

wscript.echo "err: " & pay.err & Chr(13) & "errmsg: " & pay.errmsg & Chr(13) &"appr: " & pay.appr _
& Chr(13) &"OrderID: " & pay.oid & Chr(13) &"rrn: " & pay.refno & Chr(13) &"HostMsg: " & pay.Extra("HOSTMSG") & Chr(13) &"EXTRA: " & pay.extra("extra") & Chr(13)
