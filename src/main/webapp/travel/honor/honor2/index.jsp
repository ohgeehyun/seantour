<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000125_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><!-- contaniner -->
		<div id="container" >
            <div class="section_visual sub01 trans400">
                <div class="section_tit_box">
		            <h2 class="tit trans300">추천여행일정</h2>
		            <p class="txt trans300">틀별하고 즐거움이 가득한 국내 바다여행 여행지 추천</p>
        		</div>
            </div><!-- // section_visual -->
             <div class="section_lnb">
             	<div class="inr">
			        <ul id="lnb">
			        	<li><a href="#none"><span class="sprh_com">HOME</span></a></li>
			        	<li id="firstmenu"><!--<a href="/www/main"><span class="unfd sprh_com">홈</span></a>-->
			                <a href="#none">추천여행일정<span class="unfd">같은 레벨 메뉴 보기</span></a>
			                <div>
			                    <ul>
									<li><a href="#none">1차메뉴</a></li>
									<li><a href="#none">1차메뉴</a></li>
									<li><a href="#none">1차메뉴</a></li>
									<li><a href="#none">1차메뉴</a></li>
			                	</ul>
			                </div>  
			            </li>
			            <li id="secondmenu">
			                <a href="#none">작가 추전일정<span class="unfd sprh_com">같은 레벨 메뉴 보기</span></a>
			                <div class="snb_wrap">
			                   <ul class="snb">
									<li><a href="#none">작가 추전일정</a></li>
									<li><a href="#none">2차메뉴</a></li>
									<li><a href="#none">2차메뉴</a></li>
									<li><a href="#none">2차메뉴</a></li>
									<li><a href="#none">2차메뉴</a></li>
			                	</ul> 
			                </div>
			            </li>                       
			         </ul>
		         </div>
    		</div><!-- // section_lnb -->


         <div id="content" class="cont_wrap">
            <!--<div class="cont_head">
                <h2 class="title">센터현황</h2>
            </div><!-- cont_head -->
            <div class="cont_body">
	            <div class="inr">
	               <div class="tabmenu colum2">
						<a href="#none">명성<span class="unfd sprh_com"></span></a>
						<ul>
							<li><a href="/travel/honor/honor1/index.jsp"><span>명성점수 순위</span></a></li>
							<li><a href="/travel/honor/honor2/index.jsp" class="on"><span>명성이란?</span></a></li>
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
					 			<span class="img"><img src="/travel/common/images/content/icon_fame_step1.png" alt="" /></span>
					 			<p class="tit">초보여행자</p>
					 			<p class="score">(0점~300점)</p>
					 		</li>
					 		<li>
					 			<span class="img"><img src="/travel/common/images/content/icon_fame_step2.png" alt="" /></span>
					 			<p class="tit">중급여행자</p>
					 			<p class="score">(300점~600점)</p>
					 		</li>
					 		<li>
					 			<span class="img"><img src="/travel/common/images/content/icon_fame_step3.png" alt="" /></span>
					 			<p class="tit">마스터여행자</p>
					 			<p class="score">(600점~900점)</p>
					 		</li>
					 		<li>
					 			<span class="img"><img src="/travel/common/images/content/icon_fame_step4.png" alt="" /></span>
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
        <!--// container --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000125_E.jsp' %>
