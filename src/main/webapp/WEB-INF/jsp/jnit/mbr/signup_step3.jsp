<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="header.jsp" %>
<script type="text/javascript" src="<c:url value="/js/jquery.form.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.alphanumeric.pack.js" />"></script>
<script type="text/javascript">
function open_post(){
	var winUrl = "/gis/zip.do?retForm=mbrForm";
	winUrl += "&retZip=zip";
	winUrl += "&retAddr=address03";
	winUrl += "&retAddrDetail=address04";
//	winUrl += "&retSido=ctprvn";
//	winUrl += "&retGugun=gugun";
//	winUrl += "&retDong=emd";
	winUrl += "&retFunction=afterAddress";

	var winZip = window.open(winUrl,"windowZip","width=500,height=400,top=0,left=0");
	winZip.focus();
}
function afterAddress(){
	if($('input[name=zip]').val() != ""){
		var zip = $('input[name=zip]').val().split("-");
		var zip1= zip[0];
		var zip2= zip[1];
		$('input[name=post1]').val(zip1);
		$('input[name=post2]').val(zip2);
	}
	//상세주소 처리

	var addrDetail = "";
	if($('input[name=addr]').val().search("\\(|\\~") > -1) {
		var addrArr = $('input[name=addr]').val().split(" ");
		for(i=0;i<addrArr.length-1;i++){
			if( $.trim(addrArr[i]) != "") {
				addrDetail += $.trim(addrArr[i]) + " ";
			}
		}
	}else {
		addrDetail = $('input[name=addr]').val();
	}

	$('input[name=addr]').val( $.trim(addrDetail) + " " + $('input[name=address04]').val() );
}
</script>
<script type="text/javascript">

var isIdChecked = false;

var fnc_signup = function() {
	if($("input[name=mbrNm]").val() == "") {
		alert("성명을 입력하세요.");
		$("input[name=mbrNm]").focus();
		return false;
	}
  
	if($("input[name=mbrLogin]").val() == "") {
		alert("아이디를 입력하세요.");
		$("input[name=mbrLogin]").focus();
		return false;
	}

	if($("input[name=passwd]").val() == "") {
		alert("비밀번호를 입력하세요.");
		$("input[name=passwd]").focus();
		return false;
	}

	if($("input[name=passwdConfirm]").val() == "") {
		alert("비밀번호확인을 입력하세요.");
		$("input[name=passwdConfirm]").focus();
		return false;
	}
	
	if($("input[name=passwd]").val().length < 8
		|| $("input[name=passwd]").val().search('[0-9]') == -1
		|| $("input[name=passwd]").val().search('[a-z|A-Z]') == -1) {
		alert("비밀번호를 영문,숫자 조합 8~12자로 입력하세요.");
		$("input[name=passwd]").focus();
		return false;
	}
	
	if($.trim($("input[name=email]").val()) == "" || !checkEmail($("input[name=email]").val())) {
		alert("이메일을 정확하게 입력하세요.");
		$("input[name=email]").focus();
		return false;
	}

	if(isIdChecked == false) {
		alert("아이디 중복확인을 해주세요.");
		return false;
	}
	
	$("input[name=mbrLogin]").val( $("input[name=mbrLogin]").val().toLowerCase() );
	
	frm = document.getElementById("mbrForm");
	frm.action = "<c:url value='/mbr/signup_savembr.do'/>";
	
	$("form#mbrForm").ajaxSubmit({
		success:function(data){
  			var resData = "";
  			eval("resData = " + $.trim(data));
 
  			if($.browser.msie == false) console.log(resData);
  
  			if(resData.status == "ok") {
  				alert("가입되었습니다.");
  				location.href=resData.next;
  			}else {
  				alert(resData.message);
  			}
	    }
	}); 
  
	return false;
}

function checkEmail(emailStr) {
    if (emailStr.length == 0) {
        return true;
    }
    var emailPat=/^(.+)@(.+)$/;
    var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]";
    var validChars="\[^\\s" + specialChars + "\]";
    var quotedUser="(\"[^\"]*\")";
    var ipDomainPat=/^(\d{1,3})[.](\d{1,3})[.](\d{1,3})[.](\d{1,3})$/;
    var atom=validChars + '+';
    var word="(" + atom + "|" + quotedUser + ")";
    var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
    var domainPat=new RegExp("^" + atom + "(\\." + atom + ")*$");
    var matchArray=emailStr.match(emailPat);
    if (matchArray == null) {
        return false;
    }
    var user=matchArray[1];
    var domain=matchArray[2];
    if (user.match(userPat) == null) {
        return false;
    }
    var IPArray = domain.match(ipDomainPat);
    if (IPArray != null) {
        for (var i = 1; i <= 4; i++) {
           if (IPArray[i] > 255) {
              return false;
           }
        }
        return true;
    }
    var domainArray=domain.match(domainPat);
    if (domainArray == null) {
        return false;
    }
    var atomPat=new RegExp(atom,"g");
    var domArr=domain.match(atomPat);
    var len=domArr.length;
    if ((domArr[domArr.length-1].length < 2) ||
        (domArr[domArr.length-1].length > 3)) {
        return false;
    }
    if (len < 2) {
        return false;
    }
    return true;
 }

var idCheck = function() {
	$("input[name=mbrLogin]").val( $("input[name=mbrLogin]").val().toLowerCase() );
	
	$.ajax({
		url:"<c:url value="/mbr/idcheck.do" />",
		type:"POST",
		cache:false,
		data: { site:"<c:out value="${param.site}"/>", mbrLogin:$('input[name=mbrLogin]').val() },
		success:function(data) {
  			var resData = "";
  			eval("resData = " + $.trim(data));
 
  			if($.browser.msie == false) console.log(resData);
  
  			if(resData.status == "ok") {
  				isIdChecked = true;
  				alert(resData.message);
  			}else {
  				isIdChecked = false;
  				alert(resData.message);
  			}			
		}		
	});
}

$(document).ready(function(){
	$('#mbrForm input[rel=numeric]').numeric();
	$('#mbrForm input[rel=numeric]').css("ime-mode", "disabled");
	
	$('#mbrForm input[rel=alpha]').alpha();
	$('#mbrForm input[rel=alpha]').css("ime-mode", "disabled");
	
	$('#mbrForm input[rel=alphanumeric]').alphanumeric();
	$('#mbrForm input[rel=alphanumeric]').css("ime-mode", "disabled");
	
	$.ajax({
		url:"<c:url value="/mbr/isMbrSn.do" />",
		type:"POST",
		cache:false,
		data: {},
		success:function(data) {
  			var resData =  $.trim(data);
 
  			if($.browser.msie == false) console.log(resData);
  			if(resData == "FAIL0") {
  				alert("만19세 이상 고객만 가입가능합니다.");
  				location.replace("/");
  				return;
  			}
  			if(resData == "FAIL1") {
  				alert("이미 가입된 사용자입니다.");
  				location.replace("/");
  				return;
  			}
  			if(resData == "FAIL2") {
  				alert("실명인증 후 이용하세요.");
  				location.replace("/");
  				return;
  			}
		}		
	});
});
</script>
<c:if test="${!empty sessionScope.snAuth.dp}">
<c:import url="/${site}/signup_step3.jsp"></c:import>
</c:if>