<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
	<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
</head>
<script>
function fn_print(elem){
	//Popup($(elem).html());
	window.print();
}

function Popup(data){
	var mywindow = window.open('', '해수욕장 예약확인', 'height=400,width=600');
	mywindow.document.write('<html><head><title>해수욕장 예약확인</title>');
	mywindow.document.write('</head><body>');
	mywindow.document.write(data);
	mywindow.document.write('</body></html>');
	mywindow.document.close(); // IE >= 10에 필요
	mywindow.focus(); // necessary for IE >= 10
	mywindow.print();
	mywindow.close();
	return true;
}

function fn_delete(reseNo){
	var result = confirm('예약번호 : ' + reseNo + '\n선택하신 예약을 취소 하시겠습니까?');
	if(result){
		document.getElementById("travelReservation").reseNo.value = reseNo;
		document.getElementById("travelReservation").action = "<c:url value='/travel/reservation/delete.do'/>";
	   	document.getElementById("travelReservation").submit();
	}
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
        	<form:hidden path="reseNo"/>
        	<form:hidden path="reseName"/>
        	<form:hidden path="reseTel"/>
			<div class="cont_head">
                <h2 class="title">해수욕장 예약확인</h2>
            </div><!--// cont_head -->
            <div class="cont_body">
	            <div class="inr">
	           		<c:forEach var="view" items="${viewList}" varStatus="status">
	            	<div class="reserv_wrap_confirm" id="reserv_wrap_confirm_${status.index}">
	            		<dl class="form_group">
	            			<dt>예약번호</dt>
	            			<dd>
	            				<p><c:out value="${view.reseNo}"/><a href="javascript:fn_delete('${view.reseNo}');" class="button reserv_btn">취소</a></p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>해수욕장</dt>
	            			<dd>
	            				<p><c:out value="${view.reseBeachName}"/></p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>날짜</dt>
	            			<dd>
	            				<p><c:out value="${fn:substring(view.reseDate, 0, 4)}"/>년 <c:out value="${fn:substring(view.reseDate, 5, 7)}"/>월 <c:out value="${fn:substring(view.reseDate, 8, 10)}"/>일</p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>시간</dt>
	            			<dd>
	            				<p>
	            					<c:choose>
	            						<c:when test="${fn:substring(view.reseNo, 3, 5) eq '12' || fn:substring(view.reseNo, 3, 5) eq '13' || fn:substring(view.reseNo, 3, 5) eq '14'}">
			            					<c:if test="${view.reseTime eq '01'}">10:00 ~ 13:00</c:if>
			            					<c:if test="${view.reseTime eq '02'}">13:00 ~ 16:00</c:if>
			            					<c:if test="${view.reseTime eq '03'}">16:00 ~ 19:00</c:if>
	            						</c:when>
	            						<c:otherwise>
			            					<c:if test="${view.reseTime eq '01'}">9:00 ~ 12:00</c:if>
			            					<c:if test="${view.reseTime eq '02'}">12:00 ~ 15:00</c:if>
			            					<c:if test="${view.reseTime eq '03'}">15:00 ~ 18:00</c:if>
	            						</c:otherwise>
	            					</c:choose>
	            				</p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>인원</dt>
	            			<dd>
	            				<p><c:out value="${view.resePersonnel}"/>명</p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>이름</dt>
	            			<dd>
	            				<p><c:out value="${view.reseName}"/></p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>전화번호</dt>
	            			<dd>
	            				<p>
	            					<c:if test="${fn:length(view.reseTel) eq 10}"><c:out value="${fn:substring(view.reseTel, 0, 3)}"/>-<c:out value="${fn:substring(view.reseTel, 3, 6)}"/>-<c:out value="${fn:substring(view.reseTel, 6, 10)}"/></c:if>
	            					<c:if test="${fn:length(view.reseTel) ne 10}"><c:out value="${fn:substring(view.reseTel, 0, 3)}"/>-<c:out value="${fn:substring(view.reseTel, 3, 7)}"/>-<c:out value="${fn:substring(view.reseTel, 7, 11)}"/></c:if>
	            				</p>
	            			</dd>
	            		</dl>
	            	</div>	
	            	</c:forEach>
	            	<div class="reservBtn_box tac">
	            		<a href="javascript:fn_print();" class="button lightblue">출력하기</a>
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
