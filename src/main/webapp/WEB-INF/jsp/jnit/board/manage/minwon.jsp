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
<link rel="stylesheet" href="<c:url value="resources/css/jquery-ui-1.9.0.custom.min.css" />" type="text/css" charset="utf-8"/>
<script type="text/javaScript" src="<c:url value="/js/jquery-1.8.2.min.js"/>"></script>
<link rel="stylesheet" type="text/css" media="screen" href="/board/_common/css/board.css" />
<script type="text/javaScript" src="<c:url value="/js/jquery.ui/js/jquery-ui-1.9.0.custom.min.js"/>"></script>
<script type="text/javaScript" src="<c:url value="/js/jquery.ui/development-bundle/ui/i18n/jquery.ui.datepicker-ko.js"/>"></script>
<script type="text/javaScript" src="<c:url value="/js/jquery.ui/js/jquery-ui-timepicker-addon.js"/>"></script>
<c:if test="${boardinfoVO.useWyswyg == 1}"><script src="<c:url value="/board/_editor/js/editor_loader.js" />" type="text/javascript" charset="utf-8"></script></c:if>
<script type="text/javaScript" src="<c:url value="/board/_common/js/board.js"/>"></script>
<script type="text/javaScript">var ctxRoot = '${ctxRoot}';</script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
$(document).on("submit","#frmManage",function(e){
	var ext01 = $("#ext01 > option:selected").val();
	if( (ext01 == "담당자지정" || ext01 == "결재진행" || ext01 == "완료")&&($("#ext05").val()=="") ){
		alert("담당자가 입력되지 않았습니다.\n지정하실 담당자를 검색하신 후\n옆의 등록버튼을 눌러 담당자를 지정하여 주세요.");
		$('#searchKeyword').focus();
		return false;
	}
});
$(document).on("click",'#ext05',function(e){
	alert("지정하실 담당자를 검색하신 후\n옆의 등록버튼을 눌러 담당자를 지정하여 주세요.");
	$('#searchKeyword').focus();
});
$(document).on("change",'#searchCondition',function(e){
	var con = $(this).val();
	var kwd = $('#searchKeyword').val();
	searchId(con,kwd);
});
$(document).on("keyup",'#searchKeyword',function(e){
	var con = $('#searchCondition').val();
	var kwd = $(this).val();
	searchId(con,kwd);
});
var searchId = function(con,kwd){
	kwd =  encodeURIComponent(kwd);
	$.getJSON('<c:url value="/cms/mbr/searchAjax.do" />',{schTypeId:'30021',searchCondition:con,searchKeyword:kwd},function(data){
		$('#mbrId').empty();
		$.each(data,function(k,v){
			$('#mbrId').append('<option value="'+v.mbrId+'">['+v.mbrId+'] '+v.mbrLogin+' : '+v.mbrNm+'</option>');
		});
	});
};
var selectMbr = function(){
	var mbrIdStr = "";
	var selectedItem = $('#mbrId').val();
	$.each(selectedItem,function(k,v){
		mbrIdStr += v + ','; 
	});
	var originData = $('#ifmContent',parent.document).contents().find("#admExt").val();
	$('#ifmContent',parent.document).contents().find("#admExt").val(originData + mbrIdStr);
	parent.setList();
};
var selectMbrId = function(){
	$('#ext05').val($('#mbrId option:selected').val());
};
// -->
</script>
<style>
#mbrId{width:100%;height:300px;}
</style>
</head>
<body>
	<div class="boardWrap">
	<form id="frmManage" action="" method="post">
	<input type="hidden" name="mode" value="manage" />
	<%--
	<input type="hidden" name="boardId" value="${boardinfoVO.boardId}" />
	<input type="hidden" name="cntId" value="${result.id}" />
	 --%>
	<table class="bbsView manage" summary="<c:out value="${boardinfoVO.boardTitle}" />의 게시물관리 테이블입니다.">
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
			<th scope="row" class="field ext01">제목</label></th>
			<td>
				<c:out value="${result.title}" />
			</td>
		</tr>
		<tr>
			<th scope="row" class="field ext01">상태</label></th>
			<td>
				<select name="ext01" id="ext01" class="ext01" >
						<c:forEach var="itm" items="${f['ext01'].item}" varStatus="status">
						<option value="<c:out value="${itm}"/>" <c:out value="${result['ext01'] == itm ? 'selected' : ''}"/>><c:out value="${itm}"/></option>
						</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th scope="row" class="field ext02">처리부서</label></th>
			<td>
				<input name="ext02" id="ext02" class="width100" type="text" value="<c:out value="${result.ext02}" />" />
			</td>
		</tr>
		<tr>
			<th scope="row" class="field ext05">담당자지정</label></th>
			<td>
				<input name="ext05" readonly="readonly" id="ext05" class="width100" type="text" value="<c:out value="${result.ext05}" />" />
			</td>
		</tr>
		<tr>
			<th rowspan="2" scope="row" class="field ext05">담당자 검색</label></th>
			<td>
				    <select name="searchCondition" id="searchCondition">
                		<option value="5">사용자이름</option>
                		<option value="4">사용자아이디</option>
                	</select>
                	<input type="text" name="searchKeyword" id="searchKeyword" />
                	<a href="javascript:selectMbrId();"><img src="<c:url value="/images/jnit/cms/up_but1.gif" />" alt="적용" /></a>
			</td>
		</tr>
		<tr>
			<td>
                	<select multiple="multiple" name="mbrId" id="mbrId">
                	</select>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="image" src="<c:url value="/images/jnit/cms/submitbut.gif" />" alt="적용" />
			</td>
		</tr>
		</tbody>
	</table>
	</form>
	</div>
</body>
</html>