<%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/_header.jsp' %><%@ page import="jnit.cms.handler.*" %><%@ page import="jnit.com.util.CclUtil" %><%@ page import="jnit.cms.menu.JnitcmsmenuController" %><c:set var="handingType" value="TPL_000137" /><% /* cset_s */ %><% String servletPath = request.getServletPath(); %><% String[] Jnit_ServletPath = servletPath.split("/"); String Jnit_sitePath = Jnit_ServletPath[1]; %><c:set var="Jnit_sitePath" value="<%= Jnit_sitePath %>" scope="request"/><%@ page import="egovframework.com.utl.fcc.service.StringUtil"%><% String localYn = ""; if(StringUtil.isExistString(request.getRequestURL().toString(),"local")) localYn="Y"; %><c:set var="localYn" value="<%= localYn %>" scope="request" /><% /* cset_e */ %><%
/**
 *@version 3.2.0.1
 **/
%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title><%= JnitcmsmenuController.getMenuJSON("pageNavTitle") %></title>
<%@ include file="/travel/common/config/handing/metaHanding.jsp" %>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<%@ include file="/travel/common/config/handing/cssHanding.jsp" %>

<script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/jquery.ui/js/jquery-ui-1.9.0.custom.min.js'/>"></script>
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
          
        <jsp:include page="/travel/include/lnb03/index.jsp"></jsp:include>
         
        <div id="content" class="cont_wrap ">
      
            <div class="cont_body content">
	           
                 
