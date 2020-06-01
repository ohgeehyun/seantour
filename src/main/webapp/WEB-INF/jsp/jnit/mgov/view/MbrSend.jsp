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
	
	$(document).on("keypress", function(e){
		if(e.which==13){
			return false;
		}
	});
	
	$("[id*='sh']").on("keypress", function(e){
		if(e.which==13){
			$("#search").click();
		}
	});
	
	
	$("#msgTxt").keyup(function(){
		byteChk();
	});
	
	$("#sendMessage").click(function(){
		
		$("#phoneList option").attr("selected", true);
		var size = $("#phoneList option[selected='selected']").size();
		var txt = $("#confirm").text();
		
		if(size < 1){
			alert("핸드폰 번호를 추가해 주세요.");
			$("#searchBtn").focus();
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
			
			$("#confirm").text("수정");
			
		}else{
			$("[id*=sendTel]").attr("readOnly", false);
			$("#confirm").text("확정");
		}
	});
	
	$("#addPhone").click(function(e){
		e.preventDefault();
		
		var chkPhone = $("#tel1").val();
		var name = $("#telNm").val();
		var phone = $("#tel1").val()+"-"+$("#tel2").val()+"-"+$("#tel3").val();
		var sizeChk = $("#phoneList option[value='"+phone+','+name+"']").length;
		
		if(name == null || name == ''){
			alert("개별 추가할 사람의 성명을 입력해주세요.");
			$("#telNm").focus();
			return false;
		}else if(chkPhone != '010' && chkPhone != '011' && chkPhone != '016' && chkPhone != '017' && chkPhone != '018' && chkPhone != '019'){
			alert("핸드폰 앞번호를 잘못 입력하셨습니다.");
			$("#tel1").focus();
			return false;
		}
		
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
		}
		
		$("#phoneList").append("<option value="+phone+','+name+" selected='selected'>"+phone+"("+name+")</option>");
		
		$("#telNm").attr('value', '');
		$("#tel1").attr('value', '');
		$("#tel2").attr('value', '');
		$("#tel3").attr('value', '');
		$("#telNm").focus();
	});
	
	$("#search").click(function(e){
		e.preventDefault();
		
		var searchNm = $.trim($("#shNm").val());
		var searchOrg = $.trim($("#shOrg").val());
		var searchPhone = $.trim($("#shPhone").val());
		var searchPos = $.trim($("#shPos").val());
		
		var thisInput = $("[id*='ctgr'].on").attr("id").replace("ctgr", "sh");
		var thisKeyword = $.trim($("#"+thisInput).val()); 
		
		if(thisKeyword == ''){
			alert("검색 키워드를 입력해주세요.");
			$("#"+thisInput).focus();
			return false;
		}
		
		$.ajax({
			type : "POST",
			url : "<c:url value="/mgov/searchAjax.do"/>",
			data : {
				searchNm : searchNm,
				searchOrg : searchOrg,
				searchPhone : searchPhone,
				searchPos : searchPos
			}
		}).done(function(data){
			$("#searchAjax").empty();
			$("#searchAjax").append(data);
		});
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
	
	$("[id*=ctgr]").click(function(e){
		e.preventDefault();
		$("[id*=ctgr]").removeClass('on');
		$(this).addClass('on');
		
		var choice = $(this).val();
		
		$("[id*='sh']").hide();
		$("[id*='sh']").val("");
		
		if(choice == 'name'){
			$("#shNm").show();
			$("#shhNm").focus();
		}else if(choice == 'pos'){
			$("#shPos").show();
			$("#shPos").focus();
		}else if(choice == 'phone'){
			$("#shPhone").show();
			$("#shPhone").focus();
		}
		
	});
	
	$("#phoneList option").click(function(){
		alert("del");
		$(this).remove();
	});
	
	$("#phoneRest").click(function(e){
		e.preventDefault();
		
		if(confirm("리스트의 목록을 전부 삭제 하시겠습니까?")){
			$("#phoneList").empty();
			$("#tel1").focus();
		}
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
// -->
</script>
</head>

<body>

<div class="Jnitsms">
	<form id="jnitsmsmgovVO" name="jnitsmsmgovVO" action="<c:url value="/cms/sms/addProc.do" />" method="post" enctype="multipart/form-data" >
	<input type="hidden" id="msgByteVal" name="msgByteVal" />
	<input type="hidden" id="view" name="view" value="view" />
	    <div class="Jnitsms_topcontent">
	        <h1 class="Jnitsms_logo"><a href="#"><img src="<c:url value="/resources/img/sms/sms_logo.gif" />" alt="SMS service" /></a></h1>    
	        <div class="Jnitsms_menu">
	            <p class="Jnitsms_menu_title">SMS보내기</p>
	            <ul>
	                <li class="on"><a href="<c:url value="/sms/view/page.do" />?pageType=MbrSend">회원조회발송</a></li>
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
	        <div class="Jnitsms_msg">
	            <textarea id="msgTxt" name="msgTxt" row="10" placeholder="메세지 내용 입력해주세요." ></textarea>
	            <p id="byteCount"></p>
	            <p class="add_name" id="nameAppend" name="nameAppend"><a href="#">성명추가</a> ※ 모든 사람의 이름을 보낼때 <span>&quot;[성명](은 8 Byte로 취급)&quot;</span>을 넣어주세요.</p>
	        </div>
	        <div class="Jnitsms_list">
	            <p class="Jnitsms_list_title">메세지 전송리스트</p>
	            <button id="phoneRest" name="phoneRest" class="Jnitsms_btn">리스트 초기화</button>
	            <div class="Jnitsms_list_box">
	            	<%--
	                <ul>
	                    <li><input type="text" class="sms_list_input" value="text" /></li>
	                    <li><input type="text" class="sms_list_input" value="text" /></li>
	                    <li><input type="text" class="sms_list_input" value="text" /></li>                
	              </ul>
	              --%>
	              <select multiple="multiple" id="phoneList" name="phoneList" style="width: 100%; height: 273px;">
	              
	              </select>
	            </div>
	        </div>
	        <div class="Jnitsms_send_msg">
	                <div class="add_address">
	                    <p class="send_msg_title">연락처추가</p>
	                    <ul>
	                        <li><label for="name">이름</label><input id="telNm" name="telNm" />
	                        </li>
	                        <li><label for="tel1">번호</label><input id="tel1" name="tel1" maxlength="3" /> - <input id="tel2" name="tel2" maxlength="4" /> - <input id="tel3" name="tel3" maxlength="4" />
	                        </li>
	                        <li style="float: right;">
	                        	<a href="#" id="addPhone" name="addPhone" class="addPhone">추가</a>
	                        </li>
	                    </ul>
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
	    <c:if test="${configVO['mbrCheck'] == 'Y'}">
		    <div class="Jnitsms_box" style="width:400px;margin-left: 15px;padding-bottom: 10px;">
		        <span class="box_lttop"></span>
		        <span class="box_rttop"></span>
		        <div class="member_search">
		            <p class="member_search_title">회원조회</p>
		            <p class="member_search_txt">핸드폰 <span>앞번호</span>가 <span>010, 011, 016, 017, 018, 019</span>를 제외한 번호는 리스트에 나오지 않습니다.</p>    
		            <div class="search_list">
		                <button class="btn on" id="ctgrNm" value="name">성명</button>
		                <button class="btn" id="ctgrPos" value="pos">부서</button>
		                <button class="btn" id="ctgrPhone" value="phone">번호</button>
		                <div id="searchNmDiv">
		                    <label for="searchNm">성명</label>
		                    <input type="text" id="shNm" name="shNm" />
		                </div>
		                <div id="searchPosDiv">
		                    <label for="searchPos">부서</label>
		                    <input type="text" id="shPos" name="shPos" style="display:none;"/>                
		                </div>
		                <div id="searchPhoneDiv">
		                    <label for="searchPhone">번호</label>
		                    <input type="text" id="shPhone" name="shPhone" style="display:none;" />                
		                </div>
		                <p class="member_search_btn" id="search" name="search">검색</p>
		            </div>  
		        </div>
		        <div class="member_list">
		          	<div class="member_list_box" id="searchAjax" name="searchAjax">
		                <button class="member_list_btn" id="boxSelect" >전체 선택/해제</button>
		                <table class="member_list_table" summary="체크, 성명, 핸드폰번호, 부서명의 회원조회 정보를 제공합니다.">
		                <caption>회원정보 조회</caption>
		                    <thead>
		                        <tr>
		                            <th scope="row">선택</th>
		                            <th scope="row">성명</th>
		                            <th scope="row">핸드폰번호</th>
		                            <th scope="row">부서명</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                    	<tr>
		                    		<td colspan="4"><strong>데이터를 조회 해주세요.</strong></td>
		                    	</tr>
		                    </tbody>
		                </table>
		          	</div>
		        </div>
		        
		        <a href="#" id="addList" name="addList" class="Jnitsms_send_btn02">전송리스트로 보내기</a>
		        
		        <span class="box_ltbtm"></span>
		        <span class="box_rtbtm"></span>
		    </div>
		</c:if>
    </form>
</div>
  
  
</body>  
</html>