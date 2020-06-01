/**
 * search pw process
 */

var CBA_window;
var searchPw = function(snType) {
	if( $.trim( $('input#mbrLogin').val() ) == "" ) {
		alert("아이디를 입력하세요.");
		 $('input#mbrLogin').focus();
		return;
	}

	$.cookie("searchpwMbrLogin", $.trim( $('input#mbrLogin').val() ), { path: '/' });

	if(snType == "sn") {
		CBA_window = window.open('/total_login/si.jsp?retParam=searchpw', 'CbaWindow', 'width=500, height=650, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
	}
	if(snType == "gpin") {
		GPIN_window = window.open('/total_login/gpin.jsp?retParam=searchpw', 'gPinLoginWin', 'width=360, height=120, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
	}
	if(snType == "nc") {
		NC_window = window.open('/total_login/nc.jsp?retParam=searchpw', 'NcWindow', 'width=500, height=650, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
	}
}

var searchId = function(snType) {
	if(snType == "sn") {
		CBA_window = window.open('/total_login/si.jsp?retParam=searchid', 'CbaWindow', 'width=500, height=650, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
	}
	if(snType == "gpin") {
		GPIN_window = window.open('/total_login/gpin.jsp?retParam=searchid', 'gPinLoginWin', 'width=360, height=120, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
	}
	if(snType == "nc") {
		NC_window = window.open('/total_login/nc.jsp?retParam=searchid', 'NcWindow', 'width=500, height=650, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
	}
}

var searchIdRes  = function() {
	location.href="/total_login/sc_login/id_find/";
	//var msg=window.open('/kr/siteinfo/0013/','pwbox','width=326,height=250,left=100,top=50');
}

var changePw = function() {
	location.href="/total_login/sc_login/pw_find/";
	//var msg=window.open('/kr/siteinfo/0013/','pwbox','width=326,height=250,left=100,top=50');
}
function checkPwChange_bln(){
	if($("#mbrLogin").val() == ""){
		alert("아이디를 입력해주세요");
		return false;
	}
  	if($.trim($('input#passwd').val()) == "") {
  		alert("변경할 새로운 패스워드를 입력하세요.");
  		return false;
  	}
  
  	if($.trim($('input#passwdConfirm').val()) == "") {
  		alert("패스워드확인를 입력하세요.");
  		return false;
  	}
  
  	if($.trim($('input#passwd').val()) != $.trim($('input#passwdConfirm').val())) {
  		alert("새로운 패스워드와 패스워드확인이 일치하지 않습니다.");
  		return false;  
  	}
  	return true;
}

var checkPwChange = function() {
	if(checkPwChange_bln()){
		changePwConfirm();
	} 
}

var changePwConfirm = function() {
	$.ajax({
		  url:"/mbr/isMbr.do",
		  type:"POST",
		  cache:false,
		  data: { mbrLogin: $('input[name=mbrLogin]').val(),
				  passwd: $('input[name=passwd]').val()
		  },
		  error: function(data) {
				//alert("error code:" + data.status);
		  },
		  success:function(data) {
				var ret = $.trim(data);
				if(ret == 'FAIL1' || ret == 'FAIL2' || ret == 'FAIL3') {
					alert('담당자에게 문의바랍니다.');
				}

				if(ret == 'FAIL4') {
					alert('입력하신 아이디['+$('input[name=mbrLogin]').val()+']와 본인확인 정보가 일치하지 않습니다.\n\n담당자에게 문의바랍니다.');
				}

				if(ret == 'FAIL5') {
					alert('시스템오류가 발생했습니다. 담당자에게 문의바랍니다.');
				}

				if(ret == 'OK') {
					alert("변경되었습니다.");
					location.href = "/kr";
					//self.close();
				}

				if(ret == 'OK1') {
					alert("변경되었습니다.");
					location.href = "/kr";
					//self.close();
				}
		  }
	});
}

function Jnit_authDefaultIdfind_bln(){
	var mbrNm = $("#mbrNm").val();
	var email = $("#email").val();
	if(mbrNm == '' || mbrNm == null){
		alert("이름을 입력해주시기 바랍니다.");
		$("#mbrNm").focus();
		return false;		
	}else if(email == '' || email == null){
		alert("이메일을 입력해주시기 바랍니다.");
		$("#email").focus();
		return false;
	}
	return true;
}

function Jnit_authDefaultIdfind(){
	var localYn = $("#localYn").val();	
	if(Jnit_authDefaultIdfind_bln()){
		$.ajax({
			type:"post",
			url: (localYn == 'Y' ? "../.." : "")+"/searchIdFind.do",
			data:$("#idFindForm").serialize()
		}).done(function(data){			
			var json = $.parseJSON(data);			
			/*
			if(json.message != ''){
				$("#defaultId").empty();
				$("#defaultId").append(json.message);
				$("#Jnit_defaultResult").css("display","block");
			}
			*/
			location.href = "noSetpIdResult.jsp?result="+json.message+"&localYn="+localYn;
		});
	}
}

function Jnit_authDefaultPwfind_bln(){
	var mbrLogin = $("#mbrLogin").val();
	if(mbrLogin == '' || mbrLogin == null){
		alert("아이디를 입력해 주시기 바랍니다.");
		$("#mbrLogin").focus();
		return false;
	}
	return true;
}

function Jnit_authDefaultPwfind(){
	var localYn = $("#localYn").val();
	if(Jnit_authDefaultPwfind_bln()){
		$.ajax({
			type:"post",
			url: (localYn == 'Y' ? "../.." : "")+"/searchPwFind.do",
			data:$("#pwFindForm").serialize()
		}).done(function(data){			
			var json = $.parseJSON(data);
			if(json.status == 'success'){
				location.href = "noSetpPwResult.jsp?result="+json.message+"&localYn="+localYn;
				//location.href=json.redirect+"/login.jsp";
			}else{
				alert(json.message);
			}	
		});
	}
}