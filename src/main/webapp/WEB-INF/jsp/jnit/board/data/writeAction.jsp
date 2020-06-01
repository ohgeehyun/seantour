<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/init.jsp" %>
<script typt="text/javascript">
<c:choose>
	<c:when test="${isSuccess}">
alert("처리되었습니다.");
location.replace("${retUrl}");
	</c:when>
	<c:otherwise>
alert("<c:out value="${msg}" />");
history.back();
	</c:otherwise>
</c:choose>
</script>