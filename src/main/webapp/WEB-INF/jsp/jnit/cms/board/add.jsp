<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<c:set var="screenMode" value="${searchVO.screenMode == 'up' ? '수정' : '등록' }" />
<script src="<c:url value="/resources/js/jquery.form.js"/>"></script>
<script type="text/javascript">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitboardinfoVO").action = "<c:url value='/cms/board/list.do'/>";
   	document.getElementById("jnitboardinfoVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
	//alert("삭제 기능을 지원하지 않습니다.");
	
	if(confirm("정말 삭제하시겠습니까?") == true) {
   		frm = document.getElementById("jnitboardinfoVO");
   		frm.action = "<c:url value='/cms/board/procDel.do'/>";
   	    frm.submit();
	}
	
}

//null check
function Jnit_save_bln(){
	var boardTitle = $("#boardTitle").val();
	var rowCnt = $("#rowCnt").val();
	var boardLbl = $("#boardLbl").val();
	var fieldSortList = $("#fieldSortList").val();
	var fieldSortView = $("#fieldSortView").val();
	var fieldSortWrite = $("#fieldSortWrite").val();
	var boardType = $("#boardType option:selected").val();
	var fieldSortListbln = false;
	var iconlist = $("#iconlist").val().split(",");
	for(var i=0; i<iconlist.length; i++){
		var iconVal = $("input:radio[name='"+iconlist[i]+"']:checked").val();
		if("1" == iconVal || "2" == iconVal){
			var iconKeyValue = $("#"+iconlist[i]+"_value").val();
			if(iconKeyValue == '' || iconKeyValue == null){
				alert("아이콘 설정 값을 입력 해주시기 바랍니다.");
				$("#"+iconlist[i]+"_value").focus();
				return false;
			}else if(iconKeyValue.match(/^[0-9]+$/) == null){
				alert("숫자들만 사용하시기 바랍니다.");
				$("#"+iconlist[i]+"_value").focus();
				return false;
			}
		}	
	}	
	if(boardTitle == '' || boardTitle == null){
		alert("게시판 제목을 입력해주시기 바랍니다.");
		$("#boardTitle").focus();
		return false;
	}else if(rowCnt == '' || rowCnt == null){
		if(confirm("게시물수를 입력 비어있습니다 초기값으로 지정하시겠습니까?")){
			$("#rowCnt").val(15);
		}else{
			$("#rowCnt").focus();
			return false;	
		}		
	}else if(rowCnt.match("^[0-9]+$") == null){		
		alert("숫자만 입력해주시기 바랍니다.");
		$("#rowCnt").focus();
		return false;
	}
	if(boardLbl == '' || boardLbl == null){
		if(confirm("기본 라벨을 입력이 비어있습니다 초기값으로 지정하시겠습니까?")){
			$("#boardLbl").val("번호|제목|작성자|작성일|조회수|내용");		
		}else{
			$("#boardLbl").focus();
			return false;
		}		
	}
	if(fieldSortList == '' || fieldSortList == null){
		if(confirm("목록 노출 순서를 입력이 비어있습니다 초기값으로 지정하시겠습니까?")){
			$("#fieldSortList").val("no,title,writer,created,hit");
		}else{
			$("#fieldSortList").focus();
			return false;
		}		
	}
	if(fieldSortView == '' || fieldSortView == null){
		if(confirm("상세뷰 노출 순서를 입력이 비어있습니다 초기값으로 지정하시겠습니까?")){
			$("#fieldSortView").val("content");			
		}else{
			$("#fieldSortView").focus();
			return false;
		}		
	}
	if(fieldSortWrite == '' || fieldSortWrite == null){
		if(confirm("등록 노출 순서를 입력이 비어있습니다 초기값으로 지정하시겠습니까?")){
			$("#fieldSortWrite").val("title,writer,created,hit,content");
		}else{
			$("#fieldSortWrite").focus();
			return false;
		}
	}else if(!Jnit_fieldSortWrite_bln(fieldSortWrite)){
		return false;
	}
	
	//여분필드 null 기본세팅
	for(var i=1; i<21; i++){
		var useExt = $("#useExt"+(i < 10 ? '0' : '')+i+" option:selected").val();
		if(useExt != '' && useExt == '0'){
			var extlbl = $("#ext"+(i < 10 ? '0' : '')+i+"Lbl").val();
			if(extlbl == '' || extlbl == null){
				$("#ext"+(i < 10 ? '0' : '')+i+"Lbl").val("여분필드"+(i < 10 ? '0' : '')+i+" 라벨 입력");
			}					
			if(fieldSortList.indexOf("ext"+(i < 10 ? '0' : '')+i) > -1){
				fieldSortList = $("#fieldSortList").val();
				fieldSortList = fieldSortList.replace(",ext"+(i < 10 ? '0' : '')+i,'');				
				$("#fieldSortList").val(fieldSortList);
			}
			if(fieldSortView.indexOf("ext"+(i < 10 ? '0' : '')+i) > -1){
				fieldSortView = $("#fieldSortView").val();
				fieldSortView = fieldSortView.replace(",ext"+(i < 10 ? '0' : '')+i,'');
				$("#fieldSortView").val(fieldSortView);
			}
			if(fieldSortWrite.indexOf("ext"+(i < 10 ? '0' : '')+i) > -1){
				fieldSortWrite = $("#fieldSortWrite").val();
				fieldSortWrite = fieldSortWrite.replace(",ext"+(i < 10 ? '0' : '')+i,'');
				$("#fieldSortWrite").val(fieldSortWrite);
			}
		}else{
			var extlbl = $("#ext"+(i < 10 ? '0' : '')+i+"Lbl").val();
			if(extlbl == '' || extlbl == null){
				if(confirm("여분필드"+(i < 10 ? '0' : '')+i+"라벨을 입력이 비어있습니다 초기값으로 지정하시겠습니까?")){
					$("#ext"+(i < 10 ? '0' : '')+i+"Lbl").val("여분필드"+(i < 10 ? '0' : '')+i+" 라벨 입력");
				}else{
					$("#ext"+(i < 10 ? '0' : '')+i+"Lbl").focus();
					return false;
				}
			}
			/*
			if(boardType != '' || boardType != null){
				if(boardType != 'calendar'
						&& boardType != 'schedule'
						&& boardType != 'scheduleList'
						&& boardType != 'faq'
						&& boardType != 'gallery' ){
					
					if(fieldSortList.indexOf("ext"+(i < 10 ? '0' : '')+i) == -1){
						if(confirm("목록 노출순서에 여분필드 ext"+(i < 10 ? '0' : '')+i+" 선언되있지 않습니다. ext"+(i < 10 ? '0' : '')+i+"을 에 추가하시겠습니까?")){
							$("#fieldSortList").val($("#fieldSortList").val()+",ext"+(i < 10 ? '0' : '')+i);
						}else{				
							$("#fieldSortList").focus();
							return false;
						}
					}
				}else {
					fieldSortListbln = true;
				}
			}			
			if(fieldSortView.indexOf("ext"+(i < 10 ? '0' : '')+i) == -1){
				if(confirm("보기 노출순서에 여분필드 ext"+(i < 10 ? '0' : '')+i+" 선언되있지 않습니다. ext"+(i < 10 ? '0' : '')+i+"을 에 추가하시겠습니까?")){
					$("#fieldSortView").val($("#fieldSortView").val()+",ext"+(i < 10 ? '0' : '')+i);
				}else{
					$("#fieldSortView").focus();
					return false;
				}
			}
			if(fieldSortWrite.indexOf("ext"+(i < 10 ? '0' : '')+i) == -1){
				if(confirm("등록 노출순서에 여분필드 ext"+(i < 10 ? '0' : '')+i+" 선언되있지 않습니다. ext"+(i < 10 ? '0' : '')+i+"을 에 추가하시겠습니까?")){
					$("#fieldSortWrite").val($("#fieldSortWrite").val()+",ext"+(i < 10 ? '0' : '')+i);
				}else{					
					$("#fieldSortWrite").focus();
					return false;
				}
			}
			*/
		}
	}
	//여분날짜필드 null 기본세팅
	for(var i=1; i<3; i++){
		var useDate = $("#useDate0"+i+" option:selected").val();
		if(useDate != '' && useDate == '0'){
			var dateLbl = $("#date0"+i+"Lbl").val();
			if(dateLbl == '' || dateLbl == null){
				$("#date0"+i+"Lbl").val("여분날짜0"+i+" 라벨 입력");
			}
			if(fieldSortList.indexOf("date0"+i) > -1){
				fieldSortList = $("#fieldSortList").val();
				fieldSortList = fieldSortList.replace(",date0"+i,'');				
				$("#fieldSortList").val(fieldSortList);
			}
			if(fieldSortView.indexOf("date0"+i) > -1){
				fieldSortView = $("#fieldSortView").val();
				fieldSortView = fieldSortView.replace(",date0"+i,'');
				$("#fieldSortView").val(fieldSortView);
			}
			if(fieldSortWrite.indexOf("date0"+i) > -1){
				fieldSortWrite = $("#fieldSortWrite").val();
				fieldSortWrite = fieldSortWrite.replace(",date0"+i,'');
				$("#fieldSortWrite").val(fieldSortWrite);
			}
		}else{
			var dateLbl = $("#date0"+i+"Lbl").val();
			if(dateLbl == '' || dateLbl == null){
				if(confirm("여분날짜0"+i+" 라벨 입력이 비어있습니다 초기값으로 지정하시겠습니까?")){
					$("#date0"+i+"Lbl").val("여분날짜0"+i+" 라벨 입력");
				}else{
					$("#date0"+i+"Lbl").focus();
					return false;
				}
			}

			/*
			if(boardType != '' || boardType != null){
				if(boardType != 'calendar'
						&& boardType != 'schedule'
						&& boardType != 'scheduleList'
						&& boardType != 'faq'
						&& boardType != 'gallery'){
					
					if(fieldSortList.indexOf("date0"+i) == -1){
						if(confirm("목록 노출순서에 여분날짜 date0"+i+" 선언되있지 않습니다. date0"+i+"을 에 추가하시겠습니까?")){
							$("#fieldSortList").val($("#fieldSortList").val()+",date0"+i);
						}else{
							$("#fieldSortList").focus();
							return false;
						}
					}
				}else {
					fieldSortListbln = true;
				}
			}
			
			if(fieldSortView.indexOf("date0"+i) == -1){
				if(confirm("보기 노출순서에 여분날짜 date0"+i+" 선언되있지 않습니다. date0"+i+"을 에 추가하시겠습니까?")){
					$("#fieldSortView").val($("#fieldSortView").val()+",date0"+i);
				}else{
					$("#fieldSortView").focus();
					return false;
				}
			}
			if(fieldSortWrite.indexOf("date0"+i) == -1){
				if(confirm("등록 노출순서에 여분날짜 date0"+i+" 선언되있지 않습니다. date0"+i+"을 에 추가하시겠습니까?")){
					$("#fieldSortWrite").val($("#fieldSortWrite").val()+",date0"+i);
				}else{
					$("#fieldSortWrite").focus();
					return false;
				}
			}
			*/
		}
			
	}
	
	//목록순서 message
	if(fieldSortListbln){
		alert("선택하신 유형 "+boardType+"은 개발자에게 문의하여 목록 노출순서를 제어하시기 바랍니다.");
	}
	
	return true;	
}

/* 글 등록 function */
function fn_egov_save() {
	if(Jnit_save_bln()){ // null check
		var fieldSortList 	= $("#fieldSortList").val();
		var fieldSortView 	= $("#fieldSortView").val();
		var fieldSortWrite 	= $("#fieldSortWrite").val();
		var boardLbl 		= $("#boardLbl").val();
		
		$("#fieldSortList").val(fieldSortList.replace(/(\s*)/g,""));
		$("#fieldSortView").val(fieldSortView.replace(/(\s*)/g,""));
		$("#fieldSortWrite").val(fieldSortWrite.replace(/(\s*)/g,""));
		$("#boardLbl").val(boardLbl.replace(/(\s*)/g,""));
		
		frm = document.getElementById("jnitboardinfoVO");
		frm.action = "<c:url value='/cms/board/proc.do'/>";
	    frm.submit();	
	}
}

//도움말
function Jnit_question(num){
	
	if(num >= 20 && num <= 41){
		boardHelperOpen();
	}else if($("#question"+num).css("display") == 'none'){
		if(num == '58'){ //비회원 접근권한			
			$("#Jnit_boardDepth5").attr("rowspan", (Number($("#Jnit_boardDepth5").attr("rowspan"))+1));
			$("#anonPermId").attr("rowspan", (Number($("#anonPermId").attr("rowspan"))+1));
		}
		$("#question"+num).css("display","");
	}else{
		if(num == '58'){ //비회원 접근권한
			$("#Jnit_boardDepth5").attr("rowspan", (Number($("#Jnit_boardDepth5").attr("rowspan"))-1));
			$("#anonPermId").attr("rowspan", (Number($("#anonPermId").attr("rowspan"))-1));
		}
		$("#question"+num).css("display","none");
	}
}

function boardHelperOpen(){
	var url = "<c:url value="/resources/img/ext_guide.gif"/>";
	window.open(url, "CMSHELPER", "width=700 height=811");
}

function open_mbrSearch() {
	if($("div#mbrSearch").css("display") == "none") {
		$("div#mbrSearch").show();
		$('#myModal').modal('toggle');
		$.ajax({
			  type: "GET",
			  url: "<c:url value='/cms/sub2/0101.do?ajax=Y'/>",
			  success:function(data) {
				$("div#mbrSearch").html(data);
			  },
			  error:function(result) {
				//alert(result);
			  }
		});
	}else {
		$("div#mbrSearch").hide();
		$('#myModal').modal('toggle');
	}
}

//언어설정
function Jnit_useLang(lang){	
	if(lang == 'korea'){			
		//기본라벨		
		$("#boardLbl").val("번호|제목|작성자|작성일|조회수|내용");	
	}else if(lang == 'eng'){
		//기본라벨
		$("#boardLbl").val("no|title|writer|created|hit|content");
	}else if(lang == 'chi'){
		//기본라벨
		$("#boardLbl").val("序号|标题|填写人|填写日期|查看次数|内容");
	}else if(lang == 'japan'){
		//기본라벨
		$("#boardLbl").val("番号|タイトル|著者|日|再生回数|内容");
	}
}

//필드셋팅
function Jnit_settingField(lang,boardType,reset){
	
	if(reset != '' && reset == 'reset'){
		//여분날짜필드01
		$("#useDate01").val("0");
		$(".useDate01").hide();
		//여분날짜필드02
		$("#useDate02").val("0");
		$(".useDate02").hide();
		//목록 노출순서
		$("#fieldSortList").val("no,title,writer,created,hit,file");
		//보기 노출 순서
		$("#fieldSortView").val("content");
		//등록 노출 순서
		$("#fieldSortWrite").val("title,writer,created,hit,content");
		//파일첨부
		$("#useFile1").attr("checked",true);
		$("#useFile1").uniform();
		$("#useFile0").attr("checked",false);
		$("#useFile0").uniform();
		$("#useFile2").attr("checked",false);
		$("#useFile2").uniform();
		//위지윅에디터
		$("#useWyswyg1").attr("checked",true);
		$("#useWyswyg1").uniform();
		$("#useWyswyg0").attr("checked",false);
		$("#useWyswyg0").uniform();
		//위지윅에디터 종류
		$("#useWyswygType0").attr("checked",true);
		$("#useWyswygType0").uniform();		
		//이미지첨부
		$("#useImage1").attr("checked",true);
		$("#useImage1").uniform();
		$("#useImage0").attr("checked",false);
		$("#useImage0").uniform();
	}
	
	//데이터설정
	if(boardType.indexOf('calendar') > -1 || boardType.indexOf('schedule') > -1 || boardType.indexOf('scheduleList') > -1){
		//여분날짜필드01
		$("#useDate01").val("1");
		$(".useDate01").show();
		//여분날짜필드02
		$("#useDate02").val("1");
		$(".useDate02").show();		
		//등록 노출 순서
		$("#fieldSortWrite").val("title,writer,created,hit,content,date01,date02");		
		//공지글
		$("#useNotice0").attr("checked",true);
		$("#useNotice0").uniform();
		$("#useNotice1").attr("checked",false);
		$("#useNotice1").uniform();
		//비밀글
		$("#useSecret0").attr("checked",true);
		$("#useSecret0").uniform();
		$("#useSecret1").attr("checked",false);
		$("#useSecret1").uniform();		
	}else if(boardType.indexOf('gallery') > -1 || boardType.indexOf('movie') > -1 || boardType.indexOf('thumbnail') > -1 || boardType.indexOf('media') > -1){
		//목록 노출순서
		$("#fieldSortList").val("no,title,writer,created,hit,img");		
	}else if(boardType.indexOf('faq') > -1){
		//공지글
		$("#useNotice0").attr("checked",true);
		$("#useNotice0").uniform();
		$("#useNotice1").attr("checked",false);
		$("#useNotice1").uniform();
		//비밀글
		$("#useSecret0").attr("checked",true);
		$("#useSecret0").uniform();
		$("#useSecret1").attr("checked",false);
		$("#useSecret1").uniform();
	}	
	//언어설정
	Jnit_useLang(lang);
}

//접기
function Jnit_board_flod(num){
	var boardDepth = 0;
	if($(".Jnit_boardDepth"+num).css("display") == 'none'){
		$("#boardTable").find("td").each(function(){
			if($(this).attr("class") == 'Jnit_boardDepth'+num){
				boardDepth++;
				//console.log($(this).attr("class"));
			}
		});
		//console.log(boardDepth);
		//속성 설정
		$("#Jnit_boardDepth"+num).attr("rowspan", boardDepth);
		$("#Jnit_boardDepth"+num).css("text-align","left");
		$("#Jnit_boardDepth"+num).attr("colspan", 1);
		//버튼설정
		$("#Jnit_boardDepth"+num+"_btn").empty();
		$("#Jnit_boardDepth"+num+"_btn").append("접기");
		$(".Jnit_boardDepth"+num).css("display","");
	}else{
		$("#boardTable").find("td").each(function(){
			if($(this).attr("class") == 'Jnit_boardDepth'+num){
				boardDepth++;
			}
		});
		//속성 설정
		$("#Jnit_boardDepth"+num).attr("rowspan", Number($("#Jnit_boardDepth"+num).attr("rowspan"))-(boardDepth-1));
		$("#Jnit_boardDepth"+num).css("text-align","center");
		$("#Jnit_boardDepth"+num).attr("colspan", 4);
		//버튼설정
		$("#Jnit_boardDepth"+num+"_btn").empty();
		$("#Jnit_boardDepth"+num+"_btn").append("펼치기");
		$(".Jnit_boardDepth"+num).css("display","none");
	}
}

function Jnit_fieldSortWrite_bln(fieldSortWrite){
	if(fieldSortWrite.indexOf("file") > -1){
		alert("등록노출순서에 file은 선언 할 수 없습니다.");
		if(fieldSortWrite.indexOf(",file") > -1) fieldSortWrite = fieldSortWrite.replace(",file","");
		else fieldSortWrite = fieldSortWrite.replace("file","");
		$("#fieldSortWrite").val(fieldSortWrite);
		$("#fieldSortWrite").focus();
		return false;
	}
	return true;
}

//icon 설명글 설정
function Jnit_icon(id,value){
	$("#"+id+"_label").empty();
	if(value == '0'){
		$("#"+id+"_value").css("display","none");
	}else if(value == '1'){
		$("#"+id+"_label").append(": 건 이상 비노출");
		$("#"+id+"_value").css("display","");
	}else if(value == '2'){
		$("#"+id+"_label").append(": 분 후 비노출");
		$("#"+id+"_value").css("display","");
	}else if(value == '3'){
		$("#"+id+"_label").append("게시물 등록 수정시 노출 설정");
		$("#"+id+"_value").css("display","none");
	}
}

//파일 확장자 체크
function checkExt(name){
	if( $("#"+name).val() != "" ){
		var ext = $('#'+name).val().split('.').pop().toLowerCase();
		if($.inArray(ext, ['bmp','jpg','gif','png','jpeg','tif', 'img','svg']) == -1) {
			alert('bmp, jpg, gif, png, jpeg, tif, img, svg 파일만 업로드 할수 있습니다.');
			$("#"+name).focus();
			return;
		}
	}
	return true;
}
//icon ajax upload
function icon_uploadFileAjax(name){
	<c:if test="${!empty jnitboardinfoVO.boardId }">
	if(checkExt(name+"_iconFile")){
		var imgType = $("#"+name+"_imgType").val();
		var options = {
			iframe:true,
			type:"POST",
			dataType:"text/javascript",
			url: "<c:url value='/cms/board/info/ajax/iconUploadfile.do'/>?name="+name+"&imgType="+imgType,
			success: successFile
		};
		$("#"+name+"_img").attr("src","${pageContext.request.contextPath}/resources/img/roding.gif");
		$("#jnitboardinfoVO").ajaxSubmit(options);
	}else{
		$("#"+name+"_iconFile").val("");
	}
	</c:if>
}

//icon ajax upload 확인
function successFile(text, statusText, $form){
	var json = $.parseJSON(text);
	if(json.status == 'success'){
		$("#"+json.name+"_img").attr("src","${pageContext.request.contextPath}/board/_info/_iconImg/${jnitboardinfoVO.boardId}/"+json.name+"."+json.imgType+"?chching="+Math.floor((Math.random() * 10000) + 1));
		$("#uniform-"+json.name+"_iconFile span.filename").empty();
		$("#uniform-"+json.name+"_iconFile span.filename").append("선택된 파일 없음");
	}else{
		alert("파일을 다시 선택하시기 바랍니다.");
	}
	$("#"+json.name+"_iconFile").val("");
}

//icon lable 이름 셋팅
function Jnit_icon_label(name){
	$("#"+name+"_nm").val($("#"+name+"_label_nm").text());
}

//icon 체크 확인
function Jnit_icon_isCheck(name){
	if($("input:radio[name='"+name+"']:checked").size() == 0){
		$("#"+name+"_0").attr("checked",true);
		$("#hit_0").uniform();
	}
}

//등록노출순서 keyup
$(document).on("keyup","#fieldSortWrite",function(){
	var fieldSortWrite = $(this).val();
	if(fieldSortWrite != ''){
		Jnit_fieldSortWrite_bln($(this).val());
	}
});

$(document).on('click','.extMbr',function(e){
	//parent.setList('<c:url value="/cms/mbr/search.do"/>');
		$("div#mbrSearch").html('');
		$('#menuModal').modal('toggle');
		$.ajax({
			  type: "GET",
			  url: "<c:url value='/cms/mbr/search.do'/>",
			  success:function(data) {
				$("div#mbrSearch").html(data);
			  },
			  error:function(result) {
				//alert(result);
			  }
		});
	
});
$(document).on('click','.extType',function(e){
	var domId = $(this).attr('id');
	//parent.setList('<c:url value="/cms/mbrtype/search.do"/>'+'?domId='+domId);
	
	$("div#mbrSearch").html('');
	$('#menuModal').modal('toggle');
	$.ajax({
		  type: "GET",
		  url: "<c:url value='/cms/mbrtype/search.do'/>",
		  data: "domId="+domId,
		  success:function(data) {
			$("div#mbrSearch").html(data);
		  },
		  error:function(result) {
			//alert(result);
		  }
	});
});

<%-- 후속보안조치 --%>
$(document).on("change",'#boardSkin',function(e){
	$.getJSON("<c:url value='/cms/board/_getSkinType.do'/>",{skin:$("#boardSkin option:selected").val()},function(data){
		if(data.length < 1){
			alert("선택하신 스킨에는 게시판유형이 없습니다.");
			$("#boardSkin option[value='default']").attr("selected","selected");
			$('#boardSkin').trigger('change'); 			
		}
		$('#boardType').empty();
		$.each(data,function(k,v){
			if('<c:out value="${jnitboardinfoVO.boardSkin}" />' == $("#boardSkin option:selected").val() && '<c:out value="${jnitboardinfoVO.boardType}" />' == v){
				$('#boardType').append('<option value="'+ v +'" selected="selected">'+ v +'</option>');
			}else{
				$('#boardType').append('<option value="'+ v +'" >'+ v +'</option>');
			}
		});
	});
});

$('#myModal').on('hide', function () {
	$("div#mbrSearch").hide();
});

$(document).ready(function(){
	
	var boardType = "${jnitboardinfoVO.boardType}";
	var lang = "${jnitboardinfoVO.useLanguage}";
	//SMS 발송 도움말
	if($("#useCategory1").is(":checked")){
		$(".categoryBox").show();
	}else {
		$(".categoryBox").hide();
	}
	
	//답글 사용 여부에 따른 정렬기준 정리
	if($("#useReply0").is(":checked")){
		$("#Sortselect").show();
	}else {
		$("#Sortselect").hide();
	}
	
	//SMS 발송 도움말
	if($("#useSms1").is(":checked")){
		$(".smsBox").show();
	}else {
		$(".smsBox").hide();
	}
	<c:if test="${screenMode == '등록'}">
		if(boardType != '' && lang != ''){
			Jnit_settingField(lang,boardType,"reset");
		}
	</c:if>
	$("#useLanguage").change(function(){
		if(confirm("설정된 값이 초기화됩니다. 계속 진행하시겠습니까?")){
			var lang = $("#useLanguage option:selected").val();
			Jnit_useLang(lang);
		}
	});
	
	$("#boardType").change(function(){
		if(confirm("설정된 값이 초기화됩니다. 계속 진행하시겠습니까?")){			
			boardType = $("#boardType option:selected").val();
			if(boardType != ''){
				Jnit_settingField(lang,boardType,"reset");
			}
		}
	});
	$("#boardSort").change(function(){
		var sort = $(this).val();
		if(sort == "1"){
			if(!confirm("답글에 관련된 정보는 노출되지 않습니다. 계속 진행하시겠습니까?")){
				$("#boardSort").val("1");
				$("#boardSort").select2();
			}
		}else if(sort == "2"){
			if(!confirm("답글에 관련된 정보는 노출되지 않습니다. 계속 진행하시겠습니까?")){
				$("#boardSort").val("2");
				$("#boardSort").select2();
			}
		}
		
	});
	
	$("input[name=useFile]").change(function() {
		var radioValue = $(this).val();
		if (radioValue == "2") {
			$("#useFormFile").show();
		}else{
			$("#useFormFile").hide();
		}
	});
	
	$("input[name=useReply]").change(function() {
		var replyvalue = $(this).val();
		if (replyvalue== "0") {
			$("#Sortselect").show();
			$("#Sorttext").hide();
		}else{
			$("#boardSort").val("0");
			$("#boardSort").select2();
			$("#Sortselect").hide();
			$("#Sorttext").show();
		}
	});
	
	//icon 설정
	var iconlist = $("#iconlist").val().split(",");
	for(var i=0; i<iconlist.length; i++){
		Jnit_icon_isCheck(iconlist[i]);
		Jnit_icon(iconlist[i],$("input:radio[name='"+iconlist[i]+"']:checked").val());
		Jnit_icon_label(iconlist[i]);
	}
});

// -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
       	<div class="row-fluid">
           	<div class="span12">
               	<div class="widget-box">
                   	<div class="widget-title">                   	
                   		<h3>게시판 <c:out value="${modeStr}" /></h3>
						<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
						<c:if test="${screenMode == '수정' }">
					    	<a href="javascript:fn_egov_delete();" class="btn btn-small btn-del"><i class="icon-minus-sign"></i> 삭제</a>
					    </c:if>
                    </div>
					<div class="widget-content nopadding">
						<form:form commandName="jnitboardinfoVO" enctype="multipart/form-data">
							<input type="hidden" name="mode" id="mode" value="<c:out value="${mode}" />" />
							<input type="hidden" name="boardGroup" value="${searchVO.searchBoardGroup }"/>
							<table id="boardTable" class="table table-bordered table-striped th_left" summary="게시판 <c:out value="${modeStr}" />">
						        <tbody>
						            <tr>
						                <th id="Jnit_boardDepth1" width="10%"><font color="red">*</font> 게시판 제목</th>
						                <td colspan="3"><form:input style="width:98%;" path="boardTitle" cssClass="txt"/><form:errors path="boardTitle" /></td>
						            </tr>
						            <tr>
						            	<th id="Jnit_boardDepth2" rowspan="10">환경설정 <a href="javascript:Jnit_board_flod('2');" id="Jnit_boardDepth2_btn" class="btn btn-small">접기</a></th>
						            	<th class="Jnit_boardDepth2" style="width: 15%"><font color="red">*</font> 언어 선택 <a href="javascript:Jnit_question('1');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth2" colspan="2">
							                <select name="useLanguage" id="useLanguage">
								                <option value="korea" <c:out value="${jnitboardinfoVO.useLanguage == 'korea' ? 'selected' : ''}"/>>한국어</option>
								                <option value="eng" <c:out value="${jnitboardinfoVO.useLanguage == 'eng' ? 'selected' : ''}"/>>영어</option>
								                <option value="chi" <c:out value="${jnitboardinfoVO.useLanguage == 'chi' ? 'selected' : ''}"/>>중국어</option>
								                <option value="japan" <c:out value="${jnitboardinfoVO.useLanguage == 'japan' ? 'selected' : ''}"/>>일본어</option>
							                </select>
							                <div id="question1" style="display: none;">
							                	<b>- 각 해당 언어를 선택하면 기본메세지 및 기본설정이 자동으로 세팅됩니다.</b>
							                </div>
						                </td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth2"><font color="red">*</font> 유형 선택 <a href="javascript:Jnit_question('3');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth2" colspan="2">
							                <select name="boardSkin" id="boardSkin">
							                <c:forEach var="item" items="${skinList}">
							                	<option value="<c:out value="${item}" />" <c:out value='${(jnitboardinfoVO.boardSkin == item || (mode == "add" && item == "basic")) ? "selected" : "" }'/>><c:out value="${item}" /></option>
							                </c:forEach>
							                </select>
						                </td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth2"><font color="red">*</font> 스킨 선택 <a href="javascript:Jnit_question('2');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth2" colspan="2">						                	
							                <select name="boardType" id="boardType">
								                <c:forEach var="item" items="${skinTypeList}">
								                	<option value="<c:out value="${item}" />" <c:out value='${(jnitboardinfoVO.boardType == item || (empty jnitboardinfoVO.boardType && item == "normal" )) ? "selected" : "" }'/>><c:out value="${item}" /></option>
								                </c:forEach>
							                </select>	               
							                <div id="question2" style="display: none;">
							                	<b>
								                	- faq : 묻고답하기 형식에 게시판입니다. <a href="<c:url value="/resources/img/board/example/faq.png" />" target="_blank" >(게시판미리보기)</a><br />
								                	- gallery : 갤러리 형식에 게시판입니다. <a href="<c:url value="/resources/img/board/example/gallery.png" />" target="_blank" >(게시판미리보기)</a><br />
								                	- normal : 기본게시판으로 자료형 및 보편적인 게시판입니다. <a href="<c:url value="/resources/img/board/example/normal.png" />" target="_blank" >(게시판미리보기)</a><br />
								                	- scheduleList : 일정형 게시판에 확장형 게시판입니다. <a href="<c:url value="/resources/img/board/example/scheduleList.png" />" target="_blank" >(게시판미리보기)</a><br />
								                	- schedule : 일정형 게시판입니다. <a href="<c:url value="/resources/img/board/example/schedule.png" />" target="_blank">(게시판미리보기)</a><br />
								                	- calendar : 달력형 게시판입니다. <a href="<c:url value="/resources/img/board/example/calendar.png" />" target="_blank" >(게시판미리보기)</a><br />
								                	- movie : 동영상형 게시판입니다. <a href="<c:url value="/resources/img/board/example/movie.png" />" target="_blank" >(게시판미리보기)</a><br />
								                	- thumbnail : 썸네일형 게시판입니다. <a href="<c:url value="/resources/img/board/example/thubnail.png" />" target="_blank" >(게시판미리보기)</a><br />
								                	- inquiry : 1:1 답변형 게시판입니다. <a href="<c:url value="/resources/img/board/example/inquiry.png" />" target="_blank" >(게시판미리보기)</a><br />
							                	</b>
							                </div>							                
						                </td>
						            </tr>
						            
						            <tr> 
                           			    <th class="Jnit_boardDepth2">삽입 URL <a href="javascript:Jnit_question('4');"><i class="icon-question-sign"></i></a></th> 
                                        <td class="Jnit_boardDepth2" colspan="2">
                                        	<form:input style="width:98%;" path="boardUrl" cssClass="txt"/><form:errors path="boardUrl" />
                                        	<div id="question4" style="display: none;">
                                        		<b>
	                                        		- 해당 게시판에 삽입된 페이지 URL를 기재합니다.<br />
	                                        		- DB형 검색엔진이용시 꼭 필요한 사항입니다.<br />
	                                        		- 삽입형식은 http://(도메인)/세부주소~ 식으로 입력하시면 됩니다.<br />
                                        		</b>
                                        	</div>
                                        </td> 
                                     </tr>
                                     <tr>
                           			    <th rowspan="6" class="Jnit_boardDepth2">아이콘 노출 설정
                           			    	<%-- new icon 설정 필수 요소 --%>       			    	
                           			    	<input type="hidden" id="iconlist" name="iconlist" value="hit,time,absolute" />
                           			    	<%-- new icon 설정 필수 요소 --%>
                           			    </th>
                           			    <th class="Jnit_boardDepth2" rowspan="2"><label id="hit_label_nm">아이콘 설정 1</label><a href="javascript:Jnit_question('61');"><i class="icon-question-sign"></i></a></th>
                                        <td class="Jnit_boardDepth2">
                                        	<input type="radio" id="hit_0" name="hit" value="0" <c:out value="${getTmp1['hit'].type == '0' ? 'checked' : '' }"/> onclick="Jnit_icon('hit',this.value);" /><label>사용안함</label>
                                        	<input type="radio" id="hit_1" name="hit" value="1" <c:out value="${getTmp1['hit'].type == '1' ? 'checked' : '' }"/> onclick="Jnit_icon('hit',this.value);" /><label>조회수</label>
                                        	<input type="radio" id="hit_2" name="hit" value="2" <c:out value="${getTmp1['hit'].type == '2' ? 'checked' : '' }"/> onclick="Jnit_icon('hit',this.value);" /><label>시간(분)</label>
                                        	<input type="radio" id="hit_3" name="hit" value="3" <c:out value="${getTmp1['hit'].type == '3' ? 'checked' : '' }"/> onclick="Jnit_icon('hit',this.value);" /><label>게시물 강제노출</label>
                                        	&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="hit_value" name="hit_value" value="<c:out value="${getTmp1['hit'].value }" />" />
                                        	<label id="hit_label" ></label>
                                        </td>
                                     </tr>
                                     <tr>
                                     	<td class="Jnit_boardDepth2" colspan="2">
                                     		<%-- new icon 설정 필수 요소 --%>
                                     			<input type="hidden" id="hit_nm" name="hit_nm"/>
	                                     		<input type="hidden" id="hit_imgType" name="hit_imgType" value="gif" />
                                     		<%-- new icon 설정 필수 요소 --%>
                                        	<label>아이콘 파일 등록 : </label><input type="file" id="hit_iconFile" name="hit_iconFile" onchange="icon_uploadFileAjax('hit');" />
                                        	<span>                                       	
                                        	<c:if test="${getTmp1['hit'].exists == 'Y'}">
                                        		<img src="<c:url value='/board/_info/_iconImg/${jnitboardinfoVO.boardId}/hit.gif'/>" id="hit_img" style="width: 50px; height: 50px; vertical-align: middle;">
                                        	</c:if>
                                        	<c:if test="${getTmp1['hit'].exists == 'N'}">
                                        		<img src="<c:url value='/resources/img/new_icon.gif'/>" id="hit_img" style="width: 50px; height: 50px; vertical-align: middle;">
                                        	</c:if>
                                        	</span>
                                        	

                                        	<div id="question61" style="display: none;">
                                        		<b>
                                        			- 조회수 선택시 : 우측에 입력한 숫자만큼 조회수 카운트가 넘어갈 경우 해당 아이콘 비노출<br />
													- 시간(분) 선택시 : 우측에 입력한 숫자만큼 등록한 "년월일시분"에서 플러스한 분 후 아이콘 비노출<br />
													- 게시물 강제노출 선택시 : 해당 게시판에 게시물 신규등록 및 수정시 상단에 "아이콘강제노출" 체크박스 활성화를 통한 아이콘 노출설정<br />
													<strong>※ 조회수,시간(분) 선택시 노출되는 첨부파일은 사용자가 직접 등록한 아이콘 사용, 첨부하지 않을 시 디폴트 이미지 노출("N"모양 아이콘)</strong>
                                        		</b>
                                        	</div>
                                        </td>
                                     </tr>
                                     <tr>
                                     	<th class="Jnit_boardDepth2" rowspan="2"><label id="time_label_nm">아이콘 설정 2</label><a href="javascript:Jnit_question('62');"><i class="icon-question-sign"></i></a></th>
                                     	<td class="Jnit_boardDepth2">
                                        	<input type="radio" id="time_0" name="time" value="0" <c:out value="${getTmp1['time'].type == '0' ? 'checked' : '' }"/> onclick="Jnit_icon('time',this.value);" /><label>사용안함</label>
                                        	<input type="radio" id="time_1" name="time" value="1" <c:out value="${getTmp1['time'].type == '1' ? 'checked' : '' }"/> onclick="Jnit_icon('time',this.value);" /><label>조회수</label>
                                        	<input type="radio" id="time_2" name="time" value="2" <c:out value="${getTmp1['time'].type == '2' ? 'checked' : '' }"/> onclick="Jnit_icon('time',this.value);" /><label>시간(분)</label>
                                        	<input type="radio" id="time_3" name="time" value="3" <c:out value="${getTmp1['time'].type == '3' ? 'checked' : '' }"/> onclick="Jnit_icon('time',this.value);" /><label>게시물 강제노출</label>
                                        	&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="time_value" name="time_value" value="<c:out value="${getTmp1['time'].value }" />" />
                                        	<label id="time_label" ></label>
                                        </td>
                                     </tr>
                                     <tr>
                                     	<td class="Jnit_boardDepth2" colspan="2">
                                     		<%-- new icon 설정 필수 요소 --%>
                                     			<input type="hidden" id="time_nm" name="time_nm"/>
	                                     		<input type="hidden" id="time_imgType"  name="time_imgType" value="gif" />
                                     		<%-- new icon 설정 필수 요소 --%>
                                        	<label>아이콘 파일 등록 : </label><input type="file" id="time_iconFile" name="time_iconFile" onchange="icon_uploadFileAjax('time');" />
                                        	<span>                                    	
                                        	<c:if test="${getTmp1['time'].exists == 'Y'}">
                                        		<img src="<c:url value='/board/_info/_iconImg/${jnitboardinfoVO.boardId}/time.gif'/>" id="time_img" style="width: 50px; height: 50px; vertical-align: middle;">
                                        	</c:if>
                                        	<c:if test="${getTmp1['time'].exists == 'N'}">
                                        		<img src="<c:url value='/resources/img/new_icon.gif'/>" id="time_img" style="width: 50px; height: 50px; vertical-align: middle;">
                                        	</c:if>
                                        	</span>
                                        	
                                      	
                                        	<div id="question62" style="display: none;">
                                        		<b>
                                        			- 조회수 선택시 : 우측에 입력한 숫자만큼 조회수 카운트가 넘어갈 경우 해당 아이콘 비노출<br />
													- 시간(분) 선택시 : 우측에 입력한 숫자만큼 등록한 "년월일시분"에서 플러스한 분 후 아이콘 비노출<br />
													- 게시물 강제노출 선택시 : 해당 게시판에 게시물 신규등록 및 수정시 상단에 "아이콘강제노출" 체크박스 활성화를 통한 아이콘 노출설정<br />
													<strong>※ 조회수,시간(분) 선택시 노출되는 첨부파일은 사용자가 직접 등록한 아이콘 사용, 첨부하지 않을 시 디폴트 이미지 노출("N"모양 아이콘)</strong>
                                        		</b>
                                        	</div>
                                        </td>
                                     </tr>
                                     <tr>
                                     	<th class="Jnit_boardDepth2" rowspan="2"><label id="absolute_label_nm">아이콘 설정 3</label><a href="javascript:Jnit_question('63');"><i class="icon-question-sign"></i></a></th>
                                     	<td class="Jnit_boardDepth2">
                                        	<input type="radio" id="absolute_0" name="absolute" value="0" <c:out value="${getTmp1['absolute'].type == '0' ? 'checked' : '' }"/> onclick="Jnit_icon('absolute',this.value);" /><label>사용안함</label>
                                        	<input type="radio" id="absolute_1" name="absolute" value="1" <c:out value="${getTmp1['absolute'].type == '1' ? 'checked' : '' }"/> onclick="Jnit_icon('absolute',this.value);" /><label>조회수</label>
                                        	<input type="radio" id="absolute_2" name="absolute" value="2" <c:out value="${getTmp1['absolute'].type == '2' ? 'checked' : '' }"/> onclick="Jnit_icon('absolute',this.value);" /><label>시간(분)</label>
                                        	<input type="radio" id="absolute_3" name="absolute" value="3" <c:out value="${getTmp1['absolute'].type == '3' ? 'checked' : '' }"/> onclick="Jnit_icon('absolute',this.value);" /><label>게시물 강제노출</label>
                                        	&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="absolute_value" name="absolute_value" value="<c:out value="${getTmp1['absolute'].value }" />" />
                                        	<label id="absolute_label" ></label>
                                        </td>
                                     </tr>
                                     <tr>
                                     	<td class="Jnit_boardDepth2" colspan="2">
                                     		<%-- new icon 설정 필수 요소 --%>
                                     			<input type="hidden" id="absolute_nm" name="absolute_nm"/>
	                                     		<input type="hidden" id="absolute_imgType"  name="absolute_imgType" value="gif" />
                                     		<%-- new icon 설정 필수 요소 --%>
                                        	<label>아이콘 파일 등록 : </label><input type="file" id="absolute_iconFile" name="absolute_iconFile" onchange="icon_uploadFileAjax('absolute');" />
                                        	<span>
                                        	<c:if test="${getTmp1['absolute'].exists == 'Y'}">
                                        		<img src="<c:url value='/board/_info/_iconImg/${jnitboardinfoVO.boardId}/absolute.gif'/>" id="absolute_img" style="width: 50px; height: 50px; vertical-align: middle;">
                                        	</c:if>
                                        	<c:if test="${getTmp1['absolute'].exists == 'N'}">
                                        		<img src="<c:url value='/resources/img/new_icon.gif'/>" id="absolute_img" style="width: 50px; height: 50px; vertical-align: middle;">
                                        	</c:if>
                                        	</span>

                                        	<div id="question63" style="display: none;">
                                        		<b>
                                        			- 조회수 선택시 : 우측에 입력한 숫자만큼 조회수 카운트가 넘어갈 경우 해당 아이콘 비노출<br />
													- 시간(분) 선택시 : 우측에 입력한 숫자만큼 등록한 "년월일시분"에서 플러스한 분 후 아이콘 비노출<br />
													- 게시물 강제노출 선택시 : 해당 게시판에 게시물 신규등록 및 수정시 상단에 "아이콘강제노출" 체크박스 활성화를 통한 아이콘 노출설정<br />
													<strong>※ 조회수,시간(분) 선택시 노출되는 첨부파일은 사용자가 직접 등록한 아이콘 사용, 첨부하지 않을 시 디폴트 이미지 노출("N"모양 아이콘)</strong>
                                        		</b>
                                        	</div>
                                        </td>
                                     </tr>
                                     <!-- 환경설정 -->
                                      
                                    <tr>
                                    	<th id="Jnit_boardDepth3" rowspan="14">기본설정 <a href="javascript:Jnit_board_flod('3');" id="Jnit_boardDepth3_btn" class="btn btn-small">접기</a></th>
                                    	<th class="Jnit_boardDepth3">내&middot;외부망 분리<a href="javascript:Jnit_question('68');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<input type="radio" id="useInternal0" name="useInternal" value="0" <c:out value='${jnitboardinfoVO.useInternal == "0" ? "checked" : "" }'/>><label>사용안함</label>
						                	<input type="radio" id="useInternal1" name="useInternal" value="1" <c:out value='${jnitboardinfoVO.useInternal == "1" ? "checked" : "" }'/>><label>사용함</label>
						                	<div id="question68" style="display: none;">
						                		<b>
						                			- 사용시 글쓰기(등록,수정,삭제)를 관리자만 할 수 있습니다. <br />
						                			- 글쓰기(등록,수정,삭제)는 cms의 게시물관리에서만 할 수 있습니다. <br />
						                			
						                		</b>
						                	</div>
						                </td>
                                    </tr>
                                    <tr>
                                    	<th class="Jnit_boardDepth3">게시물수 <a href="javascript:Jnit_question('5');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<form:input style="width:98%;" value="${mode == 'add' ? '15' : ''}" path="rowCnt" cssClass="txt"/><form:errors path="rowCnt" />
						                	<div id="question5" style="display: none;">
						                		<b>- 리스트페이지에 노출된 게시물 수를 지정합니다.</b>
						                	</div>
						                </td>
						            </tr>
                                    <tr>
						                <th class="Jnit_boardDepth3">답글<a href="javascript:Jnit_question('67');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<input type="radio" id="useReply0" name="useReply" value="0" <c:out value='${jnitboardinfoVO.useReply == "0" ? "checked" : "" }'/>><label>사용안함</label>
						                	<input type="radio" id="useReply1" name="useReply" value="1" <c:out value='${jnitboardinfoVO.useReply == "1" ? "checked" : "" }'/>><label>사용함</label>
						                	<div id="question67" style="display: none;">
						                		<b>
						                			- 답글 기능을 설정합니다. <br />
						                			- 답글을 사용하지 않아야 정렬 옵션을 선택하실 수 있습니다.<br />
						                		</b>
						                	</div>
						                </td>
						            </tr>
                                    <tr>
                                    	<%--
	                                    	boardSort = orderbyCondition 기준
	                                    	0 : 기본형 a.GRP DESC, a.IDX ASC
	                                    	1 : 최근게시물 형 a.TMP3 DESC, a.CREATED DESC
	                                    	2 : 게시물 날자형 내림차순 a.CREATED ASC , idxCondition = 0, 답글 가림
	                                    	
	                                    	2015-10-21 by.나성재 수정
	                                    	- 2 : 날짜형 내림차순은 최근게시물과는 별개 동작 진행
	                                     --%>
						                <th class="Jnit_boardDepth3">게시물 정렬기준 <a href="javascript:Jnit_question('66');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						               		<span id="Sortselect" <c:out value="${jnitboardinfoVO.useReply == 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
							                	<select id="boardSort" name="boardSort">
							                		<option value="0" <c:out value="${jnitboardinfoVO.boardSort == '0' ? 'selected' : '' }"/>>기본형</option>
							                		<option value="1" <c:out value="${jnitboardinfoVO.boardSort == '1' ? 'selected' : '' }"/>>최근게시물형</option>
							                		<option value="2" <c:out value="${jnitboardinfoVO.boardSort == '2' ? 'selected' : '' }"/>>날짜형(내림차순)</option>
							                	</select>
						                	</span>
						                	<span id="Sorttext" <c:out value="${jnitboardinfoVO.useReply == 1 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>기본형</span>
						                	<div id="question66" style="display: none;">
						                		<b>
						                			- 리스트페이지에 노출된 게시물의 정렬기준을 지정합니다. <br />
						                			- 답글을 사용하지 않아야 다른 옵션을 선택 할 수 있습니다. <br />
						                		</b>
						                	</div>
						                </td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth3">카테고리 <a href="javascript:Jnit_question('6');" class="categoryBox" style="display: none;"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<input type="radio" id="useCategory0" name="useCategory" value="0" <c:out value="${jnitboardinfoVO.useCategory == 0 ? 'checked' : ''}"/> onchange="if(this.value == '1') { $('.categoryBox').show(); }else { $('.categoryBox').hide(); }" /><label>사용안함</label>
						                	<input type="radio" id="useCategory1" name="useCategory" value="1" <c:out value="${jnitboardinfoVO.useCategory == 1 ? 'checked' : ''}"/> onchange="if(this.value == '1') { $('.categoryBox').show(); }else { $('.categoryBox').hide(); }" /><label>사용함</label>
							                <div style="display:<c:out value="${jnitboardinfoVO.useCategory == 1 ? 'block' : 'none'}"/>;" class="categoryBox">
								                <form:input style="width:300px;"   path="category" cssClass="txt" />
								                <div id="question6" style="display: none;">
								                	<b>
									                	- ','를 구분으로 입력하며 가장 첫번째로 입력하는 항목이 카테고리 고유명칭입니다.<br />
									                	- ex)파트너사명,삼성,엘지,엘티에스코리아 <br />
								                	</b>
								                </div>
							                </div>
						                </td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth3">글쓰기버튼 숨김 <a href="javascript:Jnit_question('7');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<input type="radio" name="hideWrite" value="0" <c:out value='${jnitboardinfoVO.hideWrite == "0" ? "checked" : "" }'/>><label>기본 비노출</label>						                
						                	<input type="radio" name="hideWrite" value="1" <c:out value='${jnitboardinfoVO.hideWrite == "1" ? "checked" : "" }'/>><label>기본 노출</label>
							                <div id="question7" style="display: none;">
							                	<b>
								                	- 기본비노출 : 글쓰기 권한이 없을경우 버턴자체가 노출되지 않습니다.(공지사항게시판에 주로이용)<br />
								                	- 기본노출 : 글쓰기 권한과 상관없이 기본적으로 글쓰기 버턴을 노출하고 글쓰기 클릭시 권한체크를 통해 컨트롤.<br />
							                	</b>
							                </div>
						                </td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth3">공지글 <a href="javascript:Jnit_question('8');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<input type="radio" id="useNotice0" name="useNotice" value="0" <c:out value='${jnitboardinfoVO.useNotice == "0" ? "checked" : "" }'/>><label>사용안함</label>
						                	<input type="radio" id="useNotice1" name="useNotice" value="1" <c:out value='${jnitboardinfoVO.useNotice == "1" ? "checked" : "" }'/>><label>사용함</label>
							                <div id="question8" style="display: none;">
							                	<b>
								                	- normal,gallery,movie,thumbnaill만 지원 가능합니다.<br />
								                	- 다른형식에 게시판에서는 정상지원이 되지 않으며, 필요시 개발자에게 직접 문의하여 해당기능 추가<br />
							                	</b>
							                </div>
						                </td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth3">비밀글 <a href="javascript:Jnit_question('9');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<input type="radio" id="useSecret0" name="useSecret" value="0" <c:out value='${jnitboardinfoVO.useSecret == "0" ? "checked" : "" }'/>><label>사용안함</label>
						                	<input type="radio" id="useSecret1" name="useSecret" value="1" <c:out value='${jnitboardinfoVO.useSecret == "1" ? "checked" : "" }'/>><label>사용함</label>						                	
							                <div id="question9" style="display: none;">
							                	<b>
								                	- normal,gallery,thumbnaill만 지원 가능합니다.<br />
								                	- 다른형식에 게시판에서는 정상지원이 되지 않으며, 필요시 개발자에게 직접 문의하여 해당기능 추가 요망.<br />
							                	</b>
							                </div>
						                </td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth3">댓글 <a href="javascript:Jnit_question('10');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<input type="radio" name="useCmt" value="0" <c:out value='${jnitboardinfoVO.useCmt == "0" ? "checked" : "" }'/>><label>사용안함</label>
						                	<input type="radio" name="useCmt" value="1" <c:out value='${jnitboardinfoVO.useCmt == "1" ? "checked" : "" }'/>><label>사용함</label>						                	
						                	<div id="question10" style="display: none;">
						                		<b>- 댓글이라,상세정보노출페이지에 하단에 회원들이 자유롭게 글을 쓰는 기능입니다.</b>
						                	</div>
						                </td>
						            </tr>
						            <%-- <tr>
						                <th class="Jnit_boardDepth3">소셜댓글 <a href="javascript:Jnit_question('11');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<input type="radio" name="useSocial" value="0" <c:out value='${jnitboardinfoVO.useSocial == "0" ? "checked" : "" }'/>><label>사용안함</label>
						                	<input type="radio" name="useSocial" value="1" <c:out value='${jnitboardinfoVO.useSocial == "1" ? "checked" : "" }'/>><label>사용함</label>
							                <span id="question11" style="display: none;"><br />
							                	<b>- SNS기능을 활용한 댓글 기능입니다.</b>
							                </span>
						                </td>
						            </tr> --%>
						            <tr>
						                <th class="Jnit_boardDepth3">SMS 발송 <a href="javascript:Jnit_question('13');" class="smsBox" style="display: none;"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<input type="radio" id="useSms0" name="useSms" value="0" <c:out value='${jnitboardinfoVO.useSms == "0" ? "checked" : "" }'/> onchange="if(this.value == '1') { $('.smsBox').show(); }else { $('.smsBox').hide(); }"><label>사용안함</label>
						                	<input type="radio" id="useSms1" name="useSms" value="1" <c:out value='${jnitboardinfoVO.useSms == "1" ? "checked" : "" }'/> onchange="if(this.value == '1') { $('.smsBox').show(); }else { $('.smsBox').hide(); }"><label>사용함</label>
							                <div style="display:<c:out value="${jnitboardinfoVO.useSms == 1 ? 'block' : 'none'}"/>;" class="smsBox">
							                <form:input style="width:300px;"   path="smsNum" cssClass="txt" />
							                	<div id="question13" style="display: none;">
							                		<b>( 게시글이 작성되면 이 곳에 등록된 휴대전화번호로 SMS가 발송됩니다.)</b>
							                	</div>
							                </div>						                
						                </td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth3">위지윅에디터 <a href="javascript:Jnit_question('14');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<input type="radio" id="useWyswyg0" name="useWyswyg" value="0" <c:out value='${jnitboardinfoVO.useWyswyg == "0" ? "checked" : "" }'/> onchange="if(this.value == '1') { $('.wyswygOption').show(); }else { $('.wyswygOption').hide(); }"><label>사용안함</label>
						                	<input type="radio" id="useWyswyg1" name="useWyswyg" value="1" <c:out value='${jnitboardinfoVO.useWyswyg == "1" ? "checked" : "" }'/> onchange="if(this.value == '1') { $('.wyswygOption').show(); }else { $('.wyswygOption').hide(); }"><label>사용함</label>
							                <div class="wyswygOption" <c:out value="${jnitboardinfoVO.useWyswyg == 1 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
							                	<input type="radio" id="useWyswygType0" name="useWyswygType" value="tinymce" <c:out value="${jnitboardinfoVO.useWyswygType == 'tinymce' ? 'checked' : '' }"/>/><label>tinymce 사용함</label>
							                	<input type="radio" id="useWyswygType1" name="useWyswygType" value="smartEditor" <c:out value="${jnitboardinfoVO.useWyswygType == 'smartEditor' ? 'checked' : '' }"/>/><label>smartEditor 사용함</label><br />
							                	<input type="radio" id="useImage0" name="useImage" value="0" <c:out value='${jnitboardinfoVO.useImage == "0" ? "checked" : "" }'/>><label>이미지첨부기능 사용안함</label>
						                		<input type="radio" id="useImage1" name="useImage" value="1" <c:out value='${jnitboardinfoVO.useImage == "1" ? "checked" : "" }'/>><label>이미지첨부기능 사용함</label>
							                </div>
							                <div id="question14" style="display: none;">
							                	<b>- 글쓰기를 할경우 에디터기능의 사용여부를 제어하는 기능입니다</b>							                
							                </div>
						                </td>
						            </tr>						               
						            <tr>
						                <th class="Jnit_boardDepth3">파일첨부 <a href="javascript:Jnit_question('15');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<input type="radio" id="useFile0" name="useFile" value="0" <c:out value='${jnitboardinfoVO.useFile == "0" ? "checked" : "" }'/>><label>사용안함</label>
						                	<input type="radio" id="useFile1" name="useFile" value="1" <c:out value='${jnitboardinfoVO.useFile == "1" ? "checked" : "" }'/>><label>사용함</label>
							                <input type="radio" id="useFile2" name="useFile" value="2" <c:out value='${jnitboardinfoVO.useFile == "2" ? "checked" : "" }'/>><label>파일 폼 사용함</label>
							                <div id="question15" style="display: none;">
							                	 <b>- 게시판 글쓰기시 파일첨부기능의 사용여부를 제어하는 기능입니다.</b>
							                </div>
							                <div id="useFormFile" class="useFormFile" <c:out value="${jnitboardinfoVO.useFile == 2 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
												블랙리스트 : <input type="text" id="fileBlacklist" name="fileBlacklist" class="txt" style="width:50%;" value="${mode == 'add' ? 'php,php3,htm,html,phtm,phtml,dhtm,dhtml,inc,cgi,pl,js,jsp,asp,com,bat,c,css,h,cmd,nt,exe' : jnitboardinfoVO.fileBlacklist}" />
												<br />용량제한 : <input type="text" id="fileLimitSize" name="fileLimitSize" value="${mode == 'add' ? '1000' : jnitboardinfoVO.fileLimitSize}" /> MB
												<br />파일 최대 개수 : <input type="text" id="fileLimitCount" name="fileLimitCount" value="${mode == 'add' ? '10' : jnitboardinfoVO.fileLimitCount}" />
											</div>
						                </td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth3">최근게시물 노출 설정<a href="javascript:Jnit_question('59');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<input type="radio" id="useLatestlist0" name="useLatestlist" value="0" <c:out value='${jnitboardinfoVO.useLatestlist == "0" ? "checked" : "" }'/>><label>사용안함</label>
						                	<input type="radio" id="useLatestlist1" name="useLatestlist" value="1" <c:out value='${jnitboardinfoVO.useLatestlist == "1" ? "checked" : "" }'/>><label>사용함</label>							                							                
							                <div id="question59" style="display: none;">
							                	 <b>
							                		- 미니게시판에 노출될 게시물은 기본적으로 등록순입니다.<br />
													- 해당 설정을 "사용함"으로 변경하실 경우 게시물작성 시 "메인게시판 강제노출" 기능이 활성화 됩니다.<br />
													- 해당기능은 권한설정&gt;접근권한설정&gt;관리자레벨에 등록된 레벨만 노출됩니다.
												 </b>
							                </div>
						                </td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth3">썸네일 설정<a href="javascript:Jnit_question('60');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth3" colspan="2">
						                	<label>목록 썸네일 가로 :</label> <input type="text" id="thumbWdith" name="thumbWidth" value="${jnitboardinfoVO.thumbWidth }"/>&nbsp;&nbsp;
						                	<label>목록 썸네일 세로 :</label> <input type="text" id="thumbHeight" name="thumbHeight" value="${jnitboardinfoVO.thumbHeight }"/>&nbsp;&nbsp;
						                	<label>보기 썸네일 가로 :</label> <input type="text" id="thumbMaxdim" name="thumbMaxdim" value="${jnitboardinfoVO.thumbMaxdim }"/>
							                <div id="question60" style="display: none;">
							                	 <b>
							                		- 리스트에서 보여질 썸네일 크기를 지정합니다.(기본 : 300*200 pixel)<br />
													- 보기에서 사용될 썸네일은 가로를 기준으로 세로는 자동조절 됩니다. (기본 : 150 pixel)<br />
												 </b>
							                </div>
						                </td>
						            </tr>
						           
						            <tr>
						            	<th id="Jnit_boardDepth4" rowspan="26">디자인/추가설정 <a href="javascript:Jnit_board_flod('4');" id="Jnit_boardDepth4_btn" class="btn btn-small">접기</a></th>
						            	 <%--
						            	<th class="Jnit_boardDepth4">반응형 <a href="javascript:Jnit_question('57');"><i class="icon-question-sign"></i></a></th>
						            	<td class="Jnit_boardDepth4" colspan="2">
						            		<input type="radio" id="useReact" name="useReact" value="0" <c:out value="${jnitboardinfoVO.useReact == '0' ? 'checked' : '' }"/> /><label>사용안함</label>
						            		<input type="radio" id="useReact" name="useReact" value="1" <c:out value="${jnitboardinfoVO.useReact == '1' ? 'checked' : '' }"/> /><label>사용함</label>
						            		<span id="question57" style="display: none;"><br />
						            			<b>- 해당 게시판이 반응형으로 사용할지, 일반게시판 고정형으로 사용할지를 결정하는 기능입니다.</b>
						            		</span>
						            	</td>
						            	--%>
						            	 <th class="Jnit_boardDepth4">기본 라벨 <a href="javascript:Jnit_question('16');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
						                	<form:input style="width:98%;" value="${mode == 'add' ? '번호|제목|작성자|작성일|조회수|내용' : ''}" path="boardLbl" cssClass="txt"/><form:errors path="boardLbl" />
											<div id="question16" style="display: none;">
												<b>
									                - '번호|제목|작성자|작성일|조회수|내용' 순으로 입력 6개 항복이 누락되어서는 안됩니다.<br />
									                - 해당 기본라벨은 리스트, 상세 VIEW, 글쓰기시 노출되는 명칭을 결정합니다.<br />
									                - 예를들어 위 라벨에 '작성자'를 '글쓴이'로 바꾸면 모든 리스트페이지 상단에 작성자가 글쓴이로 노출되고 상세VIEW와 글쓰기시에도 고유명칭이 '글쓴이' 로 변경됩니다.<br />
								                </b>
								            </div>
							            </td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth4">목록 노출 순서 <a href="javascript:Jnit_question('17');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <form:input style="width:98%;" value="${mode == 'add' ? 'no,title,writer,created,hit' : ''}" path="fieldSortList" cssClass="txt"/><form:errors path="fieldSortList" />
							                <div id="question17" style="display: none;">
							                	<b>
									                - 위에 입력한 순서대로 리스트 페이지 노출됩니다.<br />
									                - 항목정의(아래에 있는 항목만 노출가능합니다.)<br />
								                </b>
								                <table class="table table-bordered">
									                <tr>
									                	<th>항목코드</th>
									                	<th>항목고유명칭</th>
									                	<th>간략설명</th>
									                </tr>
									                <tr>
									                	<td>no</td>
									                	<td>글번호</td>
									                	<td>게시물은 순차적 글번호입니다.</td>								                	
									                </tr>
									                <tr>
									                	<td>category</td>
									                	<td>카테고리</td>
									                	<td>상단 기본설정에 카테고리를 사용할 경우 해당 코드를 넣어주셔야 정상적으로 노출됩니다.</td>								                	
									                </tr>
									                <tr>
									                	<td>title</td>
									                	<td>제목</td>
									                	<td>제목이 노출됩니다.</td>								                	
									                </tr>
									                <tr>
									                	<td>writer</td>
									                	<td>작성자</td>
									                	<td>글작성자에 정보가 노출됩니다.</td>								                	
									                </tr>
									                <tr>
									                	<td>hit</td>
									                	<td>조회수</td>
									                	<td>게시물 카운터 수치가 노출됩니다.</td>								                	
									                </tr>
									                <tr>
									                	<td>file</td>
									                	<td>파일첨부</td>
									                	<td>첨부파일이 있을 경우 파일아이콘이 노출됩니다.</td>								                	
									                </tr>
									                <tr>
									                	<td>ext01</td>
									                	<td>여분필드1</td>
									                	<td>여분필드를 사용할경우 꼭 기재해 주셔야합니다.</td>								                	
									                </tr>
									                <tr>
									                	<td>ext02</td>
									                	<td>여분필드2</td>
									                	<td>여분필드를 사용할경우 꼭 기재해 주셔야합니다.</td>								                	
									                </tr>
									                <tr>
									                	<td>...</td>
									                	<td>...</td>
									                	<td>...</td>								                	
									                </tr>									                
									                <tr>
									                	<td>ext020</td>
									                	<td>여분필드20</td>
									                	<td>여분필드를 사용할경우 꼭 기재해 주셔야합니다.</td>								                	
									                </tr>
									                <tr>
									                	<td>date01</td>
									                	<td>날짜여분01</td>
									                	<td>날짜여부필드를 사용할경우 꼭 기재해 주셔야합니다.</td>								                	
									                </tr>
									               	<tr>
									                	<td>date02</td>
									                	<td>날짜여분02</td>
									                	<td>날짜여부필드를 사용할경우 꼭 기재해 주셔야합니다.</td>								                	
									                </tr>								                
									                <tr>
									                	<td>img</td>
									                	<td>이미지노출</td>
									                	<td>썸네일,갤러리게시판에 리스트페이지에 사용됨.</td>
									                </tr>
								                </table>
							                </div>
						                </td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth4">보기 노출 순서 <a href="javascript:Jnit_question('18');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <form:input style="width:98%;" value="${mode == 'add' ? 'content' : ''}" path="fieldSortView" cssClass="txt"/><form:errors path="fieldSortView" />
							                <div id="question18" style="display: none;">
							                	<b>
									                - 위에 입력한 순서대로 리스트 페이지 노출됩니다.<br />
									                - no,title,writer,created,hit,file은 고정노출됩니다.<br />
									                - 항목정의(아래에 있는 항목만 노출가능합니다.)<br />
								                </b>
								                <table class="table table-bordered">
								                	<tr>
								                		<th>항목코드</th>
								                		<th>항목고유명칭</th>
								                		<th>간략설명</th>
								                	</tr>
								                	<tr>
								                		<td>content</td>
								                		<td>내용</td>
								                		<td>리스트페이지에 콘텐츠 내용을 노출시 사용됩니다.</td>
								                	</tr>
								                	<tr>
									                	<td>ext01</td>
									                	<td>여분필드1</td>
									                	<td>여분필드를 사용할경우 꼭 기재해 주셔야합니다.</td>								                	
									                </tr>
									                <tr>
									                	<td>ext02</td>
									                	<td>여분필드2</td>
									                	<td>여분필드를 사용할경우 꼭 기재해 주셔야합니다.</td>								                	
									                </tr>
									                <tr>
									                	<td>...</td>
									                	<td>...</td>
									                	<td>...</td>								                	
									                </tr>									                
									                <tr>
									                	<td>ext020</td>
									                	<td>여분필드20</td>
									                	<td>여분필드를 사용할경우 꼭 기재해 주셔야합니다.</td>								                	
									                </tr>
									                <tr>
									                	<td>date01</td>
									                	<td>날짜여분01</td>
									                	<td>날짜여부필드를 사용할경우 꼭 기재해 주셔야합니다.</td>								                	
									                </tr>
									               	<tr>
									                	<td>date02</td>
									                	<td>날짜여분02</td>
									                	<td>날짜여부필드를 사용할경우 꼭 기재해 주셔야합니다.</td>								                	
									                </tr>								                	
								                </table>
							                </div>
						                </td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth4">등록 노출 순서 <a href="javascript:Jnit_question('19');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <form:input style="width:98%;" value="${mode == 'add' ? 'title,writer,created,hit,content' : ''}" path="fieldSortWrite" cssClass="txt"/><form:errors path="fieldSortWrite" />
							                <div id="question19" style="display: none;">
							                	<b>
									                - 위에 입력한 순서대로 리스트 페이지 노출됩니다.<br />
									                - no값은 입력하실수 없습니다. 노출불가<br />
									                - 일반사용자에게는 writer,created,hit 값은 노출되지 않습니다. 관리자권한이 있는 사용자에게 노출됩니다.<br />
								                </b>
								               <strong>※ 주의사항: 하단에 여분필드를 세팅하고 등록노출순서에 해당 여분필드 코드를 삽입하지 않으실 경우 입력란이 생성되지 않습니다.</strong>
							                </div>
						                </td>
						            </tr>
						            <!-- Extra Field 01 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드01 <a href="javascript:Jnit_question('20');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt01" id="useExt01" onchange="if(this.value != '0') { $('.useExt01').show(); }else { $('.useExt01').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt01 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt01 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt01 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt01 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt01 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>							                
							                <div class="useExt01" <c:out value="${jnitboardinfoVO.useExt01 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext01Opt" id="ext01Opt">							                
									                <option value="input" <c:out value="${jnitboardinfoVO.ext01Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext01Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext01Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext01Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext01Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext01Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>								                
							                </div>
							                <div class="useExt01" <c:out value="${jnitboardinfoVO.useExt01 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>						                	
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드01 라벨 입력' : ''}" path="ext01Lbl" cssClass="txt"/><form:errors path="ext01Lbl" />
							                </div>
							                <span id="question20" style="display: none;">
							                	
							                </span>
						                </td>
						            </tr>         
						            <!-- End of Extra Field 01 -->
						            <!-- Extra Field 02 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드02 <a href="javascript:Jnit_question('21');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt02" id="useExt02" onchange="if(this.value != '0') { $('.useExt02').show(); }else { $('.useExt02').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt02 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt02 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt02 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt02 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt02 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt02" <c:out value="${jnitboardinfoVO.useExt02 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext02Opt" id="ext02Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext02Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext02Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext02Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext02Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext02Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext02Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt02" <c:out value="${jnitboardinfoVO.useExt02 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드02 라벨 입력' : ''}" path="ext02Lbl" cssClass="txt"/><form:errors path="ext02Lbl" />
							                </div>
							                <span id="question21" style="display: none;"></span>
						                </td>
						            </tr>						            
						            <!-- End of Extra Field 02 -->
						            <!-- Extra Field 03 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드03 <a href="javascript:Jnit_question('22');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt03" id="useExt03" onchange="if(this.value != '0') { $('.useExt03').show(); }else { $('.useExt03').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt03 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt03 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt03 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt03 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt03 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt03" <c:out value="${jnitboardinfoVO.useExt03 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext03Opt" id="ext03Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext03Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext03Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext03Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext03Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext03Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext03Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt03" <c:out value="${jnitboardinfoVO.useExt03 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드03 라벨 입력' : ''}" path="ext03Lbl" cssClass="txt"/><form:errors path="ext03Lbl" />
							                </div>
							                <span id="question22" style="display: none;"></span>
						                </td>						               
						            </tr>						            
						            <!-- End of Extra Field 03 -->
						            <!-- Extra Field 04 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드04 <a href="javascript:Jnit_question('23');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt04" id="useExt04" onchange="if(this.value != '0') { $('.useExt04').show(); }else { $('.useExt04').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt04 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt04 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt04 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt04 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt04 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt04" <c:out value="${jnitboardinfoVO.useExt04 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext04Opt" id="ext04Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext04Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext04Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext04Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext04Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext04Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext04Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt04" <c:out value="${jnitboardinfoVO.useExt04 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                 <form:input style="width:98%;" value="${mode == 'add' ? '여분필드04 라벨 입력' : ''}" path="ext04Lbl" cssClass="txt"/><form:errors path="ext04Lbl" />
							                </div>
							                <span id="question23" style="display: none;"></span>
						                </td>
						            </tr>						            
						            <!-- End of Extra Field 04 -->
						            <!-- Extra Field 05 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드05 <a href="javascript:Jnit_question('24');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt05" id="useExt05" onchange="if(this.value != '0') { $('.useExt05').show(); }else { $('.useExt05').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt05 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt05 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt05 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt05 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt05 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt05" <c:out value="${jnitboardinfoVO.useExt05 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext05Opt" id="ext05Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext05Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext05Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext05Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext05Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext05Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext05Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt05" <c:out value="${jnitboardinfoVO.useExt05 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드05 라벨 입력' : ''}" path="ext05Lbl" cssClass="txt"/><form:errors path="ext05Lbl" />
							                </div>
							                <span id="question24" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 06 -->
						            <!-- Extra Field 06 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드06 <a href="javascript:Jnit_question('25');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt06" id="useExt06" onchange="if(this.value != '0') { $('.useExt06').show(); }else { $('.useExt06').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt06 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt06 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt06 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt06 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt06 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt06" <c:out value="${jnitboardinfoVO.useExt06 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext06Opt" id="ext06Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext06Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext06Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext06Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext06Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext06Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext06Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt06" <c:out value="${jnitboardinfoVO.useExt06 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드06 라벨 입력' : ''}" path="ext06Lbl" cssClass="txt"/><form:errors path="ext06Lbl" />
							                </div>
							                <span id="question25" style="display: none;"></span>
						                </td>						                
						            </tr>
						            <!-- End of Extra Field 06 -->
						            <!-- Extra Field 07 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드07 <a href="javascript:Jnit_question('26');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt07" id="useExt07" onchange="if(this.value != '0') { $('.useExt07').show(); }else { $('.useExt07').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt07 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt07 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt07 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt07 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt07 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt07" <c:out value="${jnitboardinfoVO.useExt07 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext07Opt" id="ext07Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext07Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext07Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext07Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext07Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext07Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext07Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt07" <c:out value="${jnitboardinfoVO.useExt07 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드07 라벨 입력' : ''}" path="ext07Lbl" cssClass="txt"/><form:errors path="ext07Lbl" />
							                </div>
							                <span id="question26" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 07 -->
						            <!-- Extra Field 08 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드08 <a href="javascript:Jnit_question('27');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt08" id="useExt08" onchange="if(this.value != '0') { $('.useExt08').show(); }else { $('.useExt08').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt08 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt08 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt08 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt08 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt08 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt08" <c:out value="${jnitboardinfoVO.useExt08 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext08Opt" id="ext08Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext08Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext08Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext08Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext08Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext08Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext08Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt08" <c:out value="${jnitboardinfoVO.useExt08 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드08 라벨 입력' : ''}" path="ext08Lbl" cssClass="txt"/><form:errors path="ext08Lbl" />
							                </div>
							                <span id="question27" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 08 -->
						            <!-- Extra Field 09 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드09 <a href="javascript:Jnit_question('28');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt09" id="useExt09" onchange="if(this.value != '0') { $('.useExt09').show(); }else { $('.useExt09').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt09 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt09 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt09 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt09 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt09 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt09" <c:out value="${jnitboardinfoVO.useExt09 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext09Opt" id="ext09Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext09Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext09Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext09Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext09Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext09Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext09Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt09" <c:out value="${jnitboardinfoVO.useExt09 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드09 라벨 입력' : ''}" path="ext09Lbl" cssClass="txt"/><form:errors path="ext09Lbl" />
							                </div>
							                <span id="question28" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 10 -->
						            <!-- Extra Field 10 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드10 <a href="javascript:Jnit_question('29');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt10" id="useExt10" onchange="if(this.value != '0') { $('.useExt10').show(); }else { $('.useExt10').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt10 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt10 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt10 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt10 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt10 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt10" <c:out value="${jnitboardinfoVO.useExt10 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext10Opt" id="ext10Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext10Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext10Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext10Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext10Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext10Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext10Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt10" <c:out value="${jnitboardinfoVO.useExt10 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드10 라벨 입력' : ''}" path="ext10Lbl" cssClass="txt"/><form:errors path="ext10Lbl" />
							                </div>
							                <span id="question29" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 10 -->
						            <!-- Extra Field 11 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드11 <a href="javascript:Jnit_question('30');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt11" id="useExt11" onchange="if(this.value != '0') { $('.useExt11').show(); }else { $('.useExt11').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt11 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt11 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt11 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt11 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt11 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt11" <c:out value="${jnitboardinfoVO.useExt11 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext11Opt" id="ext11Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext11Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext11Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext11Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext11Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext11Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext11Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt11" <c:out value="${jnitboardinfoVO.useExt11 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드11 라벨 입력' : ''}" path="ext11Lbl" cssClass="txt"/><form:errors path="ext11Lbl" />
							                </div>
							                <span id="question30" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 11 -->
						            <!-- Extra Field 12 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드12 <a href="javascript:Jnit_question('31');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt12" id="useExt12" onchange="if(this.value != '0') { $('.useExt12').show(); }else { $('.useExt12').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt12 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt12 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt12 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt12 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt12 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt12" <c:out value="${jnitboardinfoVO.useExt12 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext12Opt" id="ext12Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext12Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext12Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext12Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext12Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext12Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext12Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt12" <c:out value="${jnitboardinfoVO.useExt12 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드12 라벨 입력' : ''}" path="ext12Lbl" cssClass="txt"/><form:errors path="ext12Lbl" />
							                </div>
							                <span id="question31" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 12 -->
						            <!-- Extra Field 13 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드13 <a href="javascript:Jnit_question('32');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt13" id="useExt13" onchange="if(this.value != '0') { $('.useExt13').show(); }else { $('.useExt13').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt13 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt13 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt13 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt13 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt13 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt13" <c:out value="${jnitboardinfoVO.useExt13 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext13Opt" id="ext13Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext13Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext13Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext13Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext13Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext13Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext13Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt13" <c:out value="${jnitboardinfoVO.useExt13 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드13 라벨 입력' : ''}" path="ext13Lbl" cssClass="txt"/><form:errors path="ext13Lbl" />
							                </div>
							                <span id="question32" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 13 -->
						            <!-- Extra Field 14 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드14 <a href="javascript:Jnit_question('33');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt14" id="useExt14" onchange="if(this.value != '0') { $('.useExt14').show(); }else { $('.useExt14').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt14 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt14 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt14 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt14 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt14 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt14" <c:out value="${jnitboardinfoVO.useExt14 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext14Opt" id="ext14Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext14Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext14Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext14Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext14Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext14Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext14Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt14" <c:out value="${jnitboardinfoVO.useExt14 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드14 라벨 입력' : ''}" path="ext14Lbl" cssClass="txt"/><form:errors path="ext14Lbl" />
							                </div>
							                <span id="question33" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 14 -->
						            <!-- Extra Field 15 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드15 <a href="javascript:Jnit_question('34');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt15" id="useExt15" onchange="if(this.value != '0') { $('.useExt15').show(); }else { $('.useExt15').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt15 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt15 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt15 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt15 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt15 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt15" <c:out value="${jnitboardinfoVO.useExt15 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext15Opt" id="ext15Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext15Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext15Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext15Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext15Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext15Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext15Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt15" <c:out value="${jnitboardinfoVO.useExt15 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드15 라벨 입력' : ''}" path="ext15Lbl" cssClass="txt"/><form:errors path="ext15Lbl" />
							                </div>
							                <span id="question34" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 15 -->
						            <!-- Extra Field 16 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드16 <a href="javascript:Jnit_question('35');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt16" id="useExt16" onchange="if(this.value != '0') { $('.useExt16').show(); }else { $('.useExt16').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt16 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt16 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt16 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt16 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt16 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt16" <c:out value="${jnitboardinfoVO.useExt16 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext16Opt" id="ext16Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext16Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext16Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext16Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext16Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext16Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext16Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt16" <c:out value="${jnitboardinfoVO.useExt16 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드16 라벨 입력' : ''}" path="ext16Lbl" cssClass="txt"/><form:errors path="ext16Lbl" />
							                </div>
							                <span id="question35" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 16 -->
						            <!-- Extra Field 17 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드17 <a href="javascript:Jnit_question('36');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt17" id="useExt17" onchange="if(this.value != '0') { $('.useExt17').show(); }else { $('.useExt17').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt17 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt17 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt17 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt17 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt17 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt17" <c:out value="${jnitboardinfoVO.useExt17 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext17Opt" id="ext17Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext17Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext17Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext17Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext17Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext17Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext17Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt17" <c:out value="${jnitboardinfoVO.useExt17 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드17 라벨 입력' : ''}" path="ext17Lbl" cssClass="txt"/><form:errors path="ext17Lbl" />
							                </div>
							                <span id="question36" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 17 -->
						            <!-- Extra Field 18 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드18 <a href="javascript:Jnit_question('37');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt18" id="useExt18" onchange="if(this.value != '0') { $('.useExt18').show(); }else { $('.useExt18').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt18 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt18 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt18 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt18 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt18 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt18" <c:out value="${jnitboardinfoVO.useExt18 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext18Opt" id="ext18Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext18Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext18Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext18Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext18Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext18Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext18Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt18" <c:out value="${jnitboardinfoVO.useExt18 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드18 라벨 입력' : ''}" path="ext18Lbl" cssClass="txt"/><form:errors path="ext18Lbl" />
							                </div>
							                <span id="question37" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 18 -->
						            <!-- Extra Field 19 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드19 <a href="javascript:Jnit_question('38');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt19" id="useExt19" onchange="if(this.value != '0') { $('.useExt19').show(); }else { $('.useExt19').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt19 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt19 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt19 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt19 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt19 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt19" <c:out value="${jnitboardinfoVO.useExt19 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext19Opt" id="ext19Opt">
									                <option value="input" <c:out value="${jnitboardinfoVO.ext19Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
									                <option value="textarea" <c:out value="${jnitboardinfoVO.ext19Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
									                <option value="select" <c:out value="${jnitboardinfoVO.ext19Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
									                <option value="email" <c:out value="${jnitboardinfoVO.ext19Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
									                <option value="address" <c:out value="${jnitboardinfoVO.ext19Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
									                <option value="check" <c:out value="${jnitboardinfoVO.ext19Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt19" <c:out value="${jnitboardinfoVO.useExt19 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드19 라벨 입력' : ''}" path="ext19Lbl" cssClass="txt"/><form:errors path="ext19Lbl" />
							                </div>
							                <span id="question38" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 19 -->
						            <!-- Extra Field 20 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분필드20 <a href="javascript:Jnit_question('39');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useExt20" id="useExt20" onchange="if(this.value != '0') { $('.useExt20').show(); }else { $('.useExt20').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useExt20 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useExt20 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useExt20 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useExt20 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useExt20 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useExt20" <c:out value="${jnitboardinfoVO.useExt20 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="ext20Opt" id="ext20Opt">
								                <option value="input" <c:out value="${jnitboardinfoVO.ext20Opt == 'input' ? 'selected' : ''}"/>>일반텍스트</option>
								                <option value="textarea" <c:out value="${jnitboardinfoVO.ext20Opt == 'textarea' ? 'selected' : ''}"/>>장문텍스트</option>
								                <option value="select" <c:out value="${jnitboardinfoVO.ext20Opt == 'select' ? 'selected' : ''}"/>>셀렉트박스(항목설정은 라벨에서 하세요)</option>
								                <option value="email" <c:out value="${jnitboardinfoVO.ext20Opt == 'email' ? 'selected' : ''}"/>>이메일주소</option>
								                <option value="address" <c:out value="${jnitboardinfoVO.ext20Opt == 'address' ? 'selected' : ''}"/>>집주소</option>
								                <option value="check" <c:out value="${jnitboardinfoVO.ext20Opt == 'check' ? 'selected' : ''}"/>>체크박스(개인정보제공전용)</option>
								                </select>
							                </div>
							                <div class="useExt20" <c:out value="${jnitboardinfoVO.useExt20 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '여분필드20 라벨 입력' : ''}" path="ext20Lbl" cssClass="txt"/><form:errors path="ext20Lbl" />
							                </div>
							                <span id="question39" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Field 20 -->
						            <!-- Extra Date Field 01 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분 날짜 필드01 <a href="javascript:Jnit_question('40');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useDate01" id="useDate01" onchange="if(this.value != '0') { $('.useDate01').show(); }else { $('.useDate01').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useDate01 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useDate01 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useDate01 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useDate01 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useDate01 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useDate01" <c:out value="${jnitboardinfoVO.useDate01 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="date01Opt" id="date01Opt">
								                <option value="datetime" <c:out value="${jnitboardinfoVO.date01Opt == 'datetime' ? 'selected' : ''}"/>>yyyy-MM-dd hh:mm:ss</option>
								                <option value="date" <c:out value="${jnitboardinfoVO.date01Opt == 'date' ? 'selected' : ''}"/>>yyyy-MM-dd</option>
								                </select>
							                </div>
							                <div class="useDate01" <c:out value="${jnitboardinfoVO.useDate01 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '*여분날짜01 라벨 입력' : ''}" path="date01Lbl" cssClass="txt"/><form:errors path="date01Lbl" />
							                </div>
							                <span id="question40" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Date Field 01 -->
						            <!-- Extra Date Field 02 -->
						            <tr>
						            	<th class="Jnit_boardDepth4">여분 날짜 필드02 <a href="javascript:Jnit_question('41');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth4" colspan="2">
							                <select name="useDate02" id="useDate02" onchange="if(this.value != '0') { $('.useDate02').show(); }else { $('.useDate02').hide(); }">
												<option value="0" <c:out value="${jnitboardinfoVO.useDate02 == 0 ? 'selected' : ''}"/>>사용안함</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useDate02 == 1 ? 'selected' : ''}"/>>사용(리스트,읽기,쓰기 노출)</option>
								                <option value="2" <c:out value="${jnitboardinfoVO.useDate02 == 2 ? 'selected' : ''}"/>>사용(읽기,쓰기 노출)</option>
								                <option value="3" <c:out value="${jnitboardinfoVO.useDate02 == 3 ? 'selected' : ''}"/>>사용(본인만 읽기,쓰기 노출)</option>
								                <option value="4" <c:out value="${jnitboardinfoVO.useDate02 == 4 ? 'selected' : ''}"/>>사용(관리자만 읽기,쓰기 노출)</option>
							                </select>
							                <div class="useDate02" <c:out value="${jnitboardinfoVO.useDate02 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <select name="date02Opt" id="date02Opt">
								                <option value="datetime" <c:out value="${jnitboardinfoVO.date02Opt == 'datetime' ? 'selected' : ''}"/>>yyyy-MM-dd hh:mm:ss</option>
								                <option value="date" <c:out value="${jnitboardinfoVO.date02Opt == 'date' ? 'selected' : ''}"/>>yyyy-MM-dd</option>
								                </select>
							                </div>
							                <div class="useDate02" <c:out value="${jnitboardinfoVO.useDate02 != 0 ? '' : 'style=\"display:none;\"'}" escapeXml="false" />>
								                <form:input style="width:98%;" value="${mode == 'add' ? '*여분날짜02 라벨 입력' : ''}" path="date02Lbl" cssClass="txt"/><form:errors path="date02Lbl" />
							                </div>
							                <span id="question41" style="display: none;"></span>
						                </td>
						            </tr>
						            <!-- End of Extra Date Field 02 -->
						            <tr>
						            	<th rowspan="17" id="Jnit_boardDepth5">권한설정 <a href="javascript:Jnit_board_flod('5');" id="Jnit_boardDepth5_btn" class="btn btn-small">접기</a></th>
						            	<th class="Jnit_boardDepth5" rowspan="2">접근 권한설정</th>
						            	<th class="Jnit_boardDepth5">개별 관리자 설정 <a href="javascript:Jnit_question('42');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth5" colspan="2">
							                <form:input style="width:200px;" path="admExt" cssClass="txt"/><form:errors path="admExt" />
							                <a href="#none;" class="btn btn-small extMbr">추가</a>
							                <div id="question42" style="display: none;">
							                	<b>
								                	- 해당게시판에 전용 관리자 있을 경우 해당 회원을 지정하여 관리자로 설정할 수 있습니다.<br />
	                								- 등록가능한 회원은 유형값이 C레벨이상인 회원만 선택이 가능합니다.<br />
                								</b>
							                </div>							                							                
							                <c:if test="${admCount > 0}"><br />
							                	<c:forEach var="i" begin="0" end="${admCount -1}">
							                		${admNm[i]},
							                	</c:forEach>
							                </c:if>
						                </td>
						            </tr>						            
						            <tr>
						                <th class="Jnit_boardDepth5"><font color="red">*</font> 관리자 레벨 <a href="javascript:Jnit_question('43');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth5" colspan="2">
							                <form:input style="width:200px;"  value="${mode == 'add' ? 'A,B,C' : ''}" path="admList" cssClass="txt"/><form:errors path="admList" />
							                <div id="question43" style="display: none;">
							                	<b>
								                	- ‘,’를 구분으로 입력하시면 됩니다.<br />
	            									- 해당입력란에 등록된 레벨만 관리권한을 획득합니다.<br />
            									</b>
							                </div>						                
						                </td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth5" rowspan="6">항목별 레벨권한
						                	<c:if test="${mode == 'edit'}">
							                <c:set var="permListValue" value="${jnitboardinfoVO.permList}"/>
							                <c:set var="permViewValue" value="${jnitboardinfoVO.permView}"/>
							                <c:set var="permWriteValue" value="${jnitboardinfoVO.permWrite}"/>
							                <c:set var="permReplyValue" value="${jnitboardinfoVO.permReply}"/>
							                <c:set var="permCmtValue" value="${jnitboardinfoVO.permCmt}"/>
							                <c:set var="permFileDownValue" value="${jnitboardinfoVO.permFileDown}"/>
							                <c:set var="permFileDownTypeValue" value="${jnitboardinfoVO.permFileDownType}"/>
							                <c:set var="anonPermListValue" value="${jnitboardinfoVO.anonPermList}"/>
							                <c:set var="anonPermViewValue" value="${jnitboardinfoVO.anonPermView}"/>
							                <c:set var="anonPermWriteValue" value="${jnitboardinfoVO.anonPermWrite}"/>
							                </c:if>
							                
							                <c:if test="${mode == 'add'}">							                
							                <c:set var="permListValue" value="Z"/>
							                <c:set var="permViewValue" value="Z"/>
							                <c:set var="permWriteValue" value="Z"/>
							                <c:set var="permReplyValue" value="Z"/>
							                <c:set var="permCmtValue" value="Z"/>
							                <c:set var="permFileDownValue" value=" "/>
							                <c:set var="anonPermListValue" value="1"/>
							                <c:set var="anonPermViewValue" value="0"/>
							                <c:set var="anonPermWriteValue" value="0"/>						                
							                </c:if>
						                </th>
						                <th class="Jnit_boardDepth5" style="width: 15%"><label>목록</label>레벨 <a href="javascript:Jnit_question('44');"><i class="icon-question-sign"></i></a></th>
						                <td class="Jnit_boardDepth5">
						                	<select name="permList" id="permList">
								                <option value="A" <c:out value='${permListValue == "A" ? "selected" : "" }'/>>A</option>
								                <option value="B" <c:out value='${permListValue == "B" ? "selected" : "" }'/>>B</option>
								                <option value="C" <c:out value='${permListValue == "C" ? "selected" : "" }'/>>C</option>
								                <option value="D" <c:out value='${permListValue == "D" ? "selected" : "" }'/>>D</option>
								                <option value="E" <c:out value='${permListValue == "E" ? "selected" : "" }'/>>E</option>
								                <option value="F" <c:out value='${permListValue == "F" ? "selected" : "" }'/>>F</option>
								                <option value="G" <c:out value='${permListValue == "G" ? "selected" : "" }'/>>G</option>
								                <option value="H" <c:out value='${permListValue == "H" ? "selected" : "" }'/>>H</option>
								                <option value="I" <c:out value='${permListValue == "I" ? "selected" : "" }'/>>I</option>
								                <option value="J" <c:out value='${permListValue == "J" ? "selected" : "" }'/>>J</option>
								                <option value="K" <c:out value='${permListValue == "K" ? "selected" : "" }'/>>K</option>
								                <option value="L" <c:out value='${permListValue == "L" ? "selected" : "" }'/>>L</option>
								                <option value="M" <c:out value='${permListValue == "M" ? "selected" : "" }'/>>M</option>
								                <option value="N" <c:out value='${permListValue == "N" ? "selected" : "" }'/>>N</option>
								                <option value="O" <c:out value='${permListValue == "O" ? "selected" : "" }'/>>O</option>
								                <option value="P" <c:out value='${permListValue == "P" ? "selected" : "" }'/>>P</option>
								                <option value="Q" <c:out value='${permListValue == "Q" ? "selected" : "" }'/>>Q</option>
								                <option value="R" <c:out value='${permListValue == "R" ? "selected" : "" }'/>>R</option>
								                <option value="S" <c:out value='${permListValue == "S" ? "selected" : "" }'/>>S</option>
								                <option value="T" <c:out value='${permListValue == "T" ? "selected" : "" }'/>>T</option>
								                <option value="U" <c:out value='${permListValue == "U" ? "selected" : "" }'/>>U</option>
								                <option value="V" <c:out value='${permListValue == "V" ? "selected" : "" }'/>>V</option>
								                <option value="W" <c:out value='${permListValue == "W" ? "selected" : "" }'/>>W</option>		
								                <option value="X" <c:out value='${permListValue == "X" ? "selected" : "" }'/>>X</option>
								                <option value="Y" <c:out value='${permListValue == "Y" ? "selected" : "" }'/>>Y</option>
								                <option value="Z" <c:out value='${permListValue == "Z" ? "selected" : "" }'/>>Z</option>
							                </select>
							                <div id="question44" style="display: none;">
							                	<b>
										          	- 목록(리스트) 페이지에 접근할수 있는 레벨을 선택합니다.<br />
													- Z레벨이 최하위레벨이며 회원가입 후 일반회원을 의미합니다.<br />
													- 예를들어 C레벨 선택시 접근가능 레벨은 A,B,C레벨만 접근이 가능하게 됩니다.<br />
												</b>
							                </div>
						                </td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth5"><label>보기</label>레벨 <a href="javascript:Jnit_question('45');"><i class="icon-question-sign"></i></a></th>
						            	<td class="Jnit_boardDepth5">
						            		<select name="permView" id="permView">
								                <option value="A" <c:out value='${permViewValue == "A" ? "selected" : "" }'/>>A</option>
								                <option value="B" <c:out value='${permViewValue == "B" ? "selected" : "" }'/>>B</option>
								                <option value="C" <c:out value='${permViewValue == "C" ? "selected" : "" }'/>>C</option>
								                <option value="D" <c:out value='${permViewValue == "D" ? "selected" : "" }'/>>D</option>
								                <option value="E" <c:out value='${permViewValue == "E" ? "selected" : "" }'/>>E</option>
								                <option value="F" <c:out value='${permViewValue == "F" ? "selected" : "" }'/>>F</option>
								                <option value="G" <c:out value='${permViewValue == "G" ? "selected" : "" }'/>>G</option>
								                <option value="H" <c:out value='${permViewValue == "H" ? "selected" : "" }'/>>H</option>
								                <option value="I" <c:out value='${permViewValue == "I" ? "selected" : "" }'/>>I</option>
								                <option value="J" <c:out value='${permViewValue == "J" ? "selected" : "" }'/>>J</option>
								                <option value="K" <c:out value='${permViewValue == "K" ? "selected" : "" }'/>>K</option>
								                <option value="L" <c:out value='${permViewValue == "L" ? "selected" : "" }'/>>L</option>
								                <option value="M" <c:out value='${permViewValue == "M" ? "selected" : "" }'/>>M</option>
								                <option value="N" <c:out value='${permViewValue == "N" ? "selected" : "" }'/>>N</option>
								                <option value="O" <c:out value='${permViewValue == "O" ? "selected" : "" }'/>>O</option>
								                <option value="P" <c:out value='${permViewValue == "P" ? "selected" : "" }'/>>P</option>
								                <option value="Q" <c:out value='${permViewValue == "Q" ? "selected" : "" }'/>>Q</option>
								                <option value="R" <c:out value='${permViewValue == "R" ? "selected" : "" }'/>>R</option>
								                <option value="S" <c:out value='${permViewValue == "S" ? "selected" : "" }'/>>S</option>
								                <option value="T" <c:out value='${permViewValue == "T" ? "selected" : "" }'/>>T</option>
								                <option value="U" <c:out value='${permViewValue == "U" ? "selected" : "" }'/>>U</option>
								                <option value="V" <c:out value='${permViewValue == "V" ? "selected" : "" }'/>>V</option>
								                <option value="W" <c:out value='${permViewValue == "W" ? "selected" : "" }'/>>W</option>
								                <option value="X" <c:out value='${permViewValue == "X" ? "selected" : "" }'/>>X</option>
								                <option value="Y" <c:out value='${permViewValue == "Y" ? "selected" : "" }'/>>Y</option>
								                <option value="Z" <c:out value='${permViewValue == "Z" ? "selected" : "" }'/>>Z</option>
							                </select>
							                <div id="question45" style="display: none;">
							                	<b>
								                	- 보기(상세뷰) 페이지에 접근할수 있는 레벨을 선택합니다.<br />
											        - Z레벨이 최하위레벨이며 회원가입 후 일반회원을 의미합니다.<br />
											        - 예를들어 C레벨 선택시 접근가능 레벨은 A,B,C레벨만 접근이 가능하게 됩니다.<br />
										        </b>
							                </div>
						            	</td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth5"><label>쓰기</label>레벨 <a href="javascript:Jnit_question('46');"><i class="icon-question-sign"></i></a></th>
						            	<td class="Jnit_boardDepth5">
						            		<select name="permWrite" id="permWrite">
								                <option value="A" <c:out value='${permWriteValue == "A" ? "selected" : "" }'/>>A</option>
								                <option value="B" <c:out value='${permWriteValue == "B" ? "selected" : "" }'/>>B</option>
								                <option value="C" <c:out value='${permWriteValue == "C" ? "selected" : "" }'/>>C</option>
								                <option value="D" <c:out value='${permWriteValue == "D" ? "selected" : "" }'/>>D</option>
								                <option value="E" <c:out value='${permWriteValue == "E" ? "selected" : "" }'/>>E</option>
								                <option value="F" <c:out value='${permWriteValue == "F" ? "selected" : "" }'/>>F</option>
								                <option value="G" <c:out value='${permWriteValue == "G" ? "selected" : "" }'/>>G</option>
								                <option value="H" <c:out value='${permWriteValue == "H" ? "selected" : "" }'/>>H</option>
								                <option value="I" <c:out value='${permWriteValue == "I" ? "selected" : "" }'/>>I</option>
								                <option value="J" <c:out value='${permWriteValue == "J" ? "selected" : "" }'/>>J</option>
								                <option value="K" <c:out value='${permWriteValue == "K" ? "selected" : "" }'/>>K</option>
								                <option value="L" <c:out value='${permWriteValue == "L" ? "selected" : "" }'/>>L</option>
								                <option value="M" <c:out value='${permWriteValue == "M" ? "selected" : "" }'/>>M</option>
								                <option value="N" <c:out value='${permWriteValue == "N" ? "selected" : "" }'/>>N</option>
								                <option value="O" <c:out value='${permWriteValue == "O" ? "selected" : "" }'/>>O</option>
								                <option value="P" <c:out value='${permWriteValue == "P" ? "selected" : "" }'/>>P</option>
								                <option value="Q" <c:out value='${permWriteValue == "Q" ? "selected" : "" }'/>>Q</option>
								                <option value="R" <c:out value='${permWriteValue == "R" ? "selected" : "" }'/>>R</option>
								                <option value="S" <c:out value='${permWriteValue == "S" ? "selected" : "" }'/>>S</option>
								                <option value="T" <c:out value='${permWriteValue == "T" ? "selected" : "" }'/>>T</option>
								                <option value="U" <c:out value='${permWriteValue == "U" ? "selected" : "" }'/>>U</option>
								                <option value="V" <c:out value='${permWriteValue == "V" ? "selected" : "" }'/>>V</option>
								                <option value="W" <c:out value='${permWriteValue == "W" ? "selected" : "" }'/>>W</option>
								                <option value="X" <c:out value='${permWriteValue == "X" ? "selected" : "" }'/>>X</option>
								                <option value="Y" <c:out value='${permWriteValue == "Y" ? "selected" : "" }'/>>Y</option>
								                <option value="Z" <c:out value='${permWriteValue == "Z" ? "selected" : "" }'/>>Z</option>
							                </select>
							                <div id="question46" style="display: none;">
							                	<b>
								                	- 쓰기(등록) 페이지에 접근할수 있는 레벨을 선택합니다.<br />
										        	- Z레벨이 최하위레벨이며 회원가입 후 일반회원을 의미합니다.<br />
										        	- 예를들어 C레벨 선택시 접근가능 레벨은 A,B,C레벨만 접근이 가능하게 됩니다.<br />
									        	</b>
							                </div>
						            	</td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth5"><label>답글</label>레벨 <a href="javascript:Jnit_question('47');"><i class="icon-question-sign"></i></a></th>
						            	<td class="Jnit_boardDepth5">
						            		<select name="permReply" id="permReply">
								                <option value="A" <c:out value='${permReplyValue == "A" ? "selected" : "" }'/>>A</option>
								                <option value="B" <c:out value='${permReplyValue == "B" ? "selected" : "" }'/>>B</option>
								                <option value="C" <c:out value='${permReplyValue == "C" ? "selected" : "" }'/>>C</option>
								                <option value="D" <c:out value='${permReplyValue == "D" ? "selected" : "" }'/>>D</option>
								                <option value="E" <c:out value='${permReplyValue == "E" ? "selected" : "" }'/>>E</option>
								                <option value="F" <c:out value='${permReplyValue == "F" ? "selected" : "" }'/>>F</option>
								                <option value="G" <c:out value='${permReplyValue == "G" ? "selected" : "" }'/>>G</option>
								                <option value="H" <c:out value='${permReplyValue == "H" ? "selected" : "" }'/>>H</option>
								                <option value="I" <c:out value='${permReplyValue == "I" ? "selected" : "" }'/>>I</option>
								                <option value="J" <c:out value='${permReplyValue == "J" ? "selected" : "" }'/>>J</option>
								                <option value="K" <c:out value='${permReplyValue == "K" ? "selected" : "" }'/>>K</option>
								                <option value="L" <c:out value='${permReplyValue == "L" ? "selected" : "" }'/>>L</option>
								                <option value="M" <c:out value='${permReplyValue == "M" ? "selected" : "" }'/>>M</option>
								                <option value="N" <c:out value='${permReplyValue == "N" ? "selected" : "" }'/>>N</option>
								                <option value="O" <c:out value='${permReplyValue == "O" ? "selected" : "" }'/>>O</option>
								                <option value="P" <c:out value='${permReplyValue == "P" ? "selected" : "" }'/>>P</option>
								                <option value="Q" <c:out value='${permReplyValue == "Q" ? "selected" : "" }'/>>Q</option>
								                <option value="R" <c:out value='${permReplyValue == "R" ? "selected" : "" }'/>>R</option>
								                <option value="S" <c:out value='${permReplyValue == "S" ? "selected" : "" }'/>>S</option>
								                <option value="T" <c:out value='${permReplyValue == "T" ? "selected" : "" }'/>>T</option>
								                <option value="U" <c:out value='${permReplyValue == "U" ? "selected" : "" }'/>>U</option>
								                <option value="V" <c:out value='${permReplyValue == "V" ? "selected" : "" }'/>>V</option>
								                <option value="W" <c:out value='${permReplyValue == "W" ? "selected" : "" }'/>>W</option>
								                <option value="X" <c:out value='${permReplyValue == "X" ? "selected" : "" }'/>>X</option>
								                <option value="Y" <c:out value='${permReplyValue == "Y" ? "selected" : "" }'/>>Y</option>
								                <option value="Z" <c:out value='${permReplyValue == "Z" ? "selected" : "" }'/>>Z</option>								                
							                </select>
							                <div id="question47" style="display: none;">
							                	<b>
									                - 답글 페이지에 접근할수 있는 레벨을 선택합니다.<br />
										        	- 리스트페이지에 원문글 하단에 바로 붙는형식에 게시물을 의미합니다.<br />
										        	- Z레벨이 최하위레벨이며 회원가입 후 일반회원을 의미합니다.<br />
										        	- 예를들어 C레벨 선택시 접근가능 레벨은 A,B,C레벨만 접근이 가능하게 됩니다.<br />
									        	</b>
							                </div>
						            	</td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth5"><label>댓글</label> 쓰기 레벨 <a href="javascript:Jnit_question('48');"><i class="icon-question-sign"></i></a></th>
						            	<td class="Jnit_boardDepth5">
						            		<select name="permCmt" id="permCmt">
								                <option value="A" <c:out value='${permCmtValue == "A" ? "selected" : "" }'/>>A</option>
								                <option value="B" <c:out value='${permCmtValue == "B" ? "selected" : "" }'/>>B</option>
								                <option value="C" <c:out value='${permCmtValue == "C" ? "selected" : "" }'/>>C</option>
								                <option value="D" <c:out value='${permCmtValue == "D" ? "selected" : "" }'/>>D</option>
								                <option value="E" <c:out value='${permCmtValue == "E" ? "selected" : "" }'/>>E</option>
								                <option value="F" <c:out value='${permCmtValue == "F" ? "selected" : "" }'/>>F</option>
								                <option value="G" <c:out value='${permCmtValue == "G" ? "selected" : "" }'/>>G</option>
								                <option value="H" <c:out value='${permCmtValue == "H" ? "selected" : "" }'/>>H</option>
								                <option value="I" <c:out value='${permCmtValue == "I" ? "selected" : "" }'/>>I</option>
								                <option value="J" <c:out value='${permCmtValue == "J" ? "selected" : "" }'/>>J</option>
								                <option value="K" <c:out value='${permCmtValue == "K" ? "selected" : "" }'/>>K</option>
								                <option value="L" <c:out value='${permCmtValue == "L" ? "selected" : "" }'/>>L</option>
								                <option value="M" <c:out value='${permCmtValue == "M" ? "selected" : "" }'/>>M</option>
								                <option value="N" <c:out value='${permCmtValue == "N" ? "selected" : "" }'/>>N</option>
								                <option value="O" <c:out value='${permCmtValue == "O" ? "selected" : "" }'/>>O</option>
								                <option value="P" <c:out value='${permCmtValue == "P" ? "selected" : "" }'/>>P</option>
								                <option value="Q" <c:out value='${permCmtValue == "Q" ? "selected" : "" }'/>>Q</option>
								                <option value="R" <c:out value='${permCmtValue == "R" ? "selected" : "" }'/>>R</option>
								                <option value="S" <c:out value='${permCmtValue == "S" ? "selected" : "" }'/>>S</option>
								                <option value="T" <c:out value='${permCmtValue == "T" ? "selected" : "" }'/>>T</option>
								                <option value="U" <c:out value='${permCmtValue == "U" ? "selected" : "" }'/>>U</option>
								                <option value="V" <c:out value='${permCmtValue == "V" ? "selected" : "" }'/>>V</option>
								                <option value="W" <c:out value='${permCmtValue == "W" ? "selected" : "" }'/>>W</option>
								                <option value="X" <c:out value='${permCmtValue == "X" ? "selected" : "" }'/>>X</option>
								                <option value="Y" <c:out value='${permCmtValue == "Y" ? "selected" : "" }'/>>Y</option>
								                <option value="Z" <c:out value='${permCmtValue == "Z" ? "selected" : "" }'/>>Z</option>
							                </select>
							                <div id="question48" style="display: none;">
							                	<b>
									                - 상세VIEW(보기) 페이지에서 댓글을 작성시 작성자에 작성권한을 결정합니다.<br />
											        - Z레벨이 최하위레벨이며 회원가입 후 일반회원을 의미합니다.<br />
											        - 예를들어 C레벨 선택시 접근가능 레벨은 A,B,C레벨만 접근이 가능하게 됩니다.<br />
											        - 해당기능은 상단 기본설정에 댓글 기능을 활성화 할때만 정상 작동합니다.<br />
										        </b>
							                </div>
						            	</td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth5"><label>파일</label> 다운로드 레벨 <a href="javascript:Jnit_question('64');"><i class="icon-question-sign"></i></a></th>
						            	<td class="Jnit_boardDepth5">
						            		<select name="permFileDown" id="permFileDown">
								                <option value="A" <c:out value='${permFileDownValue == "A" ? "selected" : "" }'/>>A</option>
								                <option value="B" <c:out value='${permFileDownValue == "B" ? "selected" : "" }'/>>B</option>
								                <option value="C" <c:out value='${permFileDownValue == "C" ? "selected" : "" }'/>>C</option>
								                <option value="D" <c:out value='${permFileDownValue == "D" ? "selected" : "" }'/>>D</option>
								                <option value="E" <c:out value='${permFileDownValue == "E" ? "selected" : "" }'/>>E</option>
								                <option value="F" <c:out value='${permFileDownValue == "F" ? "selected" : "" }'/>>F</option>
								                <option value="G" <c:out value='${permFileDownValue == "G" ? "selected" : "" }'/>>G</option>
								                <option value="H" <c:out value='${permFileDownValue == "H" ? "selected" : "" }'/>>H</option>
								                <option value="I" <c:out value='${permFileDownValue == "I" ? "selected" : "" }'/>>I</option>
								                <option value="J" <c:out value='${permFileDownValue == "J" ? "selected" : "" }'/>>J</option>
								                <option value="K" <c:out value='${permFileDownValue == "K" ? "selected" : "" }'/>>K</option>
								                <option value="L" <c:out value='${permFileDownValue == "L" ? "selected" : "" }'/>>L</option>
								                <option value="M" <c:out value='${permFileDownValue == "M" ? "selected" : "" }'/>>M</option>
								                <option value="N" <c:out value='${permFileDownValue == "N" ? "selected" : "" }'/>>N</option>
								                <option value="O" <c:out value='${permFileDownValue == "O" ? "selected" : "" }'/>>O</option>
								                <option value="P" <c:out value='${permFileDownValue == "P" ? "selected" : "" }'/>>P</option>
								                <option value="Q" <c:out value='${permFileDownValue == "Q" ? "selected" : "" }'/>>Q</option>
								                <option value="R" <c:out value='${permFileDownValue == "R" ? "selected" : "" }'/>>R</option>
								                <option value="S" <c:out value='${permFileDownValue == "S" ? "selected" : "" }'/>>S</option>
								                <option value="T" <c:out value='${permFileDownValue == "T" ? "selected" : "" }'/>>T</option>
								                <option value="U" <c:out value='${permFileDownValue == "U" ? "selected" : "" }'/>>U</option>
								                <option value="V" <c:out value='${permFileDownValue == "V" ? "selected" : "" }'/>>V</option>
								                <option value="W" <c:out value='${permFileDownValue == "W" ? "selected" : "" }'/>>W</option>
								                <option value="X" <c:out value='${permFileDownValue == "X" ? "selected" : "" }'/>>X</option>
								                <option value="Y" <c:out value='${permFileDownValue == "Y" ? "selected" : "" }'/>>Y</option>
								                <option value="Z" <c:out value='${permFileDownValue == "Z" ? "selected" : "" }'/>>Z</option>								                
								                <option value=" " <c:out value='${permFileDownValue == "" ? "selected" : "" }'/>>사용안함</option>
							                </select>
							                <div id="question64" style="display: none;">
							                	<b>
									                - 상세VIEW(보기) 페이지에서 첨부파일 다운로드시 권한을 결정합니다.<br />
											        - Z레벨이 최하위레벨이며 회원가입 후 일반회원을 의미합니다.<br />
											        - 예를들어 C레벨 선택시 접근가능 레벨은 A,B,C레벨만 접근이 가능하게 됩니다.											        
										        </b>
							                </div>
						            	</td>
						            </tr>						              
						            <tr>
						            	<th class="Jnit_boardDepth5" rowspan="6">항목별 유형권한</th>
						            	<th class="Jnit_boardDepth5"><label>목록 접근 유형 <a href="javascript:Jnit_question('49');"><i class="icon-question-sign"></i></a></label></th>
						            	<td class="Jnit_boardDepth5">
						            		<form:input path="permListType" cssClass="txt"/><a id="permListType" href="#none;" class="btn btn-small extType">추가</a>
							                <div id="question49" style="display: none;">
							                	<b>
									                - 목록(리스트) 페이지에 접근할수 있는 유형을 지정할 수 있습니다.<br />
											        - 예를들어 위 레벨을 Z레벨로 하고 해당 유형에 관리자유형을 등록할 경우 Z레벨은 충족하나<br />
											        &nbsp;&nbsp;관리자유형을 충족하지 못하므로 실제로 관리자유형만 접근이 가능하게 세팅됩니다.<br />
											    </b>
											    <strong>- 즉, 레벨과 유형권한을 둘다 세팅할 경우 둘 모두를 충족할 때 접근권한을 획득하게 됩니다.<br /></strong>
							                </div>
						            	</td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth5"><label>보기 접근 유형 <a href="javascript:Jnit_question('50');"><i class="icon-question-sign"></i></a></label></th>
						            	<td class="Jnit_boardDepth5">
						            		<form:input path="permViewType" cssClass="txt"/><a id="permViewType" href="#none;" class="btn btn-small extType">추가</a>
							                <div id="question50" style="display: none;">
							                	<b>
								                	- 보기(상세VIEW) 페이지에 접근할수 있는 유형을 지정할 수 있습니다.<br />
											        - 예를들어 위 레벨을 Z레벨로 하고 해당 유형에 관리자유형을 등록할 경우 Z레벨은 충족하나<br />
											        &nbsp;&nbsp;관리자유형을 충족하지 못하므로 실제로 관리자유형만 접근이 가능하게 세팅됩니다.<br />
												</b>											          
											    <strong>- 즉, 레벨과 유형권한을 둘다 세팅할 경우 둘 모두를 충족할 때 접근권한을 획득하게 됩니다.<br /></strong>
							                </div>
						            	</td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth5"><label>쓰기 접근 유형 <a href="javascript:Jnit_question('51');"><i class="icon-question-sign"></i></a></label></th>
						            	<td class="Jnit_boardDepth5">
						            		<form:input path="permWriteType" cssClass="txt"/><a id="permWriteType" href="#none;" class="btn btn-small extType">추가</a>
						            		<div id="question51" style="display: none;">
						            			<b>
								            		- 쓰기(등록) 페이지에 접근할수 있는 유형을 지정할 수 있습니다.<br />
											        - 예를들어 위 레벨을 Z레벨로 하고 해당 유형에 관리자유형을 등록할 경우 Z레벨은 충족하나<br />
											        &nbsp;&nbsp;관리자유형을 충족하지 못하므로 실제로 관리자유형만 접근이 가능하게 세팅됩니다.<br />
											    </b>      
											    <strong>- 즉, 레벨과 유형권한을 둘다 세팅할 경우 둘 모두를 충족할 때 접근권한을 획득하게 됩니다.</strong>
						            		</div>
						            	</td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth5"><label>답글 접근 유형 <a href="javascript:Jnit_question('52');"><i class="icon-question-sign"></i></a></label></th>
						            	<td class="Jnit_boardDepth5">
						            		<form:input path="permReplyType" cssClass="txt"/><a id="permReplyType" href="#none;" class="btn btn-small extType">추가</a>
						            		<div id="question52" style="display: none;">
						            			<b>
								            		- 답글버턴 클릭시 페이지에 접근할수 있는 유형을 지정할 수 있습니다.<br />
											        - 예를들어 위 레벨을 Z레벨로 하고 해당 유형에 관리자유형을 등록할 경우 Z레벨은 충족하나<br />
											        &nbsp;&nbsp;관리자유형을 충족하지 못하므로 실제로 관리자유형만 접근이 가능하게 세팅됩니다.<br />
											    </b>      
											    <strong>- 즉, 레벨과 유형권한을 둘다 세팅할 경우 둘 모두를 충족할 때 접근권한을 획득하게 됩니다.</strong>
						            		</div>
						            	</td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth5"><label>댓글 쓰기 유형 <a href="javascript:Jnit_question('53');"><i class="icon-question-sign"></i></a></label></th>
						            	<td class="Jnit_boardDepth5">
						            		<form:input path="permCmtType" cssClass="txt"/><a id="permCmtType" href="#none;" class="btn btn-small extType">추가</a>
						            		<div id="question53" style="display: none;">
						            			<b>
								            		- 상세VIEW(보기) 페이지에서 댓글을 작성시 작성자에 작성권한을 결정합니다.<br />
											        - 예를들어 위 레벨을 Z레벨로 하고 해당 유형에 관리자유형을 등록할 경우 Z레벨은 충족하나<br />
											        &nbsp;&nbsp;관리자유형을 충족하지 못하므로 실제로 관리자유형만 접근이 가능하게 세팅됩니다.<br />
											    </b>      
											    <strong>- 즉, 레벨과 유형권한을 둘다 세팅할 경우 둘 모두를 충족할 때 접근권한을 획득하게 됩니다.</strong>
						            		</div>
						            	</td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth5"><label>파일 다운로드 유형 <a href="javascript:Jnit_question('65');"><i class="icon-question-sign"></i></a></label></th>
						            	<td class="Jnit_boardDepth5">
						            		<form:input path="permFileDownType" cssClass="txt"/><a id="permFileDownType" href="#none;" class="btn btn-small extType">추가</a>
						            		<div id="question65" style="display: none;">
						            			<b>
								            		- 상세VIEW(보기) 페이지에서 댓글을 작성시 작성자에 작성권한을 결정합니다.<br />
											        - 예를들어 위 레벨을 Z레벨로 하고 해당 유형에 관리자유형을 등록할 경우 Z레벨은 충족하나<br />
											        &nbsp;&nbsp;관리자유형을 충족하지 못하므로 실제로 관리자유형만 접근이 가능하게 세팅됩니다.<br />
											    </b>      
											    <strong>- 즉, 레벨과 유형권한을 둘다 세팅할 경우 둘 모두를 충족할 때 접근권한을 획득하게 됩니다.</strong>
						            		</div>
						            	</td>
						            </tr>						            
						            <tr>
						                <th class="Jnit_boardDepth5" rowspan="3" id="anonPermId">비회원접근권한 <a href="javascript:Jnit_question('58');"><i class="icon-question-sign"></i></a></th>
						                <th class="Jnit_boardDepth5"><label for="anonPermList">목록 <a href="javascript:Jnit_question('54');"><i class="icon-question-sign"></i></a></label></th>
						                <td class="Jnit_boardDepth5">
						                	<select name="anonPermList" id="anonPermList">
								                <option value="1" <c:out value='${anonPermListValue == "1" ? "selected" : "" }'/>>접근허용</option>
								                <option value="0" <c:out value='${anonPermListValue == "0" ? "selected" : "" }'/>>접근불가</option>
							                </select>
							                <div id="question54" style="display: none;">
							                	<b>								                	
	       											- 목록(리스트)페이지에 비회원접근 허용여부를 제어하는 기능입니다.
       											</b>
							                </div>
						                </td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth5"><label for="anonPermView">보기 <a href="javascript:Jnit_question('55');"><i class="icon-question-sign"></i></a></label></th>
						            	<td class="Jnit_boardDepth5">
						            		<select name="anonPermView" id="anonPermView">
								                <option value="1" <c:out value='${anonPermViewValue == "1" ? "selected" : "" }'/>>접근허용</option>
								                <option value="0" <c:out value='${anonPermViewValue == "0" ? "selected" : "" }'/>>접근불가</option>
							                </select>
							                <div id="question55" style="display: none;">
							                	<b>									                
		       										- 보기(상세VIEW)페이지에 비회원접근 허용여부를 제어하는 기능입니다.
	       										</b>
							                </div>
						            	</td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth5"><label for="anonPermWrite">쓰기 <a href="javascript:Jnit_question('56');"><i class="icon-question-sign"></i></a></label></th>
						            	<td class="Jnit_boardDepth5">
						            		<select name="anonPermWrite" id="anonPermWrite">
								                <option value="1" <c:out value="${anonPermWriteValue == 1 ? 'selected' : ''}"/>>접근허용</option>
								                <option value="0" <c:out value="${anonPermWriteValue == 0 ? 'selected' : ''}"/>>접근불가</option>
							                </select>
							                <div id="question56" style="display: none;">
								                <b>									                
		       										- 쓰기(작성)페이지에 비회원작성 허용여부를 제어하는 기능입니다.
	       										</b>
							                </div>
						            	</td>
						            </tr>
						            <tr id="question58" style="display: none;">
						            	<td colspan="2">
						            		<span>
						            			<b>- 해당 게시판은 기본적으로 회원제로 운영되는 방식입니다. 최하위레벨인 Z레벨이 회원가입을 한 회원을 의미합니다. 비회원(로그인하지 않는 회원)에 접근 및 작성을 허용하고 할 경우 해당 접근권한을 제어하시기 바랍니다.</b>
						            		</span>
						            	</td>
						            </tr>
						            <%-- <tr>
						                <th>게시판 그룹</th>
						                <td>
							                <form:input style="width:200px;" path="boardGroup" value="${jnitboardinfoVO.boardGroup == '' ? '기본그룹' : ''}"  cssClass="txt"/>
							                (게시판관리시 구분을 위해 게시판그룹을 지정할 수 있습니다.)
							                &nbsp;<form:errors path="boardGroup" />
						                </td>
						            </tr>						            
						            <tr>
						                <th>읽기에서 답글 노출 여부</th>
						                <td>
							                <select name="useViewReply" id="useViewReply">
								                <option value="0" <c:out value="${jnitboardinfoVO.useViewReply == 0 ? 'selected' : ''}"/>>아니오</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useViewReply == 1 ? 'selected' : ''}"/>>예</option>
							                </select>
							                &nbsp;<form:errors path="useViewReply" />
						                </td>
						            </tr>
						            <tr>
						                <th>필터링 솔루션</th>
						                <td>
							                <select name="useFilter" id="useFilter" onchange="if(this.value == '1') { $('.useFilter').show(); }else { $('.useFilter').hide(); }">
								                <option value="0" <c:out value="${jnitboardinfoVO.useFilter == 0 ? 'selected' : ''}"/>>아니오</option>
								                <option value="1" <c:out value="${jnitboardinfoVO.useFilter == 1 ? 'selected' : ''}"/>>예</option>
							                </select>
							                &nbsp;<form:errors path="useFilter" />
							                <div style="display:<c:out value="${jnitboardinfoVO.useFilter == 1 ? 'block' : 'none'}"/>;" class="useFilter">
							                <form:input style="width:300px;"   path="filterAction" cssClass="txt" />
							                (필터링 솔루션에서 제공한 Action Target URL을 입력해주세요.)
							                </div>						                
						                </td>
						            </tr>
						            <tr class="wyswygOption" <c:out value="${jnitboardinfoVO.useWyswyg == 1 ? '' : 'style=\"display:none;\"'}" escapeXml="false" /> >
						                <th style="background:#dddddd;border:1px solid #ccc;">동영상첨부</th>
						                <td style="background:#dddddd;border:1px solid #ccc;">
							                <select name="useMovie" id="useMovie">
								                <option value="1" <c:out value="${jnitboardinfoVO.useMovie == 1 ? 'selected' : ''}"/>>예</option>
								                <option value="0" <c:out value="${jnitboardinfoVO.useMovie == 0 ? 'selected' : ''}"/>>아니오</option>
							                </select>
							                &nbsp;<form:errors path="useMovie" />
						                </td>
						            </tr>
						            --%> 
						            <%-- <tr>
						                <th>리스트답글 <a href="javascript:Jnit_question('12');"><i class="icon-question-sign"></i></a></th>
						                <td colspan="2">
						                	<input type="radio" name="useListReply" value="0" <c:out value='${jnitboardinfoVO.useListReply == "0" ? "checked" : "" }'/>><label>비노출</label>
						                	<input type="radio" name="useListReply" value="1" <c:out value='${jnitboardinfoVO.useListReply == "1" ? "checked" : "" }'/>><label>노출</label>
							                <select name="useListReply" id="useListReply">
							                <option value="0" <c:out value="${jnitboardinfoVO.useListReply == 0 ? 'selected' : ''}"/>>노출</option>
							                <option value="1" <c:out value="${jnitboardinfoVO.useListReply == 1 ? 'selected' : ''}"/>>비노출</option>
							                </select>							                
							                <span id="question12" style="display: none;"></span>
						                </td>
						            </tr> --%>  						            
						        </tbody>
						    </table>
						<input type="hidden" name="searchBoardGroup" value="<c:out value='${searchVO.searchBoardGroup}'/>"/>
						<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
						<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--콘텐츠끝-->
<div id="menuModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
	</div>
	<div class="modal-body">
		  <div id="mbrSearch"></div>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>    	
	</div>
</div>
<!-- 검색조건 유지 -->

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>