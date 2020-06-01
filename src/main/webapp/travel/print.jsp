<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><c:set var="Jnit_sitePath" value="travel" /><%@ page import="jnit.cms.handler.*" %><%@ page import="jnit.com.util.CclUtil" %><%@ page import="jnit.cms.menu.JnitcmsmenuController" %><c:set var="Jnit_sitePath" value="${Jnit_sitePath}" scope="request"/><% /* cset_s */ %><% String servletPath = request.getParameter("path"); if(servletPath.lastIndexOf("index.jsp") == -1){ servletPath += "index.jsp";	} %><%@ page import="egovframework.com.utl.fcc.service.StringUtil"%><% String localYn = ""; if(StringUtil.isExistString(request.getRequestURL().toString(),"local")) localYn="Y"; %><c:set var="localYn" value="<%= localYn %>" scope="request" /><% /* cset_e */ %><% /*<!-- [-CONTENT-] -->*/ %><%
/**
 *@version 3.2.0.1
 **/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인쇄 페이지</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/travel/common/config/handing/cssHanding.jsp" %>
<link rel="stylesheet" type="text/css" href="/${Jnit_sitePath}/common/css/Jnit_print.css" media="all">
<script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js'/>"></script>
<%@ include file="/travel/common/config/handing/jsHanding.jsp" %>
</head>
<body>
	<div id="middle">
		<div class="content">
			<div class="print_content">
				<div class="print">
					<a href="#wrap" onclick="print(); return false;">
						인쇄<img src="${pageContext.request.contextPath }/resources/img/Jnit_text_print.gif" alt="화면 인쇄"/>
					</a>
					<a href="#" onclick="javascript:window.close();">
						<img src="${pageContext.request.contextPath }/travel/common/img/scrap_del.gif" alt="인쇄 닫기" width="26px"/>
					</a>
				</div>
				<div class="pagetitle">페이지 타이틀 : <%= CmsServletPathProperty.getProp(servletPath,"pageTitle") %></div>
				<div class="pagelinknav">페이지 링크형 네비 : <%= CmsServletPathProperty.getProp(servletPath,"pageLinkNav") %></div>
				<div class="print_boby">
					<script type="text/javascript">document.write($(".content", opener.document).html());</script>
				</div>
			</div>
		</div>
	</div>
</body>
</html><% /*<!-- /[-CONTENT-] -->*/ %>