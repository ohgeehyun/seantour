<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000132_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %>
<%@ include file="/WEB-INF/jsp/travel/tpl/navigation.jsp" %>
<div style="margin:60px 0;text-align:center;"><img src="/images/travel/content/img_preparing.jpg" alt="준비중입니다" /></div>
<% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000132_E.jsp' %>
