
<%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/_header.jsp' %><%@ page import="jnit.cms.handler.*" %><%@ page import="jnit.com.util.CclUtil" %><%@ page import="jnit.cms.menu.JnitcmsmenuController" %><c:set var="handingType" value="TPL_000132" /><% /* cset_s */ %><% String servletPath = request.getServletPath(); %><% String[] Jnit_ServletPath = servletPath.split("/"); String Jnit_sitePath = Jnit_ServletPath[1]; %><c:set var="Jnit_sitePath" value="<%= Jnit_sitePath %>" scope="request"/><%@ page import="egovframework.com.utl.fcc.service.StringUtil"%><% String localYn = ""; if(StringUtil.isExistString(request.getRequestURL().toString(),"local")) localYn="Y"; %><c:set var="localYn" value="<%= localYn %>" scope="request" /><% /* cset_e */ %><%
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

 <!-- script -->
<%@ include file="/travel/common/config/handing/jsHanding.jsp" %>

</head>

<body>
<div id="wrap" style="position:static;">   	
    
    <jsp:include page="/travel/include/header/index.jsp"></jsp:include>
    <!-- End of header -->
	<!-- middle -->
	<!-- contaniner -->
		<div id="container" >
  
          <!-- 현재 컨텐츠 관리 lnb가 아닌 내부의 navigation.jsp파일을 사용하는중이다.navigation.jsp 파일 호출시 java 에러 -->
    
               
                 

