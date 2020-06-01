<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="<c:url value="/resources/js/jquery.form.js"/> "></script>
<script type="text/javascript">
<!--
$(document).ready(function(){
	$('input[type=checkbox],input[type=radio],input[type=file]').uniform();
	$('select[class!="noSelect2"]').select2();
    $('.colorpicker').colorpicker();
    $('.datepicker').datepicker();
    
});

function duplicationChk(){
	
	var url = "<c:url value='/cms/sub10/duplicationChk.do' />";
	
	var dupRetVal = $.ajax({
		type:"post",
		url:url,
		data:$("#jnitcmsmenuVO").serialize(),
		async: false
	}).done(function(data){
		if(data == 'true'){
			return 'true';
		}else{
			return 'false';
		}
	});

	return dupRetVal.responseText;
} 

/* 글 등록 function */
function fn_egov_save() {
	frm = document.getElementById("jnitcmsmenuVO");
	frm.action = "<c:url value='/cms/sub10/0101editDetail.do'/>";
	
	$("form#jnitcmsmenuVO").ajaxSubmit({
		success:function(data){
		var result = $.parseJSON($.trim(data));
		if(result.process == 'false'){
			alert(result.msg);	
		}else{
		    var	formUrl = "<c:url value="/cms/sub10/0101editForm.do" />";
			$.ajax({
				  type: "POST",
				  url: formUrl,
				  data: {
					  menuId: '${jnitcmsmenuVO.menuId}'
				  },
				  success: function(msg) {
					// $("div#attrEditor").html(msg);
					 alert("적용되었습니다. 빌드를 실행하여야 정상 적용됩니다.");
					 //window.location.href=window.location.href;
					 location.reload();
				  },
				  error: function(msg) {
					  $("div#attrEditor").html("<h2>로딩 실패! (Error Code: "+ msg.status +")</h2>");
				  }
			    });
			}
		}
	});
	
	/*
	$.ajax({
		  type: "POST",
		  url: frm.action,
		  data: $("form#jnitcmsmenuVO").serialize(),
		  success:function(data) {
			$("div#attrEditor").html(data);
		  },
		  error:function(result) {
			//alert(result);
		  }
	});
	return false;
	*/
    
}

function fn_edit(cntId) {
	var msg = window.open('<c:url value="/cms/sub11/0101upview.do?cntId="/>'+cntId,'editWindow','width=1000,height=750,scrollbars=yes,resizable=yes');
}

function fn_save() {
	
	if(duplicationChk() == 'true'){
		alert("메뉴명 앞자리가 중복 됩니다.");
		return false;
	}else{
		var msg = fn_egov_save();
	}
}

function open_mbrSearch(type) {
	/* if($("div#mbrSearch").css("display") == "none") {
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
	} */	
	$("#mbrSearch").empty();
	$.ajax({
		type : "POST",
		url : "<c:url value='/cms/sub2/0101.do'/>?ajax=Y&contentEdit=adm"+type,
		data : ""
	}).done(function(data){		
		$("#mbrSearch").append(data);
		$('#myModal').modal('toggle');
	});	
}

$(document).ready(function(){
	
	<c:if test="${success == 'true'}">
	reloadDanaTree();
	</c:if>
	
	<c:if test="${jnitcmsmenuVO.islink == 1}">
	$('table#linkOpt').show();
	</c:if>
	
	<c:if test="${jnitcmsmenuVO.iscnt == 0}">
		$('input#menuPath').alphanumeric();
		//$('input#sitePath').css('ime-mode', 'enabled');
		$('input#menuPath').live("blur keyup", function() {
		  if($(this).val().search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/) > -1) {
			$('input#menuPath').val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '') );
			$('span#menuPathMsg').html("폴더명은 영문/숫자만 입력가능합니다.").fadeIn('slow').fadeTo(3000,0);
		  }
		});
	</c:if>
	$('div.view').css('height',$(window).height()-$('ul.view_content_btn').height()-13);
});

var linkUrlOptOpen = function() {
	var node = getActNode();
	var childNodeCount = 0;
	try{
		childNodeCount = node.childList.length;
	}catch(e) {
		//
	}
	if(childNodeCount > 0) {
		alert("하위메뉴가 존재하므로, 링크URL을 사용할 수 없습니다.");
		$('input#islink1').attr("checked", true);
		return false;
	}
	//$('table#linkOpt').show();	
	$(".islinkOpen").stop().fadeIn('fast');
	//$(".islinkOpen").effect("highlight",function(){$(".islinkOpen").stop();},1000);
}
var linkUrlOptClose = function() {
	//$('table#linkOpt').hide();
	//$(".islinkOpen").css("display","none");
	$(".islinkOpen").stop().fadeOut('fast');
}

var editContent = function() {
	alert('준비중');
}

/* $('#myModal').on('hide', function () {
	$("div#mbrSearch").hide();
	}); */
	
	
// -->
$(document).ready(function(){
	var cclYn = "${cclVal}";
	
	if(cclYn == '0'){
		$('.cclSelectView').hide();
		$("[id*='cclChange']").attr('checked', false);
		$("[id*='cclProfit']").attr('checked', false);
	}
	$('#cclYn0').click(function(){
		$('.cclSelectView').hide();
		$('.cclSelectView').hide();
		$("[id*='cclChange']").attr('checked', false);
		$("[id*='cclProfit']").attr('checked', false);
	});
	$('#cclYn1').click(function(){
		$("[id*='cclChange']").parent().removeClass();
		$("[id*='cclProfit']").parent().removeClass();
		$("#cclChange0").parent().addClass('checked');
		$("#cclChange0").attr('checked', true);
		$("#cclProfit0").parent().addClass('checked');
		$("#cclProfit0").attr('checked', true);
		$('.cclSelectView').show();
	});
});

function initDanaCopyTree(){
	 // --- Initialize first Dynatree -------------------------------------------
	 $("#modalBody").dynatree({
	   initAjax: {
	     url: "<c:url value="/cms/sub10/0101getModalJson.do"/>"
	   },
	   autoCollapse: false,
	   clickFolderMode: 1,
	   persist: true,
	   onActivate: function(node) {
	     $("#echoActivated").text(node.data.title + ", key=" + node.data.key);
	   },
	   onClick: function(node, event) {
	     // Close menu on click
	     if(node.data.isFolder == true) {
//	   	  return false;
	     }
	     if( $(".contextMenu:visible").length > 0 ){
	       $(".contextMenu").hide();
//	       return false;
	     }
	     $("#copyMenu").val(loadEditorCopyForm(node));
	   }
	 });
}
function initDanaCopyTree2(){
	// --- Initialize first Dynatree -------------------------------------------
	$("#modalBody").dynatree({
		initAjax: {
			url: "<c:url value="/cms/sub10/0101getModalJson.do"/>"
		},
		autoCollapse: false,
		clickFolderMode: 1,
		persist: true,
		onActivate: function(node) {
			
		},
		onClick: function(node, event) {
			// Close menu on click
			if(node.data.isFolder == true) {
			}
			if( $(".contextMenu:visible").length > 0 ){
				$(".contextMenu").hide();
			}
			$("#copyMenu").val('');
			$("#copyDepth").val('');
			if(node.data.menudepth !== undefined){
				$("#copyMenu").val(node.data.menuid);
				$("#copyDepth").val(node.data.menudepth);
			}else{
				$("#copyDepth").val('default');
			}
		}
	});
}
var loadEditorCopyForm = function(node) {
	return node.data.menuid;	
}

function fn_adm_cancel(){
	if(confirm("관리자 설정을 취소 하시겠습니까?")){
		document.getElementById("jnitcmsmenuVO").action = "<c:url value='/cms/sub10/adm/cancel.do' />";
		document.getElementById("jnitcmsmenuVO").submit();
	}
}

function webStandard(cntId,url,type){		
	$("#url").val(url);
	$("#cntId").val(cntId);
	$("#type").val(type);
	$("#host").val(window.location.protocol + "//" + window.location.host);
	var title;
	var message = "";
	if(type == 'except'){
		title = '평가제외중';		
	}else if(type == 'restore'){
		title = '평가복구중';
	}else {
		title = '평가진행중';
		message = "- css평가시 30초 소요 -";
	}
	var $pJquery = window.parent.$;	
	var dialog = '<div id="dialog" title="'+title+'" style="text-align:center;"><br />'+message+'<br /><img src="<c:url value="/images/loading01.gif"/>" /><br /><font color="red">잠시 하던 일을 중단해 주시기 바랍니다.</font></div>';
	if($pJquery('#dialog').length>0){
		$pJquery('#dialog').remove();
	}
	$pJquery('body').append(dialog);
	$pJquery('#dialog').dialog({
		modal: true,
		close: function( event, ui ) {
			$pJquery(this).dialog('destroy').remove();
		}
	});
	$.ajax({
		type:"POST",
		url:"<c:url value='/cms/sub8/webStandard.do'/>",
		data: $('#jnitcmsmenuVO').serialize()
	}).done(function(data){		
		var json = JSON.parse(data);		
		if(json.status == 'success'){
			$pJquery('#dialog').dialog("destroy");
			alert(json.message);
			/*
			document.getElementById("jnitcmsmenuVO").action = "<c:url value='/cms/sub10/0101editForm.do?success=true&menuId=${cntVO.menuId}'/>";
		   	document.getElementById("jnitcmsmenuVO").submit();
		   	*/
		   	location.reload();
		}else if(json.status == 'error'){
			$pJquery('#dialog').dialog("destroy");
			alert(json.message);
			/*
			document.getElementById("jnitcmsmenuVO").action = "<c:url value='/cms/sub10/0101editForm.do?success=true&menuId=${cntVO.menuId}'/>";
		   	document.getElementById("jnitcmsmenuVO").submit();
		   	*/
			location.reload();
		}
	});
}

//meta 접기,열기
function Jnit_handingClose(){	
	if($("#meta").attr("rowspan") == '8'){
		$("#metaBtn").empty();
		$("#metaBtn").append("열기");
		$(".meta").css("display","none");
		$("#meta").attr("rowspan","1");
		$("#meta").attr("colspan","3");
	}else{
		$("#metaBtn").empty();
		$("#metaBtn").append("접기");
		$(".meta").css("display","");
		$("#meta").attr("rowspan","8");
		$("#meta").attr("colspan","1");
	}	
}

//도움말
function Jnit_help(num){	
	if($("#menuHelp"+num).css("display") == "none"){
		$("#menuHelp"+num).css("display","");
	}else{
		$("#menuHelp"+num).css("display","none");
	}
}

function Jnit_menuCopy(){
	if(confirm($("#menuNm").val()+" 복사 하시겠습니까?")){
		Jnit_modalDefault();
		var headHtml = "폴더를 복사할 폴더를 클릭하고 <strong style='color: blue;'>\"선택\"</strong>을 눌러주세요.";
		var footerHtml = ""
						+ "<strong style='float: left; margin-top: 4px;'>"
							+ "복사할 폴더 명 변경: "
						+ "</strong>&nbsp;"
						+ "<input type='text' id='copyNm' name='copyNm' style='float: left; width: 200px; margin-left: 5px;' />"
						+ '<a href="javascript:Jnit_menuCopyProc();" class="btn">선택</a>';
		var originMenu = $("#menuId").val();
		var originPid = $("#pid").val();
		
		$("#originMenu").val(originMenu);
		$("#originPid").val(originPid);
		
		initDanaCopyTree2();
		$("#myModalLabel").append(headHtml);
		$("#modalFooter").append(footerHtml);
		$('#menuModal').modal({keyboard: false}, {backdrop: false},'show');		
	}
}

function Jnit_menuCopyProc_bln(){
	var copyNm = $("#copyNm").val();
	
	if(copyNm == "" || copyNm == null){
		alert("복사될 폴더명을 입력해주시기 바랍니다.");
		return false;
	}
	console.log(copyNm.match(/^[a-zA-Z0-9]+$/));
	return true;
}
function Jnit_menuCopyProc(){
	
	var originMenu = $("#originMenu").val();
	var originDepth = $("#depth").val();
	var copyDepth = $("#copyDepth").val();
	var copyMenu = $("#copyMenu").val();
	var copyNm = $("#copyNm").val();
	
	var $pJquery = window.parent.$;	
	var dialog = '<div id="dialog" title="폴더 복사중" style="text-align:center;"><br />- 2분 ~ 3분 소요 -<br /><img src="<c:url value="/images/loading01.gif"/>" /><br /><font color="red">잠시 하던 일을 중단해 주시기 바랍니다.</font></div>';
	if($pJquery('#dialog').length>0){
		$pJquery('#dialog').remove();
	}
	$pJquery('body').append(dialog);
	$pJquery('#dialog').dialog({
		modal: true,
		close: function( event, ui ) {
			$pJquery(this).dialog('destroy').remove();
		}
	});
	
	if(Jnit_menuCopyProc_bln()){
		$.ajax({
			type : "post",
			data : "",
			url : "<c:url value='/cms/sub10/menuCopy/proc.do'/>?menuId="+originMenu+"&isDepth="+originDepth+"&targetMenu="+copyMenu+"&targetDepth="+copyDepth+"&targetNm="+copyNm
		}).done(function(data){
			var json = JSON.parse(data);
			if(json.status == "success"){
				alert("복사되었습니다.");
				$pJquery('#dialog').dialog("destroy");
				$('#myModal').modal('toggle');
				location.reload();
			}else{
				if(json.message != ""){
					if(json.message == "FAIL 1"){
						alert("선택하신 실제 경로의 대상이 없습니다. 빌드해주시기 바랍니다.");
					}else if(json.message == "FAIL 2"){
						alert("지경된 경로에 같은 이름의 폴더가 존재합니다.");
					}else if(json.message == "FAIL 3"){
						alert("폴더복사가 진행중입니다. 2~3분 뒤에 다시 시도해주시기 바랍니다.");
					}else{
						alert(json.message);
					}
				}else{
					alert("오류가 생겼습니다.");
				}
			}
		});		
	}	
}

function Jnit_modalDefault(){
	$("#myModalLabel").empty();
	$("#modalFooter").empty();
}

function menuChoice(){
	var originMenu =  $("#originMenu").val();
	var copyMenu = $("#copyMenu").val();
	var copyNm = $("#copyNm").val();
	
	if(copyMenu == null || copyMenu == ''){
		alert("복사할 폴더를 선택해 주세요.");
		return false;
	}
	$('#menuModal').modal('hide');
	location.href="<c:url value="/cms/sub11/cntCopy.do"/>?originMenu="+originMenu+"&copyMenu="+copyMenu+"&copyNm="+copyNm;
}

$(document).ready(function(){
	$("#menuShow").click(function(e){
		e.preventDefault();
		Jnit_modalDefault();
		var headHtml = "컨텐츠를 복사할 폴더를 클릭하고 \"선택\"을 눌러주세요.";
		var footerHtml = ""
						+ "<strong style='float: left; margin-top: 4px;'>"
							+ "복사할 컨텐츠 명 변경: "
						+ "</strong>&nbsp;"
						+ "<input type='text' id='copyNm' name='copyNm' style='float: left; width: 200px; margin-left: 5px;' />"
						+ "<a href=\"javascript:menuChoice();\" class='btn btn-primary' >선택</a>";
		var originMenu = $("#menuId").val();
		var originPid = $("#pid").val();
		
		$("#originMenu").val(originMenu);
		$("#originPid").val(originPid);
		
		initDanaCopyTree();
		$("#myModalLabel").append(headHtml);
		$("#modalFooter").append(footerHtml);
		$('#menuModal').modal({keyboard: false}, {backdrop: false},'show');
	});
	
	if($("#islink0").is(":checked")){		
		$(".islinkOpen").css("display","");
	}
	
	//메뉴제목 keyup
	$("#menuNm").keyup(function(){
		$("#metaTitle").val($(this).val());
	});
	
});
// -->
</script>

<style>
	table.content2_table th{text-align:left;padding-left:8px;}
	table.content2_table td{padding-left:10px;}
	table.content2_table table td{padding-left:0;}
</style>