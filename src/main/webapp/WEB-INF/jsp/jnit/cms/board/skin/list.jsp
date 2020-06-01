<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script type="text/javascript">
<!--

/* 스킨 선택 FUNCTION */
function boardSkinSelect(skinNm){
	$("#folderPath").val($("#folderSelect").val());
	$("#skinNm").val(skinNm);
	$("#boardSkinForm").submit();
}

/* 파일 소스 저장 FUNCTION */
function boardSkinSave(){
	$("#folderPath").val($("#folderSelect").val());
	$("#boardSkinForm").attr("action","<c:url value='/cms/board/fileSave.do' />");
	$("#boardSkinForm").submit();
}

/* 파일 소스 초기화 FUNCTION */
function boardSkinReset(){
	$("#folderPath").val($("#folderSelect").val());
	$("#boardSkinForm").attr("action","<c:url value='/cms/board/fileReset.do' />");
	$("#boardSkinForm").submit();
}

/* 게시판 스킨 복사 FUNCTION */
function boardSkinCopy(originSkin){
	
	var targetNm = $.trim($("#targetNm").val());
	
	if(targetNm == ''){
		alert("복사될 게시판 스킨명을 입력해주세요.");
		$("#targetNm").val("");
		$("#targetNm").focus();
		return false;
	}
	$("#folderPath").val($("#folderSelect").val());
	$("#myModal").modal('toggle');
	$("#skinNm").val(originSkin);
	$("#replaceNm").val(originSkin+"-"+targetNm);
	
	$("#boardSkinForm").attr("action","<c:url value='/cms/board/skinCopy.do' />");
	$("#boardSkinForm").submit();
}

/* 게시판 스킨 삭제 FUNCTION */
function boardSkinDelete(thisSkin){
	$("#skinNm").val(thisSkin);
	$("#folderPath").val($("#folderSelect").val());
	$("#boardSkinForm").attr("action","<c:url value='/cms/board/skinDelete.do' />");
	$("#boardSkinForm").submit();
}

/* 페이지 로드 */
function resizeEditor() {
	$('textarea[name=fileSource]').css('height', $("#pageDiv").height()-100);
	$('.CodeMirror').css('width', $("#pageDiv").width()-100);
	$('.CodeMirror').css('height', $("#pageDiv").height()-100);
	$('.CodeMirror-scroll').css('height', $("#pageDiv").height()-100);
	$('.CodeMirror-scrollbar').css('height', $("#pageDiv").height()-100);
}

$(document).ready(function(){
	
	
	
	/* 파일 변경 JQUERY */
	$("#fileNmSelect").on("change", function(){
		$("#fileNm").val($(this).val());
		$("#folderPath").val($("#folderSelect").val());
		$("#boardSkinForm").submit();
	});
	
	$("#folderSelect").on("change", function(){
		$("#folderPath").val($(this).val());
		$("#fileNm").val('');
		$("#skinNm").val('');
		$("#boardSkinForm").submit();
	});
	
	/* 파일 저장 JQUERY */
	$("#sourceSaveBtn").on("click", function(){
		var skinNm = $("#skinNm").val();
		var fileNm = $("#fileNm").val();
		if(confirm(skinNm+" 게시판 스킨의 "+fileNm+" 파일 내용을\n\"저장\" 하시겠습니까?")){
			boardSkinSave();
		}
	});
	
	/* 파일 소스 초기화 JQUERY */
	$("#sourceResetBtn").on("click", function(){
		var skinNm = $("#skinNm").val();
		var fileNm = $("#fileNm").val();
		if(confirm(skinNm+" 게시판 스킨의 "+fileNm+" 파일 내용을\n\"초기화\" 하시겠습니까?")){
			boardSkinReset();
		}
	});
	
	/* 게시판 스킨 복사 MODAL JQUERY */
	$("[name='boardSkinCopyBtn']").on("click", function(){
		$("#targetSkin").text($(this).val());
		$("#skinCopyBtn").val($(this).val());
		$("#myModal").modal('toggle');
	});
	
	/* 게시판 스킨 복사 JQUERY */
	$("#skinCopyBtn").on("click", function(){
		boardSkinCopy($(this).val());
	});
	
	/* 게시판 스킨 복사 MODAL 닫기 JQUERY */
	$("#skinCopyCloseBtn").on("click", function(){
		$("#myModal").modal("toggle");
		$("#targetNm").val("");
	});
	
	/* 게시판 스킨 삭제 JQUERY */
	$("[name='boardSkinDeleteBtn']").on("click", function(){
		var thisVal = $(this).val();
		if(confirm(thisVal+" 게시판 스킨을 \"삭제\" 하시겠습니까?\n\n[경고] 삭제하시면 복구가 불가능 합니다.")){
			boardSkinDelete(thisVal);
		}
	});
	
	/* 파일 소스 에디터 적용 */
	try {
		CodeEditor = CodeMirror.fromTextArea(document.getElementById("fileSource"), {
		  mode: "application/xml",
		  lineNumbers: true,
		  lineWrapping: true,
		  onCursorActivity: function() {
		    CodeEditor.setLineClass(CodeHl, null, null);
		    CodeHl = CodeEditor.setLineClass(CodeEditor.getCursor().line, null, "activeline");
		  }
		});
		CodeHl = CodeEditor.setLineClass(0, "activeline");
		
		resizeEditor();
	}catch(e) {
		//
	}
	
	resizeEditor();
	$(window).bind('resize', resizeEditor());
	$('.CodeMirror').css('width','');
});
// -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<div class="list_content2">
			<%-- Contents Start --%>
			<div class="row-fluid">
	           	<div class="span4">
	               	<div class="widget-box">
	                   	<div class="widget-title">
							
							<select name="folderSelect" id="folderSelect" title="스킨 리스트" >
							<option value="empty" <c:out value="${folderPath == 'empty' || folderPath == null ? 'selected' : ''}" />>스킨 선택</option>
							<c:forEach var="item" items="${skinList}">
			                	<option value="<c:out value="${item}" />" <c:out value='${item == folderPath ? "selected" : "" }'/>><c:out value="${item}" /></option>
			                </c:forEach>
							</select>
	                    </div>
	                    <div class="widget-content nopadding" style="overflow: auto; height: 596px;">
							<table class="table table-bordered table-striped table-hover" summary="그룹 테이블">
								<thead>
									<tr>
										<th align="center">게시판 유형</th>
										<th align="center">복사</th>
										<th align="center">삭제</th>
									</tr>
									</thead>
									<tbody>
										<c:forEach var="result" items="${skinJArr}" varStatus="status">
											<tr>
												<td align="center"><a href="javascript:boardSkinSelect('${result}')" ${result == skinNm ? "style='font-weight: bold; color: red;'" : ''}><c:out value="${result}" /></a></td>
												<td align="center"><button id="boardSkinCopyBtn${status.count}" name="boardSkinCopyBtn" class="btn btn-mini" style="width: 100%;" value="${result}">복사</button></td>
												<td align="center">
													<c:if test="${result != '_business' && result != '_calendar' && result != '_calendar_mobile' && result != '_contribution'  && result != '_faq' && result != '_faq_mobile' && result != '_gallery' && result != '_gallery(pro)' && result != '_gallery_mobile' && result != '_movie' && result != '_movieLink' && result != '_movie_mobile' && result != '_normal' && result != '_normal_mobile' && result != '_schedule' && result != '_scheduleList' && result != '_scheduleList_mobile' && result != '_schedule_mobile' && result != '_thumbnail' && result != '_thumbnail_mobile'&& result != '_inquiry'}">
														<button id="boardSkinDeleteBtn${status.count}" name="boardSkinDeleteBtn" class="btn btn-mini" style="width: 100%;" value="${result}">삭제</button>
													</c:if>
												</td>
											</tr>
										</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
         		<div class="span8">
             		<div id="pageDiv" class="widget-box" style="height: 641px;">
                 		<div class="widget-title">
							<h3><c:out value="${skinNm}" /></h3>
							<button id="sourceSaveBtn" name="sourceSaveBtn" class="btn" style="margin-left: 30px;">저장</button>
							<button id="sourceResetBtn" name="sourceResetBtn" class="btn" style="float: right; margin-right: 5px;">소스 초기화</button>
						</div>
						<div class="widget-content nopadding">
							<form name="boardSkinForm" id="boardSkinForm" method="post" action="<c:url value='/cms/board/skinList.do' />">
								<input type="hidden" id="skinNm" name="skinNm" value="${skinNm}" />
								<input type="hidden" id="fileNm" name="fileNm" value="${fileNm}" />
								<input type="hidden" id="replaceNm" name="replaceNm" />
								<input type="hidden" id="folderPath" name="folderPath" />
								
								<table class="table table-bordered table-striped th_left" summary="파일설정">
									<tbody>
										<tr>
											<th>파일선택&nbsp;
												<select id="fileNmSelect" name="fileNmSelect" style="width: 30%;">
													<c:forEach var="result" items="${fileObj[skinNm]}" varStatus="status">
														<c:if test="${result != 'origin' }">
															<option value="${result}" ${result == fileNm ? 'selected' : ''}><c:out value="${result}" /></option>
														</c:if>
													</c:forEach>
												</select>
											</th>
										</tr>
									</tbody>
								</table>
								<div class="fileSourceBox" style="padding-top:10px;padding-left:10px;">
								<textarea id="fileSource" name="fileSource" style="width: 98%; height:526px;"><c:out value="${fileSource }" /></textarea>
								<br>
							</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<div class="widget-box">
					<div class="widget-content nopadding cmstipbox">
						<table class="table table-bordered table-striped th_left">
						<caption>cms TIP</caption>
						<tbody>
						<tr>
							<th colspan="2">
								<span class="icon" style=" font-size: 20px; font-weight: bold; "><i class="icon-lightbulb"></i> TIP</span>
							</th>
							<td>
								<b>각 게시판 스킨의 html 코드를 수정하시거나 새로운 게시판 스킨을 만드실 수 있습니다.</b>
							</td>
						</tr>
						</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
  <div class="modal-header">
    <h3 id="myModalLabel" style="text-align: center;">게시판 스킨 복사</h3>
  </div>
  <div class="modal-body">
  	복사할 게시판 스킨명 :&nbsp;&nbsp;<strong style="color: red; font-weight: bold;" id="targetSkin" name="targetSkin"></strong><br />
	복사될 게시판 스킨명 :&nbsp;&nbsp;<input type="text" id="targetNm" name="targetNm" /><br /><br />	
	<strong>복사될 게시판 스킨의 스킨명은 <font color="red">_복사대상명-스킨명</font>으로 사용되어집니다.<br />
	ex) <font color="red">_normal-testSkin</font></strong>
  </div>
  <div class="modal-footer">
  	<button id="skinCopyBtn" name="skinCopyBtn" class="btn btn-primary" style="float: left; width: 49%; " value="">적용</button>
  	<button id="skinCopyCloseBtn" name="skinCopyCloseBtn" class="btn" style="width: 49%; ">취소</button>
  </div>
</div>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>