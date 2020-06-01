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
function save(){
	var subTpl = $('#subTpl').val();
	
	if(subTpl == ""){
		alert("서브메뉴를 선택해주시기 바랍니다.");
		document.subTpl.focus();
		return false;
	}
	return true;
}

/* 글 등록 function */
function fn_egov_save() {	
    /* ClientSite Validator */
	//if(!validateJnitcmstplVO(frm)){
	//		return;
	//}
	frm = document.getElementById("jnitcmstplVO");	
	if(save() == true){		
		frm.action = "<c:url value='/cms/sub4/0104up.do'/>?tplType=${jnitcmstplVO.tplType}";
	    frm.submit();	
	}	
}

function resizeEditor() {
	$('div.view').css('padding-left', 10);
	$('div.view').css('overflow', 'hidden');
	$('textarea[name=cntSrc]').css('height', $(window).height()-100);
	$('.CodeMirror').css('width', $(window).width()-300 );
	$('.CodeMirror').css('height', $(window).height()-300 );
	$('.CodeMirror-scroll').css('height', $(window).height()-300 );
	$('.CodeMirror-scrollbar').css('height', $(window).height()-300 );	
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
	
});
// -->
</script>
<style>
#s2id_subTplList{width:100%;};
</style>
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
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="jnitcmstplVO">
			<input type="hidden" name="screenMode" value="up" />
			<input type="hidden" name="siteId" value="<c:out value="${searchVO.siteId}" />" />
			<input type="hidden" name="sitePath" value="<c:out value="${searchVO.sitePath}" />" />
			<input type="hidden" name="tplId" id="tplId" value="<c:out value="${jnitcmstplVO.tplId}" />" />			
				<!--p class="MAT20"><strong>ㆍ 템플릿 뷰</strong></p>
				<iframe src="<c:url value="/${searchVO.sitePath}" />/signup.jsp" style="width:100%; height:300px;"></iframe><br/><br/-->
				
				<!-- subTplList -->
				<div class="row-fluid">
					<div class="span12">
						<div class="widget-box">
							<div class="widget-title">
								<span class="icon"><i class="icon-th"></i></span>
								<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
								&nbsp;&nbsp;<a href="javascript:fn_egov_hist();" class="btn btn-small"><i class="icon-book"></i> 히스토리</a>
								<a href="<c:url value="/${searchVO.sitePath}" />${tplTypePath != '' ? tplTypePath : '/mbr/signup.jsp'}" target="_blank" title="새 창으로 열립니다." class="btn btn-small"><i class="icon-share-alt"></i> 템플릿 미리보기</a>
								<button id="upView" class="btn btn-small">▼</button> <button id="downView" class="btn btn-small">▲</button>				
							</div>
							<div class="widget-content nopadding">
								<table class="table table-bordered">
									<tr>
										<th style="width:20%;">적용할 템플릿 선택 </th>
										<td>	
										    <select id="subTplList" name="subTplList" >
												<option value=" " <c:out value="${' ' == tplDesc ? 'selected' : ''}"/>>--서브템플릿 사용안함--</option>
										    	<c:forEach var="subTplList" items="${subTplList }">										    		
										    		<option value="${subTplList.tplId }" <c:out value="${tplDesc == subTplList.tplId ? 'selected' : ''}"/>>${subTplList.tplNm }</option>
										    	</c:forEach>
										    </select>
										</td>										
									</tr>								
									<c:if test="${errorCodeList != null }" >
									<tr>
										<th colspan="2"><font color="red">${errorMessage}</font></th>
									</tr>
									<tr>
										<th><font color="red"> 적용되지않은 코드 List</font>
										<td><font color="red"> ${errorCodeList }</font></td>
									</tr>																	
									</c:if>																	
								</table>
								
                                <div class="tplSrcBox" style="padding-top:10px;padding-left:10px;">
                                    <p class="MAT20"><strong>ㆍ 템플릿 소스
                                        <c:if test="${newFileCnt == 'Y'}"><span style="color:red;">(서버에서 변경된 페이지입니다)</span></c:if>
                                        <c:if test="${notFileCnt == 'Y'}"><span style="color:red;">(파일이 없습니다)</span></c:if>
                                    </strong></p>
                                    <form:textarea path="tplSrc" rows="20" style="width:99%" escape="false"/><br />
                                    <form:errors path="tplSrc" /><br />
                               	</div>
							</div>
						</div>						
					</div>			 	
				</div>
				</div>
			</form:form>
		<%-- Contents End --%>
	</div>
</div>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
