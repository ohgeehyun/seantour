<%
/**
 *@version 3.2.0.1
 **/
%>
<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0); 
if (request.getProtocol().equals("HTTP/1.1")) 
response.setHeader("Cache-Control", "no-cache"); 
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("lf", "\n"); %>
<%@ page import = "org.springframework.web.context.*, org.springframework.web.context.support.*, jnit.visit.log.JnitvisitlogImportController, egovframework.com.utl.fcc.service.NullUtil"%>
<%@ page import = "jnit.cms.*, jnit.cms.mbr.*, jnit.cms.handler.*, egovframework.com.cmm.service.EgovProperties"%>
<%
WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletConfig().getServletContext());
CmsProperty cmsProperty = (CmsProperty)ctx.getBean("cmsProperty");
cmsProperty.setClientProperty(new CmsClientProperty());
CmsClientProperty cmsClientProperty = cmsProperty.getClientProperty();
cmsClientProperty.init(request);
//System.out.println(request);
//System.out.println("==>" + cmsClientProperty.request);
JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
%>
<% if(loginVO.getTypeId() == null) { %>
<script type="text/javascript">
	var request_uri = '<c:out value="${requestScope['javax.servlet.forward.request_uri']}" />';
	var context_path = '<c:out value="${requestScope['javax.servlet.forward.context_path']}" />';
	request_uri = request_uri.replace(context_path, '');

	location.replace('<c:url value="/cms/login.do"/>'+(request_uri ? '?returnUrl='+request_uri : ''));
</script>
<% return; } %>
<%
/* 관리자 레벨 */
final String admLevelProp = EgovProperties.getProperty(EgovProperties.getProperty("Webadm.Properties"), "Webadm.Levels");
final String[] admLevels = admLevelProp.split(",");
boolean loginAdmin = false;
for(int i1=0; i1<admLevels.length; i1++) {
        if(loginAdmin == false) {
                if(loginVO.getTypeVO().getTypeLv().equals(admLevels[i1])) {
                        loginAdmin = true;
                }
        }
}
if(!loginAdmin) { %>
<script type="text/javascript">
        var request_uri = '<c:out value="${requestScope['javax.servlet.forward.request_uri']}" />';
        var context_path = '<c:out value="${requestScope['javax.servlet.forward.context_path']}" />';
        request_uri = request_uri.replace(context_path, '');

        location.replace('<c:url value="/"/>');
</script>
<% return; } %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><c:out value="${customTitle != '' ? customTitle : 'CMS 관리자모드'}"/></title>
<!-------------------------------------------------------------
------ Wysiwyg Editor------------------------------------------
------ Daum Editor(https://github.com/daumeditor/DaumEditor/)
-------------------------------------------------------------->
<link rel="stylesheet" href="<c:url value="/bbs/_editor/css/editor.css" />" type="text/css" charset="utf-8"/>
<link rel="stylesheet" href="<c:url value="/js/jquery.ui/css/jnit/jquery-ui-1.9.0.custom.min.css" />" type="text/css" charset="utf-8"/>
<script src="<c:url value="/bbs/_editor/js/editor_loader.js" />" type="text/javascript" charset="utf-8"></script>
<!-- End of Wysiwyg Editor -->
<script type="text/javascript" src="<c:url value="/js" />/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<c:url value="/js" />/jquery.ui/js/jquery-ui-1.9.0.custom.min.js"></script>
<script type="text/javascript" src="<c:url value="/js" />/jquery.ui/development-bundle/ui/i18n/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="<c:url value="/js" />/jquery.ui/js/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.alphanumeric.pack.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/js/codemirror-5.25.0/lib/codemirror.css" />" />
<script src="<c:url value="/js/codemirror-5.25.0/lib/codemirror.js" />"></script>
<script src="<c:url value="/js/codemirror-5.25.0/mode/xml/xml.js" />"></script>
<script src="<c:url value="/js/codemirror-5.25.0/mode/css/css.js" />"></script>
<script src="<c:url value="/js/codemirror-5.25.0/mode/javascript/javascript.js" />"></script>
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
		$('.CodeMirror').css('width', $(window).width()-400 );
		$('td.content_1').css('width', $(window).width()-550 );
		$('td.content_1').css('margin-right', '10px');
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
<link rel="stylesheet" href="<c:url value="/images/jnit/cms/main.css" />" type="text/css" />
<link rel="stylesheet" href="<c:url value="/images/jnit/cms/admin.css" />" type="text/css" />
<link rel="stylesheet" href="<c:url value="/js/jquery.ui/css/jnit/jquery-ui-1.9.0.custom.min.css" />" type="text/css" />
<script type="text/javascript" src="<c:url value="/images/jnit/cms/common.js" />"></script>

</head>

<body>

<!--<c:out value="${loginVO.typeVO.typeLv}" />-->