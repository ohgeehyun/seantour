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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("lf", "\n"); %>
<%@ page import = "org.springframework.web.context.*, org.springframework.web.context.support.*, jnit.visit.log.JnitvisitlogImportController, egovframework.com.utl.fcc.service.NullUtil, org.json.simple.*, java.util.TreeMap, org.json.simple.parser.JSONParser"%>
<%@ page import = "jnit.cms.*, jnit.cms.mbr.*, jnit.cms.handler.*, egovframework.com.cmm.service.EgovProperties, jnit.cms.config.ConfigUtil"%>
<% final String deDug = EgovProperties.getProperty("Globals.Debug"); %>
<%
WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletConfig().getServletContext());
CmsProperty cmsProperty = (CmsProperty)ctx.getBean("cmsProperty");
cmsProperty.setClientProperty(new CmsClientProperty());
CmsClientProperty cmsClientProperty = cmsProperty.getClientProperty();
cmsClientProperty.init(request);
request.setAttribute("ctxRoot",request.getContextPath());
//System.out.println(request);
//System.out.println("==>" + cmsClientProperty.request);
JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
%>
<% if(loginVO.getTypeId() == null) { %>
<script type="text/javascript">
/* TypeId is Null*/
	var request_uri = '<c:out value="${requestScope['javax.servlet.forward.request_uri']}" />';
	var context_path = '<c:out value="${requestScope['javax.servlet.forward.context_path']}" />';
	request_uri = request_uri.replace(context_path, '');

	location.replace('<c:url value="/cms/login.do"/>'+(request_uri ? '?returnUrl='+request_uri : ''));
</script>
<% return; } %>
<%
/* 관리자 레벨 */
final String admLevelProp = EgovProperties.getProperty(EgovProperties.getProperty("Webadm.Properties"), "Webadm.Levels");
final String[] admLevels = admLevelProp.split(",");
boolean loginAdmin = false;
for(int i1=0; i1<admLevels.length; i1++) {
	//System.out.println(admLevels[i1]);
        if(loginAdmin == false) {
                if(loginVO.getTypeVO().getTypeLv().equals(admLevels[i1])) {
                        loginAdmin = true;
                }
        }
}
if(!loginAdmin) { %>
<script type="text/javascript">
        var request_uri = '<c:out value="${requestScope['javax.servlet.forward.request_uri']}" />';
        var context_path = '<c:out value="${requestScope['javax.servlet.forward.context_path']}" />';
        request_uri = request_uri.replace(context_path, '');
        location.replace('<c:url value="/"/>');
</script>
<% return; } %>
<%
	String skinMode = ConfigUtil.getDefaultProp("skinMode");
%>
<c:set var="skinMode" value="<%= skinMode %>"/>
<c:set var="globalListThumb" value="true"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
	<title>JNITCMS</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--[if IE 7]>
		<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/ie7_main.css"/>" />
	<![endif]-->
	
	<%-- 기본(default) CSS --%>
	<c:if test="${empty skinMode || skinMode == 'default'}">
		<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/jnit.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/jnit.main.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/select.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/select2.css"/>" />
	</c:if>
	
	<%-- 블랙(balck) CSS --%>
	<c:if test="${skinMode == 'black'}">
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black//bootstrap.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/jnit.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/jnit.main.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/jquery-ui.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/select.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/select2.css"/>" />
	</c:if>
	
	<%-- 화이트(white) CSS --%>
	<c:if test="${skinMode == 'white'}">
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/bootstrap.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/jnit.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/jnit.main.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/jquery-ui.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/select.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/select2.css"/>" />
	</c:if>
	
	<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap-responsive.css"/>" />
	<link rel="stylesheet" href="<c:url value="/resources/css/jnit.dashboard.css"/>" />
	<link rel="stylesheet" href="<c:url value="/resources/css/calendar.css"/>" />
	<link rel="stylesheet" href="<c:url value="/resources/css/color_picker.css"/>" />
	<link rel="stylesheet" href="<c:url value="/resources/css/date_picker.css"/>" />
	
	<script src="<c:url value="/resources/js/jquery.min.js"/> "></script>
	
	<script type="text/javascript">
		var request_uri = '<c:out value="${requestScope['javax.servlet.forward.request_uri']}" />';
		var context_path = '<c:out value="${requestScope['javax.servlet.forward.context_path']}" />';
		request_uri = request_uri.replace(context_path, '');
		var menuId = '<c:out value="${menuId}" />';
	</script>
</head>

<body class="skeleton">
