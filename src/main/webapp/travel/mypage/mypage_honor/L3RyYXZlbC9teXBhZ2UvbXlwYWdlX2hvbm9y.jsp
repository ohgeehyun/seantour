<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000131_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><!-- contaniner -->
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
	            	<div class="conBox">
	               		<h3 class="fame_tit">나의 정보</h3>
	               		<div class="my_info_box">
	               			<div class="info">
	               				<div class="name_tit">
	               					<div class="img"><img src="./images/content/img_recommend01.jpg" alt="" /></div>
	               					<div class="name">
	               						<p class="my"><span>홍길동</span>님</p>
	               						<p clss="step">초보여행자 회원</p>
	               					</div>
               					</div>
               					<ul class="info_lst">
               						<li><strong>이메일</strong><p>adghe124@naver.com</p></li>
               						<li><strong>이름</strong><p>홍길동</p></li>
               						<li><strong>휴대폰</strong><p>010-0000-11111</p></li>
               					</ul>
               					<div class="btn"><a href="#none" class="button border">내정보 수정</a></div>
	               			</div>
	               			<div class="fame">
	               				<div class="myfameArea">
		               				<div class="myfame">
		               					<p class="tit">나의 명성점수</p>
		               					<strong class="score">250P</strong>
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
			               				<script>
			               				
										var i = 0;
										var width = 10;
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
										move();
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
									</script>
	               				</div>
	               				<div class="fame_list">
	               					<ul>
	               						<li>
	               							<p class="tit">나의 명성등수</p>
	               							<p class="tit_num">245등</p>
	               						</li>
	               						<li>
	               							<p class="tit">내글 추천수</p>
	               							<p class="tit_num">10건</p>
	               						</li>
	               						<li>
	               							<p class="tit">내글 공유 수</p>
	               							<p class="tit_num">4건</p>
	               						</li>
	               					</ul>
	               				</div>
	               			</div>
	               		</div>
	                </div><!-- // conBox -->
	                <div class="conBox">
       					<h3 class="fame_tit">명성점수 내역</h3>
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
       								<tr>
       									<td data-table-type="brd_number">5</td>
       									<td data-table-type="brd_list" class="tal">홈페이지 로그인 접속(1일 1회)</td>
       									<td data-table-type="brd_score"><span class="color_red">+10</span></td>
       									<td data-table-type="brd_date">2020.03.16</td>
       									<td data-table-type="brd_name">담당자</td>
       								</tr>
       								<tr>
       									<td data-table-type="brd_number">4</td>
       									<td data-table-type="brd_list" class="tal">내가만든 여행일정 추천(가족과 함께 떠나는 부산바다여행)</td>
       									<td data-table-type="brd_score"><span class="color_red">+100</span></td>
       									<td data-table-type="brd_date">2020.02.07</td>
       									<td data-table-type="brd_name">jtel10*</td>
       								</tr>
       								<tr>
       									<td data-table-type="brd_number">3</td>
       									<td data-table-type="brd_list" class="tal">내가만든 여행일정 SNS공유(가족 과 함께 떠나는 부산바다여행)</td>
       									<td data-table-type="brd_score"><span class="color_red">+50</span></td>
       									<td data-table-type="brd_date">2020.02.24</td>
       									<td data-table-type="brd_name">adg35**</td>
       								</tr>
       								<tr>
       									<td data-table-type="brd_number">2</td>
       									<td data-table-type="brd_list" class="tal">이달의 인기추천여행일정으로 선정</td>
       									<td data-table-type="brd_score"><span class="color_red">+200</span></td>
       									<td data-table-type="brd_date">2020.01.09</td>
       									<td data-table-type="brd_name">담당자</td>
       								</tr>
       								<tr>
       									<td data-table-type="brd_number">1</td>
       									<td data-table-type="brd_list" class="tal">홈페이지 로그인 접속(1일 1회)</td>
       									<td data-table-type="brd_score"><span class="color_red">+10</span></td>
       									<td data-table-type="brd_date">2020.01.09</td>
       									<td data-table-type="brd_name">담당자</td>
       								</tr>
       							</tbody>
       						</table>
       					</div>
       					<!-- pagination -->
	            		<ul class="paging">
	            			<li class="first"><a href="#none"></a></li>
	            			<li class="prev"><a href="#none"></a></li>
	            			<li><a href="#none">1</a></li>
	            			<li><a href="#none">2</a></li>
	            			<li><a href="#none">3</a></li>
	            			<li><a href="#none">4</a></li>
	            			<li><a href="#none">5</a></li>
	            			<li class="next"><a href="#none"></a></li>
	            			<li class="last"><a href="#none"></a></li>
	            		</ul>
	            		<!-- //pagination -->
       				</div>
				</div>
            </div><!-- cont_body -->
        </div><!-- // cont_wrap -->
        </div>
        <!--// container --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000131_E.jsp' %>