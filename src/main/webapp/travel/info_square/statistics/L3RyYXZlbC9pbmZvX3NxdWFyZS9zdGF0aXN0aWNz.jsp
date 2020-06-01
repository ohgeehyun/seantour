<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000132_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><div id="content" class="cont_wrap">
            <!--<div class="cont_head">
                <h2 class="title">센터현황</h2>
            </div><!-- cont_head -->
            <div class="cont_body">
	            <div class="inr">
	               <!--<div class="tabmenu colum4">
						<a href="#none">통계<span class="unfd sprh_com"></span></a>
						<ul>
							<li><a href="#none"><span>공지사항</span></a></li>
							<li><a href="#none"><span>여행정보 정정 요청</span></a></li>
							<li><a href="#none" class="on"><span>통계</span></a></li>
							<li><a href="#none"><span>여행 Tip</span></a></li>
						</ul>
					</div>-->
				 	<h3 class="fame_tit">인기 관광지</h3>
					<div class="popular_srch">
						<ul>
							<li><a href="#none">#부산축제</a></li>
							<li><a href="#none">#백제역사 유적지구</a></li>
							<li><a href="#none">#부산 태종대</a></li>
							<li><a href="#none">#봄 여행지</a></li>
							<li><a href="#none">#봄 여행지</a></li>
							<li><a href="#none">#백제역사 유적지구</a></li>
							<li><a href="#none">#부산 태종대</a></li>
							<li><a href="#none">#백제역사 유적지구</a></li>
							<li><a href="#none">#바다</a></li>
							<li><a href="#none">#부산축제</a></li>
							<li><a href="#none">#백제역사 유적지구</a></li>
							<li><a href="#none">#부산 태종대</a></li>
							<li><a href="#none">#봄 여행지</a></li>
							<li><a href="#none">#백제역사 유적지구</a></li>
							<li><a href="#none">#부산 태종대</a></li>
							<li><a href="#none">#백제역사 유적지구</a></li>
						</ul>
					</div>
					<h3 class="fame_tit">추천 여행지</h3> 	
					<div class="recommend_tour_box">
						<div class="tab_menu">
							<ul>
								<li><a href="#none">계절별</a></li>
								<li><a href="#none">지역별</a></li>
								<li><a href="#none">베스트추천</a></li>
							</ul>
						</div>
						<div class="recommend_box">
							<div class="season_area">
								<h4 class="recommend_tit">봄</h4>
								<ul>
									<li>
										<span clss="num">1</span>
										<span class="tit">부산해운대</span>
										<span class="img"><img src="./images/content/img_statistic01.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">2</span>
										<span class="tit">태종대</span>
										<span class="img"><img src="./images/content/img_statistic02.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">3</span>
										<span class="tit">백제역사유적지구</span>
										<span class="img"><img src="./images/content/img_statistic03.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">4</span>
										<span class="tit">해수욕장</span>
										<span class="img"><img src="./images/content/img_statistic04.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">5</span>
										<span class="tit">울산바위섬</span>
										<span class="img"><img src="./images/content/img_statistic05.jpg" alt="" /></span>
									</li>
								</ul>
							</div>
							<div class="season_area">
								<h4 class="recommend_tit">여름</h4>
								<ul>
									<li>
										<span clss="num">1</span>
										<span class="tit">부산해운대</span>
										<span class="img"><img src="./images/content/img_statistic01.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">2</span>
										<span class="tit">태종대</span>
										<span class="img"><img src="./images/content/img_statistic02.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">3</span>
										<span class="tit">백제역사유적지구</span>
										<span class="img"><img src="./images/content/img_statistic03.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">4</span>
										<span class="tit">해수욕장</span>
										<span class="img"><img src="./images/content/img_statistic04.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">5</span>
										<span class="tit">울산바위섬</span>
										<span class="img"><img src="./images/content/img_statistic05.jpg" alt="" /></span>
									</li>
								</ul>
							</div>
							<div class="season_area">
								<h4 class="recommend_tit">가을</h4>
								<ul>
									<li>
										<span clss="num">1</span>
										<span class="tit">부산해운대</span>
										<span class="img"><img src="./images/content/img_statistic01.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">2</span>
										<span class="tit">태종대</span>
										<span class="img"><img src="./images/content/img_statistic02.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">3</span>
										<span class="tit">백제역사유적지구</span>
										<span class="img"><img src="./images/content/img_statistic03.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">4</span>
										<span class="tit">해수욕장</span>
										<span class="img"><img src="./images/content/img_statistic04.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">5</span>
										<span class="tit">울산바위섬</span>
										<span class="img"><img src="./images/content/img_statistic05.jpg" alt="" /></span>
									</li>
								</ul>
							</div>
							<div class="season_area">
								<h4 class="recommend_tit">겨울</h4>
								<ul>
									<li>
										<span clss="num">1</span>
										<span class="tit">부산해운대</span>
										<span class="img"><img src="./images/content/img_statistic01.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">2</span>
										<span class="tit">태종대</span>
										<span class="img"><img src="./images/content/img_statistic02.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">3</span>
										<span class="tit">백제역사유적지구</span>
										<span class="img"><img src="./images/content/img_statistic03.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">4</span>
										<span class="tit">해수욕장</span>
										<span class="img"><img src="./images/content/img_statistic04.jpg" alt="" /></span>
									</li>
									<li>
										<span clss="num">5</span>
										<span class="tit">울산바위섬</span>
										<span class="img"><img src="./images/content/img_statistic05.jpg" alt="" /></span>
									</li>
								</ul>
							</div>
						</div><!-- //recommend_box1 -->
						<div class="recommend_box type3">
							<h3 class="local_tit">
								<span class="sub">지역별</span>
								<span class="tit">인기 여행지</span>
								<span class="txt">BEST SPOT</span>
							</h3>
							<div class="selection_map_area map01">
								<script>
									$(function(){
										 var status = 'status';
										//지도 온표시
										$("#Map area").click(function(){
											$("#map-image").attr("src", "./images/content/map_"+$(this).attr("class")+".png");
											//console.log($(this).attr("class"));
										});
									});	
								</script>
								<div class="selection_map"> 
									<img src="./images/content/map_map01.png" alt="" usemap="#Map" border="0" id="map-image" />
							        <map name="Map" id="Map">
							          <area shape="poly" coords="119,21,93,33,76,32,69,38,69,47,63,56,51,74,63,113,78,117,103,90,115,104,134,112,116,134,90,137,71,146,70,162,129,188,174,153,172,104,148,94,146,41,118,21" href="#" id="map01" class="map01"><!--경기도-->
							          <area shape="poly" coords="132,14,121,20,148,38,150,92,177,104,174,151,191,154,201,143,254,164,318,152,318,135,295,115,295,96,261,62,263,36,238,8,218,8,207,17" href="#" id="map02" class="map02"><!--강원도-->
							          <area shape="poly" coords="50,80,46,93,44,127,69,145,85,138,78,118,63,117" href="#"id="map17" class="map17"><!--인천광역-->
							          <area shape="poly" coords="67,170,43,173,28,183,22,190,12,191,8,199,6,211,26,228,41,229,44,233,41,257,53,265,51,287,59,298,81,297,88,277,96,277,109,290,122,283,151,299,159,288,150,265,135,272,122,253,122,244,106,213,126,213,138,203,129,189,101,179" href="#" id="map03" class="map03"<!-- 충청남도 -->
							          <area shape="poly" coords="174,155,131,191,143,203,131,215,137,235,151,245,151,264,162,289,184,296,200,273,178,225,216,186,237,193,251,165,203,147,191,155" href="#" id="map04" class="map04"><!-- 충청북도 -->
							          <area shape="poly" coords="137,236,126,252,136,271,149,261,149,245" href="#" id="map05" class="map05"><!--대전광역시-->
							          <area shape="poly" coords="316,158,255,166,239,197,220,192,181,225,201,271,186,298,188,314,215,327,218,343,228,344,230,309,258,295,274,315,253,343,270,351,290,346,302,332,344,344,346,315,356,309,356,300,343,284,344,257,352,244,353,214,334,189,334,175" href="#" id="map06" class="map06"><!--경상북도-->
							          <area shape="poly" coords="293,346,275,356,250,346,220,346,212,329,188,319,162,342,148,383,177,426,230,413,267,412,272,391,301,374,295,361" href="#" id="map07" class="map07"><!-- 경상남도 -->
							          <area shape="poly" coords="256,297,234,310,232,340,248,341,269,315" href="#" id="map08" class="map08"><!-- 대구광역시 -->
							          <area shape="poly" coords="181,317,184,300,165,292,153,305,122,288,111,293,97,281,90,280,83,300,63,301,64,330,41,346,46,365,40,368,63,381,82,365,102,373,113,383,145,384,157,339" href="#" id="map09" class="map09"><!--전라북도-->
							          <area shape="poly" coords="38,374,27,388,28,403,16,411,12,425,20,452,22,468,37,479,43,504,60,503,68,491,88,488,96,471,108,471,112,482,120,488,137,489,156,462,173,451,173,429,146,386,111,387,104,378,85,372,66,384,67,394,63,407,82,426,105,406,95,395,71,395,65,384" href="#" id="map10" class="map10"><!-- 전라남도-->
							          <area shape="poly" coords="92,398,69,397,67,406,80,424,101,405" href="#" id="map11" class="map11"><!-- 광주 광역시-->
							          <area shape="poly" coords="127,216,112,215,126,244,135,234" href="#" id="map12" class="map12"><!-- 세종특별시 -->
							          <area shape="poly" coords="104,95,84,115,88,132,112,131,128,113,116,107" href="#" id="map13" class="map13"><!-- 서울특별시 -->
							          <area shape="poly" coords="304,335,295,346,298,361,306,373,322,387,329,385,329,372,344,356,342,348" href="#" id="map14" class="map14"><!--울산광역시-->
							          <area shape="poly" coords="314,385,305,374,274,393,271,415,284,416" href="#" id="map15" class="map15"><!-- 부산광역시 -->
							          <area shape="poly" coords="101,529,79,528,65,536,54,534,40,550,40,565,49,569,58,572,70,566,102,565,118,553,118,544" href="#" id="map16" class="map16"><!-- 제주특별시-->
							      </map>
								</div>
								<script src="./js/jquery.rwdImageMaps.min.js"></script>
								<script>
								$(document).ready(function(e) {
									$('img[usemap]').rwdImageMaps();
								});
								</script>
								<div class="map_status map01">
									<h4 class="tit"><img src="./images/content/local_tit_jn.png" alt="전라남도 추천 여행지" /></h4>
									<div class="img"><img src="./images/content/img_map_jn.png" alt="여수 해상 케이블카" />
										<a href="#none" class="btn">자세히보기</a>
									</div>
									<div class="t_box">
										<p class="tit">여수 해상 케이블카</p>
										<p class="txt">여수해상케이블카는 바다위를 지나 섬과 육지를 연결하는 , 국내 최최의 해상 케이블카입니다.</p>
									</div>
								</div>		
								<div class="map_status map02">
									<h4 class="tit"><img src="./images/content/local_tit_jn.png" alt="전라남도 추천 여행지" /></h4>
									<div class="img"><img src="./images/content/img_map_jn.png" alt="여수 해상 케이블카" />
										<a href="#none" class="btn">자세히보기</a>
									</div>
									<div class="t_box">
										<p class="tit">여수 해상 케이블카</p>
										<p class="txt">여수해상케이블카는 바다위를 지나 섬과 육지를 연결하는 , 국내 최최의 해상 케이블카입니다.</p>
									</div>
								</div>	
							</div>
							
						</div><!-- //recommend_box2 -->						
						<div class="recommend_box type2">
							<link href='./css/landing.css' rel='stylesheet'>
					        <link href='./css/landing.mosaic.css' rel='stylesheet'>
					        <script src="./js/mosaic.js"></script>
					        <script>
					            $(document).ready(function() {
					                var test = {size: 1200, columns: 10};
					                //var test2 = {size: 700, columns: 8};
					                var grid = $("#mosaic-grid").mosaic({
					                    tileModel: '.sizer',
					                    columns: 1,
					                    gutter: 1,
					                    heightFromWidth: true,
					                    breakpoints: [test, test2]
					                });
					
					                $(".link").click(function() {
					                    $(".active").removeClass("active");
					                    $(this).addClass("active"); 
					                });
					            });
					        </script>
							<div id="mosaic-grid" class="mosaic-grid">
								<div class="mosaic-tile sizer width-2 height-2 test mob1 a">
									<img src="./images/content/img_season01.jpg" alt="" />
									<div class="over">
										<a href="#none">
											<span class="tit">#경남</span>
											<span class="txt">#2106경남고성공룡세계엑스포</span>
											<span class="location">경상남도 고성군 하이면 덕명리30-2</span>
										</a>
									</div>
								</div>
					            <div class="mosaic-tile width-5 height-2 test mob2 a">
					            	<img src="./images/content/img_season02.jpg" alt="" />
					            	<div class="over">
										<a href="#none">
											<span class="tit">#경남</span>
											<span class="txt">#2106경남고성공룡세계엑스포</span>
											<span class="location">경상남도 고성군 하이면 덕명리30-2</span>
										</a>
									</div>
				            	</div>
					            <div class="mosaic-tile width-3 height-2 test mob3 a">
					            	<img src="./images/content/img_season03.jpg" alt="" />
					            	<div class="over">
										<a href="#none">
											<span class="tit">#경남</span>
											<span class="txt">#2106경남고성공룡세계엑스포</span>
											<span class="location">경상남도 고성군 하이면 덕명리30-2</span>
										</a>
									</div>
				            	</div>
					            <div class="mosaic-tile width-2 height-2 test mob4 a" style="margin-left:1%;">
					            	<img src="./images/content/img_season04.jpg" alt="" />
					            	<div class="over">
										<a href="#none">
											<span class="tit">#경남</span>
											<span class="txt">#2106경남고성공룡세계엑스포</span>
											<span class="location">경상남도 고성군 하이면 덕명리30-2</span>
										</a>
									</div>
				            	</div>
					            <div class="mosaic-tile height-2 width-2 test mob5 a">
					            	<img src="./images/content/img_season05.jpg" alt="" />
					            	<div class="over">
										<a href="#none">
											<span class="tit">#경남</span>
											<span class="txt">#2106경남고성공룡세계엑스포</span>
											<span class="location">경상남도 고성군 하이면 덕명리30-2</span>
										</a>
									</div>
				            	</div>
					            <div class="mosaic-tile height-2 width-6 test mob6 a">
					            	<img src="./images/content/img_season06.jpg" alt="" />
					            	<div class="over">
										<a href="#none">
											<span class="tit">#경남</span>
											<span class="txt">#2106경남고성공룡세계엑스포</span>
											<span class="location">경상남도 고성군 하이면 덕명리30-2</span>
										</a>
									</div>
				            	</div>
				            </div>
				            
						</div><!-- //recommend_box3 -->	
					</div>
				</div>
            </div><!-- cont_body -->
        </div><!-- // cont_wrap -->
        </div>
        <!--// container --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000132_E.jsp' %>