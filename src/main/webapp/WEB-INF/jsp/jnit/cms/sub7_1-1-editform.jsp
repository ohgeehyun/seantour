<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header_skeleton.jsp" %>
<%@ include file="/WEB-INF/jsp/jnit/include/cms/codeMirror.jsp" %>
<script type="text/javaScript" language="javascript" defer="defer">
// <!--
function fn_egov_save() {	
	frm = document.getElementById("jnitcmscntvtVO");

	frm.action = "<c:url value='/cms/sub7/0101up.do'/>";
    frm.submit();
}

function fn_egov_selectList() {
	opener.location.reload();
	self.close();
}

function resizeEditor() {
	$('td.content_1').css('width', $(window).width()-150 );
	$('td.content_1').css('margin-right', '10px');
	$('textarea[name=cntSrc]').css('height', $(window).height()-376 );
	$('iframe#previewFrame').css('width', $(window).width()-15 );
	$('iframe#previewFrame').css('height', $(window).height()-56 );
	$('.CodeMirror').css('width', $(window).width()-15 );
	$('.CodeMirror').css('height', $(window).height()-386 );
	$('.CodeMirror-scroll').css('height', $(window).height()-386 );
	$('.CodeMirror-scrollbar').css('height', $(window).height()-386 );
}

$(document).ready(function(){
	resizeEditor();
	$(window).bind('resize', resizeEditor);
	$('.CodeMirror').css('width',''); 
	$('.CodeMirror').css('height', $(window).height()-370 ); 
});

function editMode() {
	$('#previewArea').hide();
	$('#editArea').show();
	$('#prevLi').removeClass('on');
	$('#editLi').addClass('on');
}

function previewMode() {
	$('#editArea').hide();
	$('#previewArea').show();
	$('#editLi').removeClass('on');
	$('#prevLi').addClass('on');
}

function loadHistory() {
	var msgPop = window.open('<c:url value="/cms/sub7/history.do?prefixSiteId=${siteVO.siteId}&prefixMenuId=${jnitcmscntvtVO.menuId}&prefixCntId=${jnitcmscntvtVO.cntId}"/>', 'HISTORY_WINDOW', 'resizable=yes scrollbars=no width=460 height=500');
}
// -->
</script>


<style>
body {
	background:none;
	margin:0px;
	padding:5px;
	margin-bottom:0px;
	padding-bottom:0px;
}

ul#tab {
	height:30px;
	margin:0px;
	border-bottom:2px #ccc solid;
	margin-bottom:10px;
}

ul#tab li a {
	font-size:12px;
	font-weight:normal;
	color:#333;
}

ul#tab li {
	width:100px;
	border:1px #ccc solid;
	float:left;
	text-align:center;
	padding-top:5px;
	padding-bottom:5px;
}

ul#tab li.on a {
	font-size:12px;
	font-weight:bold;
	color:#fff;
}

ul#tab li.on {
	background-color:#555555;
}

div#previewArea {
	display:none;
	float:left;
}

td.content_1 {
	padding-right:10px;
}

</style>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		  <table width="95%" border="0" cellspacing="0" cellpadding="0" style="margin:5px 0 10px 0;">
	      <tr>
		      <td width="45%" align="right" style="padding-right:5px;"><button class="btn btn-primary btn-large" onclick="javascript:fn_egov_save();">저장</button></td>
		      <td width="55%" >
		      	<a class="btn btn-large" href="javascript:fn_egov_selectList();">취소</a>
	      	  </td>
	                
	      </tr>
	      </table>
	      
		<!-- <ul id="tab">
			<li id="editLi" class="on"><a href="#" onclick="editMode();">수정</a></li>
			<li id="prevLi" ><a href="#" onclick="previewMode();">미리보기</a></li>
		</ul> -->
		<div id="editArea">
		<form:form commandName="jnitcmscntvtVO" height="100%" >
		
		<form:hidden path="cntId" />
		<form:hidden path="siteId" />
		<form:hidden path="menuId" />
		
		    					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
		                            <tr>
		                            	<td colspan="2"><c:out value="${menuNames}"/> 수정</td>
		                            </tr>
		                            <tr>
		                            	<td width="120">메뉴 ID</td>
		                            	<td width="89%" height="25" align="left" class="content_1">
		                            		<c:out value="${jnitcmscntvtVO.menuId}" />&nbsp;&nbsp;(콘텐츠 코드 : <c:out value="${pageCode}" />)
		                            	</td>
		                            </tr>
		                            <%-- <tr>
		                            	<td width="120">콘텐츠 코드</td>
		                            	<td width="89%" height="25" align="left" class="content_1">
		                            		
		                            	</td>
		                            </tr> --%>
		                            <tr>
		                            	<td>콘텐츠 수정일</td>
		                            	<td width="89%" height="25" align="left" class="content_1">
		                            		<c:out value="${modifiedDate}" />
		                            		<a href="javascript:loadHistory();">[콘텐츠 히스토리]</a>
		                            	</td>
		                            </tr>
		                            <tr>
		                            	<td>콘텐츠 경로</td>
		                            	<td width="89%" height="25" align="left" class="content_1">
		                            		<c:out value="${menuDirs}"/>
		                            	</td>
		                            </tr>
		                            <tr>
		                            	<td>콘텐츠 설명</td>
		                            	<td width="89%" align="left" class="content_1">
		                            	<form:textarea path="cntDesc" rows="1" style="width:100%;" /><form:errors path="cntDesc" /></td>
		                            </tr>
		                            <tr>
		                            	<td>콘텐츠 템플릿</td>
		                            	<td width="89%" align="left" class="content_1">
							                <form:select path="tplId" id="tpl]Id" title="서브템플릿" style="width:50%;">
							                    <form:option value=" " label="--선택하세요--"/>
							                    <form:options items="${tplId_result}" itemValue="code" itemLabel="codeNm"/>
							                </form:select>
							                &nbsp;<form:errors path="tplId" /></td>
		                            </tr>
		                            <tr>
		                            	<td colspan="2"><br/>콘텐츠 소스 
		                            		<c:if test="${newFileCnt == 'Y'}"><span style="color:red;">(서버에서 변경된 페이지입니다)</span></c:if>
		                            		<c:if test="${notFileCnt == 'Y'}"><span style="color:red;">(파일이 없습니다)</span></c:if>
		                            	</td>
		                            </tr>
		                            <tr>
		                            	<td colspan="2">
		                            	<form:textarea path="cntSrc" style="width:100%; height:550px;"/>
										<br /><form:errors path="cntSrc" />
		                            	</td>
		                            </tr>
		                        </table>
		                        <!-- <table width="95%" border="0" cellspacing="0" cellpadding="0" style="margin:10px 0 20px 0;">
		                            <tr>
		                                <td width="45%" align="right" style="padding-right:5px;"><button class="btn btn-primary btn-large" onclick="javascript:fn_egov_save();">저장</button></td>
		                                <td width="55%" ><a class="btn btn-large" href="javascript:fn_egov_selectList();">취소</a></td>
		                                
		                            </tr>
		                        </table> -->
		   					 <!--콘텐츠끝-->		 
		</form:form>
		</div>
		<div id="previewArea">
			<iframe id="previewFrame" src="<c:url value="${menuDirs}"/>" name="_preview" style="width:100%; height:750px;"></iframe>
		</div>
		<%-- Contents End --%>
	</div>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer_skeleton.jsp" %>