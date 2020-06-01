<!-- 
/**
 *@version 3.2.0.1
 **/
 -->
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/_common/header.jsp" %>
<script type='text/javascript'>
	<c:if test="${not empty alert}">
	alert('<c:out value="${alert}" />');
	</c:if>
</script>
<%-- 팝업용 
<c:if test="${closeWindow == 'true'}">
<script type="text/javascript">
	window.close();
</script>
</c:if>

<c:if test="${closeWindow != 'true'}">
<jsp:include page="/WEB-INF/jsp/jnit/research/userview/${page}.jsp" flush="false" />
</c:if>
--%>
<jsp:include page="/WEB-INF/jsp/jnit/research/userview/${page}.jsp" flush="false" />