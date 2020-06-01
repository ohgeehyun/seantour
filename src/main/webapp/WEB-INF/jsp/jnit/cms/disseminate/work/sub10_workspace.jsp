<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="jnit.cms.config.ConfigUtil"%>
<%	
	String overlap = ConfigUtil. getDefaultProp("overlap");
%>
<c:set var="overlap" value="<%= overlap %>"/>
<script type="text/javascript">
<!--
if("${loginVO.mbrId}" == ""){
	alert("로그인을 해주시기 바랍니다.");
	window.close();
}
var menuContentError = "${menuContentError }";
if(menuContentError == "FAIL 1"){
	alert("잘못된 접근입니다.");
	window.close();
}
//-->
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>JNITCMS :: 메뉴/콘텐츠관리</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="author" type="text/plain" href="<c:url value="/humans.txt"/>" />
	
    <!--[if IE 7]>
	  	<link rel="stylesheet" href="/resources/css/font-awesome-ie7.min.css" />
	  	<link rel="stylesheet" type="text/css" href="/resources/css/ie7_main.css" />
  	<![endif]-->
  	
    <%-- 기본(default) CSS --%>
	<c:if test="${empty skinMode || skinMode == 'default'}">
		<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/jnit.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/jnit.main.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/select.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/js/codemirror-5.25.0/lib/codemirror.css" />" />
	</c:if>
	
	<%-- 블랙(balck) CSS --%>
	<c:if test="${skinMode == 'black'}">
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black//bootstrap.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/jnit.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/jnit.main.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/jquery-ui.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/select.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/codemirror.css"/>" />
	</c:if>
	
	<%-- 화이트(white) CSS --%>
	<c:if test="${skinMode == 'white'}">
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/bootstrap.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/jnit.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/jnit.main.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/jquery-ui.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/select.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/js/codemirror-5.25.0/lib/codemirror.css" />" />
	</c:if>
    
    <link rel="stylesheet" href="<c:url value="/resources/css/menuContent/imsi.css" />" />
	<link rel="stylesheet" href="<c:url value="/resources/css/menuContent/jnit_menuContent.css" />" />
	<link rel="stylesheet" href="<c:url value="/resources/css/jnit.dashboard.css" />" />
	<link rel="stylesheet" href="<c:url value="/resources/css/calendar.css" />" />
	<link rel="stylesheet" href="<c:url value="/resources/css/color_picker.css" />" />
	<link rel="stylesheet" href="<c:url value="/resources/css/date_picker.css" />" />
	<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap-responsive.css" />" />
	<link rel="stylesheet" href="<c:url value="/resources/css/font-awesome.min.css" />" />
    
    <script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/>"></script>
	<script src="<c:url value="/resources/js/codemirror-5.25.0/lib/codemirror.js" />"></script>
	<script src="<c:url value="/resources/js/codemirror-5.25.0/mode/xml/xml.js" />"></script>
	<script src="<c:url value="/resources/js/codemirror-5.25.0/mode/css/css.js" />"></script>
	<script src="<c:url value="/resources/js/codemirror-5.25.0/mode/javascript/javascript.js" />"></script>
	<style type="text/css">
		.CodeMirror {border-top: 1px solid black; border-bottom: 1px solid black;}
		.activeline {background: #e8f2ff !important;}
	</style>
	<script language="javascript">
		function popGallery(num){
			var url = "tour_galley_main_0" + num + ".html";
			var popup = window.open(url, "tour", "width=585, height=600, scrollbars=no;");
			popup.focus();
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
		
		var CodeEditor;
		var CodeHl;
		$(document).ready(function(){
			
			if($.browser.msie != true) {
				try {
					CodeEditor = CodeMirror.fromTextArea(document.getElementById("tplSrc"), {
					  mode: "application/xml",
					  lineNumbers: true,
					  lineWrapping: true,
					  onCursorActivity: function() {
					    CodeEditor.setLineClass(CodeHl, null, null);
					    CodeHl = CodeEditor.setLineClass(CodeEditor.getCursor().line, null, "activeline");
					  }
					});
					CodeHl = CodeEditor.setLineClass(0, "activeline");
					
					$('.CodeMirror').css('width', $(window).width()-400 );
					$('td.content_1').css('width', $(window).width()-550 );
					$('td.content_1').css('margin-right', '10px');
					$('.CodeMirror').css('height', $('textarea[name=tplSrc]').height()-10 );
					$('.CodeMirror-scroll').css('height', $('textarea[name=tplSrc]').height()-10 );
					$('.CodeMirror-scrollbar').css('height', $('textarea[name=tplSrc]').height()-10 );
					
					resizeEditor();
					$(window).bind('resize', resizeEditor);
				}catch(e) {
					//
				}
				
				try {
					CodeEditor = CodeMirror.fromTextArea(document.getElementById("cntSrc"), {
					  mode: "application/xml",
					  lineNumbers: true,
					  lineWrapping: true,
					  onCursorActivity: function() {
					    CodeEditor.setLineClass(CodeHl, null, null);
					    CodeHl = CodeEditor.setLineClass(CodeEditor.getCursor().line, null, "activeline");
					  }
					});
					CodeHl = CodeEditor.setLineClass(0, "activeline");
					
					$('.CodeMirror').css('width', $('textarea[name=cntSrc]').width() );
					$('.CodeMirror').css('height', $('textarea[name=cntSrc]').height()-10 );
					$('.CodeMirror-scroll').css('height', $('textarea[name=cntSrc]').height()-10 );
					$('.CodeMirror-scrollbar').css('height', $('textarea[name=cntSrc]').height()-10 );
				}catch(e) {
					//
				}
			}
		});
	</script>
	<script type="text/javascript">
		var request_uri = '<c:out value="${requestScope['javax.servlet.forward.request_uri']}" />';
		var context_path = '<c:out value="${requestScope['javax.servlet.forward.context_path']}" />';
		request_uri = request_uri.replace(context_path, '');
		var menuId = '<c:out value="${menuId}" />';
	</script>	
</head>
<body>
<%-- BackOffice & site 팝업 공용 --%>
<%@ include file="/WEB-INF/jsp/jnit/cms/disseminate/common/menuContent1_Script.jsp" %>
<div id="content">
	<script type="text/javascript">
	<!--
    $(document).ready(function(){
        $('#manualOpen').click(function(e){
            e.preventDefault();
            /*
            var url = "http://ltskorea.co.kr/JNITCMS_manual.zip";
            window.open(url,"CMS메뉴얼", "width=721, height=900, toolbar=yes, scrollbars=yes");
            */
            location.href="http://ltskorea.co.kr/JNITCMS_manual.zip";
        });
    });
	//-->
    </script>
	<div id="content-header">
		<div class="btn-group" style="width: auto;">
			<a href="#" title="" class="btn btn-large tip-bottom"><i class="icon-remove"></i></a>
		</div>
		<h2 class="left_title">메뉴/콘텐츠관리</h2>
	</div>
	<div id="user-nav" class="navbar navbar-inverse">
		<ul class="nav btn-group" style="width: auto; margin: 0px;">  
			<li class="btn btn-inverse"><a class="cmsMenu" href="#"><i class="icon icon-cog"></i><span class="txt">메인 관리</span></a></li>            
			<li class="btn btn-inverse"><a class="cmsMenu" href="#"><i class="icon icon-file"></i><span class="txt">메뉴 관리</span></a></li>            
			<!-- <li class="btn btn-inverse"><a class="cmsMenu" href="#"><i class="icon icon-eye-open"></i><span class="txt">CSS관리</span></a></li>            
			<li class="btn btn-inverse"><a class="cmsMenu" href="#"><i class="icon icon-cogs"></i><span class="txt">Script관리</span></a></li>  --> 
		</ul>
	</div>
	<div class="content_view">	
		<%-- Contents Start --%>	
		<div class="list_content2">
			<div class="content_btn">
				<a class="btn btn-small" href="javascript:addFolNode(getActNode());"><i class="icon icon-folder-open"></i><span>새 메뉴</span></a>
				<a class="btn btn-small" href="javascript:addConNode(getActNode());"><i class="icon icon-file"></i><span>새 콘텐츠</span></a>
				<a class="btn btn-small" href="javascript:editNode(getActNode());"><i class="icon icon-wrench"></i><span>수정</span></a>
				<a class="btn btn-small" href="javascript:delNode(getActNode());"><i class="icon icon-trash"></i><span>삭제</span></a>
				<a class="btn btn-small pull-right" href="javascript:rebuildTreeJson();"><i class="icon icon-share"></i><span>빌드</span></a>
			</div>
			<div class="content_in">
				<div id="tree" style="width: 350px; height: 750px;"></div> 
			</div>
		</div>
		<!-- 메뉴 & 콘텐츠 정보 수정 Ajax -->
		<div class="view_content2">
			<div id="attrEditor" style="width:100%;"></div>
			<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
					<div id="mbrSearch"></div>
				</div>
			</div>
		</div>
		<%-- Contents End --%>
	</div>
</div>
<div id="footer">
  	<p>COPYRIGHT © 2017 JNITCMS. All Rights Reserved.</p>
</div>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.ui.datepicker-ko.js" /> "></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.ui.timepicker.addon.js" /> "></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.peity.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.flot.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.flot.resize.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.dataTables.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.uniform.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.fullcalendar.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.alphanumeric.pack.js"/> "></script>
	<script src="<c:url value="/resources/js/excanvas.min.js"/>" ></script>    
	<script src="<c:url value="/resources/js/bootstrap.js"/>" ></script>
	<script src="<c:url value="/resources/js/bootstrap-colorpicker.js"/>" ></script>
	<script src="<c:url value="/resources/js/select2.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jnit.form_common.js"/>" ></script>
	<script src="<c:url value="/resources/js/jnit.tables.js"/>" ></script>
	<script src="<c:url value="/resources/js/jnit.js" />" ></script>
	<%-- <c:catch var="e2">	
		<jsp:include page="/${sitePath }/common/config/handing/jsHanding.jsp"></jsp:include>
	</c:catch> --%>
</body>
</html>