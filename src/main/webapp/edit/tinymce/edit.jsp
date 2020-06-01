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

<c:if test="${boardinfoVO.useLanguage == 'korea'}"><c:set var ="tinymceLang" value="ko_KR"/></c:if>
<c:if test="${boardinfoVO.useLanguage == 'eng'}"><c:set var ="tinymceLang" value="en_GB"/></c:if>
<c:if test="${boardinfoVO.useLanguage == 'chi'}"><c:set var ="tinymceLang" value="zh_CN"/></c:if>
<c:if test="${boardinfoVO.useLanguage == 'japan'}"><c:set var ="tinymceLang" value="ja"/></c:if>

<%--
	include 경로	
	1. /WEB-INF/jsp/jnit/board/board.jsp by.2014-05-28 
 --%>
<script type="text/javascript">
<!--
function Jnit_edit_img_upload(){	
	window.open("<c:url value='/edit/img/upload/popup.do'/>",'imgFileEdit','width=350, height=330, toolbar=no, scrollbars=yes, status=yes, resizable=yes');
}
//-->
</script>
<%-- full
<script src="<c:url value="/resources/js/ap/tinymce/tinymce.dev.js" />"></script>
<script src="<c:url value="/resources/js/ap/tinymce/plugins/table/plugin.dev.js" />"></script>
<script src="<c:url value="/resources/js/ap/tinymce/plugins/paste/plugin.dev.js" />"></script>
<script src="<c:url value="/resources/js/ap/tinymce/plugins/spellchecker/plugin.dev.js" />"></script> 
--%>
<script type="text/javascript" src="<c:url value="/resources/js/ap/tinymce/tinymce.min.js"/>"></script>
<script type="text/javascript">
<!--
function Jnit_tinymce_init(selector){
	tinymce.init({
	language:"${empty tinymceLang ? 'ko_KR' : tinymceLang}", //언어설정
	selector: "#"+selector, //id
	//invalid_elements : "script,iframe",
	plugins: [ //플러그인 주석부분은 오류로인하여 주석처리함
		  "advlist anchor autolink", // autosave autoresize
		  //"bbcode"
		  "charmap code contextmenu", //도구 소스코드
		  "directionality",
		  //"emoticons example example_dependency",
		  //"fullpage fullscreen", <!DOCTYPE html>기본html 생성
		  "hr",
		  "image  insertdatetime",//importcss
		  "layer link lists", //legacyoutput
		  //"media"
		  "nonbreaking noneditable",
		  "pagebreak paste preview print",
		  //"save searchreplace spellchecker",
		  "tabfocus table template textcolor",
		  "visualblocks visualchars",
		  //"wordcount"
	  ],
	  target_list: [ //link target 지정
		{title: '_blank', value: '_blank'},
		{title: '_self', value: '_self'}     
	  ],
	  image_advtab : true, // 사용자 지정 스타일
	  height : 300, //아래는 고정
	  /* autoresize 반응형으로 쓰였지만 overflow 발생시 x좌표 스크롤이 2개생성 끝쪽 클릭하면 작동안하는 문제 발생
	  autoresize_min_height: 300, //편집기 최소 높이
	  autoresize_max_height: 400, //편집기 최대 높이
	  */
	  //forced_root_block: false,//IE에서 한글입력 문제 해결을 위해서 //한칸띠고 다음문장적을시 지워지는 문제 발생
	  relative_urls : false,//이미지 상대경로 치환부분 막기
	  //폰트지정
	  //theme_advanced_fonts: "굴림=굴림;굴림체=굴림체;궁서=궁서;궁서체=궁서체;돋움=돋움;돋움체=돋움체;바탕=바탕;바탕체=바탕체;Arial=Arial; Comic Sans MS='Comic Sans MS';Courier New='Courier New';Tahoma=Tahoma;Times New Roman='Times New Roman';Verdana=Verdana",
	  //toolbar = | 그룹 구분자
	  /* 2014-10-31 by.나성재 수정 툴바 수정
	  toolbar1: "newdocument | fullpage | bold | italic | underline | strikethrough | alignleft | aligncenter | alignright | alignjustify",
	  toolbar2: "bullist | numlist | outdent | indent | blockquote | undo | redo | cut | copy | paste | searchreplace",
	  toolbar3: "table | hr | removeformat | subscript | superscript | charmap | emoticons | print | fullscreen | link | unlink | anchory", //| spellchecker | template | pagebreak
	  toolbar4: "ltr | rtl | visualchars | visualblocks | nonbreaking | image | code | inserttime | preview | forecolor | backcolor",
	  toolbar5: "fontselect | fontsizeselect" //fontsizeselect 와 기본 format headings 오류있음
	  */
	  toolbar1: "code | undo | redo | cut | copy | paste | searchreplace | charmap | emoticons | image | table | visualblocks",
	  toolbar2: "fontselect | fontsizeselect | forecolor | backcolor | bold | italic | underline | strikethrough | alignleft | aligncenter | alignright | alignjustify | bullist | numlist | outdent | indent | hr | removeformat | subscript | superscript | link | unlink | anchory"      
	});
}
$(document).ready(function(){
	Jnit_tinymce_init("Jnit_edit");
});
//-->
</script>