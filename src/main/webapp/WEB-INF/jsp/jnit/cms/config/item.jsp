<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javascript" src="<c:url value="/resources/js/jnit.member.js" />" ></script>

<script type="text/javascript">
function fn_egov_save() {
	
	if(fn_validate()){
		frm = document.getElementById("jnitmbrInfoVO");	
		frm.action = "<c:url value='/cms/config/itemSave.do'/>";
	    frm.submit();
	}
}

function fn_validate(){
	var ex01 = $('#ex01').val();
	var ex02 = $('#ex02').val();
	var ex03 = $('#ex03').val();
	
	if($("input[id='ex01Add']:checked").val() != 0){
		if(ex01 == '' || ex01 == null){
			alert('추가입력 1 부분이 비어있습니다.');
			$('#ex01').focus();
			return false;
		}
		if($('#ex01Type').val() != '0' && $('#ex01Type').val() != 'text' && $('#ex01Type').val() != 'multiinput'){
			if($('#ex01TypeFields').val() == '' || $('#ex01TypeFields').val() == null){
				alert('추가입력 1 항목들을 콤마(,)로 구분하여 적어주시기 바랍니다.');
				$('#ex01TypeFields').focus();
				return false;
			} 
		}
	}
	
	if($("input[id='ex02Add']:checked").val() != 0){
		if(ex02 == '' || ex02 == null){
			alert('추가입력 2 부분이 비어있습니다.');
			$('#ex02').focus();
			return false;
		}
		if($('#ex02Type').val() != '0' && $('#ex02Type').val() != 'text' && $('#ex02Type').val() != 'multiinput'){
			if($('#ex02TypeFields').val() == '' || $('#ex02TypeFields').val() == null){
				alert('추가입력 2 항목들을 콤마(,)로 구분하여 적어주시기 바랍니다.');
				$('#ex02TypeFields').focus();
				return false;
			} 
		}
	}
	
	if($("input[id='ex03Add']:checked").val() != 0){
		if(ex03 == '' || ex03 == null){
			alert('추가입력 3 부분이 비어있습니다.');
			$('#ex03').focus();
			return false;
		}
		
		if($('#ex03Type').val() != '0' && $('#ex03Type').val() != 'text' && $('#ex03Type').val() != 'multiinput'){
			if($('#ex03TypeFields').val() == '' || $('#ex03TypeFields').val() == null){
				alert('추가입력 3 항목들을 콤마(,)로 구분하여 적어주시기 바랍니다.');
				$('#ex03TypeFields').focus();
				return false;
			} 
		}
	}
	return true;
}

$(document).ready(function(){
	// ex01
	var ex01Type = "${resultProp['ex01Type']}";	
	$('#ex01Type').val(ex01Type);
	
	if($("input[id='ex01Add']:checked").val() == 0){  //기본셋팅 jquery		
		$('#divEx01Type').hide();
		$('#divEx01TypeFields').hide();
	}else{		
		if($('#ex01Type').val() == 'text' || $('#ex01Type').val() == '0' || $('#ex01Type').val() == 'multiinput'){
			$('#divEx01Type').show();
			$('#divEx01TypeFields').hide();
		}else{
			$('#divEx01Type').show();
			$('#divEx01TypeFields').show();
		}			
	}
	
	$("input[id='ex01Add']").change(function(){ //사용여부 function		
		if($("input[id='ex01Add']:checked").val() == 0){		
			$('#divEx01Type').hide();
			$('#divEx01TypeFields').hide();
		}else{
			
			if($('#ex01Type').val() == 'text' || $('#ex01Type').val() == '0' || $('#ex01Type').val() == 'multiinput'){
				$('#divEx01Type').show();
				$('#divEx01TypeFields').hide();
			}else{
				$('#divEx01Type').show();
				$('#divEx01TypeFields').show();
			}			
		}
	});
	
	$('#ex01Type').change(function(){  //타입 변경 function
		if($('#ex01Type').val() == 'text' || $('#ex01Type').val() == '0' || $('#ex01Type').val() == 'multiinput'){
			$('#divEx01Type').show();
			$('#divEx01TypeFields').hide();
		}else{
			$('#divEx01Type').show();
			$('#divEx01TypeFields').show();
		}
	});	
	// end ex01
	
	// ex02
	var ex02Type = "${resultProp['ex02Type']}";	
	$('#ex02Type').val(ex02Type);
	
	if($("input[id='ex02Add']:checked").val() == 0){  //기본셋팅 jquery		
		$('#divEx02Type').hide();
		$('#divEx02TypeFields').hide();
	}else{		
		if($('#ex02Type').val() == 'text' || $('#ex02Type').val() == '0' || $('#ex02Type').val() == 'multiinput'){
			$('#divEx02Type').show();
			$('#divEx02TypeFields').hide();
		}else{
			$('#divEx02Type').show();
			$('#divEx02TypeFields').show();
		}			
	}
	
	$("input[id='ex02Add']").change(function(){ //사용여부 function		
		if($("input[id='ex02Add']:checked").val() == 0){		
			$('#divEx02Type').hide();
			$('#divEx02TypeFields').hide();
		}else{
			
			if($('#ex02Type').val() == 'text' || $('#ex02Type').val() == '0' || $('#ex02Type').val() == 'multiinput'){
				$('#divEx02Type').show();
				$('#divEx02TypeFields').hide();
			}else{
				$('#divEx02Type').show();
				$('#divEx02TypeFields').show();
			}			
		}
	});
	
	$('#ex02Type').change(function(){  //타입 변경 function
		if($('#ex02Type').val() == 'text' || $('#ex02Type').val() == '0' || $('#ex02Type').val() == 'multiinput'){
			$('#divEx02Type').show();
			$('#divEx02TypeFields').hide();
		}else{
			$('#divEx02Type').show();
			$('#divEx02TypeFields').show();
		}
	});
	// end ex02
	
	// ex03
	var ex03Type = "${resultProp['ex03Type']}";	
	$('#ex03Type').val(ex03Type);
	
	if($("input[id='ex03Add']:checked").val() == 0){  //기본셋팅 jquery		
		$('#divEx03Type').hide();
		$('#divEx03TypeFields').hide();
	}else{		
		if($('#ex03Type').val() == 'text' || $('#ex03Type').val() == '0' || $('#ex03Type').val() == 'multiinput'){
			$('#divEx03Type').show();
			$('#divEx03TypeFields').hide();
		}else{
			$('#divEx03Type').show();
			$('#divEx03TypeFields').show();
		}			
	}
	
	$("input[id='ex03Add']").change(function(){ //사용여부 function		
		if($("input[id='ex03Add']:checked").val() == 0){		
			$('#divEx03Type').hide();
			$('#divEx03TypeFields').hide();
		}else{
			
			if($('#ex03Type').val() == 'text' || $('#ex03Type').val() == '0' || $('#ex03Type').val() == 'multiinput'){
				$('#divEx03Type').show();
				$('#divEx03TypeFields').hide();
			}else{
				$('#divEx03Type').show();
				$('#divEx03TypeFields').show();
			}			
		}
	});
	
	$('#ex03Type').change(function(){  //타입 변경 function
		if($('#ex03Type').val() == 'text' || $('#ex03Type').val() == '0' || $('#ex03Type').val() == 'multiinput'){
			$('#divEx03Type').show();
			$('#divEx03TypeFields').hide();
		}else{
			$('#divEx03Type').show();
			$('#divEx03TypeFields').show();
		}
	});
	// end ex03
});


function Jnit_item_question(num){
	var baseId = "JnitItemQuestion"+num;
	var baseObject = $("#"+baseId);
	var displayState = baseObject.css("display");
	
	if(displayState == "none"){
		baseObject.show();
	}else{
		baseObject.hide();
	}
}
</script>

<form:form commandName="jnitmbrInfoVO" method="post">			<!--<c:url value='/cms/config/itemSave.do'/>-->			
	<div id="content">
		<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
		<div class="content_view container-fluid">
			<%-- Contents Start --%>
			<div class="row-fluid">
				<div class="span12">
				<c:if test="${!empty message }">
					<strong><font color="red">${message }</font></strong>							
				</c:if>	
				<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-cog"></i></span>
							<!-- <button type="submit" class="btn btn-small"><i class="icon icon-ok"></i> 저장</button> -->
							<a href="javascript:fn_egov_save();" class="btn btn-small">저장</a>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped th_left">								
								<tbody>									 
									<tr>
										<th colspan="4">개인회원 가입항목 입력</th>										
									</tr>
									<%-- <tr>
										<th>회사 주소</th>
										<td>
											<input type="text" name="companyAddr" id="tel" value="${resultProp['companyAddr'] != '' ? resultProp['companyAddr'] : ''}" />
										</td>
									</tr> --%>
									<tr>
										<th colspan="2" style="width: 13%;">아이디</th>
										<td>필수입력</td>
									</tr>
									<tr>
										<th colspan="2">성명</th>
										<td>필수입력</td>
									</tr>
									<tr>
										<th colspan="2">일반전화번호</th>
										<td>
											<input type="radio" name="tel" id="tel0" value="0" <c:out value="${resultProp['tel'] == '0' ? 'checked' : ''}"/>><label for="tel0">사용안함</label> 
											<input type="radio" name="tel" id="tel1" value="1" ${resultProp['tel'] == '1' ? 'checked' : ''}/><label for="tel1">선택</label> 
											<input type="radio" name="tel" id="tel2" value="2" ${resultProp['tel'] == '2' ? 'checked' : ''}/><label for="tel2">필수</label>
										</td>																				
									</tr>
									<tr>
										<th colspan="2">휴대폰</th>
										<td>
											<input type="radio" name="phone" id="phone0" value="0" ${resultProp['phone'] == '0' ? 'checked' : ''}/><label for="phone0">사용안함</label> 
											<input type="radio" name="phone" id="phone1" value="1" ${resultProp['phone'] == '1' ? 'checked' : ''}/><label for="phone1">선택</label> 
											<input type="radio" name="phone" id="phone2" value="2" ${resultProp['phone'] == '2' ? 'checked' : ''}/><label for="phone2">필수</label> 
										</td>										
									</tr>
									<tr>
										<th colspan="2">이메일</th>
										<td>
											<input type="radio" name="email" id="email0" value="0" ${resultProp['email'] == '0' ? 'checked' : ''}/><label for="email0">사용안함</label> 
											<input type="radio" name="email" id="email1" value="1" ${resultProp['email'] == '1' ? 'checked' : ''}/><label for="email1">선택</label>
											<input type="radio" name="email" id="email2" value="2" ${resultProp['email'] == '2' ? 'checked' : ''}/><label for="email2">필수</label>
										</td>										
									</tr>
									<tr>
										<th colspan="2">우편번호</th>
										<td>
											<input type="radio" name="post" id="post0" value="0" ${resultProp['post'] == '0' ? 'checked' : ''}/><label for="post0">사용안함</label>
											<input type="radio" name="post" id="post1" value="1" ${resultProp['post'] == '1' ? 'checked' : ''}/><label for="post1">선택</label>
											<input type="radio" name="post" id="post2" value="2" ${resultProp['post'] == '2' ? 'checked' : ''}/><label for="post2">필수</label>
										</td>										
									</tr>
									<tr>
										<th colspan="2">주소</th>
										<td>
											<input type="radio" name="addr" id="addr0" value="0" ${resultProp['addr'] == '0' ? 'checked' : ''}/><label for="addr0">사용안함</label>
											<input type="radio" name="addr" id="addr1" value="1" ${resultProp['addr'] == '1' ? 'checked' : ''}/><label for="addr1">선택</label>
											<input type="radio" name="addr" id="addr2" value="2" ${resultProp['addr'] == '2' ? 'checked' : ''}/><label for="addr2">필수</label>					
										</td>										
									</tr>
									<tr>
										<th colspan="2">메일수신동의</th>
										<td>
											<input type="radio" name="emailRecv" id="emailRecv0" value="0" ${resultProp['emailRecv'] == '0' ? 'checked' : ''}/><label for="emailRecv0">사용안함</label>
											<input type="radio" name="emailRecv" id="emailRecv1" value="1" ${resultProp['emailRecv'] == '1' ? 'checked' : ''}/><label for="emailRecv1">선택</label>
											<input type="radio" name="emailRecv" id="emailRecv2" value="2" ${resultProp['emailRecv'] == '2' ? 'checked' : ''}/><label for="emailRecv2">필수</label>
										</td>										
									</tr>
									<tr>
										<th colspan="2">SMS 수신동의</th>
										<td>
											<input type="radio" name="smsRecv" id="smsRecv0" value="0" ${resultProp['smsRecv'] == '0' ? 'checked' : ''}/><label for="smsRecv0">사용안함</label>
											<input type="radio" name="smsRecv" id="smsRecv1" value="1" ${resultProp['smsRecv'] == '1' ? 'checked' : ''}/><label for="smsRecv1">선택</label>
											<input type="radio" name="smsRecv" id="smsRecv2" value="2" ${resultProp['smsRecv'] == '2' ? 'checked' : ''}/><label for="smsRecv2">필수</label>
										</td>										
									</tr>									 									
									<tr>
										<th colspan="5">단체회원 가입 항목</th>
									</tr>									
									<tr>
										<th rowspan="4">구분</th>
										<th>개인 사업자</th>
										<td>
											<input type="radio" name="personal" id="personal0" value="0" ${resultProp['personal'] == '0' ? 'checked' : ''}/><label for="personal0">사용안함</label>
											<input type="radio" name="personal" id="personal1" value="1" ${resultProp['personal'] == '1' ? 'checked' : ''}/><label for="personal1">선택</label>
											<input type="radio" name="personal" id="personal2" value="2" ${resultProp['personal'] == '2' ? 'checked' : ''}/><label for="personal2">필수</label>
											사업자번호 필수입력										
										</td>																			 
									</tr>
									<tr>
										<th>영리 법인</th>
										<td>
											<input type="radio" name="profit" id="profit0" value="0" ${resultProp['profit'] == '0' ? 'checked' : ''}/><label for="profit0">사용안함</label>
											<input type="radio" name="profit" id="profit1" value="1" ${resultProp['profit'] == '1' ? 'checked' : ''}/><label for="profit1">선택</label>
											<input type="radio" name="profit" id="profit2" value="2" ${resultProp['profit'] == '2' ? 'checked' : ''}/><label for="profit2">필수</label>
											사업자번호 법인등록번호 필수입력											
										</td>										
									</tr>
									<tr>
										<th>비영리 법인</th>
										<td>
											<input type="radio" name="nonprofit" id="nonprofit0" value="0" ${resultProp['nonprofit'] == '0' ? 'checked' : ''}/><label for="nonprofit0">사용안함</label>
											<input type="radio" name="nonprofit" id="nonprofit1" value="1" ${resultProp['nonprofit'] == '1' ? 'checked' : ''}/><label for="nonprofit1">선택</label>
											<input type="radio" name="nonprofit" id="nonprofit2" value="2" ${resultProp['nonprofit'] == '2' ? 'checked' : ''}/><label for="nonprofit2">필수</label>
											사업자번호 법인등록번호 고유번호 필수입력
										</td>										
									</tr>
									<tr>
										<th>공식단체</th>
										<td>
											<input type="radio" name="organization" id="organization0" value="0" ${resultProp['organization'] == '0' ? 'checked' : ''}/><label for="organization0">사용안함</label>
											<input type="radio" name="organization" id="organization1" value="1" ${resultProp['organization'] == '1' ? 'checked' : ''}/><label for="organization1">선택</label>
											<input type="radio" name="organization" id="organization2" value="2" ${resultProp['organization'] == '2' ? 'checked' : ''}/><label for="organization2">필수</label>
											고유번호 필수입력											
										</td>										
									</tr>									
									<%-- <tr>
										<th>상호</th>
										<td>
											사용안함<input type="radio" name="mutual" id="mutual" value="0" ${resultProp['mutual'] == '0' ? 'checked' : ''}/>
											선택<input type="radio" name="mutual" id="mutual" value="1" ${resultProp['mutual'] == '1' ? 'checked' : ''}/>
											필수<input type="radio" name="mutual" id="mutual" value="2" ${resultProp['mutual'] == '2' ? 'checked' : ''}/>											
										</td>										
									</tr> --%>
									<tr>
										<th rowspan="9">공통입력항목</th>
										<th>법인명(단체명)</th>
										<td>
											<input type="radio" name="corporateName" id="corporateName0" value="0" ${resultProp['corporateName'] == '0' ? 'checked' : ''}/><label for="corporateName0">사용안함</label>
											<input type="radio" name="corporateName" id="corporateName1" value="1" ${resultProp['corporateName'] == '1' ? 'checked' : ''}/><label for="corporateName1">선택</label>
											<input type="radio" name="corporateName" id="corporateName2" value="2" ${resultProp['corporateName'] == '2' ? 'checked' : ''}/><label for="corporateName2">필수</label>										
										</td>										
									</tr>
									<tr>
										<th>대표자명</th>
										<td>
											<input type="radio" name="groupName" id="groupName0" value="0" ${resultProp['groupName'] == '0' ? 'checked' : ''}/><label for="groupName0">사용안함</label>
											<input type="radio" name="groupName" id="groupName1" value="1" ${resultProp['groupName'] == '1' ? 'checked' : ''}/><label for="groupName1">선택</label>
											<input type="radio" name="groupName" id="groupName2" value="2" ${resultProp['groupName'] == '2' ? 'checked' : ''}/><label for="groupName2">필수</label>										
										</td>										
									</tr>
									<tr>
										<th>사업장 소재지</th>
										<td>
											<input type="radio" name="businessPlace" id="businessPlace0" value="0" ${resultProp['businessPlace'] == '0' ? 'checked' : ''}/><label for="businessPlace0">사용안함</label>
											<input type="radio" name="businessPlace" id="businessPlace1" value="1" ${resultProp['businessPlace'] == '1' ? 'checked' : ''}/><label for="businessPlace1">선택</label>
											<input type="radio" name="businessPlace" id="businessPlace2" value="2" ${resultProp['businessPlace'] == '2' ? 'checked' : ''}/><label for="businessPlace2">필수</label>						
										</td>
										
									</tr>
									<tr>
										<th>사업장 주소</th>
										<td>
											<input type="radio" name="businessAddr" id="businessAddr0" value="0" ${resultProp['businessAddr'] == '0' ? 'checked' : ''}/><label for="businessAddr0">사용안함</label>
											<input type="radio" name="businessAddr" id="businessAddr1" value="1" ${resultProp['businessAddr'] == '1' ? 'checked' : ''}/><label for="businessAddr1">선택</label>
											<input type="radio" name="businessAddr" id="businessAddr2" value="2" ${resultProp['businessAddr'] == '2' ? 'checked' : ''}/><label for="businessAddr2">필수</label>
										</td>										
									</tr>
									<tr>
										<th>대표 종목</th>
										<td>
											<input type="radio" name="groupKind" id="groupKind0" value="0" ${resultProp['groupKind'] == '0' ? 'checked' : ''}/><label for="groupKind0">사용안함</label>
											<input type="radio" name="groupKind" id="groupKind1" value="1" ${resultProp['groupKind'] == '1' ? 'checked' : ''}/><label for="groupKind1">선택</label>
											<input type="radio" name="groupKind" id="groupKind2" value="2" ${resultProp['groupKind'] == '2' ? 'checked' : ''}/><label for="groupKind2">필수</label>
										</td>									
									</tr>
									<tr>
										<th>대표 전화번호</th>
										<td>
											<input type="radio" name="groupTel" id="groupTel0" value="0" ${resultProp['groupTel'] == '0' ? 'checked' : ''}/><label for="groupTel0">사용안함</label>
											<input type="radio" name="groupTel" id="groupTel1" value="1" ${resultProp['groupTel'] == '1' ? 'checked' : ''}/><label for="groupTel1">선택</label>
											<input type="radio" name="groupTel" id="groupTel2" value="2" ${resultProp['groupTel'] == '2' ? 'checked' : ''}/><label for="groupTel2">필수</label>
										</td>										
									</tr>									
									<tr>
										<th>대표 팩스</th>
										<td>
											<input type="radio" name="groupPax" id="groupPax0" value="0" ${resultProp['groupPax'] == '0' ? 'checked' : ''}/><label for="groupPax0">사용안함</label>
											<input type="radio" name="groupPax" id="groupPax1" value="1" ${resultProp['groupPax'] == '1' ? 'checked' : ''}/><label for="groupPax1">선택</label>
											<input type="radio" name="groupPax" id="groupPax2" value="2" ${resultProp['groupPax'] == '2' ? 'checked' : ''}/><label for="groupPax2">필수</label>
										</td>										
									</tr>
									<tr>
										<th>회사명</th>
										<td>
											<input type="radio" name="groupTitle" id="groupTitle0" value="0" ${resultProp['groupTitle'] == '0' ? 'checked' : ''}/><label for="groupTitle0">사용안함</label>
											<input type="radio" name="groupTitle" id="groupTitle1" value="1" ${resultProp['groupTitle'] == '1' ? 'checked' : ''}/><label for="groupTitle1">선택</label>
											<input type="radio" name="groupTitle" id="groupTitle2" value="2" ${resultProp['groupTitle'] == '2' ? 'checked' : ''}/><label for="groupTitle2">필수</label>
										</td>
									</tr>
									<tr>
										<th>직책</th>
										<td>
											<input type="radio" name="gradeNm" id="gradeNm0" value="0" ${resultProp['gradeNm'] == '0' ? 'checked' : ''}/><label for="gradeNm0">사용안함</label>
											<input type="radio" name="gradeNm" id="gradeNm1" value="1" ${resultProp['gradeNm'] == '1' ? 'checked' : ''}/><label for="gradeNm1">선택</label>
											<input type="radio" name="gradeNm" id="gradeNm2" value="2" ${resultProp['gradeNm'] == '2' ? 'checked' : ''}/><label for="gradeNm2">필수</label>
										</td>
									</tr>
									<!-- 추가입력 -->									
									<tr>
										<th rowspan="3">추가사항</th>
										<th>
											추가 입력 1</br>
											<input type="text" name="ex01" id="ex01" value="${resultProp['ex01'] }" style="width: 80px;" />											
										</th>
										<td>
											<input type="radio" name="ex01Add" id="ex01Add0" value="0" ${resultProp['ex01Add'] == '0' ? 'checked' : ''}/><label for="ex01Add0">사용안함</label>
											<input type="radio" name="ex01Add" id="ex01Add1" value="1" ${resultProp['ex01Add'] == '1' ? 'checked' : ''}/><label for="ex01Add1">선택</label>
											<input type="radio" name="ex01Add" id="ex01Add2" value="2" ${resultProp['ex01Add'] == '2' ? 'checked' : ''}/><label for="ex01Add2">필수</label>
											
											<div id="divEx01Type">
												<select id="ex01Type" name="ex01Type">
													<option value="0">사용안함</option>
													<option value="text">텍스트 형</option>
													<option value="select">select 형</option>
													<option value="checkbox">check box 형</option>
													<option value="radio">radio 버튼 형</option>
													<option value="multiinput">텍스트-텍스트-텍스트 형</option>
												</select>
											</div>
											<div id="divEx01TypeFields">
												<input type="text" name="ex01TypeFields" id="ex01TypeFields" value="${resultProp['ex01TypeFields'] }" /><br/> 
												<font color="red">항목1, 항목2, 항목3 .... ( 콤마(,)로 구분자를 넣주시기 바랍니다. )</font>
											</div>
										</td>
									</tr>
									<tr>
										<th>
											추가 입력 2</br>
											<input type="text" name="ex02" id="ex02" value="${resultProp['ex02'] }" style="width: 80px;" />
										</th>
										<td>
											<input type="radio" name="ex02Add" id="ex02Add0" value="0" ${resultProp['ex02Add'] == '0' ? 'checked' : ''}/><label for="ex02Add0">사용안함</label>
											<input type="radio" name="ex02Add" id="ex02Add1" value="1" ${resultProp['ex02Add'] == '1' ? 'checked' : ''}/><label for="ex02Add1">선택</label>
											<input type="radio" name="ex02Add" id="ex02Add2" value="2" ${resultProp['ex02Add'] == '2' ? 'checked' : ''}/><label for="ex02Add2">필수</label>
											
											<div id="divEx02Type">
												<select id="ex02Type" name="ex02Type">
													<option value="0">사용안함</option>
													<option value="text">텍스트 형</option>
													<option value="select">select 형</option>
													<option value="checkbox">check box 형</option>
													<option value="radio">radio 버튼 형</option>
													<option value="multiinput">텍스트-텍스트-텍스트 형</option>
												</select>
											</div>
											<div id="divEx02TypeFields">												
												<input type="text" name="ex02TypeFields" id="ex02TypeFields" value="${resultProp['ex02TypeFields'] }" /><br/> 
												<font color="red">항목1, 항목2, 항목3 .... ( 콤마(,)로 구분자를 넣주시기 바랍니다. )</font>
											</div>											
										</td>								
									</tr>
									<tr>
										<th>
											추가 입력 3</br>
											<input type="text" name="ex03" id="ex03" value="${resultProp['ex03'] }" style="width: 80px;" />											
										</th>
										<td>
											<input type="radio" name="ex03Add" id="ex03Add0" value="0" ${resultProp['ex03Add'] == '0' ? 'checked' : ''}/><label for="ex03Add0">사용안함</label>
											<input type="radio" name="ex03Add" id="ex03Add1" value="1" ${resultProp['ex03Add'] == '1' ? 'checked' : ''}/><label for="ex03Add1">선택</label>
											<input type="radio" name="ex03Add" id="ex03Add2" value="2" ${resultProp['ex03Add'] == '2' ? 'checked' : ''}/><label for="ex03Add2">필수</label>
											
											<div id="divEx03Type">
												<select id="ex03Type" name="ex03Type">
													<option value="0">사용안함</option>
													<option value="text">텍스트 형</option>
													<option value="select">select 형</option>
													<option value="checkbox">check box 형</option>
													<option value="radio">radio 버튼 형</option>
													<option value="multiinput">텍스트-텍스트-텍스트 형</option>
												</select>
											</div>
											<div id="divEx03TypeFields">
												<input type="text" name="ex03TypeFields" id="ex03TypeFields" value="${resultProp['ex03TypeFields'] }" /><br/>
												<font color="red">항목1, 항목2, 항목3 .... ( 콤마(,)로 구분자를 넣주시기 바랍니다. )</font>
											</div>
										</td>								
									</tr>
									 <tr>
	                                       <th colspan="2"><label>자동가입 방지 설정</label><a href="javascript:Jnit_item_question('1');"><i class="icon-question-sign"></i></a></th>
	                                       <td>
	                                     		<input type="radio" name="captcha" id="captcha0" value="0" <c:out value="${resultProp['captcha'] == '0' ? 'checked' : ''}"/>><label for="captcha0"> 사용안함</label>
	                                       		<input type="radio" name="captcha" id="captcha1" value="1" <c:out value="${resultProp['captcha'] == '1' ? 'checked' : ''}"/>><label for="captcha1"> 사용함</label>
	                                       		<br />
	                                       		<span id="JnitItemQuestion1" style="display: none;">
													<img src="http://manual.ltskorea.co.kr/upload/editUpload/20170523/2017052320142482097.jpg" alt="자동가입방지 참조 이미지" /><br />
													<strong>&nbsp;- 회원가입시 사용되는 항목입니다.</strong>
												</span>
	                                       </td>
	                                   </tr>
									<!-- End 추가입력 -->										
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<div class="widget-box">
					<div class="widget-content nopadding cmstipbox" >
						<table class="table table-bordered table-striped th_left">
						<caption>cms TIP</caption>
						<tbody>
						<tr>
							<th colspan="2">
								<span class="icon" style=" font-size: 20px; font-weight: bold; "><i class="icon-lightbulb"></i> TIP</span>
							</th>
							<td>
								<b>회원구분은 개인회원과 단체 회원으로 나뉘게 되며 각각의 항목별 제어가 가능합니다.</b>
							</td>
						</tr>
						</tbody>
						</table>
					</div>
				</div>
			</div>
			<%-- Contents End --%>
		</div>
	</div>
</form:form>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>