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
	if(document.getElementById("staticType").value == 1){
		if(confirm("일반 저장시 HTML 기능이 해제 됩니다. 계속 하시겠습니까?")){
			document.getElementById("staticType").value = 0
			frm = document.getElementById("jnitcmstplVO");
			frm.action = "<c:url value='/cms/sub4/0101up.do'/>";
		    frm.submit();
		}
	}else{
		frm = document.getElementById("jnitcmstplVO");
		frm.action = "<c:url value='/cms/sub4/0101up.do'/>";
	    frm.submit();	
	}

}

function save_make_html() {	
	if(confirm("메인 페이지를 HTML로 적용 하시겠습니까?")){
		frm = document.getElementById("jnitcmstplVO");
		frm.action = "<c:url value='/cms/sub4/mainToHtml.do'/>";
	    frm.submit();	
	}
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
			<input type="hidden" name="staticType" id="staticType" value="<c:out value="${jnitcmstplVO.staticType}" />" />	
				
			<div class="widget-box">
				<div class="widget-title">
					<h3>메인템플릿 등록</h3>
					<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
					&nbsp;&nbsp;
					<a href="javascript:save_make_html();" class="btn btn-small"><i class="icon-ok-sign"></i>HTML 적용</a>
					&nbsp;&nbsp;
					<a href="javascript:fn_egov_hist();" class="btn btn-small"><i class="icon-book"></i> 히스토리</a>
					<c:if test="${!empty codeList }">
						<font color="red"><c:out value="적용되지않는 리스트 : ${codeList }"/></font>
						<input type="hidden" name="codeList" id="codeList" value="<c:out value="${codeList }"/>" />
					</c:if>                
					<a href="<c:url value="/${searchVO.sitePath}" />" target="_blank" title="새 창으로 열립니다." class="btn btn-small"><i class="icon-share-alt"></i> 템플릿 미리보기</a>
				</div>
				<div class="widget-content nopadding">            
					<div class="tplSrcBox" style="padding-top:10px;padding-left:10px;">
						<p class="MAT20"><strong>메인템플릿ㆍ
						<c:if test="${jnitcmstplVO.staticType == 0}">
							<c:if test="${newFileCnt == 'Y'}"><span style="color:red;">(서버에서 변경된 페이지입니다)</span></c:if>
							<c:if test="${notFileCnt == 'Y'}"><span style="color:red;">(파일이 없습니다)</span></c:if>
						</c:if>
						<c:if test="${jnitcmstplVO.staticType == 1}">
							<span style="color:red;">(HTML이 적용된 상태입니다)</span>
						</c:if>
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
				<th colspan="2">필수코드는 <font color="red">빨강색</font>입니다.</th>
			</tr>					
			<tr>			
			  	<th><font color="red">{-CONFIG_CSS-}</font></th> 
			  	<td>CSS 파일 호출 코드</td> 
			</tr>			
			<tr>			
			  	<th><font color="red">{-CONFIG_JS-}</font></th> 
			  	<td>JS 파일 호출 코드</td> 
			</tr>
			<tr>			
			  	<th>{-STATE-} / {-STATE_TOTAL-} / {-STATE_TODAY-} / {-STATE_YESTERDAY-}</th> 
			  	<td>사이트별 통계 호출 코드 / 총 접속자 수 / 오늘 접속자 수 / 어제 접속자 수</td> 
			</tr>
			<%-- 2015-11-10 by.나성재 수정
			<tr>
				<th>
					&lt;jsp:include page=&quot;/&#36;&#123;ctxRoot&#125;/board/latest.do&quot;&gt;<br />
					&lt;jsp:param name=&quot;board_id&quot; value=&quot;게시판코드&quot;/&gt;<br />
					&lt;jsp:param name=&quot;count&quot; value=&quot;7&quot;/&gt;<br />
					&lt;jsp:param name=&quot;type&quot; value=&quot;main&quot;/&gt;<br />
					&lt;jsp:param name=&quot;base_path&quot; value=&quot;콘텐츠경로&quot;/&gt;<br />
					&lt;/jsp:include&gt;
				</th>
				<td>
					최근 게시판 삽입 형식<br />
					board_id : 게시판 아이디<br />
					count : 가져올 게시물수<br />
					type : 출력될 유형<br />
					base_path : 콘텐츠 경로<br />
				</td>
			</tr> --%>	 
			<tr>
				<th>
					&lt;jsp:include page="/make/allim/allim/html/알리미코드.jsp" flush="false" &gt;&lt;/jsp:include&gt;								
				</th>
				<td>알리미 기본 삽입형식</td>
			</tr>
			<tr>
				<th>
					&lt;jsp:include page="/make/allim/banner/html/배너코드.jsp?bannerMorePath=더보기 경로" flush="false" &gt;&lt;/jsp:include&gt;								
				</th>
				<td>배너 삽입형식</td>
			</tr>
			<tr>
				<th>
					&lt;jsp:include page="/make/allim/popup/html/팝업코드.jsp" flush="false" &gt;&lt;/jsp:include&gt;								
				</th>
				<td>팝업 삽입형식</td>
			</tr>
			<tr>
				<th>
					&lt;c:import url="/menu/getTopMenu.do"&gt;<br />
					&lt;c:param name="target" value="[탑메뉴 명칭]" /&gt;<br />
					&lt;c:param name="menuNm" value="[출력할 메뉴 명칭]" /&gt;<br />
					&lt;c:param name="depth" value="[출력할 뎁스]" /&gt;<br />
					&lt;c:param name="order" value="[class 순서 ex: 0]" /&gt;<br />
					&lt;/c:import&gt;
				</th>
				<td>
					target : 탑메뉴 명칭 ex) sample<br />
					menuNm : 출력할 메뉴 이름 ( 1뎁스 )<br />
					depth : 출력하고 싶은 뎁스 입력 ex) 3<br />
					order : class 순서 ex : 0
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

