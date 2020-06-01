<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header_skeleton.jsp" %>
<%@ include file="/WEB-INF/jsp/jnit/include/cms/codeMirror.jsp" %>

<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/>"></script>

<script type="text/javaScript">
<!--

//승인
function fn_egov_save(type){
	$('#myModalLabel').empty();			
	$('#mbrSearch').empty();
	$('#myModalLabel').append("남기실 메모");
	$('#mbrSearch').append("<textarea id='memo' rows='10' style='width: 400px;'></textarea>");			
	$('.modal-footer').empty();
	if($('#disseminateType option:selected').val() == 1){
		$('.modal-footer').append(
						"<a href='javascript:fn_cancel_do(4);' class='btn btn-primary btn-small pull-right'>예약저장</a>");	
	}else if(type=="compulsion"){
		$('.modal-footer').append(
		"<a href='javascript:fn_cancel_do(6);' class='btn btn-primary btn-small pull-right'>강제승인</a>");
	}else if($('#disseminateType option:selected').val() == 2){		
		$('.modal-footer').append(
							"<a href='javascript:fn_cancel_do(5);' class='btn btn-primary btn-small pull-right'>승인</a>");			
	}else{
		$('.modal-footer').append(
						"<a href='javascript:fn_cancel_do(6);' class='btn btn-primary btn-small'>즉시배포</a>");
	}
	$('.modal').css('width','560px');
	$('.modal').css('margin-left','-280px');
	$('#myModal').modal('toggle');
}
//End 승인

//승인
function fn_egov_temporary(){
	fn_cancel_do(7);	
}
//End 승인

//취소 설정
function fn_egov_savedel(type){
	frm = document.getElementById("jnitcmscntvtVO");
	$('#myModalLabel').empty();			
	$('#mbrSearch').empty();
	$('#myModalLabel').append("남기실 메모");
	$('#mbrSearch').append("<textarea id='memo' rows='10' style='width: 400px;'></textarea>");			
	$('.modal-footer').empty();
	
	if(type == 1){ //예약	
		$('.modal-footer').append("<button class='btn' data-dismiss='modal' aria-hidden='true'>닫기</button>"+
						"<a href='javascript:fn_cancel_do(1);' class='btn btn-danger btn-small'>예약취소</a>");			
	}else if(type == 2){
		$('.modal-footer').append("<button class='btn' data-dismiss='modal' aria-hidden='true'>닫기</button>"+
						"<a href='javascript:fn_cancel_do(2);' class='btn btn-danger btn-small'>결제 취소</a>");
	}else if(type ==3){
		$('.modal-footer').append("<button class='btn' data-dismiss='modal' aria-hidden='true'>닫기</button>"+
						"<a href='javascript:fn_cancel_do(3);' class='btn btn-warning btn-small'>재설정</a>");
	}
	$('.modal').css('width','560px');
	$('.modal').css('margin-left','-280px');
	$('#myModal').modal('toggle');
    
}
function fn_cancel_do(type){
	if(type == 1){		
		frm = document.getElementById("jnitcmscntvtVO");			
		var memo = $('#memo').val();			
		$('#anMemo').val(memo);
		$('#cancel').val('daycancel');
		frm.action = "<c:url value='/cms/sub11/0101up.do'/>";
		frm.submit();
	}else if(type == 2){
		frm = document.getElementById("jnitcmscntvtVO");
		var memo = $('#memo').val();			
		$('#anMemo').val(memo);
		$('#cancel').val('disseminatecancel');
		frm.action = "<c:url value='/cms/sub11/0101up.do'/>";
		frm.submit();
	}else if(type == 3){
		frm = document.getElementById("jnitcmscntvtVO");
		var memo = $('#memo').val();			
		$('#anMemo').val(memo);
		$('#cancel').val('redisseminate');
		frm.action = "<c:url value='/cms/sub11/0101up.do'/>";
		frm.submit();
	}else if(type == 4){
		var disseminateDay = $('#disseminateDay').val();		
		if(disseminateDay == '' || disseminateDay == null){
			alert('예약 날자를 지정해주시기 바랍니다.');			
			$('#disseminateDay').focus();
			//return false;
		}else{
			var memo = $('#memo').val();			
			$('#anMemo').val(memo);
			frm = document.getElementById("jnitcmscntvtVO");
			frm.action = "<c:url value='/cms/sub11/0101up.do'/>";
		    frm.submit();	
		}
		
	}else if(type == 5){
		var mbrlength = $('#mbrList').find('option').length;
		if(mbrlength == 0){
			alert('관리자 등록을 해주시기 바랍니다.');
			$('#mbrList').focus();
			//return false;
		}else{
			var memo = $('#memo').val();			
			$('#anMemo').val(memo);
			frm = document.getElementById("jnitcmscntvtVO");
			frm.action = "<c:url value='/cms/sub11/0101up.do'/>";
		    frm.submit();	
		}
		
	}else if(type == 6){
		var memo = $('#memo').val();			
		$('#anMemo').val(memo);
		frm = document.getElementById("jnitcmscntvtVO");
		frm.action = "<c:url value='/cms/sub11/0101up.do'/>";
	    frm.submit();
	}else if(type == 7){
		var memo = $('#memo').val();			
		$('#anMemo').val(memo);
		$('#temporary').val('Y');
		frm = document.getElementById("jnitcmscntvtVO");
		frm.action = "<c:url value='/cms/sub11/0101up.do'/>";
	    frm.submit();
	}	
}
//End 취소 설정

$(document).ready(function(){	
	
	resizeEditor();	
	$(window).bind('resize', resizeEditor);
	$('.CodeMirror').css('width',''); 
	$('.CodeMirror').css('height', $(window).height()-370 );
	
	//select disseminateType 설정
	var disseminateType = "${disseminateType}";
	if(disseminateType != ''){
		$('#disseminateType').val(disseminateType);
	}	
	//end select disseminateType 설정
	
	// 기본설정
	var contentConfirm = "${contentConfirm}";
	if(contentConfirm == '' || contentConfirm == 1 || contentConfirm == 3 ){
		$('#disseminateDay').datepicker();
	}	
	var html = "<td align='right' style='padding-right:5px;text-align:right;' colspan='2'>"+
				    "<button class='btn btn-warning' onclick='javascript:fn_egov_save();return false;'>즉시배포</button>"+
				"</td>";
			
	$('#example').empty('tr');
	$('#example').append(html);	
	
	if($('#disseminateType option:selected').val() == 1){			
		$('.disseminateStep').hide();
		$(".disseminateDay").show();
		$('#example').empty('tr');
		var html2 = 
						"<td align='right' style='padding-right:5px;text-align:right;' colspan='2'>"+
							<c:if test="${contentConfirm == '' || contentConfirm == 1}">
							"<button class='btn btn-primary' onclick='javascript:fn_egov_save();return false;'>예약저장</button> "+
							</c:if>
							<c:if test="${contentConfirm == 0}">
							"<button class='btn btn-primary' onclick='javascript:fn_egov_temporary();return false;'>임시적용</button> "+
						    "<button class='btn btn-danger' onclick='javascript:fn_egov_savedel(1);return false;'>예약취소</button> "+
						    </c:if>
						    "<a class='btn' href='javascript:fn_egov_selectList();'>닫기</a>"+     	   				    
					    "</td>";          
					
		$('#example').append(html2);			
	}else if($('#disseminateType option:selected').val() == 2){
		$('.disseminateStep').show();
		$(".disseminateDay").hide();
		$('#example').empty('tr');			
    	var html2 = 
 	   					"<td align='right' style='padding-right:5px;text-align:right;' colspan='2'>"+ 	   						
 	   						<c:if test="${contentConfirm == ''}">
 	   						"<button class='btn btn-primary' onclick='javascript:fn_egov_save();return false;'>승인절차 등록</button> "+
 	   						</c:if>
 	   						"<button class='btn btn-primary' onclick='javascript:fn_egov_temporary();return false;'>임시저장</button> "+
 	   						<c:if test="${ contentConfirm == 0 || contentConfirm == 2 || contentConfirm == 6}">
 	   						
	 	   					"<button class='btn btn-success' onclick=\"javascript:fn_egov_save('compulsion');return false;\">결제 강제승인</button> "+
	 	   					</c:if>
	 	   					<c:if test="${ contentConfirm == 0 || contentConfirm == 1  || contentConfirm == 5 }">
	 	   					
	   						"<button class='btn btn-danger' onclick='javascript:fn_egov_savedel(2);return false;'>결제승인 강제취소</button> "+
	   						</c:if>
	   						
	   						"<button class='btn btn-warning' onclick='javascript:fn_egov_savedel(3);return false;'>승인절차 재설정</button> "+
	   						
     	   				    "<a class='btn' href='javascript:fn_egov_selectList();'>닫기</a>"+     	   				    
 	   				    "</td>";			
	   				
	   	$('#example').append(html2);			
	}else{
		$('#example').empty('tr');
		$('.disseminateStep').hide();
		$(".disseminateDay").hide();
		$('#example').append(html);
	}
	//end 기본설정
	
	//콘텐츠 배포 설정 change function
	$("#disseminateType").change(function(){		
		if($('#disseminateType option:selected').val() == 1){			
			$('.disseminateStep').hide();
			$(".disseminateDay").show();
			$('#example').empty('tr');
			var html2 = 
							"<td align='right' style='padding-right:5px;text-align:right;' colspan='2'>"+
								"<button class='btn btn-primary' onclick='javascript:fn_egov_save();return false;'>예약저장</button> "+
							    "<a class='btn' href='javascript:fn_egov_selectList();'>닫기</a>"+     	   				    
						    "</td>";
			$('#example').append(html2);			
		}else if($('#disseminateType option:selected').val() == 2){
			$('.disseminateStep').show();
			$(".disseminateDay").hide();
			$('#example').empty('tr');			
        	var html2 = 
     	   					"<td align='right' style='padding-right:5px;text-align:right;' colspan='2'>"+     	   						     	   						
     	   						"<button class='btn btn-primary' onclick='javascript:fn_egov_save();return false;'>승인절차 등록</button> "+
	     	   				    "<a class='btn' href='javascript:fn_egov_selectList();'>닫기</a>"+     	   				    
     	   				    "</td>";
    	   	$('#example').append(html2);			
		}else{
			$('#example').empty('tr');
			$('.disseminateStep').hide();
			$(".disseminateDay").hide();
			$('#example').append(html);
		}
	});
	// end 콘텐츠 배포 설정 change function
	
	if( contentConfirm == '0' || contentConfirm == '1' || contentConfirm == '2' || contentConfirm == '5' || contentConfirm == '6' ){
		$('#disseminateTypeComent').empty();			
		$('#disseminateTypeDiv').hide();			
		if(disseminateType == 2){
			$('#disseminateTypeComent').append("<font color='red'>콘텐츠 배포 설정을 변경하실려면 승인절차 재설정 후 다시 지정해주시기 바랍니다.</font>");
		}
		
	}
	if( contentConfirm == '0' || contentConfirm == '2' || contentConfirm == '5' || contentConfirm == '6' ){
		if(disseminateType == 1){			
			$('#disseminateTypeComent').append("<font color='red'>콘텐츠 배포 설정을 변경하실려면 예약취소후 다시 지정해주시기 바랍니다.</font>");
		}	
	}else{
		if(disseminateType == 1){
			$('#disseminateTypeDiv').show();
		}		
	}
	
	//예약날자 설정 click function
	
	/* $(".disseminateDay").click(function(){		
		if(contentConfirm == 0){
			alert('날자 설정을 변경 하실려면 예약취소 후 다시 예약 날자를 지정해주시기 바랍니다.');
			return false;
		}
	});	 */
	//End 예약날자 설정 click function
	
	/* 콘텐츠 미리보기
	$("#tmpView").click(function(e){
		alert($("#jnitcmscntvtVO").serialize());
		alert(document.getElementById("jnitcmscntvtVO"));
		$.ajax({
			type : "post",
			url : "<c:url value='/cms/sub11/temp.do'/>",
			data : document.getElementById("jnitcmscntvtVO")
		}).done(function(data){
			
		});
		
	});
	*/
	
});

function fn_egov_selectmbr(){
	$('#myModalLabel').empty();
	$('#mbrlist').empty();
	$('#mbrSearch').empty();
	$('#myModalLabel').append('관리자 검색');
	$('.modal-footer').empty();
	$('.modal-footer').append("<button class='btn' data-dismiss='modal' aria-hidden='true'>닫기</button>");
	$.ajax({
		type:"post",
		url:"<c:url value="/cms/sub2/0101.do"/>",
		data:"ajax=Y"+"&contentEdit=Y"		
	}).done(function(data){
		$('#mbrSearch').html(data);
	});
	$('.modal').css('width','560px');
	$('.modal').css('margin-left','-280px');
	$('#myModal').modal('toggle');
}

function fn_egov_disseminateHistory(){
	$('#myModalLabel').empty();
	$('#myModalLabel').append('HISTORY 검색');
	$('#mbrSearch').empty();
	$('.modal-footer').empty();
	$('.modal-footer').append("<button class='btn' data-dismiss='modal' aria-hidden='true'>닫기</button>");
	var cntId = "${cntId}";	
	$.ajax({
		type: "POST",
		url: "<c:url value="/disseminate/ajaxHistory.do" />",
		data: "cntId="+cntId
	}).done(function(data){	
		$('#mbrSearch').append(data);
		
	});
	$('.modal').css('width','955px');
	$('.modal').css('margin-left','-480px');	
	$('#myModal').modal('toggle');
}


//

//팝업 닫기
function fn_egov_selectList() {
	self.close();
}
//End 팝업 닫기

function resizeEditor() {
	//$('td.content_1').css('width', $(window).width()-150 );
	$('td.content_1').css('margin-right', '10px');
	$('textarea[name=cntSrc]').css('height', $(window).height()-376 );
	$('iframe#previewFrame').css('width', $(window).width()-15 );
	$('iframe#previewFrame').css('height', $(window).height()-56 );
	//$('.CodeMirror').css('width', $(window).width()-15 );
	$('.CodeMirror').css('height', $(window).height()-386 );
	$('.CodeMirror-scroll').css('height', $(window).height()-386 );
	$('.CodeMirror-scrollbar').css('height', $(window).height()-386 );
}
function editMode() {
	$('#previewArea').hide();
	$('#editArea').show();
	$('#prevLi').removeClass('on');
	$('#editLi').addClass('on');
}

function previewMode() {
	$('#editArea').hide();
	$('#previewArea').show();
	$('#editLi').removeClass('on');
	$('#prevLi').addClass('on');
}

function loadHistory() {
	var msgPop = window.open('<c:url value="/cms/sub7/history.do?prefixSiteId=${siteVO.siteId}&prefixMenuId=${jnitcmscntvtVO.menuId}&prefixCntId=${jnitcmscntvtVO.cntId}"/>', 'HISTORY_WINDOW', 'resizable=yes scrollbars=no width=460 height=500');
}

function Jnit_help(){
	window.open("<c:url value='/cms/help.do'/>","help","resizable=yes scrollbars=yes width=1000 height=850");
}
var tinymce; 
function Jnit_edit(){	
	tinymce = window.open("<c:url value='/edit/tinymce/popupView.do'/>",'tinymce','resizable=yes,scrollbars=yes,width=870,height=720');
	$(".cntSrc").css("display","none");
	$("#cntSrcTextArea").css("display","");
}

var agt = navigator.userAgent.toLowerCase();
function Jnit_editAddProc(){
	var editsrc =$(tinymce.document).find("#Jnit_edit_ifr").contents().find("body").html();
	
	editsrc = Jnit_replaceAll(editsrc,"&lt;!--","<!--");
	editsrc = Jnit_replaceAll(editsrc,"--&gt;","-->");
	editsrc = Jnit_replaceAll(editsrc,"<br>","\n");
	editsrc = Jnit_replaceAll(editsrc,"<BR>","\n");
	editsrc = Jnit_replaceAll(editsrc,"&quot;","\"");
	editsrc = Jnit_replaceAll(editsrc,"&#9;","	");//수평탭
	editsrc = Jnit_replaceAll(editsrc,"&#10;","\n");//줄변환
	
	var elementJSON = [
	                   	{"name":"include","num":"14"}
	                   ,{"name":"attribute","num":"16"}
	                   ,{"name":"body","num":"11"}
	                   ,{"name":"plugin","num":"13"}
	                   ,{"name":"forward","num":"14"}
	                   ,{"name":"getProperty","num":"18"}
	                   ,{"name":"setProperty","num":"18"}
	                   ,{"name":"output","num":"13"}
	                   ,{"name":"useBean","num":"14"}
	                   ,{"name":"fallback","num":"15"}
	                   ,{"name":"params","num":"13"}
	                   ,{"name":"element","num":"14"}
	                   ,{"name":"param","num":"12"}
	                  ];	
	for(var i=0; i<elementJSON.length; i++){
		while(editsrc.indexOf("<img id=\"changeImg"+elementJSON[i].name+"\"") != -1){
			var editSrc = editsrc;
			var altSrc1 = editSrc.substring(editSrc.indexOf("<img id=\"changeImg"+elementJSON[i].name+"\""));
			var altSrc2 = altSrc1.substring(altSrc1.indexOf("<"+"jsp:"+elementJSON[i].name),altSrc1.indexOf("<"+"/jsp:"+elementJSON[i].name+">")+Number(elementJSON[i].num));
			var replaceAltSrc = Jnit_replaceType("2",altSrc2);
			var changeImgAltSrc = altSrc1.replace(altSrc2,replaceAltSrc);
			var beforImgSrc = changeImgAltSrc.substring(changeImgAltSrc.indexOf("<img id=\"changeImg"+elementJSON[i].name+"\""),changeImgAltSrc.indexOf(">")+1);
			var imgSrc = Jnit_replaceType("3",beforImgSrc);
			editsrc = editsrc.replace(imgSrc,altSrc2);
		}
	}
	
	if (agt.indexOf("msie") != -1){
		$("#cntSrc").val(editsrc);
	}else{
		CodeEditor.setValue('');
		CodeEditor.setValue(editsrc);
	}
	tinymce.close();
	$(".cntSrc").css("display","");
}

function insertCntSrc(){
	var cntSrc = "";
	if (agt.indexOf("msie") != -1){
		cntSrc = $("#cntSrc").val();		
	}else{
		cntSrc = CodeEditor.getValue();
	}
	//change 주석
	while(cntSrc.indexOf("<!--") != -1){
		var comment = cntSrc.substring(cntSrc.indexOf("<!--"), cntSrc.indexOf("-->")+3);
		cntSrc = cntSrc.replace(comment,Jnit_replaceType("1",comment));
	}
	
	var elementJSON = [
	                   	{"name":"include","num":"14"}
	                   ,{"name":"attribute","num":"16"}
	                   ,{"name":"body","num":"11"}
	                   ,{"name":"plugin","num":"13"}
	                   ,{"name":"forward","num":"14"}
	                   ,{"name":"getProperty","num":"18"}
	                   ,{"name":"setProperty","num":"18"}
	                   ,{"name":"output","num":"13"}
	                   ,{"name":"useBean","num":"14"}
	                   ,{"name":"fallback","num":"15"}
	                   ,{"name":"params","num":"13"}
	                   ,{"name":"element","num":"14"}
	                   ,{"name":"param","num":"12"}
	                  ];
	var isSrcConfirm = true;
	var errorElement = "";
	for(var i=0; i<elementJSON.length; i++){
		while(cntSrc.indexOf("<"+"jsp:"+elementJSON[i].name) != -1){
			if(cntSrc.indexOf("<"+"jsp:"+elementJSON[i].name) != -1 && cntSrc.indexOf("<"+"/jsp:"+elementJSON[i].name+">") != -1){
				
				var includeSrc = cntSrc.substring(cntSrc.indexOf("<"+"jsp:"+elementJSON[i].name), cntSrc.indexOf("<"+"/jsp:"+elementJSON[i].name+">")+Number(elementJSON[i].num));
				var imgIncludeSrc = "<img id=\"changeImg"+elementJSON[i].name+"\" src='${pageContext.request.contextPath }/resources/img/edit/tinymce/fail_mod_"+elementJSON[i].name+".gif' alt='"+Jnit_replaceType("2",includeSrc)+"' />";
				cntSrc = cntSrc.replace(includeSrc,imgIncludeSrc);
				
			}else{ //열렸는데 없으면
				isSrcConfirm = false;
				errorElement = elementJSON[i].name;
				break;
			}
		}
	}
	if(!isSrcConfirm){		
		alert("현재 : <"+"/jsp:"+errorElement+"> 닫는 태그가 없습니다.\n\n공백없이 기입해주시기 바랍니다.\n\n팝업창을 닫겠습니다.");
		tinymce.close();
	}	
	
	//console.log("cntSrc ======="+cntSrc);
	$(tinymce.document).find("#Jnit_edit_ifr").contents().find("body").empty();
	$(tinymce.document).find("#Jnit_edit_ifr").contents().find("body").html(cntSrc);
}

//replaceAll(문자열,찾을문자,바꿀문자)
function Jnit_replaceAll(str,character,replaceChar){
    var word = str;

    while(word.indexOf(character) != -1)
        word = word.replace(character,replaceChar);

    return word;
}

function Jnit_replaceType(type,src){	
	if(type == "1"){ //주석변환
		src = Jnit_replaceAll(src,"<!--","&lt;!--");
		src = Jnit_replaceAll(src,"-->","--&gt;");
		src = src.replace(/[\r|\n]/g,"<br />"); //줄바꿈
		src +="<br />";
	}else if(type == "2"){//<,>변환
		src = Jnit_replaceAll(src,"<","&lt;");
		src = Jnit_replaceAll(src,">","&gt;");
	}else if(type == "3"){ //lt,gt 변환
		src = Jnit_replaceAll(src,"&lt;","<");
		src = Jnit_replaceAll(src,"&gt;",">");
	}
	return src;
}

function Jnit_editform_question(num){
	var baseId = "JnitEditformQuestion"+num;
	var baseObject = $("#"+baseId);
	var displayState = baseObject.css("display");
	
	if(displayState == "none"){
		baseObject.show();
	}else{
		baseObject.hide();
	}
}
// -->
</script>


<style type="text/css">
body {
	background:none;
	margin:0px;
	padding:5px;
	margin-bottom:0px;
	padding-bottom:0px;
}

ul#tab {
	height:30px;
	margin:0px;
	border-bottom:2px #ccc solid;
	margin-bottom:10px;
}

ul#tab li a {
	font-size:12px;
	font-weight:normal;
	color:#333;
}

ul#tab li {
	width:100px;
	border:1px #ccc solid;
	float:left;
	text-align:center;
	padding-top:5px;
	padding-bottom:5px;
}

ul#tab li.on a {
	font-size:12px;
	font-weight:bold;
	color:#fff;
}

ul#tab li.on {
	background-color:#555555;
}

div#previewArea {
	display:none;
	float:left;
}

td.content_1 {
	padding-right:10px;
}

</style>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<!-- <ul id="tab">
			<li id="editLi" class="on"><a href="#" onclick="editMode();return false;">수정</a></li>
			<li id="prevLi" ><a href="#" onclick="previewMode();return false;">미리보기</a></li>
		</ul> -->
		<!--  <table id="example" width="95%" border="0" cellspacing="0" cellpadding="0" style="margin:10px 0 20px 0;">
            <tr>
                <td colspan="2">
				    <p class="btn">Html 편집</p>
				    <a href="javascript:Jnit_edit();" class="btn">에디터 모드 편집1</a>
				    <a href="javascript:Jnit_help();" class="btn btn-small">소스코드도움말</a>
				    <button class="btn btn-warning" onclick="javascript:fn_egov_save();return false;">즉시배포</button>
				</td>
            </tr>
        </table> -->		
		<div id="editArea">
		<form:form commandName="jnitcmscntvtVO" height="100%" >
		
		<form:hidden path="cntId" />
		<form:hidden path="siteId" />		
		<form:hidden path="menuId" />
		<input type="hidden" id="cancel" name="cancel" />
		<input type="hidden" id="anMemo" name="anMemo" />
		<input type="hidden" id="temporary" name="temporary" />
		
								<div class="ediarea-nav"><c:out value="${menuNames}"/> 수정</div>
		    					<table class="table ediarea-table" width="100%" border="0" cellspacing="0" cellpadding="0">
		                            <tr>
		                            	<th width="120">메뉴 ID</th>
		                            	<td  class="content_1">
		                            		<c:out value="${jnitcmscntvtVO.menuId}" />
		                            		(콘텐츠 코드 : <c:out value="${pageCode}" />)
		                            	</td>
		                            </tr>		                            
		                            <tr>
		                            	<th>콘텐츠 수정일</th>
		                            	<td  class="content_1">
		                            		<c:out value="${modifiedDate}" />
		                            		<a href="javascript:loadHistory();" class="btn btn-default btn-small">콘텐츠 히스토리</a>
		                            	</td>
		                            </tr>
		                            <tr>
		                            	<th>콘텐츠 경로</th>
		                            	<td  class="content_1">
		                            		<c:out value="${menuDirs}"/>
		                            	</td>
		                            </tr>
		                            <tr>
		                            	<th>부제목&nbsp;<a href="javascript:Jnit_editform_question('1');"><i class="icon-question-sign"></i></a></th>
		                            	<td class="content_1">
		                            		<form:textarea path="cntDesc" rows="1" style="width:98%;" /><form:errors path="cntDesc" />
		                            		<span id="JnitEditformQuestion1" style="display: none;">
												<strong>&nbsp;- 서브 템플릿에  {-SUBTITLE-} 치환코드를 넣어주셔야 적용 됩니다.</strong><br />
												<strong>&nbsp;- 치환코드를 넣은 위치에 문구를 넣을수 있습니다.</strong>
											</span>
										</td>
		                            </tr>
		                            <tr>
		                            	<th>적용할 템플릿 선택</th>
		                            	<td class="content_1">
							                <form:select path="tplId" id="tplId" title="서브템플릿" style="width:50%;">
							                    <form:option value=" " label="--서브템플릿 사용안함--"/>
							                    <form:options items="${tplId_result}" itemValue="code" itemLabel="codeNm"/>
							                </form:select>
							                &nbsp;<form:errors path="tplId" /></td>
		                            </tr>		                            		                                         
		                            <tr>
							        	<th>콘텐츠 배포 설정</th>
							        	<td>
							        		<div id="disseminateTypeDiv" style="float: left; margin-right: 10px;">
								        		<select id="disseminateType" name="disseminateType" style="width: 100px; margin-right: 10px;">
								        			<option value="0" selected="selected">즉시</option>
								        			<option value="1">예약설정</option>
								        			<option value="2">승인절차</option>
								        		</select>
							        		</div>
							        		<a href="javascript:fn_egov_disseminateHistory();" class="btn btn-default btn-small">배포 메모</a>
							        		<div id="disseminateTypeComent">
							        		</div>							        		
							        	</td>					        		
							        </tr>		
							        <tr>
							        	<th>퀵 코드삽입</th>
							        	<td><%@ include file="/WEB-INF/jsp/jnit/cms/disseminate/help_code_button.jsp" %></td>
							        </tr>					        						      
							        <tr class="disseminateDay" style="display: none;">
							        	<th>예약 날자 설정</th>
							        	<td>
							        		
							        		<c:if test="${contentConfirm == 0 }">
							        			<c:set var="readonly" value="readonly"/> 
							        		</c:if>
							        		<c:if test="${contentConfirm == 0 }">
							        			<fmt:formatDate var="fmtDay" value="${disseminateDay}" pattern="yyyy-MM-dd"/> 
							        		</c:if>	        		
							        									        								        		
							        		<input type="text" id="disseminateDay" name="disseminateDay" value="${fmtDay }" ${readonly } /><font color="red"> 0시를 기준으로 업데이트 됩니다.</font>							        		
							        	</td>
							        </tr>
							        <c:if test="${contentConfirm == '' || empty disseminateList  }">		
							        <tr class="disseminateStep" style="display: none;">							        	
							        	<th>승인 관리자 리스트</th>
							        	<td>							        		
							        		<a href="javascript:fn_egov_selectmbr();" class="btn btn-small">관리자 등록</a> 
							        		<select multiple="multiple" id="mbrList" name="mbrList">		                		
						                	</select>							        		
							        	</td>
							        </tr>
							        </c:if>
							        
							        <c:if test="${contentConfirm == '0' || contentConfirm == '1' || contentConfirm == '2' || contentConfirm == '5' || contentConfirm == '6'}">							        
							        <tr class="disseminateStep" style="display: none;">
							        	<th>승인 진행 상황</th>
							        	<td>							        		
							        		<c:if test="${!empty disseminateList }">							        			
							        			<c:forEach var="disseminateResult" items="${disseminateList }" varStatus="status" >
							        			
							        				<c:if test="${disseminateResult.disseminateConfirm == '0' }">
							        					<c:set var="btnClass" value="btn btn-warning btn-mini" />
							        					<c:set var="btnresult" value="대기중" />
							        				</c:if>
							        				
							        				<c:if test="${disseminateResult.disseminateConfirm == '1' }">
							        					<c:set var="btnClass" value="btn btn-success btn-mini" />
							        					<c:set var="btnresult" value="승인" />
							        				</c:if>
							        				
							        				<c:if test="${disseminateResult.disseminateConfirm == '2' }">
							        					<c:set var="btnClass" value="btn btn-danger btn-mini" />
							        					<c:set var="btnresult" value="반려" />
							        				</c:if>							        									
							        					        				
							        				<button type="button" class="btn btn-default btn-small">${status.count}.${disseminateResult.mbrNm }
							        				<c:if test="${disseminateResult.posNm  != null && disseminateResult.posNm  != '' }">
							        				(${disseminateResult.posNm }/${disseminateResult.orgNm })
							        				</c:if>
							        				<c:if test="${disseminateResult.posNm  == null && disseminateResult.posNm  == '' && disseminateResult.posNm  != '' && disseminateResult.posNm  != null }">
							        				(${disseminateResult.orgNm })
							        				</c:if>
							        				<c:if test="${disseminateResult.posNm  != null && disseminateResult.posNm  != '' && disseminateResult.posNm  == '' && disseminateResult.posNm  == null }">
							        				(${disseminateResult.posNm })
							        				</c:if>
							        				</button>
							        				<button type="button" class="${btnClass }">${btnresult }</button>&nbsp;&nbsp;<c:if test="${!status.last}">></c:if>
							        											        					
							        			</c:forEach>
							        		</c:if>						        								        		
							        	</td>
							        </tr>	
							        </c:if>
							        <c:if test="${!empty historyMap}">
							        <tr class="disseminateStep" style="display: none;">							        	
							        	<th>${historyMap['historyMbrNm'] } 님의 메모</th>
							        	<td><font color="red">${historyMap['historyMemo'] == '' || historyMap['historyMemo'] == 'null' || historyMap['historyMemo'] == null ? '없음' : historyMap['historyMemo'] }</font></td>							        	
							        </tr>
							        </c:if>							        
							        <c:forEach var="memoList" items="${disseminateList }">
							        <tr class="disseminateStep" style="display: none;">							        	
							        	<th>${memoList.mbrNm } 님의 메모</th>
							        	<td><font color="red">${memoList.dissmeinateMemo == '' || memoList.dissmeinateMemo == null ? '없음' : memoList.dissmeinateMemo }</font></td>							        	
							        </tr>
							        </c:forEach>
		                            <tr class="cntSrc">
		                            	<td colspan="2">
											<c:if test="${contentConfirm == 1 }">
		                            			<c:if test="${disseminateType == 1 }">
		                            				<font color="red">(<fmt:formatDate value="${disseminateDay}" pattern="yyyy-MM-dd"/> 서버에서 예약 배포 적용이 되었습니다.)</font>
		                            			</c:if>
		                            		</c:if>
		                            		<c:if test="${newFileCnt == 'Y'}"><span style="color:red;">(서버에서 변경된 페이지입니다)</span></c:if>
		                            		<c:if test="${notFileCnt == 'Y'}"><span style="color:red;">(파일이 없습니다)</span></c:if>
		                            	</td>
		                            </tr>
									<tr id="example">
										
									</tr>
		                            <tr class="cntSrc">
		                            	<td colspan="2" style="border-top: none;padding-top: 0;">
										    <div class="cntbtn-bar">
											    <b style='display: inline-block;padding: 4px 12px;font-size: 14px;line-height: 19px;vertical-align: middle;'><i class='icon-cog'></i>Html 편집</b>
											    <a href='javascript:Jnit_edit();' class='btn btn-small'><i class='icon-edit'></i> 에디터 모드 편집</a>
											    <a href='javascript:Jnit_help();' class='btn btn-small'><i class='icon-question-sign'></i> 소스코드 도움말</a>
										    </div>
		                            		<form:textarea path="cntSrc" id="cntSrc"  style="width:100%; height:550px;"/><form:errors path="cntSrc" />
		                            	</td>
		                            </tr>
		                            <tr id="cntSrcTextArea" style="display: none;">
		                            	<td colspan="2">
		                            		<font color="red"> * 현재 에디터 모드입니다. 팝업창을 확인해주시기 바랍니다.</font>
		                            	</td>
		                            </tr>
		                        </table>
		   					 <!--콘텐츠끝-->		 
		</form:form>
		
		</div>
		<div id="previewArea">
		
		</div>
		
		<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="myModalLabel"></h3>
		</div>
		<div class="modal-body">
			<div id="mbrSearch"></div>
			<div id="mbrlist">
										
			</div>
			
			<div id="mbrmessage"></div>			
		</div>
		<div class="modal-footer">			
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button class="btn btn-primary">Save changes</button>
		</div>
	</div>
		<%-- Contents End --%>
	</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer_skeleton.jsp" %>