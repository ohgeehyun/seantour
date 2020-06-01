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
    	type = "LMS";
    }
    
    $("#byteCount").empty();
    if(type == 'SMS'){
    	$("#byteCount").append(totalByte+" Byte(<strong style='color: blue;'>"+type+"</strong>)");
    	$(".msgTitle").css("display", "none");
    }else{
    	$("#byteCount").append(totalByte+" Byte(<strong style='color: red;'>"+type+"</strong>)");
    	$(".msgTitle").css("display", "block");
    }
    $("#msgByteVal").val(totalByte);
}

$(document).ready(function(){
	
	$("#msgTxt").keyup(function(){
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
7				}
			},
			error: function(){
				alert("엑셀파일에 문제가 발생하였습니다.");
			}
		});
		
		//$("#myModal").modal("hide");
	});
	
	$("#excelFileChk").click(function(e){
		e.preventDefault();
		
		var upFile = $("#upFile").val();
		if(upFile == ''){
			alert("업로드 할 파일을 지정해 주세요.");
			return false;
		}
		
		$(document).ajaxStart(function(){
			//$("#fileCheckModal").modal("show");
		});
		$("[name='jnitsmsmgovVO']").ajaxSubmit({
			url:"<c:url value="/cms/sms/excelUpload.do"/>",
			success:function(data){
				var strChk = data.substring(0,5);
				
				if(strChk == 'ERROR'){
					$("#upFileChk").val("error");
					
					alert(data);
					return false;
				}else{
					$("#upFileChk").val("pass");
					$("#excelFileChk").removeClass("btn-danger");
				}
			}
		});
		$(document).ajaxStop(function(){
			//$("#fileCheckModal").modal("hide");
		});
	});
	
	$("#upFile").click(function(){
		fileCheckReset();
	});
	
	$("#duplicate").click(function(){
		fileCheckReset();
	});
	
	$("#confirm").click(function(e){
		e.preventDefault();
		
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
			
			$("[id*=sendTel]").attr("readOnly", true);
			$("#confirm").removeClass("btn-danger");
			$("#confirm").text("수정");
			
		}else{
			$("[id*=sendTel]").attr("readOnly", false);
			$("#confirm").addClass("btn-danger");
			$("#confirm").text("확정");
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
	
	$("#sendMessage").click(function(){
		
		var txt = $("#confirm").text();
		var fileChk = $("#upFileChk").val();
		var classNm = $("#excelFileChk").attr("class");
		var chk = classNm.indexOf("btn-danger");
		var upFile = $("#upFile").val();
		
		if(upFile == ''){
			alert("엑셀 파일을 올려주세요");
			$("#upFile").focus();
			return false;
		}else if(fileChk != "pass" || chk != -1){
			alert("업로드할 엑셀파일을 검사해주세요. (파일검사 필수)");
			$("#excelFileChk").focus();
			return false;
		}
		
		if(txt == '수정'){
			if(confirm("메세지를 전송하시겠습니까?")){
				var messageTitle = $("#messageTitle").val();
				var msgTxt = $("#msgTxt").val();
				
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

// -->
</script>

</head>
<body>

<div class="Jnitsms">
	<form id="jnitsmsmgovVO" name="jnitsmsmgovVO" action="<c:url value="/cms/sms/addProc.do" />" method="post" enctype="multipart/form-data" >
	<input type="hidden" id="msgByteVal" name="msgByteVal" />
	<input type="hidden" id="upFileChk" name="upFileChk" />
	<input type="hidden" id="view" name="view" value="view" />
	    <div class="Jnitsms_topcontent">
	        <h1 class="Jnitsms_logo"><a href="#"><img src="<c:url value="/resources/img/sms/sms_logo.gif" />" alt="SMS service" /></a></h1>    
	        <div class="Jnitsms_menu">
	            <p class="Jnitsms_menu_title">SMS보내기</p>
	            <ul>
	                <li><a href="<c:url value="/sms/view/page.do" />?pageType=MbrSend">회원조회발송</a></li>
	                <li class="on"><a href="<c:url value="/sms/view/page.do" />?pageType=ExcelSend">엑셀발송</a></li>
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
	        <div class="Jnitsms_msg">
	            <textarea id="msgTxt" name="msgTxt" row="10" placeholder="메세지 내용 입력해주세요." ></textarea>
	            <p id="byteCount"></p>
	            <p class="add_name" id="nameAppend" name="nameAppend">
	            	<a href="#">성명추가</a> 
	            	※ 모든 사람의 이름을 보낼때 <span>&quot;[성명](은 8 Byte로 취급)&quot;</span>을 넣어주세요.
	            </p>
	        </div>
	        <div class="Jnitsms_upload_excel">
	            <p class="excel_file_title">
	            	엑셀 파일 업로드
	            	<a href="<c:url value="/resources/img/excelSample.xlsx" />" class="btn btn-mini" target="_blank" title="다운로드" style="float: right;">엑셀 샘플 다운로드</a>
	            </p>
	            <div class="excel_file_upload">
	                <input type="file" id="upFile" name="upFile" size="0" />
	                <input type="checkbox" id="duplicate" name="duplicate" />
	                <label for="duplicate">중복 검사</label>
	                <button id="excelFileChk" name="excelFileChk" class="excelFileChk">파일 검사</button>     
	            </div>
	            <div class="send_from">
	                <p class="send_msg_title">보내는사람</p>
	                <ul>
	                    <li><label for="sendTel1">번호</label><input id="sendTel1" name="sendTel1" maxlength="3" /> - <input id="sendTel2" name="sendTel2" maxlength="4" /> - <input id="sendTel3" name="sendTel3" maxlength="4" />
	                    </li>
	                    <li style="float: right;">
	                        <a href="#" class="confirm btn-danger" id="confirm" name="confirm">확정</a>
	                    </li>
	                </ul>
	            </div>
	            <%-- <a href="#" class="Jnitsms_send_btn" id="sendMessage" name="sendMessage">메세지 전송</a> --%>
	            <button class="Jnitsms_send_btn" id="sendMessage" name="sendMessage">메세지 전송</button>
	        </div>
	    
	        <span class="box_ltbtm2"></span>
	        <span class="box_rtbtm2"></span>
	    </div>
	</form>   
</div>
  
  
</body>  
</html>