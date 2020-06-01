<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="<c:url value="/resources/js/ap/smartEditor/js/service/HuskyEZCreator.js" />" charset="utf-8"></script>
<script type="text/javascript">
<!--
var oEditors = [];

// 추가 글꼴 목록
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

var smartEditor = {
	init : function(selector){
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: selector,
			sSkinURI: '<c:url value="/resources/js/ap/smartEditor/SmartEditor2Skin.html" />',	
			htParams : {
				bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
				fOnBeforeUnload : function(){
					//alert("완료!");
				}
			}, //boolean
			fOnAppLoad : function(){
				//예제 코드
				//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			},
			fCreator: "createSEditor2"
		});
	},
	pasteHTML : function(selector,htmlSources) {
		var sHTML = htmlSources;
		oEditors.getById[selector].exec("PASTE_HTML", [sHTML]);
	},
	showHTML : function(selector) {
		var sHTML = oEditors.getById[selector].getIR();
		return sHTML;
	},
	setDefaultFont : function(selector,font,size) {
		var sDefaultFont = font;
		var nFontSize = size;
		oEditors.getById[selector].setDefaultFont(sDefaultFont, nFontSize);
	},
	setText : function(selector){
		oEditors.getById[selector].exec("UPDATE_CONTENTS_FIELD", []);
	}
}

$(document).ready(function(){
	smartEditor.init("Jnit_edit");
});
//-->
</script>