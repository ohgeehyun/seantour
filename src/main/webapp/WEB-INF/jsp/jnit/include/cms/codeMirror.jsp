<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<%-- 기본(default) CSS --%>
	<c:if test="${empty skinMode || skinMode == 'default'}">
		<link rel="stylesheet" href="<c:url value="/resources/js/codemirror-5.25.0/lib/codemirror.css" />" />
	</c:if>
	
	<%-- 블랙(balck) CSS --%>
	<c:if test="${skinMode == 'black'}">
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/codemirror.css"/>" />
	</c:if>
	
	<%-- 화이트(white) CSS --%>
	<c:if test="${skinMode == 'white'}">
		<link rel="stylesheet" href="<c:url value="/resources/js/codemirror-5.25.0/lib/codemirror.css" />" />
	</c:if>

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
		
		try {
			CodeEditor = CodeMirror.fromTextArea(document.getElementById("ebookContent"), {
			  mode: "application/xml",
			  lineNumbers: true,
			  lineWrapping: true,
			  onCursorActivity: function() {
			    CodeEditor.setLineClass(CodeHl, null, null);
			    CodeHl = CodeEditor.setLineClass(CodeEditor.getCursor().line, null, "activeline");
			  },
			  onKeyEvent: function (e, s) {
				    if (s.type == "keyup") {
				    	$("#ebookContent").html(CodeEditor.getValue());
				    }
				}
			});
			
			CodeHl = CodeEditor.setLineClass(0, "activeline");			
			$('.CodeMirror').css('width', $('textarea[name=ebookContent]').width() );
			$('.CodeMirror').css('height', $('textarea[name=ebookContent]').height());
			$('.CodeMirror-scroll').css('height', $('textarea[name=ebookContent]').height());
			$('.CodeMirror-scrollbar').css('height', $('textarea[name=ebookContent]').height());
			$(window).bind('resize', resizeEditor);
		}catch(e) {
			//
		}
	
});
</script>