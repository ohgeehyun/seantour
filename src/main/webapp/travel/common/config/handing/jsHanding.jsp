<%-- 2020-4-16 10시 48분 by.메인템플릿에서 수정되었습니다. 헤더 핸들링 파일입니다. 직접수정하지 말아주시기 바랍니다. --%>
<%@ page import="jnit.cms.mgmt.mgmtUtil" %>
<% String jsUrl = (String)request.getAttribute("javax.servlet.forward.request_uri");if(jsUrl == null) jsUrl = request.getServletPath().toString();if(pageContext.getAttribute("handingType") != null) jsUrl = pageContext.getAttribute("handingType").toString(); %>
<% if(mgmtUtil.isExistJSON(jsUrl,"jquery.min","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/jquery.min.js"></script><% } %>
<% if(mgmtUtil.isExistJSON(jsUrl,"Jnit_print","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/Jnit_print.js"></script><% } %>
<% if(mgmtUtil.isExistJSON(jsUrl,"kakao.min","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/kakao.min.js"></script><% } %>
<% if(mgmtUtil.isExistJSON(jsUrl,"jquery-ui.min","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/jquery-ui.min.js"></script><% } %>
<% if(mgmtUtil.isExistJSON(jsUrl,"jquery-1.12.2.min","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/jquery-1.12.2.min.js"></script><% } %>
<% if(mgmtUtil.isExistJSON(jsUrl,"TweenMax.min","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/TweenMax.min.js"></script><% } %>
<% if(mgmtUtil.isExistJSON(jsUrl,"jquery.bxslider","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/jquery.bxslider.js"></script><% } %>
<% if(mgmtUtil.isExistJSON(jsUrl,"aos","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/aos.js"></script><% } %>
<% if(mgmtUtil.isExistJSON(jsUrl,"Sortable","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/Sortable.js"></script><% } %>
<% if(mgmtUtil.isExistJSON(jsUrl,"slick.min","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/slick.min.js"></script><% } %>
<% if(mgmtUtil.isExistJSON(jsUrl,"common","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/common.js"></script><% } %>
<% if(mgmtUtil.isExistJSON(jsUrl,"content","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/content.js"></script><% } %>
<% if(mgmtUtil.isExistJSON(jsUrl,"main","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/main.js"></script><% } %>
<% if(mgmtUtil.isExistJSON(jsUrl,"slick","js","travel")){ %><script type="text/javascript" src="${pageContext.request.contextPath}/travel/common/js/slick.js"></script><% } %>
