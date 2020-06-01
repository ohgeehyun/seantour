<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header_skeleton.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">

function fn_egov_save() {	
	frm = document.getElementById("newFileForm");
	
	if("<c:out value="${param.dirType}"/>" == "css") {
		if(frm.fileName.value.search("\\.css") == -1) {
			alert("확장자 .css파일만 생성할 수 있습니다.");
			$('#fileName').focus();
			return;
		}
	}else if("<c:out value="${param.dirType}"/>" == "js") {
		if(frm.fileName.value.search("\\.js") == -1) {
			alert("확장자 .js파일만 생성할 수 있습니다.");
			$('#fileName').focus();
			return;
		}
	}
	/*else if("<c:out value="${param.dirType}"/>" == "file") {
		if(frm.fileName.value.search("\\.css|\\.js|\\.txt|\\.html|\\.json") == -1) {
			alert("확장자 .css/.js/.txt/.html/.json파일만 생성할 수 있습니다.");
			$('#fileName').focus();
			return;
		}
		
	}*/
	
	if($('#fileName').val() == '') {
		alert("파일명을 입력하세요.");
		$('#fileName').focus();
		return;
	}else {
		frm.searchKeyword.value = frm.searchKeywordOrg.value+$('#fileName').val();		
	}
	
	if(frm.fileName.value.search("\\.") == -1) {
		alert("파일에 확장자가 없습니다.");
		$('#fileName').focus();
		return;
	}
	
	if(confirm("파일명 ["+frm.fileName.value+"]\n\n위 파일을 생성하시겠습니까?") == false) {
		return false;
	}
	
    /* ClientSite Validator */
	//if(!validateJnitcmstplVO(frm)){
	//		return;
	//}
	frm.action = "<c:url value='/cms/file/save.do'/>";
	//alert(frm.searchKeyword.value);
    frm.submit();
}

</script>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
			<br />
			<span style="color:#000000">생성할 파일명을 입력하세요.</span>
			<form:form commandName="jnitcmstplVO" id="newFileForm" onsubmit="fn_egov_save();">
			<input type="hidden" name="screenMode" value="" />
			<input type="hidden" name="siteId" value="" />
			<input type="hidden" name="tplId" value="uniq" />
			<input type="hidden" name="sitePath" value="<c:out value="${sitePath}" />" />
			<input type="hidden" name="searchKeyword" value="<c:out value="${param.bindType}" />,<c:out value="${param.dirType}" />," />	
			<input type="hidden" name="searchKeywordOrg" value="<c:out value="${param.bindType},${param.dirType}," />" />
			<input type="text" id="fileName" name="fileName" />	
			<br />
			<a class="btn btn-primary" onclick="fn_egov_save();"><i class="icon icon-pencil"></i>생성</a>
			</form:form>
		<%-- Contents End --%>
	</div>
