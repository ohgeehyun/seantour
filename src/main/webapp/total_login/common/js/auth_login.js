var authGpin = function() {
	if(checkAgree() == true){
		var retType = $('#retType').val();
		var returnUrl = $("#returnUrl").val();
		var retParam = $("#retParam").val();		
		msg = window.open("http://cms-cubrid.jnit.kr/total_login/gpin.jsp?retParam="+retParam+"&returnUrl="+returnUrl+"&retType="+retType, "GPINAuth", "width=450,height=630");
	}
}

function ncIpin(){
	if(checkAgree() == true){
		var retParam  = "";
		if($("#retParam").val() != null || $("#retParam").val() != '' ){
			retParam = $("#retParam").val();
		}	
		
		var agree = "";
		if($("#agree02:checked").size() > 0 ){
			agree = "true";
		}		
		
		var retType = "";
		if($("#retType").val() != null || $("#retType").val() != '' ){
			retType = $("#retType").val();
			if(retType == 'group'){
				retParam = "group";
			}else if(retType == 'kid'){
				retParam = "kid";
			}			
		}
		
		//alert("retParam : "+retParam+ " agree : "+agree + "retType : "+retType);
		//window.open('http://ygpa.jnit.kr/ipin/ipin_main.jsp?retParam='+retParam+'&returnUrl='+$("#mbrLoginForm input[name=returnUrl]").val()+"&retAgree="+agree+"&retType="+retType, 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		window.open('https://www.ygpa.or.kr/ipin/ipin_main.jsp?retParam='+retParam+'&returnUrl='+$("#mbrLoginForm input[name=returnUrl]").val()+"&retAgree="+agree+"&retType="+retType, 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	}
}

function ncIpinIdfind(){
	//window.open('http://ygpa.jnit.kr/ipin/ipin_main.jsp?retParam=idFind&returnUrl='+$("#returnUrl").val(), 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	window.open('https://www.ygpa.or.kr/ipin/ipin_main.jsp?retParam=idFind&returnUrl='+$("#returnUrl").val(), 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
}

function ncIpinPwfind_bln(){
	var mbrLogin = $("#mbrLogin").val();
	if(mbrLogin == '' || mbrLogin == null){
		alert("아이디를 입력해주시기 바랍니다.");
		$("#mbrLogin").focus();
		return false;
	}
	return true;
}

function ncIpinPwfind(){	
	//window.open('http://ygpa.jnit.kr/ipin/ipin_main.jsp?retParam=pwFind&returnUrl='+$("#returnUrl").val(), 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	var mbrLogin = $("#mbrLogin").val();
	
	if(ncIpinPwfind_bln()){
		window.open('https://www.ygpa.or.kr/ipin/ipin_main.jsp?retParam=pwFind&returnUrl='+$("#returnUrl").val()+"&mbrLogin="+mbrLogin, 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	}	
}

var authGpinPwfind = function() {
	searchPw("gpin");
}

var authGpinIdfind = function() {
	searchId("gpin");
}


var authNc = function() {
	msg = window.open("http://cms-cubrid.jnit.kr/total_login/nc.jsp?retParam=login&returnUrl="+$("#mbrLoginForm input[name=returnUrl]").val(), "NCAuth", "width=630,height=600");
}

var authNcPwfind = function() {
	searchPw("nc");
}

var authNcIdfind = function() {
	searchId("nc");
}


var authSi = function() {	
	if(checkAgree() == true){
		msg = window.open("http://cms-cubrid.jnit.kr/total_login/si.jsp?retParam=login&returnUrl="+$("#mbrLoginForm input[name=returnUrl]").val(), "SiAuth", "width=630,height=600");
	}
}

var authSiPwfind = function() {
	searchPw("sn");
}

var authSiIdfind = function() {
	searchId("sn");
}

var authSignReg = function() {
	if(checkAgree() ==true){
		if($('#ppname').val() == "") {
			alert("성명을 입력하세요");
			$('#ppname').focus();
			return;
		}
		if($('#ppnum01').val().length != 6 || $('#ppnum02').val().length != 7) {
			alert("주민등록번호를 정확하게 입력하세요");
			$('#ppnum01').focus();
			return;
		}
		
		$('#signname').val( $('#ppname').val() );
		$('#comNo').val("");
		$('#regNo').val($('#ppnum01').val()+""+$('#ppnum02').val());
		$('#signForm #returnUrl').val($("#mbrLoginForm input[name=returnUrl]").val());

		IDNCheck('signForm', $('#regNo').val());
	}	
}

var authSignCom = function() {
	if(checkAgree() ==true){
		if($('#cpname').val() == "") {
			alert("사업자명을 입력하세요");
			$('#cpname').focus();
			return;
		}
		if($('#cpnum01').val().length != 3 || $('#cpnum02').val().length != 2 || $('#cpnum03').val().length != 5) {
			alert("사업자번호를 정확하게 입력하세요");
			$('#cpnum01').focus();
			return;
		}

		$('#signname').val( $('#cpname').val() );
		$('#regNo').val("");
		$('#comNo').val($('#cpnum01').val()+""+$('#cpnum02').val()+""+$('#cpnum03').val());
		$('#signForm #returnUrl').val($("#mbrLoginForm input[name=returnUrl]").val());
		
		/*IDNCheck('signForm', $('#comNo').val());*/
		
		document.signForm.action="/sign_res.jsp";
		document.signForm.submit();
		
	}	
}

function checkConfirm(){
	if(checkAgree() ==true){
		$('#checkConfirm').show();
	}	
}

function checkAgree(){
	var checkAgree = $('#checkAgree').val();	
	if(checkAgree == 'ok'){
		if($("input#agree:checked").size() == 0){
			 alert('약관에 동의해주세요');
			 $("#agree").focus();
			 return false;
		}	
		return true;
	}else{		
		return true;
	}	
}

function prop(){
	document.getElementById("mbrLoginForm").action = "/config/ckdefault.do";
	document.getElementById("mbrLoginForm").submit();
}

function Jnit_authDefault(){
	if(checkAgree()){
		document.getElementById("mbrLoginForm").action = "signupAdd.jsp";
		document.getElementById("mbrLoginForm").method = "get";
		document.getElementById("mbrLoginForm").submit();
	}	
}
