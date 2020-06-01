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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>팝업-sms</title>
<meta http-equiv="X-UA-Compatible" content="IE=8,9,10">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="<c:url value="/resources/js/jquery.min.js"/> "></script>
<script src="<c:url value="/resources/js/jquery.form.js"/> "></script>
<link type="text/css" href="<c:url value="/resources/css/sms/jnit_base.css" />" media='all' rel='stylesheet' />
<link type="text/css" href="<c:url value="/resources/css/sms/jnit_sms.css" />" media='all' rel='stylesheet' />
<script type="text/javascript">
<!--

$(document).ready(function(){
	/*
	$.ajax({
		type:"post",
		url:"<c:url value="/cms/sms/addressbookAjax.do"/>",
		success:function(data){
			$("#ajax").empty();
			$("#ajax").append(data);
		}
	});
	*/
	
	$("#grpTypeAdd").on("click", function(e){
		e.preventDefault();
		var grpClass =  $("#grpTypeAddDiv").attr("class");
		if(grpClass.indexOf("on") != -1){
			$("#grpTypeAddDiv").removeClass("on");
			$("#grpTypeAddDiv").hide();
		}else{
			$("#grpTypeAddDiv").addClass("on");
			$("#grpTypeAddDiv").show();
		}
	});
	
	$("#grpAdd").on("click", function(e){
		e.preventDefault();
		
		var grpNm = $("#grpNm").val();
		$.ajax({
			type:"post",
			url:"<c:url value="/cms/mgov/addrGrpAdd.do"/>",
			data:{
				grpNm:grpNm
			},
			success:function(data){
				window.location.href=window.location.href;
			},
			failed:function(){
				alert("주소록 유형 생성 실패");
			}
		});
	});
	
	$("#grpTypeDel").on("click", function(e){
		e.preventDefault();
		
		var grpId = $.trim($("#grpType").val());
		
		if(grpId == ''){
			alert("주소록 유형을 선택해주세요.");
			return false;
		}
		$.ajax({
			type:"post",
			url:"<c:url value="/cms/mgov/addrGrpDel.do"/>",
			data:{
				grpId:grpId
			},
			success:function(data){
				if(data == 'success'){
					window.location.href=window.location.href;
				}else if(data == 'failed'){
					alert("주소록의 데이터를 모두 삭제후에 그룹을 제거해주세요.");
				}
			},
			failed:function(){
				alert("삭제 실패");
			}
		});
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
	
	
	$("#addrDel").click(function(e){
		e.preventDefault();
		
		var chk = $("[name='chkBox']").is(":checked");
		
		if(chk == true){
			if(confirm("해당 번호를 삭제 하시겠습니까?")){
				var url = "<c:url value="/cms/mgov/addrDelProc.do"/>";
				$("#listForm").attr("action", url).submit();
			}
		}else{
			alert("삭제할 번호를 선택해 주세요.");
		}
	});
	
	$("#individualAdd").click(function(e){
		e.preventDefault();

		var tel1 = $("#tel1").val();
		var tel2 = $("#tel2").val();
		var tel3 = $("#tel3").val();
		var nameVal = $("#addrNm").val();
		
		if(nameVal == ''){
			alert("이름을 입력해주세요.");
			$("#addrNm").focus();
			return false;
		}else if(tel1 == ''){
			alert("번호를 입력해주세요.");
			$("#tel1").focus();
			return false;
		}else if(tel2 == ''){
			alert("번호를 입력해주세요.");
			$("#tel2").focus();
			return false;
		}else if(tel3 == ''){
			alert("번호를 입력해주세요.");
			$("#tel3").focus();
			return false;
		}

		var addrPhone = tel1+tel2+tel3;
		$("#addrPhone").val(addrPhone);
		var val = "";
		var thisVal = addrPhone;
		var grpId = $.trim($("#grpType").val());
		var frontNum = thisVal.substring(0,3);
		var frontNumOk = new Array("010","011","016","017","018","019");
		
		var chk = true;
		var frontNumChk = false;
		
		var regexNm = /^[a-zA-Z가-힣 ]+$/;
		var regexNum = /^[0-9]+$/;
		var regexNumLength = /^[0-9]{10,11}$/;
		
		if(thisVal == ''){
			alert("핸드폰 번호를 입력해주세요.");
			$("#addrPhone").focus();
			return false;
		}else if(grpId == ''){
			alert("주소록 유형을 선택해주세요.");
			$("#grpType").focus();
			return false;
		}
		
		if(!nameVal.match(regexNm)){
			alert("성명란에 문자만 입력 가능 합니다.");
			$("#addrNm").focus();
			return false;
		}else if(!thisVal.match(regexNum)){
			alert("핸드폰 번호 입력시 숫자만 입력 가능 합니다.");
			$("#addrPhone").focus();
			return false;
		}else if(!thisVal.match(regexNumLength)){
			alert("핸드폰 번호 자릿수 10~11까지 가능 합니다.\n현재 자릿수 : "+thisVal.length);
			$("#addrPhone").focus();
			return false;
		}
		
		for(var i=0; i<frontNumOk.length; i++){
			if(frontNumOk[i] == frontNum){
				frontNumChk = true;
				break;
			}
			
		}
		if(frontNumChk == false){
			alert("핸드폰 앞번호를 확인해주세요\n010,011,016,017,018,019만 허용 됩니다.");
			return false;
		}
		
		$("[name='chkBox']").each(function(index){
			val = $(this).val().split(",")[2];
			if(thisVal == val){
				alert("기존의 주소록에 이미 존재한 번호 입니다.");
				chk = false;
				return false;
			}
		});
		
		if(chk == true){
			var url = "<c:url value="/cms/mgov/addrAddProc.do"/>";
			$("#listForm").attr("action", url).submit();
		}
		
	});
	
	$("#excelUpload").click(function(e){
		e.preventDefault();
		
		var showChk = $("#excelUploadSpace").css("display");
		if(showChk == 'block'){
			$("#excelUploadSpace").slideUp();
			$("#excelUpload").removeClass("btn-primary");
			$("#excelUpload").text("엑셀 업로드");
			$("#upFile").val("");
			$(".filename").text("선택된 파일 없음");
			$("#excelFileUpload").parent().parent().slideUp();
			fileCheckReset();
		}else{
			$("#searchList").slideUp();
			$("#searchList").removeClass('on');
			$("#searchBtn").removeClass("btn-primary");
			$("#searchBtn").text("회원조회");
			$("#excelUploadSpace").slideDown();
			$("#excelUpload").addClass("btn-primary");
			$("#excelUpload").text("엑셀 업로드 닫기");
		}
	});
	
	$("#excelFileChk").click(function(e){
		e.preventDefault();
		
		var upFile = $("#upFile").val();
		
		if(upFile == ''){
			alert("업로드 할 파일을 선택해주세요.");
			return false;
		}
		$("#listForm").ajaxSubmit({
			url:"<c:url value="/cms/mgov/AddrExcelChk.do"/>",
			success:function(data){
				var strChk = data.substring(0,5);
				
				if(strChk == 'ERROR'){
					$("#upFileChk").val("error");
					
					alert(data);
					return false;
				}else{
					$("#upFileChk").val("pass");
					$("#excelFileChk").removeClass("btn-danger");
					$("#excelFileUpload").parent().parent().slideDown();
				}
			},
			error:function(){
				alert("파일검사 중 문제가 발생했습니다.");
			}
		});
	});
	
	$("#excelFileUpload").click(function(e){
		e.preventDefault();
		
		var grpId = $.trim($("#grpType").val());

		if(grpId == ''){
			alert("주소록 유형을 선택해주세요.");
			$("#grpType").focus();
			return false;
		}
		
		var url = "<c:url value="/cms/mgov/AddrExcelUpload.do"/>";
		
		$("#listForm").attr("action", url).submit();
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
		$("#upFile").val("");
		$(".filename").text("선택된 파일 없음");
		
		if(chk == "-1" || fileChk == "pass"){
			$("#excelFileChk").addClass("btn-danger");
			$("#upFileChk").val("error");
			$("#excelFileUpload").parent().parent().slideUp();
		}
	}
	
	function searchReset(){
		$("#searchNm").val("");
		$("#searchOrg").val("");
		$("#searchPhone").val("");
	}
});

// -->
</script>
</head>

<body>

<div class="Jnitsms">
	<form:form commandName="searchVO" name="listForm" id="listForm" method="post" enctype="multipart/form-data">
	<input type="hidden" id="upFileChk" name="upFileChk" />
	<input type="hidden" id="view" name="view" value="view" />
	<input type="hidden" id="addrPhone" name="addrPhone" />
	    <div class="Jnitsms_topcontent">
	        <h1 class="Jnitsms_logo"><a href="#"><img src="<c:url value="/resources/img/sms/sms_logo.gif" />" alt="SMS service" /></a></h1>    
	        <div class="Jnitsms_menu">
	            <p class="Jnitsms_menu_title">SMS보내기</p>
	           <ul>
	                <li><a href="<c:url value="/sms/view/page.do" />?pageType=MbrSend">회원조회발송</a></li>
	                <li><a href="<c:url value="/sms/view/page.do" />?pageType=ExcelSend">엑셀발송</a></li>
	                <li><a href="<c:url value="/sms/view/page.do" />?pageType=AddrSend">주소록발송</a></li>
	            </ul>
	            <p class="Jnitsms_menu_title MAL20">발송내역</p>
	            <ul>
					<li><a href="<c:url value="/sms/view/smsSendList.do" />">SMS발송내역</a></li>
					<li><a href="<c:url value="/sms/view/lmsSendList.do" />">LMS발송내역</a></li>
	            </ul>
	        </div>
	        <p class="Jnitsms_address"><a href="<c:url value="/sms/view/page.do?pageType=SmsAddr" />">+ 주소록관리</a></p>
	    </div>
	    <div class="Jnitsms_box">
	      	<span class="box_lttop"></span>
	      	<span class="box_rttop"></span>
	      	<div class="sms_address">
				<p class="sms_address_title">SMS 주소록 관리</p>
	            <div class="sms_address_type">         
	                    <label for="sDate">주소록 유형</label>
	                    <select id="grpType" name="grpType">
	                        <option value=" " selected="selected">선택해주세요.</option>
	                        <c:forEach var="result" items="${grpList}" varStatus="status">
	                        	<option value="${result.grpId}"><c:out value="${result.grpNm}" /></option>
	                        </c:forEach>
	                    </select>
	                    <div class="grpTypeAddDiv" id="grpTypeAddDiv" name="grpTypeAddDiv" style="display: none;">
	                    	<font>유형 명 :</font><input type="input" id="grpNm" name="grpNm" />
	                    	<button type="button" id="grpAdd" name="grAdd">추가</button>
	                    </div>
	                    <button class="grpTypeAdd" id="grpTypeAdd" name="grpTypeAdd">유형추가</button>
	                    <button class="grpTypeDel" id="grpTypeDel" name="grpTypeDel">유형삭제</button>
	                
	            </div>
	            <div class="sms_address_eachadd">
					<p class="eachadd_title">개별추가</p>
	              	<p class="eachadd_txt">
	                	<label for="addrNm">이름</label><input id="addrNm" name="addrNm" />
	                    <label for="tel1">핸드폰 번호</label><input id="tel1" name="tel1" maxlength="3" /> - <input id="tel2" name="tel2" maxlength="4" /> - <input id="tel3" name="tel3" maxlength="4" />
	                    <button class="individualAdd" id="individualAdd" name="individualAdd">추가</button>
	                    <button class="addrDel" id="addrDel" name="addrDel">삭제</button>
	               </p>
	            </div>
	            <div class="sms_address_list">            	
	                <div class="address_list_box" id="ajax" name="ajax">
	                    <table class="member_list_table" summary="선택, 회원 이름, 회원 전화번호의 회원정보를 조회할 수 있는 표입니다.">
	                    <caption>회원정보 조회</caption>
	                        <thead>
	                            <tr>
	                                <th scope="row">선택</th>
	                                <th scope="row">회원 이름</th>
	                                <th scope="row">회원 전화번호</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <tr>
	                                <td colspan="3"><strong>주소록 유형을 선택해주세요.</strong></td>
	                            </tr>
	                        </tbody>
	                    </table>
	                </div>
	            </div>            
	        </div>
	    
	        <span class="box_ltbtm"></span>
	        <span class="box_rtbtm"></span>
	    </div>
	    
	    <div class="Jnitsms_box" style="width:400px;margin-left: 15px;">
	        <span class="box_lttop"></span>
	        <span class="box_rttop"></span>
	        <div class="address_excel">
	            <p class="address_excel_title">SMS 주소록 테이블</p>
	            <p class="address_excel_btn">
	            	<a href="#" class="address_excel_down">엑셀 샘플 다운로드</a>                
	            </p>
	        </div>
			<div class="address_excel_upload">
				<p class="address_excel_title">엑셀 파일 업로드</p>
	            <input type="file" id="upFile" name="upFile" size="0" />
	            <input type="checkbox" id="duplicate" name="duplicate" />
	            <label for="duplicate">중복 검사</label>
	            <button id="excelFileChk" class="excelFileChk">파일 검사</button>     
	        </div>
	        <div class="excelHide" style="display:none;">
	        	<%-- <a href="#" class="excelFileUpload">엑셀 파일 등록</a> --%>
	        	<span><button id="excelFileUpload" name="excelFileUpload">엑셀 파일 등록</button></span>
	        </div>
	        <span class="box_ltbtm"></span>
	        <span class="box_rtbtm"></span>
	    </div>
	</form:form>
</div>
  
  
</body>  
</html>