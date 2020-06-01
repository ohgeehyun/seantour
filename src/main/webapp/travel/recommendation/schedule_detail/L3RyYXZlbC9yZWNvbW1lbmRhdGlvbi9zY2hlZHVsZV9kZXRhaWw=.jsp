<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000128_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><!-- contaniner -->
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
	            	<div class="map_route_wrap">
	            		<div class="map_route">
		            		<div class="map">
		            			 
		            		</div>
		            		<dl class="map_day_route">
		            			<dt><a href="#none">DAY 1</a></dt>
		            			<dd class="route_lst">
		            				<ul>
		            					<li><span class="num">1</span>죽성식당</li>
		            					<li><span class="num">2</span>산굼부리</li>
		            					<li><span class="num">3</span>함덕서우봉</li>
		            					<li><span class="num">4</span>산굼부리</li>
		            					<li><span class="num">5</span>올레길6코스</li>
		            					<li><span class="num">6</span>문화거리</li>
		            					<li><span class="num">7</span>쇠소깍</li>
		            					<li><span class="num">8</span>산굼부리</li>
		            				</ul>
		            			</dd>
		            		</dl>
		            		<dl class="map_day_route">
		            			<dt><a href="#none">DAY 2</a></dt>
		            			<dd class="route_lst">
		            				<ul>
		            					<li><span class="num">1</span>죽성식당</li>
		            					<li><span class="num">2</span>산굼부리</li>
		            					<li><span class="num">3</span>함덕서우봉</li>
		            					<li><span class="num">4</span>산굼부리</li>
		            					<li><span class="num">5</span>올레길6코스</li>
		            				</ul>
		            			</dd>
		            		</dl>
		            		<dl class="map_day_route">
		            			<dt><a href="#none">DAY 3</a></dt>
		            			<dd class="route_lst">
		            				<ul>
		            					<li><span class="num">1</span>죽성식당</li>
		            					<li><span class="num">2</span>산굼부리</li>
		            					<li><span class="num">3</span>함덕서우봉</li>
		            				</ul>
		            			</dd>
		            		</dl>
	            		</div>
		            	<div class="recommend_days_lst">
		            		<div class="tit_box">
		            			<p class="name">홍길동</p>
		            			<p class="tit">가족과 함께 떠나는 부산 해돋이 여행</p>
		            			<div class="info">
		            				<ul class="list">
		            					<li>부산</li>
		            					<li>1박2일</li>
		            				</ul>
		            				<p class="date">2020.03.02</p>
		            			</div>
		            		</div>
		            		<div class="re_days_area">
		            			<p class="day_num">DAY 1</p>
		            			<ul class="list">
									<li>
										<div class="img"><img src="./images/content/img_re01.jpg" alt="" /></div>
										<div class="txt_box">
											<p class="tit">죽성성당(드라마 촬영지)</p>
											<div class="txt_area">
												<span class="local">부산 동구</span>
												<p class="txt">공주시 금성동과 웅진동에 연접한 옛 지명은 공주읍 송산리 宋山의 남쪽 경사면에 자리하고 있는 웅진시대...</p>
											</div>
											<a href="#none" class="more">더보기</a>
										</div>
									</li>
									<li>
										<div class="img"><img src="./images/content/img_re02.jpg" alt="" /></div>
										<div class="txt_box">
											<p class="tit">이기대 정망대</p>
											<div class="txt_area">
												<span class="local">부산 동구</span>
												<p class="txt">공주시 금성동과 웅진동에 연접한 옛 지명은 공주읍 송산리 宋山의 남쪽 경사면에 자리하고 있는 웅진시대...</p>
											</div>
											<a href="#none" class="more">더보기</a>
										</div>
									</li>
									<li>
										<div class="img"><img src="./images/content/img_re03.jpg" alt="" /></div>
										<div class="txt_box">
											<p class="tit">[공수마을]오링대공원</p>
											<div class="txt_area">
												<span class="local">부산 동구</span>
												<p class="txt">공주시 금성동과 웅진동에 연접한 옛 지명은 공주읍 송산리 宋山의 남쪽 경사면에 자리하고 있는 웅진시대...</p>
											</div>
											<a href="#none" class="more">더보기</a>
										</div>
									</li>
									<li>
										<div class="img"><img src="./images/content/img_re04.jpg" alt="" /></div>
										<div class="txt_box">
											<p class="tit">달맞이고개(달맞이마을)</p>
											<div class="txt_area">
												<span class="local">부산 동구</span>
												<p class="txt">공주시 금성동과 웅진동에 연접한 옛 지명은 공주읍 송산리 宋山의 남쪽 경사면에 자리하고 있는 웅진시대...</p>
											</div>
											<a href="#none" class="more">더보기</a>
										</div>
									</li>
								</ul>
		            		</div>
		            		<div class="re_days_area">
		            			<p class="day_num">DAY 2</p>
		            			<ul class="list">
									<li>
										<div class="img"><img src="./images/content/img_re01.jpg" alt="" /></div>
										<div class="txt_box">
											<p class="tit">죽성성당(드라마 촬영지)</p>
											<div class="txt_area">
												<span class="local">부산 동구</span>
												<p class="txt">공주시 금성동과 웅진동에 연접한 옛 지명은 공주읍 송산리 宋山의 남쪽 경사면에 자리하고 있는 웅진시대...</p>
											</div>
											<a href="#none" class="more">더보기</a>
										</div>
									</li>
									<li>
										<div class="img"><img src="./images/content/img_re02.jpg" alt="" /></div>
										<div class="txt_box">
											<p class="tit">이기대 정망대</p>
											<div class="txt_area">
												<span class="local">부산 동구</span>
												<p class="txt">공주시 금성동과 웅진동에 연접한 옛 지명은 공주읍 송산리 宋山의 남쪽 경사면에 자리하고 있는 웅진시대...</p>
											</div>
											<a href="#none" class="more">더보기</a>
										</div>
									</li>
									<li>
										<div class="img"><img src="./images/content/img_re03.jpg" alt="" /></div>
										<div class="txt_box">
											<p class="tit">[공수마을]오링대공원</p>
											<div class="txt_area">
												<span class="local">부산 동구</span>
												<p class="txt">공주시 금성동과 웅진동에 연접한 옛 지명은 공주읍 송산리 宋山의 남쪽 경사면에 자리하고 있는 웅진시대...</p>
											</div>
											<a href="#none" class="more">더보기</a>
										</div>
									</li>
								</ul>
		            		</div>
		            	</div>
	            	</div>
	             </div>  
            </div><!-- cont_body -->
        </div><!-- // cont_wrap -->
        </div>
        <!--// container --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000128_E.jsp' %>