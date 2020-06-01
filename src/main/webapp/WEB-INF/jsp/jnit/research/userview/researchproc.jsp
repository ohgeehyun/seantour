<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/board/header.jsp" %>
<form:form commandName="searchVO" name="researchForm" id="researchForm" method="get" action="?">
<!-- 검색조건 유지 -->
<input type="hidden" name="mode" id="mode" value="entry" />
<input type="hidden" name="researchId" id="researchId" value="${researchId}" />
</form:form>
<script type="text/javascript">
<!--
<c:if test="${setCookie == 'true'}">
var todayDate = new Date();
todayDate.setDate(todayDate.getDate() + 1);
document.cookie = "entry_research_${researchId}=" + escape("참여") + ";"+ "path=/"+";"+ "expires=" + todayDate.toUTCString() + ";";

</c:if>
		alert("<c:out value="${modeStr}" />");
		document.getElementById("researchForm").submit();
// -->
</script>