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
	               <div class="tabmenu colum2">
						<a href="#none">추천일정<span class="unfd sprh_com"></span></a>
						<ul>
							<li><a href="#none" class="on"><span>작가 추천일정</span></a></li>
							<li><a href="#none" ><span>베스트 추천일정</span></a></li>
						</ul>
					</div>
	               <div class="bbsSrch">
						<fieldset form="board">
							<legend>검색</legend>
							<select name="searchCnd" class="select" title="검색조건선택">
			                    <option value='0' >제목</option>
			                    <option value='1' >글내용</option>
			                    <option value='4' >부서명</option>
			                </select>
							<input name="searchWrd" type="text" size="30" class="word" value='' maxlength="35" onkeypress="doKeyPress(event);" title="검색어 입력" /> 
							<input type="button" value='검색' class="bbs_btn" />
						</fieldset>
					</div>
					<div class="page_num">
						<p>총 게시물 <span>39</span>건</p>
					</div>
					 <div class="recommend_lst">
						<ul>
							<li>
								<div class="img">
									<span class="title">부산여행 전문작가 추천</span>
									<img src="./images/content/img_recommend01.jpg" alt="" />
								</div>
								<div class="txt"><a href="./추천일정_detail.html">부산의 바다를 제대로 감상하고 맛볼수 있는 해운대 & 기장 여행</div>
								<div class="info">
									<span class="name">홍길동</span>
									<ul class="lst">
										<li>
											<span class="reco_num">조회수</span>
											<span class="num">211</span>
										</li>
										<li>
											<span class="reco_num">추천수</span>
											<span class="num">43</span>
										</li>
									</ul>
								</div>
							</li>
							<li>
								<div class="img">
									<span class="title">바다여행 전문작가 추천</span>
									<img src="./images/content/img_recommend02.jpg" alt="" />
								</div>
								<div class="txt"><a href="#none">바다와 계곡 사이에 숨은 솔숲, 포항 바다솔캠핑장에서 시원한 여름나기</a></div>
								<div class="info">
									<span class="name">홍길동</span>
									<ul class="lst">
										<li>
											<span class="reco_num">조회수</span>
											<span class="num">211</span>
										</li>
										<li>
											<span class="reco_num">추천수</span>
											<span class="num">43</span>
										</li>
									</ul>
								</div>
							</li>
							<li>
								<div class="img">
									<span class="title">부산여행 전문작가 추천</span>
									<img src="./images/content/img_recommend03.jpg" alt="" />
								</div>
								<div class="txt"><a href="#none">부산의 바다를 제대로 감상하고 맛볼수 있는 해운대 & 기장 여행</a><div>
								<div class="info">
									<span class="name">홍길동</span>
									<ul class="lst">
										<li>
											<span class="reco_num">조회수</span>
											<span class="num">211</span>
										</li>
										<li>
											<span class="reco_num">추천수</span>
											<span class="num">43</span>
										</li>
									</ul>
								</div>
							</li>
							<li>
								<div class="img">
									<span class="title">웅ㄹ산여행 전문작가 추천</span>
									<img src="./images/content/img_recommend04.jpg" alt="" />
								</div>
								<div class="txt"><a href="#none">부산의 바다를 제대로 감상하고 맛볼수 있는 해운대 & 기장 여행</a></div>
								<div class="info">
									<span class="name">홍길동</span>
									<ul class="lst">
										<li>
											<span class="reco_num">조회수</span>
											<span class="num">211</span>
										</li>
										<li>
											<span class="reco_num">추천수</span>
											<span class="num">43</span>
										</li>
									</ul>
								</div>
							</li>
							<li>
								<div class="img">
									<span class="title">포항여행 전문작가 추천</span>
									<img src="./images/content/img_recommend05.jpg" alt="" />
								</div>
								<div class="txt"><a href="#none">일출 명소 포항, 경주, 울산 동해바다 가족여행</a></div>
								<div class="info">
									<span class="name">홍길동</span>
									<ul class="lst">
										<li>
											<span class="reco_num">조회수</span>
											<span class="num">211</span>
										</li>
										<li>
											<span class="reco_num">추천수</span>
											<span class="num">43</span>
										</li>
									</ul>
								</div>
							</li>
							<li>
								<div class="img">
									<span class="title">부산여행 전문작가 추천</span>
									<img src="./images/content/img_recommend06.jpg" alt="" />
								</div>
								<div class="txt"><a href="#none">부산의 바다를 제대로 감상하고 맛볼수 있는 해운대 & 기장 여행</a></div>
								<div class="info">
									<span class="name">홍길동</span>
									<ul class="lst">
										<li>
											<span class="reco_num">조회수</span>
											<span class="num">211</span>
										</li>
										<li>
											<span class="reco_num">추천수</span>
											<span class="num">43</span>
										</li>
									</ul>
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
        <!--// container --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000128_E.jsp' %>