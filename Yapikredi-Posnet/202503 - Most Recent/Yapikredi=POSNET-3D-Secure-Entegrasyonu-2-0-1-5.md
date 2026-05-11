# POSNET ThreeD Secure

# XML Servis

# Entegrasyonu


## Giriş

Bu dokümanda, POSNET TDS (3D Secure) sistemine entegrasyonun nasıl yapılabileceği
anlatılmaktadır. Paylaşılan servis url’leri test ortamı içindir. Gerçek ortama geçmek için gerekli
işlemlere doküman sonunda yer verilmiştir. Test ortamında testlerinizi tamamladıktan sonra canlı
ortama geçiş talebinizi posnet.support@yapikredi.com.tr adresine göndereceğiniz mail ile belirtmeniz
gerekmektedir. Göndereceğiniz mail ekinde örnek işlemleriniz için ayırt edici (MERCHANT_ID,
TERMINAL_ID, POSNET_ID, SOURCE_IP, ORDER_NO, TRANSACTION_DATE vb.) bilgilere ve işlem yaptığınız
tarihe yer vermeniz gerekmektedir.

POSNET sistemini kullanacak üye işyerlerinin hem test hem canlı ortam için Statik IP adreslerini
bankaya bildirmesi gerekmektedir.

Order id değeri 24 karakter yerine 1-24 karakter arası gönderilmek isteniyorsa veya aynı order
id’nin farklı tarihlerde kullanılma durumu olacak ise merchant üye işyeri için order id parametresinin
aktif edilmesi Posnet Support ekibinden talep edilmelidir. Order id parametresinin aktif olması
durumunda farklı günlerde aynı order id ile işlem gönderilebilir. Parametre aktifleştirilmesi işlemleri
için talebinizi posnet.support@yapikredi.com.tr adresine göndereceğiniz mail ile belirtmeniz
gerekmektedir.

Üye işyerinin hem kendi riskini azaltması hem de müşteri bilgilerinin güvenliğinin sağlanması için
3D Secure (3 boyutlu güvenlik) ödeme entegrasyonu yapması önerilmektedir. İptal İşlemi, İade İşlemi,
Puan İşlemleri, Kişiye Özel – Joker Vadaa’lı İşlemler, Vade Farkı işlemler POSNET XML Servisi
dokümanında anlatılmaktadır.

```
Entegrasyonun gerçekleşmesi için gereken adımlar 4 ana başlık altında toplanmaktadır.
```
1. **Verilerin Şifrelenmesi:** Kullanıcı alışverişini tamamlayıp ödeme aşamasına geldiğinde müşteri
    bilgileri, alışveriş bilgileri ve kredi kartı bilgileri YKB servislerine gönderilerek verileri şifrelenir.
    Şifreli posnetData, posnetData2 ve digest gibi bilgiler response içerisinde alınır.
2. **Kullanıcı Doğrulama (3D Secure):** Şifrelenmiş veriler banka servislerine gönderilerek kullanıcı
    doğrulaması yapılır. Bu adımda banka tarafında Ortak Ödeme Sayfası (OOS) ve/veya ThreeD
    Secure (TDS) doğrulama sayfası aracılığıyla işlemin bir kaydı oluşturulur. Kayıt sonrasında
    finansallaştırma için gereken bilgiler, üye işyeri sistemine şifreli olarak geri gönderilir.
3. **MAC/Kullanıcı Doğrulama Sonuç Sorgulanması:** İşleme özel MAC datası üye işyeri tarafından
    oluşturulur ve ek bilgiler ile banka servislerine gönderilir. Servis cevabında dönen verilerin
    1.adımda gönderilmiş verilerle aynı olduğu işyeri tarafından kontrol edilir. Böylelikle bilgilerin
    web sayfaları arasında doğru şekilde aktarıldığından emin olunur. Ayrıca OOS/TDS doğrulama
    işlem sonucu bu servis ile öğrenilmektedir. (Kart bilgilerini kendi ekranlarından alan ve TDS
    doğrulama yapmayan iş yerlerinin MAC doğrulama yapması gerekmektedir)
4. **Finansallaştırma:** Finansallaştırma işlemi için 2 .adımdan dönen bankData ve oluşturulacak
    MAC datası ilgili servise gönderilir. Servis cevabına göre işlemin sonucu kullanıcıya bilgi olarak
    verilir.

Finansallaştırma için kullanıcı doğrulamasının başlarıyla sonuçlanmış olması veya MAC datasının
doğrulanmış olması banka sistemlerinde kontrol edilmemektedir. İşyerinin bu kontrolleri
yapmamasından dolayı oluşacak risklerden dolayı banka sorumluluk kabul etmemektedir.

```
 POSNET sistemini kullanacak üye iş yerlerinin hem test hem canlı ortam için Statik IP
adreslerini bankaya bildirmesi gerekmektedir.
```

## Servis Genel Yapısı

Posnet XML servisi, posnet işyerlerinin XML dokümanları göndererek posnet işlemi yapmalarını
sağlayan bir servistir. İşyeri sistemlerinin ortam değişkeni olan <%XML_SERVICE_URL%> adresine
(test ortamı: https://setmpos.ykb.com/PosnetWebService/XML) oluşturdukları xml dokümanını UTF-
8 URL Encode ile encode ettikten sonra “xmldata” parametresinde Content-Type=application/x-
www-form-urlencoded; charset=utf- 8 ile POST etmesi gerekmektedir. İşlem sonucu yine bir XML
dokümanı olarak işyerine dönülür.

Örnek url:
https://setmpos.ykb.com/PosnetWebService/XML?xmldata=%3CposnetRequest%3E%0D%0A++%3C
mid%3E...

Servis entegrasyonunda yer alan aşağıdaki bilgiler üye iş yerlerine mail ile bildirilmektedir ve bu
bilgiler test ve canlı ortamlar arasında farklılık göstermektedir. Bu bilgilerin kod içerisinde gömülü
olarak tutulmaması, ortam değişkeni olarak tanımlanarak kullanılması önerilmektedir.

**_Key Type Description Sample Data_**
MERCHANT_ID String 10 haneli YKB üye işyeri
numarası

#### 6706598320

TERMINAL_ID String 8 haneli YKB üye işyeri
terminal numarası

#### 67005551

POSNET_ID String 16 haneye kadar YKB üye
işyeri POSNET numarası. 3D
Secure şifreleme
işlemlerinde
kullanılmaktadır.

#### 9644

ENCKEY String Şifreleme anahtarı (test
ortamı için sabittir)

#### 10,10,10,10,10,10,10,

#### OOS_TDS_SERVICE_U

#### RL

```
String Form yönlendirmesi
yapılacak banka banka
sayfası adresi
```
```
https://setmpos.ykb.com/3DSWeb
Service/YKBPaymentService
```
XML_SERVICE_URL String Banka entegrasyon servis
adresi

https://setmpos.ykb.com/PosnetW
ebService/XML
MERCHANT_INIT_URL String Üye işyerinin işlem yaptığı
web sitesi adresi

```
Localhost
```
MERCHANT_RETURN_
URL

```
String Form yönlendirmesinin geri
yapılacağı işyeri sayfa adresi.
Max 255 karakter
```
```
http://localhost:1453/JavaOOS/me
rchant_islem_sonu.jsp
```
OPEN_A_NEW_WIND
OW

```
Boolean POST edilecek formun yeni
bir sayfaya mı yoksa mevcut
sayfayı mı yönlendirileceğini
belirten parametre
```
#### 0

MERCHANT_ID, TERMINAL_ID, POSNET_ID, ENCYKEY bilgileri İşyeri Yönetici Ekranlarındaki Üye
İşyeri bilgileri sayfasından da öğrenilebilir.

```
NOTLAR:
```
```
 Yapılacak servis entegrasyonunda her Request Header’ına X-MERCHANT-ID, X-TERMINAL-ID,
X-POSNET-ID, X-CORRELATION-ID bilgileri eklenmelidir. (CorrelationId: işyeri tarafından set
edilecek işleme ait unique değerdir. Satış işlemleri için sipariş numarası (XID) set edilebilir)
```

```
 Servise gönderilecek datanın xml yapısını bozmaması için xml escape karakterleri encode
edilerek gönderilmelidir.
 Banka sistemlerinde UTF-8 encoding desteklenmektedir.
```
## 1. Verilerin Şifrelenmesi

Kullanıcı ödeme adımına geldiğinde, ödeme bilgileri ve kart bilgilerinin şifrelendiği adımdır.
Ödeme bilgileri tutar, para birimi, taksit sayısı, işlem tipi bilgilerden oluşmaktadır. Kart bilgileri ad
soyad, kart numarası, son kullanma tarihi, güvenlik kodu bilgilerinden oluşmaktadır. İşyeri kendi
ekranlarında kart bilgilerini kullanıcıdan almıyorsa bu bilgileri şifreleme servisine göndermez. Bu
durumda banka ortak ödeme sayfası aracılığıyla kullanıcıdan kart bilgilerini isteyecektir.

Verilerin şifrelenmesi için aşağıdaki XML yapısı (oosRequestData) oluşturulup UTF-8 URL Encode
ile encode edildikten sonra önüne “xmldata=” stringi eklenir.
xmldata=%3CposnetRequest%3E%0D%0A++%3Cmid%3E şeklinde başlayan string <%XML_SERVICE_URL%>
‘e Content-Type=application/x-www-form-urlencoded ile POST edilir.

Örnek url:
https://setmpos.ykb.com/PosnetWebService/XML?xmldata=%3CposnetRequest%3E%0D%0A++%3C
mid%3E...

_Request Örneği_

1. **<?xml** version="1.0" encoding="ISO- 8859 - 9" **?>**
2. **<posnetRequest>**
3. **<mid>** 6706022701 **</mid>**
4. **<tid>** 67002706 **</tid>**
5. **<oosRequestData>**
6. **<posnetid>** 142 **</posnetid>**
7. **<XID>** YKB_0000080603143050 **</XID>**
8. **<amount>** 5696 **</amount>**
9. **<currencyCode>** TL **</currencyCode>**
10. **<installment>** 00 **</installment>**
11. **<tranType>** Sale **</tranType>**
12. **<cardHolderName>** ĞğÜüİıŞşÖöÇç **</cardHolderName>**
13. **<ccno>** 5400637500005263 **</ccno>**
14. **<expDate>** 0607 **</expDate>**
15. **<cvc>** 111 **</cvc>**
16. **</oosRequestData>**
17. **</posnetRequest>**

**_posnetRequest - oosRequestData_**
Verilerin şifrelenmesi için kullanılacak servis desenini oluşturmaktadır. Servis sonucunda posnetData,
posnetData2 ve digest bilgilerine response içerisinden ulaşılacaktır.

**posnetRequest
mid** YKB Üye İşyeri Numarası <%MERCHANT_ID%>
**tid** YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
**oosRequestData
posnetid** YKB Üye İşyeri POSNET Numarası <%POSNET_ID%>
**XID** Tekil alışveriş sipariş numarası – 20 alfa numerik karakter. İşyeri tarafından
oluşturulur. Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
minimum 1 maksimum 24 karakter alphanumeric.
**amount** Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak set edilmelidir.
**currencyCode** Para birimi – “TL, US, EU”


**installment** Alışveriş taksit sayısı
Peşin İşlem için “00” kullanılmalıdır.
2 taksitli işlem için “02” kullanılmalıdır.
**tranType** İşlem Tipi
Sale  Satış
Auth  Provizyon
WP  World Puan Kullanım
SaleWP  Satış ve World Puan Kullanım
Vft  Vade Farklı Satış
**cardHolderName** Müşterinin adı soyadı
**ccno** Kredi kartı numarası
**expDate** Kredi kartı son kullanım tarihi – Formatı yıl ay olacak şekilde YYAA
**cvc** Kredi kartı güvenlik numarası – CVV
Kredi kartı bilgilerinin banka tarafından ortak ödeme sayfası aracılığı ile alınması isteniyorsa
cardHolderName, ccno, expDate, cvc alanlarına XML içerisinde yer verilmez veya boş bırakılır.

_Response Örneği_

1. **<?xml** version='1.0' **?>**
2. **<posnetResponse>**
3. **<approved>** 1 **</approved>**
4. **<respCode></respCode>**
5. **<respText></respText>**
6. **<oosRequestDataResponse>**
7. **<data1>** AEFE78BFC852867FF57078B723E284D1BD52EED8264C6CBD110A1A9EA5EAA7533D1A
    2EFD614032D686C507738FDCDD2EDD00B22DEFEFE0795DC4674C16C02EBBFEC9DF0F495D5E23BE487A
    8BF8293C7C1D517D9600C96CBFD8816C9D8F8257442906CB9B10D8F1AABFBBD24AA6FB0E5533CDE67B0D
    9EA5ED621B91BF6991D5362182302B781241B56E47BAE1E86BC3D5AE7606212126A4E97AFC2 **</data1>**
8. **<data2>** 69D04861340091B7014B15158CA3C83413031B406F08B3792A0114C9958E6F0F
    6C5EE32EAEEC7158BFF59DFCB77E20CD625 **</data2>**
9. **<sign>** 9998F61E1D0C0FB6EC5203A748124F30 **</sign>**
10. **</oosRequestDataResponse>**
11. **</posnetResponse>**

**_posnetResponse - oosRequestDataResponse_**
Şifrelenmiş veriler daha sonra kullanılmak üzere kaydedilmelidir.

**posnetResponse
approved** İşlem sonucu.
0:Başarısız
1:Başarılı
**respCode** Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata Kodları
bölümünde açıklamalara yer verilmiştir.
**respText** Hata mesajı.
**oosRequestDataResponse
data1** Ödeme bilgilerini içermektedir.
İlerleyen adımlarda **posnetData** değişkeni olarak kullanılacaktır.
**data2** Kart bilgileri request içerisinde bulunuyorsa bu alan oluşturulmaktadır.
İlerleyen adımlarda **posnetData2** değişkeni olarak kullanılacaktır.
**sign** Servis imzası.
İlerleyen adımlarda **digest** değişkeni olarak kullanılacaktır.


_Response Örneği (Hatalı)_

1. **<?xml** version='1.0' **?>**
2. **<posnetResponse>**
3. **<approved>** 0 **</approved>**
4. **<respCode>** 0002 **</respCode>**
5. **<respText>** XNIException: :::::1:261:cvc-datatype-
    valid.1.2.1: '569a' değeri 'integer' için geçerli bir değer değil. **</respText>**
6. **</posnetResponse>**

## 2. Kullanıcı Doğrulama (3D Secure)

Kullanıcının banka ekranlarına yönlendirilerek kart sahibi olduğunun doğrulandığı akışı
içermektedir. Kullanıcı ödeme aşamasına geldiğinde üye işyeri sistemi tarafından 1.adımda anlatıldığı
gibi bilgiler şifrelenir ve html form içine hidden field olarak diğer bilgilerle birlikte eklenir.

_Kullanıcının işyeri sisteminden OOS/TDS banka sayfalarına yönlendirilmesi_

1. **<input** name="mid" type="hidden" id="mid" value="<%=MERCHANT_ID%>" **>**
2. **<input** name="posnetID" type="hidden" id="PosnetID" value="<%POSNET_ID%>" **>**
3. **<input** name="posnetData" type="hidden" id="posnetData" value="<%=DATA1%>" **>**
4. **<input** name="posnetData2" type="hidden" id="posnetData2" value="<%=DATA2%>" **>**
5. **<input** name="digest" type="hidden" id="sign" value="<%=SIGN%>" **>**
6. **<input** name="vftCode" type="hidden" id="vftCode" value="<%=VFT_CODE%>" **>**
7. **<input** name="useJokerVadaa" type="hidden" id="useJokerVadaa" **>** <!-- Opsiyonel -->
8. **<input** name="merchantReturnURL" type="hidden" id=" merchantReturnURL" value="<%=MERC
    HANT_RETURN_URL%>" **>**
9. **<input** name="lang" type="hidden" id="lang" value="tr" **>**
10. **<input** name="url" type="hidden" id="url" value="" **>**
11. **<input** name="openANewWindow" type="hidden" id="openANewWindow" value="<%=OPEN_A_NEW_
    WINDOW%>" **>**

**_hiddenFields_**
Bir kısmı giriş bölümünde bahsedilen ortam değişkenlerinden, bir kısmı 1.adım servis cevabından alınan
verilerden oluşmaktadır. Form değişken id’leri büyük küçük harf hassasiyeti içermektedir.

**parametreler
mid** YKB Üye İşyeri Numarası <%MERCHANT_ID%>
**posnetID** YKB Üye İşyeri POSNET Numarası <%POSNET_ID%>
**posnetData** Alışveriş ile ilgili bilgilerin bulunduğu data bloğu (oosResponseData XML ‘i
kullanılarak elde edilir.)
**posnetData2** Kredi kartı ile ilgili bilgilerin bulunduğu data bloğu. ( **oosResponseData** XML ‘i
kullanılarak elde edilir.) Bu alan boş bırakıldığında ortak ödeme sayfası kullanıcıya
otm. olarak açılacaktır. Kullanıcının kart bilgilerini bu ekranda girmesi beklenir.
**digest** Gönderilecek FORM 'un imza bilgisi ( **oosResponseData** XML ‘i kullanılarak elde
edilir.)
**vftCode Vade Farklı işlemler** için kullanılacak olan kampanya kodunu belirler.
Üye İşyeri için tanımlı olan kampanya kodu, İşyeri Yönetici Ekranlarına giriş
yapıldıktan sonra, Üye İşyeri bilgileri sayfasından öğrenilebilinir.
**useJokerVadaa** Sadece TDS sistemini kullanacak Üye İşyerleri için, 3D-Secure doğrulamasından
önce Joker Vadaa(üye işyerlerine özel ek taksit ve öteleme kampanyaları)
sorgulamasını ve kullanımını aktif etmek için kullanılır.
Opsiyoneldir. Eğer kullanılmak istenmiyor bu field’a form içerisinde yer
verilmemelidir.
**merchantReturnURL** OOS/TDS sisteminden kart bilgileri alındıktan veya 3D-Secure işlemi


tamamlandıktan sonra, Üye İşyeri ‘nin sitesine yönlendirilecek olan sayfanın
adresi. Eğer ki, bu parametre kullanılmaz ise, Posnet Üye İşyeri Ekranları ‘ndaki
Üye İşyeri bilgileri sayfasında kayıt edilmiş olan adrese yönlendirme yapılmaya
çalışılır. Max 255 karakter <%MERCHANT_RETURN_URL%>
**lang** Posnet sistemindeki sayfaların dilini belirlemek için kullanılır.
tr:Türkçe
en:İngilizce
**url** Yönlendirilen sayfanın adresi (URL – bilgi amaçlı)
YKB tarafından verilen Java Script fonksiyonu ( **posnet.js** içerisindeki) tarafından
set edilir. Form içerisinde bulundurulması yeterlidir.
**openANewWindow** POST edilecek formun yeni bir sayfaya mı yoksa mevcut sayfayı mı
yönlendirileceğini belirten parametre
YKB tarafından verilen Java Script fonksiyonu tarafından set edilir.
<%OPEN_A_NEW_WINDOW%>

```
Hazırlanan sayfadaki formun yönlendirilmesi (POST edilmesi) için iki yöntem mevcuttur.
```
1. Yeni bir pencere açılıp, bu formun açılan yeni bir pencereye POST edilmesi. Pop-up
    blocker problemleri ile karşılaşılabilir ve browserlardaki cross-domain kontrollerinden
    dolayı üye işyerinin geri dönüş sayfasına mevcut pencere üzerinden yönlendirilememe
    sorunu görülebilir.
2. Mevcut pencerede oluşturulan formun YKB 'ye direkt POST edilmesi. ( **önerilir** )

Yönlendirme işleminin sağlıklı bir şekilde yapılabilmesi için YKB tarafından yazılmış bir JavaScript
fonksiyonu ( **submitForm** ) kullanılabilir. Bunun için
https://posnet.yapikredi.com.tr/3DSWebService/scriptler/posnet.js linkinde yer alan javascirpt
kodu işyeri sistemine indirilerek referans gösterilmelidir. Banka sayfasında barındırılan linkin
doğrudan kullanılması önerilmez.

1. **<script** language="JavaScript" src="https://isyeriadresi/posnet.js" **></script>**

İlgili JavaScript fonksiyonununda ( **submitForm** ) yönlendirme öncesindeki aşağıdaki işlemler
yapılmaktadır;

```
 “url” parametresinin, ilgili sayfanın adresi olarak set edilmesi,
 Yeni bir pencere açılacak ise, “openANewWindow” parametresinin “0” veya “1” olarak set
edilmesi,
 Yeni pencere açılacaksa ana pencereye geri yönlendirme yapmak için “window.name”
değerinin uygun olarak set edilmesi. Pencere boyutlarının ve özelliklerinin uygun değerlere
set edilerek açılması.
```
1. **function** submitFormEx(Form, OpenNewWindowFlag, WindowName) {
2. submitForm(Form, OpenNewWindowFlag, WindowName)
3. Form.submit();
4. }

Javascript kodu eklendikten sonra yönlendirme sırasında gönderilecek olan FORM ‘un ACTION
değeri aşağıdaki şekilde ortam değişkeni ile değiştirilmelidir.

1. **<form** name="formName" method="post" action="<%=OOS_TDS_SERVICE_URL%>" target="YKBWin
    dow" **>**


```
Form submit butonunun onlick event değerine ortam değişkeni set edilir.
```
1. **<input** type="submit" name="Submit" value="Ödeme Yap" onclick="submitFormEx(formName,
    <%=OPEN_A_NEW_WINDOW%>, 'YKBWindow')" **>**

Şifrelenmiş verilerin yer aldığı html form üye işyeri sisteminde oluşturularak submiti ile birlikte
kullanıcı banka ekranlarına yönlenmiş olur. Eğer form içerisindeki parametrelerde eksik, format
bozukluğu veya imza bilgisi yanlış ise yönlendirilen sayfada bir uyarı ekrana basılır.

```
Tüm field ve scriptler eklendiğinde doğrulama form sayfası aşağıdaki gibi bir html’den oluşacaktır.
```
1. <!DOCTYPE html **>**
2.
3. **<html** lang="en" xmlns="http://www.w3.org/1999/xhtml" **>**
4. **<head>**
5. **<meta** charset="utf-8" **/>**
6. **<title></title>**
7. **<script** type="text/javascript" src="https://posnet.yapikredi.com.tr/3DSWebServic
    e/scriptler/posnet.js" **></script>**
8. **<script** type="text/javascript" **>**
9. function submitFormEx(Form, OpenNewWindowFlag, WindowName) {
10. submitForm(Form, OpenNewWindowFlag, WindowName)
11. Form.submit();
12. }
13. **</script>**
14. **</head>**
15. **<body>**
16. **<form** name="formName" method="post" action="https://setmpos.ykb.com/3DSWebServic
    e/YKBPaymentService" target="YKBWindow" **>**
17. **<input** name="mid" type="hidden" id="mid" value="6706598320" **/>**
18. **<input** name="posnetID" type="hidden" id="PosnetID" value="9644" **/>**
19. **<input** name="posnetData" type="hidden" id="posnetData" value="7E2EAA9FCA48B
    499C65AB3B820148E7A31F234B439A01C9ECDE8D42101A0F104F985DB3C2D2DA8EA7E7A468030179E17B
    0632E13E3CE3D7C5096B7593BEE739BD07A0CDE5B46D05FB61FCEB4961F86DCB47B71E567D1E734C
    D6DB31C324151803F1D24D3259B4C28348566886DB82DC6DE2AEA0506FD38E0015403C1A3D52EE8E0CDA
    8B0043CAAAFE1A93A1B2CDCAD1B12BC7CA1E8A3CDA84EF" **/>**
20. **<input** name="posnetData2" type="hidden" id="posnetData2" value="7585932834B
    51D962D9CCEE5B5775FCDBDC84E5365F4248E79A453601934B855072D1E36535A8F40BF4F9D478B589AC
    46ECA928" **/>**
21. **<input** name="digest" type="hidden" id="sign" value="A531D6C260A4573F3753535E
    D50BE408" **/>**
22. **<input** name="vftCode" type="hidden" id="vftCode" value="" **/>**
23. **<input** name="useJokerVadaa" type="hidden" id="useJokerVadaa" value=" 1 " **/>** <!
    -- Opsiyonel -->
24. **<input** name="merchantReturnURL" type="hidden" id=" merchantReturnURL" value=
    "http://localhost:8081/3DSResultPage" **/>**
25. **<input** name="lang" type="hidden" id="lang" value="tr" **/>**
26. **<input** name="url" type="hidden" id="url" value="http://localhost:8080/Paymen
    t.html" **/>**
27. **<input** name="openANewWindow" type="hidden" id="openANewWindow" value="0" **/>**
28.
29. **<input** type="submit" name="Submit" value="Doğrulama Yap" onclick="submitForm
    Ex(formName, 0, 'YKBWindow')" **/>**
30. **</form>**
31. **</body>**
32. **</html>**

Submit edilen form içerisinde şifrelenmiş kart bilgileri (posnetData2) bulunmuyorsa banka ortak
ödeme sayfası aracılığı ile kullanıcıdan kart bilgilerini alınır.


Kullanıcı kart bilgilerini girerek Onayla butonuna bastığında ThreeD Secure doğrulama işlemi için
kart sahibi banka ekranına yönlenir. Banka tarafından gönderilen SMS kodunun kullanıcı tarafından
ekrana girilmesiyle doğrulama yapılmış olur.


3D-Secure doğrulama işleminin sonucunda kullanıcı üye işyerine sistemlerine geri yönlendirilir.
Bu yönlendirme sırasında, üye iş yerinin doğrulama sonucunu öğrenebilmesi ve ilgili işlemi
finansallaştırabilmesi için ek bilgiler HTML formunun içerisinde gönderilir. Bu aşama da işlem henüz
finansallaşmamış, sadece kullanıcı/kart doğrulaması yapılmıştır.

_Kullanıcının banka sayfalarından işyerine yönlenmesi_
Yönlendirilen form içerisinde aşağıdaki verilerin yer aldığı görülecektir. Bu verilerden
MerchantPackage, BankPackage ve Sign formdan okunarak finansallaştırma işleminde kullanılmak
üzere tutulmalıdır. Diğer bilgiler işyerinin entegrasyon ve işlem güvenliğini sağlayabilmesi için bilgi
amaçlı olarak paylaşılmaktadır ve işyeri sisteminin önceki adımlarda bildirdiği verilerden
oluşmaktadır.


**_HTML form içerisinde geri gönderilen bilgiler;_**
Bir kısmı giriş bölümünde bahsedilen ortam değişkenlerinden, bir kısmı 1.adım servisinden alınan
verilerden oluşmaktadır.

**parametreler
MerchantPacket** İşlem detayları datası (merchantData)
**BankPacket** İşlemin finansallaştırılması için kullanılacak data (bankData)
**Sign** Veri doğrulama bilgisi
**CCPrefix** İşlem yapılan kredi kartının ilk 6 hanesi. Bilgi amaçlı paylaşılmaktadır.
**TranType** İşlem tipi. Bilgi amaçlı paylaşılmaktadır.
**Amount** Alışveriş tutarı. Bilgi amaçlı paylaşılmaktadır.
**Xid** Tekil alışveriş sipariş numarası. Bilgi amaçlı paylaşılmaktadır.
**MerchantId** YKB Üye İşyeri Numarası. Bilgi amaçlı paylaşılmaktadır.

## 3. MAC/Kullanıcı Doğrulama Sonuç Sorgulanması

_MAC Datasının oluşturulması_
Kullanıcının banka tarafında ücretlendirileceği tutar ile işyeri tarafındaki sipariş tutarının
karşılaştırılabilmesi için MAC Datası oluşturulur. MAC Datası oluşturulurken işyeri tarafındaki tekil
işlem bilgileri ve ortam değişkenlerinden faydalanılmaktadır. SHA256 şifreleme algoritmasına UTF- 8
byte array’e dönüştürülmüş string verilir ve sonuç Base64String’e dönüştülerek HASH’leme
tamamlanmış olur. HASH’leme işlemi için öncelikle EncryptionKey (encKey) ve terminalId değerleri
arasına ‘;’ karakteri gelecek şekilde string birleştirme yapılır ve HASH’lenerek birinciHash oluşturulur.
Sonrasında xid, amount, currency, merchantNo ve birinciHash değerleri aralarına ‘;’ karakteri gelecek
şekilde tekrar string birleştirme yapılır ve HASH’lenir. Böylelikle MAC datasına ulaşılır.

_encKey: 10,10,10,10,10,10,10,_

_terminalID: 67005551_

değerleri kullanıldığında birincli hash _c1PPl+2UcdixyhgLYnf4VfJyFGaNQNOwE0uMkci7Uag=_ değerinin
oluştuğu görülmelidir.

_xid: YKB_TST_190620093100__

_amount: 175_

_currency: TL_

_merchantNo: 6706598320_

_firstHash: c1PPl+2UcdixyhgLYnf4VfJyFGaNQNOwE0uMkci7Uag=_

değerleri kullanıldığında MAC datasının _J/7/Xprj7F/KDf98luVfIGyUPRQzUCqGwpmvz3KT7oQ=_ değerinin
oluştuğu görülmelidir.

JAVA kod örneği

1. **private** String HASH(String originalString) **throws** Exception {
2. MessageDigest digest = MessageDigest.getInstance("SHA-256");
3. **byte** [] bytes = digest.digest(originalString.getBytes("UTF-8"));
4. **return** DatatypeConverter.printBase64Binary(bytes);
5. }
6.
7. String firstHash = HASH(encKey + ';' + terminalID);


8. String MAC = HASH(xid + ';' + amount + ';' + currency + ';' + merchantNo + ';' + fir
    stHash);

C# kod örneği

1. **private string** HASH(string originalString) {
2. using(SHA256 sha256Hash = SHA256.Create()) {
3. **byte** [] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(originalString));
4. **return** Convert.ToBase64String(bytes);
5. }
6. }
7.
8. **string** firstHash = HASH(encKey + ';' + terminalID);
9. **string** MAC = HASH(xid + ';' + amount + ';' + currency + ';' + merchantNo
    + ';' + firstHash);

PHP kod örneği

1. Function hashString($originalString){
2. **return** base64_encode(hash('sha256',$originalString,true));
3. }
4.
5. $firstHash = hashString($encKey. ";". $terminalID);
6. $MAC = hashString($xid. ";". $amount. ";". $currency. ";". $merchantNo. ";"
   . $firstHash);

_Kullanıcı Doğrulama İşleminin Sorgulanması_
TDS sisteminde, kullanıcı doğrulama bilgilerini girdikten sonra banka tarafında kullanıcının kaydı
oluşturulur ve HTML form içerisinde ek bilgiler ile üye işyeri tarafına yönlendirilir. Bu bilgiler şifrelidir
ve detaylara ulaşmak için **oosResolveMerchantData** servisi kullanılarak deşifre edilmesi
gerekmektedir. Request gönderilmeden önce, oluşturulan XML yapısı UTF-8 URL Encode ile encode
edildikten sonra önüne “xmldata=” stringi eklenir.
xmldata=%3CposnetRequest%3E%0D%0A++%3Cmid%3E şeklinde başlayan string <%XML_SERVICE_URL%>
‘e Content-Type=application/x-www-form-urlencoded ile POST edilir.

_Request Örneği_

1. **<?xml** version="1.0" encoding="ISO- 8859 - 9" **?>**
2. **<posnetRequest>**
3. **<mid>** 6706022701 **</mid>**
4. **<tid>** 67002706 **</tid>**
5. **<oosResolveMerchantData>**
6. **<bankData>** 87F491ACD24EAE64B519980F0B1BC7547BE4A7C5C614DC3A8CA3FC41B180EE
    851B081AAE61221956C0C68B0AD69307B4386C7FCE451C272264251BD72BFCBA0A96A197C38C6CD39DD
    42BC179FF098824AFA15B1BB320AD15DA2FB588ECC81B11A26D13764A57B57B49C4CA1BD5D46FA7E60EE
    D480C944AE0817 **</bankData>**
7. **<merchantData>** F57E38055C280283044612E7338A314758CE0BB13FE9CFF2D1ACD415A979C
    C65AD1FA664E561809F63262552496B491378DE688980EDFEF32785CB8090E0F3F618D560B4C2C089C7B
    9FBA8F91F1F4231D6725ECF8D94B18B0AA9EA206083D94BA1315DCC950E7E5BED2B3B5A1571C3E761E 23
    64E590CC6BB95BF4F1165208FA55CE99BDE6C7ACDEFB5A2A6F16B6C3838B9876F00EDF1E7261B626532E
    E81C40C9DE94588ED36FC4D2E639FA89152D1590A0031416BA8A31A1300EE37E31BD54B6ADA2FF7D4D
    EA0A4A1CC7 **</merchantData>**
8. **<sign>** 6C47DAAE1FC76EF98787548B6EBA3B5E **</sign>**
9. **<mac>** DF2323A3BMC782QOP42RT **</mac>**
10. **</oosResolveMerchantData>**
11. **</posnetRequest>**

**_posnetRequest - oosResolveMerchantData_**


Kullanıcı doğrulama sonucunun sorgulanması ve verilerin doğruluğunun teyit edilmesi için kullanılır.

**posnetRequest
mid** YKB Üye İşyeri Numarası <%MERCHANT_ID%>
**tid** YKB Üye İşyeri Termial Numarası <%TERMINAL_ID%>
**oosResolveMerchantData
bankData** 2.adımda yer alan kullanıcı doğrulama işlemi sonrasında banka ekranlarından
üye işyeri ekranlarına gönderilen html formdaki **bankPacket** verisi.
**merchantData** 2.adımda yer alan kullanıcı doğrulama işlemi sonrasında banka ekranlarından
üye işyeri ekranlarına gönderilen html formdaki **merchantPacket** verisi.
**sign** 2.adımda yer alan kullanıcı doğrulama işlemi sonrasında banka ekranlarından
üye işyeri ekranlarına gönderilen html formdaki **sign** verisi.
**mac** Üye işyeri ortamsal bilgiler ve tekil ödeme işlemine ait bilgilerin birleştirilmesi
ile oluşturulan sistemler arası işlem tutarı doğruluğunu garanti eden veridir.
UTF-8 ile url encode edilmelidir. Bknz: _MAC Datasının oluşturulması_

_Response Örneği_

1. **<?xml** version='1.0' **?>**
2. **<posnetResponse>**
3. **<approved>** 1 **</approved>**
4. **<respCode></respCode>**
5. **<respText></respText>**
6. **<oosResolveMerchantDataResponse>**
7. **<xid>** YKB_0000080603153823 **</xid>**
8. **<amount>** 5696 **</amount>**
9. **<currency>** TL **</currency>**
10. **<installment>** 00 **</installment>**
11. **<point>** 0 **</point>**
12. **<pointAmount>** 0 **</pointAmount>**
13. **<txStatus>** N **</txStatus>**
14. **<mdStatus>** 9 **</mdStatus>**
15. **<mdErrorMessage>** None 3D - Secure Transaction **</mdErrorMessage>**
16. **<mac>** ED7254A3ABC264QOP67MN **</mac>**
17. **</oosResolveMerchantDataResponse>**
18. **</posnetResponse>**

**_posnetResponse - oosResolveMerchantDataResponse_**
Banka tarafından merchantData verisi çözümlenir ve MAC Datası kontrolü ile bilgilerin güvenli bir şekilde
aktarıldığı teyit edilmiş olunur. Bu paketten deşifre (decrypt) edilerek elde edilen xid ve amount bilgileri ile iş
yeri tarafından satış işlemi aşamasına geçilirken (1.adım veri şifreleme) kullanılan xid ve amount bilgilerinin
birebir aynı olduğu mutlaka kontrol edilmelidir.

**posnetResponse
approved** İşlem sonucu.
0:Başarısız
1:Başarılı
**respCode** Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata Kodları
bölümünde açıklamalara yer verilmiştir.
**respText** Hata mesajı.
**oosResolveMerchantDataResponse
xid** Alışveriş sipariş numarası


**amount** Alışveriş Tutarı
Yeni kuruş cinsinden Ör: 1234  12.34 TL
**currency** Para Birimi
TL: Türk Lirası
US: Amerikan Doları
EU: Euro
**installment** Alışveriş Taksit Sayısı
Peşin işlem ise “00”
**point** İşlemde kullanılan kredi kartının sahip olduğu World Puan bilgisi Ör : 340
**pointAmount** İşlemde kullanılan kredi kartının sahip olduğu World Puan tutar bilgisi Ör : 170
 1.70 TL
**txStatus** ThreeD Secure İşlem Durumu
**mdStatus** ThreeD Secure Onay Durumu
0 : Kart doğrulama başarısız, işleme devam etmeyin
1 : Doğrulama başarılı, işleme devam edebilirsiniz
2: Kart sahibi veya bankası sisteme kayıtlı değil
3 : Kartın bankası sisteme kayıtlı değil
4 : Doğrulama denemesi, kart sahibi sisteme daha sonra kayıt olmayı seçmiş
5 : Doğrulama yapılamıyor
6 : 3 - D Secure hatası
7 : Sistem hatası
8 : Bilinmeyen kart no
9 : Üye İşyeri 3D-Secure sistemine kayıtlı değil (Bankada işyeri ve terminal
numarası 3d olarak tanımlı değil)
**mdErrorMessage** ThreeD Secure Hata Mesajı
**mac** Banka tarafında doğrulama sorgusuna istinaden oluşturulan hashlenmiş MAC
Data bilgisidir.
Cevabın bankadan döndüğü ve değiştirilmediğini görmek için işyeri tarafından
banka response MAC’i oluşturularak karşılaştırılmalıdır.

**msStatus** kullanıcı doğrulama (3D Secure) işleminin sonucunu belirtmektedir. Kullanıcı
doğrulaması yapıla **ma** mış bir işlem finansallaştırma adımı ile devam ettirilebilir ancak bu durumda
işyeri sorumluluğu kabul etmiş olur. Bu işlem 3d doğrulamasız (NonSecure) olarak adlandırılmaktadır.

**Point** ve **PointAmount** değerleri, **Satış + Puan Kullanımı (Karma)** işlem yapıldığında
kullanılmaktadır. Bu değerler, kart sahibinin kullanabileceği World Puan bilgilerini dönmektedir. **Satış
+ Puan Kullanımı** işlemi yapılırken, kart sahibinin ne kadar puan kullanacağı ( **wpAmount** ), **geri dönüş
sayfalarında** girilmektedir. Dolayısıyla, Üye İşyeri kendi sayfalarında bu değerleri göstererek,
kullanıcıya kullanabileceği kaç puanı olduğunu gösterip, bu değer doğrultusunda kullanıcının puanını
kullanmasını sağlayabilir.

**Point** ve **PointAmount** değerleri, diğer işlemler için “000000000” veya boş bir değer
dönmektedir. **Satış + Puan kullanımı** işlemi için ise; eğer ki puan sorgulama başarılı ise ilgili puan ve
puan tutarı bilgilerini, başarılı değilse “-1” değerlerini dönmektedir. Puan değerinin, “-1” olarak
gelmesi, ilgili kredi kartı puan bilgilerinin sorgulanamadığını göstermektedir. Ancak, puan bilgileri üye
işyerine geri dönülemediyse de, **Satış + Puan kullanımı** işlemine devam edilebilir.

_Banka Response MAC Datasının teyit edilmesi_
İş yerinin **oosResolveMerchantDataResponse** bilgisinin bankadan geldiğini teyit edebilmesi
amacıyla banka tarafından üretilen MAC Datası **oosResolveMerchantDataResponse** içerisine


konulmuştur. İşyeri sistemine banka MAC Datasını kendisi oluşturarak, response içerisinde yer alan
MAC Datası ile karşılaştırması tavsiye edilir. MAC karşılaştırması doğru sonuçlanmamışsa response
bankadan gelmemiş demektir. Bu durumda işleme devam edilmemesi gerekir.

1. String MAC = HASH(mdStatus + ';' + xid + ';' + amount + ';' + currency + ';' + merch
    antNo + ';' + HASH(EncKey + ';' + terminalID))

Mac değeri oluşturulurken kullanılan parametrelerden mdStatus için
**oosResolveMerchantDataResponse** objesindeki değer; xid, amount, currency, merchantNo, EncKey
ve TerminalID değerleri üye işyeri tarafında işleme ait oluşmuş ve 1.adımda şifreleme servisine
gönderilen ilk değerler kullanılmalıdır.

## 4. Finansallaştırma

İşlemin finansallaştırılabilmesi için 2.adım sonucunda kullanıcının işyeri sistemine yönlendirilmesi
esnasında HTML form içerisinde dönen şifreli **bankPacket** verisi kullanılır. Finansallaştırma işlemi için
aşağıdaki XML yapısı (oosTranData) oluşturulup UTF-8 URL Encode ile encode edildikten sonra önüne
“xmldata=” stringi eklenir. xmldata=%3CposnetRequest%3E%0D%0A++%3Cmid%3E şeklinde başlayan
string <%XML_SERVICE_URL%> ‘e Content-Type=application/x-www-form-urlencoded ile POST
edilir.

_Request Örneği_

1. **<?xml** version="1.0" encoding="ISO- 8859 - 9" **?>**
2. **<posnetRequest>**
3. **<mid>** 6706022701 **</mid>**
4. **<tid>** 67002706 **</tid>**
5. **<oosTranData>**
6. **<bankData>** 87F491ACD24EAE64B519980F0B1BC7547BE4A7C5C614DC3A8CA3FC41B180EE
    851B081AAE61221956C0C68B0AD69307B4386C7FCE451C272264251BD72BFCBA0A96A197C38C6CD39DD
    42BC179FF098824AFA15B1BB320AD15DA2FB588ECC81B11A26D13764A57B57B49C4CA1BD5D46FA7E60EE
    D480C944AE0817 **</bankData>**
7. **<wpAmount>** 0 **</wpAmount>**
8. **<mac>** DF2323A3BMC782QOP42RT **</mac>**
9. **</oosTranData>**
10. **</posnetRequest>**

**_posnetRequest - oosTranData_**
Verilerin geçerli olup olmadığını kontrol eder ve ilgili işlemi finansallaştırır.

**posnetRequest
mid** YKB Üye İşyeri Numarası <%MERCHANT_ID%>
**tid** YKB Üye İşyeri Termial Numarası <%TERMINAL_ID%>
**oosTranData
bankPacket** İşlemin finansallaştırılması için kullanılan data (bankData)
**wpAmount** 1.adımda veriler şifrelenirken işlem tipi SaleWP (Satış + Puan karma kullanım)
olarak set edilmişse kullanılır. Kuruş cinsindendir. Ör: 12.34 TL için 1234 olarak set
edilmelidir.

**mac** Üye işyeri ortamsal bilgiler ve tekil ödeme işlemine ait bilgilerin birleştirilmesi ile
oluşturulan sistemler arası işlem tutarı doğruluğunu garanti eden veridir. UTF-8 ile
url encode edilmelidir. Bknz: _MAC Datasının oluşturulması_


Finansallaştırma işlemi yapılmadan önce iş yerinin 3.adımda belirtilen Banka Response MAC
Datasının teyit edilmesi adımını gerçekleştirmiş olduğu var sayılır. Eğer işyeri ve banka arasındaki
entegrasyon bir şekilde kötü amaçlı yazılımlarla örnekleniyorsa bunu tespit etmenin yolu private key
kullanılarak yapılmış şifrelemelerin karşılaştırılmasıdır. Bu karşılaştırma işyeri sistemlerince
yapılmadığı durumda oluşacak iş yeri maddi kayba uğrayabilir.

oosTranData modelindeki mac verisinin oluşturulması için işyeri sistemlerinde üretilmiş olan XID
ve gerekli diğer bilgiler kullanılmalıdır.

1. String MAC = HASH(xid + ';' + amount + ';' + currency + ';' + merchantNo + ';' + HAS
    H(encKey + ';' + terminalID));

_Response Örneği_

1. **<?xml** version='1.0' **?>**
2. **<posnetResponse>**
3. **<approved>** 1 **</approved>**
4. **<respCode></respCode>**
5. **<respText></respText>**
6. **<mac>** DF2323A3BMC782QOP42RT **</mac>**
7. **<hostlogkey>** 0000000002P0806031 **</hostlogkey>**
8. **<authCode>** 901477 **</authCode>**
9. **<instInfo>**
10. **<inst1>** 00 **</inst1>**
11. **<amnt1>** 000000000000 **</amnt1>**
12. **</instInfo>**
13. **<pointInfo>**
14. **<point>** 00000228 **</point>**
15. **<pointAmount>** 000000000114 **</pointAmount>**
16. **<totalPoint>** 00000000 **</totalPoint>**
17. **<totalPointAmount>** 000000000000 **</totalPointAmount>**
18. **</pointInfo>**
19. **</posnetResponse>**

**_posnetResponse - instInfo - pointInfo_**
Kullanıcı hesabına finansal etki eden işlem sonucu yer almaktadır.

**posnetResponse
approved** İşlem sonucu.
0:Başarısız, onaylanmadı
1:Başarılı, onaylandı
2:Daha önce başarıyla onaylanmış
**respCode** Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır.
Hata Kodları bölümünde açıklamalara yer verilmiştir.
**respText** Hata mesajı.
**mac** Banka tarafından finansallaştırma talebine istinaden oluşturulan
hashlenmiş MAC Data bilgisidir.
**hostlogkey** Referans numarası
**authCode** Onay kodu
**instInfo - Taksit Bilgileri
inst1** Alışveriş taksit sayısı
**amnt1** Alışveriş taksit tutarı


Kuruş cinsindendir. Ör : 12.34 TL için 1234 olarak yer almaktadır.
**pointInfo - Puan Bilgileri
point** Kazanılan puan
**pointAmount** Kazanılan puan tutarı
Kuruş cinsindendir. Ör : 12.34 TL için 1234 olarak yer almaktadır.
**totalPoint** Kullanılabilir toplam puan
**totalPointAmount** Kullanılabilir toplam puan tutarı
Kuruş cinsindendir. Ör : 12.34 TL için 1234 olarak yer almaktadır.
**vft - VFT Bilgileri
vftAmount** İşlem için hesaplanan ek vade tutarı
Kuruş cinsindendir. Ör : 12.34 TL için 1234 olarak yer almaktadır.
**vftDayCount** İşlem için hesaplanan ek vade gün sayısı

oosTranData Response’un banka tarafından gönderildiğinin teyidi içinse response’da dönen mac’i üye
işyeri tarafında aşağıdaki gibi oluşturulan mac ile kontrol edilmesi tavsiye edilir.

1. String MAC = HASH(hostLogkey + ';' + xid + ';' + amount + ';' + currency + ';' + mer
    chantNo + ';' + HASH(EncKey + ';' + terminalID))


## 5. Hata Kodları

```
Yanlış parametre girilmesi veya posnete bağlanılması durumunda alınabilecek hata kodları ve
gerçekleştirilmesi gereken aksiyonlar aşağıda belirtilmiştir.
```
**_Hata Kodu Yapılması Gereken_**
**100 - OK** Posnet sunucuyla iletişim başarıyla kuruldu. Ancak bu sonuç kodu,
işlemin başarılı olduğu anlamına gelmez. İşlemin başarılı olup olmadığını
anlamak için sunucudan alınan yanıtın kontrol edilmesi gerekmektedir.
**101 - CONNECT_ERROR** Bağlanılan sunucu ip’si kontrol edilmelidir.
**103 - PACKET_ERROR** Posnet sunucu aldığı paketi çözümleyemediğinde bu hata dönülür.
Çözümleme işleminde kaynak ip (ownIP) kullanıldığından, bu
parametrenin internete çıkış ip'niz ile aynı olduğundan emin olunmalıdır.
IP Bazlı Hatalar sayfasındaki bilgiler de sorunu çözmenize yardımcı
olabilir.
**113 - CONNECT_CONNECT** Hostname parametresinin doğru set edildiği ve internet bağlantısı olduğu
kontrol edilmelidir. Firewall vs. erişimlerini kontrol etmek için Hostname
parametresine (adrese) telnet çekerek, erişim problemi olmadığı
görülmelidir. (Örneğin komut satırından: telnet 193.254.228.53 2222).
Telnet çekerken, port parametresine girilen değerin (dokümantasyonda
aksi belirtilmedikçe 2222) telnet komutuna da girildiğinden emin olun
(Posnet sunucuya ancak doğru porttan bağlanabilirsiniz, bu telnet için de
geçerlidir).

```
Posnet sunucusuna telnet de çekemiyorsanız internet bağlantınızda bir
sorun vardır. Örneğin firewall ayarlarınızda, posnet sunucuya doğru
porttan çıkış verildiğinden emin olmalısınız. Birçok firewall sadece http
(80) ve https (8080) portundan çıkış yapılmasına izin vermektedir. Bu
durumda izin verilen portlar arasına 2222'nin (veya dokümantasyonda
belirtilen bağlantı portunun) eklenmesi gerekir.
```
internet bağlantınızda da bir sorun yoksa test destek grubuyla iletişim
kurmalısınız.
**115 - CONN_REFUSED** Posnet sunucu bağlantı isteğinizi reddetti. Firmanızın Posnet sistemine
işlem gönderebileceği IP'ler listesinde bulunmayan bir ip'den işlem
denemiş olabilirsiniz. IP Bazlı Hatalar sayfasındaki bilgiler sorunu
çözmenize yardımcı olabilir.
**120 - CGI_SERVLET_ERROR** Bağlantı açıldı, ancak paket gönderilemedi.
**121 - EXCHANGE_TIMEOUT** Posnet sunucudan yanıt alınamadı. Internet bağlantınızda bir sorun
olabilir. Internet bağlantınızda bir sorun yoksa tekrar deneyin, sorun
devam ederse test destek birimini arayın.
**131 - ERROR_CCNO** Kart No parametresi hatalı. Parametre açıklamalarına bakın.
**132 - ERROR _HOSTLOGKEY** Hostlogkey parametresi hatalı. Parametre açıklamalarına bakın.
**133 - ERROR _AUTH** Onay kodu parametresi hatalı. Parametre açıklamalarına bakın.
**134 - ERROR _HOSTNAME** Hostname parametresi hatalı. Parametre açıklamalarına bakın.
**135 - ERROR _PORT** Port parametresi hatalı. Parametre açıklamalarına bakın.
**136 - ERROR _OWNIP** Ownip parametresi hatalı. Parametre açıklamalarına bakın.
**137 - ERROR _AMOUNT** Tutar parametresi hatalı.Tutar bilgisini göndermeden önce son iki
hanenin mutlaka kuruş olduğundan ve kuruş veya binler ayracı gibi
ayraçlar kullanılmadığından emin olmalısınız. Örneğin 5,12 TL göndermek
için 512 değerini, 5 TL göndermek için 500 değerini girmelisiniz.


**138 - ERROR _EXPDATE** Kredi kartı son kullanım tarihi parametresi hatalı. Parametre
açıklamalarına bakın.
**139 - ERROR _CVC** Kredi kartı güvenlik numarası (CVC) parametre hatalı. Parametre
açıklamalarına bakın.
**140 - ERROR _TAKNUM** Taksit parametresi hatalı. Taksit parametresi 2 karakter uzunluğunda ve
numerik olmalıdır. Ör: 02. Eğer taksit yapılmayacaksa 00 veya 01
girilmelidir.

Taksitli olması zorunlu işlemlerde (örneğin VFT) taksit parametresinin 00
veya 01 girilmesi de bu hataya neden olur.
**142 - ERROR _MIDNO** Üye ışyeri numarası (MID) parametresi hatalı. Parametre açıklamalarına
bakın.
**143 - ERROR _TIDNO** Terminal numarası (TID) parametresi hatalı. Parametre açıklamalarına
bakın.
**144 - ERROR _ORDERID** Sipariş numarası (ORDERID) parametresi hatalı. 20 karakter uzunluğunda
ve sadece harf ve rakamlardan oluşmalıdır. Bkz: Parametre açıklamaları.
**146 - ENCRYPTION ERROR** Şifreleme hatası. posnet.support@yapikredi.com.tr 'a mail atın.
**147 - CURRENCY CODE ERROR** Para birimi parametresi hatalı. CurrencyCode parametresine "TL" veya
"YT" değerleri dışında bir değer girildiğinde alınır. Bu hatanın en sık
nedeni parametre olarak "YTL" girilmesidir.
**156 - ERROR_VFT_CODE** VFT Kampanya Kodu hatalı. Fix 4 karakter uzunluğunda olması gerekiyor.
**180 - KATLI VE EKSTRA PUAN** Aynı işlemde hem kat hem ekstra puan belirtilemez. Ya kat puan
parametresini 00, ya da ekstra puan parametresini 000000 girmelisiniz.
**181 - ERROR_TXNSEQNO** TranSeqNo parametresi hatalı. Parametre açıklamalarına bakın.
**184 - ERROR_TRANTYPE** İşlem tipi parametresi hatalı. Parametre açıklamalarına bakın.
**185 - ERROR_BONUS** Puan işlem tipi hatalı.
**186 - ERROR_EXTRAPOINT** Ekstra puan parametresi hatalı. Parametre açıklamalarına bakın.
**187 - ERROR_MULTIPLE** Katlı puan parametresi hatalı. Parametre açıklamalarına bakın.

Parametrelerde ve posnet sistemiyle iletişimde sorun olmadığı halde (iletişim hatası = 100) işlem
onaylanmadığında alınabilecek hatalar ve gerçekleştirilmesi gereken aksiyonlar aşağıda belirtilmiştir.

```
Hata Kodu Açıklama Yapılması Gereken
0001 BANKANIZI ARAYIN 0001 Kart bu tip işleme izin vermiyor veya kartın kredisi
yetersiz. Kartı veren bankayı arayın.
0004 RED-KARTA EL KOY 0004 Kart Bloke edilmiş.
0005 RED-ONAYLANMADI Kart bilgilerinden ( KK No, SKT, CVV) biri yada birkaçı hatalı
girilmiş veya Worldcard'lar için bankaca tanımlanmış
günlük limitler aşılmış olabilir.
```
```
Kart bilgilerinin doğru girildiğinden emin olmak amacıyla,
İşyeri Yönetici Ekranlarındaki “Online İşlemler”
sayfasından bir deneme işlemi yapılabilir. Bu işlemde de
bu hatanın alınması kart bilgilerinin doğru gönderildiği
anlamına gelir.
```
```
Bu hatanın bir diğer nedeni de, kart sahibi banka
tarafından belirlenen internetten günlük işlem yapma
limitinin kart için dolmasıdır. Bu limit her bankaya göre
değişmektedir ve YKB kredi kartları için 3'tür; yani bir YKB
```

```
kredi kartı günde en fazla 3 internet alışverişinde
kullanılabilir. Bu limit aşıldıysa, kart sahibi kendi
bankasının kredi kartı müşteri hizmetlerini arayarak bu
limiti sıfırlamalıdır.
```
Girilen tutar finansallaştırma işleminde provizyon
tutarından, iade işleminde de finansallaştırma tutarından
büyük olamaz.
**0007** BANKANIZI ARAYIN 0007 Kart bloke/çalıntı/kayıp statüsünde olabilir (özel durum).

**0012** RED-GECERSIZ ISLEM Bu hatanın en sık rastlanan nedeni, yanlış miktarda taksit
sayısıyla taksit yapmaya çalışmanızdır. En fazla kaç taksit
yapabileceğinizi öğrenmek için 444 0 448'i aramalısınız.
Eğer test kartlarıyla işlem yapıyorsanız, bu bilgiyi
posnet.support@yapikredi.com.tr adresinden
öğrenebilirsiniz. Genellikle normal işlemler için en fazla 9
taksit yapılabilmektedir.

```
0012 almanızın bir diğer nedeni de kullanılan kartın
müsaade etmediği bir işlem yapmanızdır. Örneğin başka
bankaya ait bir kredi kartına taksit yapmaya çalıştığınızda
bu hatayı alırsınız.
```
Bu adımlar sorunu çözmenize yardımcı olamadıysa,
bankamızdaki üye işyeri tanımlamalarınızda sorunlar
olabilir. Üye işyeri servisimizi arayıp üye işyeri no.nuzu ve
hangi işlemi yaparken bu hatayı aldığınızı bildirmeniz
gerekmektedir.
**0014** RED-HATALI KART 0014 Numara bir kredi kartına ait değil / Kart no hatalı.
**0015** PROVIZYON BULUNAMADI Provizyon alınmamış. Provizyon iptal edilmiş olabilir.
Tekrar provizyon almalısınız.
**0015** TERMINAL IŞLEM YETKISI YOK Terminal yetkisi işlem için uygun değil.
**0015** IŞYERI STATÜSÜ HATALI Işyeri statüsü uygun değil.
**0015** TAKSIT IÇIN YETERSIZ TUTAR Taksit için girilen tutar minimum tutarında altında ise bu
hata verilir.
**0030** BANKANIZI ARAYIN 0030 Bu hatanın nedeni kartı veren (issuer) bankanın YKB
provizyon sistemine gönderdiği bozuk verilerdir. Kartı
veren banka aranmalı ve bir sanal pos işleminde bu
hatanın alındığı belirtilmelidir. Hata çözümleninceye kadar
sorunun geçici çözümü amacıyla, işlem mail order yoluyla
YKB'ye gönderilebilir. Mail order yapmak için üye işyeri
servisimizi arayınız.
**0041** RED-KARTA EL KOY 0041 Kayıp Kart - (444 0 448)' i arayınız.
**0043** RED-KARTA EL KOY 0043 Sorunun nedeni işlemde kullanılan kredi kartının YKB
provizyon sisteminde tutulan **çalıntı kredi kartı listesi** nde
bulunmasıdır. Işlem kart sahibi bankaya iletilmeden
reddedilmektedir.

```
Sanal POS işlemlerinde kullanılan kredi kartları, çeşitli
nedenlerle YKB tarafından karaliste benzeri bir listeye
alınabilmektedir. Eğer kartın çalıntı listesinde
bulunmasının yanlış olduğunu (kartın güvenilir bir kart
```

olduğunu) düşünüyorsanız, YKB Üye Işyeri Operasyon
Servisi'ni (444 0 448) aramalısınız.
**0051** RED-YETERSIZ BAKIYE 0051 Kartın bakiyesi yetersiz. Kartı veren bankayı arayın.
**0053** BANKANIZI ARAYIN 0053 Hesap bulunamadı.
**0054** RED-ONAYLANMADI 0054 Son kullanım tarihi geçmiş olan kart.
**0057** RED-ONAYLANMADI 0057 Yapılan işlem, kullanılan kart tipi ile yapılamaz
(Debit/kredi). Örnek: POSNET’ten debit kartla (ATM'lerden
para çekmek için kullanılan banka kartları) işlem
yapılamaz. Hata mesajında “X” olarak belirtilen yerde,
işlemin yapıldığı kartın tipi belirtilir (D: Debit/K: Kredi
kartı).
**0057** RED-ONAYLANMADI 0057 Bu hata, işlemde kullanılan kredi kartının internetten işlem
yapma yetkilerinde bir sorun olduğu durumda alınır. Kart
sahibi kredi kartını aldığı bankanın kredi kartları servisiyle
görüşüp kredi kartını e-ticarette kullanamadığını
belirtmelidir.
**0058** RED-ONAYLANMADI 0058 Terminalin işlem tipine yetkisi yok.
**0062** RED-ONAYLANMADI 0062 Kısıtlı kart.
**0065** RED-ONAYLANMADI 0065 Kredi kartının para çekme limiti aşıldığında verilen bu
hata, normal durumlarda sanal pos işlemlerinde
dönülmemelidir. Bu hatanın alınması durumunda kartı
veren (issuer) banka aranmalı, bir sanal pos işleminde bu
hatanın alındığı belirtilmelidir. Hata çözümleninceye kadar
sorunun geçici çözümü amacıyla, işlem mail order yoluyla
YKB'ye gönderilebilir. Mail order yapmak için üye işyeri
servisimizi arayınız.
**0091** BANKANIZI ARAYIN 0091 Kartı veren (issuer) banka ile iletişimde zaman aşımı oldu
(bankadan zamanında yanıt alınamadı). Tekrar deneyin;
sorun devam ederse, kartı veren bankayı arayıp, bir sanal
pos işleminde bu hatanın alındığını belirtin.
**0100** HOST RECEIVE PROBLEM Bu hata bazen banka sistemlerimizde anlık sorunlar
olduğunda alınabilmektedir. Tekrar deneyin, sorun devam
ederse posnet.destek@ykb.com adresiyle iletişime geçin.

Test ortamında bu hata alınıyorsa, sorunun nedeni
kullanılan test kartının tanımlarının silinmesi olabilir. Bu
olasılığı ortadan kaldırmak için birkaç farklı test kartıyla
işlem denemeniz gerekebilir.
**0122** DATABASE DE ISTENILEN KAYIT
YOK

```
Iptal işleminde hata. Iptal işlemi provizyon işleminden 1
hafta sonrasına kadar yapılabilir. Finansallaştırma
yapılmadan finansallaştırma iptal yapıldığında da bu hata
alınabilir.
```
Bu hatanın bir nedeni de daha önce firmanıza ait bir mid
ile yaptığınız bir işlemi, firmanıza ait başka bir mid
kullanarak finansallaştırmak veya iptal etmek istemenizdir.
Bunun en sık rastlanan yolu, bir mid kullanılarak yapılmış
bir işlemin programsal olarak başka bir mid kullanılarak
finansallaştırılması veya iptal edilmesidir.
**0123** ORJINAL ISLEM BULUNAMADI Finansallaştırma, iptal veya iade edilmeye çalışılan işlem
bulunamadı. Muhtemelen yanlış YKB ref.no veya sipariş


```
no ile finansallaştırma/iptal yapmaya çalışıyorsunuz.
Finansallaştırmaya/iptal etmeye çalıştığınız işlem Posnet
sistemine hiç gönderilememiş de olabilir.
```
```
VFT işlemlerinin iptalinde YKB ref.no ile iptal yapılıyorsa
onay kodu (authCode) kontrolü de yapılmaktadır. Bu
iptallerde bu hata alınıyorsa YKB ref.no ile birlikte onay
kodu da kontrol edilmelidir.
```
```
Bir işlem için Posnet sisteminden yanıt alınamadığında,
otomatik olarak iptal gönderilmesi üzerine bu hata
alınması normaldir; bu durum, işlemin Posnet sistemine
hiç ulaşmadığını gösterir.
0124 HOST SESSION OPEN PROBLEM Bu hata, bankamızın ortamlarından kaynaklanmaktadır.
Bazen bankamız ortamlarındaki çalışmalar nedeniyle anlık
kesintiler yaşanabilmektedir. Bu hata alındığında işlem bir
süre sonra tekrar denenmeli, sorun devam ederse
posnet.destek@ykb.com adresiyle irtibata geçilmelidir.
0125 ORDERID VAR HOSTLOGKEY YOK
DB ERR
```
```
YKB’yi arayın.
```
```
0126 ORDERID VAR KK SIFRELEME
HATASI
```
```
YKB’yi arayın.
```
```
0127 ORDERID DAHA ONCE
KULLANILMIS
```
```
Kullandığınız sipariş no (orderId) daha önce kullanılmış.
Yeni bir sipariş no ile tekrar deneyin.
0129 KREDI KARTI MERCHANT
BLACKLIST TE
```
Bu kredi kartı işyeri karalistesine alınmış. Kartın bu işyeri
tarafından kullanılabilmesi için önce karalisteden
çıkarılması gerekiyor.
**0146 *** HATALI SIFRELEME: KULLANICI
ISMI & SIFRE veya NO
GENERATED RECORD

Kullanıcı adı, şifre veya şifreleme anahtarı yanlış
girilmektedir. Ayrıntılı bilgi için StubF1Class.setUserName,
StubF1Class.setPassword,
StubF1Class.setEncKey metodlarına bakınız. İşyeri Yönetici
Ekranlarının ana menüsündeki "Anahtar Yarat" linki
kullanılarak yeni kullanıcı adı, şifre ve anahtar oluşturulup,
bu bilgilerle işlem tekrar denenmesi gerekir.
**0147 *** HATALI KULLANICI ISMI & SIFRE 146 hatasının açıklamalarına bakın.
**0148 *** CRYPTO HATASI: MID Web sunucunuzun tarihi, saati veya TimeZone bilgisi yanlış
olabilir. Bu bilgilerde bir sorun yoksa Teknik Destek
birimimize başvurulmalıdır.

Gönderdiğiniz bilgileri karşılayan Posnet Servisi, bazı şifreli
bilgilerin açılmasında tarih ve saatten faydalanmaktadır.
Sunucunuzun tarih veya saatinin yanlış olması durumunda
bu bilgiler servis tarafından çözümlenememektedir.
**0148 *** HATALI MID Üye işyeri no bulunamadı. Üye işyeri no (MID) parametresi
yanlış.
**0148 *** MID,TID,IP HATALI: X.X.X.X Bağlantı yaparken kullandığınız mid (üye işyeri no) yanlış
veya izin verilmemiş bir ip'den bağlantı yapmaya
çalışıyorsunuz. Yanlış ortama (örneğin üretim ortamı mid'i
ile test ortamına) işlem göndermeniz de bu soruna neden
olur.


```
Test ortamı için
https://setmpos.ykb.com/PosnetWebService/XML
üretim ortamı için
https://posnet.yapikredi.com.tr/PosnetWebService/XML
adresine işlem göndermelisiniz.
```
Işleminizi doğru ortama gönderdiğinizden eminseniz, hata
mesajında X.X.X.X şeklinde belirtilen istek ip'nizi
posnet.destek@ykb.com adresine mid/tid bilgisiyle
birlikte göndererek ip tanımınızın değiştirilmesini
sağlayabilirsiniz.
**0150** PAKET HATALI Yanlış CVC no kullanılmış. Üretim ortamında, test
ortamında kullanılan XXX kullanılmışsa bu hata alınır.
Üretim ortamında CVC kodları müşteriniz tarafından
girilmelidir. Ayrıca test ortamında XXX dışında anlamsız bir
CVC (xxx gibi) girilmesi de bu hataya neden olur.
**0150** INVALID MID TID IP Yanlış bir ip'den veya yanlış bir mid/tid ile işlem yapmaya
çalışıyorsunuz. IP Bazlı Hatalar sayfasındaki bilgiler sorunu
çözmenize yardımcı olabilir.
**0200** GECERSIZ ISLEM Geçersiz bir işlem gönderdiğinizde alınır. Örneğin zaten
finansallaştırılmış bir işlemi tekrar finansallaştırmaya veya
provizyon durumundaki bir işlemi iade etmeye çalışmak.
Bu tür hatalı işlemlere İşyeri Yönetici Ekranlarında zaten
izin verilmez, ancak programsal olarak gönderilen (ASP
gibi bir teknoloji kullanılarak) işlemlerde bu kontrol
yapılmaktadır.
**0205** GECERSIZ TUTAR Bu hata şu koşullarda alınmaktadır:

```
 Yapılan işlemin tutarı maksimum işlem tutarını
(99.999,99 TL) aştığında.
Posnet sisteminde bir defada en fazla 99.999,99
TL'lik işlem yapılabilir.
 Finansallaştırma işlemi yapılırken gönderilen işlem
tutarı, provizyon işlem tutarını "provizyon aşım
yüzdesi"nden fazla aştığında
 Tüm iade işlemlerinde, gönderilen işlem tutarı
iade edilebilecek işlem tutarını aştığında
```
**0211** GRUP KAPAMA YAPILMIS Bu hata finansallaşma veya satış iptal işlemini yaparken
alınır. Iptal etmek istediğiniz işlemin finansallaştırıldığı için
artık iptal edilememektedir. Yapmış olduğunuz
finansallaştırma veya satışı iade etmek için iade işlemi
yapmalısınız.
**0217** GEÇERSIZ IŞLEM STATÜSÜ Çalıntı kart. Kullanıcı ve kart no YKB’ye bildirilmelidir.
**0220** IPTAL ISLEMI YAPILMIS Zaten iptal edilmiş bir işlem tekrar iptal edilmeye
çalışıldığında alınır.
**0223** ONAYLANMADI Finansallaştırma yapılmadan finansallaştırma iptal
yapılmak isteniyor.
**0232** KREDIKARTI IŞLEM SINIRI AŞILDI Posnet sisteminde Üye Işyeri tarafından tanımlanmış, belli
bir periyotta bir kredi kartı ile işlem yapılabilecek


```
maksimum sayı aşıldığı vakit ilgili hata oluşur. Bkz. Işlem
Kısıtlama
0370 ISLEM IPTALI YAPILMIS Iptal işlemi zaten yapılmış.
0400 DB ERROR Posnet sunucu teknik bir sorun yaşıyor. Tekrar deneyin,
sorun tekrar ederse teknik destek ile iletişim kurun.
0411 ISLEM HENUZ
FINANSALLASMAMIS
```
```
Iade yaparken alınan bu hata, finansallaştırma işleminde
belirtilen tutarın henüz karttan tahsil edilip hesabınıza
yansımadığını gösterir. Bu nedenle iade işlemi yapmanıza
gerek yoktur, finansallaştırma iptal yapmalısınız.
0444 BANKANIZI ARAYIN YKB’yi arayın.
0450 IADE ISLEMI YAPILAMIYOR İşyeri yönetici ekranları dışından iade edilmiş olabilir.
Işlemi daha önce üye işyeri servisimizi arayarak iade etmiş
olabilirsiniz. Eğer böyle bir iade talebiniz olmadıysa, üye
işyeri servisimizi aramanız gerekmektedir.
0788 FINANSAL ISLEM YAPILMIS Finansallaştırma yapılmış. Provizyon iptal edilmek
isteniyorsa önce finansallaştırma iptal edilmeli.
```
## Canlı Ortama Geçiş Adımları

Test ortamında testlerinizi tamamladıktan sonra canlı ortama geçiş talebi
posnet.support@yapikredi.com.tr adresine gönderecek mail ile belirtilmelidir. Gönderilecek mail
ekinde örnek işlemler için ayırt edici (MERCHANT_ID, TERMINAL_ID, POSNET_ID, SOURCE_IP, ORDER_NO,
TRANSACTION_DATE vb.) bilgiler ve işlem yapılan tarih(ler)e yer verilmelidir.

Posnet sistemlerine gönderilmiş işlemler için her Request Header’ında X-MERCHANT-ID, X-
TERMINAL-ID, X-POSNET-ID, X-CORRELATION-ID bilgileri eklenmiş olduğundan emin olunmalıdır.

1. İşyeri yönetim ekranları aracılığı ile MERCHANT_ID, TERMINAL_ID, POSNET_ID bilgileri
    öğrenilir.
2. İşyeri canlı ortam uygulamasına ortam değişkenleri ve XML_SERVICE_URL, kullanılıyorsa
    OOS_TDS_SERVICE_URL eklenir.
3. Canlı ortam IP bilgileri işyeri yönetim ekranları aracılığı ile sisteme tanımlanır.

Ortam değişkeni olarak tanımlanmış olan değişkenler canlı ortamda kullanılacak şekilde işyeri
uygulama konfigürasyonları güncellenir.

**_Key Type Description Sample Data_**
MERCHANT_ID String 10 haneli YKB üye işyeri
numarası

#### 6706598320

TERMINAL_ID String 8 haneli YKB üye işyeri
terminal numarası

#### 67005551

POSNET_ID String 16 haneye kadar YKB üye
işyeri POSNET numarası. 3D
Secure şifreleme
işlemlerinde
kullanılmaktadır.

#### 9644

XML_SERVICE_URL String Banka entegrasyon servis
adresi

https://posnet.yapikredi.com.tr/Po
snetWebService/XML
OOS_TDS_SERVICE_U
RL

```
String Banka ortak ödeme ve 3D
Secure sayfa adresi
```
```
https://posnet.yapikredi.com.tr/3D
SWebService/YKBPaymentService
```

ENCKEY String Şifreleme anahtarı <%LIVE_ENCKEY %>
MERCHANT_INIT_URL String Üye işyerinin işlem yaptığı
web sitesi adresi

```
https://www.example.com
```
MERCHANT_RETURN_
URL

```
String Form yönlendirmesinin geri
yapılacağı işyeri sayfa adresi.
Max 255 karakter
```
```
https://www.example.com/Payme
ntResult
```
OPEN_A_NEW_WIND
OW

```
Boolean POST edilecek formun yeni
bir sayfaya mı yoksa mevcut
sayfayı mı yönlendirileceğini
belirten parametre
```
#### 0

İşyeri 3D güvenli ödeme yapıyorsa veya Posnet’in sağladığı ortak ödeme sayfasını kullanıyorsa 3D
Secure (3 Boyutlu Güvenlik) aktif demektir ve işyerinin müşterisi yani son kullanıcı işyeri
ekranlarından banka ekranlarına yönlendirilecek ve banka ekranlarındaki güvenlik ve doğrulama
adımlarından geçtikten sonra tekrar işyeri ekranına geri gönderilecektir. Müşterinin networkler
arasındaki geçişi güvenlik açığı yaratmaması için 3DS ödeme akışlarında MAC doğrulaması
yapılmaktadır. MAC datasının oluşturulabilmesi için işyeri yönetim ekranlarından Anahtar Yaratma
adımı takip edilerek canlı ortam için **ENCKEY** değeri set edilmelidir. Bu değerin Türkçe karakter ve

### boşluk içermemesine dikkat edilmelidir.


## Tarihçe

**_Tarih Versiyon Açıklama Hazırlayan_**
12.05.2019 2. 0 beta Geliştirme ortamı (.net, java, php vs.) bazlı hazırlanmış dokümanlar
referans alınarak platform bağımsız entegrasyon dokümanı
oluşturulmuştur.
 Verilerin Şifrelenmesi
 Kullanıcı Doğrulama
 Mac/Kullanıcı Doğrulama Sonuç Sorgulanması
 Finansallaştırma
 Hata Kodları

```
Kemal Koray
Pekdemir
```
-
Sanal Pos ve
Kampanya
Uygulama
Geliştirme

20.06.2019 2.0.1
beta

```
MAC oluşturma PHP kodları eklenmiştir.
Format düzenlemeleri yapılmıştır.
```
```
Nazım Sezer
```
-
Sanal Pos ve
Kampanya
Uygulama
Geliştirme
30.07.2019 2.0.1.3
beta

```
TCKN, Kredi kartı ilk6 ve son4 hane ile ödeme işlemleri
desteklenmiştir.
```
```
Nazım Sezer
```
-
Sanal Pos ve
Kampanya
Uygulama
Geliştirme
14.12.2020 2.0.1.4 oosTranData servisinin response’unda dönen mac’in nasıl
hesaplandığı eklendi.

Enes
Köksalmış –
Sanal Pos ve
Kampanya
Uygulama
Geliştirme
10.01.2023 2.0.1.5 Order ID parametre geliştirmesi ile ilgili bilgiler eklendi. Tuba Çinal -
Sanal Pos ve
Kampanya
Uygulama
Geliştirme


