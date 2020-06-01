<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>
<script type="text/javaScript" language="javascript" defer="defer">
//<!--
/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitcmstplVO");
	frm.action = "<c:url value='/cms/tpl/pageUp.do'/>";
    frm.submit();
}

function resizeEditor() {
	$('div.view').css('padding-left', 10);
	$('div.view').css('overflow', 'hidden');
	$('textarea[name=cntSrc]').css('height', $(window).height()-100);
	$('.CodeMirror').css('width', $(window).width()-300 );
	$('.CodeMirror').css('height', $(window).height()-500 );
	$('.CodeMirror-scroll').css('height', $(window).height()-500 );
	$('.CodeMirror-scrollbar').css('height', $(window).height()-500 );
}

function fn_egov_hist(){
	$.ajax({
		type:"post",
		url:"<c:url value='/cms/ajax/tpl/hist/list.do'/>",
		data: "tplId="+$("#tplId").val()
	}).done(function(data){		
		$("#histList").empty();
		$("#histList").append(data);
		$('#myModal').modal('toggle');
	});
}

$(document).ready(function(){
	resizeEditor();
	$(window).bind('resize', resizeEditor);
	$('.CodeMirror').css('width','');
	//$('.CodeMirror').css('height', $(window).height()-200 );
	
	/*
	var message = $("#tplSrc").val();
	var comm = "";
	var res = "";
	
	comm = /<!(.*?)>/g;
		res = message.replace(comm, '');
	comm = /<\!--(.*?)--\>/g;
		res = message.replace(comm, '');
	comm = /<\%(([^>]{1})(.*?))*?%\>/g;
		res = res.replace(comm, '');
	comm = /<link(.*?)\>/g;
		res = res.replace(comm, '');
	comm = /<meta(.*?)\>/g;
		res = res.replace(comm, '');
	comm = /<script(([^>]{1})(.*?))*?\/script>/g;
		res = res.replace(comm, '');
		

	$("#htmlView").empty();
	$("#htmlView").html(res);
	*/
	
	$("#upView").click(function(e){
		e.preventDefault();
		
		var px = "";
		var length = "";
		var str = "";
		var sumVal = "";
		
		if($(".CodeMirror").css("height") != null || $(".CodeMirror").css("height") == ''){
			px = $(".CodeMirror").css("height");
			length = px.length-2;
			str = px.substring(0, length);
			sumVal = Number(str) + Number(50);
			$(".CodeMirror").css("height",sumVal);
			$(".CodeMirror-scroll").css("height",sumVal);
		}
		
		px = $("#tplSrc").css("height");
		length = px.length-2;
		str = px.substring(0, length);
		sumVal = Number(str) + Number(50);
		$("#tplSrc").css("height",sumVal);
	});
	
	$("#downView").click(function(e){
		e.preventDefault();
		
		var px = "";
		var length = "";
		var str = "";
		var sumVal = "";
		
		if($(".CodeMirror").css("height") != null || $(".CodeMirror").css("height") == ''){
			px = $(".CodeMirror").css("height");
			length = px.length-2;
			str = px.substring(0, length);
			sumVal = Number(str) - Number(50);
			$(".CodeMirror").css("height",sumVal);
			$(".CodeMirror-scroll").css("height",sumVal);
		}
		
		px = $("#tplSrc").css("height");
		length = px.length-2;
		str = px.substring(0, length);
		sumVal = Number(str) - Number(50);
		$("#tplSrc").css("height",sumVal);
	});
	
	$("#upHtml").click(function(e){
		e.preventDefault();
		
		var px = $("#htmlView").css("height");
		var length = px.length-2;
		var str = px.substring(0, length);
		var sumVal = Number(str) + Number(50);
		$("#htmlView").css("height",sumVal);
	});
	
	$("#downHtml").click(function(e){
		e.preventDefault();
		
		var px = $("#htmlView").css("height");
		var length = px.length-2;
		var str = px.substring(0, length);
		var sumVal = Number(str) - Number(50);
		$("#htmlView").css("height",sumVal);
	});
	
	/*
	$("#tplSrc").keyup(function(){
		
		var message = $("#tplSrc").val();
		var comm = "";
		var res = "";
		
		comm = /<!(.*?)>/g;
			res = message.replace(comm, '');
		comm = /<\%(([^>]{1})(.*?))*?%\>/g;
			res = res.replace(comm, '');
		comm = /<link(.*?)\>/g;
			res = res.replace(comm, '');
		comm = /<meta(.*?)\>/g;
			res = res.replace(comm, '');
		comm = /<script(([^z]{1})(.*?))*?\/script>/g;
			res = res.replace(comm, '');
			

		$("#htmlView").empty();
		$("#htmlView").html(res);
	});
	*/
	
});
// -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>				
		<form:form commandName="jnitcmstplVO">
			<input type="hidden" name="screenMode" value="up" />
			<input type="hidden" name="siteId" value="<c:out value="${searchVO.siteId}" />" />
			<input type="hidden" name="sitePath" value="<c:out value="${searchVO.sitePath}" />" />
			<input type="hidden" name="tplId" id="tplId" value="<c:out value="${jnitcmstplVO.tplId}" />" />
			<input type="hidden" name="tplNm" id="tplNm" value="<c:out value="${jnitcmstplVO.tplNm}" />" />
			<div class="widget-box">
				<div class="widget-title">
					<h3>메인템플릿 등록</h3>
					<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
					&nbsp;&nbsp;<a href="javascript:fn_egov_hist();" class="btn btn-small"><i class="icon-book"></i> 히스토리</a>
					<c:if test="${!empty codeList }">
						<font color="red"><c:out value="적용되지않는 리스트 : ${codeList }"/></font>
						<input type="hidden" name="codeList" id="codeList" value="<c:out value="${codeList }"/>" />
					</c:if>                
				</div>
				<div class="widget-content nopadding">            
					<div class="tplSrcBox" style="padding-top:10px;padding-left:10px;">
						<p class="MAT20"><strong>ㆍ 템플릿 소스
						<c:if test="${newFileCnt == 'Y'}"><span style="color:red;">(서버에서 변경된 페이지입니다)</span></c:if>
						<c:if test="${notFileCnt == 'Y'}"><span style="color:red;">(파일이 없습니다)</span></c:if>
						</strong><button id="upView" class="btn btn-small">▼</button> <button id="downView" class="btn btn-small">▲</button></p>
						<div class="control-group">
							<div class="controls">
								<form:textarea path="tplSrc" id="tplSrc" style="width:99%; " rows="30" escape="false"/><br />
								<form:errors path="tplSrc" /><br/>
							</div>
						</div>
					</div>                
				</div>
			</div>       
		</form:form>
		<table class="table table-bordered th_left">
			<tr>			
			  	<th>{-CSS-}</th> 
			  	<td>&lt;link rel=\stylesheet\ type=\text/css\ href=\/${Jnit_sitePath}/common/css/Jnit_print.css\ media=\all\></td> 
			</tr>			
			<tr>			
			  	<th>{-CONFIG_CSS-}</th> 
			  	<td>CSS 파일 호출 코드</td> 
			</tr>
			<tr>			
			  	<th>{-CONFIG_JS-}</th> 
			  	<td>JS 파일 호출 코드</td> 
			</tr>
			<tr>			
			  	<th>{-PAGETITLE-}</th> 
			  	<td>콘텐츠페이지 제목 텍스트 표시</td> 
			</tr>
			<tr>			
			  	<th>{-PAGELINKNAV-}</th> 
			  	<td>콘텐츠페이지 링크 네비게이션 HTML 표시</td> 
			</tr>
			<tr>			
			  	<th>{-PRINT_CONTENT-}</th> 
			  	<td>
			  		&lt;script type="text/javascript">document.write($(".content", opener.document).html());</script>
			  		<br />
			  		.content 를 수정하면 프린트 영역을 제어할 수 있습니다
			  	</td> 
			</tr>
			
			
		</table>
		<%-- Contents End --%>
	</div>
</div>

<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Modal header</h3>
  </div>
  <div class="modal-body">
    <div id="histList"></div>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>
    <!-- <button class="btn btn-primary">Save changes</button> -->
  </div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>

