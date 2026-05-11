# YAPI KREDİ BANKASI

# SANAL POS (POSNET)

# XML Servisleri

## ENTEGRASYON DOKÜMANI


## İçindekiler

## İçindekiler


- İçindekiler
- Giriş
- Servis Genel Yapısı
- Kredi Kartı İşlemleri
   - Satış (Direkt Satış) & Peşin Fiyatına Taksitli Satış
   - Satış (Direkt Satış) & Peşin Fiyatına Taksitli Satış İşleminin Mail Order Olarak İşaretlenmesi
   - Provizyon & Peşin Fiyatına Taksitli Provizyon
   - Finansallaştırma & Peşin Fiyatına Taksitli Finansallaştırma
   - İptal İşlemi (satış, provizyon, finansallaştırma... vs.)
   - İade İşlemi
   - Eşleniksiz İade İşlemi
- Puan İşlemleri
   - Puan Sorgulama
   - Puan Kullanım
   - Puan Kullanım İptal
   - Puan İade
   - Puan İadenin İptali
- Karma İşlemler
   - Karma İşlemin İptali
   - Karma İşlemin İadesi
   - Karma İşlemin Oransal İadesi
   - Karma İşlemin Oransal İadesinin İptali
- Vade Farklı İşlemler (VFT)
   - Vade Farkı Sorgulama
   - Vade Farklı Taksitli Satış
   - Vade Farklı Satış İadesi
- Kişiye Özel - Joker Vadaa’lı İşlemler
   - Kişiye Özel İşlem Sorgulama
- Trio İşlemleri
   - Tekli Ödeme.......................................................................................................................................
   - Sabit Ödeme
   - Çoklu Ödeme
   - İade
   - Limit Sorgulama
- Mutabakat Servisleri
   - İşlem Durumu Sorgulama (Agreement)
   - Gün Bazlı İşlem Raporu Sorgulama
- Yeni Nesil Ödeme
- TCKN/VKN ve kartın ilk 6 ve son 4 bilgisi ile yapılan işlemler
   - TCKN/VKN ve kartın ilk 6 ve son 4 bilgisi ile satış işlemi
   - TCKN/VKN ve kart ilk 6 son 4 bilgisi ile provizyon ve provizyon finansallaştırma
   - TCKN/VKN ve kart ilk 6 son 4 bilgisi ile Puan İşlemleri
      - TCKN/VKN ve kart ilk 6 son 4 bilgisi ile puan sorgulama
      - TCKN/VKN ve kart ilk 6 son 4 bilgisi ile puan kullanım
- Hata Kodları
- Canlı Ortama Geçiş Adımları
- Tarihçe


## Giriş

Bu dokümanda, POSNET sistemine entegrasyonun nasıl yapılabileceği anlatılmaktadır. Paylaşılan
servis url’leri test ortamı içindir. Gerçek ortama geçmek için gerekli işlemlere doküman sonunda yer
verilmiştir. Test ortamında testlerinizi tamamladıktan sonra canlı ortama geçiş talebinizi Posnet
Support possupp@yapikredi.com.tr adresine göndereceğiniz mail ile belirtmeniz gerekmektedir.
Göndereceğiniz mail ekinde örnek işlemleriniz için ayırt edici (MERCHANT_ID, TERMINAL_ID, POSNET_ID,
SOURCE_IP, ORDER_NO, TRANSACTION_DATE vb.) bilgilere ve işlem yaptığınız tarihe yer vermeniz
gerekmektedir.

POSNET sistemini kullanacak üye işyerlerinin hem test hem canlı ortam için Statik IP adreslerini
bankaya bildirmesi gerekmektedir.

Sisteme entegre olan üye işyerlerinin müşterilerine en iyi deneyimi sunmaları için kart numarası
ekranlara girişi tamamlandığında kişiye özel indirimlerin sunulduğu Joker Vadaa sorgulaması yapılarak
kampanya olup olmadığı kontrol edilmelidir.

Üye işyerinin müşterilerinin memnuniyetini sağlamak için ödeme işlemlerinde World Puan
kullanımına imkan sunması tavsiye edilmektedir.

Üye işyerinin hem kendi riskini azaltması hem de müşteri bilgilerinin güvenliğinin sağlanması için
3D Secure (3 boyutlu güvenlik) ödeme entegrasyonu yapması önerilmektedir. Bu dokümanda yer alan
İptal İşlemi, İade İşlemi, Puan İşlemleri, Kişiye Özel – Joker Vadaa’lı İşlemler, Vade Farkı işlemler “3D
Secure Entegrasyon” dokümanının devamı niteliğindedir.

## Servis Genel Yapısı

Posnet XML servisi, Posnet işyerlerinin XML dokümanları göndererek Posnet işlemi yapmalarını
sağlayan bir servistir. İşyeri sistemlerinin ortam değişkeni olan <%XML_SERVICE_URL%> adresine (test
ortamı: https://setmpos.ykb.com/PosnetWebService/XML ) oluşturdukları xml dokümanını UTF-8 URL
Encode ile encode ettikten sonra “xmldata” parametresinde Content-Type=application/x-www-
form-urlencoded; charset=utf-8 ile POST etmesi gerekmektedir. İşlem sonucu yine bir XML
dokümanı olarak işyerine dönülür.

Örnek url:
https://setmpos.ykb.com/PosnetWebService/XML?xmldata=%3CposnetRequest%3E%0D%0A++%3C
mid%3E...

Servis entegrasyonunda yer alan aşağıdaki bilgiler üye iş yerlerine mail ile bildirilmektedir ve bu
bilgiler test ve canlı ortamlar arasında farklılık göstermektedir. Bu bilgilerin kod içerisinde gömülü
olarak tutulmaması, ortam değişkeni olarak tanımlanarak kullanılması önerilmektedir.

```
Key Type Description Sample Data
MERCHANT_ID String 10 haneli YKB üye işyeri numarası 6700000001
TERMINAL_ID String 8 haneli YKB üye işyeri terminal
numarası
```
##### 67000001

```
POSNET_ID String 16 haneye kadar YKB üye işyeri POSNET
numarası. 3D Secure şifreleme
işlemlerinde kullanılmaktadır.
```
##### 9644

XML_SERVICE_URL String Banka entegrasyon servis adresi https://setmpos.ykb.com/Posnet
WebService/XML
MERCHANT_ID, TERMINAL_ID, POSNET_ID bilgileri İşyeri Yönetici Ekranlarındaki Üye İşyeri bilgileri
sayfasından da öğrenilebilir.


##### NOTLAR:

```
 Yapılacak servis entegrasyonunda her Request Header’ına X-MERCHANT-ID, X-TERMINAL-ID,
X-POSNET-ID, X-CORRELATION-ID bilgileri eklenmelidir. (CorrelationId: işyeri tarafından set
edilecek işleme ait unique değerdir ve posnet destek ekiplerinden problem bildiriminde hızlı
dönüş yapmasını sağlayacaktır. Sipariş numarası (XID) set edilebilir. Aynı sipariş için birden fazla
servis çağrısı yapılıyorsa sipariş numarasının sonuna eklenecek karakterlerle (max 24)
ayrıştırılabilir)
 Order id değeri 24 karakter yerine 1-24 karakter arası gönderilmek isteniyorsa veya aynı order
id’nin farklı tarihlerde kullanılma durumu olacak ise merchant üye işyeri için order id
parametresinin aktif edilmesi Posnet Support ekibinden talep edilmelidir. Order id
parametresinin aktif olması durumunda farklı günlerde aynı order id ile işlem gönderilebilir.
Order id parametresinin aktif olup order id’nin çağırıldığı finansallaştırma, iptal, iade ve
mutabakat işlemlerinde orderDate alanında orijinal işlemin sipariş tarihi gönderilmelidir.
Detaylı bilgi ilgili işlemlerin başlıklarında verilmektedir.
 Request Header’ına X-MERCHANT-ID, X-TERMINAL-ID, X-POSNET-ID, X-CORRELATION-ID
bilgilerinin eklenmemesi işlemin hata almasına yol açmayacaktır. Ancak loglama ve işlem takibi
açısından headerde bu bilgilerin yer alması tavsiye edilir.
 Servise gönderilecek datanın xml yapısını bozmaması için xml escape karakterleri encode
edilerek gönderilmelidir.
 Banka sistemlerinde UTF-8 encoding desteklenmektedir. Hem request’in content charset=UTF-
8 olarak set edilmeli, hem de request content’i UTF-8 olarak encode edilmelidir.
```
## Kredi Kartı İşlemleri

### Satış (Direkt Satış) & Peşin Fiyatına Taksitli Satış

Satış işlemi (diğer adıyla Direkt Satış), müşterilerin kartından belirtilen tutarın çekilerek işyeri
hesabına yatırılmasını sağlar. Satış işleminde taksit sayısı da belirtilebilir. Bu durumda tutar, taksitli
olarak (vade farksız) karta yansır. Bu şekilde yapılan işlemlere Peşin Fiyatına Taksitli Satış denilmektedir.

Satış işleminin peşin fiyatına taksitli olması durumunda, herhangi bir vade farkı hesaplanmaz.
Belirtilen tutar belirtilen takside bölünür, her taksit vadesi geldiğinde müşterinin kart hesabına borç
kaydedilir.

Taksitli satışlarına vade farkı eklemek isteyen Posnet işyerleri, önce bu vade farkını
hesaplamalı, sonra da asıl tutara eklemelidir. Örneğin 100 TL'lik bir işlemin 2 takside bölünmesi
durumunda %10 vade farkı eklenecekse, Posnet işyeri tutar olarak 110, taksit olarak da 2
göndermelidir. Böylece 2 ay boyunca müşterinin kartından 55 TL çekilerek işyeri hesabına yatırılacaktır.
Bunun yanında işyeri Vade Farklı Satış işlemi de yapabilir.

Satış işlemi grup kapama yapıldığında finansal değer kazandığı için, grup kapama yapılıncaya
kadar iptal edilebilir. Grup kapaması yapılmış bir işlemin iptalinde 0211 hata kodu alınır. Bu durumda
iade edilmesi gerekmektedir. Gün sonuna kadar iptal edilmeyen satış işlemleri finansal anlam
kazanırlar.

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000067 </mid>


<tid> 67000067 </tid>
<tranDateRequired> 1 </tranDateRequired>
<sale>
<amount> 2451 </amount>
<ccno> 4506340000000001 </ccno>
<currencyCode>TL</currencyCode>
<cvc> 000 </cvc>
<expDate> 0703 </expDate>
<orderID>1s3456z8901234567890123</orderID>
<installment> 02 </installment>
<!--
<koiCode>1</koiCode>
-->
<!--
<subMrcId></subMrcId><mrcPfId></mrcPfId><mcc></mcc>
-->
<!--
<tckn></tckn><vkn></vkn><subDealerCode></subDealerCode>
-->
</sale>
</posnetRequest>

```
posnetRequest – sale
Direkt satış işlemi için kullanılmaktadır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
tranDateRequired Posnet sisteminde işlemin gerçekleştiği zamanın reponse içerisinde
yer almasını sağlar. Destek ihtiyacında bu bilgi süreci hızlandıracaktır.
sale
amount Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak set
edilmelidir.
ccno Kredi kartı numarası
currencyCode Para birimi – “TL, US, EU”
cvc Kredi kartı güvenlik numarası – CVV
expDate Kredi kartı son kullanım tarihi – Formatı yıl ay olacak şekilde YYAA
orderID Alışveriş sipariş numarası. 24 haneli alphanumeric, üye iş yerinin
OrderID parametresinin aktif edildiği durumlarda minimum 1
maksimum 24 karakter alphanumeric.
installment Alışveriş taksit sayısı
Peşin İşlem için “00” kullanılmalıdır.
2 taksitli işlem için “02” kullanılmalıdır.
mailorderflag Online entegrasyon üzerinden Ecom olarak gerçekleşecek olan
işlemlerin Mail Order olarak gerçekleşmesi isteniyorsa kullanılmalıdır.
Mail Order için “Y” set edilmelidir. Sadece Satış ve Peşin Fiyatına
Taksitli Satış işlemlerde set edilebilir.
```

```
koiCode Joker Vadaa kampanya tipi (kişiye özel işlem kodu). Kart numarası ile
sorgulama yapılarak kişiye özel işlem listesi sorgulanarak
kullanılmalıdır. Opsiyoneldir. Eğer bir değer set edilmiyorsa xml
içerisinde bulundurulmamalıdır.
1: Ek Taksit
2: Taksit Atlatma
3: Ekstra Puan
4: Kontur Kazanım
5: Ekstre Erteleme
6: Özel Vade Farkı
subMrcId Posnet hizmeti bir ödeme aracısı (payment facilitator) tarafından
kullanılıyorsa ödeme aracısı firma Posnet sistemine kendi
müşterilerini tanımlattığı bilgileri bu 3 alan ile göndermelidir. Ödeme
sağlayıcısı olmayan standart işyerlerinin xml içerisinde bu alanlara
yer vermemesi gerekmektedir.
```
```
mrcPfId
Mcc
```
```
tckn Posnet hizmeti bir ödeme aracısı (payment facilitator) tarafından
kullanılıyorsa ödeme aracısı firma Posnet sistemine kendi
müşterilerini tanımlattığı bilgileri bu 3 alan ile göndermelidir. Ödeme
sağlayıcısı olmayan standart işyerlerinin xml içerisinde bu alanlara
yer vermemesi gerekmektedir.
Alt bayi işlemi yapılmayacaksa TCKN/VKN/SubdealerCode alanları
gönderilmemelidir.
Bir ana bayinin alt bayi işlemi göndermesi için, alt bayinin kayıtlı
TCKN, VKN bilgilerinden en az birini göndermesi gerekmektedir.
İşlem TCKN/VKN ile gönderildiğinde
 Bu TCKN/VKN ile kayıtlı tek alt bayi varsa işlem alt bayiden
gerçekleşecektir.
 Bu TCKN/VKN ile kayıtlı hiç alt bayi yok ise işlem ana bayiden
gerçekleşecektir.
Bu TCKN/VKN ile kayıtlı birden fazla alt bayi olabilir. Bu durumda
subdealerCode’un gönderilmesini beklemekteyiz. subDealerCode
belirtilmediği durumda hangi alt işyerinden geçeceği bilinemeyeceği
için işlem ana bayiden gerçekleşecektir.
Alt bayi işlemi yapılmayacaksa TCKN/VKN/SubdealerCode alanları
gönderilmemelidir.
```
```
vkn
subDealerCode
```
Response Örneği

<?xml version='1.0' encoding='iso-8859-9'?>
<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019676067890000191 </hostlogkey>
<authCode> 760678 </authCode>
<tranDate> 190519161445 </tranDate>
<instInfo>
<inst1> 00 </inst1>
<amnt1> 000000000000 </amnt1>
</instInfo>


<pointInfo>
<point> 00000000 </point>
<pointAmount> 000000000000 </pointAmount>
<totalPoint> 09840134 </totalPoint>
<totalPointAmount> 000004920067 </totalPointAmount>
</pointInfo>
</posnetResponse>

```
posnetResponse – instInfo – pointInfo
Hostlogkey daha sonra iptal/iade gibi işlemlerde kullanılmak üzere kaydedilmelidir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
Hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. İptal iade işlemleri için
saklanmalıdır.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur. Vade
farklı işlem yapılıyorsa iptal iade işlemleri için saklanmalıdır.
tranDate Sistem ayarına göre işlemin gerçekleşme tarihidir ve işyeri yönetici
ekranlarında görünecek tarihtir. Request içerisinde tranDateRequired
= 1 girildiyse donulur. YYAAGGSSDDSS seklindedir
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Ör : 12.34 TL için 1234 olarak yer alır.
pointInfo
point İşlemden kazanılan World Puan
pointAmount İşlemden kazanılan World Puan karşılığı TL tutarı
totalPoint Kartın toplam World Puanı
totalPointAmount Kartın toplam World Puan karşılığı TL tutarı
```
Response Örneği (Hatalı)

<posnetResponse>
<approved> 0 </approved>
<respCode> 0014 </respCode>
<respText>RED-HATALI KART 0014</respText>
<yourIP>10.105.182.74</yourIP>
</posnetResponse>


Response Örneği (Daha önce gerçekleştirilmiş)
OrderId kullanılarak yapılan işlemler (Satış, Provizyon, Puan Kullanım, Karma vs.) için Posnet
sistemlerinde işyeri tekrarlı ödeme alınması ve muhtemel müşteri memnuniyetsizliğinin engellenmesi
için tekillik kontrolü yapılmaktadır. Bu tekillik kontrolü 2 senaryo ile gerçekleşebilir:

1. OrderID parametresi aktifse: Bu senaryoda tekillik kontrolü OrderId + sipariş tarihi ile
    yapılmaktadır. Farklı tarihlerde olması şartıyla aynı OrderId kullanılabilir.
2. OrderID parametresi pasifse: Bu senaryoda tekillik kontrolü OrderID üzerinden
    yapılmaktadır. Daha önce kullanılmış bir OrderID ile servise tekrar talepte bulunulduğunda
    aşağıdaki gibi cevap alınacaktır. Eğer ilk request sonucunda network gibi sebeplerden ötürü
    işlem sonucu alınamamışsa, ikinci istekte approved:2 ve respCode:127 görülerek siparişin
    tamamlanması sağlanabilir.

<posnetResponse>
<approved> 2 </approved>
<respCode> 0127 </respCode>
<respText>ORDERID DAHA ONCE KULLANILMIS 0127</respText>
<hostlogkey> 020527337090000191 </hostlogkey>
<authCode> 273370 </authCode>
<tranDate> 190703093340 </tranDate>
<instInfo>
<inst1> 00 </inst1>
<amnt1> 000000000000 </amnt1>
</instInfo>
<pointInfo>
<point> 00000000 </point>
<pointAmount> 000000000000 </pointAmount>
<totalPoint> 00000000 </totalPoint>
<totalPointAmount> 000000000000 </totalPointAmount>
</pointInfo>
</posnetResponse>

### Satış (Direkt Satış) & Peşin Fiyatına Taksitli Satış İşleminin Mail Order Olarak İşaretlenmesi

Yapılan Satış / Peşin Fiyatına Taksitli Satış işlemleri, online web servisler üzerinden
gönderildiği durumda aksini belirten bir değişiklik yapılmadığı sürece e-ticaret işlemi (E-Commerce /
Ecom) olarak gerçekleşir ve işlem yapılan kartın e-ticaret yetkileri kontrol edilir.

Dosya transferi (FTP) ile gerçekleştirilebilen Mail Order (MO) işlemlerinde ise işlem yapılan
kartın Mail Order (MO) yetkisi kontrol edilir. MO işlemler klasik olarak FTP üzerinden dosya
gönderimi ile çalışabildiği gibi web servisler ile ek parametreler ile gerçekleştirilebilir. Bu durumda
<mailorderflag>Y</mailorderflag> parametresinin xml deseni içerisinde yer alması gerekmektedir.

Bu işlemin uçtan uca Mail Order olarak gerçekleşmesi için, Mid parametresinde gönderilen
İşyeri Numarasının banka sisteminde Mail Order bir işyeri olarak tanımlı olması gerekmektedir.

Mail Order olarak gerçekleşmesi istenen online bir işlemin entegrasyon parametreleri,
Standart bir Satış / Peşin Fiyatına Taksitli Satış parmetresine sadece mailorderflag parametresi
eklenerek tamamlanabilir. Örnek istek paketi aşağıdaki gibidir;


Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000067 </mid>
<tid> 67000067 </tid>
<tranDateRequired> 1 </tranDateRequired>
<sale>
<amount> 2451 </amount>
<ccno> 4506340000000001 </ccno>
<currencyCode>TL</currencyCode>
<cvc> 000 </cvc>
<expDate> 0703 </expDate>
<orderID>1s3456z8901234567890123</orderID>
<installment> 02 </installment>
<mailorderflag>Y</mailorderflag>
<!--
<koiCode>1</koiCode>
-->
<!--
<subMrcId></subMrcId><mrcPfId></mrcPfId><mcc></mcc>
-->
<!--
<tckn></tckn><vkn></vkn><subDealerCode></subDealerCode>
-->
</sale>
</posnetRequest>
MailOrderFlag parametresinin set edildiği işlemlerin cevap paketleri (response) Satış ve Peşin
Fiyatına Taksitli Satış işlemlerinin cevap paketleri ile bire bir aynıdır.

### Provizyon & Peşin Fiyatına Taksitli Provizyon

Provizyon işlemi bir kredi kartının alışverişe uygun olduğunun kontrol edilmesi, uygunsa
istenen tutardaki blokenin karta konulması amacıyla kullanılır. Bu işlem kart hamilinin ekstresinde
görünmez, ancak kartın limitini azaltır.

Provizyon işleminin kullanım amacı, karta belirli bir tutarda bloke konulması, asıl ürün
teslimatının gerçekleşmesi ardından da gerçek finansallaştırmanın yapılmasıdır. Eğer finansallaştırmayı
ürün teslimatının ardından değil hemen yapılması isteniyorsa veya satılan ürün hemen müşteriye
teslim edilebilen bir türde ise, Provizyon yerine Satış işleminin kullanılması önerilir.

Provizyon ve finansallaştırma adımlarını içeren posnet işlemlerinde provizyon, yapılması
gereken öncelikli işlemdir. Provizyon almadan finansallaştırma yapılamaz; yani müşterinin kartından
istenilen tutar çekilemez.

Provizyon işlemi belirli bir süre içinde finansallaştırılmazsa kart hamili banka tarafından birkaç
gün sonra kendiliğinden otomatikman kalkar. İşyeri müşterinin kartına koyulmuş olan blokeyi
kaldırmak amacıyla, bu süre bitimini beklemeden de provizyon iptalini gerçekleştirebilir. Müşteri
hesabında bloke kalkacak ve müşteri memnuniyeti artırılacaktır. Bunun yanında bu süre içinde
finansallaştırılmamış işlemler daha sonra da finansallaştırılabilirler, ancak bu durumda limit kaldırılmış
olacağından yetersiz limit gibi hatalar alınması mümkün olacaktır. Finansallaşmamış provizyon işlemleri
müşteri tarafından kart online işlemlerinde görülebilir, kart ekstresinde görünmez.


Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<tranDateRequired> 1 </tranDateRequired>
<auth>
<amount> 175 </amount>
<ccno> 4048090000000001 </ccno>
<currencyCode>TL</currencyCode>
<cvc> 000 </cvc>
<expDate> 2002 </expDate>
<orderID>YKB_TST_1905210122001234</orderID>
<installment> 00 </installment>
<!-- <koiCode>1</koiCode> -->
<!--
<subMrcId></subMrcId><mrcPfId></mrcPfId><mcc></mcc>
-->
<!--
<tckn></tckn><vkn></vkn><subDealerCode></subDealerCode>
-->
</auth>
</posnetRequest>

```
posnetRequest – auth
Provizyon işlemi için kullanılmaktadır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
tranDateRequired Posnet sisteminde işlemin gerçekleştiği zamanın reponse içerisinde
yer almasını sağlar. Destek ihtiyacında bu bilgi süreci hızlandıracaktır.
auth
amount Alışveriş tutarı – Kuruş cinsinden Ör : 12.34 TL için 1234 olarak set
edilmelidir.
ccno Kredi kartı numarası
currencyCode Para birimi – “TL, US, EU”
cvc Kredi kartı güvenlik numarası – CVV
expDate Kredi kartı son kullanım tarihi – Formatı yıl ay olacak şekilde YYAA
orderID Alışveriş sipariş numarası. 24 haneli alphanumeric, üye iş yerinin
OrderID parametresinin aktif edildiği durumlarda minimum 1
maksimum 24 karakter alphanumeric.
installment Alışveriş taksit sayısı
Peşin İşlem için “00” kullanılmalıdır.
2 taksitli işlem için “02” kullanılmalıdır.
koiCode Joker Vadaa kampanya tipi (kişiye özel işlem kodu). Kart numarası ile
sorgulama yapılarak kişiye özel işlem listesi sorgulanarak
```

```
kullanılmalıdır. Opsiyoneldir. Eğer bir değer set edilmiyorsa xml
içerisinde bulundurulmamalıdır.
1: Ek Taksit
2: Taksit Atlatma
3: Ekstra Puan
4: Kontur Kazanım
5: Ekstre Erteleme
6: Özel Vade Farkı
subMrcId Posnet hizmeti bir ödeme aracısı (payment facilitator) tarafından
kullanılıyorsa ödeme aracısı firma Posnet sistemine kendi
müşterilerini tanımlattığı bilgileri bu 3 alan ile göndermelidir. Ödeme
sağlayıcısı olmayan standart işyerlerinin xml içerisinde bu alanlara
yer vermemesi gerekmektedir.
```
```
mrcPfId
mcc
```
```
tckn Alt bayi işlemi yapılmayacaksa TCKN/VKN/SubdealerCode alanları
gönderilmemelidir.
Bir ana bayinin alt bayi işlemi göndermesi için, alt bayinin kayıtlı
TCKN, VKN bilgilerinden en az birini göndermesi gerekmektedir.
İşlem TCKN/VKN ile gönderildiğinde
 Bu TCKN/VKN ile kayıtlı tek alt bayi varsa işlem alt bayiden
gerçekleşecektir.
 Bu TCKN/VKN ile kayıtlı hiç alt bayi yok ise işlem ana bayiden
gerçekleşecektir.
Bu TCKN/VKN ile kayıtlı birden fazla alt bayi olabilir. Bu durumda
subdealerCode’un gönderilmesini beklemekteyiz. subDealerCode
belirtilmediği durumda hangi alt işyerinden geçeceği bilinemeyeceği
için işlem ana bayiden gerçekleşecektir.
Alt bayi işlemi yapılmayacaksa TCKN/VKN/SubdealerCode alanları
gönderilmemelidir.
Bir ana bayinin alt bayi işlemi göndermesi için, alt bayinin kayıtlı
TCKN, VKN bilgilerinden en az birini göndermesi gerekmektedir.
İşlem TCKN/VKN ile gönderildiğinde
 Bu TCKN/VKN ile kayıtlı tek alt bayi varsa işlem alt bayiden
gerçekleşecektir.
 Bu TCKN/VKN ile kayıtlı hiç alt bayi yok ise işlem ana bayiden
gerçekleşecektir.
Bu TCKN/VKN ile kayıtlı birden fazla alt bayi olabilir. Bu durumda
subdealerCode’un gönderilmesini beklemekteyiz. subDealerCode
belirtilmediği durumda hangi alt işyerinden geçeceği bilinemeyeceği
için işlem ana bayiden gerçekleşecektir.
```
```
vkn
subDealerCode
```
Response Örneği

<?xml version='1.0' encoding='iso-8859-9'?>
<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019676067890000191 </hostlogkey>
<authCode> 760678 </authCode>
<tranDate> 190519161445 </tranDate>


<instInfo>
<inst1> 00 </inst1>
<amnt1> 000000000000 </amnt1>
</instInfo>
<pointInfo>
<point> 00000000 </point>
<pointAmount> 000000000000 </pointAmount>
<totalPoint> 09840134 </totalPoint>
<totalPointAmount> 000004920067 </totalPointAmount>
</pointInfo>
</posnetResponse>

```
posnetResponse – instInfo – pointInfo
Hostlogkey daha sonra iptal/iade gibi işlemlerde kullanılmak üzere kaydedilmelidir.
(Üye iş yeri OrderID parametresi aktif olduğu durumlarda hostlogkey kullanılmayacaksa order id +
sipariş tarihi daha sonra iptal/iade gibi işlemlerde kullanılmak üzere kaydedilmelidir.)
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. Finansallaştırma, İptal ve iade
işlemleri için saklanmalıdır.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur. Vade farklı
işlem yapılıyorsa iptal iade işlemleri için saklanmaldıır.
tranDate Sistem ayarına göre işlemin gerçekleşme tarihidir ve işyeri yönetici
ekranlarında görünecek tarihtir. Request içerisinde tranDateRequired = 1
girildiyse donulur. YYAAGGSSDDSS seklindedir
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak yer alır.
pointInfo
point İşlemden kazanılan World Puan
pointAmount İşlemden kazanılan World Puan karşılığı TL tutarı
totalPoint Kartın toplam World Puanı
totalPointAmount Kartın toplam World Puan karşılığı TL tutarı
```
### Finansallaştırma & Peşin Fiyatına Taksitli Finansallaştırma

Finansallaştırma işlemi, alınan provizyonun finansal anlam kazanması, yani müşterinin kart
hesabından çekilip işyeri hesabına yatırılması anlamına gelir. Yapılabilmesi için öncelikle mutlaka
provizyon alınmış olması gerekmektedir. Bu işlem kart ekstresinde ve işyerinin finansal kayıtlarında
görünür. Yapılan alışverişin finansal değer kazanması için bu işlemin mutlaka yapılması gerekir.


Finansallaştırma işleminde gönderilen tutar (finansallaştırma tutarı), provizyon tutarını
geçemez, ancak daha az olabilir. Örneğin 10 TL'lik bir provizyon alındıysa, en fazla 10 TL'lik bir
finansallaştırma yapılabilir. Eğer bazı durumlarda provizyon tutarının bir miktar üzerinde
finansallaştırma yapılması gerekirse, bu durumda possupp@yapikredi.com.tr adresiyle iletişime
geçilmesi gerekmektedir. Bu durumda provizyon aşım yüzdesi tanımlanarak, provizyon tutarının
üstünde finansallaştırma yapılması sağlanabilmektedir. Provizyon aşım yüzdesi 10 olan bir firma, 100
TL'lik provizyonunu en fazla 110 TL olarak finansallaştırabilir.

Taksitli gönderilemeyen bir provizyon, finansallaştırılması sırasında taksiktlendirilemez. Taksitli
gönderilen bir provizyonun finansallaştırma işleminde bulunabilecek taksit sayısı en fazla provizyon
işlemindeki kadardır. Örnek olarak; 4 taksit gönderilmiş bir provizyon işlemi 5 taksit olarak
finansallaştırılamayacak, 3 taksit olarak finansallaştırma onaylanacaktır.

Alınan provizyonun finansallaştırılmama nedeniyle otomatikman kalkması ardından da
finansallaştırma yapılabilir; ancak bu durumda kart limitindeki bloke kalkmış olacağından yetersiz
bakiye benzeri bir hata alınma olasılığı artacaktır.

Finansallaştırılma tarihine göre aynı gün içerisinde iptal, sonraki günlerde ise iade işlemi
yapılabilmektedir. Kısmi iade işlemlerinde, üzerinde bir iade olan bir işleme iptal isteği gönderilemez.
Örnek olarak 10 TL olarak gönderiken provizyon işlemine 5 TL lik iade gönderildikten sonra iptal isteği
gönderilemez.

Order ID parametresi aktif işyerleri farklı günlerde gerçekleştirdikleri aynı Order ID’ye sahip
provizyonları aynı gün gerçekleştiremezler, aksi durumda
“BU SIPARIS NO ILE BUGUN FINANSALLASTIRMA YAPILDIGI ICIN TEKRAR FINANSALLASTIRMA YAPILA
MAZ” hatası alınacaktır. Bunun nedeni iki aynı OrderId ve aynı tarihe sahip finansallaştırma işleminin
oluşmasını önlemektir.

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<capt>
<amount> 175 </amount>
<currencyCode>TL</currencyCode>
<hostLogKey> 019799151790000191 </hostLogKey>
<installment> 00 </installment>
<!--
<orderID></orderID><orderDate></orderDate>
-->
</capt>
</posnetRequest>

```
posnetRequest – capt
Provizyonu alınmış işlemi finansallaştırmak için kullanılır
```

```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
capt
amount Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak set edilmelidir.
currencyCode Para birimi – “TL, US, EU”
hostLogKey Sistem tarafındaki işlemin tekil Id’sidir. Provizyon servisinden dönen değer
kullanılmalıdır.
installment Alışveriş taksit sayısı
Peşin İşlem için “00” kullanılmalıdır.
2 taksitli işlem için “02” kullanılmalıdır.
orderID Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda hostlogkey
gönderilmiyorsa orijinal işlemin sipariş numarası gönderilmelidir.
```
orderDate (^) Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda orderID ile
finansallaştırılacak işlemin tekillik kontrolü için bu alanda orijinal işlemin
sipariş tarihi gönderilmelidir. Formatı YYYYAAGG şeklinde olmalıdır.
Response Örneği
<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019799151790000191 </hostlogkey>
<authCode> 991517 </authCode>
<instInfo>
<inst1> 00 </inst1>
<amnt1> 000000000000 </amnt1>
</instInfo>
<pointInfo>
<point> 00000000 </point>
<pointAmount> 000000000000 </pointAmount>
<totalPoint> 04860169 </totalPoint>
<totalPointAmount> 000002430084 </totalPointAmount>
</pointInfo>
</posnetResponse>
posnetResponse – instInfo – pointInfo
Finansallaştırma işlemi sonucu, taksit miktarı ve puan bilgilerine erişilir.
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.


```
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. Finansallaştırma, İptal ve iade
işlemleri için saklanmalıdır.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur. Vade
farklı işlem yapılıyorsa iptal iade işlemleri için saklanmaldıır.
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Ör : 12.34 TL için 1234 olarak yer alır.
pointInfo
point İşlemden kazanılan World Puan
pointAmount İşlemden kazanılan World Puan karşılığı TL tutarı
totalPoint Kartın toplam World Puanı
totalPointAmount Kartın toplam World Puan karşılığı TL tutarı
```
### İptal İşlemi (satış, provizyon, finansallaştırma... vs.)

Gün içinde yapılan bir işlemi iptal etmek için kullanılır. İptal edilen işlemler finansal bir değer
kazanmazlar ve müşteri ekstresinde hiçbir şekilde görünmezler. İptal işleminin ardından müşterinin
kredi kartının limiti de en geç gün sonunda olmak üzere işlem tutarı oranında arttırılır.

Gün sonunda satış işlemleri finansallaşır ve finansallaşmış işlemlerin iptali ancak iade işlemiyle
mümkün olmaktadır. Bu nedenle önceki günlerde yapılmış satışlar için Posnet Yönetici Ekranlarında
İptal seçeneği gösterilmez ve iptal servisi kullanılamaz.

Satış iptal işlemi onaylanırsa müşterinin ekstresinde satış işlemine dair hiçbir kayıt gösterilmez.
Dolayısıyla bir satışın iptal edilmesinde en tercih edilen yöntem budur. Bu işlem üye işyeri tarafında
geliştirmiş ara yüz kullanarak veya Posnet Yönetici Ekranlarında satış işlemi görüntülenerek, işlem
detayından yapılabilir.

Provizyon işleminin iptali karta konulan blokenin kaldırılmasıdır. Provizyon işlemi gibi bu işlem
de kart ekstresinde görünmez.

Finansallaştırma işleminin iptali, finansallaştırmanın kart ekstresine yansımasını engeller.
Ancak karta konulan blokeyi kaldırmaz. Bunun için provizyon iptal işlemi de yapılmalıdır. Önceki güne
ait bir finansallaştırmanın iptalinde "RED-GECERSIZ ISLEM 0229" hatası alınır. Bu durumda iade işlemi
yapılmalıdır.

Puan kullanım işleminin iptali, kart ekstresinin "WorldPuan Bilgileriniz" kısmında müşteriye
ayrıca gösterilir.

Bir işlem üzerinde daha önce yapılmış bir İade işlemi var ise, İptal işlemi hata alacaktır. Örnek
olarak 10 TL’lik bir satış işlemi içerisinde 3 TL’lik bir iade yapılmışsa, 10 TL’lik işlemin iptal edilmesi 3
TL’lik iade işlemini karşılıksız bırakacağı için bu işleme izin verilmemektedir.

Üzerinde 3 TL’lik iade işlemi bulunan 10 TL’lik işlemin tümü geri alınmak isteniyorsa, 7 TL’lik bir
iade işlemi daha yapabilirsiniz.

Ya da 3 TL’lik iade işlemini iptal ettikten sonra asıl tutar olan 10 TL’lik işlemi artık iptal
edebilirsiniz. Bu konuda bir kurgu planlanırken dikkat edilmesi gereken konu, iptal işleminin sadece
aynı gün yapılabildiğidir.

Request Örneği


<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<reverse>
<transaction>sale</transaction>
<hostLogKey> 050215105426770842 </hostLogKey>
<!--
<orderID></orderID>
-->
<!--
<orderDate></orderDate>
-->
<!--
<authCode></authCode>
-->
</reverse>
</posnetRequest>

```
posnetRequest – reverse
İşlemin gerçekleştiği gün içerisinde iptal (geri alma) için kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
reverse
transaction İptal edilecek işleminin tipi bu alanda set edilir. Satışın iptali,
provizyonun iptali, finansallaştırmanın iptali, puan kullanımın iptali,
VFT işleminin iptali, iadenin iptali olarak kullanılır.
Satis: sale
Provizyon: auth
Finansallastirma: capt
Puan Kullanim: pointUsage
VFT Islemi: vftTransaction
Iade Islemi: return
hostLogKey Sistem tarafındaki işlemin tekil Id’sidir. İlgili işlem için servis
dönüşünden elde edilerek kullanılır.
orderID Alışveriş sipariş numarası. Opsiyoneldir. Eğer sisteminizde hostlogkey
değerini tutmuyorsanız, iptal işlemini orijinal işlemin sipariş
numarasını kullanarak da yapabilirsiniz. Ancak performans açısından
hostlogkey kullanımı tercih edilmelidir. Hostlogkey kullanılıyorsa bu
alana xml içerisinde yer verilmemelidir. Üye iş yerinin OrderID
parametresinin aktif edildiği durumlarda minimum 1 maksimum 24
hane gönderilmelidir.
orderDate Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
orderID ile iptal edilecek işlemin tekillik kontrolü için bu alanda
orijinal işlemin sipariş tarihi gönderilmelidir. Formatı YYYYAAGG
şeklinde olmalıdır.
```

```
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur. Vade
Farklı İşlem (VFT) servis dönüşünde elde edilerek kullanılır. VFT işlem
iptali için bu alan zorunludur, diğer iptal işlemleri için xml içerisinde
yer verilmemelidir.
```
Response Örneği

<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019799159990000191 </hostlogkey>
<authCode> 000000 </authCode>
</posnetResponse>

```
İptal işlemi sonucuna erişilir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur. Vade
farklı işlem iptali harici işlemlerde default değer 000000 yer
almaktadır.
```
Response Örneği (Hatalı)

<?xml version='1.0' encoding='iso-8859-9'?>
<posnetResponse>
<approved> 0 </approved>
<respCode> 0220 </respCode>
<respText>IPTAL ISLEMI YAPILMIS 0220</respText>
<yourIP>10.105.182.74</yourIP>
</posnetResponse>

### İade İşlemi

Bu işlem geçmişte yapılan satış veya finansallaştırmaları tamamen iptal etmek veya sadece
belirli bir tutarını iade etmektedir. Kart ekstresinde ayrı bir işlem olarak görünür ve iptal edilen işlemin
ekstredeki kaydını silmez.


İade işlemlerinde iade edilecek tutar, orijinal işlem tutarını ve daha önce aynı orijinal işlem
üzerinde yapılmış iadelerin tutarlarının toplamını geçemez. Örneğin 10 TL'lik bir işlemin ilk iadesinde 3
TL iade ettiyseniz 2. iadede de en fazla 7 TL iade edebilirsiniz. Bir işlemin iadelerinin toplam tutarı
orijinal işlemin tutarına ulaşmadığı sürece iade işlemi yapılabilir.

İşlemlerin yapıldıkları gün iade edilmeleri de mümkündür. Böylece iptal işlemlerinin aksine,
işlemin sadece bir kısmı iade edilebilir. Vade Farklı İşlemlerin iadesi ayrıca değerlendirilmekte ve
kendine özel iade servisi bulunmaktadır. Bknz: Vade Farklı İşlemler (VFT) > Vade Farklı Satış İadesi

İade işleminde iade edilecek orijinal işlemin bilgileriyle gelinmesi gerekmektedir; örneğin satış
işlemi sonrası kısmi iade yapılması durumunda, ikinci yapılacak kısmi iade ilk kısmi iadeden dönen
bilgilerle değil satıştan dönen bilgilerle yapılmalıdır.

Order id parametresinin aktif olduğu durumda iade edilecek işlemin hostlogkey’i ile veya order
id + order date’i ile gelinmelidir. Örneğin önotorizasyon ve finansallaştırma işlemi yapıldıktan sonra
iade için finansallaştırmanın hostlogkey’i veya order id + order date’i ile gelinmelidir. Satış işleminin
kısmi iadesi sonrası tekrar iade yapılmak istendiğinde ise yine satıştan dönen hostlogkey veya satışın
yapıldığı order id + order date ile iade yapılmalıdır.

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<tranDateRequired> 1 </tranDateRequired>
<return>
<amount> 100 </amount>
<currencyCode>TL</currencyCode>
<hostLogKey> 019676067890000191 </hostLogKey>
<!--
<orderID></orderID>
-->
<!--
<orderDate></orderDate>
-->
</return>
</posnetRequest>

```
posnetRequest – return
İşlemin iadesi için kullanılmaktadır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
tranDateRequired Posnet sisteminde işlemin gerçekleştiği zamanın response içerisinde
yer almasını sağlar. Destek ihtiyacında bu bilgi süreci hızlandıracaktır.
return
```

```
amount Alışveriş tutarı – Kuruş cinsinden Ör : 12.34 TL için 1234 olarak set
edilmelidir.
currencyCode Para birimi – “TL, US, EU”
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. İlgili işlem için servis
dönüşünden elde edilerek kullanılır.
orderID Alışveriş sipariş numarası. Opsiyoneldir. Eğer işyeri sisteminde
hostlogkey değerini tutulmuyorsa, iptal işlemini orijinal işlemin sipariş
numarası kullanarak da yapılabilir. Eğer 3D Secure ödeme yönetimi ile
finansallaştırılmış bir işlemin iadesi yapılıyorsa 20 haneli orderId
önüne “TDS_” koyularak 24 haneye tamamlanması gerekmektedir.
Örn: TDS_YKB_
Bu yöntem performans açısından hostlogkey kullanımından daha
kötüdür. Hostlogkey kullanılıyorsa bu alana xml içerisinde yer
verilmemelidir. Üye iş yerinin OrderID parametresinin aktif edildiği
durumlarda minimum 1 maksimum 24 hane gönderilebilir.
```
orderDate (^) Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
orderID ile iade edilecek işlemin tekillik kontrolü için bu alanda
orijinal işlemin sipariş tarihi gönderilmelidir. Formatı YYYYAAGG
şeklinde olmalıdır.
Response Örneği
<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019799179990000191 </hostlogkey>
<authCode> 991799 </authCode>
<instInfo>
<inst1> 00 </inst1>
<amnt1> 000000000000 </amnt1>
</instInfo>
<pointInfo>
<point> 00000000 </point>
<pointAmount> 000000000000 </pointAmount>
<totalPoint> 09856296 </totalPoint>
<totalPointAmount> 000004928148 </totalPointAmount>
</pointInfo>
</posnetResponse>
posnetResponse – instInfo – pointInfo
İade işlem sonucu, taksit miktarı ve puan bilgilerine erişilir.
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.


```
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur.
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak yer alır.
pointInfo
point
pointAmount
totalPoint Kartın toplam World Puanı
totalPointAmount Kartın toplam World Puan karşılığı TL tutarı
```
### İadenin İptali İşlemi

Aynı gün içinde yapılan bir iade işlemini iptal etmek için kullanılır. Yapılan satış işlemi Yapı Kredi
Bankası kartı ile yapıldıysa bu işlem kullanılabilir, farklı bankanın kartı ile yapılan bir işlem için
kullanılamaz.

OrderId parametresi aktif işyerleri herhangi bir iadenin iptali işlemini OrderId ve OrderDate ile
gerçekleştirirken transaction alanına return yazmalılardır. Aksi halde aynı gün içerisinde yapılan satış
ve iade işlemlerinin order id’si de aynı olduğundan satışın iptali mi iadenin iptali olduğu
anlaşılamayacak ve satış işlemi iptal edilmeye çalışılacaktır.

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<tranDateRequired> 1 </tranDateRequired>
<reverse>
<transaction>sale</transaction>
<hostLogKey> 050215105426770842 </hostLogKey>
<!--
<orderID></orderID>
-->
<!--
<orderDate></orderDate>
-->
</reverse>
</posnetRequest>

```
posnetRequest – reverse
İşlemin gerçekleştiği gün içerisinde iptal (geri alma) için kullanılır.
```

```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
reverse
transaction İptal edilecek işleminin tipi bu alanda set edilir. Satışın iptali,
provizyonun iptali, finansallaştırmanın iptali, puan kullanımın iptali,
VFT işleminin iptali, iadenin iptali olarak kullanılır.
Satis: sale
Provizyon: auth
Finansallastirma: capt
Puan Kullanim: pointUsage
VFT Islemi: vftTransaction
Iade Islemi: return
hostLogKey Sistem tarafındaki işlemin tekil Id’sidir. İlgili işlem için servis
dönüşünden elde edilerek kullanılır.
```
orderID (^) Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
minimum 1 maksimum 24 hane gönderilmelidir.
orderDate (^) Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
orderID ile iptal edilecek işlemin tekillik kontrolü için bu alanda
orijinal işlemin sipariş tarihi gönderilmelidir. Formatı YYYYAAGG
şeklinde olmalıdır.
Response Örneği
<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019799159990000191 </hostlogkey>
<authCode> 000000 </authCode>
</posnetResponse>
İptal işlemi sonucuna erişilir.
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur. Vade
farklı işlem iptali harici işlemlerde default değer 000000 yer
almaktadır.


### Eşleniksiz İade İşlemi

Bu işlem tipi, içerisinde bulunan tutarı işlem gönderilen kart hamiline iade edip, üye işyerinin
hesabından çekilmesini sağlar. Daha önce yapılmış bir sipariş numarası ya da referans numarası
gerektirmemekte ve daha önce yapılmış bir işlem ile tutarlı olması gerekmemektedir.

Request Örneği

<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<tranDateRequired> 1 </tranDateRequired>
<unmatchedreturn>
<ccno> 4506340000000001 </ccno>
<expDate> 2101 </expDate>
<orderID>1s3456z8901234567890123</orderID>
<currencyCode>YT</currencyCode>
<amount> 245 </amount>
</unmatchedreturn>
</posnetRequest>

```
posnetRequest – return
Eşleniksiz iade için kullanılmaktadır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
tranDateRequired Posnet sisteminde işlemin gerçekleştiği zamanın response içerisinde
yer almasını sağlar. Destek ihtiyacında bu bilgi süreci hızlandıracaktır.
unmatchedreturn
```
```
ccno Kredi kartı numarası
expDate Kredi kartı son kullanım tarihi – Formatı yıl ay olacak şekilde YYAA
currencyCode Para birimi – “TL, US, EU”
Amount Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak set
edilmelidir.
```
orderID (^) Alışveriş sipariş numarası. 24 hane gönderilmelidir. (Üye iş yerinin
OrderID parametresinin aktif edildiği durumlarda minimum 1
maksimum 24 karakter alphanumeric.)
Response Örneği
<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019799179990000191 </hostlogkey>
<authCode> 991799 </authCode>
<instInfo>


<inst1> 00 </inst1>
<amnt1> 000000000000 </amnt1>
</instInfo>
<pointInfo>
<point> 00000000 </point>
<pointAmount> 000000000000 </pointAmount>
<totalPoint> 09856296 </totalPoint>
<totalPointAmount> 000004928148 </totalPointAmount>
</pointInfo>
</posnetResponse>

```
posnetResponse – instInfo – pointInfo
Eşleniksiz İade işlem sonucu, taksit miktarı ve puan bilgilerine erişilir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur.
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Ör : 12.34 TL için 1234 olarak yer alır.
pointInfo
point
pointAmount
totalPoint Kartın toplam World Puanı
totalPointAmount Kartın toplam World Puan karşılığı TL tutarı
```
## Puan İşlemleri

### Puan Sorgulama

Bu işlem bir WorldCard'ın sahip olduğu World Puan ve sadece sorgulama yapılan işyerinde
kullanılabilen Marka Puan bilgisinin görüntülenmesi için kullanılır. Kart ekstresinde ve sayfasında
görünmez.

İşyerinizin bankamız ile Marka Puan sorgulamak ve kullandırmak ile ilgili bir kampanya
anlaşması var ise getPointDetail tag’ini Y set edebilir ve sorgulama sonucunda World Puan ile birlikte
işyerinizde kullanılabilir Marka Puan bilgisini de sorgulayabilirsiniz. Marka Puan anlaşmanız yoksa ya da
bu detayı görmek istemiyorsanız, getPointDetail alanını göndermeyebilir ya da “N” olarak
gönderebilirsiniz.

Request Örneği


<posnetRequest>
<mid> 6700972667 </mid>
<tid> 67510491 </tid>
<pointInquiry>
<ccno> 4506340000000001 </ccno>
<expDate> 2411 </expDate>
<getPointDetail>N</getPointDetail>
</pointInquiry>
</posnetRequest>

```
posnetRequest – pointInquiry
World Puan ve Marka Puan sorgulamak için kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
tranDateRequired Posnet sisteminde işlemin gerçekleştiği zamanın reponse içerisinde
yer almasını sağlar. Destek ihtiyacında bu bilgi süreci hızlandıracaktır.
pointInquiry
ccno Kredi kartı numarası
expDate Kredi kartı son kullanım tarihi – Formatı yıl ay olacak şekilde YYAA
getPointDetail World Puan bilgilerine ek olarak bu işyerinde kullanılabilir Marka Puan
bilgilerini de sorgulamak için kullanılır
```
Response Örneği

getPointDetail tag’i N olarak set edildiğinde sorgulama yapılan karta ait World Puan bilgileri ve bu
bilgilerin TL karşılıkları gösterilir. Bu flag Y olarak set edildiğinde ek olarak sorgulama yapılan kart ile
daha önce bu işyerine özel olarak kazanılmış ve bu işyerinde kullanılabilir Marka Puan bilgileri de
verilmektedir.

<?xml version='1.0' encoding='iso-8859-9'?>
<posnetResponse>
<approved> 1 </approved>
<pointInfo>
<point> 115106032 </point>
<pointAmount> 000057553016 </pointAmount>
<loyaltyPoint> 00000000 </loyaltyPoint>
<loyaltyPointAmount> 000015379414 </loyaltyPointAmount>
<totalPoint> 00000000 </totalPoint>
<totalPointAmount> 000072932430 </totalPointAmount>
</pointInfo>
</posnetResponse>

```
posnetResponse – pointInfo
Puan sorgulama işlemi sonucu, puan bilgilerine erişilir.
```

```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
pointInfo
point Karttaki kullanılabilir toplam World Puan
pointAmount Karttaki kullanılabilir toplam World Puan karşılığı TL tutarı – Kuruş
cinsinden Ör: 12.34 TL için 1234
loyaltyPoint Karttaki kullanılabilir Marka Puan
loyaltyPointAmount Karttaki kullanılabilir Marka Puan karşılığı TL tutarı – Kuruş cinsinden
Ör: 12.34 TL için 1234
totalPoint Karttaki kullanılabilir toplam World Puan ve Marka Puan
totalPointAmount Karttaki kullanılabilir toplam World Puan ve Marka Puan karşılığı TL–
Kuruş cinsinden Ör: 12.34 TL için 1234
```
### Puan Kullanım

Bu işlem bir WorldCard'ın sahip olduğu World Puanların ya da sadece işlemin yapıldığı işyerinde
kullanılabilecek Marka Puanların kullanılması amacıyla yapılır. İşlem kart ekstresinin "WorldPuan
Bilgileriniz" kısmında görünür. Karma işlem yapılarak da World Puan ya da Marka Puan kullanımı
gerçekleştirilebilmektedir. Puan kullanımı yerine Karma İşlem yapılarak tutar alanına 0 (sıfır), puan
alanına kullanılmak istenilen puan gönderilebilir. Bknz: Karma İşlemler

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<pointUsage>
<amount> 250 </amount>
<lpAmount> 40 </lpAmount>
<ccno> 4048090000000001 </ccno>
<currencyCode>TL</currencyCode>
<expDate> 2411 </expDate>
<orderID>PKPPislemleriNT000000001</orderID>
</pointUsage>
</posnetRequest>

```
posnetRequest – pointUsage
World Puan kullanımı için kullanılır.
```
```
posnetRequest
```

```
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
pointUsage
amount Alışverişte kullanılacak World Puan tutarı – Kuruş cinsinden Ör : 12.34
TL için 1234 olarak set edilmelidir.
lpamount Alışverişte kullanılacak Marka Puan tutarı. Amount alanında kullanılan
Toplam World Puan’ın içinden ne kadarının Marka Puan olarak
kullanılacağı bilgisi belirlenir – Kuruş cinsinden Ör: 12.34 TL için 1234
olarak set edilmelidir.
ccno Kredi kartı numarası
currencyCode Para birimi – “TL, US, EU”
expDate Kredi kartı son kullanım tarihi – Formatı yıl ay olacak şekilde YYAA
orderID Alışveriş sipariş numarası 24 karakter, üye iş yerinin OrderID
parametresinin aktif edildiği durumlarda minimum 1 maksimum 24
karakter alphanumeric.
```
Marka Puan tutarının belirlenmesi:

lpAmount gönderilmediği durumda klasik puan satış işlemimiz gerçekleşir ve belirlenen
Amount tutarındaki değer, kart sahibinin hesabındaki puanların tipi, önceliği ve son kullanma tarihleri
gibi banka kurallarına ve sıralamasına uygun olarak kullanılır.

Lpamount alanında kullanılan tutar, amount alanında kullanılan tutarın içinden ne kadarının
Marka Puan olarak kullanılacağı bilgisini belirler.

Örneğin Amount alanında 500 (5,00 TL) belirlenen bir işlemde lpamount alanı 300 (3,00 TL)
olarak belirlenirse, 5,00 TL’nin 3 TL’si Marka Puan olarak kullanılır, kalan 2,00 TL ise World Puan
olarak kullanılır.

Response Örneği

<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019959713990000191 </hostlogkey>
<pointInfo>
<point> 000000350 </point>
<pointAmount> 000000000175 </pointAmount>
<totalPoint> 019985493 </totalPoint>
<totalPointAmount> 000009992746 </totalPointAmount>
</pointInfo>
</posnetResponse>

```
posnetResponse – pointInfo
Puan kullanım işlemi sonucu, puan bilgilerine erişilir.
```
```
posnetResponse
approved İşlem sonucu.
```

```
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. İptal iade işlemleri için
saklanmalıdır.
pointInfo
point İşlemde kullanılan World Puan
pointAmount İşlemde kullanılan World Puan karşılığı TL tutarı – Kuruş cinsinden Ör:
12.34 TL için 1234
totalPoint Kartın kalan toplam World Puanı
totalPointAmount Kartın kalan toplam World Puan karşılığı TL tutarı – Kuruş cinsinden
Ör: 12.34 TL için 1234
```
### Puan Kullanım İptal

Bu işlem puan kullanım işlemini iptal etmek amacıyla kullanılır. İşlem kart ekstresinin
"WorldPuan Bilgileriniz" kısmında puan kullanımından ayrı bir işlem olarak görünür.

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<reverse>
<transaction>pointUsage</transaction>
<hostLogKey> 019959715690000191 </hostLogKey>
<!--
<orderID></orderID>
-->
<!--
<orderDate></orderDate>
-->
</reverse>
</posnetRequest>

```
posnetRequest – reverse
İşlemin gerçekleştiği gün içerisinde iptal (geri alma) için kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
reverse
```

```
transaction İptal edilecek işleminin tipi bu alanda set edilir. Satışın iptali,
provizyonun iptali, finansallaştırmanın iptali, puan kullanımın iptali,
VFT işleminin iptali, iadenin iptali olarak kullanılır.
Satis: sale
Provizyon: auth
Finansallastirma: capt
Puan Kullanim: pointUsage
VFT Islemi: vftTransaction
Iade Islemi: return
hostLogKey Sistem tarafındaki işlemin tekil Id’sidir. İlgili işlem için servis
dönüşünden elde edilerek kullanılır.
orderID Alışveriş sipariş numarası. Opsiyoneldir. Eğer sisteminizde hostlogkey
değerini tutmuyorsanız, iptal işlemini orijinal işlemin sipariş
numarasını kullanarak da yapabilirsiniz. Ancak bu yöntem performans
açısından hostlogkey kullanımından daha kötüdür. Hostlogkey
kullanılıyorsa bu alana xml içerisinde yer verilmemelidir. Üye iş yerinin
OrderID parametresinin aktif edildiği durumlarda minimum 1
maksimum 24 hane gönderilebilir.
```
orderDate (^) Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
orderID ile iptal edilecek işlemin tekillik kontrolü için bu alanda
orijinal işlemin sipariş tarihi de gönderilmelidir. Formatı YYYYAAGG
şeklinde olmalıdır.
Response Örneği
<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019959715690000191 </hostlogkey>
<authCode> 000000 </authCode>
<pointInfo>
<totalPoint> 19985493 </totalPoint>
<totalPointAmount> 9992746 </totalPointAmount>
</pointInfo>
</posnetResponse>
posnetResponse – pointInfo
Puan kullanımı iptal işlemi sonucu, puan bilgilerine erişilir.
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur.


```
pointInfo
totalPoint Kartın kalan toplam World Puanı
totalPointAmount Kartın kalan toplam World Puan karşılığı TL tutarı – Kuruş cinsinden Ör
: 12.34 TL için 1234
```
### Puan İade

Bu işlem geçmişte yapılan Puan işleminin tümünü veya sadece belirli bir tutarını iade
etmektedir. Kart ekstresinde ayrı bir işlem olarak görünür ve iade edilen işlemin ekstredeki kaydını
silmez.

Puan İade işlemlerinde iade edilecek tutar, orijinal işlem tutarını ve daha önce aynı orijinal
işlem üzerinde yapılmış iadelerin tutarlarının toplamını geçemez. Örneğin 10 TL'lik bir Puan Kullandırım
işlemin ilk iadesinde 3 TL iade ettiyseniz 2. iadede de en fazla 7 TL iade edebilirsiniz. Bir işlemin
iadelerinin toplam tutarı orijinal işlemin tutarına ulaşmadığı sürece iade işlemi yapılabilir.

Puan Kullandırım işlemlerinin yapıldıkları gün iade edilmeleri de mümkündür. Böylece iptal
işlemlerinin aksine, işlemin sadece bir kısmı iade edilebilir.

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<tranDateRequired> 1 </tranDateRequired>
<pointReturn>
< wpAmount> 100 </wpAmount >
<currencyCode>TL</currencyCode>
<hostLogKey> 019676067890000191 </hostLogKey>
<!--
<orderID></orderID>
-->
<!--
<orderDate></orderDate>
-->
</pointReturn>
</posnetRequest>

```
posnetRequest – return
İşlemin iadesi için kullanılmaktadır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
tranDateRequired Posnet sisteminde işlemin gerçekleştiği zamanın response içerisinde
yer almasını sağlar. Destek ihtiyacında bu bilgi süreci hızlandıracaktır.
pointReturn
```

```
wpAmount Alışveriş tutarı – Kuruş cinsinden Ör : 12.34 TL için 1234 olarak set
edilmelidir.
currencyCode Para birimi – “TL, US, EU”
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. İlgili işlem için servis
dönüşünden elde edilerek kullanılır.
orderID Alışveriş sipariş numarası. Opsiyoneldir. Eğer işyeri sisteminde
hostlogkey değerini tutulmuyorsa, iptal işlemini orijinal işlemin sipariş
numarası kullanarak da yapılabilir. Eğer 3D Secure ödeme yönetimi ile
finansallaştırılmış bir işlemin iadesi yapılıyorsa 20 haneli orderId
önüne “TDS_” koyularak 24 haneye tamamlanması gerekmektedir.
Örn: TDS_YKB_0000190526121122
Bu yöntem performans açısından hostlogkey kullanımından daha
kötüdür. Hostlogkey kullanılıyorsa bu alana xml içerisinde yer
verilmemelidir. Üye iş yerinin OrderID parametresinin aktif edildiği
durumlarda minimum 1 maksimum 24 hane gönderilmelidir.
```
orderDate (^) Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
orderID ile iade edilecek işlemin tekillik kontrolü için bu alanda
orijinal işlemin sipariş tarihi gönderilmelidir. Formatı YYYYAAGG
şeklinde olmalıdır.
Response Örneği
<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019799179990000191 </hostlogkey>
<pointInfo>
<point> 00000000 </point>
<pointAmount> 000000000000 </pointAmount>
<totalPoint> 09856296 </totalPoint>
<totalPointAmount> 000004928148 </totalPointAmount>
</pointInfo>
</posnetResponse>
posnetResponse – instInfo – pointInfo
İade işlem sonucu, taksit miktarı ve puan bilgilerine erişilir.
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir.
pointInfo
point


```
pointAmount
totalPoint Kartın toplam World Puanı
totalPointAmount Kartın toplam World Puan karşılığı TL tutarı
```
### Puan İadenin İptali

Gün içinde yapılan bir puan iade işlemini iptal etmek için kullanılır. Yapılan puan kullanımı Yapı
Kredi Bankası kartı ile yapıldıysa bu işlem kullanılabilir, farklı bankanın kartı ile yapılan bir işlem için
kullanılamaz.

OrderId parametresi aktif işyerleri herhangi bir iadenin iptali işlemini OrderId ve OrderDate ile
gerçekleştirirken transaction alanına return yazmalılardır. Aksi halde aynı gün içerisinde yapılan satış
ve iade işlemlerinin order id’si de aynı olduğundan satışın iptali mi iadenin iptali olduğu
anlaşılamayacak ve satış işlemi iptal edilmeye çalışılacaktır.

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<reverse>
<transaction>pointusage</transaction>
<hostLogKey> 045533917690000211 </hostLogKey>
<!--
<orderID></orderID><orderDate></orderDate>
-->
</reverse>
</posnetRequest>

```
posnetRequest – reverse
İşlemin gerçekleştiği gün içerisinde iptal (geri alma) için kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
reverse
transaction pointusage
```
```
hostLogKey Sistem tarafındaki işlemin tekil Id’sidir. İlgili işlem için servis
dönüşünden elde edilerek kullanılır.
```
orderID (^) Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
hostlogkey gönderilmiyorsa orijinal işlemin sipariş numarası
minimum 1 maksimum 24 hane alphanumeric gönderilmelidir.
orderDate Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
orderID ile iptal edilecek işlemin tekillik kontrolü için bu alanda


```
orijinal işlemin sipariş tarihi gönderilmelidir. Formatı YYYYAAGG
şeklinde olmalıdır.
```
Response Örneği

<?xml version='1.0' encoding='iso-8859-9'?>
<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 045533917690000211 </hostlogkey>
<authCode> 000000 </authCode>
<respText>(TR:=Basarili.)</respText>
</posnetResponse>

```
posnetResponse – instInfo – pointInfo
İade işlem sonucu, taksit miktarı ve puan bilgilerine erişilir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
Hostlogkey İptal edilen iade işleminin referans kodu.
authCode Başarılı işlemlerde 000000 olarak dönen onay kodu alanı.
respText İşlem sonucu başarılı ise (TR:=Basarili.) açıklaması dönülür.
```
Response Örneği (Hatalı)

<?xml version='1.0' encoding='iso-8859-9'?>
<posnetResponse>
<approved> 0 </approved>
<respCode> 0217 </respCode>
<respText>GECERSIZ ISLEM STATUSU</respText>
</posnetResponse>

```
posnetResponse – instInfo – pointInfo
İade işlem sonucu, taksit miktarı ve puan bilgilerine erişilir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText İşlem sonucu başarılı değil ise ilgili hata kodunun açıklamasının
dönüldüğü alan.
```

## Karma İşlemler

Karma işlemler, aynı işlemde hem peşin veya taksitli satış, hem de puan kullanımı yapılmasını
sağlarlar. Kullanılan puan tutarı, kart sahibinin World Puanları ya da sadece bu işyerine özel olan Marka
Puanlarında istenilen dağılım sağlanacak şekilde belirlenebilir.

Request Örneği

<posnetRequest>
<mid> 6700000067 </mid>
<tid> 67000067 </tid>
<tranDateRequired> 1 </tranDateRequired>
<saleWP>
<ccno> 4506340000000001 </ccno>
<expDate> 2411 </expDate>
<cvc> 123 </cvc>
<currencyCode>YT</currencyCode>
<amount> 700 </amount>
<wpAmount> 200 </wpAmount>
<lpAmount> 100 </lpAmount>
<orderID>puanislemleriG0000000015</orderID>
</saleWP>
</posnetRequest>

```
posnetRequest – saleWP
Karma işlem için kullanılmaktadır. Yukarıdaki request örneğinde 7 TL’lik işlemin 2,00 TL’si World
Puanından düşülmesi ve 1,00 TL’sinin Marka Puanından düşülmesi ve kalan 4,00 TL’si kart
hesabından çekilmesi talep edilmiştir.
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
tranDateRequired Posnet sisteminde işlemin gerçekleştiği zamanın reponse içerisinde
yer almasını sağlar. Destek ihtiyacında bu bilgi süreci hızlandıracaktır.
saleWP
amount Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak set
edilmelidir.
wpAmount İşlemde kullanılan World Puan karşılığı TL tutarı – Kuruş cinsinden Ör:
12.34 TL için 1234 olarak set edilmelidir.
lpAmount İşlemde kullanılan Marka Puan karşılığı TL tutarı – Kuruş cinsinden Ör:
12.34 TL için 1234 olarak set edilmelidir.
ccno Kredi kartı numarası
currencyCode Para birimi – “TL, US, EU”
cvc Kredi kartı güvenlik numarası – CVV2
expDate Kredi kartı son kullanım tarihi – Formatı yıl ay olacak şekilde YYAA
orderID Alışveriş sipariş numarası. 24 haneli alphanumeric, üye iş yerinin
OrderID parametresinin aktif edildiği durumlarda minimum 1
maksimum 24 karakter alphanumeric.
installment Alışveriş taksit sayısı
Peşin İşlem için “00” kullanılmalıdır.
```

```
2 taksitli işlem için “02” kullanılmalıdır.
koiCode Joker Vadaa kampanya tipi (kişiye özel işlem kodu). Kart numarası ile
sorgulama yapılarak kişiye özel işlem listesi sorgulanarak
kullanılmalıdır. Opsiyoneldir. Eğer bir değer set edilmiyorsa xml
içerisinde bulundurulmamalıdır.
1: Ek Taksit
2: Taksit Atlatma
3: Ekstra Puan
4: Kontur Kazanım
5: Ekstre Erteleme
6: Özel Vade Farkı
```
Amount alanında gönderilen tutarın içinden kullanılması istenen World Puan ve Marka Puan bilgileri,
wpAmount ve lpAmount tag’leri içerisinde belirlenir. Kullanılacak Toplam Puan tutarı
(wpAmount+lpAmount) toplam satış tutarını (Amount) geçmemelidir.

lpAmount gönderilmediği durumda klasik çoklu satış işlemimiz gerçekleşir ve belirlenen wpAmount
tutarındaki değer, toplam tutarın içinden gerçekleşir. Bu puan tutarı kart sahibinin hesabındaki
puanların tipi, önceliği ve son kullanma tarihleri gibi banka kurallarına ve sıralamasına uygun olarak
kullanılır.

wpAmount ve lpAmount tutarlarının ikisi de belirtildiğinde ise, spesifik olarak belirtilen World Puan
ve Marka Puan tutarları kullanılır.

```
 Amount: 10 TL, wpAmpount: 4 TL
o 6 TL Satış ve Kartın banka sisteminin belirlediği önceliklerine göre 4 TL Puan kullanımı
gerçekleşir
 Amount: 10 TL, wpAmount: 4 TL, lpAmount: 0 TL
o 6 TL Satış ve 4 TL World Puan kullanılır
 Amount: 10 TL, wpAmount: 0 TL, lpAmount: 4 TL
o 6 TL Satış ve 4 TL Marka Puan kullanılır
 Amount: 10 TL, wpAmount: 4 TL, lpAmount: 5 TL
o 1 TL Satış ve 4 TL World Puan, 5 TL Marka Puan kullanılır
```
Response Örneği

<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019842038190000191 </hostlogkey>
<authCode> 420381 </authCode>
<tranDate> 190612020835 </tranDate>
<instInfo>
<inst1> 00 </inst1>
<amnt1> 000000000000 </amnt1>
</instInfo>
<pointInfo>
<point> 00000000 </point>
<pointAmount> 000000000000 </pointAmount>


<totalPoint> 20028193 </totalPoint>
<totalPointAmount> 000010014096 </totalPointAmount>
</pointInfo>
</posnetResponse>

```
posnetResponse – instInfo – pointInfo
Hostlogkey daha sonra iptal/iade gibi işlemlerde kullanılmak üzere kaydedilmelidir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. İptal iade işlemleri için
saklanmalıdır.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur. Vade
farklı işlem yapılıyorsa iptal iade işlemleri için saklanmalıdır.
tranDate Sistem ayarına göre işlemin gerçekleşme tarihidir ve işyeri yönetici
ekranlarında görünecek tarihtir. Request içerisinde tranDateRequired
= 1 girildiyse donulur. YYAAGGSSDDSS seklindedir
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Ör : 12.34 TL için 1234 olarak yer alır.
pointInfo
point İşlemden kazanılan World Puan
pointAmount İşlemden kazanılan World Puan karşılığı TL tutarı
totalPoint Kartın toplam World Puanı
totalPointAmount Kartın toplam World Puan karşılığı TL tutarı
```
### Karma İşlemin İptali

```
Karma İşlemlerin iptali, Satış işlemlerinin iptali ile aynı istek paketi ile yapılmaktadır.
```
İptal işlemi yapılırken Satış işleminde olduğu gibi Karma işlemin de Order ID ya da HostlogKey bilgisi
kullanılır. Satış İptal (Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda order ID ile iptal
edilecek işlemlerde sipariş tarihi orderDate alanında gönderilmelidir.)

Karma işlem iptal edildiğinde, karma işlem içerisinde bulunan Puan Kullandırım işlemi de, Satış
işlemi de iptal olur.

### Karma İşlemin İadesi

Karma işlem içerisinde hem Satış, hem de Puan Kullandırım işlemi barındırdığı için bu işlemler ayrı
ayrı ya da birlikte iade edilebilir. Karma işlem içerisindeki Puan Kullandırım işlemi Puan İade , Karma
işlem içerisindeki Satış işlemi ise Satış İade işlemleri ile iade edilebilir. İki işlemin tek bir istek ile iade
edilmesi “Karma İşlemin Oransal İadesi” başlığında detaylandırılmıştır.


### Karma İşlemin Oransal İadesi

Hem Satış hem de Puan (ve Marka Puan) kullandırım işlemlerinin birlikte yapıldığı Karma Satış
işlemi üzerinde oransal bir iade işlemi yapılabilmektedir.

İşlemin Oransal olarak yapılmasından, tek bir tutarla yapılacak iade işleminin, işlem ilk yapılırken
gerçekleşen satış ve puan kullandırımı üzerinde oranlanarak iade edilmesi kastedilmektedir.

Toplam 10 TL’lik Karma işlemin 7 TL’sinin satış, 3 TL’sinin de Puan kullandırım olarak
gerçekleştirildiği durumda, isRationalReturn alanı set edilerek 5 TL’lik bir iade işlemi gönderilirse;

```
 Toplam Tutar; 10 TL, İade edilmek istenen Tutar; 5 TL.  İade Oranı %50
o Satış işleminden iade edilecek tutar; 7 TL’nin %50’si olan 3,5 TL
o Puan işleminden iade edilecek tutar; 3 TL’nin %50’si olan 1,5 TL
```
```
Olacaktır.
```
Request Örneği

<posnetRequest>
<mid> 6700972667 </mid>
<tid> 67510491 </tid>
<return>
<amount> 350 </amount>
<currencyCode>TL</currencyCode>
<orderID>puanislemleriG0000000015</orderID>
<isRationalReturn>Y</isRationalReturn>
<!--
<orderID></orderID><orderDate></orderDate>
-->
</return>
</posnetRequest>

```
posnetRequest – return
İşlemin iadesi için kullanılmaktadır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
tranDateRequired Posnet sisteminde işlemin gerçekleştiği zamanın response içerisinde
yer almasını sağlar. Destek ihtiyacında bu bilgi süreci hızlandıracaktır.
return
amount Alışveriş tutarı – Kuruş cinsinden Ör : 12.34 TL için 1234 olarak set
edilmelidir.
currencyCode Para birimi – “TL, US, EU”
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. İlgili işlem için servis
dönüşünden elde edilerek kullanılır.
orderID Alışveriş sipariş numarası. Opsiyoneldir. Eğer işyeri sisteminde
hostlogkey değerini tutulmuyorsa, iptal işlemini orijinal işlemin sipariş
numarası kullanarak da yapılabilir. Eğer 3D Secure ödeme yönetimi ile
```

```
finansallaştırılmış bir işlemin iadesi yapılıyorsa 20 haneli orderId
önüne “TDS_” koyularak 24 haneye tamamlanması gerekmektedir.
Örn: TDS_YKB_0000190526121122
Bu yöntem performans açısından hostlogkey kullanımından daha
kötüdür. Hostlogkey kullanılıyorsa bu alana xml içerisinde yer
verilmemelidir. Üye iş yerinin OrderID parametresinin aktif edildiği
durumlarda minimum 1 maksimum 24 karakter gönderilmelidir.
```
orderDate (^) Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
orderID ile iade edilecek işlemin tekillik kontrolü için bu alanda
orijinal işlemin sipariş tarihi gönderilmelidir. Formatı YYYYAAGG
şeklinde olmalıdır.
isRationalReturn Karma bir satış işlemi üzerinde Oransal İade yapılmak istendiğinde “Y”
olarak set edilmelidir. Standart bir işlem iade edilecekse, yani Oransal
bir iade yapılmayacaksa bu alan hiç gönderilmeyebilir ya da “N” olarak
gönderilebilir.
Response Örneği
<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019799179990000191 </hostlogkey>
<authCode> 991799 </authCode>
<instInfo>
<inst1> 00 </inst1>
<amnt1> 000000000000 </amnt1>
</instInfo>
<pointInfo>
<point> 00000000 </point>
<pointAmount> 000000000000 </pointAmount>
<totalPoint> 09856296 </totalPoint>
<totalPointAmount> 000004928148 </totalPointAmount>
</pointInfo>
</posnetResponse>
posnetResponse – instInfo – pointInfo
İade işlem sonucu, taksit miktarı ve puan bilgilerine erişilir.
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur.


```
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Ör : 12.34 TL için 1234 olarak yer alır.
pointInfo
point
pointAmount
totalPoint Kartın toplam World Puanı
totalPointAmount Kartın toplam World Puan karşılığı TL tutarı
```
### Karma İşlemin Oransal İadesinin İptali

Gün içinde yapılan bir Karma Satış üzerinden gerçekleşen Oransal iade işlemini iptal etmek için
kullanılır. Yapılan karma satış Yapı Kredi Bankası kartı ile yapıldıysa bu işlem kullanılabilir, farklı
bankanın kartı ile yapılan bir satış için bu işlem kullanılamaz. Karma satış içerisindeki Satış ve Puan
kullanım tutarlarının üzerinden oransal olarak gerçekleşen bu işlemler iptal olur. İptal edilen işlemler
finansal bir değer kazanmazlar ve müşteri ekstresinde hiçbir şekilde görünmezler.

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<reverse>
<transaction>pointusage</transaction>
<hostLogKey> 045533917690000211 </hostLogKey>
<!--
<orderID></orderID><orderDate></orderDate>
-->
</reverse>
</posnetRequest>

```
posnetRequest – reverse
İşlemin gerçekleştiği gün içerisinde iptal (geri alma) için kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
reverse
transaction pointusage
```
```
hostLogKey Sistem tarafındaki işlemin tekil Id’sidir. İlgili işlem için servis
dönüşünden elde edilerek kullanılır.
```
orderID (^) Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
hostlogkey gönderilmiyorsa orijinal işlemin sipariş numarası
gönderilmelidir.


orderDate (^) Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
orderID ile iptal edilecek işlemin tekillik kontrolü için bu alanda
orijinal işlemin sipariş tarihi gönderilmelidir. Formatı YYYYAAGG
şeklinde olmalıdır.
Response Örneği
<?xml version='1.0' encoding='iso-8859-9'?>
<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 045533917690000211 </hostlogkey>
<authCode> 000000 </authCode>
<respText>(TR:=Basarili.)</respText>
</posnetResponse>
posnetResponse – instInfo – pointInfo
İade işlem sonucu, taksit miktarı ve puan bilgilerine erişilir.
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
Hostlogkey İptal edilen iade işleminin referans kodu.
authCode Başarılı işlemlerde 000000 olarak dönen onay kodu alanı.
respText İşlem sonucu başarılı ise (TR:=Basarili.) açıklaması dönülür.
Response Örneği (Hatalı)
<?xml version='1.0' encoding='iso-8859-9'?>
<posnetResponse>
<approved> 0 </approved>
<respCode> 0217 </respCode>
<respText>GECERSIZ ISLEM STATUSU</respText>
</posnetResponse>
posnetResponse – instInfo – pointInfo
İade işlem sonucu, taksit miktarı ve puan bilgilerine erişilir.
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.


```
respText İşlem sonucu başarılı değil ise ilgili hata kodunun açıklamasının
dönüldüğü alan.
```
## Vade Farklı İşlemler (VFT)

Bankanın, satılan ürünün peşin tutarı üzerinden istenilen vadede (vade sayısı 36 aya kadar çıkabilir)
kredi kartı sahiplerine önceden belirlenmiş oranda faiz uygulayarak kredi verme işlemidir.

Bu işlem tipinde Üye İşyeri herhangi bir faiz hesaplaması yapmaz. Seçilmiş vade gün sayısını ve ürün
satış tutarını sisteme girer. Banka satış tutarı ve vade gün sayısı üzerinden belirlenmiş olan tüketici
kredisi faiz oranından kart sahibine kredi verir. Banka satış tutarını banka-işyeri anlaşmasına uygun
şekilde işyeri hesabına aktarır.

```
Bu işlem işyeri için peşin satış, banka için kredili satış olarak tanımlanır.
```
Bu işlem Peşin Fiyatına Taksitli Satış ile karıştırılmamalıdır. Peşin Fiyatına Taksitli Satış işleminde
belirtilen tutar ve taksit sayısı ne ise işyerine banka-işyeri anlaşmalarına uygun şekilde ödeme
yapılmaktadır. Vade Farklı Satışta işlem işyeri için peşin satış yapılmış olarak değerlendirilir.

VFT işlemlerine uygulanan faiz oranı sabit olmasına rağmen faiz günlük hesaplanmaktadır. Bu
durumda kart hamilinin ekstre kesim tarihine göre faiz hesaplaması farklılık gösterebilir. Ekstre
kesimine az süre kalan kartın faiz ödemesi daha az, çok alan kart hamilinin faiz ödemesi daha çok olur.

Örneğin ayın 22'sinde ekstre kesimi gerçekleşen bir kartla, ayın 12'sinde kesimi yapılan bir kartla
yapılan VFT işlemlerinde, işlem tutarı aynı olsa bile toplam tutarlar (işlem tutarı+faiz tutarı) farklı
olacak, 22 kesimli karta daha fazla faiz uygulanacaktır.

VFT işlemlerine uygulanacak faiz tutarları konusunda müşterilerin bilgilendirilmesi için, Posnet
firmalarının öncelikle VFT sorgu yaparak uygulanacak faiz miktarını müşterilerine gösterip, müşteri
onayı sonrasında VFT satış işlemini yapması uygun olabilir.

### Vade Farkı Sorgulama

Vade farklı bir işlem için seçilen kampanyaya göre Ödeme Tablosunu gösterir. Finansal bir
değeri yoktur. Ödeme Tablosu işlemin yapıldığı gün için geçerlidir. Kart ekstresinde ve sayfasında
görünmez.

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<vftQuery>
<ccno> 4506340000000001 </ccno>
<amount> 175 </amount>
<installment> 03 </installment>
<vftCode>K001</vftCode>
</vftQuery>
</posnetRequest>


```
posnetRequest – vftQuery
Vade farkı sorgulama işlemi için kullanılmaktadır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
vftQuery
ccno Kredi kartı numarası
amount Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak set
edilmelidir.
installment Alışveriş taksit sayısı
Peşin İşlem için “00” kullanılmalıdır.
2 taksitli işlem için “02” kullanılmalıdır.
vftCode VFT Kampanya kodu. İşyeri yönetici ekranlarındaki üye işyeri bilgileri
linki kullanılarak elde edilebilir. VFT Kampanya Detayları başlığının
altındaki Kampanya Kodu sütununda bulunan bilgi buraya girilmelidir.
Test ortamı için K001 kullanılmaktadır.
```
Response Örneği

<posnetResponse>
<approved> 1 </approved>
<instInfo>
<inst1> 03 </inst1>
<amnt1> 000000000059 </amnt1>
</instInfo>
<vftInfo>
<vftAmount> 000000000002 </vftAmount>
<vftRate> 000223 </vftRate>
<vftDayCount> 0001 </vftDayCount>
</vftInfo>
</posnetResponse>

```
posnetResponse – instInfo - vftInfo
Sorgu sonrasında belirtilen taksit seçeneği için ödeme bilgilerine, vade bilgilerine erişilir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Ör : 12.34 TL için 1234 olarak yer alır.
```

```
vftInfo
vftAmount Vade farkı tutarı – Kuruş cinsinden Ör : 12.34 TL için 1234 olarak yer
alır.
vftRate Vade oranı, son üç hane binler basamağıdır Ör: 000223 için oran:
%0,223
vftDayCount Vade gün sayısı, işlemin yapılmasından sonra kredi kartının ilk ekstre
kesimine kalan gün sayısı
```
### Vade Farklı Taksitli Satış

Request Örneği
Vade farkı uygulanarak yapılan satış işlemidir. vftCode işyeri tarafından yönetim ekranlarından elde
edilmelidir. Kişiye özel vade oranı ile işlem yapılmak isteniyorsa koiCode alanına yer verilmelidir.
koiCode sorgulaması ve işlemleri için bknz: Kişiye özel – Joker Vadaa’lı İşlemler.

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<vftTransaction>
<ccno> 4506340000000001 </ccno>
<cvc> 000 </cvc>
<expDate> 2002 </expDate>
<amount> 175 </amount>
<currencyCode>TL</currencyCode>
<installment> 03 </installment>
<vftCode>K001</vftCode>
<orderID>YKB_TST_190610234500_024</orderID>
<!--
<koiCode>1</koiCode>
-->
</vftTransaction>
</posnetRequest>

```
posnetRequest – vftTransaction
Vade farklı taksitli satış için kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
vftTransaction
ccno Kredi kartı numarası
cvc Kredi kartı güvenlik numarası – CVV2
expDate Kredi kartı son kullanım tarihi – Formatı yıl ay olacak şekilde YYAA
amount Alışveriş tutarı – Kuruş cinsinden Ör : 12.34 TL için 1234 olarak set
edilmelidir.
currencyCode Para birimi – “TL, US, EU”
installment Alışveriş taksit sayısı
```

```
Peşin İşlem için “00” kullanılmalıdır.
2 taksitli işlem için “02” kullanılmalıdır.
vftCode VFT Kampanya kodu. İşyeri yönetici ekranlarındaki üye işyeri bilgileri
linki kullanılarak elde edilebilir. VFT Kampanya Detayları başlığının
altındaki Kampanya Kodu sütununda bulunan bilgi buraya girilmelidir.
Test ortamı için K001 kullanılmaktadır.
orderID Alışveriş sipariş numarası. 24 haneli alphanumeric, üye iş yerinin
OrderID parametresinin aktif edildiği durumlarda minimum 1
maksimum 24 karakter alphanumeric.
koiCode Joker Vadaa kampanya tipi (kişiye özel işlem kodu). Kart numarası ile
sorgulama yapılarak kişiye özel işlem listesi sorgulanarak
kullanılmalıdır. Opsiyoneldir. Eğer bir değer set edilmiyorsa xml
içerisinde bulundurulmamalıdır.
1: Ek Taksit
2: Taksit Atlatma
3: Ekstra Puan
4: Kontur Kazanım
5: Ekstre Erteleme
6: Özel Vade Farkı
```
Response Örneği

<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019960022290000191 </hostlogkey>
<authCode> 600222 </authCode>
<instInfo>
<inst1> 03 </inst1>
<amnt1> 59 </amnt1>
</instInfo>
<pointInfo>
<point> 0 </point>
<pointAmount> 0 </pointAmount>
<totalPoint> 9432912 </totalPoint>
<totalPointAmount> 4716456 </totalPointAmount>
</pointInfo>
<vftInfo>
<vftAmount> 2 </vftAmount>
<vftRate> 223 </vftRate>
<vftDayCount> 1 </vftDayCount>
</vftInfo>
</posnetResponse>

```
posnetResponse – instInfo – pointInfo – vftInfo
İşlem sonrasında belirtilen taksit seçeneği için ödeme bilgilerine, puan bilgilerine, vade bilgilerine
erişilir.
```
```
posnetResponse
```

```
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. İptal iade işlemleri için
saklanmalıdır.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur. Vade
farklı işlem için iptal/iade işlemleri için saklanmalıdır.
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Örn: 12.34 TL için 1234 olarak yer alır.
pointInfo
point İşlemden kazanılan World Puan
pointAmount İşlemden kazanılan World Puan karşılığı TL tutarı
totalPoint Kartın toplam World Puanı
totalPointAmount Kartın toplam World Puan karşılığı TL tutarı
vftInfo
vftAmount Vade farkı tutarı – Kuruş cinsinden Örn: 12.34 TL için 1234 olarak yer
alır.
vftRate Vade oranı, son üç hane binler basamağıdır Örn: 000223 için oran:
%0,223
vftDayCount Vade gün sayısı, işlemin yapılmasından sonra kredi kartının ilk ekstre
kesimine kalan gün sayısı
```
### Vade Farklı Satış İadesi

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<vftReturn>
<hostLogKey> 019960027090000191 </hostLogKey>
<authCode> 600270 </authCode>
<amount> 175 </amount>
<currencyCode>TL</currencyCode>
<!--
<orderID>YKB_TST_190611004500_024<orderID>
-->
<!--
<orderDate></orderDate>
-->
</vftReturn>


</posnetRequest>

```
posnetRequest – vftReturn
Vft işlemin iadesi için kullanılmaktadır. Aynı gün içerisinde olmayan, grup kapaması yapılmış işlemler
için kullanılabilir. Aynı gün içerisinde işlemin iptali yapılabilir. Bknz: Kredi Kartı İşlemleri, İptal İşlemi
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
vftReturn
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. İlgili işlem için servis
dönüşünden elde edilerek kullanılır.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur. Vade
Farklı İşlem (VFT) servis dönüşünde elde edilerek kullanılır. VFT işlem
iptali için bu alan zorunludur.
amount Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak set
edilmelidir.
currencyCode Para birimi – “TL, US, EU”
orderID Alışveriş sipariş numarası. Opsiyoneldir. Eğer işyeri sisteminde
hostlogkey değerini tutulmuyorsa, iptal işlemini orijinal işlemin sipariş
numarası kullanarak da yapılabilir. Eğer 3D Secure ödeme yönetimi ile
finansallaştırılmış bir işlemin iadesi yapılıyorsa 20 haneli orderId
önüne “TDS_” koyularak 24 haneye tamamlanması gerekmektedir.
Örn: TDS_YKB_0000190526121122
Bu yöntem performans açısından hostlogkey kullanımından daha
kötüdür. Hostlogkey kullanılıyorsa bu alana xml içerisinde yer
verilmemelidir. Üye iş yerinin OrderID parametresinin aktif edildiği
durumlarda minimum 1 maksimum 24 karakter gönderilmelidir.
```
orderDate (^) Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
orderID ile iade edilecek işlemin tekillik kontrolü için bu alanda
orijinal işlemin sipariş tarihi gönderilmelidir. Formatı YYYYAAGG
şeklinde olmalıdır.
Response Örneği
<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 019960027090000191 </hostlogkey>
<authCode> 600270 </authCode>
<instInfo>
<inst1> 00 </inst1>
<amnt1> 000000000000 </amnt1>
</instInfo>
<pointInfo>
<point> 00000000 </point>
<pointAmount> 000000000000 </pointAmount>
<totalPoint> 09856296 </totalPoint>


<totalPointAmount> 000004928148 </totalPointAmount>
</pointInfo>
</posnetResponse>

```
posnetResponse – instInfo – pointInfo
İade işlem sonucu, taksit miktarı ve puan bilgilerine erişilir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur.
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak yer alır.
pointInfo
point
pointAmount
totalPoint Kartın toplam World Puanı
totalPointAmount Kartın toplam World Puan karşılığı TL tutarı
```
## Kişiye Özel - Joker Vadaa’lı İşlemler

Kişiye Özel İşlem (kısaca KÖİ), Worldcard sahiplerinin yaptıkları alışveriş sonucunda kazanacakları
puana, işlemin kaç takside bölüneceğine kendilerinin karar vermesini sağlayan işlem şeklidir. Joker
Vadaa adıyla da anılmaktadır.

POSNET 'de Joker Vadaa, YKB 'nin düzenlediği kampanyalar dahilinde, YKB kredi kartı sahiplerine
verilen ödüllerdir. Bu ödüller, kredi kartı sahibine, işlem tipine ve alışveriş yapılan üye işyerine göre
çeşitlilik göstermektedir. Dolayısı ile kredi kartı sahibi, alışverişin tipine ve yapılan kampanyaya göre
değişik ödülleri kullanabilir. Bu ödüller sırası ile aşağıdaki gibidir.

1. Ek Taksit
2. Taksit Atlatma
3. Ekstra Puan
4. Kontur Kazanım
5. Ekstre Erteleme
6. Özel Vade Farkı

```
Posnet 'de Joker Vadaa kullanımı
```
POSNET 'de Joker Vadaa kullanımı için, ilk önce kart sahibinin kullanabileceği Joker Vadaa 'ları
sorgulamak, ikincisi sorgulama sonucunda dönen ve kredi kartı sahibi tarafından seçilen kampanya
kodunun, ilgili işleme (Provizyon, Satış veya Vade Farklı Satış) gönderilmesi olacaktır.


```
Dikkat Edilmesi Gerekenler
```
Posnet 'de Joker Vadaa işlemleri sadece Provizyon, Satış, Taksitli ve Vade Farklı Satış işlemlerinde
yapılabilmektedir.

```
Posnet 'de Joker Vadaa, YKB ve World Lisans kartlarında kullanılabilir.
```
Posnet 'de Joker Vadaa kullanılan bir Provizyon işleminin, finansallaştırılması sırasında taksit ve
tutar bilgileri değiştirilemez.

```
Ödüllerden, Taksit Atlatma ve Ek Taksit işlemleri sadece taksitli işlemler için kullanılabilir.
```
```
Ödüllerden, Özel Vade Farkı sadece Vade Farklı Satış işleminde kullanılabilir.
```
### Kişiye Özel İşlem Sorgulama

Her kredi kartının değişik ödülleri (maksimum 8 adet) olabilir. Dolayısı ile alışverişi yapan
kişinin, kullanabileceği ödülleri görüp seçim yapabilmesi için kullanıcıya bu ödülleri göstermek gerekir.
Bu işlemin yapılabilmesi için Kişiye Özel İşlem - Joker Vadaa Sogulama servisi kullanılmalıdır. Bu servis
parametre olarak sadece kredi kartı numarası alıp, ilgili ödül veya ödülleri dönmektedir. Her dönülen
ödülün, bir kampanya kodu, bir de kampanya mesajı vardır. Kampanya kodu, Joker Vadaa'lı işlem
(Provizyon, Satış veya Vade Farklı Satış) yapılırken gönderilmesi gereken bir parametredir. Kampanya
mesajı ise sadece bilgi amaçlıdır.

Eğer Joker Vadaa’lı bir işlem yapılmak isteniyorsa ilgili servise koiCode alanında ödülün
kampanya kodu set edilerek (1 ile 6 arasında bir değer) gönderilmelidir.

Eğer ilgili işlemde Joker Vadaa kullanılmak istenmiyorsa servis deseninde bu alana yer
verilmemelidir.

3DS veya banka Ortak Ödeme Sayfasına aracılığı ile işlem yapılıyorsa banka tarafından sağlanan
sayfalarda kullanıcıya joker vadaa kampanyaları gösterilerek seçim şansı verilecektir.

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<koiCampaignQuery>
<ccno> 4048090000000001 </ccno>
</koiCampaignQuery>
</posnetRequest>

```
posnetRequest – koiCampaignQuery
Kişiye özel kampanyaları (Joker Vadaa) sorgulama için kullanılır
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
koiCampaignQuery
ccno Kredi kartı numarası
```

Response Örneği

<posnetResponse>
<approved> 1 </approved>
<koiInfo>
<code> 1 </code>
<message>Sanal Pos +2 ek taksit</message>
</koiInfo>
<koiInfo>
<code> 2 </code>
<message>Tum isyerleri 5 ay erteleme</message>
</koiInfo>
<koiInfo>
<code> 3 </code>
<message>Ekstra Puan Kazan</message>
</koiInfo>
</posnetResponse>

```
posnetResponse – koiInfo
Sorgusu sonrasında belirtilen joker vadaa kampanya bilgilerine erişilir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
koiInfo
code Kişiye Özel İşlem (Joker Vadaa) işleminin kodunu belirtir. Bir kartla
birden çok tipte koi yapılabilir.
1:Ek taksit
2:Taksit atlatma
3:Ekstra puan
4:Kontur kazanim
5:Ekstre erteleme
6:Özel vade farkı
message Kişiye özel işlemin yanında kart sahibine gösterilecek mesajı içerir. Bu
mesaj sadece bilgilendirme amaçlıdır ve kart sahibine göre değişiklik
gösterebilir.
```
Test ortamında yapılan KÖİ sorgulama işlemlerinde dönülecek mesajlar anlamsız olabilirler. Bu
durum normaldir, üretim ortamında müşterilerinize anlamlı mesajlar dönülecektir.


KÖİ sorgulama işlemi sonucunda aynı koda sahip birden fazla mesaj (kişiye özel işlem listesi)
geri dönülebilir;

<posnetResponse>
<approved> 1 </approved>
<koiInfo>
<code> 1 </code>
<message>Sanal Pos +2 ek taksit</message>
</koiInfo>
<koiInfo>
<code> 1 </code>
<message>300TL uzeri +3 ek taksit</message>
</koiInfo>
<koiInfo>
<code> 2 </code>
<message>Tum isyerleri 5 ay erteleme</message>
</koiInfo>
</posnetResponse>

Burada 2 farklı mesaja fakat aynı KÖİ koduna (1:Ek Taksit) sahip KÖİ olmasının nedeni,
müşteriye iki farklı ek taksit kampanyası tanımlanmasıdır. Bu durumda müşterinize 2 seçeneği de
göstermenizde bir sakınca yoktur. Bu tasarımın amacı, müşterinin tüm tanımlı kampanyaları
görebilmesidir. Sizin üye işyeri olarak yapmanız gereken, tüm seçenekleri (sorgulama sonucunda
dönülen tüm mesajları) müşterinize göstermektir. Aslında yukarıdaki örnekte müşteriniz hangi
seçeneği seçerse seçsin, eğer işlemi 300 TL üzerindeyse +3 taksit yapılır. Kısacası aynı koda sahip
KÖİ'lerden hangisi seçilirse seçilsin, sistem otomatik olarak müşteri için en avantajlı olan KÖİ'yi seçer.
Buradaki amaç, müşterinin yanlışlıkla daha az avantajlı bir KÖİ'yi seçmesinin engellenmesidir.

Müşterinize sadece KÖİ sorgulama sonucunda size dönülen mesajları göstermeniz yeterlidir.
Bu mesajlar, ek taksit veya ekstra puan gibi hangi koda ait olduklarına dair bilgiyi de içerirler.

## Trio İşlemleri

Alıcıların ve satıcıların ticari işletmeler olduğu alışverişlerde kullanılmak üzere tamamen esnek
vade yapısıyla çalışan işlemlerdir. Bknz: https://www.yapikredi.com.tr/kartlar/ticari-kartlar

### Tekli Ödeme.......................................................................................................................................

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<trioSingle noWarranty="false">
<ccno> 6037970000000001 </ccno>
<expDate> 2511 </expDate>
<cvc> 000 </cvc>
<orderID>YKB_TST_190703093100_024</orderID>
<amount> 175 </amount>


<currencyCode>TL</currencyCode>
<termDayCount> 20 </termDayCount>
</trioSingle>
</posnetRequest>

```
posnetRequest – trioSingle
Trio tekli ödeme işlemi için kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
trioSingle
ccno Kredi kartı numarası
expDate Kredi kartı son kullanım tarihi – Formatı yıl ay olacak şekilde YYAA
cvc Kredi kartı güvenlik numarası – CVV2
orderID Alışveriş sipariş numarası. 24 haneli alphanumeric, üye iş yerinin
OrderID parametresinin aktif edildiği durumlarda minimum 1
maksimum 24 karakter alphanumeric.
amount Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak set
edilmelidir.
currencyCode Para birimi – “TL, US, EU”
termDayCount Trio ödeme dönem gün sayısı
```
Response Örneği

<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 020527826090000191 </hostlogkey>
<authCode> 011970 </authCode>
</posnetResponse>

```
posnetResponse
Hostlogkey daha sonra iptal/iade gibi işlemlerde kullanılmak üzere kaydedilmelidir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur.
```

### Sabit Ödeme

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<trioFixed noWarranty="false">
<ccno> 6037970000000001 </ccno>
<expDate> 2511 </expDate>
<cvc> 000 </cvc>
<orderID>YKB_TST_190706021900_025</orderID>
<amount> 175 </amount>
<currencyCode>TL</currencyCode>
</trioFixed>
</posnetRequest>

```
posnetRequest – trioFixed
Trio sabit ödeme işlemi için kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
trioFixed
ccno Kredi kartı numarası
expDate Kredi kartı son kullanım tarihi – Formatı yıl ay olacak şekilde YYAA
cvc Kredi kartı güvenlik numarası – CVV2
orderID Alışveriş sipariş numarası. 24 haneli alphanumeric, üye iş yerinin
OrderID parametresinin aktif edildiği durumlarda minimum 1
maksimum 24 karakter alphanumeric.
amount Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak set
edilmelidir.
currencyCode Para birimi – “TL, US, EU”
```
Response Örneği

<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 020527826090000192 </hostlogkey>
<authCode> 011971 </authCode>
</posnetResponse>

```
posnetResponse
Hostlogkey daha sonra iptal/iade gibi işlemlerde kullanılmak üzere kaydedilmelidir.
```

```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur.
```
### Çoklu Ödeme

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<!--
noWarranty parametresi trio isleminin garantisiz olup olmadigini belir
tir. Girilmezse false kabul edilir.
-->
<trioMultiple noWarranty="false">
<ccno> 6037970000000001 </ccno>
<expDate> 2511 </expDate>
<cvc> 000 </cvc>
<orderID>YKB_TST_190707121900_024</orderID>
<amount> 1000 </amount>
<currencyCode>TL</currencyCode>
<installment> 03 </installment>
<termDayCount> 20 </termDayCount>
</trioMultiple>
</posnetRequest>

```
posnetRequest – trioMultiple
Trio çoklu ödeme işlemi için kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
trioMultiple
ccno Kredi kartı numarası
expDate Kredi kartı son kullanım tarihi – Formatı yıl ay olacak şekilde YYAA
cvc Kredi kartı güvenlik numarası – CVV2
orderID Alışveriş sipariş numarası. 24 haneli alphanumeric, üye iş yerinin
OrderID parametresinin aktif edildiği durumlarda minimum 1
maksimum 24 karakter alphanumeric.
```

```
amount Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak set
edilmelidir.
currencyCode Para birimi – “TL, US, EU”
installment Alışveriş taksit sayısı
Peşin İşlem için “00” kullanılmalıdır.
2 taksitli işlem için “02” kullanılmalıdır.
termDayCount Trio ödeme dönem gün sayısı
```
Response Örneği

<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 018971217390000181 </hostlogkey>
<authCode> 010680 </authCode>
<instInfo>
<inst1> 03 </inst1>
<amnt1> 000000000333 </amnt1>
</instInfo>
</posnetResponse>

```
posnetResponse – instInfo
Hostlogkey daha sonra iptal/iade gibi işlemlerde kullanılmak üzere kaydedilmelidir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur.
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak yer alır.
```
### İade

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>


<trioReturn>
<hostLogKey> 020527826090000191 </hostLogKey>
<!--
<orderID>YKB_TST_190703093100_024<orderID>
-->
<!--
<orderDate></orderDate>
-->
</trioReturn>
</posnetRequest>

```
posnetRequest – trioReturn
Trio işlemin iadesi için kullanılmaktadır. hostLogKey veya orderId ile çalışır. İşlem tutarının tamamı
iade edilebilir.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
trioReturn
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. İlgili işlem için servis
dönüşünden elde edilerek kullanılır.
orderID Alışveriş sipariş numarası. Opsiyoneldir. Eğer işyeri sisteminde
hostlogkey değerini tutulmuyorsa, iptal işlemini orijinal işlemin sipariş
numarası kullanarak da yapılabilir.
Hostlogkey kullanılıyorsa bu alana xml içerisinde yer verilmemelidir.
Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
minimum 1 maksimum 24 karakter gönderilmelidir.
orderDate Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
orderID ile iade edilecek işlemin tekillik kontrolü için bu alanda
orijinal işlemin sipariş tarihi gönderilmelidir. Formatı YYYYAAGG
şeklinde olmalıdır.
```
Response Örneği

<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 020527826090000191 </hostlogkey>
<authCode> 011970 </authCode>
<!-- coklu odeme işlemleri icin yer alacaktir
<instInfo><inst1>01</inst1><amnt1>000000001000</amnt1></instInfo>
-->
<trioDate></trioDate>
<trioAmount> 000000000175 </trioAmount>
<ins1></ins1>
<amt1></amt1>
</posnetResponse>


```
posnetResponse – instInfo
İade işlem sonucu, taksit miktarı ve puan bilgilerine erişilir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur.
trioDate Trio ödeme günü
trioAmount Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak yer alır.
ins1
amt1
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak yer alır.
```
### Limit Sorgulama

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<trioAvailableLimitInq>
<ccno> 6037970000000001 </ccno>
<expDate> 2511 </expDate>
</trioAvailableLimitInq>
</posnetRequest>

```
posnetRequest – trioAvailableLimitInq
Trio kart limitine kalan tutarı sorgulamak için kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
trioAvailableLimitInq
ccno Kredi kartı numarası
expDate Kredi kartı son kullanım tarihi – Formatı yıl ay olacak şekilde YYAA
```
Response Örneği


<posnetResponse>
<approved> 1 </approved>
<limitInfo>
<accountNumber> 42049272 </accountNumber>
<availableAmount> 0000000000632347 </availableAmount>
<limit> 0000000000800000 </limit>
</limitInfo>
</posnetResponse>

```
posnetResponse – limitInfo
Kart limitine kalan tutar bilgilerine erişilir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
limitInfo
accountNumber Hesap numarası
availableAmount Ödeme alınabilir tutar – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak
yer alır.
limit Limit
```
## Mutabakat Servisleri

### İşlem Durumu Sorgulama (Agreement)

Banka sunucuları ile işyeri sunucuları arasında yapılan data transferi esnasında bir hata
oluşması durumunda işlemin sonucu işyeri tarafında görülemeyebilir. Bu problem sistemlerin beklenen
sürede cevap verememesi ya da network seviyesindeki paket kayıpları sebebiyle yaşanabilir. Finansal
olan veya müşteri kart bakiyesini bloklayan bir işlem gerçekleştirilmiş ancak işyeri ilgili sonucu
alamadığı durumlarda sorgulama servisi ile sonuç tekrar kontrol edilmelidir.

Banka tarafındaki işlemlerde duruma göre farklı banka ya da sistemlerle iletişime geçilmekte
ve işlem süresi için 45 saniyeye kadar beklenmektedir. Bu sebeple işyeri sistemlerinde 1dakika timeout
süresi kullanılması önerilmektedir.

İşyeri tarafından gönderilen bir provizyon talebine banka sisteminden yanıt alınamadığı
durumda işlemin gerçekleşip gerçekleşmediği işyeri tarafından tespit edilemeyecektir. Eğer işlem
banka tarafında başarıyla tamamlanmış ise kart bakiyesine tutar kadar bloke koyulacak ve kart
hareketlerinde müşteri tarafından görüntülenebilecektir. İşyerinin bu durumda ikinci kez provizyon
işlemi yapmak yerine sorgulama yaparak işlem sonucu kontrol etmesi gerekmektedir. Bu durum
özellikle finansal sonuçlar doğuran (satış, puan kullanımı vs.) veya kullanıcı tarafından kart hareketi
(provizyon) olarak görüntülenebilecek işlemlerde dikkate alınmalıdır. Müşteri mağduriyetinin önüne
geçmek için aynı sipariş numarası ile yapılacak ikinci işlemlerde banka sistemi tekillik kontrolü yaparak
çiftli (duplicate) işlemleri engelleyecek ve uygun mesaj dönecektir.


Order id parametresinin aktif olduğu üye işyerlerimiz orijinal işlemle ilgili yapılmış tüm
finansallaştırma, iade iptal gibi işlemleri görebilmesi için orijinal işlemin order id ve order date’i ile işlem
durumunu sorgulamalıdır.

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<agreement>
<orderID>TDS_YKB_0000191010111730</orderID>
<!--
<orderDate></orderDate>
-->
</agreement>
</posnetRequest>

```
posnetRequest – agreement
Sipariş numarası ile işlem sonucu sorgulama için kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
agreement
orderID Alışveriş sipariş numarası
```
orderDate (^) Üye iş yerinin OrderID parametresinin aktif edildiği durumlarda
sorgulaması yapılacak işlemin sipariş tarihi de girilmelidir. Formatı
YYYYAAGG şeklinde olmalıdır.
Response Örneği
<?xml version="1.0" encoding="utf-16"?>
<posnetResponse>
<approved> 1 </approved>
<transactions>
<transaction>
<orderID>TDS_YKB_0000191010111730</orderID>
<ccno>4506 34** **** 4637</ccno>
<amount>1,16</amount>
<currencyCode>TL</currencyCode>
<authCode> 504289 </authCode>
<tranDate>2019-10-10 11:21:14.281</tranDate>
<state>Sale</state>
<txnStatus> 1 </txnStatus>
<hostLogKey> 021450428990000191 </hostLogKey>


</transaction>
</transactions>
</posnetResponse>

```
posnetResponse – transactions – transaction
Sorgusu sonrasında belirtilen işlem sonucuna erişilir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
```
```
transactions – transaction
```
orderID (^) Alışveriş sipariş numarası. 24 haneli alphanumeric, OrderID
parametresinin aktif olduğu üye iş yerlerinde 1-24 haneli
alphanumeric
ccno Kredi kartı numarası. İlk 6 ve son 4 hane açık, diğer alanlar maskelidir.
amount Alışveriş tutarı – TL cinsinden Ör: 12.34 TL için 12 , 34 olarak yer alır.
currencyCode Para birimi – “TL, US, EU”
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur.
tranDate Sistem ayarına göre işlemin gerçekleşme tarihidir ve işyeri yönetici
ekranlarında görünecek tarihtir. yyyy-MM-dd HH:mm:ss.nnn
formatındadır.
state İşlem tipini gösterir.
Sale: Satış ve Peşin Fiyatına Taksitli Satış
VFT_Sale: Vade Farklı Taksitli Satış
Authorization: Provizyon ve Taksitli Ön Provizyon
Capture: Finansallaştırma ve Taksitli Finansallaştırma
Bonus_Usage: Puan Kullandırım
Sale_Reverse: Satış İptal ve Peşin Fiyatına Taksitli Satış İptal
VFT_Sale_Reverse: Vade Farklı Taksitli Satış İptal
Authorization_Reverse: Önprovizyon ve Taksitli Önprovizyon İptal
Capture_Reverse: Finansallaştırma ve Taksitli Finansallaştırma İptal
Bonus_Reverse: Puan Kullandırım İptal
Return_Reverse: İadenin İptali
Return: Satış/Taksitli Satış/Karma Satış/Finansallaştırma İade
VFT_Return: Vade Farklı Taksitli Satış İade
Bonus_Return: Puan Kullandırım İade
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir.
txnStatus İşlemin başarı durumunu gösterir.
1: Başarılı gerçekleşen işlem (işlem tutarı üye işyeri ve kart hamiline
yansıtılacak)
0: Başarısız ya da iptal edilmiş işlem (işlem tutarı üye işyeri ve kart
hamiline yansıtılmayacak)


### Gün Bazlı İşlem Raporu Sorgulama

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<merchantReconciliation>
<startDate>2019-06-12</startDate>
<endDate>2019-06-14</endDate>
<currency>TL</currency>
</merchantReconciliation>
</posnetRequest>

```
posnetRequest – merchantReconciliation
Belirli bir gün için işyerinden yapılmış toplam işlem sayısı ve işlem tutarı bilgisini sorgulamak için
kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
merchantReconciliation
startDate yyyy-MM-dd formatında iletilir, istenen verinin başlangıç tarihini
belirler. Belirtilen başlangıç günü rapora dâhil edilir. Ör : 2019-02-01
endDate yyyy-MM-dd formatında iletilir, istenen verinin bitiş tarihini belirler.
Belirtilen bitiş günü rapora dahil edilir.
Başlangıç ve bitiş tarihleri arasında en çok 10 gün olabilir.
Başlangıç ve bitiş tarihleri aynı gün belirtildiği takdirde 1 günlük işlem
raporu verilir. Ör: 2019-02-01
currency Para birimi – “TL, US, EU”
```
Response Örneği

<posnetResponse>
<approved> 1 </approved>
<merchantReconciliation>
<totalNumber> 5 </totalNumber>
<totalAmount> 50000 </totalAmount>
<transactionType> 1 </transactionType>
<transactionName>Peşin Satış</transactionName>
</merchantReconciliation>
<merchantReconciliation>
<totalNumber> 2 </totalNumber>
<totalAmount> 4000 </totalAmount>
<transactionType> 2 </transactionType>
<transactionName>Taksitli Satış</transactionName>


</merchantReconciliation>
<merchantReconciliation>
<totalNumber> 3 </totalNumber>
<totalAmount> 38107 </totalAmount>
<transactionType> 6 </transactionType>
<transactionName>Peşin Satış İptal</transactionName>
</merchantReconciliation>
</posnetResponse>

```
posnetResponse – merchantReconciliation
Her bir işlem tipi için işlem sayısı ve toplam tutar bilgisi verilir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
```
```
merchantReconciliation
totalNumber İlgili işlem tipindeki toplam işlem sayısı
totalAmount İlgili işlem tipindeki toplam işlem tutarı – Kuruş cinsinden Ör : 12.34
TL için 1234 olarak yazılmaktadır.
transactionType İşlem tipidir. Aşağıdaki değerlere karşılık gelmektedir.
0:İşlem tipi tanımsız
1:Peşin Satış
2:Taksitli Satış
3:Peşin İade
4:Taksitli Satış İade
5:Finansallaştırma
6:Peşin Satış İptal
7:Taksitli Satış İptal
8:Taksitli Finansallaştırma
9:Vade Farklı Satış
10:Puanlı Satış Puan Kullanım
11:Peşin Satış İptal - Sistemsel
12:Puanlı Taksitli Satış
13:Puanlı Peşin Satış
14:Vade Farklı Satış İade
15:Puan Kullanım
16:Taksitli Satış İptal - Sistemsel
17:Finansallaştırma İptal
18:Vade Farklı Satış İptal
19:Puan Kullanım İade
20:Taksitli Finansallaştırma İptal
21:Taksitli Satış İadenin İptali
22:Peşin İade İptal
23:Peşin Satış - FTP
```

```
24:Taksitli Satış - FTP
25:Peşin Satış İade - FTP
26:Taksitli Satış İade - FTP
27:Puan Kullanım İptal
28:Puanlı Satış Puan Kullanım İptal
29:Puanlı Peşin Satış İptal
30:Peşin Satış İptal - FTP
31:Taksitli Satış İptal - FTP
32:Puanlı Taksitli Satış İptal
33:Ön Provizyon İptal
34:Ön Provizyon
35:Joker Vadaa Sorgulama
36:Puan Sorgulama
transactionName İşlem adıdır.
Örn : Ön Provizyon, Peşin Satış, Peşin Satış İptali, Taksitli Satış, Vade
Farklı Satış, Finansallaştırma vb.
```
Response Örneği (Hatalı)

<posnetResponse>
<approved> 0 </approved>
<respCode>E117</respCode>
<respText>Tarih değerleri boş olamaz</respText>
</posnetResponse>

<posnetResponse>
<approved> 0 </approved>
<respCode>E154</respCode>
<respText>Üye işyeri adı null ya da boş olamaz.</respText>
</posnetResponse>

<posnetResponse>
<approved> 0 </approved>
<respCode>E215</respCode>
<respText>Tarih alanı hatalı</respText>
</posnetResponse>

<posnetResponse>
<approved> 0 </approved>
<respCode> 0340 </respCode>
<respText>BAŞLANGIÇ VE BİTİŞ TARİHİ FARKI 10 GÜNÜ GEÇEMEZ.</respText>
</posnetResponse>

<posnetResponse>
<approved> 0 </approved>
<respCode> 0341 </respCode>
<respText>BAŞLANGIÇ TARİHİ BİTİŞ TARİHİNDEN BÜYÜK OLAMAZ</respText>
</posnetResponse>


## Yeni Nesil Ödeme

Teknolojinin değişimiyle birlikte ödeme şekilleri de değişmiş, ödemelerin mobil-web
kanalından ya da işlemin yüz yüze veya kart sahibi adına aracı kişi (sistemsel) aracılığı ile yapıldığı
durumlar ortaya çıkmıştır. Ayrıca kart bilgileri işyerleri tarafından dijital cüzdanlarda saklanarak işlem
yapılabilmektedir. BKM tarafından her işyeri ve kart saklama çözümü (wallet) için bankalar aracılığıyla
yapılacak başvuru ile tekil bir değer atanmakta ve iş yerleri, aldığı ödeme işlemlerinin hangi şekilde,
hangi kanaldan, kart bilgilerinin nasıl elde edildiğini belirten bilgileri paylaşabilmektedir. Tüm finansal
servislerde posnetRequest içerisinde bu bilgiler geçildiği takdirde, Posnet kendisinde tanımlı bilgiler ile
karşılaştırarak bu bilgileri saklar. Aşağıda örneği verilen yeni nesil ödeme bilgileri Satış <sale>, Puan
Kullanım <pointUsage>, Provizyon <auth>, Finansallaştırma <capt>, İade <return>, Eşleniksiz İade
<unmatchedreturn>, İptal <reverse>, VFT Satış <vftTransaction>, VFT İade <vftReturn>, Tekli Trio
Ödeme <trioSingle>, Çoklu Trio Ödeme <trioMultiple>, Sabit Trio Ödeme <trioFixed>, 3D Secure
İşlemin Finansallaştırılması <oosTranData> servislerinde Posnet request içerisinde yer alabilir.
<posnetRequest> içerisine childNode olarak <ngp> xml tag’i ile eklenmelidir.

<ngp>
<txnType> 1 </txnType>
<txnSrcApp> 3 </txnSrcApp>
<assignedId> 123456 </assignedId>
<wProgData></wProgData>
<ffi> 00 </ffi>
<vType> 1 </vType>
</ngp>

```
posnetRequest – ngp
Yeni nesil ödeme işlemlerinde ödeme bilgileri bu alan içerisinde yer alır.
```
```
ngp
txnType İşlem Tipi – 2 haneli numeric
1: Yüzyüze Mobil İşlemler
2: Yüzyüze Olmayan Mobil İşlemler
3: Saklanan Kart Verisi ile Webden Yapılan İşlemler
txnSrcApp İşlem Kaynak Uygulaması – 2 haneli numeric
1: Cüzdanlar (Banka, Şema, 3. Partiler)
2: BKM Express
3: İşyeri Mobil Uygulamaları
assignedId BKM tarafından her bir işyeri için atanan tekil Id – 6 haneli
alphanumeric
wProgData Cüzdan Programı Bilgisi (BKM tarafından kart saklama ürünü için
atanan tekil Id) – 3 haneli alphanumeric
ffi Form Factor Indicator
vType Verification Type
```
Request Örneği

```
Satış
```

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<sale>
<ccno> 4506340000000001 </ccno>
<cvc> 000 </cvc>
<expDate> 2002 </expDate>
<amount> 2000 </amount>
<currencyCode>TL</currencyCode>
<installment> 4 </installment>
<orderID>jokervadaa0sale0000000A1</orderID>
<koiCode> 1 </koiCode>
</sale>
<ngp>
<txnType> 1 </txnType>
<txnSrcApp> 3 </txnSrcApp>
<assignedId> 123456 </assignedId>
<wProgData></wProgData>
<ffi> 00 </ffi>
<vType> 1 </vType>
</ngp>
</posnetRequest>

```
Puan Kullanım
```
<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<pointUsage>
<amount> 245 </amount>
<ccno> 4506340000000001 </ccno>
<currencyCode>TL</currencyCode>
<expDate> 2002 </expDate>
<orderID>1s3t56z8a012345673s01234</orderID>
</pointUsage>
<ngp>
<txnType> 1 </txnType>
<txnSrcApp> 3 </txnSrcApp>
<assignedId> 123456 </assignedId>
<wProgData></wProgData>
<ffi> 00 </ffi>
<vType> 1 </vType>
</ngp>
</posnetRequest>


```
Provizyon
```
<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<auth>
<ccno> 4506340000000001 </ccno>
<expDate> 2002 </expDate>
<cvc> 000 </cvc>
<currencyCode>TL</currencyCode>
<amount> 1000 </amount>
<orderID>onprovizyony000000000030</orderID>
</auth>
<ngp>
<txnType> 1 </txnType>
<txnSrcApp> 3 </txnSrcApp>
<assignedId> 123456 </assignedId>
<wProgData></wProgData>
<ffi> 00 </ffi>
<vType> 1 </vType>
</ngp>
</posnetRequest>

```
Finansallaştırma
```
<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<capt>
<amount> 1000 </amount>
<currencyCode>TL</currencyCode>
<hostLogKey> 019017272790000181 </hostLogKey>
</capt>
<ngp>
<txnType> 1 </txnType>
<txnSrcApp> 3 </txnSrcApp>
<assignedId> 123456 </assignedId>
<wProgData></wProgData>
<ffi> 00 </ffi>
<vType> 1 </vType>
</ngp>
</posnetRequest>


```
İade
```
<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<return>
<amount> 245 </amount>
<currencyCode>TL</currencyCode>
<hostLogKey> 019139540590000191 </hostLogKey>
</return>
<ngp>
<txnType> 1 </txnType>
<txnSrcApp> 3 </txnSrcApp>
<assignedId> 123456 </assignedId>
<wProgData></wProgData>
<ffi> 00 </ffi>
<vType> 1 </vType>
</ngp>
</posnetRequest>

```
Trio Ödeme
```
<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 2600000001 </mid>
<tid> 00000067 </tid>
<trioFixed noWarranty="false">
<ccno> 6037970000000001 </ccno>
<expDate> 0907 </expDate>
<cvc> 000 </cvc>
<orderID>1s3456z89012345678901234</orderID>
<amount> 2451 </amount>
<currencyCode>TL</currencyCode>
</trioFixed>
<ngp>
<txnType> 1 </txnType>
<txnSrcApp> 3 </txnSrcApp>
<assignedId> 123456 </assignedId>
<wProgData></wProgData>
<ffi> 00 </ffi>
<vType> 1 </vType>
</ngp>
</posnetRequest>


```
3D Secure Ödeme Finansallaştırma
```
<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<oosTranData>
<bankData>87F491ACD24EAE64B519980F0B1BC7547BE4A7C5C614DC3A8CA3FC41B180
EE7765851B081AAE61221956C0C68B0AD69307B4386C7FCE451C272264251BD72BFCBA0A96A197
C38C6CD39DD442BC179FF098824AFA15B1BB320AD15DA2FB588ECC81B11A26D13764A57B57B49C
4CA1BD5D46FA7E60EED480C944AE0817</bankData>
<wpAmount> 0 </wpAmount>
<mac>DF2323A3BMC782QOP42RT</mac>
</oosTranData>
<ngp>
<txnType> 1 </txnType>
<txnSrcApp> 3 </txnSrcApp>
<assignedId> 123456 </assignedId>
<wProgData></wProgData>
<ffi> 00 </ffi>
<vType> 1 </vType>
</ngp>
</posnetRequest>

## TCKN/VKN ve kartın ilk 6 ve son 4 bilgisi ile yapılan işlemler

### TCKN/VKN ve kartın ilk 6 ve son 4 bilgisi ile satış işlemi

Sigorta sektörü firmalarının kullanımı için geliştirilen kart bilgisinin tam hali gönderilmeden
yapılmak istenen işlemler için kullanılan metottur. Standart işleminden farkı, işlem yapılmak istenen
kartın ilk 6 ve son 4 hane bilgisi ile kart hamilinin TCKN ya da VKN bilgisi kullanılarak
gerçekleştirilmesidir. Bu işlem tipi sigorta sektöründe faaliyet gösteren firmaların kullanımı için
yapıldığı için üye işyerinin sektör tanımına göre kontrol bulunmaktadır. TCKN/VKN ve kartın ilk 6 ve son
4 hane bilgisi kullanılarak tüm banka kartları ile işlemler gerçekleştirilebilecektir. E-com ve mail order
işlemlerde kullanılabilecektir.

Bu kapsamda satış, taksitli satış, ön provizyon (<auth>), ön provizyon finansallaştırma (<capt>)
ve puan işlemleri (sorgu ve kullanım) kart hamilinin TCKN’si ve kartın ilk 6 son 4 hane bilgisi ile
yapılabilecektir. Aşağıda belirtilen işlem tipleri için örnek request ve response bilgilerine yer verilmiştir.

TCKN/VKN ve kart 6 4 bilgisi ile gerçekleştirilen tüm işlemler standart işlemlerde olduğu gibi
iptal ya da iade edilecektir, bu işlemler özelinde iptal ve iade request ve response bilgilerinde bir
değişiklik bulunmamaktadır. TCKN/VKN ve kart 6 4 bilgisi ile yapılan işlemlere ait örnek iptal ve iade
request bilgilerine aşağıda yer verilmiştir.

```
TCKN ve kart ilk 6 son 4 ile satış işlemi örnek Request:
```
<posnetRequest>
<mid> 6700000001 </mid>


<tid> 67000001 </tid>
<sale>
<cvc> 586 </cvc>
<currencyCode>YT</currencyCode>
<amount> 2323 </amount>
<orderID>YKB_TST_202010234500_020</orderID>
<cardInfo>
<inquiryValue> 12345678901 </inquiryValue>
<cardNoFirst> 540061 </cardNoFirst>
<cardNoLast> 1234 </cardNoLast>
</cardInfo>
</sale>
</posnetRequest>

```
VKN ve kart ilk 6 son 4 ile satış işlemi örnek Request:
```
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<sale>
<cvc> 586 </cvc>
<currencyCode>YT</currencyCode>
<amount> 100 </amount>
<orderID>YKB_TST_202010234500_021</orderID>
<cardInfo>
<inquiryValue> 1234567890 </inquiryValue>
<cardNoFirst> 540061 </cardNoFirst>
<cardNoLast> 1234 </cardNoLast>
</cardInfo>
</sale>
</posnetReq

```
TCKN ve Kart ilk 6 son 4 hane ile Taksitli Satış örnek Request:
```
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<sale>
<cvc></cvc>
<currencyCode>YT</currencyCode>
<amount> 111 </amount>
<orderID>TCKNVKN67100876500010010</orderID>
<installment> 3 </installment>
<cardInfo>
<inquiryValue> 41839824368 </inquiryValue>
<cardNoFirst> 540061 </cardNoFirst>


<cardNoLast> 4581 </cardNoLast>
</cardInfo>
</sale>
</posnetRequest>

```
TCKN ve Kart ilk 6 son 4 hane ile Mail Order satış örnek Request:
```
<posnetRequest>
<mid> 4200000001 </mid>
<tid> 68000001 </tid>
<sale>
<cvc></cvc>
<currencyCode>YT</currencyCode>
<amount> 2323 </amount>
<orderID>TCKNVKN67103480000100004</orderID>
<mailorderflag>Y</mailorderflag>
<cardInfo>
<inquiryValue> 12345678901 </inquiryValue>
<cardNoFirst> 444676 </cardNoFirst>
<cardNoLast> 1234 </cardNoLast>
</cardInfo>
</sale>
</posnetRequest>

```
TCKN ve Kart ilk 6 son 4 hane ile Taksitli Alt bayi satış örnek Request:
```
1. <posnetRequest>
2. <mid> 6700000001 </mid>
3. <tid> 67000001 </tid>
4. <sale>
5. <cvc> 586 </cvc>
6. <currencyCode>YT</currencyCode>
7. <amount> 245 </amount>
8. <orderID>TAKGUNz89019876678911237</orderID>
9. <cardInfo>
10. <inquiryValue> 41839824368 </inquiryValue>
11. <cardNoFirst> 540061 </cardNoFirst>
12. <cardNoLast> 4581 </cardNoLast>
13. </cardInfo>
14. <tckn></tckn>
15. <vkn> 1234567890 </vkn>
16. <subDealerCode>fatihto</subDealerCode>
17. </sale>
18. </posnetRequest>


```
TCKN ve kart ilk 6 son 4 ile satış işlemi örnek Response:
```
posnetRequest – sale
Sigorta sektörü firmalarının satış işlemi için kullanılmaktadır.

posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
tranDateRequired Posnet sisteminde işlemin gerçekleştiği zamanın reponse içerisinde
yer almasını sağlar. Destek ihtiyacında bu bilgi süreci hızlandıracaktır.
sale
amount Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak set
edilmelidir.
currencyCode Para birimi – “TL, US, EU”
cvc Kredi kartı güvenlik numarası – CVV2. Zorunlu bir alan değildir, bu
bilgi sisteminizde bulunmuyorsa <cvc></cvc> bu şekilde boş
gönderilebilir. CVV2 değerini 000 kullanan firmalar aynı şekilde
kullanmaya devam edebilir.
orderID Alışveriş sipariş numarası, 24 haneli alphanumeric. Üye iş yerinin
OrderID parametresinin aktif edildiği durumlarda minimum 1
maksimum 24 karakter alphanumeric.
installment Alışveriş taksit sayısı
Peşin İşlem için “00” kullanılmalıdır ya da bu alan gönderilmemelidir.
2 taksitli işlem için “02” kullanılmalıdır.
cardInfo
inquiryValue Kart hamilinin TCKN ya da VKN bilgisi gönderilmelidir. Gönderilen
TCKN ve VKN değerleri için doğruluk kontrolü bulunmaktadır. VKN
değeri 10 haneli ve TCKN değeri 11 haneli numeric değer olmalıdır.
cardNoFirst Kartın ilk 6 hane bilgisi, 6 haneli numeric değer
cardNoLast Kartın son 4 hane bilgisi, 4 haneli numeric değer
subMrcId Posnet hizmeti bir ödeme aracısı (payment facilitator) tarafından
kullanılıyorsa ödeme aracısı firma Posnet sistemine kendi
müşterilerini tanımlattığı bilgileri bu 3 alan ile göndermelidir. Ödeme
sağlayıcısı olmayan standart işyerlerinin xml içerisinde bu alanlara
yer vermemesi gerekmektedir.

mrcPfId
Mcc

tckn Alt bayi işlemi yapılmayacaksa TCKN/VKN/SubdealerCode alanları
gönderilmemelidir.
Bir ana bayinin alt bayi işlemi göndermesi için, alt bayinin kayıtlı
TCKN, VKN bilgilerinden en az birini göndermesi gerekmektedir.
İşlem TCKN/VKN ile gönderildiğinde
 Bu TCKN/VKN ile kayıtlı tek alt bayi varsa işlem alt bayiden
gerçekleşecektir.
 Bu TCKN/VKN ile kayıtlı hiç alt bayi yok ise işlem ana bayiden
gerçekleşecektir.
Bu TCKN/VKN ile kayıtlı birden fazla alt bayi olabilir. Bu durumda
subdealerCode’un gönderilmesini beklemekteyiz. subDealerCode
belirtilmediği durumda hangi alt işyerinden geçeceği bilinemeyeceği
için işlem ana bayiden gerçekleşecektir.

vkn
subDealerCode


<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 022719163090000191 </hostlogkey>
<authCode> 191630 </authCode>
<instInfo>
<inst1> 00 </inst1>
<amnt1> 000000000000 </amnt1>
</instInfo>
<pointInfo>
<point> 00000138 </point>
<pointAmount> 000000000069 </pointAmount>
<totalPoint> 00558852 </totalPoint>
<totalPointAmount> 000000279426 </totalPointAmount>
</pointInfo>
</posnetResponse>

```
VKN ve kart ilk 6 son 4 ile satış işlemi örnek Response:
```
<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 022390547990000191 </hostlogkey>
<authCode> 905479 </authCode>
<instInfo>
<inst1> 00 </inst1>
<amnt1> 000000000000 </amnt1>
</instInfo>
<pointInfo>
<point> 00000006 </point>
<pointAmount> 000000000003 </pointAmount>
<totalPoint> 00562714 </totalPoint>
<totalPointAmount> 000000281357 </totalPointAmount>
</pointInfo>
</posnetResponse>

```
posnetResponse – sale
Hostlogkey daha sonra iptal/iade gibi işlemlerde kullanılmak üzere kaydedilmelidir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
2:Daha önce gerçekleştirilmiş
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
```

```
Hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. İptal iade işlemleri için
saklanmalıdır.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur. Vade
farklı işlem yapılıyorsa iptal iade işlemleri için saklanmalıdır.
tranDate Sistem ayarına göre işlemin gerçekleşme tarihidir ve işyeri yönetici
ekranlarında görünecek tarihtir. Request içerisinde tranDateRequired
= 1 girildiyse donulur. YYAAGGSSDDSS seklindedir
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak yer alır.
pointInfo
point İşlemden kazanılan World Puan
pointAmount İşlemden kazanılan World Puan karşılığı TL tutarı
totalPoint Kartın toplam World Puanı
totalPointAmount Kartın toplam World Puan karşılığı TL tutarı
```
TCKN ve kart 6 4 bilgisi ile satış, iade ve iptal örnek kullanım senaryoları:
İptal ya da iade işlemleri satış işleminin response bilgisinde dönülen “hostLogKey” bilgisi ya da
satış işlemi requestinde gönderilen “orderID” bilgisi kullanılarak gerçekleştirilebilir. Örnek senaryolar
aşağıda belirtilmiştir.

İptal Senaryosu - Satış isteğinin gönderilmesi:

<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<sale>
<cvc> 586 </cvc>
<currencyCode>YT</currencyCode>
<amount> 2323 </amount>
<orderID>TCKNVKN67145600000000001</orderID>
<cardInfo>
<inquiryValue> 12345678901 </inquiryValue>
<cardNoFirst> 540061 </cardNoFirst>
<cardNoLast> 1234 </cardNoLast>
</cardInfo>
</sale>
</posnetRequest>

İptal Senaryosu - Satış cevabının alınması:

<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 025723570390000201 </hostlogkey>
<authCode> 235703 </authCode>
<instInfo>
<inst1> 00 </inst1>


<amnt1> 000000000000 </amnt1>
</instInfo>
<pointInfo>
<point> 00000138 </point>
<pointAmount> 000000000069 </pointAmount>
<totalPoint> 10241809 </totalPoint>
<totalPointAmount> 000005120904 </totalPointAmount>
</pointInfo>
</posnetResponse>

İptal isteği (orderID bilgisi ile):

<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<reverse>
<transaction>sale</transaction>
<orderID>TCKNVKN67145600000000001</orderID>
<!--
<orderDate></orderDate>
-->
</reverse>
</posnetRequest>

İptal isteği (hostLogKey bilgisi ile):

<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<reverse>
<transaction>sale</transaction>
<hostLogKey> 025723570390000201 </hostLogKey>
</reverse>
</posnetRequest>

İade Senaryosu - Satış isteğinin gönderilmesi:

<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<sale>
<cvc> 586 </cvc>
<currencyCode>YT</currencyCode>
<amount> 2323 </amount>
<orderID>TCKNVKN67168000000000003</orderID>
<cardInfo>
<inquiryValue> 12345678901 </inquiryValue>
<cardNoFirst> 540061 </cardNoFirst>


<cardNoLast> 1234 </cardNoLast>
</cardInfo>
</sale>
</posnetRequest>

İade Senaryosu - Satış cevabının alınması:

<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 025521994690000201 </hostlogkey>
<authCode> 219946 </authCode>
<instInfo>
<inst1> 00 </inst1>
<amnt1> 000000000000 </amnt1>
</instInfo>
<pointInfo>
<point> 00000138 </point>
<pointAmount> 000000000069 </pointAmount>
<totalPoint> 10241809 </totalPoint>
<totalPointAmount> 000005120904 </totalPointAmount>
</pointInfo>
</posnetResponse>

İade isteği (orderID bilgisi ile):

<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<reverse>
<transaction>sale</transaction>
<orderID>TCKNVKN67168000000000003</orderID>
<!--
<orderDate></orderDate>
-->
</reverse>
</posnetRequest>

İade isteği (hostLogKey bilgisi ile):

<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<return>
<amount> 2323 </amount>
<currencyCode>YT</currencyCode>
<hostLogKey> 025521994690000201 </hostLogKey>
</return>
</posnetRequest>


### TCKN/VKN ve kart ilk 6 son 4 bilgisi ile provizyon ve provizyon finansallaştırma

Standart provizyon ve provizyon işleminin finansallaştırma işlemleri kart verisi olmaksızın TCKN
ve kartın ilk 6 son 4 hane bilgisi ile gerçekleştirilmektedir. TCKN/VKN ve kartın ilk 6 son 4 hane bilgisi
ile gönderilen provizyonun finasallaştırılmasıyla, standart provizyon finasallaştırılması işleminin farkı
bulunmamaktadır, ilgili detaylar için Finansallaştırma & Peşin Fiyatına Taksitli Finansallaştırma.

```
Request Örneği
```
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<auth>
<cvc></cvc>
<currencyCode>YT</currencyCode>
<amount> 300 </amount>
<orderID>TCKNVKN67100876500110012</orderID>
<cardInfo>
<inquiryValue> 12345678901 </inquiryValue>
<cardNoFirst> 540061 </cardNoFirst>
<cardNoLast> 1234 </cardNoLast>
</cardInfo>
</auth>
</posnetRequest>

```
posnetRequest – auth
Provizyon işlemi için kullanılmaktadır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
tranDateRequired Posnet sisteminde işlemin gerçekleştiği zamanın reponse içerisinde
yer almasını sağlar. Destek ihtiyacında bu bilgi süreci hızlandıracaktır.
auth
amount Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak set
edilmelidir.
currencyCode Para birimi – “TL, US, EU”
cvc Kredi kartı güvenlik numarası – CVV2. Zorunlu bir alan değildir, bu
bilgi sisteminizde bulunmuyorsa <cvc></cvc> bu şekilde boş
gönderilebilir. CVV2 değerini 000 kullanan firmalar aynı şekilde
kullanmaya devam edebilir.
orderID Alışveriş sipariş numarası
installment Alışveriş taksit sayısı
Peşin İşlem için “00” kullanılmalıdır.
2 taksitli işlem için “02” kullanılmalıdır.
cardInfo
```

```
inquiryValue Kart hamilinin TCKN ya da VKN bilgisi gönderilmelidir. Gönderilen
TCKN ve VKN değerleri için doğruluk kontrolü bulunmaktadır. VKN
değeri 10 haneli ve TCKN değeri 11 haneli numeric değer olmalıdır.
cardNoFirst Kartın ilk 6 hane bilgisi, 6 haneli numeric değer
cardNoLast Kartın son 4 hane bilgisi, 4 haneli numeric değer
subMrcId Posnet hizmeti bir ödeme aracısı (payment facilitator) tarafından
kullanılıyorsa ödeme aracısı firma Posnet sistemine kendi
müşterilerini tanımlattığı bilgileri bu 3 alan ile göndermelidir. Ödeme
sağlayıcısı olmayan standart işyerlerinin xml içerisinde bu alanlara
yer vermemesi gerekmektedir.
```
```
mrcPfId
mcc
```
```
tckn Alt bayi işlemi yapılmayacaksa TCKN/VKN/SubdealerCode alanları
gönderilmemelidir.
Bir ana bayinin alt bayi işlemi göndermesi için, alt bayinin kayıtlı
TCKN, VKN bilgilerinden en az birini göndermesi gerekmektedir.
İşlem TCKN/VKN ile gönderildiğinde
 Bu TCKN/VKN ile kayıtlı tek alt bayi varsa işlem alt bayiden
gerçekleşecektir.
 Bu TCKN/VKN ile kayıtlı hiç alt bayi yok ise işlem ana bayiden
gerçekleşecektir.
Bu TCKN/VKN ile kayıtlı birden fazla alt bayi olabilir. Bu durumda
subdealerCode’un gönderilmesini beklemekteyiz. subDealerCode
belirtilmediği durumda hangi alt işyerinden geçeceği bilinemeyeceği
için işlem ana bayiden gerçekleşecektir.
```
```
vkn
subDealerCode
```
Response Örneği

<posnetResponse>
<approved> 1 </approved>
<hostlogkey> 025521536690000201 </hostlogkey>
<authCode> 215366 </authCode>
<instInfo>
<inst1> 00 </inst1>
<amnt1> 000000000000 </amnt1>
</instInfo>
<pointInfo>
<point> 00000000 </point>
<pointAmount> 000000000000 </pointAmount>
<totalPoint> 12609525 </totalPoint>
<totalPointAmount> 000006304762 </totalPointAmount>
</pointInfo>
</posnetResponse>

```
posnetResponse – auth
Hostlogkey daha iptal/iade işlemlerde gibi kullanılmak üzere kaydedilmelidir.
```
```
posnetResponse
approved İşlem sonucu.
```

```
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. Finansallaştırma, İptal ve iade
işlemleri için saklanmalıdır.
authCode Sistem yetkilendirmesine istinaden oluşturulan yetki kodudur. Vade
farklı işlem yapılıyorsa iptal iade işlemleri için saklanmaldıır.
tranDate Sistem ayarına göre işlemin gerçekleşme tarihidir ve işyeri yönetici
ekranlarında görünecek tarihtir. Request içerisinde
tranDateRequired = 1 girildiyse donulur. YYAAGGSSDDSS seklindedir
instInfo
inst1 İşlemin kaç taksite bölündüğünü gösterir. Örn: 00 veya 03
amnt1 Taksit tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak yer alır.
pointInfo
point İşlemden kazanılan World Puan
pointAmount İşlemden kazanılan World Puan karşılığı TL tutarı
totalPoint Kartın toplam World Puanı
totalPointAmount Kartın toplam World Puan karşılığı TL tutarı
```
### TCKN/VKN ve kart ilk 6 son 4 bilgisi ile Puan İşlemleri

TCKN/VKN ve kartın ilk 6 son 4 bilgisi ile puan işlemleri de gerçekleştirilebilmektedir. Aşağıda
puan sorgulama ve puan kullanımı örnek requestleriyle açıklanmıştır. TCKN/VKN ve kartın ilk 6 son 4
bilgis ile gerçekleştirilen puan kullanım işlemlerinin iptal ve iade request ve response yapılarında bir
değişiklik bulunmamaktadır.

#### TCKN/VKN ve kart ilk 6 son 4 bilgisi ile puan sorgulama

Bu işlem bir WorldCard'ın sahip olduğu worldpuan bilgisinin görüntülenmesi için kullanılır. Kart
ekstresinde ve sayfasında görünmez.

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<pointInquiry>
<cardInfo>
<inquiryValue> 12345678901 </inquiryValue>
<cardNoFirst> 540061 </cardNoFirst>
<cardNoLast> 1234 </cardNoLast>
</cardInfo>
</pointInquiry>
</posnetRequest>


```
World Puan sorgulamak için kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
pointInquiry
cardInfo
inquiryValue Kart hamilinin TCKN ya da VKN bilgisi gönderilmelidir. Gönderilen
TCKN ve VKN değerleri için doğruluk kontrolü bulunmaktadır. VKN
değeri 10 haneli ve TCKN değeri 11 haneli numeric değer olmalıdır.
cardNoFirst Kartın ilk 6 hane bilgisi, 6 haneli numeric değer
cardNoLast Kartın son 4 hane bilgisi, 4 haneli numeric değer
```
Response Örneği

<?xml version='1.0' encoding='iso-8859-9'?>
<posnetResponse>
<approved> 1 </approved>
<pointInfo>
<point> 59386187 </point>
<pointAmount> 000029693093 </pointAmount>
<totalPoint> 00000000 </totalPoint>
<totalPointAmount> 000000000000 </totalPointAmount>
</pointInfo>
</posnetResponse>

```
posnetResponse – pointInfo
Puan sorgulama işlemi sonucu, puan bilgilerine erişilir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
pointInfo
point Karttaki kullanılabilir toplam World Puan
pointAmount Karttaki kullanılabilir toplam World Puan karşılığı TL tutarı – Kuruş
cinsinden Ör: 12.34 TL için 1234
totalPoint N/A
totalPointAmount N/A
```
```
posnetRequest – pointInquiry
```

#### TCKN/VKN ve kart ilk 6 son 4 bilgisi ile puan kullanım

Bu işlem bir WorldCard'ın sahip olduğu worldpuanların kullanılması amacıyla yapılır. İşlem kart
ekstresinin "WorldPuan Bilgileriniz" kısmında görünür. Karma işlem yapılarak da puan kullanımı
gerçekleştirilebilmektedir. Puan kullanımı yerine Karma İşlem yapılarak tutar alanına 0 (sıfır), puan
alanına kullanılmak istenilen puan gönderilebilir. Bknz: Karma İşlemler

Request Örneği

<?xml version="1.0" encoding="ISO-8859-9"?>
<posnetRequest>
<mid> 6700000001 </mid>
<tid> 67000001 </tid>
<pointUsage>
<cvc></cvc>
<currencyCode>YT</currencyCode>
<amount> 100 </amount>
<orderID>YKB_TST_202102064500_020</orderID>
<cardInfo>
<inquiryValue> 12345678901 </inquiryValue>
<cardNoFirst> 540061 </cardNoFirst>
<cardNoLast> 1234 </cardNoLast>
</cardInfo>
</pointUsage>
</posnetRequest>

```
posnetRequest – pointUsage
World Puan kullanımı için kullanılır.
```
```
posnetRequest
mid YKB Üye İşyeri Numarası <%MERCHANT_ID%>
tid YKB Üye İşyeri Terminal Numarası <%TERMINAL_ID%>
pointUsage
amount Alışveriş tutarı – Kuruş cinsinden Ör: 12.34 TL için 1234 olarak set
edilmelidir.
currencyCode Para birimi – “TL, US, EU”
orderID Alışveriş sipariş numarası
cardInfo
inquiryValue Kart hamilinin TCKN ya da VKN bilgisi gönderilmelidir. Gönderilen
TCKN ve VKN değerleri için doğruluk kontrolü bulunmaktadır. VKN
değeri 10 haneli ve TCKN değeri 11 haneli numeric değer olmalıdır.
cardNoFirst Kartın ilk 6 hane bilgisi, 6 haneli numeric değer
cardNoLast Kartın son 4 hane bilgisi, 4 haneli numeric değer
```
Response Örneği

<?xml version='1.0' encoding='iso-8859-9'?>
<posnetResponse>


<approved> 1 </approved>
<hostlogkey> 032516673490000211 </hostlogkey>
<pointInfo>
<point> 00000000 </point>
<pointAmount> 000000000000 </pointAmount>
<totalPoint> 59385787 </totalPoint>
<totalPointAmount> 000029692893 </totalPointAmount>
</pointInfo>
</posnetResponse>

```
posnetResponse – pointInfo
Puan kullanım işlemi sonucu, puan bilgilerine erişilir.
```
```
posnetResponse
approved İşlem sonucu.
0:Başarısız
1:Başarılı
respCode Hata kodu.
İşlem sonucunun başarısız olduğu durumda dikkate alınmalıdır. Hata
Kodları bölümünde açıklamalara yer verilmiştir.
respText Hata mesajı.
hostlogkey Sistem tarafındaki işlemin tekil Id’sidir. İptal iade işlemleri için
saklanmalıdır.
pointInfo
point İşlemde kullanılan World Puan
pointAmount İşlemde kullanılan World Puan karşılığı TL tutarı – Kuruş cinsinden Ör:
12.34 TL için 1234
totalPoint Kartın kalan toplam World Puanı
totalPointAmount Kartın kalan toplam World Puan karşılığı TL tutarı – Kuruş cinsinden
Ör: 12.34 TL için 1234
```
## Hata Kodları

Yanlış parametre girilmesi veya Posnet’e bağlanılması durumunda alınabilecek hata kodları ve
gerçekleştirilmesi gereken aksiyonlar aşağıda belirtilmiştir.

```
Hata Kodu Yapılması Gereken
100 – OK Posnet sunucuyla iletişim başarıyla kuruldu. Ancak bu sonuç kodu,
işlemin başarılı olduğu anlamına gelmez. İşlemin başarılı olup
olmadığını anlamak için sunucudan alınan yanıtın kontrol edilmesi
gerekmektedir.
101 - CONNECT_ERROR Bağlanılan sunucu ip’si kontrol edilmelidir.
103 - PACKET_ERROR Posnet sunucu aldığı paketi çözümleyemediğinde bu hata dönülür.
Çözümleme işleminde kaynak ip (ownIP) kullanıldığından, bu
parametrenin internete çıkış ip'niz ile aynı olduğundan emin
olunmalıdır. IP Bazlı Hatalar sayfasındaki bilgiler de sorunu
çözmenize yardımcı olabilir.
113 - CONNECT_CONNECT Hostname parametresinin doğru set edildiği ve internet bağlantısı
olduğu kontrol edilmelidir. Firewall vs. erişimlerini kontrol etmek
```

```
için Hostname parametresine (adrese) telnet çekerek, erişim
problemi olmadığı görülmelidir. (Örneğin komut satırından: telnet
193.254.228.53 2222). Telnet çekerken, port parametresine girilen
değerin (dokümantasyonda aksi belirtilmedikçe 2222) telnet
komutuna da girildiğinden emin olun (Posnet sunucuya ancak
doğru porttan bağlanabilirsiniz, bu telnet için de geçerlidir).
```
```
Posnet sunucusuna telnet de çekemiyorsanız internet
bağlantınızda bir sorun vardır. Örneğin firewall ayarlarınızda,
posnet sunucuya doğru porttan çıkış verildiğinden emin
olmalısınız. Birçok firewall sadece http (80) ve https (8080)
portundan çıkış yapılmasına izin vermektedir. Bu durumda izin
verilen portlar arasına 2222'nin (veya dokümantasyonda belirtilen
bağlantı portunun) eklenmesi gerekir.
```
İnternet bağlantınızda da bir sorun yoksa test destek grubuyla
iletişim kurmalısınız.
115 - CONN_REFUSED Posnet sunucu bağlantı isteğinizi reddetti. Firmanızın Posnet
sistemine işlem gönderebileceği IP'ler listesinde bulunmayan bir
ip'den işlem denemiş olabilirsiniz. IP Bazlı Hatalar sayfasındaki
bilgiler sorunu çözmenize yardımcı olabilir.
120 - CGI_SERVLET_ERROR Bağlantı açıldı, ancak paket gönderilemedi.
121 - EXCHANGE_TIMEOUT Posnet sunucudan yanıt alınamadı. Internet bağlantınızda bir
sorun olabilir. Internet bağlantınızda bir sorun yoksa tekrar
deneyin, sorun devam ederse test destek birimini arayın.
131 - ERROR_CCNO Kart No parametresi hatalı. Parametre açıklamalarına bakın.
132 - ERROR _HOSTLOGKEY Hostlogkey parametresi hatalı. Parametre açıklamalarına bakın.
133 - ERROR _AUTH Onay kodu parametresi hatalı. Parametre açıklamalarına bakın.
134 - ERROR _HOSTNAME Hostname parametresi hatalı. Parametre açıklamalarına bakın.
135 - ERROR _PORT Port parametresi hatalı. Parametre açıklamalarına bakın.
136 - ERROR _OWNIP Ownip parametresi hatalı. Parametre açıklamalarına bakın.
137 - ERROR _AMOUNT Tutar parametresi hatalı.Tutar bilgisini göndermeden önce son iki
hanenin mutlaka kuruş olduğundan ve kuruş veya binler ayracı gibi
ayraçlar kullanılmadığından emin olmalısınız. Örneğin 5,12 TL
göndermek için 512 değerini, 5 TL göndermek için 500 değerini
girmelisiniz.
138 - ERROR _EXPDATE Kredi kartı son kullanım tarihi parametresi hatalı. Parametre
açıklamalarına bakın.
139 - ERROR _CVC Kredi kartı güvenlik numarası (CVC) parametre hatalı. Parametre
açıklamalarına bakın.
140 - ERROR _TAKNUM Taksit parametresi hatalı. Taksit parametresi 2 karakter
uzunluğunda ve numerik olmalıdır. Ör: 02. Eğer taksit
yapılmayacaksa 00 veya 01 girilmelidir.

Taksitli olması zorunlu işlemlerde (örneğin VFT) taksit
parametresinin 00 veya 01 girilmesi de bu hataya neden olur.
142 - ERROR _MIDNO Üye ışyeri numarası (MID) parametresi hatalı. Parametre
açıklamalarına bakın.
143 - ERROR _TIDNO Terminal numarası (TID) parametresi hatalı. Parametre
açıklamalarına bakın.


```
144 - ERROR _ORDERID Sipariş numarası (ORDERID) parametresi hatalı. 20 karakter
uzunluğunda ve sadece harf ve rakamlardan oluşmalıdır. Bkz:
Parametre açıklamaları.
146 - ENCRYPTION ERROR Şifreleme hatası. Posnet Support possupp@yapikredi.com.tr 'a
mail atın.
147 - CURRENCY CODE ERROR Para birimi parametresi hatalı. CurrencyCode parametresine "TL"
veya "YT" değerleri dışında bir değer girildiğinde alınır. Bu hatanın
en sık nedeni parametre olarak "YTL" girilmesidir.
156 - ERROR_VFT_CODE VFT Kampanya Kodu hatalı. Fix 4 karakter uzunluğunda olması
gerekiyor.
180 - KATLI VE EKSTRA PUAN Aynı işlemde hem kat hem ekstra puan belirtilemez. Ya kat puan
parametresini 00, ya da ekstra puan parametresini 000000
girmelisiniz.
181 - ERROR_TXNSEQNO TranSeqNo parametresi hatalı. Parametre açıklamalarına bakın.
184 - ERROR_TRANTYPE İşlem tipi parametresi hatalı. Parametre açıklamalarına bakın.
185 - ERROR_BONUS Puan işlem tipi hatalı.
186 - ERROR_EXTRAPOINT Ekstra puan parametresi hatalı. Parametre açıklamalarına bakın.
187 - ERROR_MULTIPLE Katlı puan parametresi hatalı. Parametre açıklamalarına bakın.
```
Parametrelerde ve posnet sistemiyle iletişimde sorun olmadığı halde (iletişim hatası = 100) işlem
onaylanmadığında alınabilecek hatalar ve gerçekleştirilmesi gereken aksiyonlar aşağıda belirtilmiştir.

```
Hata
Kodu
```
```
Açıklama Yapılması Gereken
```
```
0001 BANKANIZI ARAYIN 0001 Kart bu tip işleme izin vermiyor veya kartın kredisi yetersiz.
Kartı veren bankayı arayın.
0004 RED-KARTA EL KOY 0004 Kart Bloke edilmiş.
0005 RED-ONAYLANMADI Kart bilgilerinden ( KK No, SKT, CVV) biri yada birkaçı hatalı
girilmiş veya Worldcard'lar için bankaca tanımlanmış
günlük limitler aşılmış olabilir.
```
```
Kart bilgilerinin doğru girildiğinden emin olmak amacıyla,
İşyeri Yönetici Ekranlarındaki “Online İşlemler” sayfasından
bir deneme işlemi yapılabilir. Bu işlemde de bu hatanın
alınması kart bilgilerinin doğru gönderildiği anlamına gelir.
```
```
Bu hatanın bir diğer nedeni de, kart sahibi banka tarafından
belirlenen internetten günlük işlem yapma limitinin kart
için dolmasıdır. Bu limit her bankaya göre değişmektedir ve
YKB kredi kartları için 3'tür; yani bir YKB kredi kartı günde
en fazla 3 internet alışverişinde kullanılabilir. Bu limit
aşıldıysa, kart sahibi kendi bankasının kredi kartı müşteri
hizmetlerini arayarak bu limiti sıfırlamalıdır.
```
```
Girilen tutar finansallaştırma işleminde provizyon
tutarından, iade işleminde de finansallaştırma tutarından
büyük olamaz.
0005
Onaylanmadı(Notonus online
iadenin iptal islemi ve reversal
iptal islemi yapilamaz)
```
```
Yapı Kredi Bankası dışında farklı bir bankanın kartı ile
yapılan bir işlem için iadenin iptali yapılmaya çalışılırsa
alınan hatadır. Farklı banka kartları ile yapılan işlemin iadesi
```

kart sahibi bankaya ulaştığından bu işlemin iptali mümkün
olamamaktadır.
0007 BANKANIZI ARAYIN 0007 Kart bloke/çalıntı/kayıp statüsünde olabilir (özel durum).
0012 RED-GECERSIZ ISLEM Bu hatanın en sık rastlanan nedeni, yanlış miktarda taksit
sayısıyla taksit yapmaya çalışmanızdır. En fazla kaç taksit
yapabileceğinizi öğrenmek için 444 0 448'i aramalısınız.
Eğer test kartlarıyla işlem yapıyorsanız, bu bilgiyi Posnet
Support possupp@yapikredi.com.tr adresinden
öğrenebilirsiniz. Genellikle normal işlemler için en fazla 9
taksit yapılabilmektedir.

```
0012 almanızın bir diğer nedeni de kullanılan kartın
müsaade etmediği bir işlem yapmanızdır. Örneğin başka
bankaya ait bir kredi kartına taksit yapmaya çalıştığınızda
ya da orijinal işlem tutarından daha fazla bir tutar iade
etmeye çalıştığınızda bu hatayı alırsınız.
```
Bu adımlar sorunu çözmenize yardımcı olamadıysa,
bankamızdaki üye işyeri tanımlamalarınızda sorunlar
olabilir. Üye işyeri servisimizi arayıp üye işyeri no.nuzu ve
hangi işlemi yaparken bu hatayı aldığınızı bildirmeniz
gerekmektedir.
0014 RED-HATALI KART 0014 Numara bir kredi kartına ait değil / Kart no hatalı.
0015 PROVIZYON BULUNAMADI Provizyon alınmamış. Provizyon iptal edilmiş olabilir. Tekrar
provizyon almalısınız.
0015 TERMINAL IŞLEM YETKISI YOK Terminal yetkisi işlem için uygun değil.
0015 IŞYERI STATÜSÜ HATALI Işyeri statüsü uygun değil.
0015 TAKSIT IÇIN YETERSIZ TUTAR Taksit için girilen tutar minimum tutarında altında ise bu
hata verilir.
0030 BANKANIZI ARAYIN 0030 Bu hatanın nedeni kartı veren (issuer) bankanın YKB
provizyon sistemine gönderdiği bozuk verilerdir. Kartı
veren banka aranmalı ve bir sanal pos işleminde bu hatanın
alındığı belirtilmelidir. Hata çözümleninceye kadar sorunun
geçici çözümü amacıyla, işlem mail order yoluyla YKB'ye
gönderilebilir. Mail order yapmak için üye işyeri servisimizi
arayınız.
0041 RED-KARTA EL KOY 0041 Kayıp Kart - (444 0 448)' i arayınız.
0043 RED-KARTA EL KOY 0043 Sorunun nedeni işlemde kullanılan kredi kartının YKB
provizyon sisteminde tutulan çalıntı kredi kartı listesinde
bulunmasıdır. Işlem kart sahibi bankaya iletilmeden
reddedilmektedir.

Sanal POS işlemlerinde kullanılan kredi kartları, çeşitli
nedenlerle YKB tarafından karaliste benzeri bir listeye
alınabilmektedir. Eğer kartın çalıntı listesinde bulunmasının
yanlış olduğunu (kartın güvenilir bir kart olduğunu)
düşünüyorsanız, YKB Üye Işyeri Operasyon Servisi'ni (444 0
448) aramalısınız.
0051 RED-YETERSIZ BAKIYE 0051 Kartın bakiyesi yetersiz. Kartı veren bankayı arayın.
0053 BANKANIZI ARAYIN 0053 Hesap bulunamadı.


0054 RED-ONAYLANMADI 0054 Son kullanım tarihi geçmiş olan kart.
0057 RED-ONAYLANMADI 0057 Yapılan işlem, kullanılan kart tipi ile yapılamaz
(Debit/kredi). Örnek: POSNET’ten debit kartla (ATM'lerden
para çekmek için kullanılan banka kartları) işlem yapılamaz.
Hata mesajında “X” olarak belirtilen yerde, işlemin yapıldığı
kartın tipi belirtilir (D: Debit/K: Kredi kartı).
0057 RED-ONAYLANMADI 0057 Bu hata, işlemde kullanılan kredi kartının internetten işlem
yapma yetkilerinde bir sorun olduğu durumda alınır. Kart
sahibi kredi kartını aldığı bankanın kredi kartları servisiyle
görüşüp kredi kartını e-ticarette kullanamadığını
belirtmelidir.
0058 RED-ONAYLANMADI 0058 Terminalin işlem tipine yetkisi yok.
0062 RED-ONAYLANMADI 0062 Kısıtlı kart.
0065 RED-ONAYLANMADI 0065 Kredi kartının para çekme limiti aşıldığında verilen bu hata,
normal durumlarda sanal pos işlemlerinde
dönülmemelidir. Bu hatanın alınması durumunda kartı
veren (issuer) banka aranmalı, bir sanal pos işleminde bu
hatanın alındığı belirtilmelidir. Hata çözümleninceye kadar
sorunun geçici çözümü amacıyla, işlem mail order yoluyla
YKB'ye gönderilebilir. Mail order yapmak için üye işyeri
servisimizi arayınız.
0091 BANKANIZI ARAYIN 0091 Kartı veren (issuer) banka ile iletişimde zaman aşımı oldu
(bankadan zamanında yanıt alınamadı). Tekrar deneyin;
sorun devam ederse, kartı veren bankayı arayıp, bir sanal
pos işleminde bu hatanın alındığını belirtin.
0122 DATABASE DE ISTENILEN KAYIT
YOK

```
Iptal işleminde hata. Iptal işlemi provizyon işleminden 1
hafta sonrasına kadar yapılabilir. Finansallaştırma
yapılmadan finansallaştırma iptal yapıldığında da bu hata
alınabilir.
```
Bu hatanın bir nedeni de daha önce firmanıza ait bir mid ile
yaptığınız bir işlemi, firmanıza ait başka bir mid kullanarak
finansallaştırmak veya iptal etmek istemenizdir. Bunun en
sık rastlanan yolu, bir mid kullanılarak yapılmış bir işlemin
programsal olarak başka bir mid kullanılarak
finansallaştırılması veya iptal edilmesidir.
0123 ORJINAL ISLEM BULUNAMADI Finansallaştırma, iptal veya iade edilmeye çalışılan işlem
bulunamadı. Muhtemelen yanlış YKB ref.no veya sipariş no
ile finansallaştırma/iptal yapmaya çalışıyorsunuz.
Finansallaştırmaya/iptal etmeye çalıştığınız işlem Posnet
sistemine hiç gönderilememiş de olabilir.

```
VFT işlemlerinin iptalinde YKB ref.no ile iptal yapılıyorsa
onay kodu (authCode) kontrolü de yapılmaktadır. Bu
iptallerde bu hata alınıyorsa YKB ref.no ile birlikte onay
kodu da kontrol edilmelidir.
```
```
Bir işlem için Posnet sisteminden yanıt alınamadığında,
otomatik olarak iptal gönderilmesi üzerine bu hata alınması
normaldir; bu durum, işlemin Posnet sistemine hiç
ulaşmadığını gösterir.
```

##### 0127 ORDERID DAHA ONCE

##### KULLANILMIS

Kullandığınız sipariş no (orderId) daha önce kullanılmış.
Yeni bir sipariş no ile tekrar deneyin.
0129 KREDI KARTI MERCHANT
BLACKLIST TE

Bu kredi kartı işyeri karalistesine alınmış. Kartın bu işyeri
tarafından kullanılabilmesi için önce karalisteden
çıkarılması gerekiyor.
0146 * HATALI SIFRELEME: KULLANICI
ISMI & SIFRE veya NO
GENERATED RECORD

Kullanıcı adı, şifre veya şifreleme anahtarı yanlış
girilmektedir. Ayrıntılı bilgi için StubF1Class.setUserName,
StubF1Class.setPassword,
StubF1Class.setEncKey metodlarına bakınız. İşyeri Yönetici
Ekranlarının ana menüsündeki "Anahtar Yarat" linki
kullanılarak yeni kullanıcı adı, şifre ve anahtar oluşturulup,
bu bilgilerle işlem tekrar denenmesi gerekir.
0147 * HATALI KULLANICI ISMI & SIFRE 146 hatasının açıklamalarına bakın.
0148 * CRYPTO HATASI: MID Web sunucunuzun tarihi, saati veya TimeZone bilgisi yanlış
olabilir. Bu bilgilerde bir sorun yoksa Teknik Destek
birimimize başvurulmalıdır.

Gönderdiğiniz bilgileri karşılayan Posnet Servisi, bazı şifreli
bilgilerin açılmasında tarih ve saatten faydalanmaktadır.
Sunucunuzun tarih veya saatinin yanlış olması durumunda
bu bilgiler servis tarafından çözümlenememektedir.
0148 * HATALI MID Üye işyeri no bulunamadı. Üye işyeri no (MID) parametresi
yanlış.
0148 * MID,TID,IP HATALI: X.X.X.X Bağlantı yaparken kullandığınız mid (üye işyeri no) yanlış
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
possupp@yapikredi.com.tr adresine mid/tid bilgisiyle
birlikte göndererek ip tanımınızın değiştirilmesini
sağlayabilirsiniz.
0150 PAKET HATALI Yanlış CVC no kullanılmış. Üretim ortamında, test
ortamında kullanılan XXX kullanılmışsa bu hata alınır.
Üretim ortamında CVC kodları müşteriniz tarafından
girilmelidir. Ayrıca test ortamında XXX dışında anlamsız bir
CVC (xxx gibi) girilmesi de bu hataya neden olur.

0150 PAKET HATALI (ORDERDATE) (^) Üye iş yerinin OrderID parametresinin aktif edildiği
durumlarda iptal/iade/finansallaştırma gibi orijinal işlemin
bulunmasını gerektiren işlemlerde orderID yanında
orderDate bilgisinin gönderilmemesi bu hataya neden olur.


0150 PAKET HATALI (ORDERID) Üye iş yerinin order id kullanması gereken bir işlemde order
id göndermemesi veya eksik ya da fazla karakter
göndermesi bu hataya neden olur.
0150 INVALID MID TID IP Yanlış bir ip'den veya yanlış bir mid/tid ile işlem yapmaya
çalışıyorsunuz. IP Bazlı Hatalar sayfasındaki bilgiler sorunu
çözmenize yardımcı olabilir.
0180 GECERSIZ ISTEK (CARDNOFIRST
BULUNAMADI)

cardInfo taginin içerisinde bulunması gereken cardNoFirst
değeri bulunamadığında alınır.
0180 GECERSIZ ISTEK (CARDNOFIRST
BULUNAMADI)

cardInfo taginin içerisinde bulunması gereken cardNoLast
değeri bulunamadığında alınır.
0180 GECERSIZ ISTEK
(INQUIRYVALUE BULUNAMADI)

cardInfo taginin içerisinde bulunması gereken inquiryValue
değeri bulunamadığında alınır.
0180 KART BILGISI YA CCNO TAGINDE
YA DA CARDINFO TAGINDE
GONDERILMELIDIR

TCKN/VKN bilgisi ve kartın ilk 6 son 4 hane bilgisi ile yapılan
işlemlerde kart bilgisi cardInfo tagi kullanılarak
gönderilmelidir, request içerisinde aynı anda hem ccno
hem de cardInfo tagi bulunamaz.
0180 HATALI FORMAT
(CARDNOFIRST TAGI HATALI)

cardInfo taginin içerisinde bulunması gereken cardNoFirst
değeri beklenen formatta gönderilmediği zaman alınır.
Beklenen değer 6 haneli numeric bir değerdir.
0180 HATALI FORMAT (CARDNOLAST
TAGI HATALI)

cardInfo taginin içerisinde bulunması gereken cardNoLast
değeri beklenen formatta gönderilmediği zaman alınır.
Beklenen değer 4 haneli numeric bir değerdir.
0180 HATALI FORMAT
(INQUIRYVALUE TAGI HATALI)

cardInfo taginin içerisinde bulunması gereken inquiryValue
değeri beklenen formatta gönderilmediği zaman alınır.
Beklenen değer VKN için 10 TCKN için 11 haneli numeric bir
değerdir.
0180 HATALI FORMAT
(INQUIRYVALUE TAGI (TCKN)
HATALI)

cardInfo taginin içerisinde bulunması gereken inquiryValue
alanı içerisinde gönderilen değer geçerli bir TCKN olmadığı
zaman alınır.
0180 HATALI FORMAT
(INQUIRYVALUE TAGI (VKN)
HATALI)

cardInfo taginin içerisinde bulunması gereken inquiryValue
alanı içerisinde gönderilen değer geçerli bir VKN olmadığı
zaman alınır.
0205 GECERSIZ TUTAR Bu hata şu koşullarda alınmaktadır:

```
 Yapılan işlemin tutarı maksimum işlem tutarını
(99.999,99 TL) aştığında.
Posnet sisteminde bir defada en fazla 99.999,99
TL'lik işlem yapılabilir.
 Finansallaştırma işlemi yapılırken gönderilen işlem
tutarı, provizyon işlem tutarını "provizyon aşım
yüzdesi"nden fazla aştığında
```
Tüm iade işlemlerinde, gönderilen işlem tutarı iade
edilebilecek işlem tutarını aştığında
0211 GRUP KAPAMA YAPILMIS Bu hata finansallaşma veya satış iptal işlemini yaparken
alınır. Iptal etmek istediğiniz işlemin finansallaştırıldığı için
artık iptal edilememektedir. Yapmış olduğunuz
finansallaştırma veya satışı iade etmek için iade işlemi
yapmalısınız.
0217 GEÇERSIZ IŞLEM STATÜSÜ Çalıntı kart. Kullanıcı ve kart no YKB’ye bildirilmelidir.


##### 0218 BU SIPARIS DAHA ONCE IADE

##### EDILDIGI ICIN IPTAL ISLEMI

##### GECERSIZDIR

```
İade edilmiş bir işlem iptal edilmeye çalışıldığında alınır.
```
##### 0219 BU SIPARIS NO ILE BUGUN

##### FINANSALLASTIRMA YAPILDIGI

##### ICIN TEKRAR

##### FINANSALLASTIRMA

##### YAPILAMAZ.

Farklı günlerde gerçekleştirilmiş aynı order id’ye sahip
provizyon işlemlerinde aynı gün içerisinde yalnızca birine
finansallaştırma gönderilebilir, ikinci bir işleme
gönderilmek istendiğinde bu hata alınır. Farklı bir günde
finansallaştırma denenmelidir.
0220 IPTAL ISLEMI YAPILMIS Zaten iptal edilmiş bir işlem tekrar iptal edilmeye
çalışıldığında alınır.
0223 ONAYLANMADI Finansallaştırma yapılmadan finansallaştırma iptal
yapılmak isteniyor.
0232 KREDIKARTI IŞLEM SINIRI AŞILDI Posnet sisteminde Üye Işyeri tarafından tanımlanmış, belli
bir periyotta bir kredi kartı ile işlem yapılabilecek
maksimum sayı aşıldığı vakit ilgili hata oluşur. Bkz. Işlem
Kısıtlama
0370 ISLEM IPTALI YAPILMIS Iptal işlemi zaten yapılmış.
0400 DB ERROR Posnet sunucu teknik bir sorun yaşıyor. Tekrar deneyin,
sorun tekrar ederse possupp@yapikredi.com.tr adresi ile
iletişim kurun.
0411 ISLEM HENUZ
FINANSALLASMAMIS

Iade yaparken alınan bu hata, finansallaştırma işleminde
belirtilen tutarın henüz karttan tahsil edilip hesabınıza
yansımadığını gösterir. Bu nedenle iade işlemi yapmanıza
gerek yoktur, finansallaştırma iptal yapmalısınız.
0444 BANKANIZI ARAYIN YKB’yi arayın.
0450 IADE ISLEMI YAPILAMIYOR İşyeri yönetici ekranları dışından iade edilmiş olabilir. Işlemi
daha önce üye işyeri servisimizi arayarak iade etmiş
olabilirsiniz. Eğer böyle bir iade talebiniz olmadıysa, üye
işyeri servisimizi aramanız gerekmektedir.
0788 FINANSAL ISLEM YAPILMIS Finansallaştırma yapılmış. Provizyon iptal edilmek
isteniyorsa önce finansallaştırma iptal edilmeli.
E997 DOMAIN SERVICE HATASI Banka servislerinde alınan beklenilmeyen hatalarda verilir.
possupp@yapikredi.com.tr adresine haber verilmelidir.
E998 VERİ TABANI HATASI Banka servislerinde alınan beklenmedik veri tabanı
hatalarında verilir. possupp@yapikredi.com.tr adresine
haber verilmelidir.
E999 GENEL HATA Banka servislerinde alınan beklenilmeyen hatalarda verilir.
possupp@yapikredi.com.tr adresine haber verilmelidir.
E117 TARIH DEGERLERI BOS OLAMAZ merchantReconciliation servisinde kullanılan startdate
veya enddate alanları boş gönderildiği takdirde bu hata
alınır. Requestte gönderilen ilgili alanlar kontrol edilmelidir.
E154 ÜYE İŞYERİ ADI NULL YA DA BOŞ
OLAMAZ

merchantReconciliation servisinde kullanulan mid alanı boş
olduğunda bu hata alınır. Requestte gönderilen ilgili alanlar
kontrol edilmelidir.
E190 CURRENCYCODE HATALI Currencycode alanı hatalı gönderildiği zaman alınır, ilgili
alanda gönderilen değer kontrol edilmelidir.
E215 TARİH ALANI HATALI merchantReconciliation servisinde kullanılan startdate
veya enddate alanları hatalı formatta gönderildiği takdirde
bu hata alınır. Requestte gönderilen ilgili alanlar kontrol
edilmelidir.


E219 KAYIT BULUNAMADI Agreement servisinde gönderilen orderid ye ait bir kayıt
bulunamadığı durumda verilen hata. Orderid kontrol
edilmelidir, doğru orderid olduğu düşünülüyorsa
possupp@yapikredi.com.tr adresine haber verilmelidir.
0302 ONL NET EXCEPTION Sistem hatası olduğu durumlarda bu hata verilir, alındığı
durumlarda possupp@yapikredi.com.tr adresine haber
verilmelidir.
0302 ONL NET CONNECTIONERROR Sistem hatası olduğu durumlarda bu hata verilir, alındığı
durumlarda possupp@yapikredi.com.tr adresine haber
verilmelidir.
0302 ONL NET READENQTIMEOUT Sistem hatası olduğu durumlarda bu hata verilir, alındığı
durumlarda possupp@yapikredi.com.tr adresine haber
verilmelidir.
0302 ONL NET WRITEBUFFERERROR Sistem hatası olduğu durumlarda bu hata verilir, alındığı
durumlarda possupp@yapikredi.com.tr adresine haber
verilmelidir.
0302 ONL NET READDATATIMEOUT Sistem hatası olduğu durumlarda bu hata verilir, alındığı
durumlarda possupp@yapikredi.com.tr adresine haber
verilmelidir.
0302 ONL NET WRITEACKERROR Sistem hatası olduğu durumlarda bu hata verilir, alındığı
durumlarda possupp@yapikredi.com.tr adresine haber
verilmelidir.
0302 ONL NET READEOTERROR Sistem hatası olduğu durumlarda bu hata verilir, alındığı
durumlarda possupp@yapikredi.com.tr adresine haber
verilmelidir.
0302 ONL NET UNKNOWN Sistem hatası olduğu durumlarda bu hata verilir, alındığı
durumlarda possupp@yapikredi.com.tr adresine haber
verilmelidir.
0320 INVALID MERCHANT NO.
MERCHANT NO MUST BE 10
DIGIT

```
İstekte gönderilen mid alanı 10 hane olmadığında alınır,
ilgili alan 10 hane ve numeric olmalıdır.
```
0321
INVALID TERMINAL NO.
TERMINAL NO MUST BE 8 DIGIT

İstekte gönderilen tid alanı 8 haneyi geçtiğinde alınır, ilgili
alan en fazla 8 hane ve numeric olmalıdır.
0324 ODEME SERVIS SAGLAYICI VE
ALT BAYII ISLEMI BIRLIKTE
YAPILAMAZ

Ödeme servis sağlayıcı ve alt bayii işlemi aynı istekte
gönderdiğinde alınır. Ödeme servis sağlayıcı ve alt bayii
işlemi birlikte yapılamaz istek kontrol edilmelidir.
0325 ALT BAYII ISLEMINDE TCKN veya
VKN ZORUNLUDUR

Alt bayii işleminde tckn ve vkn alanları boş olduğu zaman
alınır. Alt bayii işlemlerinde bu iki alandan birisi zorunludur,
istek kontrol edilmelidir.
0327 ODEME SERVIS SAGLAYICI
BULUNAMADI

Ödeme sağlayıcı işlemlerde, gönderilen değerlere uyan bir
ödeme sağlayıcı bulunmadığı zaman alınır. Ödeme sağlayıcı
işlemde gönderilen subMrcId, mrcPfId ve mcc alanlarındaki
değerler kontrol edilmelidir, doğru oldukları düşünülüyorsa
possupp@yapikredi.com.tr adresine haber verilmelidir.
0202 GECERSIZ ISLEM TIPI Finansallaştırma isteğinde gönderilen işlem tipi sistemde
bulunmayan bir değer olduğu zaman verilir. İşlem tipi
kontrol edilmelidir.
0204 GECERSIZ DATA Finansallaştırma isteğinde gönderilen tutar alanı 0 ya da
daha küçük bir değerse bu hata alınır, istekte gönderilen
ilgili alan kontrol edilmelidir.


##### 0206 TAK.SAY. PROV TAK.SAY.BUYUK

##### OLAMAZ

Finansallaştırma isteğinde gönderilen taksit sayısı,
provizyon işleminde gönderilen taksit sayısından fazla
olduğu durumda alınır. Taksit sayısı kontrol edilmelidir.
0207 GECERSIZ PARA BIRIMI Hatalı para birimi gönderildiği durumda bu hata alınır,
istekte gönderilen ilgili alan kontrol edilmelidir.
0215 TANIMSIZ KAMPANYA KODU VftTransaction işleminde gönderilen vftCode alanı 4 haneli
olmadığı durumda bu hata alınır, ilgili alanda gönderilen
değer kontrol edilmelidir.
0218 BU SIPARIS DAHA ONCE IADE
EDILDIGI ICIN IPTAL ISLEMI
GECERSIZDIR

```
İade gönderilmiş bir işleme iptal isteği gönderdiğinde alınan
hatadır, üzerinde iade bulunan bir işlem iptal edilemez.
```
0340 BAŞLANGIÇ VE BİTİŞ TARİHİ
FARKI 10 GÜNÜ GEÇEMEZ

merchantReconciliation servisinde kullanılan startdate
veya enddate alanları arasında fark 10 günden fazla
olduğunda bu hata alınır. Requestte gönderilen ilgili alanlar
kontrol edilmelidir.
0341 BAŞLANGIÇ TARİHİ BİTİŞ
TARİHİNDEN BÜYÜK OLAMAZ

merchantReconciliation servisinde kullanılan startdate
alanı enddate alanından büyük olduğunda bu hata alınır.
Requestte gönderilen ilgili alanlar kontrol edilmelidir.
0342 ORDERID BOŞ GÖNDERİLDİ.
ORDERID'Yİ KONTROL EDİP
TEKRAR DENEYİNİZ

```
İptal isteğinde orderId alanı boş gönderildiği zaman alınır,
istekte ilgili alan kontrol edilmelidir.
```
0343 KART BILGISI YA CCNO TAGINDE
YA DA CARDINFO TAGINDE
GONDERILMELIDIR

TCKN/VKN ve kart ilk 6 son 4 hane bilgisi ile yapılan
işlemlerde hem kart bilgisi (ccno) hem de kart 6 4 bilgisi
gönderildiği zaman alınır. İstek belirtildiği şekilde kontrol
edilmelidir.
0345 GECERSIZ ISTEK
(INQUIRYVALUE BOŞ OLAMAZ)

TCKN/VKN ve kart ilk 6 son 4 hane bilgisi ile yapılan
işlemlerde inquiryValue alanı boş gönderildiğinde bu hata
alınır, istek içerisinde ilgili alan kontrol edilmelidir.
0346 HATALI FORMAT
(INQUIRYVALUE TAGI HATALI)

TCKN/VKN ve kart ilk 6 son 4 hane bilgisi ile yapılan
işlemlerde inquiryValue hatalı formatta gönderildiğinde bu
hata alınır, istek içerisinde ilgili alan kontrol edilmelidir.
0347 GECERSIZ ISTEK (CARDNOFIRST
BOŞ OLAMAZ)

TCKN/VKN ve kart ilk 6 son 4 hane bilgisi ile yapılan
işlemlerde cardNoFirst alanı boş gönderildiğinde bu hata
alınır, istek içerisinde ilgili alan kontrol edilmelidir.
0348 HATALI FORMAT
(CARDNOFIRST TAGI HATALI)

TCKN/VKN ve kart ilk 6 son 4 hane bilgisi ile yapılan
işlemlerde cardNoFirst hatalı formatta gönderildiğinde bu
hata alınır, istek içerisinde ilgili alan kontrol edilmelidir.
0349 GECERSIZ ISTEK (CARDNOLAST
BOŞ OLAMAZ)

TCKN/VKN ve kart ilk 6 son 4 hane bilgisi ile yapılan
işlemlerde cardNoLast alanı boş gönderildiğinde bu hata
alınır, istek içerisinde ilgili alan kontrol edilmelidir.
0350 HATALI FORMAT (CARDNOLAST
TAGI HATALI)

TCKN/VKN ve kart ilk 6 son 4 hane bilgisi ile yapılan
işlemlerde cardNoLast hatalı formatta gönderildiğinde bu
hata alınır, istek içerisinde ilgili alan kontrol edilmelidir.
0352 HATALI TCKN TCKN/VKN ve kart ilk 6 son 4 hane bilgisi ile yapılan
işlemlerde gönderilen TCKN değeri hatalı bir TCKN
olduğunda alınır, ilgili alanda gönderilen değer kontrol
edilmelidir.
0353 HATALI VKN TCKN/VKN ve kart ilk 6 son 4 hane bilgisi ile yapılan
işlemlerde gönderilen VKN değeri hatalı bir VKN olduğunda
alınır, ilgili alanda gönderilen değer kontrol edilmelidir.


##### 0354 POINTAMOUNT VE CARDINFO

##### BILGILERI BERABER

##### GONDERILEMEZ

```
TCKN/VKN ve kart ilk 6 son 4 hane bilgisi ile yapılan
işlemlerde puan kullanımı için kullanılan alanlar
gönderildiğinde bu hata alınır, bu işlemlerde puan kullanımı
yapılamaz.
```
## Canlı Ortama Geçiş Adımları

Test ortamında testlerinizi tamamladıktan sonra canlı ortama geçiş talebi Posnet Support
possupp@yapikredi.com.tr adresine gönderecek mail ile belirtilmelidir. Gönderilecek mail ekinde
örnek işlemler için ayırt edici (MERCHANT_ID, TERMINAL_ID, POSNET_ID, SOURCE_IP, ORDER_NO,
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

```
Key Type Description Sample Data
MERCHANT_ID String 10 haneli YKB üye işyeri numarası 6700000001
TERMINAL_ID String 8 haneli YKB üye işyeri terminal
numarası
```
##### 67000001

```
POSNET_ID String 16 haneye kadar YKB üye işyeri POSNET
numarası. 3D Secure şifreleme
işlemlerinde kullanılmaktadır.
```
##### 9644

```
XML_SERVICE_URL String Banka entegrasyon servis adresi https://posnet.yapikredi.com.tr/P
osnetWebService/XML
OOS_TDS_SERVICE
_URL
```
```
String Banka ortak ödeme ve 3D Secure sayfa
adresi
```
```
https://posnet.yapikredi.com.tr/3
DSWebService/YKBPaymentServi
ce
```
İşyeri 3D güvenli ödeme yapıyorsa veya Posnet’in sağladığı ortak ödeme sayfasını kullanıyorsa
3D Secure (3 Boyutlu Güvenlik) aktif demektir ve işyerinin müşterisi yani son kullanıcı işyeri
ekranlarından banka ekranlarına yönlendirilecek ve banka ekranlarındaki güvenlik ve doğrulama
adımlarından geçtikten sonra tekrar işyeri ekranına geri gönderilecektir. Müşterinin networkler
arasındaki geçişi güvenlik açığı yaratmaması için 3DS ödeme akışlarında MAC doğrulaması
yapılmaktadır. MAC datasının oluşturulabilmesi için işyeri yönetim ekranlarından Anahtar Yaratma
adımı takip edilerek canlı ortam için ENCKEY değeri set edilmelidir. Bu değerin Türkçe karakter ve
boşluk içermemesine dikkat edilmelidir.

## Tarihçe

```
Tarih Versiyon Açıklama Hazırlaya
n
```

19 .05.2019 2. 0 .1.0 Geliştirme ortamı (.net, java, php vs.) bazlı hazırlanmış dokümanlar
referans alınarak platform bağımsız entegrasyon dokümanı
oluşturulmuştur.
 Kredi Kartı İşlemleri
 Puan İşlemleri
 Karma İşlem
 Vade Farklı İşlemler
 Joker Vadaa’lı İşlemler
 Hata Kodları

```
Nazım
Sezer -
Sanal Pos
Uygulama
Geliştirme
```
12.06.2019 2.0.1.1 Mutabakat servisleri eklenmiştir.
 İşlem Durum Sorgulama
 Gün bazlı işlem raporu sorgulama

Nazım
Sezer -
Sanal Pos
Uygulama
Geliştirme
03.07.2019 2.0.1.2 Trio servisleri eklenmiştir. Nazım
Sezer -
Sanal Pos
Uygulama
Geliştirme
12.07.2019 2.0.1.3 Yeni nesil ödeme servisleri eklenmiştir Nazım
Sezer -
Sanal Pos
Uygulama
Geliştirme
11.10.2019 2.0.1.5 Agreement metodunun response una yeni eklenen alanlarla ilgili
olarak güncelleme yapılmıştır.

Tolga
Akgün -
Sanal Pos
Uygulama
Geliştirme
10.01.2020 2.0.1.6 TCKN/VKN ve kartın ilk 6 ve son 4 hanesi ile satış işlemine ait bilgiler
eklenmiştir.

```
Tolga
Akgün -
Sanal Pos
Uygulama
Geliştirme
```
08 .04.2020 2.0.1.7 (^)  Hata kodları bölümü güncellendi.
 TCKN/VKN ve kartın ilk 6 ve son 4 hanesi ile satış işlemine ait
bilgiler güncellendi, aşağıda belirtilenler eklendi;
o Provizyon ve provizyon finansallaştırma işlemleri
örnek request ve response bilgileri
o Taksitli satış işlemi örnek request ve response
bilgileri
o Mail order işlem örnek request ve response bilgileri
o İade ve İptal örnek senaryolar
Tolga
Akgün -
Sanal Pos
Uygulama
Geliştirme
14.12.2020 2.0.1.8 (^)  Altbayi entegrasyonuna ait tckn, vkn, subdealercode alanı
hakkındaki bilgi düzenlendi
 Posnet.ykb.com urlleri Posnet.yapikredi.com.tr olarak
güncellendi.
Enes
Köksalmış

- Sanal Pos
Uygulama
Geliştirme
05.01.2021 2.0.1.9  Karma İşlem tutar bilgileri düzeltildi
 Puan İade akışı eklendi
 Karma işlem İadesi ve İptali akışı eklendi

```
Fatih
Topçu -
Sanal Pos
```

```
 İadesi olan bir işlemin iptal edilemeyeceği konusundaki iş
kuralları eklendi.
 Eşleniksiz iade işlem bilgileri eklendi.
 Satış ve Taksitli Satış işlemlerinin Mail Order olarak
gerçekleştirilmesi akışı eklendi.
```
```
Uygulama
Geliştirme
```
06.02.2021 2.0.2.0 TCKN/VKN ve kartın ilk 6 ve son 4 hanesi ile puan sorgu ve kullanım
işlemlerine ait bilgiler eklenmiştir.

Tolga
Akgün -
Sanal Pos
Uygulama
Geliştirme
25.03.2021 2.0.2.1 Kradi Kartı ve işyeri bilgileri güncellendi Tolga
Akgün -
Sanal Pos
Uygulama
Geliştirme
15 .0 4 .2021 2 .1  Puan Sorgulama işleminde Marka Puan sorgulama
yönteminin eklenmesi
 Puan Kullanma işleminde Marka Puan kullanım yönteminin
eklenmesi
 Puan İade işleminin İptali fonksiyonunun eklenmesi.
 Karma işlemlerde Marka Puan kullandırım yönteminin
tariflenmesi.
 Karma İşlemin Oransal İadesi fonksiyonun eklenmesi.

```
Fatih
Topçu -
Sanal Pos
Uygulama
Geliştirme
```
27.08.2021 2. 1 .1.0 (^)  TDSC ifadesi TDS_ olarak değiştirildi.
 PointReturn isteğindeki <amount> tagi <wpAmount>
olarak güncellendi.
Burcu
Kaya-
Sanal Pos
Uygulama
Geliştirme
15.04.2022 2.1.1.1 (^)  İşlem Durumu Sorgulama (Agreement) Servisinden dönen
değerler güncellendi.
Bengi
Başar – E-
Ticaret ve
Ödeme
Çözümleri
Uygulama
Geliştirme
10.01.2023 2.1.1.2  Order id parametresi kapsamındaki geliştirmeler eklendi. Tuba Çinal

- E-Ticaret
ve Ödeme
Çözümleri
Uygulama
Geliştirme
24.05.2023 2.1.1.3  Order id parametresinin aktif olması durumu ile ilgili
povizyon işlemi, iade işlemi, iadenin iptali işlemi ve
mutabakat işlemine kurallar eklenmiştir.

```
Tuba Çinal
```
- E-Ticaret
ve Ödeme
Çözümleri
Uygulama
Geliştirme


