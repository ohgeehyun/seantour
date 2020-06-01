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
<%@ taglib prefix="jtag" uri="/WEB-INF/tlds/jnittag.tld"%>
<%@ page import="jnit.site.state.JnitSiteStateUtil, java.util.HashMap" %>
<%
/* site state count*/
String sitePath = request.getServletPath();
sitePath = sitePath.split("/")[1];
String total = "0";
String today = "0";
String yesterday = "0";

try{	   
	JnitSiteStateUtil.siteStateCount(sitePath);
	HashMap<String, String> stateMap = JnitSiteStateUtil.getTotalSiteCount(sitePath);
	total = stateMap.get("total");
	today = stateMap.get("today");
	yesterday = stateMap.get("yesterday");
}catch(Exception e){
	total = "0";
	today = "0";
	yesterday = "0";
}
%>

<c:set var="total" value="<%=total%>" />
<c:set var="today" value="<%=today%>" />
<c:set var="yesterday" value="<%=yesterday%>" />