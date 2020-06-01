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
	<input type="hidden" id="state" name="state" value="" />
	<div id="filegoFailDiv">
		<table class="table table-bordered table-striped table-hover" summary="배포실패 로그">
			<tr>
				<th style="width: 5%"><input type="checkbox" id="allChk" name="allChk" value="" /></th>
				<th style="width: 5%">No</th>
				<!-- <th>UUID</th> -->
				<th style="width: 10%">보낸 서버</th>
				<th style="width: 12%">받는 서버</th>
				<th style="width: *">파일명</th>
				<th style="width: 15%">메시지</th>
				<th style="width: 12%">전송 실패일자</th>
			</tr>
			<c:if test="${fn:length(resultList) < 1}">
				<tr>
					<td colspan="7" style="text-align: center;">내역이 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td style="text-align: center; vertical-align: middle;"><input type="checkbox" id="jfflSeqChk_<c:out value="${status.index}" />" name="jfflSeqChk_<c:out value="${status.index}" />" value="<c:out value="${result.jfflSeq}" />" /></td>
					<td style="text-align: center; vertical-align: middle;"><c:out value="${status.count - (totCnt - ( ( paginationInfo.currentPageNo -1 ) * paginationInfo.recordCountPerPage))}" /></td>
					<%-- <td><c:out value="${result.jfflRequestUuid}" /></td> --%>
					<td style="text-align: center; vertical-align: middle;"><c:out value="${result.jfflSender}" /></td>
					<td style="text-align: center; vertical-align: middle;"><c:out value="${result.jfflReceiver}" /></td>
					<td style="vertical-align: middle;"><c:out value="${result.jfflFilename}" /></td>
					<td style="vertical-align: middle;">
						<c:set var="jfflMsgLength" value="${fn:length(result.jfflMsg)}" />
						<c:set var="jfflMsg" value="${fn:substring(result.jfflMsg, 0, 25)}" />
						<p id="filego_<c:out value="${status.count}" />" data-original-title="<c:out value="${result.jfflMsg}" />">
							<c:out value="${jfflMsg  }" /><c:out value="${jfflMsgLength > 25 ? '...' : '' }" />
						</p>
					</td>
					<td style="text-align: center; vertical-align: middle;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${result.created}"/></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div id="page_navi" class="pagination">
		<ui:pagination paginationInfo = "${paginationInfo}"
				   type="jnitDefault"
				   jsFunction="fn_filego_link_page"
				   />
		<form:hidden path="pageIndex" />
	</div>
</form:form>