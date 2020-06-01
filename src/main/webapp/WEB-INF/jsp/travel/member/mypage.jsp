<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
	<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
</head>
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

	            <div class="cont_body">
		            <div class="inr">
		            	<div class="conBox">
		               		<h3 class="fame_tit">나의 정보</h3>
		               		<div class="my_info_box">
		               			<div class="info">
		               				<div class="name_tit">
		               					<div class="img"><img src="/images/travel/content/img_recommend01.jpg" alt='<c:out value="${loginVO.mbrNm}"/>님 프로필 이미지' /></div>
		               					<div class="name">
		               						<%-- <p class="my"><span>홍길동</span>님</p> --%>
		               						<p class="my"><span><c:out value="${loginVO.mbrNm}"/></span>님</p>
		               						<p clss="step">초보여행자 회원</p>
		               					</div>
	               					</div>
	               					<ul class="info_lst">
	               						<li><strong>이메일</strong><p><c:out value="${loginVO.email}"/></p></li>
	               						<li><strong>이름</strong><p><c:out value="${loginVO.mbrNm}"/></p></li>
	               						<li><strong>휴대폰</strong><p><c:out value="${loginVO.mobile}"/></p></li>
	               					</ul>
	               					<div class="btn"><a href='/travel/member/modify.do?mbrId=<c:out value="${loginVO.mbrId}"/>' class="button border">내정보 수정</a></div>
		               			</div>
		               			<div class="fame">
		               				<div class="myfameArea">
			               				<div class="myfame">
			               					<p class="tit">나의 명성점수</p>
			               					<strong class="score"><c:out value="${famePoint.famePointSum}"/>P</strong>
		               					</div>
		               					<div id="myProgress">
		               						<div>
											  <div id="myBar"></div>
											</div>
										</div>
										<ul class="myProgress_lst">
											<li>초보여행자</li>
											<li>중급여행자</li>
											<li>마스터여행자</li>
											<li>여행가이드</li>
										</ul>
		               				</div>
		               				<div class="fame_list">
		               					<ul>
		               						<li>
		               							<p class="tit">나의 명성등수</p>
		               							<p class="tit_num"><c:out value="${famePoint.fameRanking}"/>등</p>
		               						</li>
		               						<li>
		               							<p class="tit">내글 추천수</p>
		               							<p class="tit_num"><c:out value="${famePoint.fameRecoCase}"/>건</p>
		               						</li>
		               						<li>
		               							<p class="tit">내글 공유 수</p>
		               							<p class="tit_num"><c:out value="${famePoint.fameSharedCase}"/>건</p>
		               						</li>
		               					</ul>
		               				</div>
		               			</div>
		               		</div>
		                </div><!-- // conBox -->
		                <div class="conBox">
	       					<h3 class="fame_tit">명성점수 내역</h3>
				
						<form:form commandName="recommHistory" method="post">            
	       					<div class="scroll">
	       						<table class="tbl01">
	       							<caption>명성점수 내역 번호, 적림내용, 적립점수, 적립일, 적립자</caption>
	       							<thead>
	       								<tr>
	       									<th scope="col" data-table-type="brd_number">번호</th>
	       									<th scope="col" data-table-type="brd_list">적립내역</th>
	       									<th scope="col" data-table-type="brd_score">적립점수</th>
	       									<th scope="col" data-table-type="brd_date">적립일</th>
	       									<th scope="col" data-table-type="brd_name">적립자</th>
	       								</tr>
	       							</thead>
	       							<tbody>
	       							<c:forEach var="result" items="${resultList}" varStatus="status">	
	       								<tr>
	       									<td data-table-type="brd_number">
	       										<c:out value="${paginationInfo.totalRecordCount-(paginationInfo.currentPageNo-1)*paginationInfo.recordCountPerPage-status.index}" />
	       									</td>
	       									<td data-table-type="brd_list" class="tal"><c:out value="${result.fameHisItem}" /></td>
	       									<td data-table-type="brd_score"><span class="color_red">+<c:out value="${result.fameHisPoint}" /></span></td>
	       									<td data-table-type="brd_date">
	       										<%-- 2020.03.16 --%>
				            					<fmt:parseDate value="${result.fameHisDate}" var="parsedDate" pattern="yyyy-MM-dd HH:mm:ss.S"/>
				            					<fmt:formatDate value="${parsedDate}" pattern="yyyy.MM.dd"/>
	       									</td>
	       									<td data-table-type="brd_name"><c:out value="${result.fameHisRecUserNm}" /></td>
	       								</tr>
	       							</c:forEach>
	       							<%-- <c:if test="fn:length(resultList) eq 0}"> --%>
	       							<c:if test="${empty resultList}">
	       								<tr><td colspan="5">적립내역이 없습니다</td></tr>
	       							</c:if>
	       							</tbody>
	       						</table>
	       					</div>
	       					<!-- pagination -->
		            		<ui:pagination paginationInfo="${paginationInfo}" type="travelFront" jsFunction="fn_egov_link_page" />
							<form:hidden path="pageIndex" />
		            		<!-- //pagination -->
							
						</form:form>
	       				</div>
					</div>
	            </div><!-- cont_body -->

	        </div><!-- // cont_wrap -->
        </div>
        <!--// container -->
		
		<!-- footer -->
		<%@ include file="/WEB-INF/jsp/travel/tpl/foot.jsp" %>
		<!--//footer -->
	</div>
	<!-- // wrap -->
</body>
<style type="text/css">
.local_lst li .tbox .tit span {
	width: 60px;
}
</style>
<script type="text/javascript">
var i = 0;
var width = 10;

function fn_egov_link_page(pageNo){
	document.getElementById("recommHistory").pageIndex.value = pageNo;
	document.getElementById("recommHistory").action = "<c:url value='/travel/member/mypage.do'/>";
   	document.getElementById("recommHistory").submit();
}

function move() {
  	if (i == 0) {
    	i = 1;
    	var elem = document.getElementById("myBar");
    	var elemBox = document.getElementById("myProgress");
    	var id = setInterval(frame, 10);
    	function frame() {
      		if (width >= 100) {
        		clearInterval(id);
        		i = 0;
      		} else {
        		width++;
        		elem.style.width = width + "%";
        		afterMove();
      		}
    	}
	}
}
function afterMove(){
	if (width >= 0 && width <33.33) {
		$("#myProgress").addClass('on1');
	} else if(width >= 33.33 && width <66.66) {
		$("#myProgress").addClass('on2');
	} else if(width >= 66.66 && width < 100) {
		$("#myProgress").addClass('on3');
	} else {
		$("#myProgress").addClass('on4');
	}
}
$(function(){
	// var i = 0;
	// var width = 10;
	move();
});
</script>
</html>
