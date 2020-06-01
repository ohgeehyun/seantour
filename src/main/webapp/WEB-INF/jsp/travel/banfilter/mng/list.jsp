<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<% String type = request.getParameter("type"); %>
<c:set var="type" value="<%= type %>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<div class="list_content2">
			<%-- Contents Start --%>
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
					<form:form commandName="banFilters" method="post">
					    <input type="hidden" name="screenMode" />
					    <%-- <input type="hidden" id="groupId" name="groupId" /> --%>
					    <%-- <input type="hidden" name="grpId" value="${grpId}" /> --%>
					    <%-- <input type="hidden" id="type" name="type" value="${type}" /> --%>
					    <input type="hidden" name="delWord" id="delWord" value="">
						<%-- <input type="hidden" name="searchKeyword" id="searchKeyword" value=""> --%>
	                   	<%-- <div class="widget-title">
							<h3>금칙어 리스트</h3>
							<a href="<c:url value="/cms/travel/banfilter/register.do"/>" class="btn btn-small"><i class="icon-plus-sign"></i> 추가하기</a>
	                    </div> --%>
						<div class="widget-title" style="float:left;width:49.4%;">
							<form:input path="searchKeyword" cssClass="txt" maxlength="50" />
							<button class="btn btn-small"><i class="icon-plus-sign"></i>검색</button>
						</div>
						<div class="widget-title" style="float:right;width:49.4%;text-align:right;">
							<input type="text" name="wordList" class="txt" maxlength="50" style="width:400px;" placeholder="추가하려는 단어를 쉼표(,)로 구분해서 입력하세요">
							<a href="javascript:;" onclick="registerBanWord();return false;" class="btn btn-small"><i class="icon-plus-sign"></i> 추가하기</a>
						</div>

	                    <div class="widget-content nopadding" style="clear:both; overflow: auto; width:100%; height: 650px;">
							<table class="table table-bordered table-striped table-hover" summary="금칙어 테이블">
								<thead>
									<tr>
										<th>금칙어</th>
										<th>생성일시</th>
										<th>관리</th>
									</tr>
								</thead>
								<tbody>		
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td class="conts"><c:out value="${result.banWord}"/></td>
										<td class="conts"><c:out value="${fn:substring(result.createdAt,0,10)}"/></td>
										<td class="conts">
											<a href="javascript:;" onclick="deleteBanWord('<c:out value="${result.banWord}"/>');" class="btn btn-small"><i class="icon-remove-sign"></i> 삭제</a>
											<%-- <a href="<c:url value="/cms/travel/banfilter/delete.do?banWord=${result.banWord}"/>" class="btn btn-small"><i class="icon-trash"></i> 삭제</a> --%>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							<div id="page_navi">
								<ui:pagination paginationInfo="${paginationInfo}" type="jnitDefault" jsFunction="fn_egov_link_page" />
								<form:hidden path="pageIndex" />
							</div>
						</div>
					</form:form>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/cms.admin.css"/>">
<script type="text/javascript">
function fn_egov_link_page(pageNo){
	document.getElementById("banFilters").pageIndex.value = pageNo;
	document.getElementById("banFilters").action = "<c:url value='/cms/travel/banfilter/list.do'/>";
   	document.getElementById("banFilters").submit();
}
function registerBanWord(){
	document.getElementById("banFilters").pageIndex.value = 1;
	document.getElementById("banFilters").action = "<c:url value='/cms/travel/banfilter/insert.do'/>";
   	document.getElementById("banFilters").submit();
}
function deleteBanWord(banWord){
	document.getElementById("banFilters").delWord.value = banWord;
	document.getElementById("banFilters").pageIndex.value = 1;
	document.getElementById("banFilters").action = "<c:url value='/cms/travel/banfilter/delete.do'/>";
   	document.getElementById("banFilters").submit();
}
</script>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>