<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=utf-8 />
<title><c:out value="${boardinfoVO.boardTitle}"/> :: 게시물관리</title>
<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui-1.9.0.custom.min.css" />" type="text/css" charset="utf-8"/>
<script type="text/javaScript" src="<c:url value="/resources/js/jquery.ui/js/jquery-1.8.2.min.js"/>"></script>
<link href="<c:url value="/board/_common/css/board.css" />" media="all" rel="stylesheet" type="text/css" />
<script type="text/javaScript" src="<c:url value="/resources/js/jquery.ui/js/jquery-ui-1.9.0.custom.min.js"/>"></script>
<script type="text/javaScript" src="<c:url value="/resources/js/jquery.ui/development-bundle/ui/i18n/jquery.ui.datepicker-ko.js"/>"></script>
<script type="text/javaScript" src="<c:url value="/resources/js/jquery.ui/js/jquery-ui-timepicker-addon.js"/>"></script>
<c:if test="${boardinfoVO.useWyswyg == 1}"><script src="<c:url value="/board/_editor/js/editor_loader.js" />" type="text/javascript" charset="utf-8"></script></c:if>
<script type="text/javaScript">var ctxRoot = '${ctxRoot}';</script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
$(document).ready(function(){
	searchBoard("${boardinfoVO.boardGroup}","");
});
$(document).on("change",'#searchBoardGroup',function(e){
	var group = $(this).val();
	var kwd = $('#searchKeyword').val();
	searchBoard(group,kwd);
});
$(document).on("keyup",'#searchKeyword',function(e){
	var group = $('#searchBoardGroup').val();
	var kwd = $(this).val();
	searchBoard(group,kwd);
});
var searchBoard = function(group,kwd){
	group =  encodeURIComponent(group);
	kwd =  encodeURIComponent(kwd);
	$.getJSON('<c:url value="/cms/board/searchAjax.do" />',{searchBoardGroup:group,searchCondition:'1',searchKeyword:kwd},function(data){
		$('#boardList').empty();
		$.each(data,function(k,v){
			$('#boardList').append('<option value="'+v.boardId+'">['+v.boardSkin+':'+v.boardType+'] '+v.boardTitle+'</option>');
		});
	});
};
var addBoard = function(){
	var selectedItem = $('#boardList').children("option:selected");
	$.each(selectedItem,function(k,v){
		if($('#tgBoardDp').children('option[value="'+$(v).val()+'"]').length<1){
			$('#tgBoardDp').append($(v).clone());
		}else{
			//alert("이미 추가된 게시판은 제외되고 추가되었습니다.");
		}
	});
};
var removeBoard = function(){
	$('#tgBoardDp').children("option:selected").remove();
};
var boardResult = function(){
	var result = "";
	var itemObj = $('#tgBoardDp').children("option");
	$.each(itemObj,function(k,v){
		result += $(v).val() + ',';
	});
	return result;
};
$(document).on("submit",'#boardManage',function(e){
	$('input[name="boardResult"]').val(boardResult());
	var moveChk = $("#moveConfig").attr('class');
	if(boardResult() == ''){
		alert("선택된 대상게시판이 없습니다.");
		return false;
	}
	if(!confirm('선택된 대상 게시판의 스킨이나 유형이\n기존 게시판과 다를 경우\n게시물이 다르게 보일 수도 있습니다.')){
		return false;
	}
	if(moveChk == 'on'){
		var targetUrl = $("#targetUrl").val(); 
		var comment = $("#comment").val();
		
		if(targetUrl == 'http://' || targetUrl == ''){
			alert("이동될 컨텐츠 URL을 입력해 주세요.");
			$("#targetUrl").focus();
			return false;
		}else if(comment == ''){
			alert("이동될 게시글의 대한 설명");
			$("#comment").focus();
			return false;
		}
	}
});

$(document).on("change","#action", function(){
	var thisVal = $(this).val();
	
	if(thisVal == 'move_with_tracks'){
		$("#moveConfig").addClass("on");
		$("#moveConfig").show();
	}else{
		$("#targetUrl").val('http://');
		$("#comment").val('');
		$("#moveConfig").removeClass("on");
		$("#moveConfig").hide();
	}
});

// -->
</script>
<style>
#boardList{width:100%;height:300px;}
#tgBoardDp{width:100%;height:300px;}
.boardWrap .bbsView th {width:150px;}
.manage{border-collapse: collapse;width:800px;}
.manage th{color:#26231c;padding:3px 5px 5px 5px;height:32px; background:#ededed;border-bottom:1px solid #bebebe;}
.manage td{padding:3px 5px 5px 5px;height:32px;border-bottom:1px solid #bebebe;}
</style>
</head>
<body>
	<div class="boardWrap">
	<form id="boardManage" name="boardManage" action="" method="post">
	<input type="hidden" name="mode" value="manage" />
	<input type="hidden" name="boardResult" value="" />
	<%--
	<input type="hidden" name="boardId" value="${boardinfoVO.boardId}" />
	<input type="hidden" name="cntId" value="${result.id}" />
	 --%>
	<table class="manage" summary="<c:out value="${boardinfoVO.boardTitle}" />의 게시물관리 테이블입니다.">
		<caption><c:out value="${boardinfoVO.boardTitle}" /> 게시물 관리</caption>
		<colgroup>
			<col width="17%">
			<col>
		</colgroup>
		<thead>
			<tr>
				<th colspan="2" class="title">게시물 관리</th>
			</tr>
		</thead>
		<tbody>
		<tr>
			<th scope="row" class="field ext01" style="width:150px">제목</th>
			<td>
				<c:out value="${result.title}" />
			</td>
		</tr>
		<tr>
			<th scope="row" class="field" style="width:150px">게시판스킨</th>
			<td>
				<c:out value="${boardinfoVO.boardSkin}" />
			</td>
		</tr>
		<tr>
			<th scope="row" class="field" style="width:150px">게시판유형</th>
			<td>
				<c:out value="${boardinfoVO.boardType}" />
			</td>
		</tr>
		<tr>
			<th scope="row" class="field ext01" style="width:150px">액션</th>
			<td>
				<select name="action" id="action" class="action" >
						<option value="copy">게시물 복사</option>
						<option value="move">게시물 이동</option>
						<option value="move_with_tracks">게시물 이동 (기존 게시물에 이동사실 고지)</option>
				</select>
			</td>
		</tr>
		<tr id="moveConfig" style="display: none;">
			<th scope="row" class="field ext01" style="width:150px">이동 게시물 설정</th>
			<td>
				<font>SAMPLE : 이동할 게시판 URL <strong style="color: red;">http://domain/kr/talk/0004/0001/</strong></font><br />
				빨간색 글씨까지만 복사 하세요.<br />
				<font style="float: left;"><strong>이동될 컨텐츠 URL : </strong></font><input type="text" id="targetUrl" name="targetUrl" value="http://" style="margin-left: 50px; " /><br />
				<font style="float: left;"><strong>이동될 게시글의 대한 설명 : </strong></font><input type="text" id="comment" name="comment" style="margin-left: 4px;" /><br />
				<font>EX : <strong style="color: red;">[기타 게시판]</strong>을 입력하시면 <strong style="color: red;">[기타 게시판 (으)로 이동된 게시물]</strong>로 나옵니다.</font>
			</td>
		</tr>
		</tbody>
	</table>
	<table class="manage" summary="액션 대상 게시판 선택 테이블입니다.">
		<caption>액션 대상 게시판 선택</caption>

		<thead>
			<tr>
				<th colspan="3" class="title">대상 게시판 선택</th>
			</tr>
		</thead>
		<tbody>
		<tr>
			<th scope="col" class="field" style="width:350px;">게시판 목록</th>
			<td rowspan="3" style="width:100px;" align="center">
				<p><a href="javascript:addBoard();">추가▶</a></p>
				<p><a href="javascript:removeBoard();">제거◀</a></p>
			</td>
			<th scope="col" class="field" style="width:350px;">대상 게시판</th>
		</tr>
		<tr>
		<%--
			<td>
			
				<c:if test="${!empty boardGroupList}">
                <select name="searchBoardGroup" id="searchBoardGroup">
                <option value="">전체 그룹</option>
                <c:forEach var="groupResult" items="${boardGroupList}" varStatus="status">
                <c:if test="${!empty groupResult.boardGroup}">
                <option value="<c:out value="${groupResult.boardGroup}"/>" <c:out value="${searchVO.searchBoardGroup == groupResult.boardGroup ? 'selected' : ''}"/>><c:out value="${groupResult.boardGroup}"/></option>
                </c:if>
                </c:forEach>
                </select>
                </c:if>
                	<input type="text" name="searchKeyword" id="searchKeyword" />
                	
			</td>
		--%>
			<td>
				<select multiple="multiple" name="boardList" id="boardList">
                </select>
			</td>
			<td>
                <select multiple="multiple" name="tgBoardDp" id="tgBoardDp">
                </select>
			</td>
		</tr>
		<tr>
			<td colspan="3" align="center">
				<input type="submit" class="manage_submit" value="적용하기" />
			</td>
		</tr>
		</tbody>
	</table>
	</form>
	</div>
</body>
</html>