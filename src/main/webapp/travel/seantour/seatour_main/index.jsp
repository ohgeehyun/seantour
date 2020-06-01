<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000129_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><!-- contaniner -->
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
            <div class="cont_head">
                <h2 class="title">부산광역시(BUSAN)</h2>
            </div><!--// cont_head -->
            <div class="cont_body">
	            <div class="inr">
	            	<div class="bbsSrch bbsSrch2">
						<fieldset form="board">
							<legend>검색</legend>
							<select name="searchCnd" class="select" title="지역선택">
			                    <option value=''>지역</option>
			                    <option value=''>부산광역시</option>
			                    <option value=''>대구광역시</option>
			                    <option value=''>인천광역시</option>
			                    <option value=''>대전광역시</option>
			                    <option value=''>울산광역시</option>
			                    <option value=''>경기도</option>
			                    <option value=''>충청북도</option>
			                    <option value=''>충청남도</option>
			                    <option value=''>전라북도</option>
			                    <option value=''>전라남도</option>
			                    <option value=''>경상북도</option>
			                    <option value=''>경상남도</option>
			                    <option value=''>제주특별자치도</option>
			                </select>
							<select name="searchCnd" class="select" title="분류선택">
			                    <option value=''>분류</option>
			                    <option value=''></option>
			                    <option value=''></option>
			                </select>
							<input name="searchWrd" type="text" size="30" class="word" value='' maxlength="35" onkeypress="doKeyPress(event);" title="검색어 입력" /> 
							<input type="button" value='검색' class="bbs_btn" />
						</fieldset>
					</div>
	               <div class="tabmenu colum6">
						<a href="#none">전체<span class="unfd sprh_com"></span></a>
						<ul>
							<li><a href="#none" class="on"><span>전체</span></a></li>
							<li><a href="#none"><span>관광</span></a></li>
							<li><a href="#none"><span>숙박</span></a></li>
							<li><a href="#none"><span>음식</span></a></li>
							<li><a href="#none"><span>쇼핑</span></a></li>
							<li><a href="#none"><span>체험</span></a></li>
						</ul>
					</div>
	               
					<div class="page_num">
						<p>총 게시물 <span>39</span>건</p>
					</div>
					 <div class="local_lst">
						<ul>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local01.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="../seantour_view/index.jsp"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
									<div class="icon_box">
										<a href="#none" class="clip">클립</a>
										<a href="#none" class="heart">좋아요</a>
									</div>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local02.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
									<div class="icon_box">
										<a href="#none" class="clip">클립</a>
										<a href="#none" class="heart">좋아요</a>
									</div>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local03.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
									<div class="icon_box">
										<a href="#none" class="clip">클립</a>
										<a href="#none" class="heart">좋아요</a>
									</div>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local04.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
									<div class="icon_box">
										<a href="#none" class="clip">클립</a>
										<a href="#none" class="heart">좋아요</a>
									</div>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local01.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
									<div class="icon_box">
										<a href="#none" class="clip">클립</a>
										<a href="#none" class="heart">좋아요</a>
									</div>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local02.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
									<div class="icon_box">
										<a href="#none" class="clip">클립</a>
										<a href="#none" class="heart">좋아요</a>
									</div>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local03.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
									<div class="icon_box">
										<a href="#none" class="clip">클립</a>
										<a href="#none" class="heart">좋아요</a>
									</div>
								</div>
							</li>
							<li>
								<div class="img">
									<img src="/travel/common/images/content/img_local04.jpg" alt="" />
								</div>
								<div class="tbox">
									<p class="tit"><a href="#none"><span class="flag01">관광</span>감천문화마을</a></p>
									<p class="location">전라남도 나주시 다사면 죽산리</p>
									<div class="icon_box">
										<a href="#none" class="clip">클립</a>
										<a href="#none" class="heart">좋아요</a>
									</div>
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
        <!--// container --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000129_E.jsp' %>
