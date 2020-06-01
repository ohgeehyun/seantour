<%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/_header.jsp' %><%@ page import="jnit.cms.handler.*" %><%@ page import="jnit.com.util.CclUtil" %><%@ page import="jnit.cms.menu.JnitcmsmenuController" %><c:set var="handingType" value="TPL_000111" /><% /* cset_s */ %><% String servletPath = request.getServletPath(); %><% String[] Jnit_ServletPath = servletPath.split("/"); String Jnit_sitePath = Jnit_ServletPath[1]; %><c:set var="Jnit_sitePath" value="<%= Jnit_sitePath %>" scope="request"/><%@ page import="egovframework.com.utl.fcc.service.StringUtil"%><% String localYn = ""; if(StringUtil.isExistString(request.getRequestURL().toString(),"local")) localYn="Y"; %><c:set var="localYn" value="<%= localYn %>" scope="request" /><% /* cset_e */ %><%
/**
 *@version 3.2.0.1
 **/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%= JnitcmsmenuController.getMenuJSON("pageNavTitle") %></title>
<%@ include file="/travel/common/config/handing/metaHanding.jsp" %>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/travel/common/config/handing/cssHanding.jsp" %>

<script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/jquery.ui/js/jquery-ui-1.9.0.custom.min.js'/>"></script>
 <!-- script -->
<%@ include file="/travel/common/config/handing/jsHanding.jsp" %>
</head>

<body>
<div id="wrap">
	<!-- header -->
	<div id="header">
    	<ul class="util">
    		<li><a href="${pageContext.request.contextPath }/${Jnit_sitePath}">HOME</a></li>
    		<c:if test="${loginVO.mbrId == null }">
	        	<li><a href="${pageContext.request.contextPath }/${Jnit_sitePath}/login.jsp">로그인</a></li>	            
            </c:if>
            <c:if test="${loginVO.mbrId != null }">
	        	<li><a href="${pageContext.request.contextPath }/uat/uia/actionLogout.do">로그아웃</a></li>
	            <li><a href="${pageContext.request.contextPath }/${Jnit_sitePath}/mbr/myPage.jsp">마이페이지</a></li>
        		<li><a href="javascript:Jnit_workspace('<c:url value="/disseminate/workspace.do?mode=pop&sitePath=${Jnit_sitePath }"/>');" title="새 창으로 열립니다.">내업무함</a></li>
	            <li><a href="#" onclick="window.open('${pageContext.request.contextPath }/sms/view/page.do', 'CLIENT_WINDOW', 'resizable=yes scrollbars=no width=1040 height=725');" title="새 창으로 열립니다.">SMS</a></li>
            </c:if>
        </ul>
    	<p class="header_txt">HEADER</p>
    </div>
    <!-- End of header -->
	<!-- middle -->
	<div id="middle">    	
    	<jsp:include page="/cms/import/getSubMenu.jsp"></jsp:include>        	
        
        <div class="content_group">
        	<div class="content_top">
            	<h3><%= CmsServletPathProperty.getProp(servletPath,"pageTitle") %></h3>
				<%= JnitcmsmenuController.getMenuJSON("pageLinkNav") %>
				<ul class="content_util">
					<li class="content_text">
				    	<p><a href="#"><img src="${pageContext.request.contextPath }/travel/common/img/Jnit_text_big.gif" alt="글씨 크게" /></a></p>
				    	<p><a href="#"><img src="${pageContext.request.contextPath }/travel/common/img/Jnit_text_small.gif" alt="글씨 작게" /></a></p>
				        <p><a href="#wrap" onclick="pagePrint(); return false;"><img src="${pageContext.request.contextPath }/travel/common/img/Jnit_text_print.gif" alt="화면 인쇄" /></a></p>
				    	<p><a href="#" onclick="addScrap();"><img src="${pageContext.request.contextPath }/travel/common/img/Jnit_text_scrap.gif" alt="스크랩" /></a></p>
				    </li>
				   
					<li class="content_sns">
				    	<p class="twitter"><a href="#" target="_blank" title="새창에서 열립니다."><img src="${pageContext.request.contextPath }/travel/common/img/Jnit_content_twitter.gif" alt="내용을 트위터로 공유하기" /></a></p>
				    	<p class="facebook"><a href="#" target="_blank" title="새창에서 열립니다."><img src="${pageContext.request.contextPath }/travel/common/img/Jnit_content_facebook.gif" alt="내용을 페이스북으로 공유하기" /></a></p>				    	
				    	<p class="kakaostory"><a href="#" target="_blank" title="새창에서 열립니다."><img src="${pageContext.request.contextPath }/resources/img/kakaostory/story_pc_24x24.png" alt="내용을 카카오스토리로 가져가기" /></a></p>
				    </li>
				</ul>
            </div>
            
            <div class="content">
            <!-- Sample S 이상 -->
