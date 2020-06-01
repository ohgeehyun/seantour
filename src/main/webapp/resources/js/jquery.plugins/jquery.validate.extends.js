(function ($) {
	//영문+숫자만
	$.validator.addMethod('alphanum', function(val, el) {
		var pattern =  /^[a-zA-Z0-9]+$/;
		return pattern.test(val);   
	});
	//아이디
	$.validator.addMethod('idpattern', function(val, el) {
		var pattern =  /^[a-zA-Z]{1}[a-zA-Z0-9_]+$/;
		return pattern.test(val);   
	});
	//비밀번호
	$.validator.addMethod('pwpattern', function(val, el) {
		//비밀번호 - 길이, 대소문자 제한없음
		//var pattern = '/^[a-z0-9_-]$/';
		//중간 비밀번호 - 8~15 사이의 수, 최소 1개의 영문자,숫자 그리고 특수문자 1개 포함
		//var pattern = /((?=.*\d)(?=.*[a-zA-Z]).)/gm;
		//강력한 비밀번호 - 8~15 사이의 수, 최소 1개의 대문자와 소문자 그리고 특수문자 1개 포함
		//var pattern = /((?=.*\d)(?=.*[a-z])(?=.*[A-Z]).)/gm;
		//return pattern.test(val);   
		
		var pattern1 = /[a-zA-Z]/i; // 영문
		var pattern2 = /[0-9]/i; // 숫자
		var pattern3 = /[@!#\$\^%&*()+=\-\[\]\\\';,\.\/\{\}\|\":<>\?]/i; // 특수기호
		var pattern4 = /^[a-zA-Z0-9@!#\$\^%&*()+=\-\[\]\\\';,\.\/\{\}\|\":<>\?]+$/i; // 영문/숫자/특수기호 외 한글여부체크
		
		return (pattern1.test(val) && pattern2.test(val) && pattern3.test(val) && pattern4.test(val));
		
	});

	//전화번호(핸드폰 포함)
	$.validator.addMethod('tel', function(val, el) {
		if(val == '')return true;
		var pattern =  /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		return pattern.test(val);   
	});

	//핸드폰 번호
	$.validator.addMethod('handphone', function(val, el) {
		if(val == '')return true;
		var pattern =  /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		return pattern.test(val);   
	});

	//ip패턴(숫자,*)
	$.validator.addMethod('ippattern', function(val, el) {
		var pattern1 = /^[0-9]+$/;
		var pattern2 = /^[*]+$/;
		
		return (pattern1.test(val) || pattern2.test(val)) && val.length < 4;   
	});
	
	$.validator.addMethod('businessnum', function(num, el){
		var reg = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/; 
		if (!reg.test(num)) return false; 
		num = RegExp.$1 + RegExp.$2 + RegExp.$3; 
		var cVal = 0; 
		for (var i=0; i<8; i++) { 
		var cKeyNum = parseInt(((_tmp = i % 3) == 0) ? 1 : ( _tmp == 1 ) ? 3 : 7); 
		cVal += (parseFloat(num.substring(i,i+1)) * cKeyNum) % 10; 
		} 
		var li_temp = parseFloat(num.substring(i,i+1)) * 5 + '0'; 
		cVal += parseFloat(li_temp.substring(0,1)) + parseFloat(li_temp.substring(1,2)); 
		return (parseInt(num.substring(9,10)) == 10-(cVal % 10)%10); 
	});
	
	$.validator.addMethod('ipaddress', function(value) { 
		var split = value.split('.'); 
		if (split.length != 4)  
			return false; 

		for (var i=0; i<split.length; i++) { 
			var s = split[i]; 
			if (s.length==0 || isNaN(s) || s<0 || s>255) 
				return false; 
		} 
		return true; 
	}, ' Invalid IP Address'); 




	$.extend($.validator.messages, {
		alphanum:"영문(대,소문자) + 숫자 만 입력가능합니다."
		,idpattern: "영문(대,소문자) + 숫자 + _ 만 입력가능하며 첫번째 문자는 영문만 가능합니다."
		,pwpattern: "영문자,숫자,특수문자를 각각 1개이상은 포함하여야 합니다."
		,tel: "하이픈(-)을 포함한 전화번호를 입력해 주세요"
		,handphone: "하이픈(-)을 포함한 핸드폰 번호를 입력해 주세요"
		,ippattern: "숫자 또는 *만 입력해 주세요"
		,businessnum: "하이픈(-)을 포함한 사업자등록번호를 입력해 주세요."
	});
}(jQuery));

/*
//숫자만 가능
var intRegex = /[0-9 -()+]+$/;
//IP 주소형식
var ipRegex = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b';
//0-255 숫자
var num0to255Regex = '^([01][0-9][0-9]|2[0-4][0-9]|25[0-5])$';
//0-999 범위의 수
var num0to999Regex = '^([0-9]|[1-9][0-9]|[1-9][0-9][0-9])$';
//소수점 허용
var floatRegex = '[-+]?([0-9]*\.[0-9]+|[0-9]+)';
//1-50 까지의 숫자
var number1to50Regex = /(^[1-9]{1}$|^[1-4]{1}[0-9]{1}$|^50$)/gm;



//이메일
var emailRegex = '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$';
//카드 번호 4자리
var creditCardRegex = '^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$';
//사용자 이름
var usernameRegex = '/^[a-z0-9_-]{3,16}$/';
//비밀번호 - 길이, 대소문자 제한없음
var passwordRegex = '/^[a-z0-9_-]{6,18}$/';
//강력한 비밀번호 - 8~15 사이의 수, 최소 1개의 대문자와 소문자 그리고 특수문자 1개 포함
var passwordStrengthRegex = /((?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,15})/gm;
//폰번호
var phoneNumber = /[0-9-()+]{3,20}/; 




//일자 포맷 -> 21/3/2006
var dateRegex = /(\d{1,2}\/\d{1,2}\/\d{4})/gm;
//일자 포맷 -> MM/DD/YYYY
var dateMMDDYYYRegex = '^(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d$';
//일자 포맷 -> DD/MM/YYYY
var dateDDMMYYYRegex = '^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$';



//URL
var urlRegex = '/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/';
//URL 슬러그 형
var urlslugRegex = '/^[a-z0-9-]+$/';



var whiteSpaceRegex = '^[ \t]+';
//공백과 탭
var whiteSpaceRegex = '^[ \t]+|[ \t]+$';
//공백과 탭과 \r포함(IE의 경우 textarea에서 엔터를 \r\n으로 인식)
var whiteSpaceRegex = '[ \t\r\n]';
//엔터키를 <br>로 변경해주는 함수
newLineToBr = function(str) { return str.replace(/(\r\n|[\r\n])/g, '<br>'); }



//도메인 이름(http 포함)
var domainRegex = /(.*?)[^w{3}\.]([a-zA-Z0-9]([a-zA-Z0-9\-]{0,65}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6}/igm;
//도메인 이름 (http://를 제외한)
var domainRegex = /[^w{3}\.]([a-zA-Z0-9]([a-zA-Z0-9\-]{0,65}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6}/igm;
//도메인 이름 (아래의 co.uk 와 같은 특정도메인)
var domainRegex = /(.*?)\.(com|net|org|info|coop|int|com\.au|co\.uk|org\.uk|ac\.uk|)/igm;
//서브 도메인과 매칭이 되는지 비교: www, dev, int, stage, int.travel, stage.travel
var subDomainRegex = /(http:\/\/|https:\/\/)?(www\.|dev\.)?(int\.|stage\.)?(travel\.)?(.*)+?/igm;


//jpg, gif, png 이미지, 아래 bmp나 기타 형식은 추가해서 사용가능
var imageRegex = /([^\s]+(?=\.(jpg|gif|png))\.\2)/gm;
//모든 이미지 태그
var imgTagsRegex = /<img.+?src=\"(.*?)\".+?>/ig;
//이미지 png 타입<img.+?src=\"(.*?.png)\".+?></img.+?src=\"(.*?.png)\".+?></img.+?src=\"(.*?)\".+?>



//RGB 컬러 형식
var rgbRegex = /^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/;
//Hex 코드 컬러 형식
var hexRegex = '/^#?([a-f0-9]{6}|[a-f0-9]{3})$/';
//Hex 코드 형식과 16진수로 작성되어 있는지 
var hexRegex = /(#?([A-Fa-f0-9]){3}(([A-Fa-f0-9]){3})?)/gm;
//HTML 태그 형식 #1
var htmlTagRegex = '/^<([a-z]+)([^<]+)*(?:>(.*)<\/\1>|\s+\/>)$/';
//HTML 태그 형식 #2
var htmlTagRegex = /(\<(/?[^\>]+)\>)/gm;
//URL이 다음과 같이 특정 문자열을 포함하고 있는 포맷인지 -> /product/123456789
var productUrlRegex = '(\/product\/)?+[0-9]+';
//숫자와 문자만 사용가능
var lnhRegex = /([A-Za-z0-9-]+)/gm;
*/