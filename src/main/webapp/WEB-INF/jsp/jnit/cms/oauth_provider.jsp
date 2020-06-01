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

<html>
<body onload="postit();">
<!--  <body> -->
<form name="auth" method="get" action="https://www.facebook.com/dialog/oauth">
<input type="hidden" name="client_id" value="<c:out value="${appID}" />" />
<input type="hidden" name="redirect_uri" value="<c:out value="${callbackUrl}" />" />
<input type="hidden" name="scope" value="<c:out value="${scope}" />" />
</form>
<script type="text/javascript">function postit(){ document.auth.submit(); }</script>
</body></html>
