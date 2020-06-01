<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javascript">
<!--
$(document).ready(function(){
	var message = $("#tplSrc").val();
	var comm = "";
	
	comm = /<!(.*?)>/g;
		message = message.replace(comm, '');
	comm = /<\!--(.*?)--\>/g;
		message = message.replace(comm, '');
	comm = /<\%(([^>]{1})(.*?))*?%\>/g;
		message = message.replace(comm, '');
	comm = /<link(.*?)\>/g;
		message = message.replace(comm, '');
	comm = /<meta(.*?)\>/g;
		message = message.replace(comm, '');
	comm = /<script(([^>]{1})(.*?))*?\/script>/g;
		message = message.replace(comm, '');
		
	$("#htmlView").empty();
	$("#htmlView").html(message);
	
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
	
	
	
	$("#tplSrc").keyup(function(){
		
		var message = $("#tplSrc").val();
		var comm = "";
		
		comm = /<!(.*?)>/g;
			message = message.replace(comm, '');
		comm = /<\!--(.*?)--\>/g;
			message = message.replace(comm, '');
		comm = /<\%(([^>]{1})(.*?))*?%\>/g;
			message = message.replace(comm, '');
		comm = /<link(.*?)\>/g;
			message = message.replace(comm, '');
		comm = /<meta(.*?)\>/g;
			message = message.replace(comm, '');
		comm = /<script(([^>]{1})(.*?))*?\/script>/g;
			message = message.replace(comm, '');
		
		$("#htmlView").empty();
		$("#htmlView").html(message);
	});
});
//-->
</script>


<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_skeleton container-fluid">
	<%-- Contents Start --%>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<form:form commandName="jnitcmstplVO" action="${ctxRoot}/cms/rsc/save.do">
					<input type="hidden" name="fileSave" value="fileSave" />
					<div class="widget-title">
						<span class="icon"><i class="icon-cog"></i></span>
						<button type="submit" class="btn btn-small"><i class="icon icon-ok"></i> 저장</button>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered table-striped th_left" summary="파일설정">
							<tbody>
								<tr>
									<th style="width:15%;">파일크기</th>
									<td style="width:35%;"><span class="filesize"><fmt:formatNumber maxFractionDigits="1" minFractionDigits="1" value="${file.size}" />k</span></td>
									<th style="width:15%;">수정일시</th>
									<td style="width:35%;"><span class="filedate"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${file.date}" /></span></td>
								</tr>
							</tbody>
						</table>
						<input type="hidden" name="screenMode" value="" />
						<input type="hidden" name="siteId" value="" />
						<input type="hidden" name="tplId" value="" />
						<input type="hidden" name="sitePath" value="<c:out value="${sitePath}" />" />
						<input type="hidden" name="searchKeyword" value="<c:out value="${param.bindType}" />,<c:out value="${param.dirType}" />,<c:out value="${param.fileName}" />" />	
						<input type="hidden" name="bindType" value="<c:out value="${bindType}" />" />
						<div class="tplSrcBox" style="padding-top:10px;padding-left:10px;">
							<p><strong>ㆍ 소스 편집</strong>&nbsp;<button id="upView" class="btn btn-small">▼</button> <button id="downView" class="btn btn-small">▲</button></p>
							<form:textarea path="tplSrc" rows="20" style="width:95%" escape="false"/><br />
							<form:errors path="tplSrc" />
						</div>
					</div>
					</form:form>
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
							<b>페이지 평가의 상세보기 페이지의 디자인을 수정할 수 있는 페이지 입니다.</b>
						</td>
					</tr>
					</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>