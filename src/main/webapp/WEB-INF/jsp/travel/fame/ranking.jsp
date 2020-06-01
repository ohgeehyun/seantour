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

						<div class="tabmenu colum2">
							<a href="#none">명성<span class="unfd sprh_com"></span></a>
							<ul>
								<li><a href="javascript:;" onclick="setFamePage(this);" class="on"><span>명성점수 순위</span></a></li>
								<li><a href="javascript:;" onclick="setFamePage(this);"><span>명성이란?</span></a></li>
							</ul>
						</div>
						<div class="fame_lst">
							<ul class="flst">
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<li>
									<span class="ranking"><c:out value="${result.fameRanking}"/>위</span>
									<div class="img"><img src='/images/travel/content/img_fame0<c:out value="${result.fameRanking}"/>.png' alt="" /></div>
									<div class="tbox">
										<p class="name"><c:out value="${result.fameUserNm}"/> 님</p>
										<p class="score"><fmt:formatNumber value="${result.famePointSum}" groupingUsed="true"/> 점</p>
									</div>
								</li>
							</c:forEach>
   							<c:if test="${empty resultList}">
   								<li>
									<div class="img"><img src="/images/travel/content/img_fame_no2.png" alt="" /></div>
									<div class="tbox">
										<p class="name">누적랭킹이</p>
										<p class="score">없습니다</p>
									</div>
   								</li>
   							</c:if>
							</ul>
						</div>
					
						<div class="fame_infobox">
						 	<h3 class="fame_tit">명성점수 알아보기</h3>
						 	<p class="fame_txt">
						 		바다여행 활동을 통해 얻을 수 있는 점수입니다.<br />
								회원들과 정보를 공유하고 추천하면 명성점수와 명성등급이  올라갑니다. 일정만들기, 여행일정 공유등을 통해 소통하고 등급을 올려보세요!
						 	</p>
						 	<ul class="fame_info_lst">
						 		<li>
						 			<span class="img"><img src="/images/travel/content/icon_fame_step1.png" alt="" /></span>
						 			<p class="tit">초보여행자</p>
						 			<p class="score">(0점~300점)</p>
						 		</li>
						 		<li>
						 			<span class="img"><img src="/images/travel/content/icon_fame_step2.png" alt="" /></span>
						 			<p class="tit">중급여행자</p>
						 			<p class="score">(300점~600점)</p>
						 		</li>
						 		<li>
						 			<span class="img"><img src="/images/travel/content/icon_fame_step3.png" alt="" /></span>
						 			<p class="tit">마스터여행자</p>
						 			<p class="score">(600점~900점)</p>
						 		</li>
						 		<li>
						 			<span class="img"><img src="/images/travel/content/icon_fame_step4.png" alt="" /></span>
						 			<p class="tit">여행가이드</p>
						 			<p class="score">(900점~1200점)</p>
						 		</li>
						 	</ul>
						</div>
						<div class="fame_scoreinfo_box">
						 	<h3 class="fame_tit">활동별 명성점수 지급 리스트</h3>
						 	<div class="tbox">
						 		<ul>
						 			<li>
						 				<span class="score_tit">홈페이지 로그인 접속시(1일 1회)</span>
						 				<span class="score_txt">+10점</span>
						 			</li>
						 			<li>
						 				<span class="score_tit">내가만든 여행일정 추천시</span>
						 				<span class="score_txt">+100점</span>
						 			</li>
						 			<li>
						 				<span class="score_tit">내가만든여행일정  SNS 공유시 </span>
						 				<span class="score_txt">+50점</span>
						 			</li>
						 			<li>
						 				<span class="score_tit">이달의 인기추천여행일정으로 선정</span>
						 				<span class="score_txt">+200점</span>
						 			</li>
						 		</ul>
						 	</div>
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
div.fame_infobox, div.fame_scoreinfo_box {display: none;}
</style>
<script type="text/javascript">
function fn_egov_link_page(pageNo){
	document.getElementById("recommHistory").pageIndex.value = pageNo;
	document.getElementById("recommHistory").action = "<c:url value='/travel/member/mypage.do'/>";
   	document.getElementById("recommHistory").submit();
}

function setFamePage(obj) {
	var idx = $("div.tabmenu >ul > li > a").index(obj);
	console.log("idx", idx);

	if(idx > 0) {
		$("div.fame_lst").css("display", "none");
		$("div.fame_infobox").css("display", "block");
		$("div.fame_scoreinfo_box").css("display", "block");
	} else {
		$("div.fame_infobox").css("display", "none");
		$("div.fame_scoreinfo_box").css("display", "none");
		$("div.fame_lst").css("display", "block");
	}
	$("div.tabmenu >ul > li > a").toggleClass("on");
}
</script>
</html>
