<%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/_header.jsp' %><%@ page import="jnit.cms.handler.*" %><%@ page import="jnit.com.util.CclUtil" %><%@ page import="jnit.cms.menu.JnitcmsmenuController" %><c:set var="handingType" value="TPL_000138" /><% /* cset_s */ %><% String servletPath = request.getServletPath(); %><% String[] Jnit_ServletPath = servletPath.split("/"); String Jnit_sitePath = Jnit_ServletPath[1]; %><c:set var="Jnit_sitePath" value="<%= Jnit_sitePath %>" scope="request"/><%@ page import="egovframework.com.utl.fcc.service.StringUtil"%><% String localYn = ""; if(StringUtil.isExistString(request.getRequestURL().toString(),"local")) localYn="Y"; %><c:set var="localYn" value="<%= localYn %>" scope="request" /><% /* cset_e */ %>

<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">



<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>

</head>

<body>
<div id="wrap" style="position:static;">   	
    <div id="accessibility"><a href="#content">본문 바로가기</a></div>
 
 
    <!-- End of header -->
	<!-- middle -->
	<!-- contaniner -->
	<%@ include file="/WEB-INF/jsp/travel/tpl/gnb.jsp" %>
		<div id="container" >
          
         <%@ include file="/WEB-INF/jsp/travel/tpl/navigation.jsp" %>
        <div id="content" class="cont_wrap ">
      
            <div class="cont_body content">
	           