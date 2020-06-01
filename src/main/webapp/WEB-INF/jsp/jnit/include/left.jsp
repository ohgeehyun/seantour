<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="common-left">
left
${isLogin }
	<c:if test="${loginVO != null }">
		${loginVO.mbrNm }님 환영합니다. <a href="<c:url value='/uat/uia/actionLogout.do'/>">로그아웃</a>
	</c:if>
	<c:if test="${loginVO == null }">
		<a href="<c:url value='/login.do'/>">로그인</a>
	</c:if>

</div>

<div class="common-body">