<%@ page contentType="text/html; charset=utf-8" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="jtag" uri="/WEB-INF/tlds/jnittag.tld"%>
<%@page import="jnit.util.*,
egovframework.com.cmm.service.EgovProperties,
org.springframework.web.context.*,
org.springframework.web.context.support.*,
jnit.board.info.JnitboardinfoVO,
egovframework.rte.fdl.property.EgovPropertyService"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="jnit.board.*" %>
<%@ page import="jnit.board.info.JnitboardUtil" %>
<%
	String lang = "korea"; //언어설정;
	if(request.getAttribute("boardinfoVO") != null){
		JnitboardinfoVO boardinfoVO = (JnitboardinfoVO)request.getAttribute("boardinfoVO");
		lang = boardinfoVO.getUseLanguage().toString();
	}
	String boardServletPath = request.getServletPath();
	String[] boardSitePath = boardServletPath.split("/"); //사이트경로
%>
<%
	WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletConfig().getServletContext());
	EgovPropertyService propertiesService = (EgovPropertyService) ctx.getBean("propertiesService");
	String ctxRoot = getServletContext().getContextPath();
%>
<c:set var="ctxRoot" value="<%=ctxRoot%>" />
<%
	String fileId = "";
	if(request.getParameter("fileId")!=null){
		fileId = (String) request.getParameter("fileId");
	}
	String boardId = "";
	if(request.getParameter("boardId")!=null){
		boardId = (String) request.getParameter("boardId");
	}

	String cntId = "";
	if(request.getParameter("cntId")!=null){
		cntId = (String) request.getParameter("cntId");
	}else{
		cntId = "new";
	}

	String allowedTypes = "";
	allowedTypes = EgovProperties.getProperty("Globals.FILE.EXT");
	String allowedTypes1 = StringUtil.replaceAll(allowedTypes,",","|");

	String blockTypes = "";
	if(request.getParameter("blacklist")!=null){
		blockTypes = (String) request.getParameter("blacklist");
	}else{
		blockTypes = "noblacklist";
	}

	String blockTypes1 = StringUtil.replaceAll(blockTypes,",","|");

	String multiple = "true";
	if(request.getParameter("multiple")!=null){
		multiple = (String) request.getParameter("multiple");
	}

	String dragDrop = "true";
	if(request.getParameter("dragDrop")!=null){
		dragDrop = (String) request.getParameter("dragDrop");
	}

	String showCancel = "false";
	if(request.getParameter("showCancel")!=null){
		showCancel = (String) request.getParameter("showCancel");
	}

	String showAbort = "false";
	if(request.getParameter("showAbort")!=null){
		showAbort = (String) request.getParameter("showAbort");
	}

	String showDone = "false";
	if(request.getParameter("showDone")!=null){
		showDone = (String) request.getParameter("showDone");
	}

	String showStatusAfterSuccess = "false";
	if(request.getParameter("showStatusAfterSuccess")!=null){
		showStatusAfterSuccess = (String) request.getParameter("showStatusAfterSuccess");
	}

	String showError = "false";
	if(request.getParameter("showError")!=null){
		showError = (String) request.getParameter("showError");
	}

	String showFileCounter = "false";
	if(request.getParameter("showFileCounter")!=null){
		showFileCounter = (String) request.getParameter("showFileCounter");
	}

	String showFileSize = "false";
	if(request.getParameter("showFileSize")!=null){
		showFileSize = (String) request.getParameter("showFileSize");
	}

	String maxFileCount = "1000";
	if(request.getParameter("maxFileCount")!=null){
		maxFileCount = (String) request.getParameter("maxFileCount");
	}

	String maxFileSize = "100MB";
	if(request.getParameter("maxFileSize")!=null){
		maxFileSize = (String) request.getParameter("maxFileSize");
	}

	String maxFileSize1 = maxFileSize;
	if(maxFileSize.indexOf("KB")>0){
		maxFileSize1 = StringUtil.toString(StringUtil.toLong(StringUtil.replaceAll(maxFileSize,"KB",""))*1000);
	}else if(maxFileSize.indexOf("MB")>0){
		maxFileSize1 = StringUtil.toString(StringUtil.toLong(StringUtil.replaceAll(maxFileSize,"MB",""))*1000000);
	}else if(maxFileSize.indexOf("GB")>0){
		maxFileSize1 = StringUtil.toString(StringUtil.toLong(StringUtil.replaceAll(maxFileSize,"GB",""))*1000000000);
	}
%>

<link rel="stylesheet" href="<c:url value="/resources/css/upload_board.css"/>" />
<script type="text/javascript">
<!--
	window.jQuery || document.write('<script src="<c:url value="/resources/js/fileupload/jquery-1.9.1.js"/>"><\/script>');
// -->
</script>
<script type="text/javaScript" src="<c:url value="/resources/js/jquery.form.js"/>"></script>
<script type="text/javascript">
var myVar;
var nPos = 0;
function fn_progress_bar(){
	var vPos = "";
	if(nPos<99){
		nPos++;
		vPos = nPos+"%";
	}else{
		vPos = nPos+"%";
	}

	$('#filetrans_bar_exp').css("width",vPos);
}

function fileDown(chkFileObj){
	$('#fileFormArea').empty();

	for(i=0; i<chkFileObj.length; i++){
		var v_html = " <iframe id='fileFormArea"+i+"' src=''></iframe> ";
		$('#fileFormArea').append(v_html);
		$("#fileFormArea"+i).attr("src","<c:url value='/board/fileupload/fileDownload.do' />"+"?fileId="+chkFileObj[i].value);
	}
}

function sleep(num){
	var now = new Date();
	var stop = now.getTime() + num;

	while(true){
		now = new Date();
		if(now.getTime() > stop)return;
   }
}

function fn_selectAll(){
	var chkFileObj = $(":input[name=cheack_All]:checked");

	if(chkFileObj==null || chkFileObj.length==0){
		var vFileObj = $(":input[name=upload_file_fileId]");

		for(i=0; i<vFileObj.length; i++){
			vFileObj[i].checked = false;
		}
	}else{
		var vFileObj = $(":input[name=upload_file_fileId]");

		for(i=0; i<vFileObj.length; i++){
			vFileObj[i].checked = true;
		}
	}
}

function fn_deleteFile(){
	var chkFileObj = $(":input[name=upload_file_fileId]:checked");

	if(chkFileObj==null || chkFileObj.length==0){
		alert(Jnit_isLang("삭제할 파일을 선택해 주세요"));
	}else{
		if(confirm(Jnit_isLang("선택하신 파일을 삭제하시겠습니까?"))){
			for(i=0; i<chkFileObj.length; i++){
				var param = new Object();
				param.fileId = chkFileObj[i].value;

				$.ajax({
					url:  '<c:url value="/board/fileupload/deleteFile.do" />',
					type: 'POST',
					data: param,
					dataType:"json",
					async: false,
					success: function(data){
						$('#tr_upload_file_'+chkFileObj[i].value).remove();
					},
					error: function(e){
						alert(e.reponseText);
					},
					complete: function() {
					}
				});
			}
		}
	}

	var chkFileObj1 = $(":input[name=upload_file_fileId]");

	if(chkFileObj1.length==0){
		$('#no_upload_file0').css("display","none");
		$('#no_upload_file1').css("display","block");
	}
}

function fn_downloadFile(){
	var chkFileObj = $(":input[name=upload_file_fileId]:checked");

	if(chkFileObj==null || chkFileObj.length==0){
		alert(Jnit_isLang("다운로드할 파일을 선택해 주세요"));
	}else{
		fileDown(chkFileObj);
	}
}

function getFileInfo(fileId){
	var returnObj = new Object();

	var param = new Object();
	param.fileId = fileId;

	$.ajax({
	    url:  '<c:url value="/board/fileupload/getAttachedFileInfo.do" />',
	    type: 'POST',
	    data: param,
		dataType:"json",
		async: false,
	    success: function(data){
			returnObj = data.fileVO;
	    },
	    error: function(e){
	        alert(e.reponseText);
		},
	    complete: function() {
	    }
	});

	return returnObj;
}

function getFileInfoList(boardId,cntId){
	var returnObj = new Object();

	var param = new Object();
	param.boardId = boardId;
	param.cntId = cntId;

	$.ajax({
	    url:  '<c:url value="/board/fileupload/getAttachedFileInfoList.do" />',
	    type: 'POST',
	    data: param,
		dataType:"json",
		async: false,
	    success: function(data){
			returnObj = data.fileList;
	    },
	    error: function(e){
	        alert(e.reponseText);
		},
	    complete: function() {
	    }
	});

	return returnObj;
}

var settings;

$(document).ready(function() {
	settings = {
		url: '<c:url value="/board/attachedFile/attachFileUpload.do" />?boardId=<%=boardId%>',
		method: "POST",
		returnType:"json",
		allowedTypes:"*",
		fileName: "myfile",
		multiple: <%=multiple%>,
		dragDrop: <%=dragDrop%>,
		showCancel: <%=showCancel%>,
		showAbort: <%=showAbort%>,
		showDone: <%=showDone%>,
		showStatusAfterSuccess: <%=showStatusAfterSuccess%>,
		showError: <%=showError%>,
		showFileCounter: <%=showFileCounter%>,
		showFileSize: <%=showFileSize%>,
		maxFileCount: <%=maxFileCount%>,
		maxFileSize: <%=maxFileSize1%>,
		onSelect: function(files){
			$("#filetrans_list").empty();
			$("#filetrans_list").append(files[0].name+" + "+files.length+" file");

			var uploadFile = files[0];
			var isValid = true;
			var thumbext = uploadFile.name.slice(uploadFile.name.indexOf(".") + 1).toLowerCase();
			if ("<%=blockTypes1%>".indexOf(thumbext) != -1) {
				alert(uploadFile.name+ Jnit_isLang('확장자는 업로드가 불가능 합니다.'));
				isValid = false;
			} else if (uploadFile.size > <%=maxFileSize1%>) {
				alert(Jnit_isLang('파일 용량은')+' <%=maxFileSize%> '+Jnit_isLang('를 초과할 수 없습니다.'));
				isValid = false;
			}
			if($("input:checkbox[name='upload_file_fileId']").length >= <%=maxFileCount%>){
				alert(Jnit_isLang('파일 개수는')+ ' <%=maxFileCount%> '+ Jnit_isLang('를 초과할 수 없습니다.'));
				isValid = false;
			}
			if(!isValid) {
				return false; //to allow file submission.
			}else{
				return true; //to allow file submission.
			}
		},
		onSubmit: function(files){
			//files : List of files to be uploaded
			//return false; to stop upload
			$("#fileUploaderStatus").html("");

			$("#file_upload_status").css("display","block");
			nPos = 0;
			myVar = setInterval(fn_progress_bar,100);
		},
		onSuccess:function(files,data,xhr){
			var jsonObj = data;
			var code = jsonObj.code;

			if(code == '1') {
				$('#no_upload_file0').css("display","block");
				$('#no_upload_file1').css("display","none");

				var fileId = jsonObj.fileId;
				var fileObj = getFileInfo(jsonObj.fileId);

				var vImgIcon = "";
				var arrFileKind = jsonObj.fileName.split(".");
				var fileKind = arrFileKind[arrFileKind.length-1];
				vImgIcon = getIconSrc(fileKind);
				var fileSize = (fileObj.fileSize/1000000).toFixed(1) + ' MByte';
				if(fileObj.fileSize < 1000000){
					fileSize = (fileObj.fileSize/1000).toFixed(1) + ' KByte'
				}
				$.each( $(".upload_file"), function() {

					if($(this).html().indexOf(fileObj.fileOnm) > -1){
						if(confirm("같은 이름의 파일이 있습니다. 덮어씌우시겠습니까?")){
							$(this).find("checkbox").attr("checked", true);
							$('input:checkbox[id="'+$(this).find("label").attr("for")+'"]').attr("checked", true);
							var chkFileObj = $(":input[name=upload_file_fileId]:checked");
							for(i=0; i<chkFileObj.length; i++){
								var param = new Object();
								param.fileId = chkFileObj[i].value;
								$.ajax({
									url:  '/board/fileupload/deleteFile.do',
									type: 'POST',
									data: param,
									dataType:"json",
									async: false,
									success: function(data){
										$('#tr_upload_file_'+chkFileObj[i].value).remove();
									},
									error: function(e){
										alert(e.reponseText);
									},
									complete: function() {
									}
								});
							}
						}
					}
				});

				var vHtml	= ' <tr class="upload_file" id="tr_upload_file_'+fileObj.fileId+'"> '
							+ ' <td class="fileup_check"><input type="checkbox" onclick="" title="첨부파일 선택" id="upload_file_'+fileObj.fileId+'" name="upload_file_fileId" value="'+fileObj.fileId+'" /></td> '
							+ ' <td class="fileup_name"><label for="upload_file_'+fileObj.fileId+'"><img src="'+vImgIcon+'" alt="" /> '+fileObj.fileOnm+'</label></td> '
							+ ' <td class="fileup_size">'+ fileSize +'</td> '
							+ ' </tr> ';

				$('.tBody').append(vHtml);

				clearInterval(myVar);
				nPos = 0;
				$('#filetrans_bar_exp').css("width","100%");
				$("#file_upload_status").css("display","none");
				if($("#fileuploadList").length > 0){
					$("#fileuploadList").val($("#fileuploadList").val() + "," + fileObj.fileId);
				}
			} else {
				var msg = jsonObj.msg;
				var Ca = /\+/g;
				alert(Jnit_isLang(decodeURIComponent(msg.replace(Ca, " "))));
				$("#file_upload_status").css("display","none");
			}
		},
		onError: function(files,status,errMsg){
			alert('server connection error');
		}
	}
	$("#uploadfile0").uploadFile(settings,1);
	$("#uploadfile1").uploadFile(settings,1);
	$("#mulitplefileuploader").uploadFile(settings,2);
	$("#mulitplefileuploader2").uploadFile(settings,2);
});

$(document).ready(function() {
	var fileObjList = getFileInfoList("<%=boardId%>","<%=cntId%>");
	if(fileObjList!=null){
		for(i=0; i<fileObjList.length; i++){
			$('#no_upload_file0').css("display","block");
			$('#no_upload_file1').css("display","none");

			var fileObj = fileObjList[i];

			var vImgIcon = "";
			var arrFileKind = fileObj.fileOnm.split(".");
			var fileKind = arrFileKind[arrFileKind.length-1];
			vImgIcon = getIconSrc(fileKind);
			var fileSize = (fileObj.fileSize/1000000).toFixed(1) + ' MByte';
			if(fileObj.fileSize < 1000000){
				fileSize = (fileObj.fileSize/1000).toFixed(1) + ' KByte'
			}
			var vHtml	= ' <tr class="upload_file" id="tr_upload_file_'+fileObj.fileId+'"> '
						+ ' <td class="fileup_check"><input type="checkbox" onclick="" title="첨부파일 선택" id="upload_file_'+fileObj.fileId+'" name="upload_file_fileId" value="'+fileObj.fileId+'" /></td> '
						+ ' <td class="fileup_name"><label for="upload_file_'+fileObj.fileId+'"><img src="'+vImgIcon+'" alt="" /> '+fileObj.fileOnm+'</label></td> '
						+ ' <td class="fileup_size">'+ fileSize +'</td> '
						+ ' </tr> ';

			$('.tBody').append(vHtml);
		}
	}
});
</script>
<div class="fileUploader" id="no_upload_file0" style="display:none">
	<div class="fileUploader_info">
       <div id="uploadfile0"  style="padding: 0px 4px 2px 7px;margin: 0 4px 0 0;height: 22px;width: 50px;line-height: 27px;color: #555;background: #fff;font-size: 12px;border: 1px solid #bdbdbd;border-right-color: #a0a0a0;border-bottom-color: #a0a0a0;border-radius: 3px;cursor: pointer;display: inline-block;vertical-align: bottom;"><%= JnitboardController.isLanguage("파일",lang) %></div>
       <button type="button" href="#none;" class="delete_file btn" onClick="javascript:fn_deleteFile();"><%= JnitboardController.isLanguage("삭제",lang) %></button>
       <button type="button" href="#none;" class="upload_file btn" onClick="javascript:fn_downloadFile();"><%= JnitboardController.isLanguage("파일 다운로드",lang) %></button>
    </div>

    <table class="fileUploader_container">
        <thead>
            <tr>
                <th class="fileup_check"><input type="checkbox" onClick="javascript:fn_selectAll();" id="cheack_All" name="cheack_All" />
                    <label for="cheack_All"><b>첨부파일 전체 선택</b></label>
                </th>
                <th class="fileup_name"><%= JnitboardController.isLanguage("파일",lang) %></th>
                <th class="fileup_size"><%= JnitboardController.isLanguage("크기",lang) %></th>
            </tr>
        </thead>
        <tbody class="tBody">

		</tbody>
		<tfoot>
			<tr class="no_upload_file" >
                <td colspan="3" id="mulitplefileuploader2" style="border: 1px solid #bcbcbc;"><div class="upload_info">마우스로 원하는 파일을 넣어주세요</div></td>
			</tr>
		</tfoot>
	</table>
</div>

<div class="fileUploader" id="no_upload_file1">
	<div class="fileUploader_info">
        <div id="uploadfile1"  style="padding: 0px 4px 2px 7px;margin: 0 4px 0 0;height: 22px;width: 50px;line-height: 27px;color: #555;background: #fff;font-size: 12px;border: 1px solid #bdbdbd;border-right-color: #a0a0a0;border-bottom-color: #a0a0a0;border-radius: 3px;cursor: pointer;display: inline-block;vertical-align: bottom;"><%= JnitboardController.isLanguage("파일",lang) %></div>
       <!--  <button type="button" class="delete_file btn" onClick="javascript:fn_deleteFile();">삭제</button>
        <button type="button" class="upload_file btn" onClick="javascript:fn_downloadFile();">다운로드</button> -->
    </div>

    <table class="fileUploader_container">
        <thead>
            <tr>
                <th class="fileup_check"><input type="checkbox" onClick="javascript:fn_selectAll();" id="cheack_All" name="cheack_All" />
                    <label for="cheack_All"><b>첨부파일 전체 선택</b></label>
                </th>
                <th class="fileup_name"><%= JnitboardController.isLanguage("파일",lang) %></th>
                <th class="fileup_size"><%= JnitboardController.isLanguage("크기",lang) %></th>
            </tr>
        </thead>
        <tbody class="tBody_first">
			<tr class="no_upload_file">
                <td colspan="3" id="mulitplefileuploader"><div class="upload_info">마우스로 원하는 파일을 넣어주세요</div></td>
			</tr>
		</tbody>
	</table>
</div>

<div id="file_upload_status" class="file_transferring" style="display:none">
	<div class="filetrans_header">
    	<p class="top_text"><%= JnitboardController.isLanguage("파일을 업로드 하는 중 입니다.",lang) %></p>
        <%--<p class="top_close_btn"><a href="#none">닫기</a></p> --%>
    </div>
    <div class="filetrans_bar_box">
    	<div class="filetrans_bar">
        	<div class="filetrans_bar_exp" id="filetrans_bar_exp" style="width:0%;"></div>
        </div>
        <p class="filetrans_list" id="filetrans_list">LTSKOREA_LOGO.png + 1 file </p>
    </div>
</div>

<script language="javascript">
function getIconSrc(fileKind){
	var vImgIcon = "<c:url value='/resources/img/fileupload/icon_etc.png' />";

	switch(fileKind){
	case "7z" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_7z.png' />";
		break;
	case "7Z" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_7z.png' />";
		break;
	case "alz" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_alz.png' />";
		break;
	case "ALZ" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_alz.png' />";
		break;
	case "avi" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_avi.png' />";
		break;
	case "AVI" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_avi.png' />";
		break;
	case "bmp" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_bmp.png' />";
		break;
	case "BMP" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_bmp.png' />";
		break;
	case "css" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_css.png' />";
		break;
	case "CSS" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_css.png' />";
		break;
	case "doc" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_doc.png' />";
		break;
	case "DOC" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_doc.png' />";
		break;
	case "docx" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_docx.png' />";
		break;
	case "DOCX" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_docx.png' />";
		break;
	case "egg" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_egg.png' />";
		break;
	case "EGG" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_egg.png' />";
		break;
	case "fla" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_fla.png' />";
		break;
	case "FLA" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_fla.png' />";
		break;
	case "gif" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_gif.png' />";
		break;
	case "GIF" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_gif.png' />";
		break;
	case "html" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_html.png' />";
		break;
	case "HTML" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_html.png' />";
		break;
	case "hwp" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_hwp.png' />";
		break;
	case "HWP" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_hwp.png' />";
		break;
	case "jpg" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_jpg.png' />";
		break;
	case "JPG" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_jpg.png' />";
		break;
	case "js" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_js.png' />";
		break;
	case "JS" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_js.png' />";
		break;
	case "json" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_json.png' />";
		break;
	case "JSON" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_json.png' />";
		break;
	case "mp3" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_mp3.png' />";
		break;
	case "MP3" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_mp3.png' />";
		break;
	case "mp4" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_mp4.png' />";
		break;
	case "MP4" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_mp4.png' />";
		break;
	case "mpeg" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_mpeg.png' />";
		break;
	case "MPEG" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_mpeg.png' />";
		break;
	case "ogg" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_ogg.png' />";
		break;
	case "OGG" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_ogg.png' />";
		break;
	case "p12" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_p12.png' />";
		break;
	case "P12" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_p12.png' />";
		break;
	case "pdf" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_pdf.png' />";
		break;
	case "PDF" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_pdf.png' />";
		break;
	case "png" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_png.png' />";
		break;
	case "PNG" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_png.png' />";
		break;
	case "ppt" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_ppt.png' />";
		break;
	case "PPT" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_ppt.png' />";
		break;
	case "pptx" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_pptx.png' />";
		break;
	case "PPTX" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_pptx.png' />";
		break;
	case "rar" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_rar.png' />";
		break;
	case "RAR" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_rar.png' />";
		break;
	case "swf" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_swf.png' />";
		break;
	case "SWF" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_swf.png' />";
		break;
	case "txt" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_txt.png' />";
		break;
	case "TXT" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_txt.png' />";
		break;
	case "wav" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_wav.png' />";
		break;
	case "WAV" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_wav.png' />";
		break;
	case "wma" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_wma.png' />";
		break;
	case "WMA" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_wma.png' />";
		break;
	case "wmv" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_wmv.png' />";
		break;
	case "WMV" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_wmv.png' />";
		break;
	case "xls" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_xls.png' />";
		break;
	case "XLS" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_xls.png' />";
		break;
	case "xlsx" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_xlsx.png' />";
		break;
	case "XLSX" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_xlsx.png' />";
		break;
	case "xml" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_xml.png' />";
		break;
	case "XML" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_xml.png' />";
		break;
	case "zip" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_zip.png' />";
		break;
	case "ZIP" :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_zip.png' />";
		break;
	default :
		vImgIcon = "<c:url value='/resources/img/fileupload/icon_etc.png' />";
		break;
	}

	return vImgIcon;
}
</script>

<script language="javascript">
!function (e) {
	var a = {};
	a.fileapi = void 0 !== e("<input type='file'/>").get(0).files,
	a.formdata = void 0 !== window.FormData,
	e.fn.uploadFile = function (t, vKind) {
		function r() {
			S || (S = !0, function e() {
				if (w.sequential || (w.sequentialCount = 99999), 0 == x.length && 0 == D.length)
					w.afterUploadAll && w.afterUploadAll(C), S = !1;
				else {
					if (D.length < w.sequentialCount) {
						var a = x.shift();
						void 0 != a && (D.push(a), a.removeClass(C.formGroup), a.submit())
					}
					window.setTimeout(e, 100)
				}
			}
				())
		}
		function o(a, t, r) {
			r.on("dragenter", function (a) {
				a.stopPropagation(),
				a.preventDefault(),
				e(this).addClass(t.dragDropHoverClass)
			}),
			r.on("dragover", function (a) {
				a.stopPropagation(),
				a.preventDefault();
				var r = e(this);
				r.hasClass(t.dragDropContainerClass) && !r.hasClass(t.dragDropHoverClass) && r.addClass(t.dragDropHoverClass)
			}),
			r.on("drop", function (r) {
				r.preventDefault(),
				e(this).removeClass(t.dragDropHoverClass),
				a.errorLog.html("");
				var o = r.originalEvent.dataTransfer.files;
				return !t.multiple && o.length > 1 ? void(t.showError && e("<div class='" + t.errorClass + "'>" + t.multiDragErrorStr + "</div>").appendTo(a.errorLog)) : void(0 != t.onSelect(o) && l(t, a, o))
			}),
			r.on("dragleave", function (a) {
				e(this).removeClass(t.dragDropHoverClass)
			}),
			e(document).on("dragenter", function (e) {
				e.stopPropagation(),
				e.preventDefault()
			}),
			e(document).on("dragover", function (a) {
				a.stopPropagation(),
				a.preventDefault();
				var r = e(this);
				r.hasClass(t.dragDropContainerClass) || r.removeClass(t.dragDropHoverClass)
			}),
			e(document).on("drop", function (a) {
				a.stopPropagation(),
				a.preventDefault(),
				e(this).removeClass(t.dragDropHoverClass)
			})
		}
		function s(e) {
			var a = "",
			t = e / 1024;
			if (parseInt(t) > 1024) {
				var r = t / 1024;
				a = r.toFixed(2) + " MB"
			} else
				a = t.toFixed(2) + " KB";
			return a
		}
		function i(a) {
			var t = [];
			t = "string" == jQuery.type(a) ? a.split("&") : e.param(a).split("&");
			var r,
			o,
			s = t.length,
			i = [];
			for (r = 0; s > r; r++)
				t[r] = t[r].replace(/\+/g, " "), o = t[r].split("="), i.push([decodeURIComponent(o[0]), decodeURIComponent(o[1])]);
			return i
		}
		function l(a, t, r) {
			for (var o = 0; o < r.length; o++)
				if (n(t, a, r[o].name))
					if (a.allowDuplicates || !d(t, r[o].name))
						if (-1 != a.maxFileSize && r[o].size > a.maxFileSize)
							a.showError && e("<div class='" + a.errorClass + "'><b>" + r[o].name + "</b> " + a.sizeErrorStr + s(a.maxFileSize) + "</div>").appendTo(t.errorLog);
						else if (-1 != a.maxFileCount && t.selectedFiles >= a.maxFileCount)
							a.showError && e("<div class='" + a.errorClass + "'><b>" + r[o].name + "</b> " + a.maxFileCountErrorStr + a.maxFileCount + "</div>").appendTo(t.errorLog);
						else {
							t.selectedFiles++,
							t.existingFileNames.push(r[o].name);
							var l = a,
							p = new FormData,
							u = a.fileName.replace("[]", "");
							p.append(u, r[o]);
							var c = a.formData;
							if (c)
								for (var h = i(c), f = 0; f < h.length; f++)
									h[f] && p.append(h[f][0], h[f][1]);
							l.fileData = p;
							var w = new m(t, a),
							g = "";
							g = a.showFileCounter ? t.fileCounter + a.fileCounterStyle + r[o].name : r[o].name,
							a.showFileSize && (g += " (" + s(r[o].size) + ")"),
							w.filename.html(g);
							var C = e("<form style='display:block; position:absolute;left: 150px;' class='" + t.formGroup + "' method='" + a.method + "' action='" + a.url + "' enctype='" + a.enctype + "'></form>");
							C.appendTo("body");
							var b = [];
							b.push(r[o].name),
							v(C, l, w, b, t, r[o]),
							t.fileCounter++
						}
					else
						a.showError && e("<div class='" + a.errorClass + "'><b>" + r[o].name + "</b> " + a.duplicateErrorStr + "</div>").appendTo(t.errorLog);
				else
					a.showError && e("<div class='" + a.errorClass + "'><b>" + r[o].name + "</b> " + a.extErrorStr + a.allowedTypes + "</div>").appendTo(t.errorLog)
		}
		function n(e, a, t) {
			var r = a.allowedTypes.toLowerCase().split(/[\s,]+/g),
			o = t.split(".").pop().toLowerCase();
			return "*" != a.allowedTypes && jQuery.inArray(o, r) < 0 ? !1 : !0
		}
		function d(e, a) {
			var t = !1;
			if (e.existingFileNames.length)
				for (var r = 0; r < e.existingFileNames.length; r++)
					(e.existingFileNames[r] == a || w.duplicateStrict && e.existingFileNames[r].toLowerCase() == a.toLowerCase()) && (t = !0);
			return t
		}
		function p(e, a) {
			if (e.existingFileNames.length)
				for (var t = 0; t < a.length; t++) {
					var r = e.existingFileNames.indexOf(a[t]);
					-1 != r && e.existingFileNames.splice(r, 1)
				}
		}
		function u(e, a) {
			if (e) {
				a.show();
				var t = new FileReader;
				t.onload = function (e) {
					a.attr("src", e.target.result)
				},
				t.readAsDataURL(e)
			}
		}
		function c(a, t) {
			if (a.showFileCounter) {
				var r = e(t.container).find(".ajax-file-upload-filename").length;
				t.fileCounter = r + 1,
				e(t.container).find(".ajax-file-upload-filename").each(function (t, o) {
					var s = e(this).html().split(a.fileCounterStyle),
					i = (parseInt(s[0]) - 1, r + a.fileCounterStyle + s[1]);
					e(this).html(i),
					r--
				})
			}
		}
		function h(t, r, o, s) {
			var i = "ajax-upload-id-" + (new Date).getTime(),
			d = e("<form method='" + o.method + "' action='" + o.url + "' enctype='" + o.enctype + "'></form>"),
			p = "<input type='file' id='" + i + "' name='" + o.fileName + "' accept='" + o.acceptFiles + "'/>";
			o.multiple && (o.fileName.indexOf("[]") != o.fileName.length - 2 && (o.fileName += "[]"), p = "<input type='file' id='" + i + "' name='" + o.fileName + "' accept='" + o.acceptFiles + "' multiple/>");
			var u = e(p).appendTo(d);
			u.change(function () {
				t.errorLog.html("");
				var i = (o.allowedTypes.toLowerCase().split(","), []);
				if (this.files) {
					for (g = 0; g < this.files.length; g++)
						i.push(this.files[g].name);
					if (0 == o.onSelect(this.files))
						return
				} else {
					var p = e(this).val(),
					u = [];
					if (i.push(p), !n(t, o, p))
						return void(o.showError && e("<div class='" + o.errorClass + "'><b>" + p + "</b> " + o.extErrorStr + o.allowedTypes + "</div>").appendTo(t.errorLog));
					if (u.push({
							name : p,
							size : "NA"
						}), 0 == o.onSelect(u))
						return
				}
				if (c(o, t), s.unbind("click"), d.hide(), h(t, r, o, s), d.addClass(r), o.serialize && a.fileapi && a.formdata) {
					d.removeClass(r);
					var f = this.files;
					d.remove(),
					l(o, t, f)
				} else {
					for (var w = "", g = 0; g < i.length; g++)
						w += o.showFileCounter ? t.fileCounter + o.fileCounterStyle + i[g] + "<br>" : i[g] + "<br>", t.fileCounter++;
					if (-1 != o.maxFileCount && t.selectedFiles + i.length > o.maxFileCount)
						return void(o.showError && e("<div class='" + o.errorClass + "'><b>" + w + "</b> " + o.maxFileCountErrorStr + o.maxFileCount + "</div>").appendTo(t.errorLog));
					t.selectedFiles += i.length;
					var C = new m(t, o);
					C.filename.html(w),
					v(d, o, C, i, t, null)
				}
			}),
			o.nestedForms ? (d.css({
					margin : 0,
					padding : 0
				}), s.css({
					position : "relative",
					overflow : "hidden",
					cursor : "default"
				}), u.css({
					position : "absolute",
					cursor : "pointer",
					top : "0px",
					width : "100%",
					height : "100%",
					left : "0px",
					"z-index" : "100",
					opacity : "0.0",
					filter : "alpha(opacity=0)",
					"-ms-filter" : "alpha(opacity=0)",
					"-khtml-opacity" : "0.0",
					"-moz-opacity" : "0.0"
				}), d.appendTo(s)) : (d.appendTo(e("body")), d.css({
					margin : 0,
					padding : 0,
					display : "block",
					position : "absolute",
					left : "-250px"
				}), -1 != navigator.appVersion.indexOf("MSIE ") ? s.attr("for", i) : s.click(function () {
					u.click()
				}))
		}
		function f(a, t) {
			return this.statusbar = e("<div style='display:none' class='ajax-file-upload-statusbar'></div>").width(t.statusBarWidth),
			this.preview = e("<img style='display:none' class='ajax-file-upload-preview' />").width(t.previewWidth).height(t.previewHeight).appendTo(this.statusbar).hide(),
			this.filename = e("<div style='display:none' class='ajax-file-upload-filename'></div>").appendTo(this.statusbar),
			this.progressDiv = e("<div style='display:none' class='ajax-file-upload-progress'>").appendTo(this.statusbar).hide(),
			this.progressbar = e("<div style='display:none' class='ajax-file-upload-bar'></div>").appendTo(this.progressDiv),
			this.abort = e("<div style='display:none' >" + t.abortStr + "</div>").appendTo(this.statusbar).hide(),
			this.cancel = e("<div style='display:none' >" + t.cancelStr + "</div>").appendTo(this.statusbar).hide(),
			this.done = e("<div style='display:none' >" + t.doneStr + "</div>").appendTo(this.statusbar).hide(),
			this.download = e("<div style='display:none' >" + t.downloadStr + "</div>").appendTo(this.statusbar).hide(),
			this.del = e("<div style='display:none' >" + t.deletelStr + "</div>").appendTo(this.statusbar).hide(),
			this.abort.addClass("ajax-file-upload-red"),
			this.done.addClass("ajax-file-upload-green"),
			this.download.addClass("ajax-file-upload-green"),
			this.cancel.addClass("ajax-file-upload-red"),
			this.del.addClass("ajax-file-upload-red"),
			this
		}
		function m(a, t) {
			var r = null;
			return r = t.customProgressBar ? new t.customProgressBar(a, t) : new f(a, t),
			r.abort.addClass(a.formGroup),
			r.abort.addClass(t.abortButtonClass),
			r.cancel.addClass(a.formGroup),
			r.cancel.addClass(t.cancelButtonClass),
			t.extraHTML && (r.extraHTML = e("<div class='extrahtml'>" + t.extraHTML() + "</div>").insertAfter(r.filename)),
			"bottom" == t.uploadQueueOrder ? e(a.container).append(r.statusbar) : e(a.container).prepend(r.statusbar),
			r
		}
		function v(t, o, s, l, n, d) {
			var h = {
				cache : !1,
				contentType : !1,
				processData : !1,
				forceSync : !1,
				type : o.method,
				data : o.formData,
				formData : o.fileData,
				dataType : o.returnType,
				beforeSubmit : function (a, r, d) {
					if (0 != o.onSubmit.call(this, l)) {
						if (o.dynamicFormData) {
							var u = i(o.dynamicFormData());
							if (u)
								for (var h = 0; h < u.length; h++)
									u[h] && (void 0 != o.fileData ? d.formData.append(u[h][0], u[h][1]) : d.data[u[h][0]] = u[h][1])
						}
						return o.extraHTML && e(s.extraHTML).find("input,select,textarea").each(function (a, t) {
							void 0 != o.fileData ? d.formData.append(e(this).attr("name"), e(this).val()) : d.data[e(this).attr("name")] = e(this).val()
						}),
						!0
					}
					return s.statusbar.append("<div class='" + o.errorClass + "'>" + o.uploadErrorStr + "</div>"),
					s.cancel.show(),
					t.remove(),
					s.cancel.click(function () {
						x.splice(x.indexOf(t), 1),
						p(n, l),
						s.statusbar.remove(),
						o.onCancel.call(n, l, s),
						n.selectedFiles -= l.length,
						c(o, n)
					}),
					!1
				},
				beforeSend : function (e, t) {
					s.progressDiv.show(),
					s.cancel.hide(),
					s.done.hide(),
					o.showAbort && (s.abort.show(), s.abort.click(function () {
							p(n, l),
							e.abort(),
							n.selectedFiles -= l.length,
							o.onAbort.call(n, l, s)
						})),
					a.formdata ? s.progressbar.width("1%") : s.progressbar.width("5%")
				},
				uploadProgress : function (e, a, t, r) {
					r > 98 && (r = 98);
					var i = r + "%";
					r > 1 && s.progressbar.width(i),
					o.showProgress && (s.progressbar.html(i), s.progressbar.css("text-align", "center"))
				},
				success : function (a, r, i) {
					if (s.cancel.remove(), D.pop(), "json" == o.returnType && "object" == e.type(a) && a.hasOwnProperty(o.customErrorKeyStr)) {
						s.abort.hide();
						var d = a[o.customErrorKeyStr];
						return o.onError.call(this, l, 200, d, s),
						o.showStatusAfterError ? (s.progressDiv.hide(), s.statusbar.append("<span class='" + o.errorClass + "'>ERROR: " + d + "</span>")) : (s.statusbar.hide(), s.statusbar.remove()),
						n.selectedFiles -= l.length,
						void t.remove()
					}
					n.responses.push(a),
					s.progressbar.width("100%"),
					o.showProgress && (s.progressbar.html("100%"), s.progressbar.css("text-align", "center")),
					s.abort.hide(),
					o.onSuccess.call(this, l, a, i, s),
					o.showStatusAfterSuccess ? (o.showDone ? (s.done.show(), s.done.click(function () {
								s.statusbar.hide("slow"),
								s.statusbar.remove()
							})) : s.done.hide(), o.showDelete ? (s.del.show(), s.del.click(function () {
								p(n, l),
								s.statusbar.hide().remove(),
								o.deleteCallback && o.deleteCallback.call(this, a, s),
								n.selectedFiles -= l.length,
								c(o, n)
							})) : s.del.hide()) : (s.statusbar.hide("slow"), s.statusbar.remove()),
					o.showDownload && (s.download.show(), s.download.click(function () {
							o.downloadCallback && o.downloadCallback(a)
						})),
					t.remove()
				},
				error : function (e, a, r) {
					s.cancel.remove(),
					D.pop(),
					s.abort.hide(),
					"abort" == e.statusText ? (s.statusbar.hide("slow").remove(), c(o, n)) : (o.onError.call(this, l, a, r, s), o.showStatusAfterError ? (s.progressDiv.hide(), s.statusbar.append("<span class='" + o.errorClass + "'>ERROR: " + r + "</span>")) : (s.statusbar.hide(), s.statusbar.remove()), n.selectedFiles -= l.length),
					t.remove()
				}
			};
			o.showPreview && null != d && "image" == d.type.toLowerCase().split("/").shift() && u(d, s.preview),
			o.autoSubmit ? (t.ajaxForm(h), x.push(t), r()) : (o.showCancel && (s.cancel.show(), s.cancel.click(function () {
						x.splice(x.indexOf(t), 1),
						p(n, l),
						t.remove(),
						s.statusbar.remove(),
						o.onCancel.call(n, l, s),
						n.selectedFiles -= l.length,
						c(o, n)
					})), t.ajaxForm(h))
		}
		var w = e.extend({
				url : "",
				method : "POST",
				enctype : "multipart/form-data",
				returnType : null,
				allowDuplicates : !0,
				duplicateStrict : !1,
				allowedTypes : "*",
				acceptFiles : "*",
				fileName : "file",
				formData : !1,
				dynamicFormData : !1,
				maxFileSize : -1,
				maxFileCount : -1,
				multiple : !0,
				dragDrop : !0,
				autoSubmit : !0,
				showCancel : !0,
				showAbort : !0,
				showDone : !1,
				showDelete : !1,
				showError : !0,
				showStatusAfterSuccess : !0,
				showStatusAfterError : !0,
				showFileCounter : !0,
				fileCounterStyle : "). ",
				showFileSize : !0,
				showProgress : !1,
				nestedForms : !0,
				showDownload : !1,
				onLoad : function (e) {},
				onSelect : function (e) {
					return !0
				},
				onSubmit : function (e, a) {},
				onSuccess : function (e, a, t, r) {},
				onError : function (e, a, t, r) {},
				onCancel : function (e, a) {},
				onAbort : function (e, a) {},
				downloadCallback : !1,
				deleteCallback : !1,
				afterUploadAll : !1,
				serialize : !0,
				sequential : !1,
				sequentialCount : 2,
				customProgressBar : !1,
				abortButtonClass : "ajax-file-upload-abort",
				cancelButtonClass : "ajax-file-upload-cancel",
				dragDropContainerClass : "ajax-upload-dragdrop",
				dragDropHoverClass : "state-hover",
				errorClass : "ajax-file-upload-error",
				uploadButtonClass : "",
				dragDropStr : "",
				uploadStr : Jnit_isLang("파일 추가"),
				abortStr : "Abort",
				cancelStr : "Cancel",
				deletelStr : "Delete",
				doneStr : "Done",
				multiDragErrorStr : "Multiple File Drag &amp; Drop is not allowed.",
				extErrorStr : "is not allowed. Allowed extensions: ",
				duplicateErrorStr : "is not allowed. File already exists.",
				sizeErrorStr : "is not allowed. Allowed Max size: ",
				uploadErrorStr : "Upload is not allowed",
				maxFileCountErrorStr : " is not allowed. Maximum allowed files are:",
				downloadStr : "Download",
				customErrorKeyStr : "jquery-upload-file-error",
				showQueueDiv : !1,
				statusBarWidth : 400,
				dragdropWidth : 400,
				showPreview : !1,
				previewHeight : "auto",
				previewWidth : "100%",
				extraHTML : !1,
				uploadQueueOrder : "top"
			}, t);
		this.fileCounter = 1,
		this.selectedFiles = 0;
		var g = "ajax-file-upload-" + (new Date).getTime();
		this.formGroup = g,
		this.errorLog = e(""),//<div></div>
		this.responses = [],
		this.existingFileNames = [],
		a.formdata || (w.dragDrop = !1),
		a.formdata || (w.multiple = !1);
		e(this).html("");
		if(vKind==1){
			var C = this,
			b = e("<div>" + w.uploadStr + "</div>");
			//b = this;
		}else if(vKind==2){
			var C = this,
			b = e("<div class='upload_info'>"+Jnit_isLang("마우스로 원하는 파일을 넣어주세요")+"</div>");
		}else if(vKind==3){
			var C = this,
			b = e("<div style='width:100%'></div>");
		}

		e(b).addClass(w.uploadButtonClass),
		function F() {
			if (e.fn.ajaxForm) {
				if (w.dragDrop) {
					var a;
					if(vKind==2){
						a = e('<div></div>');
					}else if(vKind==1){
						a = e('<div></div>');
					}else if(vKind==3){
						a = e('');//<div></div>
					}
					e(C).append(a),
					e(a).append(b),
					e(a).append(e(w.dragDropStr)),
					o(C, w, a)
				} else
					e(C).append(b);
				e(C).append(C.errorLog),
				w.showQueueDiv ? C.container = e("#" + w.showQueueDiv) : C.container = e("").insertAfter(e(C)),//<div></div>
				w.onLoad.call(this, C),
				h(C, g, w, b)
			} else
				window.setTimeout(F, 10)
		}
		(),
		this.startUpload = function () {
			e("form").each(function (a, t) {
				e(this).hasClass(C.formGroup) && x.push(e(this))
			}),
			x.length >= 1 && r()
		},
		this.getFileCount = function () {
			return C.selectedFiles
		},
		this.stopUpload = function () {
			e("." + w.abortButtonClass).each(function (a, t) {
				e(this).hasClass(C.formGroup) && e(this).click()
			}),
			e("." + w.cancelButtonClass).each(function (a, t) {
				e(this).hasClass(C.formGroup) && e(this).click()
			})
		},
		this.cancelAll = function () {
			e("." + w.cancelButtonClass).each(function (a, t) {
				e(this).hasClass(C.formGroup) && e(this).click()
			})
		},
		this.update = function (a) {
			w = e.extend(w, a)
		},
		this.reset = function (e) {
			C.fileCounter = 1,
			C.selectedFiles = 0,
			C.errorLog.html(""),
			0 != e && C.container.html("")
		},
		this.remove = function () {
			C.container.html(""),
			e(C).remove()
		},
		this.createProgress = function (e, a, t) {
			var r = new m(this, w);
			r.progressDiv.show(),
			r.progressbar.width("100%");
			var o = "";
			return o = w.showFileCounter ? C.fileCounter + w.fileCounterStyle + e : e,
			w.showFileSize && (o += " (" + s(t) + ")"),
			r.filename.html(o),
			C.fileCounter++,
			C.selectedFiles++,
			w.showPreview && (r.preview.attr("src", a), r.preview.show()),
			w.showDownload && (r.download.show(), r.download.click(function () {
					w.downloadCallback && w.downloadCallback.call(C, [e])
				})),
			w.showDelete && (r.del.show(), r.del.click(function () {
					r.statusbar.hide().remove();
					var a = [e];
					w.deleteCallback && w.deleteCallback.call(this, a, r),
					C.selectedFiles -= 1,
					c(w, C)
				})),
			r
		},
		this.getResponses = function () {
			return this.responses
		};
		var x = [],
		D = [],
		S = !1;
		return this
	}
}
(jQuery);
</script>

<div id="fileFormArea" name="fileFormArea" style="display:none">
</div>
