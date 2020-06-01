<%-- 2020-5-21 10시 28분 by.메인템플릿에서 수정되었습니다. 헤더 핸들링 파일입니다. 직접수정하지 말아주시기 바랍니다. --%>
<%@ page import="jnit.cms.mgmt.mgmtUtil" %>
<% String cssUrl = (String)request.getAttribute("javax.servlet.forward.request_uri");if(cssUrl == null) cssUrl = request.getServletPath().toString();if(pageContext.getAttribute("handingType") != null) cssUrl = pageContext.getAttribute("handingType").toString(); %>
<% if(mgmtUtil.isExistJSON(cssUrl,"base","css","travel" )){ %><link type="text/css" href="${pageContext.request.contextPath}/travel/common/css/base.css" media='all' rel='stylesheet' /><% } %>
<% if(mgmtUtil.isExistJSON(cssUrl,"font","css","travel" )){ %><link type="text/css" href="${pageContext.request.contextPath}/travel/common/css/font.css" media='all' rel='stylesheet' /><% } %>
<% if(mgmtUtil.isExistJSON(cssUrl,"common","css","travel" )){ %><link type="text/css" href="${pageContext.request.contextPath}/travel/common/css/common.css" media='all' rel='stylesheet' /><% } %>
<% if(mgmtUtil.isExistJSON(cssUrl,"main","css","travel" )){ %><link type="text/css" href="${pageContext.request.contextPath}/travel/common/css/main.css" media='all' rel='stylesheet' /><% } %>
<% if(mgmtUtil.isExistJSON(cssUrl,"board","css","travel" )){ %><link type="text/css" href="${pageContext.request.contextPath}/travel/common/css/board.css" media='all' rel='stylesheet' /><% } %>
<% if(mgmtUtil.isExistJSON(cssUrl,"content","css","travel" )){ %><link type="text/css" href="${pageContext.request.contextPath}/travel/common/css/content.css" media='all' rel='stylesheet' /><% } %>
<% if(mgmtUtil.isExistJSON(cssUrl,"slick","css","travel" )){ %><link type="text/css" href="${pageContext.request.contextPath}/travel/common/css/slick.css" media='all' rel='stylesheet' /><% } %>
<% if(mgmtUtil.isExistJSON(cssUrl,"map","css","travel" )){ %><link type="text/css" href="${pageContext.request.contextPath}/travel/common/css/map.css" media='all' rel='stylesheet' /><% } %>
<% if(mgmtUtil.isExistJSON(cssUrl,"aos","css","travel" )){ %><link type="text/css" href="${pageContext.request.contextPath}/travel/common/css/aos.css" media='all' rel='stylesheet' /><% } %>
<% if(mgmtUtil.isExistJSON(cssUrl,"font-awesome.min","css","travel" )){ %><link type="text/css" href="${pageContext.request.contextPath}/travel/common/css/font-awesome.min.css" media='all' rel='stylesheet' /><% } %>
<% if(mgmtUtil.isExistJSON(cssUrl,"landing","css","travel" )){ %><link type="text/css" href="${pageContext.request.contextPath}/travel/common/css/landing.css" media='all' rel='stylesheet' /><% } %>
<% if(mgmtUtil.isExistJSON(cssUrl,"landing.mosaic","css","travel" )){ %><link type="text/css" href="${pageContext.request.contextPath}/travel/common/css/landing.mosaic.css" media='all' rel='stylesheet' /><% } %>
