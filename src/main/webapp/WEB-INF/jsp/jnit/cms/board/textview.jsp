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
		
		px = $("#code").css("height");
		length = px.length-2;
		str = px.substring(0, length);
		sumVal = Number(str) + Number(50);
		$("#code").css("height",sumVal);
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
		
		px = $("#code").css("height");
		length = px.length-2;
		str = px.substring(0, length);
		sumVal = Number(str) - Number(50);
		$("#code").css("height",sumVal);
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
						<form id="jnitcmstplVO" name="jnitcmstplVO" action="${ctxRoot}/cms/board/pageSave.do" method="POST">
						<input type="hidden" name="fileSave" value="fileSave" />						
						<div class="widget-title">
							<span class="icon"><i class="icon-cog"></i></span>
							<button type="submit" class="btn btn-small"><i class="icon icon-ok"></i> 저장</button>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped th_left" summary="파일설정">
								<tbody>
									<tr>
										<th>파일크기</th>
										<td><span class="filesize"><fmt:formatNumber maxFractionDigits="1" minFractionDigits="1" value="${file['size']}" />k</span></td>
										<th>수정일시</th>
										<td><span class="filedate"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${file['date']}" /></span></td>
									</tr>
								</tbody>
							</table>
							<input type="hidden" name="screenMode" value="" />
							<div class="tplSrcBox" style="padding-top:10px;padding-left:10px;">
								<p><strong>ㆍ 소스 편집</strong>&nbsp;<button id="upView" class="btn btn-small">▼</button> <button id="downView" class="btn btn-small">▲</button></p>
								<textarea id="tplSrc" name="tplSrc" rows="20" style="width:95%" escape="false"><c:out value="${tplSrc}" escapeXml="true" /></textarea>
								<br />
							</div>
						</div>
						</form>						
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
								<b>해당 기능은 크로스사이트 스크립팅을 대비하기 위한 기능입니다.</b><br />
								<b>소스 내의 금칙어를 수정하고 크로스사이트 스크립트 기능에 대비할수 있는 기능입니다.</b>
							</td>
						</tr>
						</tbody>
						</table>
					</div>
				</div>
			</div>
		<%-- Contents End --%>
		</div>
</div>

<div id="modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	</div>
	<div class="modal-body">
		
	</div>
</div>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>