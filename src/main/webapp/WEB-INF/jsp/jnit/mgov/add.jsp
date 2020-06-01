<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script src="<c:url value="/resources/js/jquery.form.js"/> "></script>

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>
<title> <c:out value="${registerFlag}"/> </title>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitcmssmsVO").action = "<c:url value='/cms/smsList.do'/>";
   	document.getElementById("jnitcmssmsVO").submit();		
}

$(document).ready(function(){
	
	$("#messageTitle").attr('placeholder', '메세지 제목 입력해주세요.');
	$("#msgTxt").attr('placeholder', '메세지 내용 입력해주세요.');
	$("#messageTitle").focus();
	
	function byteChk(){
		var messageChk = $("#msgTxt").val().indexOf("[성명]");
		var totalByte = 0;
        var msgTxt = $("#msgTxt").val();
        var type = "";
        var regexSize = "";

        for(var i =0; i < msgTxt.length; i++) {
			var currentByte = msgTxt.charCodeAt(i);
			if(currentByte > 128) totalByte += 2;
			else totalByte++;
        }
        
        if(messageChk != '-1'){
        	regexSize = msgTxt.match(/\[성명\]/g).length;
        	totalByte = Number(totalByte) + Number(regexSize*2);
        }
        
        if(totalByte <= 80){
        	var rgbVal = $("#msgTxt").css("background-color");
        	var val = "rgb(255, 255, 255)";
        	if(rgbVal != val){
        		$("#msgTxt").css("background-color", "white");
        		$("#messageTitle").val("");
        	}
        	type = "SMS";
        }else{
			var rgbVal = $("#msgTxt").css("background-color");
        	var val = "rgb(245, 245, 220)";
        	if(rgbVal != val){
        		$("#msgTxt").css("background-color", "beige");
        		$("#messageTitle").val("");
        	}
        	type = "MMS";
        }
        
        $("#byteCount").empty();
        if(type == 'SMS'){
        	$("#byteCount").append(totalByte+" Byte(<strong style='color: blue;'>"+type+"</strong>)");
        	$(".msgTitle").css("display", "none");
        }else{
        	$("#byteCount").append(totalByte+" Byte(<strong>"+type+"</strong>)");
        	$(".msgTitle").css("display", "block");
        }
        $("#msgByteVal").val(totalByte);
	}
	
	$("#msgTxt").keyup(function(){
		byteChk();
	});
	
	$("#msgTxt").focusout(function(){
		var messageChk = $("#msgTxt").val().indexOf("[성명]");
		var totalByte = 0;
        var msgTxt = $.trim($("#msgTxt").val());
        var type = "";
        var regexSize = "";

        for(var i =0; i < msgTxt.length; i++) {
			var currentByte = msgTxt.charCodeAt(i);
			if(currentByte > 128) totalByte += 2;
			else totalByte++;
        }
        
        if(messageChk != '-1'){
        	regexSize = msgTxt.match(/\[성명\]/g).length;
        	totalByte = Number(totalByte) + Number(regexSize*2);
        }
        
        if(totalByte <= 80){
        	var rgbVal = $("#msgTxt").css("background-color");
        	var val = "rgb(255, 255, 255)";
        	if(rgbVal != val){
        		$("#msgTxt").css("background-color", "white");
        		$("#messageTitle").val("");
        	}
        	type = "SMS";
        }else{
			var rgbVal = $("#msgTxt").css("background-color");
        	var val = "rgb(245, 245, 220)";
        	if(rgbVal != val){
        		$("#msgTxt").css("background-color", "beige");
        		$("#messageTitle").val("");
        	}
        	type = "MMS";
        }
        
        $("#byteCount").empty();
        if(type == 'SMS'){
        	$("#byteCount").append(totalByte+" Byte(<strong style='color: blue;'>"+type+"</strong>)");
        	$(".msgTitle").css("display", "none");
        }else{
        	$("#byteCount").append(totalByte+" Byte(<strong>"+type+"</strong>)");
        	$(".msgTitle").css("display", "block");
        }
        $("#msgByteVal").val(totalByte);
        $("#msgTxt").val(msgTxt);
	});
	
	$("[id*='tel']").keyup(function(){
		
		var chkPhone = "";
		
		var now = $(this).attr('id');
		
		var len1 = $("#tel1").val().length;
		var len2 = $("#tel2").val().length;
		var len3 = $("#tel3").val().length;
		
		if(now == 'tel1'){
			if(len1 == 3){
				chkPhone = $(this).val();
				
				if(chkPhone != '010' && chkPhone != '011' && chkPhone != '016' && chkPhone != '017' && chkPhone != '018' && chkPhone != '019'){
					alert("핸드폰 앞번호를 잘못 입력하셨습니다.");
					$("#tel1").focus();
					return false;
				}
				$("#tel2").focus();
			}
		}
		if(now == 'tel2'){
			if(len2 == 4){
				$("#tel3").focus();
			}
		}
		if(now == 'tel3'){
			if(len3 == 4){
				$("#addPhone").focus();
			}
		}
	});
	
	$("#searchBtn").click(function(e){
		e.preventDefault();

		var upFileChk = $("#upFileChk").val();
		var chk = $("#searchList").attr('class');
		
		if(upFileChk != ""){
			if(!confirm("회원 조회를 하게 되면 엑셀파일 업로드를\n다시 하셔야 합니다.")){
				return false;
			}
		}
		
		$("#excelUpload").removeClass("btn-primary");
		$("#searchBtn").addClass("btn-primary");
		$("#addressbook").removeClass("btn-primary");
		$("#addressbookList").slideUp();
		if(chk == 'span6'){
			$("#searchList").slideDown();
			$("#searchList").addClass('on');
			$("#searchBtn").text("회원조회 닫기");
			$("#searchNm").focus();
		}else{
			$("#searchList").slideUp();
			$("#searchList").removeClass('on');
			$("#searchBtn").removeClass("btn-primary");
			$("#searchBtn").text("회원조회");
			$("#msgTxt").focus();
		}
		
		$("[id*='phoneList']").find("th").slideDown();
		$("[id*='phoneList']").find("td").slideDown();
		$("#excelInput").hide();
		$("#tel1").parent().show();
		
		$("[id*=ctgr]").removeClass('btn-primary');
		$("[id*='sh']").attr('style', 'display:none');
		$("#shNm").attr('style', 'display:block');
		
		$("#ctgrName").addClass('btn-primary');
		
		$("#searchNm").val("");
		$("#searchOrg").val("");
		$("#searchPhone").val("");
		$("#upFileChk").val("");
		$("#upFile").val("");
		$("#excelFileChk").addClass("btn-danger");
		$(".filename").text("선택된 파일 없음");
		$("#addrSendChk").val("");
		
	});
	
	$("#addPhone").click(function(e){
		e.preventDefault();
		
		var chkPhone = $("#tel1").val();
		
		if(chkPhone != '010' && chkPhone != '011' && chkPhone != '016' && chkPhone != '017' && chkPhone != '018' && chkPhone != '019'){
			alert("핸드폰 앞번호를 잘못 입력하셨습니다.");
			$("#tel1").focus();
			return false;
		}
		
		var phone = $("#tel1").val()+"-"+$("#tel2").val()+"-"+$("#tel3").val();
		var name = $("#telNm").val();
		var sizeChk = $("#phoneList option[value='"+phone+','+name+"']").length;
		
		if(sizeChk > 0){
			if(!confirm("중복되는 핸드폰 번호가 존재합니다. (" + phone + ") \n 다시 입력하시겠습니까?")){
				$("#tel1").focus();
				return false;
			}else{
				$("#telNm").attr('value', '');
				$("#tel1").attr('value', '');
				$("#tel2").attr('value', '');
				$("#tel3").attr('value', '');
				$("#telNm").focus();
				return false;
			}
		}else if(name == null || name == ''){
			alert("개별 추가하는 분의 성명을 입력해주세요.");
			$("#telNm").focus();
			return false;
		}
		
		$("#phoneList").append("<option value="+phone+','+name+" selected='selected'>"+phone+"("+name+")</option>");
		$("#phoneList").select2();
		
		$("#telNm").attr('value', '');
		$("#tel1").attr('value', '');
		$("#tel2").attr('value', '');
		$("#tel3").attr('value', '');
		$("#telNm").focus();
	});
	
	$("#phoneRest").click(function(e){
		e.preventDefault();
		
		if(confirm("리스트의 목록을 전부 삭제 하시겠습니까?")){
			$("#phoneList").empty();
			$("#phoneList").select2();
			$("#tel1").focus();
		}
	});
	
	$("#sendMessage").click(function(){
		
		var size = $("#phoneList option[selected='selected']").size();
		var txt = $("#confirm").text();
		var fileChk = $("#upFileChk").val();
		var classNm = $("#excelFileChk").attr("class");
		var chk = classNm.indexOf("btn-danger");
		var upFile = $("#upFile").val();
		var addrSendChk = $("#addrSendChk").val();
		
		if(size < 1 && fileChk == "" && addrSendChk == ""){
			alert("핸드폰 번호를 추가해 주세요.");
			$("#searchBtn").focus();
			return false;
		}
		
		if(fileChk != ""){
			if(upFile == ''){
				alert("엑셀 파일을 올려주세요");
				$("#upFile").focus();
				return false;
			}else if(fileChk != "pass" || chk != -1){
				alert("업로드할 엑셀파일을 검사해주세요. (파일검사 필수)");
				$("#excelFileChk").focus();
				return false;
			}
		}
		
		if(txt == '수정'){
			if(confirm("메세지를 전송하시겠습니까?")){
				var messageTitle = $("#messageTitle").val();
				var msgTxt = $("#msgTxt").val();
				
				<%--
				if(messageTitle == ''){
					alert("메세지 제목을 입력해주세요");
					$("#messageTitle").focus();
					return false;
				}
				--%>
				if(msgTxt == ''){
					alert("메세지 내용을 입력해주세요.");
					$("#msgTxt").focus();
					return false;
				}
				
				
			}else{
				return false;
			}
		}else{
			alert("보내는 사람 번호에 \"확정\"을 눌러주세요.");
			$("#confirm").focus();
			return false;
		}
		
		if($("#addrSendChk").val() == 'Y'){
			
			var addrChkSize = $("[name='chkBox']:checked").length;
			if(addrChkSize < 1){
				alert("주소록에서 체크 박스를 체크해 주세요.");
				return false;
			}
			
			var url ="<c:url value="/cms/mgov/AddrSendMsg.do"/>";
			var toTel = $("#sendTel1").val()+$("#sendTel2").val()+$("#sendTel3").val();
			var msgTxt = $("#msgTxt").val();
			var title = $("#messageTitle").val();
			
			$("#addrMsg").val(msgTxt);
			$("#addrFromTel").val(toTel);
			$("#addrTitle").val(title);
			
			$("#addrSendForm").attr("action",url).submit();
			$("#myModal").modal('show');
			return false;
		}
		$("#myModal").modal('show');
	});
	
	$("[id*=ctgr]").click(function(e){
		e.preventDefault();
		$("[id*=ctgr]").removeClass('btn-primary');
		$(this).addClass('btn-primary');
		
		var choice = $(this).val();
		
		$("[id*='sh']").attr('style', 'display:none');
		
		if(choice == 'name'){
			$("#shNm").attr('style', 'display:block');
			$("#searchOrg").val("");
			$("#searchPhone").val("");
			$("#searchNm").focus();
		}else if(choice == 'org'){
			$("#shOrg").attr('style', 'display:block');
			$("#searchNm").val("");
			$("#searchPhone").val("");
			$("#searchOrg").focus();
		}else if(choice == 'phone'){
			$("#shPhone").attr('style', 'display:block');
			$("#searchNm").val("");
			$("#searchOrg").val("");
			$("#searchPhone").focus();
		}
		
	});
	
	$("#search").click(function(e){
		e.preventDefault();
		
		var searchNm = $("#searchNm").val();
		var searchOrg = $("#searchOrg").val();
		var searchPhone = $("#searchPhone").val();
		
		$.ajax({
			type : "POST",
			url : "<c:url value="/cms/sms/searchAjax.do"/>",
			data : {
				searchNm : searchNm,
				searchOrg : searchOrg,
				searchPhone : searchPhone
			}
		}).done(function(data){
			$("#resultTd").empty();
			$("#resultTd").append(data);
		});
	});
	
	$("#confirm").click(function(e){
		e.preventDefault();
		
		var chkPhone = $("#sendTel1").val();
		var txt = $("#confirm").text();
		
		if(txt == '확정'){
			var sendTel1 = $("#sendTel1").val();
			var sendTel2 = $("#sendTel2").val();
			var sendTel3 = $("#sendTel3").val();
			
			if(sendTel1 == '' || sendTel1 == null){
				alert("보내는 사람 번호를 입력해주세요.");
				$("#sendTel1").focus();
				return false;
			}else if(sendTel2 == '' || sendTel2 == null){
				alert("보내는 사람 번호를 입력해주세요.");
				$("#sendTel2").focus();
				return false;
			}else if(sendTel3 == '' || sendTel3 == null){
				alert("보내는 사람 번호를 입력해주세요.");
				$("#sendTel3").focus();
				return false;
			}
			<%--
			else if(chkPhone != '010' && chkPhone != '011' && chkPhone != '016' && chkPhone != '017' && chkPhone != '018' && chkPhone != '019'){
				alert("핸드폰 앞번호를 잘못 입력하셨습니다.");
				$("#sendTel1").focus();
				return false;
			}
			--%>
			
			$("[id*=sendTel]").attr("readOnly", true);
			$("#confirm").removeClass("btn-danger");
			$("#confirm").text("수정");
			
		}else{
			$("[id*=sendTel]").attr("readOnly", false);
			$("#confirm").addClass("btn-danger");
			$("#confirm").text("확정");
		}
	});
	
	$("[id*='sendTel']").keyup(function(){
		
		
		var now = $(this).attr('id');
		var chkPhone = "";
		
		var len1 = $("#sendTel1").val().length;
		var len2 = $("#sendTel2").val().length;
		var len3 = $("#sendTel3").val().length;
		if(now == 'sendTel1'){
			if(len1 == 3){
				<%--
				chkPhone = $(this).val();
				if(chkPhone != '010' && chkPhone != '011' && chkPhone != '016' && chkPhone != '017' && chkPhone != '018' && chkPhone != '019'){
					alert("핸드폰 앞번호를 잘못 입력하셨습니다.");
					$("#sendTel1").focus();
					return false;
				}
				--%>
				$("#sendTel2").focus();
			}
		}
		if(now == 'sendTel2'){
			if(len2 == 4){
				$("#sendTel3").focus();
			}
		}
		if(now == 'sendTel3'){
			if(len3 == 4){
				$("#confirm").focus();
			}
		}
		
	});
	
	$("#nameAppend").click(function(e){
		e.preventDefault();
		
		var originVal = $("#msgTxt").val();
		var addVal = "[성명]";
		
		$("#msgTxt").val('');
		$("#msgTxt").val(originVal+addVal);
		$("#msgTxt").focus();
		byteChk();
	});
	
	$("#excelUpload").click(function(e){
		e.preventDefault();
		
		var classNm = $("#excelUpload").attr("class");
		var chk = classNm.indexOf("btn-primary");
		if(chk != -1){
			return false;
		}
		
		if(confirm("엑셀 업로드를 하게 되면 기존 리스트의 번호들은 사라집니다.\n그래도 진행하시겠습니까?")){
			$("#excelUpload").addClass("btn-primary");
			$("#searchBtn").removeClass("btn-primary");
			
			$("#phoneList").empty();
			$("#phoneList").select2();
			
			$("#searchList").slideUp();
			$("#searchList").removeClass('on');
			$("#searchBtn").removeClass("btn-primary");
			$("#searchBtn").text("회원조회");

			$("#addressbook").removeClass("btn-primary");
			$("#addressbookList").slideUp();
			
			$("[id*='phoneList']").find("th").slideUp();
			$("[id*='phoneList']").find("td").slideUp();
			$("#tel1").parent().hide();
			$("#excelInput").show();
			$("#addrSendChk").val("");
			$("#upFileChk").val("error");
		}
		<%--
		$("#smsExcelUpload").empty();
		$("#modalOk").empty();
		
		$("#smsExcelUpload").append(
			"<input type='file' id='upFile' name='upFile' />"
		);
		$("#modalOk").append(
			"업로드"
		);
		
		$("#myModal").modal("show");
		--%>
	});
	
	$("#modalOk").click(function(e){
		e.preventDefault();
		$("form#smsExcelUpload").ajaxSubmit({
			success:function(data){
				
				var strChk = data.substring(0,5);
				
				if(strChk == 'ERROR'){
					alert(data);
					return false;
				}else{
					alert("엑셀파일이 검증되었습니다.");
				}
				<%--
				var result = $.parseJSON(data);
				var size = result.length;
				var name = "";
				var phone = "";
				
				$("#loading").show();
				for(var i=0; i<size ; i++){
					if(i % 2 == 0){
						name =  result[i];
					}else{
						phone = result[i];
						$("#phoneList").append("<option value="+phone+','+name+" selected='selected'>"+phone+"("+name+")</option>");
					}
				}
				$("#phoneList").select2();
				--%>
			},
			error: function(){
				alert("엑셀파일에 문제가 발생하였습니다.");
			}
		});
		
		$("#myModal").modal("hide");
	});
	
	$("#excelFileChk").click(function(e){
		e.preventDefault();
		
		var upFile = $("#upFile").val();
		if(upFile == ''){
			alert("업로드 할 파일을 지정해 주세요.");
			return false;
		}
		
		$(document).ajaxStart(function(){
			$("#fileCheckModal").modal("show");
		});
		$("[commandname='jnitsmsmgovVO']").ajaxSubmit({
			url:"<c:url value="/cms/sms/excelUpload.do"/>",
			success:function(data){
				var strChk = data.substring(0,5);
				
				if(strChk == 'ERROR'){
					$("#upFileChk").val("error");
					
					$("#errorModal>.modal-body>p").empty();
					$("#errorModal>.modal-body>p").append(data);
					$("#errorModal").modal('show');
					return false;
				}else{
					$("#upFileChk").val("pass");
					$("#excelFileChk").removeClass("btn-danger");
					$("#fileCompleteModal").modal('show');
				}
			}
		});
		$(document).ajaxStop(function(){
			$("#fileCheckModal").modal("hide");
		});
	});
	
	$("#upFile").click(function(){
		fileCheckReset();
	});
	
	$("#duplicate").click(function(){
		fileCheckReset();
	});
	
	function fileCheckReset(){
		var classNm = $("#excelFileChk").attr("class");
		var chk = classNm.indexOf("btn-danger");
		var fileChk = $("#upFileChk").val(); 
		
		if(chk == "-1" || fileChk == "pass"){
			$("#excelFileChk").addClass("btn-danger");
			$("#upFileChk").val("error");
		}
	}
	
	$("#addressbook").click(function(e){
		e.preventDefault();
		
		if($("#chkBoxAll").text() == ''){
			$.ajax({
				type:"post",
				url:"<c:url value="/cms/mgov/addrAjax.do" />",
				success:function(data){
					$("#ajax").empty();
					$("#ajax").append(data);
					$("#grpTypeAdd").remove();
					$("#grpTypeDel").remove();
				}
			});
		}
		
		var showChk = $("#addressbookList").css("display");
		if(showChk == 'block'){
			$("#addressbook").removeClass("btn-primary");
			$("#addressbookList").slideUp();
			$("#addrSendChk").val("");
		}else{
			if(confirm("엑셀 업로드를 하게 되면 기존 리스트의 번호들은 사라집니다.\n그래도 진행하시겠습니까?")){
				$("#addressbook").addClass("btn-primary");
				$("#addressbookList").slideDown();
				$("#excelUpload").removeClass("btn-primary");
				$("#searchBtn").removeClass("btn-primary");
				$("#searchList").slideUp();
				$("#searchList").removeClass('on');
				$("#searchBtn").removeClass("btn-primary");
				$("#searchBtn").text("회원조회");
				$("#upFileChk").val("");
				$("#upFile").val("");
				$("#excelFileChk").addClass("btn-danger");
				$(".filename").text("선택된 파일 없음");
				$("[id*='phoneList']").find("th").slideUp();
				$("[id*='phoneList']").find("td").slideUp();
				$("#phoneList").empty();
				$("#phoneList").select2();
				$("#excelInput").hide();
				$("#tel1").parent().hide();
				$("#upFileChk").val("");
				$("#addrSendChk").val("Y");
			}
		}
		
	});
	
	$("#seoPhoneNum").on("click", function(e){
		e.preventDefault();
		
		$("#sendTel1").val("070");
		$("#sendTel2").val("4212");
		$("#sendTel3").val("4155");
		$("#confirm").click();
	});
	
	$("#grpType").on("change", function(e){
		e.preventDefault();
		
		var thisVal = $(this).val();
		$.ajax({
			type:"post",
			url:"<c:url value="/cms/mgov/addrAjax.do" />",
			data:{
				grpId:thisVal
			},
			success:function(data){
				$("#ajax").empty();
				$("#ajax").append(data);
			},
			failed:function(){
				alert("조회 실패");
			}
		});
	});
	
});
// -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
       	<div class="row-fluid">
           	<div class="span6" id="sendList">
               	<div class="widget-box">
					<div class="widget-content nopadding">
						<form commandName="jnitsmsmgovVO" action="<c:url value="/cms/sms/addProc.do" />" method="post" enctype="multipart/form-data" >
						<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
						<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input type="hidden" id="msgByteVal" name="msgByteVal" />
						<input type="hidden" id="upFileChk" name="upFileChk" />
						<input type="hidden" id="addrSendChk" name="addrSendChk" />
						<c:if test="${registerFlag == '수정'}">
							<input type="hidden" name="screenMode" value="up" />
						</c:if>
						<c:if test="${registerFlag == '등록'}">
							<input type="hidden" name="screenMode" value="" />
						</c:if>
							<table class="table table-bordered table-striped th_left" summary="sms 테이블" align="center">
								<tbody>
									<%--		
									<tr>
										<th>보내는 사람</th>
										<td>
											<form:input path="sentnm" />
											&nbsp;<form:errors path="sentnm" />
										</td>
									</tr>
									<tr>
										<th>받는사람 ID</th>
										<td>
											<form:input path="receiveid" />
											&nbsp;<form:errors path="receiveid" />
										</td>
									</tr>
									<tr>
										<th>받는사람 이름</th>
										<td>
											<form:input path="receivenm" />
											&nbsp;<form:errors path="receivenm" />
										</td>
									</tr>
									<tr>
										<th>받는사람 부서</th>
										<td>
											<form:input path="department" />
											&nbsp;<form:errors path="department" />
										</td>
									</tr>
									--%>
									<tr>
										<th>메세지 내용</th>
									</tr>
									<tr class="msgTitle" style="display: none;">
										<td>
											<input type="text" id="messageTitle" name="messageTitle" maxlength="15" style="width: 200%;" />
										</td>
									</tr>
									<tr>
										<td>
											<textarea id="msgTxt" name="msgTxt" style="width: 97%; height: 110px;" ></textarea>
											<p id="byteCount"></p>
											<button class="btn btn-mini" id="nameAppend">성명 추가</button>
											※ 모든 사람의 이름을 보낼때 <strong stule="black;">&quot;[성명]&quot;은(8Byte로 취급)</strong>을 넣어주세요.&nbsp;&nbsp;<a href="<c:url value="/excelSample/excelSample.xlsx"/>" class="btn btn-mini" target="_blank" title="다운로드" style="float: right;">엑셀 다운로드</a>
										</td>
									</tr>
									<tr>
										<td>
											<button id="searchBtn" class="btn" style="width: 33%; float:left;">회원 조회</button>
											<button id="excelUpload" class="btn" style="width: 33%; float: left;">엑셀 업로드</button>
											<button id="addressbook" class="btn" style="width: 33%;">주소록</button>
										</td>
									</tr>
									<tr id="phoneList01">
										<th>메세지 전송 리스트</th>
									</tr>
									<tr id="phoneList02">
										<td>
											<div style="width: 100%; height: 200px; overflow-y: scroll;">
											<select multiple="multiple" id="phoneList" name="phoneList" style="width: 100%;">
												
											</select>
											</div>
											<button class="btn" id="phoneRest">리스트 초기화</button>
										</td>
									</tr>
									<tr id="excelInput" style="display: none;">
										<td>
											<font>엑셀 파일 업로드 :</font> 
											<input type="file" id="upFile" name="upFile" />
											<input type="checkbox" id="duplicate" name="duplicate" value="Y"/><font><strong style="color: black;">중복체크</strong></font>
											<button id="excelFileChk" class="btn btn-small btn-danger" style="float: right;">파일 검사</button>
										</td>
									</tr>
									<tr>
										<td>
											<font><strong>(개별 추가)</strong></font><br />
											&nbsp;<font>성명 : </font><input type="text" id="telNm" name="telNm" style="width: 15%;"/>
											&nbsp;&nbsp;&nbsp;<font>핸드폰 번호 : </font>
											<input type="text" id="tel1" name="tel1" maxlength="3" style="width: 30px;" />
											_ <input type="text" id="tel2" name="tel2" maxlength="4" style="width: 40px;" />
											_ <input type="text" id="tel3" name="tel3" maxlength="4" style="width: 40px;" />
											<button class="btn" id="addPhone">추가</button>
										</td>
									</tr>
									<tr>
										<td><font>보내는 사람 :</font> 
											<input type="text" id="sendTel1" name="sendTel1" maxlength="3" style="width: 30px;" />
											_ <input type="text" id="sendTel2" name="sendTel2" maxlength="4" style="width: 40px;" />
											_ <input type="text" id="sendTel3" name="sendTel3" maxlength="4" style="width: 40px;" />
											<button class="btn btn-danger" id="confirm">확정</button>
											<button class="btn btn-small" id="seoPhoneNum" name="seoPhoneNum" style="float: right;">퀵 번호</button>
										</td>
									</tr>
									<tr>
										<td>
											<button class="btn" id="sendMessage"> 전송 </button>
										</td>
									</tr>
								</tbody>
							</table>
						</form>
					</div>
				</div>
			</div>
			<div class="span6" id="searchList" style="display:none;">
				<div class="widget-box">
					<div class="widget-content nopadding">
						<form>
						<table class="table table-bordered table-striped th_left" summary="sms 테이블" align="center">
							<tbody>
								<tr>
									<th>회원 조회 <br />
										<strong>!!</strong>&nbsp;핸드폰 앞번호가 <strong>010, 011, 016, 017, 018, 019</strong>를 제외한 번호는 리스트에 나오지 않습니다.
									</th>
								</tr>
								<tr>
									<td>
										<%--
										<select id="ctgr" name="ctgr" style="width: 150px;">
											<option value="name">성명</option>
											<option value="org">부서</option>
											<option value="phone">전화번호</option>
										</select>
										--%>
										<button class="btn btn-primary" id="ctgrName" value="name">성명</button>
										<button class="btn" id="ctgrOrg" value="org">부서</button>
										<button class="btn" id="ctgrPhone" value="phone">전화번호</button>
									</td>
								</tr>
								<tr>
									<td id="shNm" style="display: block;">
										<font>성명 : </font><input type="text" id="searchNm" name="searchNm" style="width: 150px;" /> &nbsp;&nbsp;<font>Ex) 홍길동</font>
									</td>
									<td id="shOrg" style="display: none;">
										<font>부서 : </font><input type="text" id="searchOrg" name="searchOrg" style="width: 150px;" /> &nbsp;&nbsp;<font>Ex) 기타</font>
									</td>
									<td id="shPhone" style="display: none;">
										<font>전화번호 : </font><input type="text" id="searchPhone" name="searchPhone" style="width: 150px;" /> &nbsp;&nbsp;<font>Ex) 1234 or 6789</font>
									</td>
								</tr>
								<tr>
									<td>
										<button id="search" class="btn" style="width: 100%;">검색</button>
									</td>
								</tr>
								<tr id="resultTr">
									<td id="resultTd">
										
									</td>
								</tr>
							</tbody>
						</table>
						</form>
					</div>
				</div>
			</div>
			<div id="addressbookList" class="span6" style="display: none;">
				<form id="addrSendForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="addrFromTel" name="addrFromTel" />
				<input type="hidden" id="addrMsg" name="addrMsg" />
				<input type="hidden" id="addrTitle" name="addrTitle" />
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>SMS 주소록 테이블<font id="addrCount"></font></h3>
	                    </div>
	                    <div class="widget-title">
	                    	<h3>주소록 유형</h3>
	                    	<select id="grpType" name="grpType">
	                    		<option value=" ">선택해주세요.</option>
	                    		<c:forEach var="result" items="${grpList}" varStatus="status">
		                    		<option value="${result.grpId}">${result.grpNm}</option>
		                    	</c:forEach>
	                    	</select>
	                    	<button class="btn btn-small" id="grpTypeDel" name="grpTypeDel" style="float: right;">유형 삭제</button>
	                    	<button id="grpTypeAdd" class="btn btn-small" style="float: right; margin-right: 10px;">유형 추가</button>
	                    </div>
	                    <div style="height: 605px; overflow-y:scroll;" >
		                    <div id="ajax" class="widget-content nopadding">
		                    
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-body">
        <img alt="loading" src="<c:out value="/images/loading03.gif"/> " style="width: 200px; margin-left: 30%"/><br />
        <font style="text-align: center; margin-left:34%;">메세지 전송 중입니다.</font><br /><br /><br />
        <strong style="color: black; text-align: center; margin-left: 20%;">완료 후 SMS 전송 내역 페이지로 이동 됩니다.</strong><br />
        <strong style="color: red; text-align: center; margin-left: 20%;">※ 강제로 종료하게 되면 문제가 발생합니다.</strong>
    </div>
</div>
<div id="fileCheckModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-body">
        <img alt="loading" src="<c:out value="/images/loading03.gif"/> " style="width: 200px; margin-left: 30%"/><br />
        <font style="text-align: center; margin-left:34%;">파일 검사중 입니다.</font><br /><br /><br />
    </div>
</div>
<div id="fileCompleteModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	    <h3>엑셀파일 검증 완료<font style="float: right;">(닫기 : x 또는 ESC)</font></h3>
	</div>
    <div class="modal-body">
        <font style="text-align: center; margin-left:34%;"><strong>엑셀파일이 검증되었습니다.</strong></font><br /><br /><br />
    </div>
</div>
<div id="errorModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-header">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	    <h3>엑셀파일 핸드폰 번호 중복 리스트<font style="float: right;">(닫기 : x 또는 ESC)</font></h3>
	</div>
	<div class="modal-body">
	    <p style="marin-left: 15%;"></p>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>