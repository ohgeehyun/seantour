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
							<li><a href="/travel/honor/honor1/index.jsp" class="on"><span>명성점수 순위</span></a></li>
							<li><a href="/travel/honor/honor2/index.jsp" ><span>명성이란?</span></a></li>
						</ul>
					</div>
					 <div class="fame_lst">
						<ul class="flst">
							<li>
								<span class="ranking">1위</span>
								<div class="img"><img src="/travel/common/images/content/img_fame01.png" alt="" /></div>
								<div class="tbox">
									<p class="name">Admin 님</p>
									<p class="score">3,457 점</p>
								</div>
							</li>
							<li>
								<span class="ranking">2위</span>
								<div class="img"><img src="/travel/common/images/content/img_fame02.png" alt="" /></div>
								<div class="tbox">
									<p class="name">Admin 님</p>
									<p class="score">3,457 점</p>
								</div>
							</li>
							<li>
								<span class="ranking">3위</span>
								<div class="img"><img src="/travel/common/images/content/img_fame_no1.png" alt="" /></div>
								<div class="tbox">
									<p class="name">Admin 님</p>
									<p class="score">3,457 점</p>
								</div>
							</li>
							<li>
								<span class="ranking">4위</span>
								<div class="img"><img src="/travel/common/images/content/img_fame_no2.png" alt="" /></div>
								<div class="tbox">
									<p class="name">Admin 님</p>
									<p class="score">3,457 점</p>
								</div>
							</li>
							<li>
								<span class="ranking">5위</span>
								<div class="img"><img src="/travel/common/images/content/img_fame03.png" alt="" /></div>
								<div class="tbox">
									<p class="name">Admin 님</p>
									<p class="score">3,457 점</p>
								</div>
							</li>
							<li>
								<span class="ranking">6위</span>
								<div class="img"><img src="/travel/common/images/content/img_fame04.png" alt="" /></div>
								<div class="tbox">
									<p class="name">Admin 님</p>
									<p class="score">3,457 점</p>
								</div>
							</li>
							<li>
								<span class="ranking">7위</span>
								<div class="img"><img src="/travel/common/images/content/img_fame05.png" alt="" /></div>
								<div class="tbox">
									<p class="name">Admin 님</p>
									<p class="score">3,457 점</p>
								</div>
							</li>
							<li>
								<span class="ranking">8위</span>
								<div class="img"><img src="/travel/common/images/content/img_fame06.png" alt="" /></div>
								<div class="tbox">
									<p class="name">Admin 님</p>
									<p class="score">3,457 점</p>
								</div>
							</li>
							<li>
								<span class="ranking">9위</span>
								<div class="img"><img src="/travel/common/images/content/img_fame_no2.png" alt="" /></div>
								<div class="tbox">
									<p class="name">Admin 님</p>
									<p class="score">3,457 점</p>
								</div>
							</li>
							<li>
								<span class="ranking">10위</span>
								<div class="img"><img src="/travel/common/images/content/img_fame07.png" alt="" /></div>
								<div class="tbox">
									<p class="name">Admin 님</p>
									<p class="score">3,457 점</p>
								</div>
							</li>
						</ul>
					</div>
								
				</div>
            </div><!-- cont_body -->
        </div><!-- // cont_wrap -->
        </div>
        <!--// container --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000125_E.jsp' %>
