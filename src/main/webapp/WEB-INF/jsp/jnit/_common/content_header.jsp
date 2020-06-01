<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="jnit.cms.AdminUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="/resources/js/jnit/filego.js"></script>
<script>
$(document).ready(function(){
	$('#manualOpen').click(function(e){
		e.preventDefault();
		/*
		var url = "http://ltskorea.co.kr/JNITCMS_manual.zip";
		window.open(url,"CMS메뉴얼", "width=721, height=900, toolbar=yes, scrollbars=yes");
		*/
		location.href="http://ltskorea.co.kr/JNITCMS_manual.zip";
	});
});
</script>
<div id="content-header">
	<div class="btn-group">
	<a href="<c:url value="/cms/"/>" title="첫 화면 (Start Page)" class="btn btn-large tip-bottom" data-original-title="HOME"><i class="icon-home"></i></a>
	<button id="manualOpen" class="btn btn-large tip-bottom" data-original-title="메뉴얼(manual)" target="_blank"><i class="icon-question"></i></button>
	<a href="<c:url value="/session/logout.do?returnUrl=/cms/"/>" title="로그아웃 (Logout)" class="btn btn-large tip-bottom" data-original-title="Logout"><i class="icon-off"></i></a>
	<c:if test="${isFilegoActive == 'on'}">
		<a href="#" id="filegoA" onclick="javascript:filegoPop();return false;" title="배포 로그" class="btn btn-large tip-bottom" data-original-title="HOME"><i class="icon-share"></i></a>
	</c:if>
	</div>
	<%
	request.setAttribute("menuName",AdminUtil.getMenuName(String.valueOf(request.getAttribute("menuId"))));
	%>
	<h2 class="left_title"><c:out value="${menuName}" /></h2>
</div>