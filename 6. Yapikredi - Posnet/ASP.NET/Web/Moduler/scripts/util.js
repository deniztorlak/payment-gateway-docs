// JavaScript Document

KURUS_AYRACI		= ',';

function findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function findandfocus(objName) { //v3.0
	var obj = findObj(objName);
	if (obj == null) return;
	obj.focus();
}

function ykr(tutar){
	//sadece kuru? ayrac? kals?n:
	tutar = sayiOlmayanlariSil(tutar);
	
	var ind = tutar.indexOf(KURUS_AYRACI);
	if (ind == -1)
		//kuru? girilmemi?:
		return tutar+'00';
		
	var kac0var = tutar.length-ind-1;
	var kac0ekle = 2-kac0var;
	for(i = 0; i < kac0ekle; i++)
		tutar = tutar+'0';
		
	//kuru? ayrac?n? sil:
	var bas = tutar.substring(0, ind);
	var son = tutar.substr(ind+1);
	tutar = bas+son;
	return tutar;
}

//verilen dizge sayýysa true, degilse false döner.
function sayi(dizge){
	for (var i=0; i<dizge.length; i++)
		if (isNaN(dizge.charAt(i)))
			return false;
	return true;
}

//verilen sayýda tutar olmayan karakterlerin silinmiþ halini döner:
function sayiOlmayanlariSil(s){
	var gcc = '';
	var i;
	for (i=0; i<s.length; i++){
		if (sayi(s.charAt(i)) 
		|| (s.charAt(i) == KURUS_AYRACI && i < s.length-1)//son kar ayraç
				//olursa ekleme
		)
			gcc += s.charAt(i);
	}
	return gcc;
}

function tutarKontrol(kutuAdi){
	var kutu = findObj(kutuAdi);

	//virgülle bitmemeli:
	if (kutu.value.charAt(kutu.value.length-1) == KURUS_AYRACI || kutu.value == '' || kutu.value == '0,00' || kutu.value == '0'){
		alert("Tutar hatalý!");
		findandfocus(kutuAdi);
		return false;
	}
	return true;
}

function binlerAyraci(){
	return (KURUS_AYRACI == ".") ? ",":".";
}

//binler basamaklarini ayirir. Virgüllü degerler gönderilmemelidir:
//kutuHazir parametresi, kutude?erine bir karakter daha eklenip
//eklenmeyece?ini gösterir. KeyPress'de normalde kutu hazyr de?ildir
function tutarKutuBicimleAsil(kutuvalue, kutuHazir){
	//eski binler ayraçlaryny sil:
	//aslinda bu kullanilmali, ama regexpler hakkinda bilgi lazim: num = kutu.value.replace(/\./g,'');
	var ba = binlerAyraci();
	num = "";
	for (var i=0; i<kutuvalue.length; i++)
		if (kutuvalue.charAt(i) != ba) num += kutuvalue.charAt(i);
	
	//yeni ayraçlary gir:
	var s = "";
	var j=(kutuHazir)?0:1;
	for (i = num.length-1; i>=0; i--) {
		s = num.charAt(i)+s;
		j++;
		if (j == 3 && i > 0) {
			s = binlerAyraci()+s;
			j = 0;
		}
	} 
	return s;
}
//tutar kutusunda geri (backspace) tu?unda basyldy?ynda
//kutuyu biçimler. OnKeyDown'da ça?yrylmalydyr.
function tutarKutuBicimleSilme(kutu,e) {
	var whichCode = (window.Event) ? e.which : e.keyCode;
	var agt=navigator.userAgent.toLowerCase();
    var is_firefox  = (agt.indexOf('firefox')!=-1)
    var is_opera  = (agt.indexOf('opera')!=-1)
    var is_netscape  = (agt.indexOf('netscape')!=-1)
    
	if (whichCode == 8)		//silme (backspace)
	{
		kaYeri	//kuru? ayraç yeri
	    		= kutu.value.indexOf(KURUS_AYRACI);
		if (kaYeri > -1	//kurus ayraci girilmi?se
		){
			
			if (kaYeri == kutu.value.length-2 || is_firefox || is_netscape)
			{
				//silme i?leminden sonra sadece kuru? ayracy kalacak,
				//o da silinmeli:
				kutu.value = kutu.value.substr(0, kutu.value.length-1);
			}
			//çyk: Son hane silinecek:
			return;
		}
		else{
		
		    //son haneyi dikkate almadan biçimle:
			var s = tutarKutuBicimleAsil(
				kutu.value.substr(0, kutu.value.length-1), true);
			
			if (is_firefox || is_netscape)
			       kutu.value = s;
			else
			    kutu.value = s
				+'a'	//fonk.tan çykynca silme komutu aktif olacak,
					//komut bu a'yy silecek.
				;
		}
	}
}
function tutarKutuBicimle(kutu,e) {
	var whichCode = (window.Event) ? e.which : e.keyCode;
	if (whichCode == 13) return true;  // Enter
	
	key 	//girilen karakter
		= String.fromCharCode(whichCode);  // Get key value from key code
	var strCheck 	//girilebilecek kar.lar
		= '0123456789';
	if (kutu.value.indexOf(KURUS_AYRACI) == -1	//kurus ayraci zaten girilmemi?se
	)
		//KURUS_AYRACI da girilebilir:
		strCheck += KURUS_AYRACI;
	if (strCheck.indexOf(key) == -1) return false;  // Not a valid key
	
	if (kutu.maxLength <= kutu.value.length+1)
		//kutu dolmus:
		return false;
	
	if (key == KURUS_AYRACI){
		if (kutu.value.length == 0){
			//basylan ilk harf virgül, 0 ekle:
			kutu.value = "0";
			return true;
		}
		if (kutu.maxLength > kutu.value.length+2){
			kutu.value = tutarKutuBicimleAsil(kutu.value, true);
			return true;
		}
		else 
			//kutu dolmus:
			return false;
	}
	
	if (key == '0'){
		if (kutu.value.length == 0)
			//ilk girilenin 0 olmasyna sadece YTL'de izin ver:
			return true;
		if (kutu.value == '0')
			//kutu zaten 0. Fazla 0'a izin verme:
			//buraya ancak YTL'de girebiliriz.
			return false;
	}
	
	if (kutu.value.indexOf(KURUS_AYRACI) != -1) //virgül varsa
	{
		if (kutu.value.indexOf(KURUS_AYRACI) <= kutu.value.length-3)
			//virgülden sonra 2 hane girilmisse fazlasina izin verme:
			return false;
		else
			//biçimleme yapmadan çik:
			return true;
	}
	
	kutu.value = tutarKutuBicimleAsil(kutu.value, false);
	return true;
}
