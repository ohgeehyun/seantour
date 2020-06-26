<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>
<% String errCode = request.getParameter("errCode"); %>
<c:set var="errCode" value="<%= errCode %>" />
<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
	<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
</head>
<script>
$(document).ready(function(){
	if('${travelReservation.openYn}' == 'N'){
		var alertVal = "";
		switch('${travelReservation.reseBeachId}'){
		case 'R0001' : alertVal = "외달도 해수욕장 개장일은 7.11.~8.23. 입니다."; break;
		case 'R0002' : alertVal = "웅천 해수욕장 개장일은 7.11.~8.23. 입니다."; break;
		case 'R0003' : alertVal = "풍류 해수욕장 개장일은 7.10.~8.16. 입니다."; break;
		case 'R0004' : alertVal = "율포솔밭 해수욕장 개장일은 7.11.~8.30. 입니다."; break;
		case 'R0005' : alertVal = "수문 해수욕장 개장일은 7.10.~8.9. 입니다."; break;
		case 'R0006' : alertVal = "송호 해수욕장 개장일은 7.17.~8.9. 입니다."; break;
		case 'R0007' : alertVal = "돌머리 해수욕장 개장일은 7.10.~8.16. 입니다."; break;
		case 'R0008' : alertVal = "가마미 해수욕장 개장일은 7.10.~8.23. 입니다."; break;
		case 'R0009' : alertVal = "송이도 해수욕장 개장일은 7.20.~8.11. 입니다."; break;
		case 'R0010' : alertVal = "신지명사십리 해수욕장 개장일은 7.17.~8.23. 입니다."; break;
		case 'R0011' : alertVal = "금갑 해수욕장 개장일은 7.10.~8.16. 입니다."; break;
		case 'R0012' : alertVal = "대광 해수욕장 개장일은 7.13.~8.16. 입니다."; break;
		case 'R0013' : alertVal = "백길 해수욕장 개장일은 7.13.~8.16. 입니다."; break;
		case 'R0014' : alertVal = "짱뚱어 해수욕장 개장일은 7.13.~8.16. 입니다."; break;
		}
		alert(alertVal);
		return;
	}else if('${travelReservation.reservationYn}' == 'Y'){
		document.getElementById("reserv_wrap").style.display = 'block';
		document.getElementById("reservBtn_box").style.display = 'block';
		document.getElementById("lec_privacy_tit").style.display = 'block';
		document.getElementById("lec_privacy").style.display = 'block';
	}else if('${travelReservation.reservationYn}' == 'N'){
		alert('예약이 불가능 합니다.\n최대수용 인원을 초과 하였습니다.');
		return;
	}
});

function fn_egov_link_page(){
	if($('#month').val() == ""){
		alert('월을 선택해 주세요.');
		return false;
	}
	if($('#day').val() == ""){
		alert('일을 선택해 주세요.');
		return false;
	}
	if($('#reseTime').val() == ""){
		alert('시간을 선택해 주세요.');
		return false;
	}
	
	document.getElementById("travelReservation").action = "<c:url value='/travel/reservation/area.do'/>";
   	document.getElementById("travelReservation").submit();
}

function fn_insert(){
	if($('#resePersonnel').val() == ""){
		alert('인원을 선택해 주세요.');
		return false;
	}
	if($('#reseName').val() == ""){
		alert('이름을 입력해 주세요.');
		$('#reseName').focus();
		return false;
	}
	if($('#reseTel_02').val() == "" || $('#reseTel_03').val() == ""){
		alert('전화번호를 입력해 주세요.');
		if($('#reseTel_02').val() == "") $('#reseTel_02').focus();
		if($('#reseTel_03').val() == "") $('#reseTel_03').focus();
		return false;
	}
	if($('#chkAgree2').prop('checked') == false){
		alert('개인정보 수집에 동의해 주세요.');
		$('#chkAgree2').focus();
		return false;
	}
	
	document.getElementById("travelReservation").action = "<c:url value='/travel/reservation/insert.do'/>";
   	document.getElementById("travelReservation").submit();
}

function fn_display_none(){
	document.getElementById("reserv_wrap").style.display = 'none';
	document.getElementById("reservBtn_box").style.display = 'none';
	document.getElementById("lec_privacy_tit").style.display = 'none';
	document.getElementById("lec_privacy").style.display = 'none';
}
</script>
<body>
	<div id="wrap">
		<div id="accessibility"><a href="#content">본문 바로가기</a></div>
		<!-- header -->
			<%@ include file="/WEB-INF/jsp/travel/tpl/gnb.jsp" %>
		<!-- // header -->

		<!-- contaniner -->
		<div id="container" >

			<%@ include file="/WEB-INF/jsp/travel/tpl/navigation.jsp" %>

        	<div id="content" class="cont_wrap">
        	
        	<form:form commandName="travelReservation" method="post">

			<div class="cont_head">
                <h2 class="title">해수욕장 예약시스템</h2>
            </div><!--// cont_head -->
            <div class="cont_body">
	            <div class="inr">
	            	<!-- 검색 -->
					<div class="bx_srch_event">
						<fieldset>
						<legend>검색</legend>
						<div class="field01">
							<select id="reseBeachRegionCd" name="reseBeachRegionCd" title="지역">
								<c:forEach var="region" items="${regionList}" varStatus="status">
									<option value='<c:out value="${region.reseBeachRegionCd}"/>' <c:if test="${travelReservation.reseBeachRegionCd eq region.reseBeachRegionCd}">selected="selected"</c:if>><c:out value="${region.reseBeachRegion}"/></option>
								</c:forEach>
								<c:if test="${empty regionList}">
									<li>등록된 지역이 없습니다</li>
								</c:if>
				      		</select>
				      		<select id="reseBeachNameCd" name="reseBeachNameCd" title="해수용장" onchange="fn_display_none();">
								<c:forEach var="beach" items="${beachList}" varStatus="status">
									<option value='<c:out value="${beach.reseBeachNameCd}"/>' <c:if test="${travelReservation.reseBeachNameCd eq beach.reseBeachNameCd}">selected="selected"</c:if>><c:out value="${beach.reseBeachName}"/></option>
								</c:forEach>
								<c:if test="${empty beachList}">
									<li>등록된 해수욕장이 없습니다</li>
								</c:if>
				      		</select>
			      		</div>
			      		<div class="field02">
				      		<select id="month" name="month" title="월" onchange="fn_display_none();">
				    	  		<option value="">월선택</option>
					      		<option value="07" <c:if test="${travelReservation.month eq '07'}">selected="selected"</c:if>>7월</option>
					      		<option value="08" <c:if test="${travelReservation.month eq '08'}">selected="selected"</c:if>>8월</option>
				      		</select>
				      		<select id="day" name="day" title="일" onchange="fn_display_none();">
				    	  		<option value="">일선택</option>
				    	  		<c:forEach var="i" begin="1" end="31" step="1">
				    	  			<c:if test="${i lt 10}"><option value="0${i}" <c:if test="${travelReservation.day eq i}">selected="selected"</c:if>>${i}일</option></c:if>
				    	  			<c:if test="${i ge 10}"><option value="${i}" <c:if test="${travelReservation.day eq i}">selected="selected"</c:if>>${i}일</option></c:if>
				    	  		</c:forEach>
				      		</select>
				      		<select id="reseTime" name="reseTime" title="시간" onchange="fn_display_none();">
				    	  		<option value="">시간선택</option>
				    	  		<option value="01" <c:if test="${travelReservation.reseTime eq '01'}">selected="selected"</c:if>>9:00 ~ 12:00</option>
					      		<option value="02" <c:if test="${travelReservation.reseTime eq '02'}">selected="selected"</c:if>>12:00 ~ 15:00</option>
					      		<option value="03" <c:if test="${travelReservation.reseTime eq '03'}">selected="selected"</c:if>>15:00 ~ 18:00</option>
				      		</select>
						</div>
						<div class="btn">
							<a href="javascript:fn_egov_link_page()">검색</a>
						</div>
						</fieldset>
					</div>
					<div class="jn_map"><img src="/seantour_map/images/travel/content/img_jn_map.png" /></div>
					<div class="reserv_wrap" id="reserv_wrap" style="display:none">
	            		<dl class="form_group">
	            			<dt>해수욕장</dt>
	            			<dd>
		            			<div class="reserv_view">
			            			<span class="pool">
			            				<c:forEach var="beach" items="${beachList}" varStatus="status">
											<c:if test="${travelReservation.reseBeachNameCd eq beach.reseBeachNameCd}"><c:out value="${beach.reseBeachName}"/></c:if>
										</c:forEach>
			            			</span>
		            			</div>
	            				<p class="note">선택하신 해수욕장이름을 꼭 확인해주세요</p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>날짜</dt>
	            			<dd><div class="reserv_view">2020-${travelReservation.month}-${travelReservation.day}</div></dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>시간</dt>
	            			<dd>
	            				<div class="reserv_view">
	            					<c:if test="${travelReservation.reseTime eq '01'}">9:00 ~ 12:00</c:if>
	            					<c:if test="${travelReservation.reseTime eq '02'}">12:00 ~ 15:00</c:if>
	            					<c:if test="${travelReservation.reseTime eq '03'}">15:00 ~ 18:00</c:if>
	            				</div>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>인원</dt>
	            			<dd>
	            				<select id="resePersonnel" name="resePersonnel" title="인원">
	            					<c:forEach var="i" begin="1" end="5" step="1">
	            						<option value="${i}">${i}</option>
	            					</c:forEach>
	            				</select>
							</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>이름</dt>
	            			<dd><input type="text" id="reseName" name="reseName" /></dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>전화번호</dt>
	            			<dd class="tel">
	            				<select id="reseTel_01" name="reseTel_01">
	            					<option value="010">010</option>
	            					<option value="017">017</option>
	            					<option value="019">019</option>
	            				</select>
	            				<em>-</em><input type="text" id="reseTel_02" name="reseTel_02" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
	            				<em>-</em><input type="text" id="reseTel_03" name="reseTel_03" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
	            				<p class="note">예약 확인을 위해 정확한 정보 입력 부탁드립니다.</p>
	            			</dd>
	            		</dl>
	            	</div>
	            	<h3 class="lec_privacy_tit" id="lec_privacy_tit" style="display:none">개인정보 수집 및 이용에 대한안내</h3>
					<div class="lec_privacy" id="lec_privacy" style="display:none">
						<textarea cols="30" rows="10" title="개인정보수집 및 이용에 대한 안내">
개인정보 수집 및 이용에 대한 안내
바다여행일정만들기 사이트는 정보주체의 동의에 의해 개인정보를 수집·이용합니다.
홈페이지 회원관리를 위해 수집·보유하고 있는 주요 개인정보 파일은 다음과 같습니다.
- 수집 및 이용목적 : 바다여행일정만들기의 원활한 서비스 이용
- 개인정보 항목 : 이름, 휴대전화번호
- 보유 및 이용기간 : 회원가입 ~ 회원탈퇴(탈퇴 시 삭제)
- 정보주체의 권리 : 본인에 관한 개인정보 열람, 정정.삭제 청구권
 </textarea>
						<p>
							<input type="checkbox" id="chkAgree2" name="agree_box" /> 
							<label for="chkAgree2">동의합니다.</label>
						</p>
					</div>
	            	<div class="reservBtn_box tac" id="reservBtn_box" style="display:none">
	            		<!-- <a href="javascript:window.history.back();" class="button light_gray">이전화면</a> -->
	            		<a href="javascript:fn_insert()" class="button red">예약하기</a>
	            	</div>
	            </div>	
            </div><!-- cont_body -->
            </form:form>

        	</div><!-- // cont_wrap -->
        </div>
        <!--// container -->

		<!-- footer -->
		<%@ include file="/WEB-INF/jsp/travel/tpl/foot.jsp" %>
		<!--//footer -->
	</div>
	
</body>


</html>
