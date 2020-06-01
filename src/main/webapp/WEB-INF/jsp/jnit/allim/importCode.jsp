<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:if test="${type == 'allim' || type == 'popup' }">
<textarea style="width: 97%" rows="8">&lt;jsp:include page="/WEB-INF/jsp/jnit/allim/make/${type}/${groupId}.jsp" flush="false" &gt;&lt;/jsp:include&gt;</textarea>
</c:if>

<c:if test="${type == 'banner' }">
<textarea style="width: 97%" rows="15">
<!-- 배너 -->
&lt;jsp:include page="/WEB-INF/jsp/jnit/allim/make/${type}/${groupId}.jsp?bannerMorePath=더보기 경로를 입력해주세요" flush="false" &gt;&lt;/jsp:include&gt;

<!-- 배너더보기 -->
&lt;c:import url="/jnitallim/bannerMore.do"&gt;
	&lt;c:param name="groupId" value="${groupId}"&gt; &lt;/c:param&gt;
	&lt;c:param name="groupCategory" value="${bannerMore }"&gt;&lt;/c:param&gt;
&lt;/c:import&gt;
</textarea>
</c:if>