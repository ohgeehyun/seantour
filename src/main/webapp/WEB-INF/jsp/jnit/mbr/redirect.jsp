<%
/**
 *@version 3.2.0.1
 **/
%>
<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0); 
if (request.getProtocol().equals("HTTP/1.1")) 
response.setHeader("Cache-Control", "no-cache"); 
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.plugins/jquery.ui.latest.custom.min.js"/> "></script>
<script type="text/javascript">
<!--
/*
var $pJquery = window.parent.$;	
var dialog = '<div id="dialog" title="페이지 이동중" style="text-align:center;"><br /><br /><img src="<c:url value="/images/loading01.gif"/>" /></div>';
if($pJquery('#dialog').length>0){
	$pJquery('#dialog').remove();
}
$pJquery('body').append(dialog);
$pJquery('#dialog').dialog({
	modal: true,
	close: function( event, ui ) {
		$pJquery(this).dialog('destroy').remove();
	}
});
*/
var data = '${result}';
var reJson = $.parseJSON(data);
if(reJson.status == 'ok'){
	alert('정상적으로 처리되었습니다.');	
	location.replace("${pageContext.request.contextPath }/"+reJson.site+reJson.next);
}else if(reJson.status == 'okModify'){
	alert('정상적으로 처리되었습니다.');	
	location.replace("${pageContext.request.contextPath }/"+reJson.site);
}else if(reJson.message == "FAIL0"){
	alert("만 19세 이상 고객만 가입가능합니다.");
	location.replace("/"+reJson.returnUrl);
}else if(reJson.message == "FAIL1"){
	alert("이미 가입된 사용자입니다.");
	location.replace("/"+reJson.returnUrl);
}else if(reJson.message == "FAIL2"){
	alert("실명인증 후 이용하세요.");
	location.replace("/"+reJson.returnUrl);
}else if(reJson.message == "FAIL6"){
	alert("로그인을 해주시기 바랍니다.");
	location.replace("/"+reJson.returnUrl);
}else if(reJson.message == "FAIL7"){
	alert("비회원 로그인은 회원가입을 해주시기 바랍니다.");
	location.replace("/"+reJson.returnUrl);
}else if(reJson.message == "OK"){
	location.href="../../"+reJson.returnUrl+reJson.next;
}else if(reJson.step == "1"){
	location.href=".."+reJson.returnUrl+"/mbr/signup.jsp";
}else if(reJson.step == "2"){
	location.href=".."+reJson.returnUrl+"/mbr/signupAdd.jsp";
}else if(reJson.step == "3"){
	location.href=".."+reJson.returnUrl+"/mbr/signupSuccess.jsp";
}else if(reJson.step == "4"){
	location.href=".."+reJson.returnUrl+"/mbr/myPage.jsp";
}else if(reJson.step == "5"){
	location.href=".."+reJson.returnUrl+"/mbr/memberCancel.jsp";
}else{
	alert(reJson.message);	
	location.href="../"+reJson.site;
}
//-->
</script>