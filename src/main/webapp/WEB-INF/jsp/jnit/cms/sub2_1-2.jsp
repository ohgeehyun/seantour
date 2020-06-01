<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<c:out value="${searchVo.screenMode}"/>
<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>		

<!--For Commons Validator Client Side-->
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="jnitcmsmbrVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
var DBTypeInfo = "${DBTypeInfo}";
/* 글 목록 화면 function */
function fn_egov_selectList() {
	$("#orgId").val('');
	var retTypeId = $("#retTypeId").val();
	if(retTypeId != ''){
		document.getElementById("jnitcmsmbrVO").action = "<c:url value='/cms/sub2/0101.do'/>?retTypeId="+retTypeId;
	   	document.getElementById("jnitcmsmbrVO").submit();
	}else{
		document.getElementById("jnitcmsmbrVO").action = "<c:url value='/cms/sub2/0101.do'/>";
	   	document.getElementById("jnitcmsmbrVO").submit();
	}   			
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitcmsmbrVO").action = "<c:url value='/cms/sub2/0102del.do'/>";
   	document.getElementById("jnitcmsmbrVO").submit();		
}

function Jnit_rexgex(passwd){
	var regexList = "!,@,#,$,%,^,&,*,(,),_,-,+,~,`,{,},<,>,?,:,\",;,'";
	var regex = regexList.split(",");
	var regexbln = false;
	for(var i=0; i<regex.length; i++){		
		if(passwd.indexOf(regex[i]) > -1){
			regexbln = true;
			break;
		}
	}
	if(regexbln){
		if(passwd.length > 16 || passwd.length < 10){
			alert("패스워드는 10~16자 여야합니다.");
			$("#passwd").focus();
			return false;
		}
	}else{
		alert("특수문자 하나이상포합해야합니다.");
		$("#passwd").focus();
		return false;
	}
	return true;
}

/* 글 등록 function */
function fn_egov_save() {	
	var mbrLogin = $('#mbrLogin').val();
	var mbrNm =  $('#mbrNm').val();
	var orgId = $.trim($('#orgId').val());
	var posId = $.trim($('#posId').val());	
	var passwd = $('#passwd').val();
	var passwdConfirm = $('#passwdConfirm').val();
	
	var tel = $("#tel").val();
	var mobile = $("#mobile").val();
	var email = $("#email").val();
	var postcode = $("#postcode").val();
	var address = $("#address").val();
	var typeId = $("#typeId option:selected").val();
	
	var p_tel = "${mbrInfo['tel']}";
	var p_phone = "${mbrInfo['phone']}";
	var p_email = "${mbrInfo['email']}";
	var p_post = "${mbrInfo['post']}";
	var p_addr = "${mbrInfo['addr']}";
	var p_emailRecv= "${mbrInfo['emailRecv']}";
	var p_smsRecv= "${mbrInfo['smsRecv']}";
	
	
	if(mbrLogin == null || mbrLogin == ""){
		alert("아이디를 입력해 주세요.");
		$('#mbrLogin').focus();
		return false;
	}else if(mbrNm == null || mbrNm == ""){
		alert("이름을 입력해 주세요.");
		$('#mbrNm').focus();
		return false;
	}else if(typeId == null || typeId == " "){
		alert("유형을 선택해 주세요.");
		$('#typeId').focus();
		return false;
	} 
	if(p_tel == '2'){
		if(tel == null || tel == ''){
			alert("일반 전화번호를 입력해주세요");
			$('#tel').focus();
			return false;
		}
	}
	if(p_phone == '2'){
		if(mobile == null || mobile == ''){
			alert("휴대폰 번호를 입력해주세요");
			$('#mobile').focus();
			return false;
		}
	}
	if(p_email == '2'){
		if(email == null || email == ''){
			alert("이메일를 입력해주세요");
			$('#mobile').focus();
			return false;
		}
	}
	if(p_post == '2'){
		if(postcode == null || postcode == ''){
			alert("우편번호를 입력해주세요");
			$('#postcode').focus();
			return false;
		}
	}
	if(p_addr == '2'){
		if(address == null || address == ''){
			alert("주소를 입력해주세요");
			$('#address').focus();
			return false;
		}
	}
	if(p_emailRecv == '2'){
		if($("emailRecv1").is(":checked") == false){
			alert("메일수신동의를 체크해주세요");
			$('#emailRecv1').focus();
			return false;
		}
	}
	if(p_smsRecv == '2'){
		if($("smsRecv1").is(":checked") == false){
			alert("SMS수신동의를 체크해주세요");
			$('#smsRecv1').focus();
			return false;
		}
	}
	if(typeId == '30006'){ //단체회원 필수조건
		var groupType = $("input:radio[name='groupType']:checked").val();
		var establishment = $("#establishment").val();
		var corporation = $("#corporation").val();
		var primaryKey = $("#primaryKey").val();
		var corporateName = $("#corporateName").val();
		var groupName = $("#groupName").val();
		var businessPlace = $("#businessPlace").val();
		var businessAddr = $("#businessAddr").val();
		var groupKind = $("#groupKind").val();
		var groupTel = $("#groupTel").val();
		var groupPax = $("#groupPax").val();
		var p_corporateName = "${mbrInfo['corporateName']}";
		var p_groupName = "${mbrInfo['groupName']}";
		var p_businessPlace = "${mbrInfo['businessPlace']}";
		var p_businessAddr = "${mbrInfo['businessAddr']}";
		var p_groupKind = "${mbrInfo['groupKind']}";
		var p_groupTel = "${mbrInfo['groupTel']}";
		var p_groupPax = "${mbrInfo['groupPax']}";		
		
		if(groupType == '개인'){
			if(establishment == null || establishment == ''){
				alert("사업자번호를 입력해주시기 바랍니다.");
				$("#establishment").focus();
				return false;
			}
		}else if(groupType == '영리'){
			if(establishment == null || establishment == ''){
				alert("사업자번호를 입력해주시기 바랍니다.");
				$("#establishment").focus();
				return false;
			}else if(corporation == null || corporation == ''){
				alert("법인등록번호를 입력해주시기 바랍니다.");
				$("#corporation").focus();
				return false;
			}
		}else if(groupType == '비영리'){
			if(establishment == null || establishment == ''){
				alert("사업자번호를 입력해주시기 바랍니다.");
				$("#establishment").focus();
				return false;
			}else if(corporation == null || corporation == ''){
				alert("법인등록번호를 입력해주시기 바랍니다.");
				$("#corporation").focus();
				return false;
			}else if(primaryKey == null || primaryKey == ''){
				alert("고유번호를 입력해주시기 바랍니다.");
				$("#primaryKey").focus();
				return false;
			}
		}else if(groupType == '공식'){
			if(primaryKey == null || primaryKey == ''){
				alert("고유번호를 입력해주시기 바랍니다.");
				$("#primaryKey").focus();
				return false;
			}
		}
		if(p_corporateName == '2'){			
			if(corporateName == null || corporateName == ''){
				alert("법인명(단체명)을 입력해주시기 바랍니다.");
				$("#corporateName").focus();
				return false;
			}
		}
		if(p_groupName == '2'){			
			if(groupName == null || groupName == ''){
				alert("대표자명을 입력해주시기 바랍니다.");
				$("#groupName").focus();
				return false;
			}
		}
		if(p_businessPlace == '2'){			
			if(businessPlace == null || businessPlace == ''){
				alert("사업장 소재지를 입력해주시기 바랍니다.");
				$("#businessPlace").focus();
				return false;
			}
		}
		if(p_businessAddr == '2'){			
			if(businessAddr == null || businessAddr == ''){
				alert("사업장 주소를 입력해주시기 바랍니다.");
				$("#businessAddr").focus();
				return false;
			}
		}
		if(p_groupKind == '2'){			
			if(groupKind == null || groupKind == ''){
				alert("대표 종목을 입력해주시기 바랍니다.");
				$("#groupKind").focus();
				return false;
			}
		}
		if(p_groupTel == '2'){			
			if(groupTel == null || groupTel == ''){
				alert("대표 전화번호를 입력해주시기 바랍니다.");
				$("#groupTel").focus();
				return false;
			}
		}
		if(p_groupPax == '2'){			
			if(groupPax == null || groupPax == ''){
				alert("대표 팩스를 입력해주시기 바랍니다.");
				$("#groupPax").focus();
				return false;
			}
		}
	}
	/*
	if(orgId == null || orgId == ""){
		alert("부서를 선택해 주세요.");
		$('#orgId').focus();
		return false;
	}else if(posId == null || posId == ""){
		alert("직급을 선택해 주세요.");
		$('#posId').focus();
		return false;
	}
	*/
	
	<c:if test="${registerFlag == '수정'}">
		if(passwd != "" || passwdConfirm != ""){
			if(passwd == null || passwd == ""){
				alert("패스워드를 입력해 주세요.");
				$('#passwd').focus();
				return false;
			}else if(passwdConfirm == null || passwdConfirm == ""){
				alert("패스워드 확인란을 입력해 주세요.");
				$('#passwdConfirm').focus();
				return false;
			}else if(passwd != passwdConfirm){
				alert("패스워드가 다릅니다.");
				$('#passwdConfirm').focus();
				return false;
			}else if(!Jnit_rexgex(passwd)){//패스워드 특수문자 체크
				return false;
			}
		}	  		
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		
		if(passwd == null || passwd == ""){
			alert("패스워드를 입력해 주세요.");
			$('#passwd').focus();
			return false;
		}else if(passwdConfirm == null || passwdConfirm == ""){
			alert("패스워드 확인란을 입력해 주세요.");
			$('#passwdConfirm').focus();
			return false;
		}else if(passwd != passwdConfirm){
			alert("패스워드가 다릅니다.");
			$('#passwdConfirm').focus();
			return false;
		}else if(!Jnit_rexgex(passwd)){//패스워드 특수문자 체크
			return false;
		}			
	</c:if>		
	return true;
}

function member_save(){
	if(fn_egov_save()){
		frm = document.getElementById("jnitcmsmbrVO");
		$('#passwd').val($('#passwd').val().replace(/&/g, '*'));
		$('#passwdConfirm').val($('#passwd').val().replace(/&/g, '*'));
		<c:if test="${registerFlag == '수정'}">			
			frm.action = "<c:url value='/cms/sub2/0102up.do'/>";
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			frm.action = "<c:url value='/cms/sub2/0102add.do'/>";
		</c:if>
		frm.submit();
	}		
}

function afterAddress(){
	//상세주소 처리
	var addrDetail = "";
	if($('input[name=address]').val().search("\\(|\\~") > -1) {
		var addrArr = $('input[name=address]').val().split(" ");
		for(i=0;i<addrArr.length-1;i++){
			if( $.trim(addrArr[i]) != "") {
				addrDetail += $.trim(addrArr[i]) + " ";
			}
		}
	}else {
		addrDetail = $('input[name=address]').val();
	}

	$('input[name=address]').val( $.trim(addrDetail) + " " + $('input[name=address04]').val() );
}

function member_del(){
	
	if(confirm("정말 삭제하시겠습니까?")){
		document.getElementById("jnitcmsmbrVO").action = "<c:url value='/cms/sub2/mbr/delete.do'/>";
		document.getElementById("jnitcmsmbrVO").submit();
	}	
}

function Jnit_typeClass(){
	$(".typeClass").css("display","none"); //공통
	$(".typeClass1").css("display","none"); //승인여부
 	$(".typeClass2").css("display","none"); //단체종류선택
	$(".typeClass3").css("display","none"); //개인사업자
	$(".typeClass4").css("display","none"); //법인등록번호
	$(".typeClass5").css("display","none"); //고유번호
}

function Jnit_groupType(groupType){
	//단체종류 선택 체크시	
	if(groupType == '개인'){
		//초기화		
		Jnit_typeClass();
		$(".typeClass").css("display","");
		$(".typeClass1").css("display","");
		$(".typeClass2").css("display","");
		$(".typeClass3").css("display","");
	}else if(groupType == '영리'){	
		//초기화
		Jnit_typeClass();
		$(".typeClass").css("display","");
		$(".typeClass1").css("display","");
		$(".typeClass2").css("display","");
		$(".typeClass3").css("display","");
		$(".typeClass4").css("display","");
	}else if(groupType == '비영리'){
		//초기화
		Jnit_typeClass();
		$(".typeClass").css("display","");
		$(".typeClass1").css("display","");
		$(".typeClass2").css("display","");
		$(".typeClass3").css("display","");
		$(".typeClass4").css("display","");
		$(".typeClass5").css("display","");
	}else if(groupType == '공식'){
		//초기화
		Jnit_typeClass();
		$(".typeClass").css("display","");
		$(".typeClass1").css("display","");
		$(".typeClass2").css("display","");
		$(".typeClass5").css("display","");
	}else{//공통입력항목
		Jnit_typeClass();
		$(".typeClass").css("display","");
		$(".typeClass1").css("display","");
	}
}
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){
    $("#postcode").val(zipNo);
	$("#address").val(roadFullAddr);
}
$(document).ready(function(){
	$('#postFind').click(function(e){
		e.preventDefault();
		var winUrl = "<c:url value='/gis/zip.do?retForm=jnitcmsmbrVO' />";
		winUrl += "&retPost=postcode";
		winUrl += "&retAddr=address";
		winUrl += "&retAddrDetail=address04";
		winUrl += "&retFunction=addrZip";

		var winZip = window.open(winUrl,"windowZip","width=500,height=400,top=0,left=0");
		winZip.focus();
	});
	
	$('#businessPostFind').click(function(e){
		e.preventDefault();
		var winUrl = "<c:url value='/gis/zip.do?retForm=jnitcmsmbrVO' />";
		winUrl += "&retPost=businessPlace";
		winUrl += "&retAddr=businessAddr";
		winUrl += "&retAddrDetail=businessAddr1";
		winUrl += "&retNewaddr=businessAddrNew";
		winUrl += "&retNewaddrDetail=gugun";
		winUrl += "&retFunction=plusZip";

		var winZip = window.open(winUrl,"windowZip","width=500,height=400,top=0,left=0");
		winZip.focus();
	});
	
	
	$("#passwd").focusout(function(){		
		var passwd = $("#passwd").val();
		
		if(passwd != ""){
			$.ajax({
					type:"POST",
					url:"<c:url value="/jnit/kisalib/pwSafe.do" />",
					data:"passwd="+passwd
			}).done(function(data){
				
					var result = $.parseJSON(data);
					var retLvl = "";
					var retStr = "";
					var progress = "<div class='progress' style='width: 320px;'><div class='bar bar-danger' style='width: 25%'>하</div><div class='bar bar-warning' style='width: 25%'>중</div>	<div class='bar bar-success' style='width: 25%'>상</div><div class='bar bar-info' style='width: 25%'>최상</div></div>";
					var proLow = "<strong>비밀번호 안전도 : </strong><div class='progress' style='width: 80px; float: right; margin-right: 100px;'><div class='bar bar-danger' style='width: 100%;'>하</div></div><br />";
					var proMid = "<strong>비밀번호 안전도 : </strong><div class='progress' style='width: 80px; float: right; margin-right: 100px;'><div class='bar bar-warning' style='width: 100%;'>중</div></div><br />";
					var proTop = "<strong>비밀번호 안전도 : </strong><div class='progress' style='width: 80px; float: right; margin-right: 100px;'><div class='bar bar-success' style='width: 100%;'>상</div></div><br />";
					var proBest = "<strong>비밀번호 안전도 : </strong><div class='progress' style='width: 80px; float: right; margin-right: 100px;'><div class='bar bar-info' style='width: 100%;'>최상</div></div><br />";

					if(result.level != null) retLvl = result.level;
					if(result.info01 != null) retStr += "<br /> -" + result.info01;
					if(result.info02 != null) retStr += "<br /> -" + result.info02;
					if(result.info03 != null) retStr += "<br /> -" + result.info03;
					if(result.info04 != null) retStr += "<br /> -" + result.info04;
					
					$("#pwLow").attr("style","display:none;");
					$("#pwMid").attr("style","display:none;");
					$("#pwTop").attr("style","display:none;");
					$("#pwBest").attr("style","display:none;");

					if(retLvl == '하'){
						$("#pwLow").empty();
						$("#pwLow").append(progress + proLow + retStr);
						$("#pwLow").attr("style","display:block; width: 320px;");
					}else if(retLvl == '중'){
						$("#pwMid").empty();
						$("#pwMid").attr("style","display:block; width: 320px;");
						$("#pwMid").append(progress + proMid + retStr);
					}else if(retLvl == '상'){
						$("#pwTop").empty();
						$("#pwTop").attr("style","display:block; width: 320px;");
						$("#pwTop").append(progress + proTop + retStr);
					}else if(retLvl == '최상'){
						$("#pwBest").empty();
						$("#pwBest").attr("style","display:block; width: 320px;");
						$("#pwBest").append(progress + proBest + retStr);
					}
					$("#pwLvl").text(retLvl);
					$("#pwInfo").text(retStr);
					$("#pwBox").attr("style","display:block;");
					//if(result.valNull != null) retStr = result.valNull;
			});
		}else{
			$("#pwLow").attr("style","display:none;");
			$("#pwMid").attr("style","display:none;");
			$("#pwTop").attr("style","display:none;");
			$("#pwBest").attr("style","display:none;");
		}
	});
	
	<c:if test="${registerFlag == '수정'}">		
		$("#rank").val("${rankId}");		
	</c:if>
	
	$("#orgId").change(function(){
		var orgId = $(this).val();
		$("#rank").empty();
		$("#rank").append("<option value=' '>--선택하세요--</option>");
		$("#rank").select2();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/cms/sub2/0102_Ajax.do' />",
			data:"orgId="+orgId
		}).done(function(data){			
			var json = JSON.parse(data);
			json = json[0];			
			if(json.length > 0){				
				for(var i=0; i<json.length; i++){					
					$("#rank").append("<option value="+json[i].rankId+">"+json[i].rankName+"</option>");									
				}				
			}
		});
	});
	
	//담당자 정렬
	<c:if test="${registerFlag == '등록'}">
		$("#odr").val(0);
	</c:if>
	
	//유형 기본셋팅
	var typeId = $("#typeId option:selected").val();
	var personal = "${mbrInfo['personal']}";
	var profit = "${mbrInfo['profit']}";
	var nonprofit = "${mbrInfo['nonprofit']}";
	var organization = "${mbrInfo['organization']}";
	if(personal != 0){
		$("#groupType1").attr("checked",true);
	}else if(personal == 0 && profit != 0){
		$("#groupType2").attr("checked",true);
	}else if(personal == 0 && profit == 0 && nonprofit != 0){
		$("#groupType3").attr("checked",true);
	}else if(personal == 0 && profit == 0 && nonprofit == 0 && organization != 0){
		$("#groupType4").attr("checked",true);
	}	
	
	
	if(typeId == '30006'){
		var groupType = $("input:radio[name='groupType']:checked").val();
		Jnit_groupType(groupType);
	}else{
		Jnit_typeClass();
	}
	
	$("#typeId").change(function(){
		typeId = $("#typeId option:selected").val();
		
		if(typeId == '30006'){
			var groupType = $("input:radio[name='groupType']:checked").val();
			Jnit_groupType(groupType);
		}else{
			Jnit_typeClass();
		}
	});
	$("input:radio[name='groupType']").click(function(){
		var groupType = $("input:radio[name='groupType']:checked").val();
		Jnit_groupType(groupType);
	});
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
                   		<h3>회원 등록</h3>
						<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						<a href="javascript:member_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
						<c:if test="${registerFlag == '수정'}">
						<a href="javascript:member_del();" class="btn btn-small btn-del" style="float:right;"><i class="icon-minus-sign"></i> 삭제</a>
						</c:if>
                    </div>
					<div class="widget-content nopadding">
						<form:form commandName="jnitcmsmbrVO" name="jnitcmsmbrVO">
							<input type="hidden" name="retTypeId" id="retTypeId" value="${retTypeId }" />
							<c:if test="${registerFlag == '수정'}">
								<input type="hidden" name="screenMode" value="up" />
								<input type="hidden" id="mbrPhoto" name="mbrPhoto" value="<c:out value='${jnitcmsmbrVO.mbrPhoto}'/>" />
							</c:if>
							<c:if test="${registerFlag == '등록'}">
								<input type="hidden" name="screenMode" value="" />
								<input type="hidden" id="mbrPhoto" name="mbrPhoto" value="" />
							</c:if>
							<table class="table table-bordered table-striped th_left" summary="회원 등록">
						        <tbody>
						            <tr>
						                <th style="width:110px;"><font color="red">*</font> 아이디</th>
						                <td>
						                <c:if test="${registerFlag == '수정'}">
						                <c:out value='${jnitcmsmbrVO.mbrLogin}'/>
						                <input type="hidden" id="mbrId" name="mbrId" value="<c:out value='${jnitcmsmbrVO.mbrId}'/>" />
						                <input type="hidden" id="mbrLogin" name="mbrLogin" value="<c:out value='${jnitcmsmbrVO.mbrLogin}'/>" />
						                </c:if>
						                <c:if test="${registerFlag == '등록'}">
						                <input type="text" id="mbrLogin" name="mbrLogin" value="<c:out value='${jnitcmsmbrVO.mbrLogin}'/>" />
						                </c:if>
						                &nbsp;<form:errors path="mbrLogin" />
						                <c:out value="${mbrLoginMsg}" />
						                </td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 이름</th>
						                <td>
						                <input type="text" id="mbrNm" name="mbrNm" value="<c:out value='${jnitcmsmbrVO.mbrNm}'/>" /> <strong>*실명인증,G-PIN인증회원의 경우 절대 수정하지마세요</strong>
						                <%--
						                <c:if test="${registerFlag == '수정'}">
						                <c:out value='${jnitcmsmbrVO.mbrNm}'/>
						                <input type="hidden" id="mbrNm" name="mbrNm" value="<c:out value='${jnitcmsmbrVO.mbrNm}'/>" />
						                </c:if>
						                <c:if test="${registerFlag == '등록'}">
						                <input type="text" id="mbrNm" name="mbrNm" value="<c:out value='${jnitcmsmbrVO.mbrNm}'/>" />
						                </c:if>
						                &nbsp;<form:errors path="mbrNm" />
						                --%>
						                </td>
						            </tr>
						            <c:if test="${mbrInfo['tel'] != 0 }">
						            <tr>
						                <th>일반 전화번호</th>
						                <td><form:input path="tel" cssClass="txt"/></td>
						            </tr>
						            </c:if>
						            <c:if test="${mbrInfo['phone'] != 0 }">
						            <tr>
						                <th>휴대폰</th>
						                <td><form:input path="mobile" cssClass="txt"/>
						                &nbsp;<form:errors path="mobile" /></td>
						            </tr>
						            </c:if>
						            <c:if test="${mbrInfo['email'] != 0 }">
						            <tr>
						                <th>이메일</th>
						                <td><form:input path="email" cssClass="txt" style="width:300px;"/>
						                &nbsp;<form:errors path="email" /></td>
						            </tr>
						            </c:if>						            
						            <tr>
						                <th>홈페이지</th>
						                <td><form:input path="homepage" cssClass="txt" style="width:300px;"/>
						                &nbsp;<form:errors path="homepage" /></td>
						            </tr>
						            <c:if test="${mbrInfo['post'] != 0 }">
						            <tr>
						                <th>우편번호</th>
						                <td><form:input path="postcode" cssClass="txt" style="width:70px;"/>
						                &nbsp;<form:errors path="postcode" /><button class="btn btn-mini" id="postFind">주소찾기</button></td>
						            </tr>
						            </c:if>
						            <c:if test="${mbrInfo['addr'] != 0 }">
						            <tr>
						                <th>주소</th>
						                <td><form:input path="address" cssClass="txt" style="width:300px;"/>
						                &nbsp;<form:errors path="address" /><input type="hidden" name="address04" /></td>
						            </tr>
						            </c:if>
						            <tr>
						                <th>담당업무</th>
						                <td>
						                	<form:input path="workContents" cssClass="txt" style="width:300px;"/>
						                	&nbsp;<form:errors path="workContents" />
						                <%-- <form:textarea path="workContents" rows="8" cssClass="txt" style="width:98%;"/>
						                &nbsp;<form:errors path="workContents" /> --%>
						                </td>
						            </tr>
						            <tr>
						                <th>담당업무정렬순서</th>
						                <td>
						                	<form:input path="odr" id="odr" cssClass="txt" style="width:300px;"/>
						                	&nbsp;<form:errors path="odr" />
						                <%-- <form:textarea path="workContents" rows="8" cssClass="txt" style="width:98%;"/>
						                &nbsp;<form:errors path="workContents" /> --%>
						                </td>
						            </tr>						            
						            <c:if test="${mbrInfo['emailRecv'] != 0 }">
						            <tr>
						                <th>메일수신동의</th>
						                <td>
						                <form:checkbox path="emailRecv" value="1" cssClass="txt"/>
						                &nbsp;</td>
						            </tr>
						            </c:if>						            
						            <c:if test="${mbrInfo['smsRecv'] != 0 }">
						            <tr>
						                <th>SMS수신동의</th>
						                <td>
						                <form:checkbox path="smsRecv" value="1" cssClass="txt"/>
						                &nbsp;</td>
						            </tr>
						            </c:if>
						            <c:if test="${mbrInfo['ex01Add'] != 0 }">
						            <tr class="typeClass" style="display: none;">
						                <th>${mbrInfo['ex01'] == '' ? '여분필드1' : mbrInfo['ex01']}</th>
						                <td><form:input path="ex01"/></td>
						            </tr>
						            </c:if>
									<c:if test="${mbrInfo['ex02Add'] != 0 }">
						            <tr class="typeClass" style="display: none;">
						                <th>${mbrInfo['ex02'] == '' ? '여분필드2' : mbrInfo['ex02']}</th>
						                <td><form:input path="ex02"/></td>
						            </tr>
						            </c:if>
									<c:if test="${mbrInfo['ex03Add'] != 0 }">
						            <tr class="typeClass" style="display: none;">
						                <th>${mbrInfo['ex03'] == '' ? '여분필드3' : mbrInfo['ex03']}</th>
						                <td><form:input path="ex03"/></td>
						            </tr>
						            </c:if>
						            <tr class="typeClass2" style="display: none;">
						            	<th>단체종류선택</th>
						            	<td>
						            		<c:if test="${mbrInfo['personal'] != 0 }">
						            		<input type="radio" id="groupType1" name="groupType" value="개인"> 개인사업자
						            		</c:if>
						            		<c:if test="${mbrInfo['profit'] != 0 }">
						            		<input type="radio" id="groupType2" name="groupType" value="영리"> 영리 법인
						            		</c:if>
						            		<c:if test="${mbrInfo['nonprofit'] != 0 }">
						            		<input type="radio" id="groupType3" name="groupType" value="비영리"> 비영리 법인
						            		</c:if>
						            		<c:if test="${mbrInfo['organization'] != 0 }">
						            		<input type="radio" id="groupType4" name="groupType" value="공식"> 공식 단체
						            		</c:if>
						            	</td>
						            </tr>
						            <tr class="typeClass3" style="display: none;">
						                <th><font color="red">사업자번호</font></th>
						                <td>
						                	<form:input path="establishment"/>
						                </td>
						            </tr>
						            <tr class="typeClass4" style="display: none;">
						                <th><font color="red">법인등록번호</font></th>
						                <td>
						                <form:input path="corporation"/>
						                &nbsp;</td>
						            </tr>
						            <tr class="typeClass5" style="display: none;">
						                <th><font color="red">고유번호</font></th>
						                <td>
						                <form:input path="primaryKey"/>
						                &nbsp;</td>
						            </tr>
						            <%--
						            <c:if test="${mbrInfo['tel'] != 0 }"> 
						            <tr class="typeClass" style="display: none;">
						                <th width="30%">상호</th>
						                <td>
						                <form:input path="mutual"/>
						                &nbsp;</td>
						            </tr>
						            </c:if>
						             --%>						            
						            <c:if test="${mbrInfo['corporateName'] != 0 }">
						            <tr class="typeClass" style="display: none;">
						                <th>법인명(단체명)</th>
						                <td>
						                <form:input path="corporateName"/>
						                &nbsp;</td>
						            </tr>
						            </c:if>
						            <c:if test="${mbrInfo['groupName'] != 0 }">
						            <tr class="typeClass" style="display: none;">
						                <th>대표자명</th>
						                <td>
						                <form:input path="groupName"/>
						                &nbsp;</td>
						            </tr>
						            </c:if>
						            <c:if test="${mbrInfo['businessPlace'] != 0 }">
						            <tr class="typeClass" style="display: none;">
						                <th>사업장 소재지</th>
						                <td>
							                <form:input path="businessPlace"/><button class="btn btn-mini" id="businessPostFind">주소찾기</button>							                							             
						                </td>
						            </tr>
						            </c:if>
						            <c:if test="${mbrInfo['businessAddr'] != 0 }">
						            <tr class="typeClass" style="display: none;">
						                <th>사업장 구주소</th>
						                <td>
						                <form:input path="businessAddr" cssStyle="width:98%;"/>
						                &nbsp;</td>
						            </tr>
						            </c:if>
						            <c:if test="${mbrInfo['businessAddr'] != 0 }">
						            <tr class="typeClass" style="display: none;">
						                <th>사업장 신주소</th>
						                <td>
						                <form:input path="businessAddrNew" cssStyle="width:98%;"/>
						                &nbsp;</td>
						            </tr>
						            </c:if>
						            <c:if test="${mbrInfo['groupKind'] != 0 }">
						            <tr class="typeClass" style="display: none;">
						                <th>대표 종목</th>
						                <td>
						                <form:input path="groupKind"/>
						                &nbsp;</td>
						            </tr>
						            </c:if>
						            <c:if test="${mbrInfo['groupTel'] != 0 }">
						            <tr class="typeClass" style="display: none;">
						                <th>대표 전화번호</th>
						                <td>
						                <form:input path="groupTel"/>
						                &nbsp;</td>
						            </tr>
						            </c:if>
						            <c:if test="${mbrInfo['groupPax'] != 0 }">
						            <tr class="typeClass" style="display: none;">
						                <th>대표 팩스</th>
						                <td>
						                <form:input path="groupPax"/>
						                &nbsp;</td>
						            </tr>
						            </c:if>
						            <c:if test="${mbrInfo['groupTitle'] != 0 }">
						            <tr class="typeClass" style="display: none;">
						                <th>회사명</th>
						                <td>
						                <form:input path="groupTitle"/>
						                &nbsp;</td>
						            </tr>
						            </c:if>
						            <c:if test="${mbrInfo['gradeNm'] != 0 }">
						            <tr class="typeClass" style="display: none;">
						                <th>직책</th>
						                <td>
						                <form:input path="gradeNm"/>
						                &nbsp;</td>
						            </tr>
						            </c:if>
						            <tr>
						                <th><font color="red"></font> 부서</th>
						                <td>
						                <form:select path="orgId" id="orgId" title="부서">
						                <form:option value=" ">--선택하세요--</form:option>
						                <form:options items="${orgId_result}" itemValue="code" itemLabel="codeNm"/>
						                </form:select>
						                &nbsp;<form:errors path="orgId" />
						                </td>
						            </tr>
						            <tr>
						                <th><font color="red"></font> 직급분류명</th>
						                <td>
						                	<select name="rank" id="rank">
						                		<option value=" ">--선택하세요--</option>
						                		<c:if test="${registerFlag == '수정'}">
						                			<c:forEach var="rank" items="${rankList }">
						                				<option value="${rank.rankId }"><c:out value="${rank.rankName }" /></option>
						                			</c:forEach>
						                		</c:if>						                	
						                	</select>
						                </td>
						            </tr>
						            <tr>
						                <th><font color="red"></font> 직급</th>
						                <td>
						                <!-- form:input path="posId" cssClass="txt"/ -->
						                <form:select path="posId" id="posId" title="직급">
						                <form:option value=" " >--선택하세요--</form:option>
						                <form:options items="${posId_result}" itemValue="code" itemLabel="codeNm"/>
						                </form:select>
						                &nbsp;<form:errors path="posId" />
						                </td>
						            </tr>						            
						            <tr>
						                <th><font color="red">*</font> 유형</th>
						                <td>
						                <!-- form:input path="typeId" cssClass="txt"/ -->
						                <form:select path="typeId" id="typeId" title="회원유형">
						                <form:option value=" ">--선택하세요--</form:option>
						                <form:options items="${typeId_result}" itemValue="code" itemLabel="codeNm"/>
						                </form:select>
						                &nbsp;<form:errors path="typeId" />
						                </td>
						            </tr>
						            <tr class="typeClass1" style="display: none;">
						            	<th><font color="red">*</font> <span class="confirm">단체 회원가입 승인 여부</span></th>
						            	<td>
						            	<form:select path="grpConfirm">
							            	<form:option value="Y" label="인증"></form:option>
							            	<form:option value="N" label="비인증"></form:option>
						            	</form:select>
						            	</td>
						            </tr>	
						            <c:if test="${registerFlag == '등록'}">
						            <tr>
						                <th><font color="red">*</font> 패스워드</th>
						                <td><input name="passwd" id="passwd" type="password" />
						                &nbsp;<form:errors path="passwd" />
						                <div id="pwLow" class="alert alert-error" style="display: none;">
						
										</div>
						
										<div id="pwMid" class="alert alert-block" style="display: none;">
						
										</div>
						
										<div id="pwTop" class="alert alert-success" style="display: none;">
						
										</div>
						
										<div id="pwBest" class="alert alert-info" style="display: none;">
						
										</div>
										<br />
										- 영문, 숫자, 특수문자로 조합된 10~16자 이내로 써주시기 바랍니다. <br />
										- 특수문자 하나이상포함해야합니다. <br />
										- 허용되는 특수문자 : ! @ # $ % ^ & * ( ) _ - + ~ ` { } < > ? : \ " ; '
						                </td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 패스워드 확인</th>
						                <td><input name="passwdConfirm" id="passwdConfirm" type="password" /></td>
						            </tr>
						            </c:if>
						            <c:if test="${registerFlag == '수정'}">
						            <tr>
						                <th><font color="red">*</font> 변경할 패스워드</th>
						                <td><input name="passwd" id="passwd" type="password" />
						                &nbsp;<form:errors path="passwd" />
						                <div id="pwLow" class="alert alert-error" style="display: none;">
						
										</div>
						
										<div id="pwMid" class="alert alert-block" style="display: none;">
						
										</div>
						
										<div id="pwTop" class="alert alert-success" style="display: none;">
						
										</div>
						
										<div id="pwBest" class="alert alert-info" style="display: none;">
						
										</div>
										<br />
										- 영문, 숫자, 특수문자로 조합된 10~16자 이내로 써주시기 바랍니다. <br />
										- 특수문자 하나이상포함해야합니다. <br />
										- 허용되는 특수문자 : ! @ # $ % ^ & * ( ) _ - + ~ ` { } < > ? : \ " ; '
						                </td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 패스워드 확인</th>
						                <td><input name="passwdConfirm" id="passwdConfirm" type="password" /></td>
						            </tr>
						            </c:if>
						        </tbody>
					    	</table>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>						  

<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
