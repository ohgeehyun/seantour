<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="header.jsp" %>
<c:if test="${loginVO == null}">
<script type="text/javascript">
$(document).ready(function(){
	alert("로그인 후 이용하세요.");
	location.href="<c:url value="/kr/siteinfo/0006"/>";	
});
</script>
</c:if>
<c:if test="${loginVO != null}">
<script type="text/javascript" src="<c:url value="/js/jquery.form.js" />"></script>
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
var fnc_signup = function() {  
	frm = document.getElementById("mbrForm");
	frm.action = "<c:url value='/mbr/modify_savembr.do'/>";
	
	if($("input[name=passwd]").val().length > 0) {
		if($("input[name=passwd]").val().length < 8
			|| $("input[name=passwd]").val().search('[0-9]') == -1
			|| $("input[name=passwd]").val().search('[a-z|A-Z]') == -1) {
			alert("비밀번호를 영문,숫자 조합 8~12자로 입력하세요.");
			$("input[name=passwd]").focus();
			return false;
		}
	}
	
	if($.trim($("input[name=email]").val()) == "" || !checkEmail($("input[name=email]").val())) {
		alert("이메일을 정확하게 입력하세요.");
		$("input[name=email]").focus();
		return false;
	}
	
	$("form#mbrForm").ajaxSubmit({
		success:function(data){
  			var resData = "";
  			eval("resData = " + $.trim(data));
 
  			if($.browser.msie == false) console.log(resData);
  
  			if(resData.status == "ok") {
  				alert("수정되었습니다.");
  				location.href=resData.next;
  			}else {
  				alert(resData.message);
  			}
	    }
	}); 
  
	return false;
};
var fnc_leave = function() {  
	frm = document.getElementById("mbrForm");
	frm.action = "<c:url value='/mbr/leave_out.do'/>";
	
	if($("input[name=passwd]").val().length > 0) {
		if($("input[name=passwd]").val().length < 8
			|| $("input[name=passwd]").val().search('[0-9]') == -1
			|| $("input[name=passwd]").val().search('[a-z|A-Z]') == -1) {
			alert("비밀번호를 영문,숫자 조합 8~12자로 입력하세요.");
			$("input[name=passwd]").focus();
			return false;
		}
	}
	if(confirm('정말 탈퇴하시겠습니까?\n\n계속 진행하시면 모든 회원정보가 삭제됩니다.')){
		if(confirm('삭제된 모든 데이터는 복구 할 수 없습니다.\n\n계속해서 진행하시겠습니까?')){
			$("form#mbrForm").ajaxSubmit({
				success:function(data){
		  			var resData = "";
		  			eval("resData = " + $.trim(data));
		  			if($.browser.msie == false) console.log(resData);
		  			if(resData.status == "ok") {
		  				alert("정상적으로 탈퇴되었습니다.");
		  				location.href="<c:url value='/'/>";
		  			}else {
		  				alert(resData.message);
		  			}
			    }
			});
		}
	}
  
	return false;
};

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
 
$(document).ready(function(){
	var tel = "<c:out value="${mbrVO.tel}"/>";
	var mobile = "<c:out value="${mbrVO.mobile}"/>";
	var postcode = "<c:out value="${mbrVO.postcode}"/>";
	
	var tels = tel.split("-");
	var mobiles = mobile.split("-");
	var posts = postcode.split("-");
	
	try {
		$('select[name=tel1]').val(tels[0]);
		$('input[name=tel2]').val(tels[1]);
		$('input[name=tel3]').val(tels[2]);
	}catch(e) {
		//
	}
	
	try {
		$('select[name=mobile1]').val(mobiles[0]);
		$('input[name=mobile2]').val(mobiles[1]);
		$('input[name=mobile3]').val(mobiles[2]);
	}catch(e) {
		//
	}
	
	try {
		$('input[name=post1]').val(posts[0]);
		$('input[name=post2]').val(posts[1]);
	}catch(e) {
		//
	}
});
</script>
<div style="height:20px;"></div>
<c:import url="/${site}/signup_step3.jsp"></c:import>
</c:if>