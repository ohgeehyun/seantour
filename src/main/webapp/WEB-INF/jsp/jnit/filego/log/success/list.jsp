<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<form:form commandName="searchVO" name="filegoListForm" id="filegoListForm" method="post">
	<input type="hidden" id="seqs" name="seqs" value="" />
	<div id="filegoSuccessDiv">
		<table class="table table-bordered table-striped table-hover" summary="배포성공 로그">
			<tr>
				<th style="width: 5%">No</th>
				<!-- <th style="width: 8%">UUID</th> -->
				<th style="width: 10%">보낸 서버</th>
				<th style="width: 15%">받는 서버</th>
				<th style="width: *">파일명</th>
				<th style="width: 15%">전송일자</th>
			</tr>
			<c:if test="${fn:length(resultList) < 1}">
				<tr>
					<td colspan="5" style="text-align: center;">내역이 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td style="text-align: center; vertical-align: middle;"><c:out value="${status.count - (totCnt - ( ( paginationInfo.currentPageNo -1 ) * paginationInfo.recordCountPerPage))}" /></td>
					<%-- <td><c:out value="${result.jfslRequestUuid}" /></td> --%>
					<td style="text-align: center; vertical-align: middle;"><c:out value="${result.jfslSender}" /></td>
					<td style="text-align: center; vertical-align: middle;"><c:out value="${result.jfslReceiver}" /></td>
					<td style="vertical-align: middle;"><c:out value="${result.jfslFilename}" /></td>
					<td style="text-align: center; vertical-align: middle;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${result.created}"/></td>
				</tr>
			</c:forEach>
		</table>
		<div id="page_navi" class="pagination">
			<ui:pagination paginationInfo = "${paginationInfo}"
					   type="jnitDefault"
					   jsFunction="fn_filego_link_page"
					   />
			<form:hidden path="pageIndex" />
		</div>
	</div>
</form:form>