<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javascript">
/* 글 수정 화면 function */
function fn_egov_select(boardId) {
    document.getElementById("listForm").boardId.value = boardId;
    //document.getElementById("listForm").pageIndex.value = '1';
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/cms/board/edit.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	//document.getElementById("listForm").action = "<c:url value='/cms/board/add.do'/>";
   	document.getElementById("listForm").action = "<c:url value='/cms/board/step1.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/board/list.do'/>";
   	document.getElementById("listForm").submit();
}

function goExcel(boardId){
	alert('컨텐츠의 양에 따라 다소 시간이 걸릴 수 있습니다.');
	document.getElementById("listForm").searchCondition.value = "excel";
	document.getElementById("listForm").boardId.value = boardId;
	document.getElementById("listForm").action = "<c:url value='/board/board.do?mode=excel'/>";
   	document.getElementById("listForm").submit();
   	document.getElementById("listForm").searchCondition.value = "1";
}

// 게시판복사 기능
function goBoardCopyModal(boardId){
	$('#boardId').val(boardId);
	var bodyHtml = "<input type='text' id='copyboardTitle' name='copyboardTitle' />";
	var footerHtml = "<a href='javascript:goBoardCopy();' class='btn btn-primary'>복사</a>";
	
	//head
	$("#myModalLabel").empty();
	$("#myModalLabel").append("게시판 복사 : 제목을 입력해주시기 바랍니다.");
	
	//body
	$(".modal-body").empty();
	$(".modal-body").append(bodyHtml);
	
	//footer
	$("#modalFooter").empty();
	$("#modalFooter").append(footerHtml);
	
	$("#copyboardTitle").bind("keydown",function(e){
		if(e.keyCode == 13){
			goBoardCopy();
		}
	});
	$('#myModal').modal('show');
}

//게시판복사 실행
function goBoardCopy(){
	var copyboardTitle = $('#copyboardTitle').val();
	if(copyboardTitle != ''){
		$('#boardcopyTitle').val($('#copyboardTitle').val());
		$('#myModal').modal('toggle');
		frm = document.getElementById("listForm");
		frm.action = "<c:url value='/cms/jnit/board/boardcopy.do'/>";
		frm.submit();
	}else{
		alert("복사할 게시판 제목을 입력해주시기 바랍니다.");
		$("#copyboardTitle").focus();
	}
}

//임포트코드
function Jnit_importCode(boardId){
	$.ajax({
		type:"post",
		url:"<c:url value='/cms/board/ajax/importCode.do'/>",
		data: "boardId="+boardId
	}).done(function(data){
		//head
		$("#myModalLabel").empty();
		$("#myModalLabel").append("게시판 import Code : 복사버튼을 눌러 복사하시기 바랍니다.");
		//body
		$(".modal-body").empty();
		$(".modal-body").append(data);
		//footer
		var footerHtml = "<a href='javascript:Jnit_textCopy();' class='btn btn-primary'>복사</a>";
		$("#modalFooter").empty();
		$("#modalFooter").append(footerHtml);
		$('#myModal').modal('toggle');
	});
}

//임포트코드 복사하기
function Jnit_textCopy(){
	var htmlSrc = $("#boardImportCode").val();
	var IE=(document.all)?true:false;
	if (IE) {
		window.clipboardData.setData("Text", htmlSrc);
	}else {
		temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", htmlSrc);
	}		
}

//게시판 삭제
function boardDataAllDel(boardId){
	
	var preventDefault = function(e){e.preventDefault();};
	var confirmMsg = $.trim(randString(7));
	var inputMsg = $("#inputMsg").val();	
	$("#confirmMsg").val(confirmMsg);
	
	//head
	$("#myModalLabel").empty();
	$("#myModalLabel").append("게시판 데이터 전체 삭제");	
	//body
	var bodyhtml = "<span id='inputMsgView' name='inputMsgView'></span>"
				+ "<br /><input type='text' id='inputMsg' name='inputMsg' />";
	$(".modal-body").empty();
	$(".modal-body").append(bodyhtml);	
	//footer
	var footerHtml = "<button class='btn btn-primary' id='msgModalDel' name='msgModalDel' value=''>삭제</button>";
	$("#modalFooter").empty();
	$("#modalFooter").append(footerHtml);
	
	$("#inputMsgView").empty();
	$("#inputMsgView").append("삭제코드 : <strong>" + confirmMsg + "</strong><br /><strong style='color: red;'>※데이터 삭제후에는 복구가 불가능합니다.</strong>");
	 
	$("#msgModalDel").val(boardId);
	$("#myModal").bind("dragstart", preventDefault).bind("selectstart", preventDefault);
	$("#myModal").modal('show');
}

function randString(n){
    if(!n){
        n = 5;
    }
    var text = '';
    var possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    for(var i=0; i < n; i++){
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    return text;
}

function Jnit_boardSearch(){
	$('#pageIndex').val(1);
	document.getElementById("listForm").action = "<c:url value='/cms/board/list.do'/>";
   	document.getElementById("listForm").submit();
};

function Jnit_modal_close(){
	$("#myModal").modal('hide');
}

var getCode = function(boardId){

	var $pJquery = window.parent.$;
	
	var dialog = '<div id="dialog" title="게시판 삽입용 코드"><textarea></textarea></iframe></div>';
	if($pJquery('#dialog').length>0){
		$pJquery('#dialog').remove();
	}
	$pJquery('body').append(dialog);
	$pJquery('#dialog').dialog({
		modal: true,
		close: function( event, ui ) {
			$pJquery(this).dialog('destroy').remove();
			}
	});
	return false;
};

$(document).on("click", "#msgModalDel", function(e){
	e.preventDefault();
	var inputMsg = $("#inputMsg").val();
	var confirmMsg = $("#confirmMsg").val();
	var boardId = $(this).val();
	if(inputMsg != ""){
		$("#inputMsg").val("");
		window.location.href="<c:url value="/cms/board/delProc.do"/>?boardId="+boardId+"&confirmMsg="+confirmMsg+"&inputMsg="+inputMsg;
	}else{
		$("#inputMsg").focus();
		alert("삭제 코드를 입력해 주시기 바랍니다.");
	}
});

$(document).on("click", "#msgModalCancle", function(e){
	e.preventDefault();
	
	$("#inputMsg").val("");
});

$(document).on('click','input.btnSearch',function(e){
	fn_egov_link_page('1');
});

$(document).ready(function(){
	//게시판 검색
	$("#search").keydown(function(e){
		if(e.keyCode == 13){
			Jnit_boardSearch();
		}
	});
	$('#createdStartDate').datepicker();
	$('#createdEndDate').datepicker();
});
 // -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post" action="${pageContext.request.contextPath }/cms/board/list.do">
		    <input type="hidden" name="screenMode" />
		    <input type="hidden" id="boardId" name="boardId" />
		    <input type="hidden" name="searchCondition" value="1" />
		    <input type="hidden" id="boardcopyTitle" name="boardcopyTitle"/>
		    <input type="hidden" id="confirmMsg" name="confirmMsg" /> 
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title" style="padding-top:3px;">
	                       	<h3>게시판 리스트</h3>
	                       	<a href="<c:url value="/cms/board/step1.do" />" class="btn btn-small"><i class="icon-plus-sign"></i> 게시판 추가</a>
	                   		<div class="widget-right-down">
		                   		<input type="text" name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>" placeholder="검색어입력">
	        					<a href="javascript:Jnit_boardSearch();" class="btn btn-small"><i class="icon-search"></i> 검색</a>
        					</div>
	                    </div>
	                   	<div class="widget-title" style="padding-top:3px;padding-left:10px;">
	                   		엑셀다운기간설정 
	                   		<input type="text" name="createdStartDate" size="8" id="createdStartDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${createdStartDate}"/>" style="width: 90px;text-align: center;"/>
							 ~ <input type="text" name="createdEndDate" size="8" id="createdEndDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${createdEndDate}"/>" style="width: 90px;text-align: center;"/>
						</div>
	                    <div class="widget-content nopadding">
						    <table class="table table-bordered table-striped table-hover" summary="게시판 리스트">
						        <thead>
						            <tr>
						                <th style="width: 135px;">코드</td>						                
						                <th style="min-width: 50px;">제목</td>
						                <th style="width: 50px;">유형</td>
						                <th style="width: 50px;">스킨</td>
						                <th style="width: 180px;min-width: 30px;">권한</td>
						                <th style="width: 430px;">관리</td>						                
						            </tr>
						        </thead>
						        <tbody>
						            <c:forEach var="result" items="${resultList}" varStatus="status">
						            <tr>
						                <td style="text-align:center;"><c:out value="${result.boardId}"/></td>
						                <td><a href="javascript:fn_egov_select('<c:out value="${result.boardId}"/>')"><c:out value="${result.boardTitle}"/></a></td>
						                <td style="text-align:center;"><c:out value="${fn:toUpperCase(result.boardType)}"/></td>
						                <td style="text-align:center;"><c:out value="${fn:toUpperCase(result.boardSkin)}"/></td>
						                <td style="text-align:center;">
							                
								                <span>목록:<c:out value="${result.permList}"/>,</span>
								                <span>보기:<c:out value="${result.permView}"/>,</span>
								                <span>쓰기:<c:out value="${result.permWrite}"/>,</span>
								                <span>댓글:<c:out value="${result.permCmt}"/></span>
							                
						                </td>
						                <td align="center">
						                	<a href="<c:url value="/board/board.do?boardId=${result.boardId}"/>" target="_blank"  class="btn btn-small" style="padding: 5px 4px;margin-bottom: 1px;">게시물관리</a>
						                	<a href="#" onclick="goExcel('${result.boardId}');"  class="btn btn-small" style="padding: 5px 4px;margin-bottom: 1px;">엑셀다운로드</a>
						                	<a href="#" onclick="goBoardCopyModal('${result.boardId}');" class="btn btn-small" style="padding: 5px 4px;margin-bottom: 1px;">게시판복사</a>
						                	<a href="#" onclick="Jnit_importCode('${result.boardId}');" class="btn btn-small" style="padding: 5px 4px;margin-bottom: 1px;">임포트코드</a>
						                	<a href="#" onclick="boardDataAllDel('${result.boardId}');" class="btn btn-small" style="padding: 5px 4px;margin-bottom: 1px;">데이터 전체삭제</a>
						                </td>
						            </tr>
						            </c:forEach>
						            <c:if test="${empty resultList}">
						            <tr>
						                <td style="text-align:center;" colspan="6">데이터가 없습니다.</td>
						            </tr>
						            </c:if>
						        </tbody>
						    </table>
						</div>
					</div>
				</div>
			</div>
			<div id="page_navi" class="pagination">
					<ui:pagination paginationInfo = "${paginationInfo}"
							   type="jnitDefault"
							   jsFunction="fn_egov_link_page"
							   />
					<form:hidden path="pageIndex" />
			</div>
			<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h3 id="myModalLabel"></h3>
				</div>
				<div class="modal-body">

				</div>
				<div class="modal-footer">
					<span id="modalFooter"></span>
					<a href="javascript:Jnit_modal_close();" class="btn">닫기</a>
				</div>
			</div>
		</form:form>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
