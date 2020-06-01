<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
<!--
function Jnit_choice(menuNm){	
	var type = "${type}";
	var html = "<option value='"+menuNm+"' selected='selcted' >"+menuNm+"</option>";
	$("#limit"+type).append(html);
	$("#limit"+type).select2();
	$('#myModal').modal('toggle');
}

function Jnit_search(){
	$("#pageIndex").val(1);
	var searchKeyword = $("#searchKeyword").val();
	var searchCondition = $("#searchCondition option:selected").val();
	$.ajax({
		type:"post",
		url:"<c:url value='/cms/ajax/cnt/list.do'/>",
		data:"pageIndex=1 &type=${type}&searchKeyword="+searchKeyword+"&searchCondition="+searchCondition
	}).done(function(data){
		$("#listView").empty();
		$("#listView").append(data);
	});
}

function fn_egov_link_page(pageNo){
	$("#pageIndex").val(pageNo);
	var searchKeyword = $("#searchKeyword").val();
	var searchCondition = $("#searchCondition option:selected").val();
	$.ajax({
		type:"post",
		url:"<c:url value='/cms/ajax/cnt/list.do'/>",
		data:"pageIndex="+pageNo+"&type=${type}&searchKeyword="+searchKeyword+"&searchCondition="+searchCondition
	}).done(function(data){
		$("#listView").empty();
		$("#listView").append(data);
	});
}
$(document).ready(function(){
	//검색 selected
	var searchCondition = "${searchCondition}";
	if(searchCondition != '') $("#searchCondition").val(searchCondition);
	//검색어 바인드 13코드 enter
	$("#searchKeyword").bind("keypress",function(e){
		if(e.keyCode==13){
			e.preventDefault();
			$("#pageIndex").val(1);
			var searchKeyword = $("#searchKeyword").val();
			var searchCondition = $("#searchCondition option:selected").val();
			$.ajax({
				type:"post",
				url:"<c:url value='/cms/ajax/cnt/list.do'/>",
				data:"pageIndex=1 &type=${type}&searchKeyword="+searchKeyword+"&searchCondition="+searchCondition
			}).done(function(data){
				$("#listView").empty();
				$("#listView").append(data);
			});
		}
	});
});
//-->
</script>

<form:form commandName="searchVO" action="?" method="post" id="searchListVO">
	<table class="table table-bordered">
		<c:if test="${type == 'CntNm' }">
			<c:forEach var="result" items="${resultList }">
				<tr>
					<th>콘텐츠명</th>
					<td><c:out value="${result.menuNm}"/></td>
					<td><a href="javascript:Jnit_choice('${result.menuNm }');" class="btn btn-small">선택</a></td>
				</tr>
			</c:forEach>
			<c:if test="${empty resultList }"><tr><td>조회 데이터가 없습니다.</td></tr></c:if>
		</c:if>
		<c:if test="${type == 'BoardId' }">
			<tr>
				<th>게시판ID</th>
				<th>게시판제목</th>
				<th>선택</th>
			</tr>
			<c:forEach var="result" items="${resultList }">
				<tr>
					<td><c:out value="${result.boardId}"/></td>	
					<td><c:out value="${result.boardTitle}"/></td>					
					<td>
						<a href="javascript:Jnit_choice('${result.boardId }');" class="btn btn-small">선택</a>
					</td>					
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${type == 'MbrId' || type == 'MbrType' }">
			<tr>
				<th>회원 ID</th>
				<th>회원 이름</th>
				<c:if test="${type == 'MbrType' }">
					<th>유형 ID</th>
					<th>유형</th>
					<th>레벨</th>
				</c:if>
				<th>선택</th>
			</tr>
			<c:forEach var="result" items="${resultList }">
				<tr>
					<td><c:out value="${result.mbrId}"/></td>
					<td><c:out value="${result.mbrNm}"/></td>
					<c:if test="${type == 'MbrType' }">
						<td><c:out value="${result.typeId}"/></td>
						<td><c:out value="${mbrtypeMap[result.mbrId]}"/></td>
						<td><c:out value="${mbrtypeLvMap[result.mbrId]}"/></td>
					</c:if>
					<td>
						<c:if test="${type == 'MbrId'}">
							<a href="javascript:Jnit_choice('${result.mbrId }');" class="btn btn-small">선택</a>
						</c:if>
						<c:if test="${type == 'MbrType' }">
							<a href="javascript:Jnit_choice('${result.typeId }');" class="btn btn-small">선택</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<div>		
		<c:if test="${type == 'BoardId' }">
		<select id="searchCondition" name="searchCondition" style="width: 30%;">
			<option value="2" selected="selected">전체</option>
			<option value="0">ID검색</option>
			<option value="1">제목검색</option>
		</select>
		</c:if>
		<c:if test="${type == 'MbrId' || type == 'MbrType' }">
		<select id="searchCondition" name="searchCondition" style="width: 30%;">
			<c:if test="${type == 'MbrId'}">
				<option value="19" selected="selected">전체</option>
			</c:if>
			<c:if test="${type == 'MbrType'}">
				<option value="20" selected="selected">전체</option>
			</c:if>
			<option value="5">회원이름</option>
			<option value="0">회원ID</option>
			<c:if test="${type == 'MbrType'}">
				<option value="15">유형</option>
				<option value="18">유형ID</option>
				<option value="17">레벨</option>
			</c:if>
		</select>
		</c:if>
		<input type="text" id="searchKeyword" name="searchKeyword" value="${searchVO.searchKeyword }" style="width: 50%;">&nbsp;<a href="javascript:Jnit_search();" class="btn btn-small">검색</a>
	</div>
	<div id="page_navi" class="pagination">
			<ui:pagination paginationInfo = "${paginationInfo}"
					   type="jnitDefault"
					   jsFunction="fn_egov_link_page"
					   />
			<form:hidden path="pageIndex" id="pageIndex" />
	</div>	
</form:form>