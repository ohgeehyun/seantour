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
<%-- <%@ include file="/WEB-INF/jsp/jnit/_common/header_skeleton.jsp" %> --%>

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>
<script type="text/javascript">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitcmsmgmtVO").action = "<c:url value='/cms/mgmt/list.do'/>";
   	document.getElementById("jnitcmsmgmtVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {	
	if(confirm("정말 삭제 하시겠습니까?")){
		var mgmtId = $("#mgmtId").val();
	   	var mgmtType = $("#mgmtType").val();
	   	$.ajax({
	   		type :"post",
	   		url :"<c:url value='/mgmt/deleteProc.do'/>",
	   		data :"mgmtId="+mgmtId+"&mgmtType="+mgmtType
	   	}).done(function(data){	   		
	   		var json = $.parseJSON(data);	   		
	   		if(json.status == 'success'){
	   			alert("정상처리 되었습니다.");
	   			location.href = json.path;
	   		}else{
	   			if(json.code == 'ERROR 1'){
	   				alert("파일 삭제에 오류가 있습니다.");
	   			}else if(json.code == 'ERROR 2'){
	   				alert("데이터 삭제처리에 오류가 있습니다.");
	   			}else{
	   				alert("오류가 생겨 삭제 할 수 없습니다.");
	   			}
	   		}
	   	});	
	}   	
}

function fn_egov_save_bln(){
	var mgmtNm = $("#mgmtNm").val();
	/*
	if(mgmtNm == null || mgmtNm == ''){
		alert("파일명을 입력해주시기 바랍니다.");
		$("#mgmtNm").focus();
		return false;		
	}
	*/
	return true;
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitcmsmgmtVO");
	
	if(fn_egov_save_bln() && checkExt()){ //null, 확장자 check 
		$.ajax({
			type : "post",
			url : "<c:url value='/cms/ajax/file/name.do'/>",
			data : "mgmtNm="+$("#mgmtNm").val()+"&mgmtType="+$("#mgmtType").val()+"&screenMode=${searchVO.screenMode}&mgmtId="+$("#mgmtId").val()
		}).done(function(data){		
			var json = $.parseJSON(data);
			if(json.status == 'error'){ //error			
				if(json.code == null || json.code == ""){
					alert("같은 이름의 파일이 존재 합니다.");
				}else if(json.code == "ERROR 1"){
					if(confirm("Warning ! CODE "+json.code+" : 변경하신 파일이름은 이미 존재합니다 덮어 씌우시겠습니까?")){
			  			frm.action = "<c:url value='/cms/mgmt/editProc.do'/>";
			  			frm.submit();
			  		}
				}else{
					alert("CODE : "+json.code);
				}			
			}else{ //success
				<c:if test="${registerFlag == '수정'}">	
					frm.action = "<c:url value='/cms/mgmt/editProc.do'/>";
		  			frm.submit();
				</c:if>
				<c:if test="${registerFlag == '등록'}">	
					frm.action = "<c:url value='/cms/mgmt/addProc.do'/>";
					frm.submit();
				</c:if>			
			}
		});	
	}	
}

function fn_history(){	
	var mgmtId = $("#mgmtId").val();
	var mgmtType = $("#mgmtType").val();
	$.ajax({
		type:"post",
		url:"<c:url value='/cms/mgmt/hist/list.do' />",
		data:"mgmtId="+mgmtId+"&mgmtType="+mgmtType
	}).done(function(data){	
		$("#listModal").empty();
		$("#listModal").append(data);
		$('#myModal').modal('toggle');
	});
}
function fn_egov_link(){
	var htmlSrc = $("#mgmtContent").val();
	var IE=(document.all)?true:false;
	if (IE) {
		window.clipboardData.setData("Text", htmlSrc);
	}else {
		temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", htmlSrc);
	}		
}

//파일 확장자 체크
function checkExt(){	
	if( $("#upfile").val() != "" ){				
		var ext = $('#upfile').val().split('.').pop().toLowerCase();			
		if($.inArray(ext, ['avi','mkv','mp4','flv','wmv']) == -1) {
			alert('avi, mkv, mp4, flv, wmv 파일만 업로드 할수 있습니다.');
			$("upfile").focus();
			return;
		}
	}
	return true;
}

$(document).ready(function(){	
	$("#mgmtScriptType").select2();
	$("#mgmtHearderYn").select2();
	$("#upfile").uniform();
	$("#s2id_mgmtScriptType").css("width","162px");
	
	<c:if test="${registerFlag == '수정'}">	
		//video 삽입소스 세팅		
		var mgmtContent = "${mgmtContentNullYn}";		
		if(mgmtContent == ''){
			// 사용처리에 대한 문제는 조치고려 
			var imgHtmlSrc = ""
							+"<"+"%@page import='java.lang.*' %"+">\n"
							+"<"+"%\n"
							+"    String brower = request.getHeader("+'"User-Agent"'+");\n"
							+"    String browerlist[] = {"+'"Chrome"'+","+'"Opera"'+","+'"Firefox"'+","+'"Safari"'+"};\n"    	
							
							+"    if(brower.indexOf("+'"MISE"'+") > -1){ //익스 8,9,10\n"
							+"        brower = "+'"MISE"'+";\n"
							+"    }else{\n"
							+"        //현재 brower가 리스트에 속해있지 않으면 IE 통일\n"
							+"        int k = 0;\n"
							+"        for(int i=0; i<browerlist.length; i++){\n"  	
							+"            if(brower.indexOf(browerlist[i]) > -1){\n"    				
							+"                k++;\n"    				
							+"            }\n"   			
							+"        }\n"
							+"        if(k == 0){\n"
							+"            brower = "+'"MISE"'+";\n"
							+"        }\n"
							+"    }\n"
							+"%"+">\n\n"
							
							+"<"+"c:set"+" var='brower' value='<"+"%="+" brower %"+">'"+"/>\n\n"
							
							+"<"+'c:if test="$'+"{brower == 'MISE' }"+'"'+">\n"
							+"    <object id='mediaplayer' type='video/x-ms-wmv' classid='CLSID:6BF52A52-394A-11D3-B153-00C04F79FAA6' width='500' height='500'>\n"
							+"        <param name='url' value='<c:url value='${jnitcmsmgmtVO.mgmtFilePathUrl }'/>' valuetype='ref' type='video/x-ms-wmv'>\n"
							+"        <param name='animationatStart' value='1'>\n"
							+"        <param name='transparentatStart' value='1'>\n"
							+"        <param name='autoStart' value='1'>\n"
							+"        <param name='ShowControls' value='0'>\n"
							+"        <param name='ShowDisplay' value='0'>\n"
							+"        <param name='ShowStatusBar' value='0'>\n"
							+"        <param name='playcount' value='99999'>\n"
							+"        <param name='clickToPlay' value='1'>\n"
							+"        <param name='autoRewind' value='1'>\n"
							+"        <param name='displaysize' value='0'>\n"
							+"        <param name='stretchtofit' value='1'>\n"
							+"        <param name='enableContextMenu' value='0'>\n"
							+"        <param name='uiMode' value='none'>\n"
							+"        <strong>Error:</strong>You need <a href='http://www.microsoft.com/windows/windowsmedia/download/plugin.aspx'>Windows Media Player Plugin</a>.\n"
							+"   </object>\n"
							+"<"+"/c:if>\n\n"
							
							+"<"+'c:if test="$'+"{brower != 'MISE' }"+'"'+">\n"					
							+"    <object id='mediaplayer' type='application/x-ms-wmp' data='video.wmv' width='500' height='500'>\n"
							+"        <param name='src' value='<c:url value='${jnitcmsmgmtVO.mgmtFilePathUrl }'/>' valuetype='ref' type='video.wmv'>\n"
							+"        <param name='animationatStart' value='1'>\n"
							+"        <param name='transparentatStart' value='1'>\n"
							+"        <param name='autoStart' value='1'>\n"
							+"        <param name='ShowControls' value='0'>\n"
							+"        <param name='ShowDisplay' value='0'>\n"
							+"        <param name='ShowStatusBar' value='0'>\n"
							+"        <param name='playcount' value='10'>\n"
							+"        <param name='autoRewind' value='1'>\n"
							+"        <param name='displaysize' value='0'>\n"
							+"        <param name='stretchtofit' value='1'>\n"
							+"        <param name='enableContextMenu' value='0'>\n"
							+"        <param name='uiMode' value='none'>\n"
							+"        <strong>Error:</strong>You need <a href='http://port25.technet.com/pages/windows-media-player-firefox-plugin-download.aspx'>Windows Media Player Plugin</a>.\n"
							+"    </object>\n"
							+"<"+"/c:if>\n";											
			$("#mgmtContent").val(imgHtmlSrc);
		}			
	</c:if>	
}); 
// -->
</script>

<%-- Contents Start --%>
<form:form commandName="jnitcmsmgmtVO" method="post" enctype="multipart/form-data">
<input type="hidden" name="mgmtType" id="mgmtType" value="${mgmtType }"/>
<div class="widget-box">
	<div class="widget-title">
		<h3>${registerFlag}</h3>
		<a href="javascript:fn_egov_save();" class="btn btn-small">저장</a>
		<c:if test="${registerFlag == '수정' }">
			<a href="javascript:fn_egov_delete();" class="btn btn-small btn-del" style="float: right; margin-right: 10px;"><i class="icon-minus-sign"></i> 삭제</a>
		</c:if>				
	</div>
	<div class="widget-content nopadding">	
		<c:if test="${registerFlag == '등록' }">
			<table class="table table-borderd">
				<tr>
					<th>파일업로드</th>
					<td>								
						<input type="file" name="upfile" id="upfile" />
					</td>
				</tr>
				<%-- <tr>
					<th style="width: 15%">파일이름</th>
					<td style="width: 35%">
						<form:input path="mgmtNm" id="mgmtNm"/>											
					</td>							
				</tr> --%>							
			</table>
		</c:if>
		<c:if test="${registerFlag == '수정' }">		
			<table class="table table-borderd">
				<tr>
					<td>
						<%-- 1 --%>	
						<%-- IE --%>						
						<c:if test="${brower == 'MISE' }">
						<object id="mediaplayer" classid="clsid:22D6F312-B0F6-11D0-94AB-0080C74C7E95" codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,4,5,715" width="262" height="262">
							<param name="FileName" value="<c:url value="${jnitcmsmgmtVO.mgmtFilePathUrl }"/>">
							<param name="AutoStart" value="true">
							<param name="ShowTracker" value="true">
							<param name="ShowControls" value="true">
							<param name="ShowGotoBar" value="false">
							<param name="ShowDisplay" value="false">
							<param name="ShowStatusBar" value="true">
							<param name="AutoSize" value="true">
							<embed src="<c:url value="${jnitcmsmgmtVO.mgmtFilePathUrl }"/>" AutoStart="true" ShowTracker="true" ShowControls="true" ShowGotoBar="false" ShowDisplay="false" ShowStatusBar="true" AutoSize="true" pluginspage="http://www.microsoft.com/windows/windowsmedia/download/" width="100%" height="100%">
						</object>
						</c:if>					
						<%-- 크롬  --%>
						<c:if test="${brower != 'MISE' }"> 
						<object id="mediaplayer" type="application/x-ms-wmp" data="video.wmv" width="262" height="262">
	                        <param name="src" value="<c:url value="${jnitcmsmgmtVO.mgmtFilePathUrl }"/>" valuetype="ref" type="video.wmv">
	                        <param name="animationatStart" value="1">
	                        <param name="transparentatStart" value="1">
	                        <param name="autoStart" value="1">
	                        <param name="ShowControls" value="1">
	                        <param name="ShowDisplay" value="1">
	                        <param name="ShowStatusBar" value="1">
	                        <param name="playcount" value="10">
	                        <param name="autoRewind" value="1">
	                        <param name="displaysize" value="0">
	                        <param name="stretchtofit" value="1">
	                        <param name="enableContextMenu" value="0">
	                        <param name="uiMode" value="none">
	                        <strong>Error:</strong>You need 
	                        <a href="http://port25.technet.com/pages/windows-media-player-firefox-plugin-download.aspx">Windows Media Player Plugin 설치하시기 바랍니다.</a>.
	                    </object>
	                    </c:if> 
					</td>
				</tr>
				<tr>	
					<td>
						<%-- 2 --%>
						<table class="table table-borderd">
							<tr>
								<th style="width: 15%">파일업로드</th>
								<td style="width: 35%">									
									<input type="file" name="upfile" id="upfile" />
								</td>
							</tr>							
							<tr>
								<th >파일이름</th>
								<td>
									<c:out value="${jnitcmsmgmtVO.mgmtNm }"/>
									<form:hidden path="mgmtNm" id="mgmtNm"/>									
									<c:if test="${!empty isExistsNm }"><br/><font color="red">같은 파일이 존재합니다.<br />이름을 변경해서 저장해주시기 바랍니다.</font></c:if>					
								</td>
							</tr>							
							<tr>
								<th>크기</th>
								<td>
									<c:if test="${!empty fileSize }">
										<c:out value="${fileSize } Mb"/>
									</c:if>
								</td>	
							</tr>
							<tr>
								<th>저장일시</th>
								<td>
									<fmt:formatDate value="${jnitcmsmgmtVO.created }" pattern="yyyy-MM-dd HH:mm"/> 												
								</td>
							</tr>
							<tr>
								<th>수정자</th>
								<td>
									<input type="hidden" name="mgmtActId" id="mgmtActId" value="<c:out value="${jnitcmsmgmtVO.mgmtActId }" />" />
									<c:out value="${mbrNm }" />
								</td>
							</tr>																	
							<tr>
								<th>비디오경로</th>
								<td>
									<a href="<c:url value="/${siteVO.sitePath }/common/${mgmtType}/${jnitcmsmgmtVO.mgmtFileNm }"/>" target="_blank" title="새창으로 열립니다.">
										<c:out value="/${siteVO.sitePath }/common/${mgmtType}/${jnitcmsmgmtVO.mgmtFileNm }"/>
									</a>					
								</td>																
							</tr>										
							<tr>
								<th>삽입경로 메모</th>
								<td>
									<input type="text" name="mgmtInsertPath" id="mgmtInsertPath" value="<c:out value="${jnitcmsmgmtVO.mgmtInsertPath }"/>" style="width: 98%" />
								</td>
							</tr>		
							<tr>
								<td colspan="2">
									<a href="javascript:fn_egov_link();" class="btn btn-small">복사하기</a>	
									&nbsp;&nbsp;<font color="red">삽입소스(해당소스로 게시판등에 붙여 넣으시기 바랍니다.)</font><br />
									<textarea rows="25" cols="10" name="mgmtContent" id="mgmtContent" style="width: 98%"><c:out value="${jnitcmsmgmtVO.mgmtContent }"/></textarea>									
								</td>
							</tr>							
						</table>				
					</td>
				</tr>		
			</table>
		</c:if>
	</div>
</div>
<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">히스토리</h3>
  </div>
  <div class="modal-body">
   	<div id="listModal"></div>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>
    <!-- <button class="btn btn-primary">Save changes</button> -->
  </div>
</div>
<!-- 검색조건 유지 -->
<%--
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
 --%>
</form:form>
<%-- Contents End --%>