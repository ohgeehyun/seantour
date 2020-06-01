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

	if($('#upfile').val() == '') {
		alert("파일을 선택하세요.");
		$('#upfile').focus();
		return;
	}
	
	if("<c:out value="${param.dirType}"/>" == "css") {
		if($('#upfile').val().search("\\.css") == -1) {
			alert("확장자 .css파일만 생성할 수 있습니다.");
			$('#upfile').focus();
			return;
		}
	}else if("<c:out value="${param.dirType}"/>" == "js") {
		if($('#upfile').val().search("\\.js") == -1) {
			alert("확장자 .js파일만 생성할 수 있습니다.");
			$('#upfile').focus();
			return;
		}
	}
	/*else if("<c:out value="${param.dirType}"/>" == "file") {
		if($('#upfile').val().search("\\.css|\\.js|\\.txt|\\.html|\\.json") == -1) {
			alert("확장자 .css/.js/.txt/.html/.json파일만 생성할 수 있습니다.");
			$('#upfile').focus();
			return;
		}
	}*/
	
		
    /* ClientSite Validator */
	//if(!validateJnitcmstplVO(frm)){
	//		return;
	//}
	$(top.document).find('#myModal').modal('hide');
	frm.action = "<c:url value='/cms/file/saveupfile.do'/>";
	//alert(frm.searchKeyword.value);
    frm.submit();
    
}

</script>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<br />
			<span style="color:#000000">업로드할 파일을 선택하세요.</span>
			<form:form commandName="jnitcmstplVO" id="newFileForm" enctype="multipart/form-data">
			<input type="hidden" name="screenMode" value="" />
			<input type="hidden" name="siteId" value="" />
			<input type="hidden" name="tplId" value="uniq" />
			<input type="hidden" name="sitePath" value="<c:out value="${sitePath}" />" />
			<input type="hidden" name="searchKeyword" value="<c:out value="${param.bindType}" />,<c:out value="${param.dirType}" />," />
			<input type="file" id="upfile" name="upfile" />
			<br />	
			<button class="btn btn-primary" onclick="fn_egov_save();" ><i class="icon icon-pencil"></i>업로드</button>
			</form:form>
		<%-- Contents End --%>
	</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer_skeleton.jsp" %>