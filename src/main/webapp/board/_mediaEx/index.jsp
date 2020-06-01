<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0); 
if (request.getProtocol().equals("HTTP/1.1")) 
response.setHeader("Cache-Control", "no-cache");
%>
<%@ page contentType="text/html; charset=euc-kr" pageEncoding="utf-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %><%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ taglib prefix="jtag" uri="/jnittag"%>
<%@ page import = "org.springframework.web.context.*,
 org.springframework.web.context.support.*,
 egovframework.com.cmm.service.EgovProperties,
 jnit.board.info.JnitboardinfoVO,
 java.math.BigInteger,
 egovframework.rte.fdl.property.EgovPropertyService,
 egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo,
 egovframework.com.utl.fcc.service.*,
 egovframework.rte.psl.dataaccess.util.EgovMap,
 java.util.*, java.io.*, java.net.URLDecoder,java.net.URLEncoder" %>
<%
	pageContext.setAttribute("lf", "\n");

	/** 첨부 최대 파일 크기 지정 */
	final long maxFileSize = (1024 * 1024 * 1000); //업로드 최대 사이즈 설정 (1000M)

	WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletConfig().getServletContext());
	EgovPropertyService propertiesService = (EgovPropertyService) ctx.getBean("propertiesService");
	String mediaExHostIp = EgovProperties.getProperty("MediaEx.hostIp");
	String ctxRoot = getServletContext().getContextPath();
%>
<c:set var="ctxRoot" value="<%=ctxRoot%>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>MediaExServer Uploader</title>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<link href="./common/css/common.css" media="screen" rel="stylesheet" type="text/css" />

<!--
<script type="text/javaScript" src="<c:url value="/resources/js/jquery-1.8.2.min.js"/>"></script>
<script type="text/javaScript" src="<c:url value="/resources/js/jquery.ui/js/jquery-ui-1.9.0.custom.min.js"/>"></script>
<script type="text/javaScript" src="<c:url value="/resources/js/jquery.ui/development-bundle/ui/i18n/jquery.ui.datepicker-ko.js"/>"></script>
<script type="text/javaScript" src="<c:url value="/resources/js/jquery.ui/js/jquery-ui-timepicker-addon.js"/>"></script>
-->
<script type="text/javaScript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javaScript" src="<c:url value="/resources/js/jquery.ui/js/jquery-ui-1.9.0.custom.min.js"/>"></script>
<script type="text/javaScript" src="<c:url value="/resources/js/jquery.plugins/fileupload/jquery.iframe-transport.js"/>"></script>
<script type="text/javaScript" src="<c:url value="/resources/js/jquery.plugins/fileupload/jquery.fileupload.js"/>"></script>


<script type="text/javaScript">
var hostname = "${header.host}";
var ctxRoot = "${ctxRoot}";
var mediaServerAddr = "http://<%=mediaExHostIp%>:2935";
var uploadUrl;
var timer;
var timer2;
var upProgress = 0;
var show=0;
</script>
<script type="text/javaScript">
var uploadMedia = function(seq, orgNm, dstNm){
	
	uploadUrl = mediaServerAddr + "/upload?"+"seq="+ seq +"&dstmovie="+ dstNm;
	<%--$('#progress .bar').html("<img src='/images/loading01.gif'  alt='파일업로드중' />");--%>
	
	// uploading... layer on 
	$('#loadingLayer').show();
	
	$('#mediaEx').attr('action', uploadUrl);
	$('#mediaEx').submit();

	// image loading...
	
		
	//$('#srcmoviefile').trigger('change');
	
	//clearInterval(timer);
	clearInterval(timer2);
	//timer = setInterval(function(){progressProc(seq);}, 1000);
	timer2 = setInterval(function(){getImages(seq);}, 1000);
}

var uploadIframeDone = function(){
	var IE=(document.all)?true:false;
	// uploading layer off
	show = show + 1;
	$('#loadingLayer').hide();
	if(show == 2){
		$('.video_hidden').show();
	}
	
}
var progressProc = function(seq) {
	$.ajax({
		url:mediaServerAddr + "/report/"+ seq,
		cache:false,
		success:function(data){
			var progress = $.trim(data);
			if(progress == "100") {
				<%--console.log("done");--%>
				getImages(seq);
				clearInterval(timer);
				clearInterval(timer2);
			}else {
				<%--console.log(progress);--%>
			}
		}
	});
	<%--console.log(seq);--%>
}

var getImages = function(seq) {
	$('#img1').attr('src', mediaServerAddr + '/' + seq + '_01.png');
	$('#img2').attr('src', mediaServerAddr + '/' + seq + '_02.png');
	$('#img3').attr('src', mediaServerAddr + '/' + seq + '_03.png');
	$('#img4').attr('src', mediaServerAddr + '/' + seq + '_04.png');
	$('#img5').attr('src', mediaServerAddr + '/' + seq + '_05.png');
}

$(document).on('change','#srcmoviefile', function(){
	
	if($('#srcmoviefile').val() != "") {
		//var orginName = $('#srcmoviefile').prop('files').item(0).name;
		var orginName = $('#srcmoviefile').val().split('/').pop().split('\\').pop();
		<%--console.log("filename:"+orginName);--%>
		var requestUrl = "//" + hostname + ctxRoot + "/board/media/addMedia.do";
		<%--console.log(requestUrl);--%>
		$.ajaxSetup({cache:false});
		$.ajax({
			url:requestUrl,
			cache:false,
			data:{orgNm: orginName}
		}).done(function(result){
			var data = $.parseJSON($.trim(result));
			//console.log(data);
			$('#seq').val(data.jnitmediaId);
			$('#dstNm').val(data.dstNm);
			//console.log(data.jnitmediaId, data.orgNm, data.dstNm);
			uploadMedia(data.jnitmediaId,data.orgNm,data.dstNm);
			
		});
	}
});

//$(document).on('submit','#mediaEx',function(e){
//	e.preventDefault();
function uploadEnd(){
	<%--
	if(upProgress < 100){
		
		alert('미디어 파일 업로드가 완료되지 않았습니다.');
		return false;
		
	}
	--%>
	if($('#seq').val() != "" && $('#dst').val() != ""){
		var finalSeq = $('#seq').val();
		var finalDstNm = $('#dstNm').val();
		var finalIdx = $('input[name="usemain_img"]:checked').val();
		$('input[name="ext18"]',opener.document).val(finalSeq);
		$('input[name="ext19"]',opener.document).val(finalDstNm);
		$('input[name="ext20"]',opener.document).val(finalIdx);
		var $pJquery = window.opener.jQuery.noConflict();
		$pJquery("#openMediaEx").html('등록 완료(동영상 변환중...)');
		
		window.close();
		return false;
	}else{
		alert('미디어 정보가 올바르지 않습니다.\n\n다시 시도해 주세요.');
		return false;
	}
	
}
//});
</script>
</head>

<body>
<iframe name="uploadIframe" style="width:0 px; height:0px; border:0px;" onload="uploadIframeDone()"></iframe>
<form name="mediaEx" id="mediaEx" method="post" enctype="multipart/form-data" target="uploadIframe">
<input name="seq" id="seq" type="hidden" />
<input name="dstNm" id="dstNm" type="hidden" />
<div class="video_pop">
	<div class="video_in">
    	<p class="video_in_header"><img src="./images/top_img.jpg" alt="동영상파일" /></p>
        <div class="video_in_content01">
        	<input type="file" id="srcmoviefile"  name="srcmoviefile" />
        	<div id="loadingLayer" style="display:none;"><img src='/images/loading01.gif'  alt='파일업로드중' /></div>
        </div>
		<div id="progress">
		    <div class="bar" style="width: 0%;"></div>
		</div>
        <div class="video_in_content02">
        	- 등록 가능 확장자: <strong>avi</strong>, <strong>wmv</strong>, <strong>mp4</strong><br />
            - 등록 가능 용량: <strong>2GB</strong>
        </div>
    </div>
    <div class="video_hidden" style="display:none;">
    	<strong>대표 이미지 (자동 캡쳐 화면)</strong>
        <ul class="img_select">
            <li>
                <a href="#none;"><img id="img1" class="main_img" src="/images/loading02.gif" onerror="this.src='/images/loading02.gif'" alt="대표 추출 이미지1" /></a>
                <label for="usemain_img01">대표로 쓸 이미지를 선택하여 주십시오.</label>
                <input type="radio" id="usemain_img01" name="usemain_img" value="01" checked="checked" />
            </li>
            <li>
                <a href="#none;"><img id="img2" class="main_img" src="/images/loading02.gif" onerror="this.src='/images/loading02.gif'" alt="대표 추출 이미지2" /></a>
                <label for="usemain_img02">대표로 쓸 이미지를 선택하여 주십시오.</label>
                <input type="radio" id="usemain_img02" name="usemain_img" value="02" />
            </li>
            <li>
                <a href="#none;"><img id="img3" class="main_img" src="/images/loading02.gif" onerror="this.src='/images/loading02.gif'" alt="대표 추출 이미지3" /></a>
                <label for="usemain_img03">대표로 쓸 이미지를 선택하여 주십시오.</label>
                <input type="radio" id="usemain_img03" name="usemain_img" value="03" />
            </li>
            <li>
                <a href="#none;"><img id="img4" class="main_img" src="/images/loading02.gif" onerror="this.src='/images/loading02.gif'" alt="대표 추출 이미지4" /></a>
                <label for="usemain_img04">대표로 쓸 이미지를 선택하여 주십시오.</label>
                <input type="radio" id="usemain_img04" name="usemain_img" value="04" />
            </li>
            <li>
                <a href="#none;"><img id="img5" class="main_img" src="/images/loading02.gif" onerror="this.src='/images/loading02.gif'" alt="대표 추출 이미지5" /></a>
                <label for="usemain_img05">대표로 쓸 이미지를 선택하여 주십시오.</label>
                <input type="radio" id="usemain_img05" name="usemain_img" value="05" />
            </li>
        </ul>
        <p class="upload_btn">
        	<%--input id="setMedia" type="image" src="./images/upload_btn.gif" alt="올리기" /> --%>
        	<a href="javascript:uploadEnd();"><img src="./images/upload_btn.gif" alt="올리기" /></a>
        </p>
    </div>
</div>
</form>
</body>
</html>
