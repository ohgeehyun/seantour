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
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<style>
	#boardManageTable td	{text-align:center;}
</style>
<script type="text/javascript">
<!--
/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/mgmt/board/list.do'/>";
   	document.getElementById("listForm").submit();
}
function getSelectBoard(){
	
	var boardId = $("#selectBoardId").val();
	var boardNm = $("#selectBoardName").val();
	
	$("#boardName>h3").text("");
	$("#boardName>h3").text("선택된 게시판 : " + boardNm);
	
	$('#boardView').attr('src', '/board/board.do?boardId='+boardId);
	$("#boardManageTable>tbody>tr>td>a").css("font-weight", "");
	$("#boardManageTable>tbody>tr>td>a").css("color", "");
	$("#"+boardId+">a").css("font-weight", "bold");
	$("#"+boardId+">a").css("color", "red");
	
	$("#selectBoardId").val(boardId);
	$("#selectBoardName").val(boardNm);
}

function setSelectBoard(boardId, boardNm){
	$("#selectBoardId").val(boardId);
	$("#selectBoardName").val(boardNm);
}

function changeSelectBoard(boardId, boardNm){
	setSelectBoard(boardId, boardNm);
	getSelectBoard();
}

$(document).ready(function(){
	
	getBoardData();
	
	//게시판 검색 엔터키 다운
	$("#boardNameSearch").bind("keydown",function(e){
		e.preventDefault();
		if(e.keyCode == 13){
			getBoardData(searchBoardName, searchSiteName);
		}
	});
	
	//게시판 검색 버튼 클릭
	$("#searchBtn").bind("click",function(e){
		e.preventDefault();
		getBoardData();
	});
	
	//사이트 검색
	$("#searchSiteId").bind("change", function(e){
		e.preventDefault();
		getBoardData();
	});
});

function getBoardData(){
	
	var url = "/cms/mgmt/board/data.do";
	var searchBoardName = $("#searchBoardName").val();
	var searchSiteId = $("#searchSiteId").val();
	var orderByCondition = $("#orderByCondition").val();
	
	$.ajax({
		type:"POST",
		url:url,
		data:{
			"searchBoardName":searchBoardName,
			"searchSiteId":searchSiteId,
			"orderByCondition":orderByCondition
		},
		success:function(data){
			$("tbody").empty();
			$("tbody").append(data);
		},
		error:function(data){
			alert("일시적인 오류로 인해 페이지 새로고침을 진행합니다.");
			$("tbody").empty();
			window.location.href=window.location.href;
		}
	});
}

function setOrderBy(type){
	$("#orderByCondition").val(type);
	getBoardData();
}

 // -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	    <input type="hidden" name="screenMode" id="screenMode" />
		<input type="hidden" name="mgmtId" id="mgmtId" />
		<input type="hidden" name="orderByCondition" id="orderByCondition" />
		<input type="hidden" name="selectBoardId" id="selectBoardId" />
		<input type="hidden" name="selectBoardName" id="selectBoardName" />
		<div class="row-fluid">
			<div class="span4">
				<div class="widget-box"  style="overflow: auto; height: 860px;">
					<div class="widget-title">
						<h3  style="float: none;">게시판 목록</h3>
					</div>
					<div class="widget-title">
						<span>
							<input type="text" style="width: 40%;" id="searchBoardName" name="searchBoardName" placeholder="게시판 검색" />
							<button id="searchBtn" class="btn btn-small" ><i class="icon icon-search"></i>&nbsp;&nbsp;검색</button>
						</span>
					</div>
					<div class="widget-content nopadding">
						<table id="boardManageTable" class="table table-bordered">
							<thead>
								<tr>
									<th style="width: 65%;">게시판 명&nbsp;&nbsp;&nbsp;<a href="javascript:setOrderBy('up');" >▲</a>&nbsp;<a href="javascript:setOrderBy('down');">▼</a></th>
									<th style="width: 35%;">
										<select id="searchSiteId" name="searchSiteId" style="width: 100%;">
											<option value="">전체</option>
											<c:forEach var="result" items="${siteList}">
												<option value="${result.siteId}"><c:out value="${result.siteNm}" /></option>
											</c:forEach>
										</select>
									</th>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
					</div>	
				</div>
			</div>
			<div class="span8">
				<div class="widget-box" style="height: 860px;">
					<div class="widget-title">
						<span id="boardName"><h3 style="float: none;">선택된 게시판 : 없음</h3></span>
					</div>
					<div id="editView">
						<iframe id="boardView" src="about:blank" frameborder="0" topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" width="100%" height="820px"></iframe>
					</div>
				</div>
			</div>
		</div>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
