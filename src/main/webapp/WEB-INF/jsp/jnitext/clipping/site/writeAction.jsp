<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ include file="/WEB-INF/jsp/jnit/_common/init.jsp"%>
<script type="text/javascript">
location.replace("<c:out value="${searchVO.retUrl}" />?pageIndex=<c:out value="${searchVO.pageIndex}" />&searchKeyword=<c:out value="${searchVO.searchKeyword}" />&searchCondition=<c:out value="${searchVO.searchCondition}" />");
</script>