<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
	<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
	<style>
	.local_lst li .tbox .tit span {
		width: 60px;
	}
	div.fame_infobox, div.fame_scoreinfo_box {display: none;}
	</style>
	
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
							<a href="#none" id="mobile_menu">명성점수 순위<span class="unfd sprh_com"></span></a>
							<ul id="close_open">
								<li><a href="javascript:;" onclick="setFamePage(this);" class="on"><span id="menu1">명성점수 순위</span></a></li>
								<li><a href="javascript:;" onclick="setFamePage(this);" ><span id ="menu2">명성이란?</span></a></li>
							</ul>
						</div>
						<div class="fame_lst">
							<ul class="flst">
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<c:set var="fameUserPic" value="${empty result.fameUserPic ? '/images/travel/content/icon_fame_noimg.png' : result.fameUserPic}" />
								<li>
									<span class="ranking"><c:out value="${result.fameRanking}"/>위</span>
									<div class="img"><span><img src='<c:url value="${fameUserPic}"/>' alt="프로필 이미지" /></span></div>
									<div class="tbox">
										<p class="name">
											<%-- <c:out value="${result.fameUserNm}"/>  --%>
											<c:out value="${fn:substring(result.fameUserNm,0,1)}"/><c:forEach begin="${1}" end="${fn:length(result.fameUserNm) - 1}">*</c:forEach>님
										</p>
										<p class="score"><fmt:formatNumber value="${result.famePointSum}" groupingUsed="true"/> 점</p>
									</div>
								</li>
							</c:forEach>
   							<c:if test="${empty resultList}">
   								<li>
									<div class="img"><img src="<c:url value="/images/travel/content/img_fame_no2.png"/>" alt="" /></div>
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
						 			<span class="img"><img src="<c:url value="/images/travel/content/icon_fame_step1.png"/>" alt="" /></span>
						 			<p class="tit">초보여행자</p>
						 			<p class="score">(0점~300점)</p>
						 		</li>
						 		<li>
						 			<span class="img"><img src="<c:url value="/images/travel/content/icon_fame_step2.png"/>" alt="" /></span>
						 			<p class="tit">중급여행자</p>
						 			<p class="score">(300점~600점)</p>
						 		</li>
						 		<li>
						 			<span class="img"><img src="<c:url value="/images/travel/content/icon_fame_step3.png"/>" alt="" /></span>
						 			<p class="tit">마스터여행자</p>
						 			<p class="score">(600점~900점)</p>
						 		</li>
						 		<li>
						 			<span class="img"><img src="<c:url value="/images/travel/content/icon_fame_step4.png"/>" alt="" /></span>
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
						 				<span class="score_tit">홈페이지 로그인 접속하면(1일 1회)</span>
						 				<span class="score_txt">+10점</span>
						 			</li>
						 			<li>
						 				<span class="score_tit">내가 만든 여행일정 추천받으면</span>
						 				<span class="score_txt">+100점</span>
						 			</li>
						 			<li>
						 				<span class="score_tit">여행지 콘텐츠 SNS에 공유하면</span>
						 				<span class="score_txt">+50점</span>
						 			</li>
						 			<li>
						 				<span class="score_tit">이달의 인기추천여행일정으로 선정되면</span>
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
	<script>
	function fn_egov_link_page(pageNo){
		document.getElementById("recommHistory").pageIndex.value = pageNo;
		document.getElementById("recommHistory").action = "<c:url value='/travel/member/mypage.do'/>";
	   	document.getElementById("recommHistory").submit();
	}
	$(document).ready(function(){
		$('#menu1').click(function(){
			document.getElementById("mobile_menu").text = $('#menu1').text();
		});
		$('#menu2').click(function(){
			document.getElementById("mobile_menu").text = $('#menu2').text();
		});
	});
		
	function setFamePage(obj) {
		var idx = $("div.tabmenu >ul > li > a").index(obj);
		console.log("idx", idx);
	
		if(idx > 0) {
			$("div.fame_lst").css("display", "none");
			$("div.fame_infobox").css("display", "block");
			$("div.fame_scoreinfo_box").css("display", "block");
			$(this).parents("ul").css("display", "none");
			$("#mobile_menu").html("명성이란?")
			if (matchMedia("screen and (max-width: 768px)").matches) {
				$("#close_open").css("display","none") 
				} 
		} else {
			$("div.fame_infobox").css("display", "none");
			$("div.fame_scoreinfo_box").css("display", "none");
			$("div.fame_lst").css("display", "block");
			$("#mobile_menu").html("명성점수 순위")
			if (matchMedia("screen and (max-width: 768px)").matches) {
				$("#close_open").css("display","none") 
				} 
		}
		//$("div.tabmenu >ul").css("display", "none");
		$("div.tabmenu >ul > li > a").toggleClass("on");
		
	}
	</script>
</body>


</html>
