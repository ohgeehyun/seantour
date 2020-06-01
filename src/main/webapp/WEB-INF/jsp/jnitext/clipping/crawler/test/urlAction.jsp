<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ include file="/WEB-INF/jsp/jnit/_common/init.jsp" %>
<textarea rows="10" style="width:100%"><c:out value="${resultHtml }" /></textarea>
<div style="height:200px; -ms-overflow-y: scroll;">
	<div class="widget-content nopadding">
	<table class="table table-bordered table-striped table-hover" id="ajax-listClippingParam">
		<thead>
			<tr>
				<th>키</th>
			<c:forEach items="${clippingKeyList }" var="clippingKey">
				<th><c:out value="${clippingKey.clippingKeyName }" /></th>
			</c:forEach>
			</tr>
			<tr>
				<th>건수</th>
			<c:forEach items="${clippingKeyList }" var="clippingKey">
				<th>${fn:length(result[clippingKey.clippingKeyName]) }
				</th>
			</c:forEach>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>데이터</td>
			<c:forEach items="${clippingKeyList }" var="clippingKey">
				<td>
				<c:forEach items="${result[clippingKey.clippingKeyName] }" var="result">
				<c:out value="${result }" />
				<br />
				</c:forEach>
				</td>
			</c:forEach>
			</tr>
		</tbody>
	</table>
	</div>
</div>