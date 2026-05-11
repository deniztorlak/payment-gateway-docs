## SANAL POS

## ENTEGRASYON DOKÜMANI

#### Versiyon 1.

#### 09 Nisan 2 012


```
Versiyon Tarih Açıklama
1.1 09 Nisan 2012 ListApprove^ sorgulama servisinde^ test
ve prod için verilen linkler değişti.
```
### INDEX

##### G iriş. .................................................................................................................................................

##### Nestpay İş A kışı........ ......................................................................................................................

##### Sanal POS API.................................................................................................................................

```
İşlem Tipleri.............................................................................................................................................
```
```
Ön
Otorizasyon...................................................................................................................................................
Satış....................................................................................................................................................................
Ön Otorizasyon Kapama.....................................................................................................................................
İptal....................................................................................................................................................................
İade – Bağımsız
İade.........................................................................................................................................
Sipariş Sorgulama Servisleri...................................................................................................................
```
##### XML API............................................................................................................................................

```
CC 5 AS XML Format...............................................................................................................................
İşlem İsteği..........................................................................................................................................................
İşlem İsteği Alanları.............................................................................................................................................
İşlem Yanıtı.........................................................................................................................................................
İşlem Yanıt Parametreleri...................................................................................................................................
İşlem Tipleri.............................................................................................................................................
```
```
Ön
Otorizasyon...................................................................................................................................................
Satış ...................................................................................................................................................................
Ön Otorizasyon
Kapama.....................................................................................................................................
İade.....................................................................................................................................................................
İptal.....................................................................................................................................................................
Sipariş Durum Sorgulama.......................................................................................................................
Sipariş Durum Sorgulama Yanıtı ........................................................................................................................
Sipariş Durum Sorgulama Parametreleri............................................................................................................
Sipariş Tarihçesini Sorgulama.................................................................................................................
Sipariş Tarihçesi Sorgulama Yanıtı ....................................................................................................................
```
```
List Approved Sorgulama Servisi............................................................................................................
List Approved Sorgulama Gönderme..................................................................................................................
Http Yanıt Özellikleri (Http Response Properties)...............................................................................................
Rapor Özellikleri (Reporting Properties).............................................................................................................
İşlemler (Transactions) .................................................................................................................................
ApprovedListing.............................................................................................................................................
Giriş (Login Information)................................................................................................................................
ListApproved Sorgulama Servisi Önemli Bilgilendirme.......................................................................................
```
##### Java Jpay API..................................................................................................................................

```
JPAY API Kurulum Gereksinimleri...........................................................................................................
```

```
JPAY API Kullanımı.............................................................................................................................................
Jpay API İsteği Setter Metotları...........................................................................................................................
Jpay API Yanıt Getters........................................................................................................................................
Sipariş Durumu Sorgulama Yanıtı.......................................................................................................................
```
##### DLL API............................................................................................................................................

###### DLL API kurulum gereksinimleri..............................................................................................................


###### DLL API Kullanımı...................................................................................................................................

```
DLL API İstek Alanları.........................................................................................................................................
DLL API Yanıt
Alanları.........................................................................................................................................
```
##### .NET API...........................................................................................................................................

```
.NET API
kurulumu.................................................................................................................................
.NET API Kullanımı.................................................................................................................................
.NET API İstek Alanları........................................................................................................................................
.NET API Yanıt Alanları.......................................................................................................................................
```
##### Tekrarlayan Ö deme ........................................................................................................................

```
Kullanımı.................................................................................................................................................
Tekrarlayan Ödeme Parametreleri..........................................................................................................
Tekrarlayan Ödeme Örnek Kodu.............................................................................................................
XML API Örneği..................................................................................................................................................
JAVA API
Örneği................................................................................................................................................. DLL API
Örneği...................................................................................................................................................
Tekrarlayan Ödeme Hata Kodları............................................................................................................
```
##### Ö rnek Senaryolar............................................................................................................................



# Giriş^

```
Dokümanda, Nestpay sanal POS API entegrasyonu, kod örnekleri ve tanımları ile
```
```
anlatılmıştır. Bu doküman, üye iş yeri entegratörlerine yardımcı olması amacı ile
```
```
oluşturulmuştur.
```
# Nestpay İş Akışı

**- Nestpay İş Akışı -**


# Sanal POS API

```
Sanal POS API ile , üye iş yerleri için sağlanan özellikler:
```
- Birincil İşlemler (Ön otorizasyon , satış)
- İkincil İşlemler (Ön Otorizasyon kapama, iptal , iade)
- Sipariş durum sorgulama
- Sipariş tarihçe sorgulama

```
Ana istek, CC 5 AS XML formatında bir XML dokümanıdır. Uygun isteğin yaratılması ve API
```
```
sunucusuna gönderilmesini sağlayan API örnekleri , farklı programlama dilleri ve
```
```
geliştirme ortamlarını destekleyecek şekilde sunulmaktadır. Desteklenen API' ler:
```
- XML API
- Java API (Jpay)
- DLL API
- .NET API


### İşlem Tipleri

#### Ön Otorizasyon

```
Kredi kartından, alış veriş tutarı kadar ön otorizasyon alınır. Kredi kartı işlemleri için,
```
```
onaylanan ön otorizasyon , üye iş yerinin hesabına aktarılmadan , açık satış
```
```
durumunda bekletilir.
```
```
Ödemenin , üye iş yeri hesabına geçebilmesi için, ön otorizasyon işleminin
```
```
kapamasının yapılması gerekmektedir.
```
#### Satış

```
Otorizasyon alma ve ön otorizasyon kapamanın tek adımda gerçekleşmesidir. Kredi
```
```
kartı işlemleri için, onaylanan otorizasyon tutarı üye iş yeri hesabına açık satış olarak
```
```
aktarılır ve alış veriş anında tamamlanır. Fazladan bir iş akışına gerek yoktur.
```
#### Ön Otorizasyon Kapama

```
Alış verişin tamamlandığının onaylanması (Sipariş içeriğinin kargoya verilmesi gibi...)
```
```
ve muhasebeleşmeye hazır hale gelmesi durumudur. Üye iş yeri hesabına aktarılacak
```
```
miktar , ön otorizasyon tutarına eşit ya da küçük olabilir.
```
#### İptal

```
Gerçekleşen bir işlemin iptali anlamına gelir. Ön otorizasyon, ön otorizasyon kapama,
```
```
satış ve iade işlem tipleri iade edilebilir.
```
```
İptal işlemi ancak gün sonu kapatılmadan önce gerçekleştirilebilir.
```
#### İade – Bağımsız İade

```
Para transferi, üye iş yeri hesabından , kart sahibinin hesabına doğru gerçekleşir. İade,
```
```
Muhasebeleşmiş bir işlem tutarının kart sahibi hesabına geri aktarılması durumunda
```
```
kullanılır. Bir ya da birden fazla parçalı iade desteklenmektedir. Yapılabilecek iade
```
```
tutarı , siparişe ait başarılı ve muhasebeleşmiş işlem tutarları toplamı ile daha önce
```
```
başarılı iade işlem tutarları toplamının farkı kadar olabilir.
```
```
İade işlemi ancak gün sonu kapatıldıktan sonra gerçekleştirilebilir.
```

### Sipariş Sorgulama Servisleri

```
Üye iş yeri – Ödeme Geçidi - Banka arasında bağlantı kaynaklı herhangi bir problem
```
```
durumunda; ödeme geçidi üye iş yerine başarılı yanıt dönemeyebilir. Bu sebeple üye iş
```
```
yerinde sisteminde işlem yanıtı oluşmaz.
```
```
Ödeme geçidinden üye iş yerine yanıt dönülemediği durumda; işlem ödeme geçidi ve
```
```
banka sistemlerinde sonuçlanmış olmasına rağmen, üye iş yeri sisteminde ya işlem hiç
```
```
oluşmaz ya da başarısız durumda kalır.
```
```
Bu tür problemler, aşağıdaki sebeplerden oluşmuş olabilir:
```
- Üye İş yeri – Ödeme Geçidi – Banka iletişim ağında bir sunucu diğerinden yanıt

```
beklerken oluşan herhangi bir gecikme, üye iş yeri sisteminde de zaman
```
```
aşımına sebep olabilir.
```
- Sunucular arası iletişim ağında oluşan bir problem.
- Üye iş yeri sunucusunda oluşan bir problem.
- EST sistemi üye iş yerine yanıt dönebildiği ve üye iş yeri de yanıtı alabildiği

```
halde, üye iş yeri dönüş mesajını doğru okuyamayabilir. Yazılım
```
```
güncellemesi, sürüm değişiklikleri ve tablo güncellemeleri gibi durumlar bu
```
```
tür problemlere sebep olabilir.
```
- Üye iş yeri sunucu veya sistemlerinde, üye iş yeri internet sunucusu harici

```
oluşan problemler.
```
- Ülke ağlarında oluşan genel bir problem.
- Ülke ağlarında yapılan bakım çalışmaları.

```
Daha büyük sorunlara sebep olmadan bu tür senkronizasyon problemlerinin çözümü,
```
```
için ödeme geçidi bazı API servisler sunmaktadır. Üye iş yerlerinin kullanımına sunulan
```
```
bu ek servisler:
```
```
Sipariş Durum Sorgulama servisi: Üye iş yerinin , siparişin başarılı sonuçlanıp
```
```
sonuçlanmadığını öğrenmek için, siparişin durumunu sorgulayabilir.
```
```
Sipariş Tarihçesi Sorgulama servisi: Üye iş yeri, siparişe ait tüm işlemlerin
```
```
listesini alabilir. Siparişe ait iade var mı, orijinal işlem ya da iade başarılı olmuş mu
```
```
gibi detayları içerir.
```

# XML API

## CC5AS XML Format

## İşlem İsteği

```
XML kök dizini CC 5 Request olan, tüm alanları tanımlanmış CC 5 AS işlem isteği içeriği:^
<CC5Request>
<Name>Kullanıcı Adı</Name>
<Password>Kullanıcı Şifresi</Password>
<ClientId>Üye İş Yeri Numarası</ClientId>
<Type>{Auth, PreAuth, PostAuth, Void, Credit}</Type>
<IPAddress>Müşterinin IP Adresi</IPAddress>
<Email>Müşterinin e-posta Adresi</Email>
<OrderId>Sipariş Numarası</OrderId>
<GroupId>Grup numarası</GroupId>
<TransId>İşlem Numarası</TransId>
<Total>Toplam Tutar</Total>
<Currency>Para birimi kodu</Currency>
<Number>Kredi Kartı Numarası</Number>
<Expires>Kredi Kartı Son Kullanam Tarihi<Expires>
<Cvv2Val>Kredi Kartının Güvenlik Numarası</Cvv2Val>
<Instalment>Taksit Adedi</Instalment>
<PayerSecurityLevel>ECI</PayerSecurityLevel>
<PayerTxnId>İnternet İşlem Numarası</PayerTxnId>
<PayerAuthenticationCode>CAVV</PayerAuthenticationCode>
<BillTo>
<Name>Faturalama yapılacak müşterinin adı</Name>
<Company>Faturalama yapılacak firma adı</Company>
<Street1>Fatura adresi 1. satır </Street1>
<Street2>Fatura adresi 2. satır </Street2>
<Street3>Fatura adresi 3. satır </Street3>
<City>Faturalanacak şehir</City>
<StateProv>Faturalanacak ilçe</StateProv>
<PostalCode>Fatura posta kodu</PostalCode>
<Country>Faturalanacak ülkenin kodu</Country>
<TelVoice>Faturalama için telefon numarası</TelVoice>
</BillTo>
<ShipTo>
<Name>Teslimat yapılacak müşterinin adı</Name>
<Company> Teslimat yapılacak firma adı</Company>
<Street1>Teslimat adresi 1. satır </Street1>
```
```
<Street2>Teslimat adresi 2. satır </Street2>
<Street3>Teslimat adresi 3. satır </Street3>
<City> Teslimat yapılacak şehir</City>
```

```
<StateProv>Teslimat yapılacak ilçe</StateProv>
<PostalCode>Teslimat posta kodu</PostalCode>
<Country>Teslimat yapılacak ülke kodu</Country>
<TelVoice>Teslimat için teslimat numarası</TelVoice>
</ShipTo>
<OrderItemList>
<OrderItem>
```
```
</CC5Request>
```
```
</OrderItem>
</OrderItemList>
```
```
<ItemNumber>Ürün Numarası</ItemNumber>
<ProductCode>Ürün Kodu</ProductCode>
<Qty>Ürün miktarı</Qty>
<Desc>ürün açıklaması</Desc>
<Id>Ürün numarası</Id>
<Price>Ürünün birim fiyatı</Price>
<Total>Toplam tutar</Total>
```
#### İşlem İsteği Alanları^

```
Parametreler Açıklama Format Zorunlu
Alan
Name Kullanıcı Adı Harf ya da rakam,
maksimum 255 karakter
```
```
Evet
```
```
Password Şifre Harf^ ya^ da^ rakam,
maksimum 255 karakter
```
```
Evet
```
```
ClientId Üye iş yeri numarası Harf^ ya^ da^ rakam,
maksimum 15 karakter
```
```
Evet
```
```
Type İşlem Tipi Harf ya da rakam,
olabilecek değerler {Auth,
PreAuth, PostAuth, Void,
Credit}
```
```
Evet
```
```
IPAddress Müşterinin IP Adresi maksimum 39 karakter Hayır
OrderId Sipariş Numarası Harf ya da rakam,
maksimum 64 karakter
GroupId Grup Numarası Harf ya da rakam,
maksimum 64 karakter
```
```
Hayır
```
```
TransId İşlem Numarası Harf ya da rakam,
maksimum 64 karakter
```
```
Total Toplam Tutar Rakam,
ondalıklı rakamları
ayırmak için “,” veya “.”
kullanılır.
Karakter kullanılmaz.
```
```
Currency ISO para birimi kodu Rakam, 3 rakam (949 for
TL)
```
###### ÜYE İŞ YERİ ENTEGRASYON DOKÜMANI

```
UserId Kullanıcı adı Rakam, maksimum 64 Hayır
```

rakam^

```
Number Kredi Kart Numarası Harf ya da rakam +
sembol
Cvv 2 Val Güvenlik numarası değeri Rakam, 3 rakam
```
```
Expires Kredi Kartı Son Kullanma
Tarihi
```
```
MM/YYYY
```
```
Instalment (Taksit)
```
```
Taksitsiz işlemlerde taksit
parameteresi boş olarak
gönderilmelidir
Rakam
Hayır
PayerSecurityLevel ECI Rakam, 2 rakam
PayerTxnId İnternet İşlem Numarası Harf ya da rakam +
sembol, 28 karakter,
base 64 - encoded
```
```
PayerAuthenticationCode CAVV Harf ya da rakam +
sembol, 28 karakter,,
base 64 - encoded
BillTo.Name Müşteri Fatura Adresi Maksimum 255 karakter Hayır
BillTo.Company Faturalanacak şirket ismi Maksimum 255 karakter Hayır
BillTo.Street 1 Fatura adres satırı 1 Maksimum 255 karakter Hayır
BillTo.Street 2 Fatura adres satırı 2 Maksimum 255 karakter Hayır
BillTo.Street 3 Fatura adres satırı 3 Maksimum 255 karakter Hayır
BillTo.City Faturanın gönderileceği
Şehir
```
```
Maksimum 64 karakter Hayır
```
```
BillTo.StateProv Faturanın gönderileceği ilçe Maksimum 32 karakter Hayır
BillTo.PostalCode Faturanın gönderileceği
posta kodu
```
```
Maksimum 32 karakter Hayır
```
```
BillTo.Country Faturanın gönderileceği ülke Maksimum 3 karakter Hayır
BillTo.TelVoice Fatura telefon numarası Maksimum 32 karakter Hayır
ShipTo.Name Müşteri teslimat adresi Maksimum 255 karakter Hayır
ShipTo.Company Teslimatın yapılacağı Şirket Maksimum 255 karakter Hayır
ShipTo.Street 1 Teslimat Adres Satırı 1 Maksimum 255 karakter Hayır
ShipTo.Street 2 Teslimat Adres Satırı 2 Maksimum 255 karakter Hayır
ShipTo.Street 3 Teslimat Adres Satırı 3 Maksimum 255 karakter Hayır
ShipTo.City Teslimat yapılacak Şehir Maksimum 64 karakter Hayır
ShipTo.StateProv Teslimat yapılacak ilçe Maksimum 32 karakter Hayır
ShipTo.PostalCode Teslimat yapılacak yerin
posta kodu
```
```
Maksimum 32 karakter Hayır
```
```
ShipTo.Country Teslimat yapılacak ülke Maksimum 3 karakter Hayır
ShipTo.TelVoice Teslimat yapılacak telefon
numarası
```
```
Maksimum 32 karakter Hayır
```
```
OrderItem.id Ürün ID Maksimum 128 karakter Hayır
OrderItem.itemnumber Ürün numarası Maksimum 128 karakter Hayır
OrderItem.productcode Ürün kodu Maksimum 64 karakter Hayır
OrderItem.qty Ürün Adedi Maksimum 32 karakter Hayır
```
```
OrderItem.desc Açıklama Maksimum 128 karakter Hayır
OrderItem.price Fiyat Maksimum 32 karakter Hayır
```

```
Bir alan , Zorunlu Alan=Evet olarak işaretlenmişse, her bir işlem isteğinde
```
```
doldurulmalıdır.
```
```
Bir alan, Zorunlu Alan=Hayır olarak işaretlenmişse, işlem isteklerinde , doldurulması
```
```
isteğe bağlı demektir.
```
```
Diğer alanların doldurulması , işlem tipine bağlıdır. İşlem tipine bağlı olarak belirlenen
```
```
istek örneklerine bakınız.
```
```
API isteklerinde , üye iş yeri yöneticisi tarafından yaratılan “ API kullanıcısı ” rolü
```
```
ile yaratılan kullanıcı bilgileri kullanılmalıdır. Diğer rollerde yaratılan kullanıcılarla
```
```
oluşturulan işlem isteklerinde problem oluşabilir:
```
- API kullanıcısının şifresi zaman aşımına uğramaz. Her zaman günceldir.
- Diğer rollerdeki kullanıcıların şifreleri, her 3 ayda bir kullanım süresi

```
dolar. Yönetim ekranlarından değiştirilmesi gerekir.
```
- Yenileme süreleri takip edilip değiştirilmezse, işlem istekleri süresi

```
dolmuş şifrelerle yapılacağından , işlemler hatalı sonuçlanır.
```
#### İşlem Yanıtı

```
XML kök dizini CC 5 Response olan , tüm alanları tanımlanmış CC 5 AS işlem cevabı
```
```
içeriği:
```
```
<CC5Request>
```
```
</CC5Request>
```
```
<OrderId>Sipariş Numarası</OrderId>
<GroupId>Grup Numarası</GroupId>
<Response>{Approved, Declined, Error}</Response>
<AuthCode>Otorizasyon Numarası</AuthCode>
<HostRefNum>Banka Referans Kodu</HostRefNum>
<ProcReturnCode>İşlem Durum Kodu</ProcReturnCode>
<TransId>İşlem Numarası</TransId>
<ErrMsg>Hata Mesajı</ErrMsg>
<Extra>
<SETTLEID>Gün sonu numarası</SETTLEID>
<TRXDATE>İşlem Tarihi</TRXDATE>
<ERRORCODE>Hata Kodu</ERRORCODE>
<HOSTMSG>Banka Mesajı</HOSTMSG>
<NUMCODE>Nümerik hata kodu</NUMCODE>
</Extra>
```

#### İşlem Yanıt Parametreleri^

```
Parametreler Açıklama Format
```
OrderId Sipariş Numarası Harf ve rakam, maksimum 64 karakter

GroupId Grup numarası Harf ve rakam, maksimum 64 karakter

Response İşlem geri dönüş Olası değerler:
Başarılı işlem için “Approved” ,
Başarısız işlem için “Declined”
Ödeme geçidi hataları için “Error”

AuthCode Banka onay kodu Harf ve rakam, 6 karakter

HostRefNum Banka referans numarası Harf ve rakam,12 karakter

ProcReturnCode İşlem durum kodu Rakam, 2 basamak,
“ 0 0” for onaylı işlem,
“ 9 9” for ödeme geçidi hataları,
diğerleri için ISO- 858 3 hata kodları

TransId İşlem Numarası Harf ve rakam, maksimum 64 karakter

ErrMsg Hata Mesajı Harf ve rakam, maksimum 255 karakter

Extra.SETTLEID Günsonu numarası Rakam, 3 basamak

Extra.TRXDATE İşlem Tarihi “yyyyMMdd HH:mm:ss”

Extra.ERRORCODE Hata Mesajı Harf ve rakam, maksimum 16 karakter

Extra.HOSTMSG Kredi Kart numarası Harf ve rakam, maksimum 255 karakter

Extra.NUMCODE Nümerik hata kodu Rakam, maksimum 20 rakam


### İşlem Tipleri

#### Ön Otorizasyon

```
Ön otorizasyon yapmak için, "Type" alanı “ PreAuth ” ataması yapılır. Eğer "OrderId" alanı
```
```
doldurulmazsa , sistem otomatik "OrderId" üretir ve yanıt mesajında geri dönülür.
```
```
Örnek XML İsteği :
```
```
<CC5Request>
<Name>KullanıcıAdı</Name>
<Password>TEST1234</Password>
<ClientId>990000001</ClientId>
<Type>PreAuth</Type>
<Total>10.15</Total>
<Currency>949</Currency>
<Number>4242424242424242</Number>
<Expires>10/2028</Expires>
<Cvv2Val>123</Cvv2Val>
</CC5Request>
```
```
Not: 3 D güvenli otorizasyon durumunda “Expires” ve “Cvv 2 Val” alanları doldurulmaz, “
```
```
PayerAuthenticationCode, PayerTxnId, PayerSecurityLevel” alanları doldurulur. İlgili Ödeme
```
```
Model dokümanında, değerlerin nasıl doldurulması gerektiği detaylı anlatılmıştı.
```

#### Satış

```
Satış işlemi yapmak için, “Type” alanına “ Auth ” ataması yapılır. Eğer OrderId alanı
```
```
doldurulmazsa , sistem otomatik OrderId üretir ve yanıt mesajında geri dönülür.
```
**Örnek XML İsteği :**^

```
<CC5Request>
```
```
</CC5Request>
```
```
<Name>KullanıcıAdı</Name>
<Password>TEST1234</Password>
<ClientId>990000001</ClientId>
<Type>Auth</Type>
<Total>10.15</Total>
<Currency>949</Currency>
<Number>4242424242424242</Number>
<Expires>10/2028</Expires>
<Cvv2Val>123</Cvv2Val>
```
```
Not: 3 D güvenli otorizasyon durumunda “Expires” ve “Cvv 2 Val” alanları doldurulmaz, “
```
```
PayerAuthenticationCode, PayerTxnId, PayerSecurityLevel” alanları doldurulur. İlgili Ödeme
```
```
Model dokümanında, değerlerin nasıl doldurulması gerektiği detaylı anlatılmıştı.
```
#### Ön Otorizasyon Kapama

```
Ön otorizasyon kapama yapmak için, “Type” alanına “ PostAuth ” ataması yapılır.
```
```
“OrderId ” alanı, kapaması yapılacak ön otorizasyon işleminin OrderId değeri ile
```
```
doldurulmalıdır. Parçalı ön otorizasyon kapama desteklenmektedir: Ön otorizasyon
```
```
kapama tutarı, ön otorizasyon tutarına eşit ya da küçük olabilir. Kısmi Ön otorizasyon
```
```
kapama yapmak için, “Total” alanı, o işlemle gerçekleştirilecek ön otorizasyon kapama
```
```
tutarı ile doldurulur.
```
```
Örnek XML İsteği :
```
```
<CC5Request>
<Name>KullanıcıAdı</Name>
<Password>TEST1234</Password>
<ClientId>990000001</ClientId>
<Type>PostAuth</Type>
<OrderId>ORDER12345</OrderId>
</CC5Request>
```

#### İade

```
İade işlemi yapmak için, “Type” alanına “ Credit ” ataması yapılır.
```
```
“OrderId” alanı, iadesi yapılacak işlemin OrderId değeri ile doldurulmalıdır.
```
```
Bir ya da birden fazla parçalı iade desteklenmektedir: Toplam tutar, orijinal satış
```
```
işleminin tutarını geçmemek kaydı ile istenilen sayıda iade gerçekleştirilebilir.
```
```
Örnek XML İsteği :
```
```
<CC5Request>
```
```
</CC5Request>
```
```
<Name>KullanıcıAdı</Name>
<Password>TEST1234</Password>
<ClientId>990000001</ClientId>
<Type>Credit</Type>
<OrderId>ORDER12345</OrderId>
```
```
Kısmi İade yapmak için, “Total” alanı, o işlemle gerçekleştirilecek iade tutarı ile
doldurulur.
```
#### İptal

```
İptal işlemi yapmak için, “Type” alanına “Void” ataması yapılır.
```
```
İadesi yapılacak orijinal işlemin OrderId ya da TransId doldurulmalıdır.
```
```
Eğer TransId doldurulmuşsa, TransId ile eşleşen işlem iptal edilir.
```
```
Eğer OrderId doldurulmuşsa, bu OrderId ile eşleşen başarılı işlem belirlenir ve iptal
```
```
edilir. Eğer OrderId ile birden fazla başarılı işlem varsa (çoklu iade gibi), sistem hata
```
```
döner.
```
```
Örnek XML İsteği :^
<CC5Request>
```
```
</CC5Request>
```
```
<Name>KullanıcıAdı</Name>
<Password>TEST1234</Password>
<ClientId>990000001</ClientId>
<Type>Void</Type>
<OrderId>ORDER12345</OrderId>
```

### Sipariş Durum Sorgulama

##### Tekrarlayan Olmayan Sipariş İçin Sorgulama

```
Sipariş Durum Sorgulama, satış, iade, iptal, ön otorizasyon, ön otorizasyon
```
```
kapama, bağımsız iade işlem tipleri için yapılabilir. Ödeme geçidi ve banka
```
```
sisteminde hiç bir şeyi değiştirmez. Finansal bir anlamı yoktur. Siparişin durumunu
```
```
döner.
```
```
Siparişin birden fazla işlemi olabilir. Bu sebeple, sorgulama sonucundaki
```
```
“OrderStatus” alanında siparişe ait son başarılı işlemin durumu yer alır. Eğer
```
```
siparişe ait hiç başarılı işlem yoksa, “OrderStatus” alanındaki değer, siparişe ait
```
```
son başarısız işlemin durumunu gösterir.
```
```
Sipariş durum sorgulama işlem tipi için XML de Extra.ORDERSATUS
```
```
etiketi oluşturulmalıdır.
```
```
<Extra>
<ORDERSTATUS>QUERY</ORDERSTATUS>
</Extra>
```
```
Örnek XML İsteği :
```
```
<CC5Request>
<Name>KullanıcıAdı</Name>
<Password>TEST1234</Password>
<ClientId>990000001</ClientId>
<OrderId>ORDER12345</OrderId>
<Extra>
<ORDERSTATUS>QUERY</ORDERSTATUS>
</Extra>
</CC5Request>
```

###### ÜYE İŞ YERİ ENTEGRASYON DOKÜMANI

**Sipariş Durum Sorgulama Yanıtı**

##### Sipariş Durum Sorgulama yanıtında , kök dizin CC5Response olacak şekilde aşağıdaki

##### XML elemanları yer alır. Sipariş sorgu yanıtında değerleri 2 şekilde yer alabilir:

- Sorgu yanıtındaki Extra.ORDERSATUS etiketi altında, alan adı:alan

```
değeri ikilileri tab ayracı ile birleştirilmiş şekilde yer alır
```
- Extra altında ayrı etiketlerle :

```
<CC5Response>
<ErrMsg>Hata mesajı</ErrMsg> <ProcReturnCode>İşlem
durum kodu</ProcReturnCode> <Response>{Approved,
Error}</Response> <OrderId>Sipariş
numarası</OrderId> <TransId>İşlem
numarası</TransId>
<Extra>
<AUTH_DTTM>Ön otorizasyon tarihi</AUTH_DTTM>
<HOSTDATE>Banka onay tarihi</HOSTDATE>
<TRANS_STAT>İşlem durumu</TRANS_STAT>
<ORDERSTATUS>ORD_ID:OrderId CHARGE_TYPE_CD:TransactionTtype
ORIG_TRANS_AMT:FirstAmount CAPTURE_AMT:TransactionAmount
TRANS_STAT:TransactionStatus AUTH_DTTM:AuthorizationTime
CAPTURE_DTTM:DepositTime AUTH_CODE:
TRANS_ID:TransactionId
</ORDERSTATUS>
<ORIG_TRANS_AMT>İlk tutar</ORIG_TRANS_AMT>
<PROC_RET_CD>Banka onay kodu</PROC_RET_CD>
<CAPTURE_AMT>işlem tutarı</CAPTURE_AMT>
<HOST_REF_NUM>Banka referans numarası</HOST_REF_NUM>
<SETTLEID>Gün sonu numarası</SETTLEID>
<TRANS_ID>işlem numarası</TRANS_ID>
<ORD_ID>Sipariş numarası</ORD_ID>
<CHARGE_TYPE_CD>İşlem Tipi</CHARGE_TYPE_CD>
<AUTH_CODE>Banka onay kodu</AUTH_CODE>
<NUMCODE>Nümerik hata kodu</NUMCODE>
<CAPTURE_DTTM>Ön otorizasyon kapama tarihi</CAPTURE_DTTM>
</Extra>
</CC5Response>
```

###### ÜYE İŞ YERİ ENTEGRASYON DOKÜMANI

##### Tekrarlayan Olan Sipariş İçin Sorgulama

```
Sipariş durum sorgulama işlem tipi için XML de Extra.ORDERSATUS &
```
```
Extra.RECURRINGID etiketi oluşturulmalıdır.
```
```
<Extra>
<ORDERSTATUS>QUERY</ORDERSTATUS>
<RECURRINGID>15210MWwD180004</RECURRINGID>
</Extra>
```
```
Örnek XML İsteği :
```
<CC5Request>
<Name>Erdem</Name>
<Password>***</Password>
<ClientId>700655008993</ClientId>
<Extra>
<RECURRINGID>15210MWwD180004</RECURRINGID>
<ORDERSTATUS>QUERY</ORDERSTATUS>
</Extra>
</CC5Request>

```
Sipariş Durum Sorgulama Yanıtı
```
###### Tekrarlayan Siparişleri için aşağıdaki iki duruma göre yanıt farklılaşmaktadır.

###### 1) Siparişin işlenmesi Gereken Tarihi n gelmesi ve işlenmiş olma durumu

###### 2) Siparişin işlenme tarihinin gelmemiş olması, hata alması veya iptal edilmiş olması

###### durumu

###### Tekrarlayan Sipariş Durum Sorgulama Yanıtlarında, Tekrarlayan işleme ait birden fazla

###### Sipariş olması mümkün olduu için, hangi değerin hangi tekrarlayan işleme ait olduğunu

###### belirtmek amacıyla altçizgi & tekrarlayan işlem sırası belirteç olarak kullanılmaktadır.

###### Örneğin, cevap’taki XML tag’in “<TRANS_STAT_2>PN</TRANS_STAT_2>” şeklinde olması

###### durumunda “_2” tag belirteci, ilgili değeri n ikinci Tekrarlayan Siparişe ait olduğunu

###### göstermektedir.

###### <?xml version="1.0" encoding="ISO- 8859 - 9"?>

<CC5Response>
<ErrMsg>Record(s) found for 15210MWwD180004</ErrMsg>
<Extra>

<RECURRINGCOUNT>2</RECURRINGCOUNT>
<RECURRINGID>15210MWwD180004</RECURRINGID>


<ORIG_TRANS_AMT_1>1001</ORIG_TRANS_AMT_1>
<CHARGE_TYPE_CD_1>S</CHARGE_TYPE_CD_1>
<ORDERSTATUS_1>ORD_ID:ORDER-15210MWwD180003 CHARGE_TYPE_CD:S
ORIG_TRANS_AMT:1001 TRANS_STAT:PN PLANNED_START_DTTM:2016- 03 - 27
05:00:00.0</ORDERSTATUS_1>
<ORD_ID_1>ORDER-15210MWwD180003</ORD_ID_1>
<TRANS_STAT_1>PN</TRANS_STAT_1>
<PAN_1>4242 42** **** 4242</PAN_1>
<PLANNED_START_DTTM_1>2016- 03 - 27 05:00:00.0</PLANNED_START_DTTM_1>

<CAPTURE_AMT_2>1001</CAPTURE_AMT_2>
<CAPTURE_DTTM_2>2015- 07 - 29 15:31:00.78</CAPTURE_DTTM_2>
<AUTH_DTTM_2>2015- 07 - 29 15:31:00.78</AUTH_DTTM_2>
<ORIG_TRANS_AMT_2>1001</ORIG_TRANS_AMT_2>
<MDSTATUS_2></MDSTATUS_2>
<TRANS_ID_2>15210MfAA180146</TRANS_ID_2>
<PROC_RET_CD_2>00</PROC_RET_CD_2>
<ECI_3D_2></ECI_3D_2>
<HOST_REF_NUM_2>521000000043</HOST_REF_NUM_2>
<CHARGE_TYPE_CD_2>S</CHARGE_TYPE_CD_2>
<ORDERSTATUS_2>ORD_ID:ORDER-15210MWwD180003- 2 CHARGE_TYPE_CD:S
ORIG_TRANS_AMT:1001 CAPTURE_AMT:1001 TRANS_STAT:C AUTH_DTTM:2015- 07 - 29
15:31:00.78 CAPTURE_DTTM:2015- 07 - 29 15:31:00.78 AUTH_CODE:P53293
TRANS_ID:15210MfAA180146</ORDERSTATUS_2>
<PAN_2>4242 42** **** 4242</PAN_2>
<TRANS_STAT_2>C</TRANS_STAT_2>
<AUTH_CODE_2>P53293</AUTH_CODE_2>
<CAVV_3D_2></CAVV_3D_2>
<SETTLEID_2></SETTLEID_2>
<XID_3D_2></XID_3D_2>
<ORD_ID_2>ORDER-15210MWwD180003-2</ORD_ID_2>
<HOSTDATE_2>0729-123100</HOSTDATE_2>

<NUMCODE>0</NUMCODE>
</Extra>
</CC5Response>


#### Sipariş Durum Sorgulama Parametreleri^

**Sipariş Durumu Tag Açıklama Format**
ORD_ID Sipariş numarası Rakam ve harf, en fazla 64 karakter

CHARGE_TYPE_CD İşlem tipi S: Auth/PreAuth/PostAuth
C: Refund

ORIG_TRANS_AMT Ön otorizasyon tutarı Ondalık ayırıcı olmadan, hassas, en küçük birimi
para dayanmaktadır

CAPTURE_AMT Ön otorizasyon Ondalık ayırıcı olmadan, hassas, en küçük birimi
kapama tutarı para dayanmaktadır

TRANS_STAT İşlem Durumu D : Başarısız işlem
A : Otorizasyon, gün sonu kapanmadan^
C : Ön otorizasyon kapama, gün sonu kapanmadan
PN : Bekleyen İşlem
CNCL : İptal Edilmiş İşlem
ERR : Hata Almış İşlem
S : Satış^
R : Teknik İptal gerekiyor
V : İptal

AUTH_DTTM Ön otorizasyon tarihi “yyyy-MM-dd HH:mm:ss.S”

CAPTURE_DTTM Ön otorizasyon “yyyy-MM-dd HH:mm:ss.S”
kapama tarihi

AUTH_CODE banka onay kodu Harf ya da rakam, 6 karakter

HOST_REF_NUM Banka referans Harf ya da rakam, 12 karakter
numarası

PROC_RET_CD İşlem durum kodu Rakam, 2 rakam,
“ 0 0” onay alan işlem
“ 9 9” ödeme geçidi hataları için,
ISO- 85 83 diğer hata kodları

TRANS_ID İşlem numarası Harf ya da rakam, maksimum 64 karakter

SETTLEID gün sonu numarası Rakam

RECURRINGCOUNT Tekrarlayan İşlem Sayısı Rakam

RECURRINGID Tekrarlayan İşlem Numarası Harf ya da rakam, maksimum 64 karakter

PLANNED_START_DTTM İşlem Planlanan Başlangıç Zamanı “yyyy-MM-dd HH:mm:ss.S”

```
Sipariş durum sorgulama hata almazsa, ErrMsg etiketi aşağıdaki formattaki metni
```
```
içerir:
```
```
<ErrMsg>Record(s) found for OrderId</ErrMsg>
```

###### ÜYE İŞ YERİ ENTEGRASYON DOKÜMANI

### Sipariş Tarihçesini Sorgulama

```
Üye iş yeri siparişe ait işlemlerin durumlarını sorgulayabilir. Siparişe ait bir iade var mı?
```
```
Sipariş ya da iadesi başarılı mı? Gibi...
```
```
Sipariş tarihçesi sorgulama işlem tipi Extra.ORDERHISTORY etiketi ile ayrıştırılır.
```
```
<Extra>
```
```
<ORDERHISTORY>QUERY</ORDERHISTORY>
</Extra>
```
```
Örnek XML isteği :
```
```
<CC5Request>
<Name>KullanıcıAdı</Name>
<Password>TEST1234</Password>
<ClientId>990000001</ClientId>
<OrderId>ORDER12345</OrderId>
<Extra>
<ORDERHISTORY>QUERY</ORDERHISTORY>
</Extra>
</CC5Request>
```


#### Sipariş Tarihçesi Sorgulama Yanıtı

```
Sipariş tarihçesi Sorgulama yanıtında , kök dizin CC 5 Response olacak şekilde
aşağıdaki XML elemanları yer alır. Sorgu sonucunda, işlemler Extra etiketi altında ,
işlem sıra bilgisi "y" değerini içeren "TRXy" etiketleri ile yer alır.
```
```
<CC5Response>
<ErrMsg>Error message</ErrMsg>
<ProcReturnCode>İşlem durum kodu</ProcReturnCode>
<Response>{Approved, Error}</Response>
<OrderId>Sipariş numarası</OrderId>
<Extra>
<TRX1>tab-separeted transaction line of first trx</TRX1>
<TRXCOUNT>Transaction count</TRXCOUNT> <TRX2>tab-
separeted transaction line of second trx</TRX2>
<TRXn>tab-separeted transaction line of n-th trx</TRX2>
<NUMCODE>0</NUMCODE>
</Extra>
</CC5Response>
```
```
"TRXy" etiketli bilgi, tab ayracı ile birleştirilmiş, işlem detaylarını ifade eder. Detay
```
```
alanlar aşağıdaki formattadır. Bu alanların tanımlamalarına , sipariş durum
```
```
sorgulamada değinilmiştir.
```
###### CHARGE_TYPE_CD + TRANS_STAT + ORIG_TRANS_AMT +

###### CAPTURE_AMT+AUTH_DTTM + CAPTURE_DTTM VOID_DTTM + HOST_REF_NUM

###### + AUTH_CODE + PROC_RET_CD + TRANS_ID + SETTLEID


# Payment Facilitator Kullanım Detayları

```
Payment Facilitator kullanımı için satış ve ön otorizasyon işlemlerinde api
kullanımında aşağıdaki gibi alt üye işyeri extralarının eklenmesi gerekmektedir.
```
```
<Extra>
<SUBMERCHANTNAME>SubMerchant_Name</SUBMERCHANTNAME>
<SUBMERCHANTID> 1195 </SUBMERCHANTID>
<SUBMERCHANTPOSTALCODE> 5911 </SUBMERCHANTPOSTALCODE>
<SUBMERCHANTCITY>ISTANBUL</SUBMERCHANTCITY>
<SUBMERCHANTCOUNTRY> 123 </SUBMERCHANTCOUNTRY>
</Extra>
XML isteğine gelen yanıtta ise alt üye işyeri özelinde bir bilgi dönmeyecek, standard
yanıt dönecektir.
```
## Kullanımı

```
Örnek
XML
İsteği:
```
```
<?xml version="1.0" encoding="UTF-8"?>
<CC5Request>
<Name>xxx</Name>
<Password>xxx</Password>
<ClientId>xxx</ClientId>
<OrderId />
<GroupId />
<Mode>P</Mode>
<Type>Auth</Type>
<Number> 4111111111111111 </Number>
<Expires>10.2025</Expires>
<Cvv2Val> 000 </Cvv2Val>
<Total> 100 </Total>
<Currency> 949 </Currency>
<Extra>
<SUBMERCHANTNAME>SubMerchant_Name</SUBMERCHANTNAME>
<SUBMERCHANTID> 1195 </SUBMERCHANTID>
<SUBMERCHANTPOSTALCODE> 5911 </SUBMERCHANTPOSTALCODE>
<SUBMERCHANTCITY>ISTANBUL</SUBMERCHANTCITY>
<SUBMERCHANTCOUNTRY> 123 </SUBMERCHANTCOUNTRY>
</Extra>
</CC5Request>
```

### List Approved Sorgulama Servisi

```
Birden fazla siparişin durumunu saat / tarih aralığı verilerek sorgulanmasını sağlayan
```
```
servistir. Test ortamında Api'den yapılan sorgulama sonucunda,
```
```
( Örnek: https://testsanalpos.est.com.tr/ bankaismi /report/user.login ) testsanalpos
```
```
url sayfasına yanıt döner. Prod ortamında ise, bankanın prod url 'ine yanıt döner.
```
#### List Approved Sorgulama Gönderme

```
İlgili alanlar doldurularak sorgulama yapılır.
```

#### Http Yanıt Özellikleri (Http Response Properties)

```
Bu alanda; Http yanıt özellikleri, yazı karakter seti (charset), metnin içerik tipi (content
```
```
type) ve Http başlık (Http header) seçenekleri ile özelleştirilebilir.
```
```
Bazı özelliklerini xml, txt, xls formatlarında rapor olarak almak için örnekler:
```
```
Content type: text/xml,
HTTP Header (0): Content-Disposition: attachment;
filename=my_report.xml
```
```
Content type: text/plain,
HTTP Header (0): Content-Disposition: attachment;
```
```
filename=report.txt
```
```
Content type: application/vnd.ms-excel,
HTTP Header (0): Content-Disposition: attachment;
filename=this_week.xls
```
#### Rapor Özellikleri (Reporting Properties)

```
Bu alanda; Raporun ismi, formatı ve eklenebilir parametreler içerir. Ek parametreler
```
```
gönderimleri her rapor için farklıdır.
```
###### İşlemler (Transactions)

```
Detaylı işlem listeleme ve alınan servislerin raporlanmasını sağlar. Bu raporlama servisi
```
```
için ek parametreler belirtilmeli. Raporlama servisi mantıksal kombinasyonlar ile
```
```
birlikte kullanılabilir.
```
```
Ek parametre örnekleri:
```
```
tranUid:09142-PlwE- 1 - 0016
```
```
orderId:ORDER- 09142 - PuqA- 1 - 0011
```
```
tranTsGreaterThan: 2009 - 01 - 01 00:01:00,tranTsLessThan:2009- 07 - 01
00:01:00
```
```
batchStatus:OK
```
```
batchStatus:OK|FC|ER|BU|RE
```
```
tranType:SALE
```
```
tranType:SALE|PRE|POST|CRED|RFND
```
```
tranStatus:OK
```
```
tranStatus:FC|OK|NO|RE|VD|PN
```
```
dimBatchId:115
```

```
dimBatchId:115|116|117|118
```
```
tranType:SALE,tranStatus:OK,batchStatus:OK,tranTsGreaterThan:2009
```
- 01 - 01 00:01:00

```
tranStatus:OK,batchStatus:OK,dimBatchId:115
```
###### ApprovedListing

```
Legal tip (CC 5 ) işlemi / sipariş detaylama servisidir. Önerilmemektedir.
```
```
Ek parametre örnekleri:
```
```
date_start:2009- 01 - 01 00:01:00,date_end:2009- 07 - 01 23:59:59
```
```
date_start:2009- 01 - 01 00:01:00
```
###### Giriş (Login Information)

```
Onaylanan ve doğrulanan bilgilerdir. Kullanıcı yanıt raporları alabilmek için HPR
```
```
raporlama servisi izinlerine sahip olmalıdır.
```
#### ListApproved Sorgulama Servisi Önemli Bilgilendirme

```
ListApproved sorgulama servisinde, mevcut Sanal POS rapor ekranlarında olduğu
```
```
gibi 45 günlük veriye ulaşılabilmektedir.
```
```
Aynı üye iş yerinden iki farklı browser (internet sağlayıcı) açılarak, yine aynı anda 2
```
```
rapor birden alınamaz.
```

# Java Jpay API

```
JPAY, Sanal Pos işleyişini, farklı ortamlar için gerçekleyen JAVA API 'dir.
```
## JPAY API Kurulum Gereksinimleri

```
İşletim sisteminde JDK 1. 3 ya da yüksek bir daha sürüm kurulumu olması
gerekmektedir. Ödeme geçidimiz tarafından sağlanan " jpay.jar " dosyasının yer alacağı
dizin bilgisi, sunucunuzun “ class-path ” tanımlarına eklenmelidir.
```
## JPAY API Kullanımı

###### 1. Setter metotlarını kullanarak gerekli alanları doldur

###### 2. processTransaction fonksiyonunu çağır

###### 3. Getter metotlarını kullanarak sonuç alanlarını al

```
Örnek Kullanım: Sadece zorunlu alanları doldurarak satış işlemi yap:
```
```
jpay myjpay = new jpay();
myjpay.setName(“apiuser”);
myjpay.setPassword(“apipassword”);
myjpay.setClientId(“990000000000001”);
myjpay.setOrderId(“ORDER123”);
myjpay.setType(“Auth”);
myjpay.setTotal("10.5");
myjpay.setCurrency("949");
myjpay.setNumber( “4242424242424242” );
myjpay.setCvv2Val("000");
myjpay.setExpires("10/2028");
if (myjpay.processTransaction("host", 443 ,"/fim/api") > 0){
```
###### / Transaction

```
successful } else {
System. out .println(myjpay.getErrMsg());
}
```

#### Jpay API İsteği Setter Metotları^

```
Jpay setter Açıklama Format Zorunlu
setName Kullanıcı adı Harf ya da rakam, maksimum Evet
255 karakter
setPassword Şifre Harf ya da rakam, maksimum Evet
255 karakter
setClientId Üye iş yeri numarası Harf ya da rakam, maksimum Evet
15 karakters
setType İştem tipi Harf ya da rakam, kabul edilen Evet
değerler: {Auth, PreAuth,
PostAuth, Void, Credit}
```
```
setIPAddress Müşterinin IP numarası Maksimum 39 karakter Hayır
```
```
setOrderId Sipariş Numarası Harf ya da rakam, maksimum
64 karakter^
setGroupId Grup Numarası Harf ya da rakam, maksimum Hayır
64 karakter
setTransId İşlem numarası Harf ya da rakam, maksimum
64 karakter^
```
```
setTotal Toplam tutar Rakam,
ondalık rakamlar “,” veya “.” ile
ayrılır.
Karakter kullanılmaz.^
```
```
setCurrency ISO para birimi kodu Rakam, 3 rakam (949 for TR)
```
```
setUserId raporlama için Kullanıcı Rakam, maksimum 64 rakam Hayır
adı
```
```
setNumber Kredi Kartı Numarası Harf ya da rakam + sembol
```
```
setCvv 2 Val Kredi Kartı güvenlik Rakam, 3 rakam
numarası
```
```
setExpires Kartın son kullanma MM/YYYY
tarihi
setTaksit Taksit miktarı Rakam Hayır
```
```
setPayerSecurityLevel ECI Rakam, 2 rakam
```
```
setPayerTxnId internet işlem numarası Harf ya da rakam + sembol, 28
karakter, base 64 - encoded
```
```
setPayerAuthenticationC CAVV Harf ya da rakam + sembol, 28
ode karakter, base 64 - encoded
setBName Faturalama yapılacak Maksimum 255 karakter Hayır
müşteri adı
```
```
setBCompany Faturalanacak şirket Maksimum 255 karakter Hayır
setBStreet 1 Fatura 1. adres satırı Maksimum 255 karakter Hayır
setBStreet 2 Fatura 2. adres satırı Maksimum 255 karakter Hayır
setBStreet 3 Fatura 3. adres satırı Maksimum 255 karakter Hayır
setBCity Faturalama yapılacak Maksimum 64 karakter Hayır
şehir
setBStateProv Faturalama yapılacak Maksimum 32 karakter Hayır
ilçe
```
###### ÜYE İŞ YERİ ENTEGRASYON DOKÜMANI

```
setBPostalCode Faturalama yapılacak Maksimum 32 karakter Hayır
posta kodu
```

setBCountry Faturalama yapılacak Maksimum 3 karakter Hayır
ülke kodu

setBTelVoice Faturalama yapılacak Maksimum 32 karakter Hayır
telefon numarası

setSName Teslimat yapılacak Maksimum 255 karakter Hayır
müşteri adı

setSCompany Teslimat yapılacak firma Maksimum 255 karakter Hayır
adı

setSStreet 1 Teslimat 1. adres satırı Maksimum 255 karakter Hayır

setSStreet 2 Teslimat 2. adres satırı Maksimum 255 karakter Hayır

setSStreet 3 Teslimat 3. adres satırı Maksimum 255 karakter Hayır

setSCity Teslimat yapılacak şehir Maksimum 64 karakter Hayır

setSStateProv Teslimat yapılacak ilçe Maksimum 32 karakter Hayır

setSPostalCode Teslimat posta kodu Maksimum 32 karakter Hayır

setSCountry Faturalama yapılacak Maksimum 3 karakter Hayır
ülke kodu

setSTelVoice Faturalama yapılacak Maksimum 32 karakter Hayır
telefon numarası

SetOrderItem( Ürün Siparişi Hayır
ItemNumber,
ProductCode,
Qty,
Desc,
Id,
Price,
Total)

```
Bir alan , mandatory=Evet olarak işaretlenmişse, her bir işlem
```
```
isteğinde doldurulmalıdır.
```
```
Bir alan, mandatory=Hayır olarak işaretlenmişse, işlem isteklerinde ,
```
```
doldurulması isteğe bağlı demektir.
```
```
Diğer alanların doldurulması , işlem tipine bağlıdır. İşlem tipine bağlı olarak
```
```
belirlenen istek örneklerine bakınız.
```
```
API isteklerinde , üye iş yeri yöneticisi tarafından yaratılan “API kullanıcısı” rolü
```
```
ile yaratılan kullanıcı bilgileri kullanılmalıdır. Diğer rollerde yaratılan kullanıcılarla
```
```
oluşturulan işlem isteklerinde problem oluşabilir:
```
- API kullanıcısının şifresi zaman aşımına uğramaz. Her zaman günceldir.
- Diğer rollerdeki kullanıcıların şifreleri, her 3 ayda bir kullanım süresi

```
dolar. Yönetim ekranlarından değiştirilmesi gerekir.
```
- Yenileme süreleri takip edilip değiştirilmezse, işlem istekleri süresi

```
dolmuş şifrelerle yapılacağından , işlemler hatalı sonuçlanır.
```

#### Jpay API Yanıt Getters^

```
Jpay getter Açıklama Format
```
getOrderId Sipariş numarası Harf ya da rakam, maksimum 64
karakter

getGroupId Grup numarası Harf ya da rakam, maksimum 64
karakter

getResponse İşlem yanıtı Olası Değerler:
“Approved” başarılı işle için
“Declined” başarısız işlem
“Error” ödeme geçidi hataları için

getAuthCode Banka onay kodu Harf ya da rakam, 6 karakter

getHostRefNum Banka referans numarası Harf ya da rakam, 12 karakter

getProcReturnCode İşlem durum kodu Rakam, 2 rakam,
“ 0 0” onay alan işlem
“ 9 9” ödeme geçidi hataları için,
ISO- 85 83 diğer hata kodları

getTransId İşlem numarası Harf ya da rakam, maksimum 64
karakter

getErrMsg Hata mesajı Harf ya da rakam, maksimum 255
karakter

getExtra(“SETTLEID”) gün sonu numarası Rakam, 3 rakam

getExtra(“TRXDATE”) işlem tarihi “yyyyMMdd HH:mm:ss”

getExtra(“ERRORCODE”) Hata kodu Harf ya da rakam, maksimum 16
karakter

getExtra(“HOSTMSG”) Kredi Kartı Numarası Harf ya da rakam, maksimum 255
karakter

getExtra(“NUMCODE”) Rakam Hata kodu Rakam, maksimum 20 rakam


#### Sipariş Durumu Sorgulama Yanıtı^

```
Jpay getter Açıklama Format
```
getExtra(“ORD_ID”) Sipariş numarası Harf ya da rakam, maksimum 64
karakter

getExtra(“CHARGE_TYPE_CD”) İşlem tipi S: Auth/PreAuth/PostAuth
C: Refund^

getExtra(“ORIG_TRANS_AMT”) Ön otorizasyon Tutarı Ondalık ayırıcı olmadan, hassas,

```
en küçük birimi para
```
```
dayanmaktadır
```
getExtra(“CAPTURE_AMT”) Ön otorizasyon Ondalık ayırıcı olmadan, hassas,
Kapama Tutarı
en küçük birimi para
dayanmaktadır

getExtra(“TRANS_STAT”) İşlem Durumu D : Başarısız

```
A : Otorizasyon, gün sonu
kapanmadan
C : Ön otorizasyon kapama, gün sonu
kapanmadan
S : Satış
R : Teknik İptal Gerekiyor
V : İptal
```
getExtra(“AUTH_DTTM”) Otorizasyon Tarihi “yyyy-MM-dd HH:mm:ss.S”

getExtra(“CAPTURE_DTTM”) Otorizasyon Kapama “yyyy-MM-dd HH:mm:ss.S”
Tarihi

getExtra(“AUTH_CODE”) Banka onay kodu Harf ya da rakam, 6 karakter

getExtra(“HOST_REF_NUM”) Banka referans Harf ya da rakam, 12 karakter
numarası

getExtra(“PROC_RET_CD”) İşlem durum kodu Rakam, 2 rakam,
“ 0 0” onay alan işlem
“ 9 9” ödeme geçidi hataları için,
ISO- 85 83 diğer hata kodları

getExtra(“TRANS_ID”) İşlem numarası Harf ya da rakam, maksimum 64
karakter

getExtra(“SETTLEID”) gün sonu numarası Rakam


# DLL API

```
epayapi.dll, Sanal Pos fonksiyonlarını, Windows işletim sistemlerini destekler.
```
```
"epayapi.dll " ile, herhangi bir programlama dilinde yazılmış uygulamadan API
```
```
fonksiyonlarının çağrılabilmesini sağlar. Visual Basic Script buna bir örnektir.
```
## DLL API kurulum gereksinimleri

- Epayapi.dll tanımı yapılmadan önce Internet Information Services (ISS)

```
servisi durdurulmalıdır.
```
- IIS durdurulduktan sonra , Start>>Run da " regsvr 32 epayapi.dll " yazıp

```
OK e basınız.
```
- Epayapi.dll, silinmesi engellenecek bir dizinde saklanmalıdır. Örneğin:

```
C: \ WINDOWS \ system32
```
- Başarılı tanımlama sonucu üst ekran olarak çıkar. Tamam butonuna tıklanır.
- Tanımlama başarılı tamamlandığında, IIS tekrar başlatılır.

## DLL API Kullanımı

```
epayapi.dll bir kere tanımlandıktan sonra, CreateObject fonksiyonu ile erişilebilir.
```
```
Örneğin;
```
```
Set pay= CreateObject ("epayapi.payment")
```
- ASP, Visual Basic ya da C++ nesnesi yaratılır
- İşlem parametreleri doldurulur
- ProcessOrder() metodu çağrılır
- Metot sonucu, iadenin başarılı olup olmadığı belirtir

###### ◦ Sonuç “ 1 ” ise, banka ile bağlantı ve işlem başarılı

###### ◦ Sonuç “ 0 ” ise, banka ile bağlantıda problem oluşmuş olabilir


```
Örnek Kullanım: Sadece zorunlu alanları doldurarak satış işlemi örneği:
```
```
set myPay = Server.createObject("epayapi.payment")
myPay.host = "host.com.pl"
myPay.name = "apiuser" myPay.password =
"TEST1234" myPay.clientid = "990000001"
myPay.oid = "ORDER-123"
myPay.orderresult = 0 myPay.chargetype
```
```
= "Auth" myPay.currency = "949"
myPay.cardnumber = "4242424242424242"
myPay.expmonth = "12"
```
```
myPay.expyear = "12"
```
```
myPay.cv2 = "000"
```
```
myPay.subtotal = "10" result
```
```
= myPay.processorder
```
#### DLL API İstek Alanları^

(^)
**Alan Açıklama Format Zorunlu**
name Kullanıcı Adı Harf ya da rakam, maksimum Evet
255 karakter
password Şifre Harf ya da rakam, maksimum Evet
255 karakter
clientid Üye iş yeri numarası Harf ya da rakam, maksimum Evet
15 karakter
chargetype İşlem Tipi Harf ya da rakam, geçerli Evet
değerler {Auth, PreAuth,
PostAuth, Void, Credit}
ip Müşterinin IP Maksimum 39 karakter Hayır
numarası
oid Sipariş numarası Harf ya da rakam, maksimum
64 karakter
groupid Grup numarası Harf ya da rakam, maksimum
64 karakter
subtotal Toplam tutar Rakam,
Ondalıklı rakamlar için “,” veya
“.” kullanılır.
Karakter kullanılmaz
currency ISO para birimi kodu Rakam, 3 rakam (TL için 949)
setUserId Raporlama için, Rakam, maksimum 64 rakam Hayır
kullanıcı numarası
cardnumber Kredi Kartı Numarası Harf ya da rakam + sembol
cv 2 Kredi Kartı güvenlik Rakam, 3 rakam
numarası
expmonth Kredi Kartı son MM
kullanma tarihi: ay

###### ÜYE İŞ YERİ ENTEGRASYON DOKÜMANI

```
expyear Kredi Kartı son YY
```

```
kullanma yılı
```
taksit Taksit miktarı Rakam Hayır

payersecuritylevel ECI Rakam, 2 rakam

payertxnid internet işlem Harf ya da rakam + sembol, 28
numarası karakter, base 64 - encoded

payerauthenticationcode CAVV Harf ya da rakam + sembol, 28
karakter, base 64 - encoded

bname Faturalama yapılacak Maksimum 255 karakter Hayır
müşteri adı

baddr 1 Fatura 1. adres satırı Maksimum 255 karakter Hayır

baddr 2 Fatura 2. adres satırı Maksimum 255 karakter Hayır

baddr 3 Fatura 3. adres satırı Maksimum 255 karakter Hayır

bcity Faturalama yapılacak Maksimum 64 karakter Hayır
şehir

bstate Faturalama yapılacak Maksimum 32 karakter Hayır
ilçe

bzip Faturalama yapılacak Maksimum 32 karakter Hayır
posta kodu

bcountry Faturalama yapılacak Maksimum 3 karakter Hayır
ülke kodu

phone Faturalama yapılacak Maksimum 32 karakter Hayır
telefon numarası

sname Teslimat yapılacak Maksimum 255 karakter Hayır
müşteri adı

saddr 1 Teslimat 1. adres Maksimum 255 karakter Hayır
satırı

saddr 2 Teslimat 2. adres Maksimum 255 karakter Hayır
satırı

saddr 3 Teslimat 3. adres Maksimum 255 karakter Hayır
satırı

scity Teslimat yapılacak Maksimum 64 karakter Hayır
şehir

sstate Teslimat yapılacak Maksimum 32 karakter Hayır
ilçe

szip Teslimat posta kodu Maksimum 32 karakter Hayır

scountry Faturalama yapılacak Maksimum 3 karakter Hayır
ülke kodu

id Ürün Id' si Maksimum 128 karakter Hayır

itemNumber Ürün numarası Maksimum 128 karakter Hayır

productCode Ürün kodu Maksimum 64 karakter Hayır

quantity Ürün Miktarı Maksimum 32 karakter Hayır

desc ürün Açıklaması Maksimum 128 karakter Hayır

price ürün Fiyatı Maksimum 32 karakter Hayır


```
Bir alan , Zorunlu Alan=Evet olarak işaretlenmişse, her bir işlem isteğinde
```
```
doldurulmalıdır.
```
```
Bir alan, Zorunlu Alan=Hayır olarak işaretlenmişse, işlem isteklerinde , doldurulması
```
```
isteğe bağlı demektir.
```
```
Diğer alanların doldurulması , işlem tipine bağlıdır. İşlem tipine bağlı olarak belirlenen
```
```
istek örneklerine bakınız.
```
```
API isteklerinde , üye iş yeri yöneticisi tarafından yaratılan “API kullanıcısı” rolü
```
```
ile yaratılan kullanıcı bilgileri kullanılmalıdır. Diğer rollerde yaratılan kullanıcılarla
```
```
oluşturulan işlem isteklerinde problem oluşabilir:
```
- API kullanıcısının şifresi zaman aşımına uğramaz. Her zaman günceldir.
- Diğer rollerdeki kullanıcıların şifreleri, her 3 ayda bir kullanım süresi

```
dolar. Yönetim ekranlarından değiştirilmesi gerekir.
```
- Yenileme süreleri takip edilip değiştirilmezse, işlem istekleri süresi

```
dolmuş şifrelerle yapılacağından , işlemler hatalı sonuçlanır.
```
#### DLL API Yanıt Alanları^

(^)
**Alan Açıklama Format**
oid Sipariş numarası Harf ya da rakam, maksimum 64 karakter
groupid Grup numarası Harf ya da rakam, maksimum 64 karakter
appr İşlem yanıtı Olası Değerler:
“Approved” başarılı işle için
“Declined” başarısız işlem
“Error” ödeme geçidi hataları için
code Banka onay kodu Harf ya da rakam, 6 karakter
refno Banka referans numarası Harf ya da rakam, 12 karakter
err İşlem durum kodu Rakam, 2 rakam,
“ 0 0” onay alan işlem
“ 9 9” ödeme geçidi hataları için,
ISO- 85 83 diğer hata kodları
transid İşlem numarası Harf ya da rakam, maksimum 64 karakter
errmsg Hata mesajı Harf ya da rakam, maksimum 255 karakter
extra(“SETTLEID”) gün sonu numarası Rakam, 3 rakam
extra(“TRXDATE”) işlem tarihi (^) “yyyyMMdd HH:mm:ss”
extra(“ERRORCODE”) Hata kodu Harf ya da rakam, maksimum 16 karakter
extra("HOSTMSG") Kredi Kartı Numarası Harf ya da rakam, maksimum 255 karakter
extra(“NUMCODE”) Rakam hata kodu Rakam, maksimum 20 rakam


# .NET API

```
.NET API , Sanal POS fonksiyonalitesini .NET yazılım ortamlarında desteklemek
```
```
amacıyla hazırlanmıştır.
```
## .NET API kurulumu

- .NET altında bin dizini yaratılır.
- epayment.dll bu dizine kopyalanır

## .NET API Kullanımı

- İlgili sayfada nesne adı **dim mycc5pay** olacak şekilde **new**

```
ePayment.cc 5 payment() metodu ile epayment nesnesi yaratılır
```
- **set** fonksiyonları kullanılarak alanlar doldurulur
- **mycc5pay.processorder()** metodu çağrılarak ödeme gönderilir
- **get** fonksiyonları kullanılarak sonuç alınır.

```
Örnek Kullanım: Sadece zorunlu alanları doldurarak satış işlem örneği:
```
```
<script language="VB" runat="server">
Sub Page_Load(Sender As Object, E As EventArgs)
dim mycc5pay as new ePayment.cc5payment()
mycc5pay.host="https://host/fim/api"
mycc5pay.name="apiuser"
mycc5pay.password="TEST1234"
mycc5pay.clientid="990000001"
mycc5pay.orderresult="0"
mycc5pay.oid="ORDER-123"
mycc5pay.cardnumber = "4242424242424242"
mycc5pay.expmonth = "12"
mycc5pay.expyear = "12"
mycc5pay.cv2 = "000"
mycc5pay.subtotal = 10
mycc5pay.currency = 949
mycc5pay.chargetype = "Auth"
Result1.Text= mycc5pay.processorder()
Procreturncode.Text = mycc5pay.procreturncode
ErrMsg.Text = mycc5pay.errmsg
Oid1.Text = mycc5pay.oid
appr1.Text = mycc5pay.appr
End Sub
```
```
</script>
```

#### .NET API İstek Alanları^

```
Alan Açıklama Format Zorunlu alan
name Kullanıcı Adı Harf ya da rakam, Evet
maksimum 2 55 karakter
password Şifre Harf ya da rakam, Evet
maksimum 2 55 karakter
```
```
clientid Üye iş yeri numarası Harf ya da rakam, Evet
maksimum 15 karakter
chargetype İşlem Tipi Harf ya da rakam, geçerli Evet
değerler {Auth, PreAuth,
PostAuth, Void, Credit}
```
```
ip Müşterinin IP Maksimum 39 karakter Hayır
numarası
```
```
oid Sipariş numarası Harf ya da rakam,
maksimum 64 karakter
groupid Grup numarası Harf ya da rakam,
maksimum 64 karakter
```
```
subtotal Toplam tutar Rakam,
Ondalıklı rakamlar için
“,” veya “.” kullanılır.
Karakter kullanılmaz
```
```
currency ISO para birimi kodu Rakam, 3 rakam (TL için
94 9)^
setUserId Raporlama için, Rakam, maksimum 64 Hayır
kullanıcı numarası rakam
cardnumber Kredi Kartı Numarası Harf ya da rakam +
sembol^
```
```
cv 2 Kredi Kartı güvenlik Rakam, 3 rakam
numarası
expmonth Kredi Kartı son MM
kullanma tarihi: ay^
```
```
expyear Kredi Kartı son YY
kullanma yılı
taksit Taksit miktarı Rakam Hayır
```
```
payersecuritylevel ECI Rakam, 2 rakam
payertxnid internet işlem Harf ya da rakam +
numarası sembol, 28 karakter,
base 64 - encoded
```
```
payerauthenticationcode CAVV Harf ya da rakam +
sembol, 28 karakter,
base 64 - encoded
bname Faturalama yapılacak Maksimum 255 karakter Hayır
müşteri adı
```
```
baddr 1 Fatura 1. adres satırı Maksimum 255 karakter Hayır
baddr 2 Fatura 2. adres satırı Maksimum 255 karakter Hayır
baddr 3 Fatura 3. adres satırı Maksimum 255 karakter Hayır
bcity Faturalama yapılacak Maksimum 64 karakter Hayır
şehir
bstate Faturalama yapılacak Maksimum 32 karakter Hayır
```
###### ÜYE İŞ YERİ ENTEGRASYON DOKÜMANI

```
ilçe
```

bzip Faturalama yapılacak Maksimum 32 karakter Hayır
posta kodu

bcountry Faturalama yapılacak Maksimum 3 karakter Hayır
ülke kodu

phone Faturalama yapılacak Maksimum 32 karakter Hayır
telefon numarası

sname Teslimat yapılacak Maksimum 255 karakter Hayır
müşteri adı

saddr 1 Teslimat 1. adres satırı Maksimum 255 karakter Hayır

saddr 2 Teslimat 2. adres satırı Maksimum 255 karakter Hayır

saddr 3 Teslimat 3. adres satırı Maksimum 255 karakter Hayır

scity Teslimat yapılacak Maksimum 64 karakter Hayır
şehir

sstate Teslimat yapılacak ilçe Maksimum 32 karakter Hayır

szip Teslimat posta kodu Maksimum 32 karakter Hayır

scountry Teslimat yapılacak Maksimum 3 karakter Hayır
ülke kodu

additem( Sipariş ürünü Hayır
ItemNumber,
ProductCode,
Qty, Desc, Id, Price, Total)

```
Bir alan , Zorunlu Alan=Evet olarak işaretlenmişse, her bir işlem
```
```
isteğinde doldurulmalıdır.
```
```
Bir alan, Zorunlu Alan=Hayır olarak işaretlenmişse, işlem isteklerinde ,
```
```
doldurulması isteğe bağlı demektir.
```
```
Diğer alanların doldurulması , işlem tipine bağlıdır. İşlem tipine bağlı olarak
```
```
belirlenen istek örneklerine bakınız.
```
```
API isteklerinde, üye iş yeri yöneticisi tarafından yaratılan “API kullanıcısı”
```
```
rolü ile yaratılan kullanıcı bilgileri kullanılmalıdır. Diğer rollerde yaratılan
```
```
kullanıcılarla oluşturulan işlem isteklerinde problem oluşabilir:
```
- API kullanıcısının şifresi zaman aşımına uğramaz. Her zaman günceldir.
- Diğer rollerdeki kullanıcıların şifreleri, her 3 ayda bir kullanım süresi

```
dolar. Yönetim ekranlarından değiştirilmesi gerekir.
```
- Yenileme süreleri takip edilip değiştirilmezse, işlem istekleri süresi

```
dolmuş şifrelerle yapılacağından , işlemler hatalı sonuçlanır.
```

#### .NET API Yanıt Alanları^

```
Alan Açıklama Format
oid Sipariş Numarası Harf ya da rakam, maksimum 64
karakter
groupid Grup numarası Harf ya da rakam, maksimum 64
karakter
```
```
appr İşlem dönüşü Olası Değerler: “Approved”
başarılı işlem, “Declined”
başarısız işlem, “Error” ödeme
geçidi hatası için.
code Banka onay kodu Harf ya da rakam, 6 karakter
refno Banka referans kodu Harf ya da rakam, 12 karakter
err İşlem durum kodu Rakam, 2 rakam,
“ 0 0” otorizasyon için,
“ 9 9” ödeme geçidi hata kodu,
"ISO- 8583 " diğer hata kodu
```
```
transid İşlem numarası Harf ya da rakam, maksimum 64
karakter
errmsg Hata mesajı Harf ya da rakam, maksimum 255
karakter
```
```
extra(“SETTLEID”) Günsonu numarası Rakam, 3 rakam
```
```
extra(“TRXDATE”) İşlem tarihi “yyyyMMdd HH:mm:ss”
extra(“ERRORCODE”) Hata kodu Harf ya da rakam, maksimum 16
karakter
extra("HOSTMSG") Kredi Kartı numarası Harf ya da rakam, maksimum 255
karakter
```
```
extra(“NUMCODE”) Rakam hata kodu Rakam, maksimum 20 rakam
```

# Tekrarlayan Ödeme

```
Tekrarlayan ödemeler, ön otorizasyon isteği ile oluşturulur. Her bir tekrarlayan ödeme
```
```
kaydı, tekrarlama aralığı, tekrar sayısı, taksit bilgileri gibi tekrarlayan ödeme yaratma
```
```
isteğindeki bilgileri içerir. Tekrarlayan ödemeler, abonelik türü düzenli ödemelerde
```
```
kullanım kolaylığı sağlar.
```
## Kullanımı

```
Tekrarlayan ödemeler , XML isteğinde <PbOrder> etiketi kullanılarak tanımlanabilir.
```
```
Örnek XML İsteği:
```
```
<CC5Request>
<Name>FINTESTAPI</Name>
<Password>***</Password>
<ClientId>600100000</ClientId>
<IPAddress>1.1.1.1</IPAddress>
<Mode>P</Mode>
<OrderId></OrderId>
<Type>Auth</Type>
<Number>424242***4242</Number>
<Expires>***</Expires>
<Cvv2Val>***</Cvv2Val>
<Total>180</Total>
<Currency>949</Currency>
<PbOrder>
<OrderType>0</OrderType>
<TotalNumberPayments>3</TotalNumberPayments>
<OrderFrequencyCycle>M</OrderFrequencyCycle>
<OrderFrequencyInterval>1</OrderFrequencyInterval>
</PbOrder> <VersionInfo>EPAYAPI-
```
```
1.2.0.32</VersionInfo> <BillTo>
```
```
<Name></Name>
</BillTo>
<ShipTo>
<Name></Name>
</ShipTo>
<Extra></Extra>
</CC5Request>
```

### Tekrarlayan Ödeme Parametreleri^

```
Parametre İsmi Açıklama Değerler
```
OrderType Tekrarlayan ödemede taksit var ise tanımlanır. 0: Varsayılan, taksitsiz

TotalNumberPayments Taksit sayısı^ tanımlama.^ Geçerli^ bir aralık^ ise:
OrderType=0

```
Rakam
```
OrderFrequencyCycle Tekrarlanan aralık tipi D: Gün
W: Hafta
M: Ay
OrderFrequencyInterval Tekrarlanan aralık değeri Rakam

### Tekrarlayan Ödeme Örnek Kodu

```
3 tekrarlı, aylık ödemeli, taksit içermeyen tekrarlayan ödeme için olması gereken
```
```
örnek XML isteği, farklı API' ler için:
```
#### XML API Örneği

```
<PbOrder>
<OrderType>0</OrderType>
<TotalNumberPayments>3</TotalNumberPayments>
<OrderFrequencyCycle>M</OrderFrequencyCycle>
<OrderFrequencyInterval>1</OrderFrequencyInterval>
</PbOrder>
```
#### JAVA API Örneği

```
jpay myjpay = new jpay();
myjpay.setName(“apiuser”);
myjpay.setPassword(“apipassword”);
myjpay.setClientId(“990000000000001”);
myjpay.setOrderId(“ORDER123”);
myjpay.setType(“Auth”);
myjpay.setTotal("10.5");
myjpay.setCurrency("949");
myjpay.setNumber( “4242424242424242” );
myjpay.setCvv2Val("000");
myjpay.setExpires("10/2028");
myjpay.setPbOrder("0", "5", "M", "17");
```
```
if (myjpay.processTransaction("host", 443,"/fim/api") > 0){
```
###### / Transaction successful

```
} else {
System.out.println(myjpay.getErrMsg());
}
```

#### DLL API Örneği

```
ePayment.cc5payment paymentObject = new cc5payment();
paymentObject.host = txtHost.Text;
paymentObject.clientid = txtClientId.Text;
paymentObject.name = txtName.Text;
paymentObject.password = txtPassword.Text;
paymentObject.ip = String.Empty;
paymentObject.cardnumber = txtCardNumber.Text;
paymentObject.expmonth = txtExpMonth.Text;
paymentObject.expyear = txtExpYear.Text;
paymentObject.cv2 = txtCV2.Text;
paymentObject.subtotal = txtAmount.Text;
paymentObject.currency = txtCurrencyCode.Text;
paymentObject.oid = txtOrderId.Text;
paymentObject.addpborder("0", "5", "M", "1");
paymentObject.taksit = txtTaksit.Text;
result = paymentObject.processorder();
```
### Tekrarlayan Ödeme Hata Kodları^

```
Kod Orijinal Hata Mesajı Hata Mesajı Açıklama
```
CORE- 1007 Invalid value for 'OrderType'
for 'PbOrder'. Please check
API manuals.

```
'OrderType' için 'PbOrder'
değeri geçersiz. Api manüeline
bakınız.
```
```
Sipariş Tipi girilmemiş veya "0"
dan başka bir değer girilmiş.
```
```
CORE- 2020 The^ recurring period unit is
missing or empty.
```
```
Tekrarlayan ödeme birimi
eksik ya da geçersiz.
```
```
OrderFrequencyCycle değeri
girilmemiş.
```
```
CORE- 2021 The^ recurring period unit is
not valid.
```
```
Tekrarlayan ödeme aralık tipi
geçersiz.
```
```
OrderFrequencyCycle
"M", "D" veya "Y" den başka
değer girilmiş.
CORE- 2022 The recurring period is not
valid.
```
```
Tekrarlayan ödeme aralık
sayısı geçersiz.
```
```
OrderFrequencyInterval değeri
girilmemiş veya girilen değer
" 9 9" dan büyük.
CORE- 2023 The recurring duration is not
valid.
```
```
Taksit sayısı geçersiz. TotalNumberPayments değeri
girilmemiş.
```
```
CORE- 2024 Only^ Sale^ transaction have
recurring payment.
```
```
Sadece satışların tekrarlayan
ödemesi olabilir.
```
```
Sadece satış (Auth) işlemlerinde
tekrarlayan ödeme olur.
```
```
CORE- 2029 Recurring or futurerequest is
not allowed to plan for long
term.
```
```
Tekrarlanan ödeme veya
futurerequest 'te uzun vadeli
plan için izin verilmez.
```
```
TotalNumberPayments değeri
" 1 21" den büyük.^
```
```
CORE- 2034 Recurring payment can not
be installment sale.
```
```
Tekrarlayan ödemelerde
taksitli satış olamaz.
```
```
Tekrarlayan ödemeler taksitli
satış olamaz.
```

# Örnek Senaryolar

```
Soru: Müşteri 12 ay tekrarlı ödeme tanımlatmışsa ve 3 .aydan sonra ödeme miktarını
```
```
değiştirmek isterse, ne yapılabilir?
```
```
Cevap: Bu aşamada tekrarlayan ödeme tutarı değiştirilemez. Kalan tanımlanmış
```
```
ödeme kayıtları Kontrol Merkezinden iptal edilebilir ya da API kullanılarak yeni
```
```
tekrarlayan ödeme isteği gönderilebilir.
```
```
Soru: Müşterinin mevcutta tekrarlayan ödemeleri varken, kredi kartı iptal olmuşsa ya
```
```
da kredi kartı numarası değişmişse, ne yapılmalıdır?
```
```
Cevap: Her bir tekrarlayan ödeme kaydı, önceki işlemlerin sonuçlarından bağımsız
```
```
çalışır. Kalan tanımlanmış ödeme kayıtları Kontrol Merkezinden iptal edilebilir ya da API
```
```
kullanılarak yeni tekrarlayan ödeme isteği gönderilebilir.
```
```
Soru: Tekrarlayan ödemelerin bazıları , diğerlerini etkilemeyecek şekilde, iptal edilebilir
```
```
mi?
```
```
Cevap: Bu tür bir istek, sadece Kontrol Merkezi arayüzünden yapılabilir. Örneğin, 10
```
```
tekrarlı bir tekrarlayan ödemenin, 4 .ödemesi iptal edilebilir. API kullanılarak tüm kalan
```
```
tekrarlayan ödeme kayıtları iptal edilir.
```

