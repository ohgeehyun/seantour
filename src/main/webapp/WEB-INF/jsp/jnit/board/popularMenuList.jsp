<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="header.jsp" %>

<c:if test="${not empty type || not empty skin }">
<%--
<c:catch var="e">
	<c:if test="${not empty skin}">
		<jsp:include page="latest/${fn:replace(type,'..','')}_${fn:replace(skin,'..','')}.jsp" />
	</c:if>
	<c:if test="${empty skin}">
		<jsp:include page="latest/${fn:replace(type,'..','')}.jsp" />
	</c:if>
</c:catch>
--%>
<c:if test="${not empty e}">
	올바른 Type이 아닙니다.
	<c:out value="${e}" />
</c:if>
</c:if>

<div class="txt_list">
	<dl>	
		<dt>인기메뉴</dt>
			<dd class="none">
				<table class="data_txt" summary="인기메뉴 순위, 메뉴명, URL, 조회수에 대한 내용을 보실 수 있습니다.">
				<caption>인기메뉴</caption>
				<colgroup>
					<col width="6%" />
					<col width="25%" />
					<col width="55%" />
					<col width="14%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">순위</th>
						<th scope="col">메뉴명</th>
						<th scope="col">URL</th>
						<%-- <th scope="col">조회수</th> --%>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="tc">${status.count}</td>
							<td class="tc">${result.menuNm}</td>
							<td><a href="${result.pageUrl}">${result.pageUrl}</a></td>
							<%--<td class="tc">${result.pageView}</td>--%>
						</tr>
					</c:forEach>
				</tbody>
				</table>
			</dd>
	</dl>
</div><!--//txt_list-->