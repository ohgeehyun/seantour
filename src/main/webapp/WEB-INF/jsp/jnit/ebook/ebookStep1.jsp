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
<%@ include file="/WEB-INF/jsp/jnit/include/cms/codeMirror.jsp" %>

<c:set var="registerFlag" value="${empty jnitebookVO.ebookId ? '등록' : '수정'}"/>
<script src="<c:url value="/js/tableDnD.js"/> "></script>
<script src="<c:url value="/resources/js/jquery.form.js"/>"></script>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitebookVO").action = "<c:url value='/cms/ebook/list.do'/>";
   	document.getElementById("jnitebookVO").submit();		
}

function fn_egov_save_bln(){
	var ebookTitle = $("#ebookTitle").val();
	var pageWidth = $("#pageWidth").val();
	var pageHeight = $("#pageHeight").val();
	var thumbAotoHide = $("#thumbAotoHide").val();
	var thumbWidth = $("#thumbWidth").val();
	var thumbHeight = $("#thumbHeight").val();	
	var shareLink = $("#shareLink").val();
	
	if(ebookTitle == '' || ebookTitle == null){
		alert("제목을 입력해 주시기 바랍니다.");
		$("#ebookTitle").focus();
		return false;
	}else if(pageWidth.match("^[0-9]+$") == null){
		alert("숫자만 입력해주시기 바랍니다.");
		$("#pageWidth").focus();
		return false;
	}else if(pageHeight.match("^[0-9]+$") == null){
		alert("숫자만 입력해주시기 바랍니다.");
		$("#pageHeight").focus();
		return false;
	}else if(thumbAotoHide.match("^[0-9]+$") == null){
		alert("숫자만 입력해주시기 바랍니다.");
		$("#thumbAotoHide").focus();
		return false;
	}else if(thumbWidth.match("^[0-9]+$") == null){
		alert("숫자만 입력해주시기 바랍니다.");
		$("#thumbWidth").focus();
		return false;
	}else if(thumbHeight.match("^[0-9]+$") == null){
		alert("숫자만 입력해주시기 바랍니다.");
		$("#thumbHeight").focus();
		return false;
	}else if(shareLink.match("^http://") == null){
		alert("링크 주소에는 http://로 시작하는 문구를 입력 하셔야 됩니다.");
		$("#shareLink").focus();
		return false;
	}
	return true;
}

/* 글 등록 function */
function fn_egov_save() {
	if(confirm("다음단계로 넘어가시겠습니까?")){
		if(fn_egov_save_bln()){
			frm = document.getElementById("jnitebookVO");
			frm.action = "<c:url value='/cms/ebook/edit.do'/>";
		   frm.submit();
		}
	}
}

function thumb(){
	if($("#thumbYn0").is(":checked")){
		$(".thumb").css("display","");
	}else{
		$(".thumb").css("display","none");
	}
}

$(document).ready(function(){
	//썸네일 셋팅
	thumb();	
	$("#thumbYn0").click(function(){
		thumb();
	});
	$("#thumbYn1").click(function(){
		thumb();
	});
	//링크주소 셋팅
	var shareLink = $("#shareLink").val();
	$("#shareLink").val(shareLink != '' ? shareLink : "http://");
});
// -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="jnitebookVO" method="post" enctype="multipart/form-data">
		<form:hidden path="ebookId" id="ebookId" cssClass="txt" readonly="false" />
		<input type="hidden" name="countAddFields" id="countAddFields" value="${countAddFields == '' || countAddFields == null ? 1 : countAddFields }" />
		<input type="hidden" name="uploadAddFields" id="uploadAddFields" value="${uploadAddFields == '' || uploadAddFields == null ? 1 : uploadAddFields }" />
		<input type="hidden" name="step" id="step" value="1" />
		<c:if test="${registerFlag == '수정'}">
			<input type="hidden" name="screenMode" value="up" />	   
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			<input type="hidden" name="screenMode" value="" />	   	
		</c:if>	
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<a href="javascript:fn_egov_selectList();" class="btn btn-small">목록</a>
						<a href="javascript:fn_egov_save();" class="btn btn-small">다음단계</a>
						<c:if test="${registerFlag == '수정'}">
							<a href="javascript:fn_egov_delete();" class="btn btn-small">삭제</a>&nbsp;&nbsp;&nbsp;																								
							<a href="<c:url value="/upload/ebook/${jnitebookVO.ebookId }/ebook/index.html"/>" target="_blank" title="새창으로 열립니다." class="btn btn-small">미리보기</a>
						</c:if>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered">
							<tr>
								<th>제목</th>
								<td colspan="2">
									<form:input path="ebookTitle" id="ebookTitle" cssClass="txt" cssStyle="width:98%"/><form:errors path="ebookTitle" />
								</td>
							</tr>
							<tr>
								<th rowspan="5">환경설정</th>
								<th style="width: 23%;">VIEW 모드 선택</th>
								<td>
									<input type="radio" name="ext02" value="0" <c:out value="${jnitebookVO.ext02 == '0' ? 'checked' : '' }"/>>커버형
									<input type="radio" name="ext02" value="1" <c:out value="${jnitebookVO.ext02 == '1' ? 'checked' : '' }"/>>펼침형  
								</td>
							</tr>
							<tr>
								<th style="vertical-align: middle;">책자 이미지 크기</th>
								<td>								
									가로 : <input type="text" id="pageWidth" name="pageWidth" value="${jnitebookVO.pageWidth == 0 ? '450' : jnitebookVO.pageWidth}"/>&nbsp;&nbsp;
									세로 : <input type="text" id="pageHeight" name="pageHeight" value="${jnitebookVO.pageHeight == 0 ? '637' : jnitebookVO.pageHeight}"/>
								</td>
							</tr>							
							<tr>
								<th>미리보기(썸네일) 사용여부</th>
								<td>									
									<input type="radio" id="thumbYn0" name="thumbYn" value="true" <c:out value="${jnitebookVO.thumbYn == 'true' ? 'checked' : '' }"/>>사용함
									<input type="radio" id="thumbYn1" name="thumbYn" value="false" <c:out value="${jnitebookVO.thumbYn == 'false' ? 'checked' : '' }"/>>사용안함
								</td>
							</tr>
							<tr class="thumb" style="display: none;">
								<th>미리보기 설정</th>
								<td style="vertical-align: middle;">
									표시 시간 : <input type="text" id="thumbAotoHide" name="thumbAotoHide" value="${jnitebookVO.thumbAotoHide == 0 ? '10000' : jnitebookVO.thumbAotoHide}" />
									가로 크기 : <input type="text" id="thumbWidth" name="thumbWidth" value="${jnitebookVO.thumbWidth == 0 ? '80' : jnitebookVO.thumbWidth}" />
									세로 크기 : <input type="text" id="thumbHeight" name="thumbHeight" value="${jnitebookVO.thumbHeight == 0 ? '100' : jnitebookVO.thumbHeight}" />
								</td>
							</tr>
							<tr>
								<th>SNS 기본 멘트 설정</th>			
								<td style="vertical-align: middle;">
									홈페이지주소 : <form:input path="shareLink" id="shareLink"/>&nbsp; 
									한줄 기업소개 : <form:input path="shareText"/>&nbsp;
									회사명 : <form:input path="shareVia"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>	
		<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
		<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>