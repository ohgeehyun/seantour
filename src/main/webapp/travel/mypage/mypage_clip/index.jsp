<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000131_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><!-- contaniner -->
		<div id="container" >
            <div class="section_visual sub01 trans400">
                <div class="section_tit_box">
		            <h2 class="tit trans300">바다여행</h2>
		            <p class="txt trans300">특별하고 즐거움이</p>
        		</div>
            </div><!-- // section_visual -->
             <div class="section_lnb">
             	<div class="inr">
			        <ul id="lnb">
			        	<li><a href="#none"><span class="sprh_com">HOME</span></a></li>
			        	<li id="firstmenu"><!--<a href="/www/main"><span class="unfd sprh_com">홈</span></a>-->
			                <a href="#none">바다여행<span class="unfd">같은 레벨 메뉴 보기</span></a>
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
			                <a href="#none">부산광역시<span class="unfd sprh_com">같은 레벨 메뉴 보기</span></a>
			                <div class="snb_wrap">
			                   <ul class="snb">
									<li><a href="#none">부산광역시</a></li>
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
                <h2 class="title">클립보드</h2>
            </div><!--// cont_head -->
            <div class="cont_body">
	            <div class="inr">
	            	<h3 class="fame_tit">클립보드</h3>
					 <div class="local_lst">
						<ul>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local01.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="./바다여행_detail.html"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local02.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local03.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local04.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local01.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local02.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local03.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local04.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
								</div>
							</li>
						</ul>
					</div>
					<div class="pagination">
						<a href="#none" class="page_prevend"><span>처음</span></a>&nbsp;
						<a href="#none" class="page_prev"><span>이전</span></a>&nbsp;
						<strong title="현재페이지">1</strong>&nbsp;
						<a href="#none">2</a>&nbsp;
						<a href="#none">3</a>&nbsp;
						<a href="#none">4</a>&nbsp;
						<a href="#none">5</a>&nbsp;
						<a href="#none">6</a>&nbsp;
						<a href="#none">7</a>&nbsp;
						<a href="#none">8</a>&nbsp;
						<a href="#none">9</a>&nbsp;
						<a href="#none">10</a>&nbsp;
						<a href="#none" class="page_next"><span>다음</span></a>&nbsp;
						<a href="#none" class="page_nextend"><span>마지막</span></a>
					</div>
				</div>
            </div><!-- cont_body -->
        </div><!-- // cont_wrap -->
        </div>
        <!--// container --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000131_E.jsp' %>
