<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><% /* cset_s */ %><% String servletPath = request.getServletPath(); %><% String[] Jnit_ServletPath = servletPath.split("/"); String Jnit_sitePath = Jnit_ServletPath[1]; %><c:set var="Jnit_sitePath" value="<%= Jnit_sitePath %>" scope="request"/><%@ page import="egovframework.com.utl.fcc.service.StringUtil"%><% String localYn = ""; if(StringUtil.isExistString(request.getRequestURL().toString(),"local")) localYn="Y"; %><c:set var="localYn" value="<%= localYn %>" scope="request" /><% /* cset_e */ %><% /*<!-- [-CONTENT-] -->*/ %><%
/**
 *@version 3.2.0.1
 **/
%>
<%@ include file="/_common/stateCount.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <html lang="ko" class="skrollr skrollr-desktop">
<head>
<title>해양레저</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,maximum-scale=1,minimum-scale=1">
<%@ include file="/travel/common/config/handing/cssHanding.jsp" %>

<%@ include file="/travel/common/config/handing/jsHanding.jsp" %>
</head>

<body>
	<div id="wrap">
		<div id="accessibility"><a href="#content">본문 바로가기</a></div>
		<!-- header -->
		<div id="header" class="trans">
				<h1 class="logo trans"><a href="/travel/index.jsp" class="trans">바다여행 |바다여행 일정만들기</a></h1>
				<ul class="util_top trans">
					<li><a href="/travel/login/index.jsp">로그인</a></li>
					<li><a href="/travel/mypage/index.jsp">마이페이지</a></li>
				</ul>
                <!-- GNB -->
                <div class="gnb_wrap">
                    <ul id="gnb">
                        <li><a href="/travel/destination/list.do">바다여행</a>
                            <div>
                                <ul>
	                        		<li><a href="/travel/destination/list.do?destRegion=부산">부산광역시</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=대구">대구광역시</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=인천">인천광역시</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=대전">대전광역시</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=울산">울산광역시</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=경기">경기도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=충북">충청북도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=충남">충정남도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=전북">전라북도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=전남">전라남도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=경북">경상북도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=경남">경상남도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=제주">제주특별자치도</a></li>
	                        	</ul>
                            </div>
                        </li>
                        <li><a href="/travel/route/register.do">나만의 여행지 만들기</a></li>
                        <li><a href="/travel/route/list.do">추천일정</a></li>
                        <li><a href="/travel/honor/index.jsp">명성</a></li>
                        <li><a href="#">정보광장</a>
                            <div>
                               <ul>
	                                <li><a href="/board/board.do?boardId=bbs_0000000000000014">공지사항</a></li>
	                                <li><a href="/travel/info_square/faq/index.jsp">Q&A</a></li>
	                                <li><a href="/travel/info_square/statistics/index.jsp">통계</a></li>
	                                <li><a href="">개인정보처리방침</a></li>
	                                <li><a href="">이용약관</a></li>
	                            </ul>
                            </div>
                        </li>
                    </ul>
                 </div>
                <!-- // GNB -->
                <!-- 모바일 전체메뉴 -->
                <div class="mobile_wholeview">
                    <button type="button" class="btn_wv">전체메뉴</button>
                    <div id="wholeView" class="open">
                        <div class="wv_wrap">
                            <div class="wv_wrap_head">
                                <ul class="wv_util">
                                	<li><a href="#none">로그인</a></li>
                                	<li><a href="#none">마이페이지</a></li>
								</ul>
                                <button type="button" class="btn_close">전체메뉴 닫기</button>
                            </div>
                            <div class="nav">
                                <ul id="gnb_mobile">
                                    <li><a href="#">바다여행</a>
                                    	<ul>
                                    		<li><a href="/travel/destination/list.do?destRegion=부산">부산광역시</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=대구">대구광역시</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=인천">인천광역시</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=대전">대전광역시</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=울산">울산광역시</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=경기">경기도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=충북">충청북도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=충남">충정남도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=전북">전라북도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=전남">전라남도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=경북">경상북도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=경남">경상남도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=제주">제주특별자치도</a></li>
                                    	</ul>
                                    </li>
                                    <li><a href="/travel/route/register.do">나만의 여행일정 만들기</a></li>
                                    <li><a href="/travel/route/list.do">추천여행일정</a></li>
                                    <li><a href="/travel/honor/index.jsp">명성</a></li>
                                    <li><a href="">정보광장</a>
                                       <ul>
                                            <li><a href="/travel/info_square/notice/index.jsp">공지사항</a></li>
			                                <li><a href="/travel/info_square/faq/index.jsp">Q&A</a></li>
			                                <li><a href="/travel/info_square/statistics/index.jsp">통계</a></li>
			                                <li><a href="">개인정보처리방침</a></li>
			                                <li><a href="">이용약관</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="wvBg"></div>
                    </div>
                </div>
                <!-- //모바일 전체메뉴 -->
		      </div>
		<!-- // header -->
	<!-- contaniner -->
		<div id="container" >
			<!-- cont_main -->
			<div class="cont_main" id="content">
				<div class="spotzone trans400">
					<ul class="list">
						<li class="n01"></li>
						<li class="n02"></li>
					</ul>
					<div class="main_visual_wrap">
						<div class="main_visual_content">
							<div class="main_visual_content_cell">
								<div class="main_visual_content_cell_weather">
									<div class="weather">
										<img src="/travel/common/images/main/icon_weather_01.png" alt=""/>
										<span>7℃</span>
									</div>
									<div class="dust">
										<dl>
											<dt>미세먼지</dt>
											<dd>좋음<img src="/travel/common/images/main/icon_dust_good.png" alt="좋음"/></dd>
										</dl>
										<dl>
											<dt>초미세먼지</dt>
											<dd>나쁨<img src="/travel/common/images/main/icon_dust_bad.png" alt="나쁨"/></dd>
										</dl>
									</div>
								</div>
								  <div class="main_visual_content_cell_left">
								 	<p class="tit">내가 만드는 <strong>바다여행</strong></p> 	 
								 	<p class="sub_tit">
								 		언제든 누구와든 함께 떠나기 좋은<br />
										공기좋고 깨끗한 국내 바다여행 일정만들기
								 	</p> 	 
								  	<ul class="img_lst">
								  		<li><img src="/travel/common/images/main/img_visual_s1.png" alt="해파랑공원" /></li>
								  		<li><img src="/travel/common/images/main/img_visual_s2.png" alt="호미곶" /></li>
								  		<li><img src="/travel/common/images/main/img_visual_s3.png" alt="주상절리" /></li>
								  	</ul>
								  </div>
								 
								  <div class="main_visual_content_cell_right">
								  	 <div class="main_visual_content_cell_right_inr">
									  	 <div class="visual_arrow">
										  	 <img src="/travel/common/images/main/img_visual_arrow.png" alt="" />
										  </div>
									  	 <a href="#none" class="point point1">인천광역시</a>
									  	 <a href="#none" class="point point2">경기도</a>
									  	 <a href="#none" class="point point3">강원도</a>
									  	 <a href="#none" class="point point4">충청남도</a>
									  	 <a href="#none" class="point point5">충청북도</a>
									  	 <a href="#none" class="point point6">경상북도</a>
									  	 <a href="#none" class="point point7">대구광역시</a>
									  	 <a href="#none" class="point point8">울산광역시</a>
									  	 <a href="#none" class="point point9">전라북도</a>
									  	 <a href="#none" class="point point10">경상남도</a>
									  	 <a href="#none" class="point point11">부산광역시</a>
									  	 <a href="#none" class="point point12">전라남도</a>
									  	 <a href="#none" class="point point13">제주특별시</a>
									  </div>
								  </div>
								  <div class="spot_search">
								  	<div class="cssSelect">
								  		<button type="button">부산광역시</button>
								  		<ul class="lst">
								  			<li><a href="#none">부산광역시</a></li>
								  			<li><a href="#none">대구광역시</a></li>
								  			<li><a href="#none">인천광역시</a></li>
								  			<li><a href="#none">대전광역시</a></li>
								  			<li><a href="#none">울산광역시</a></li>
								  			<li><a href="#none">경기도</a></li>
								  			<li><a href="#none">충청북도</a></li>
								  			<li><a href="#none">충청남도</a></li>
								  			<li><a href="#none">전라북도</a></li>
								  			<li><a href="#none">전라남도</a></li>
								  			<li><a href="#none">경상북도</a></li>
								  			<li><a href="#none">경상남도</a></li>
								  			<li><a href="#none">제주특별자치도</a></li>
								  		</ul>
							  		</div>
								  </div>
								  <div class="visual_go">
								  		<a href="#none" class="button mv_btn01">여행일정 만들기</a>
								  		<a href="#none" class="button mv_btn02">여행일정 검색</a>
								  </div>
							</div>
						</div>
					</div>
				</div><!-- //spotzone -->
				<div class="section01 aos-init aos-animate" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="200">
					<div class="minr">
					    <div class="event_tbox">
					    	<p class="event_txt">SNS를 통해 친구를 초대하면 <span>추첨을통해 온누리상품권을</span> 드립니다!</p>
					    	<p class="event_sub_txt">바다여행을 좋아하는 친구들을 초대하면 추첨을 통해 온누리 상품권을 받으세요.</p>
					    </div>
					    <div class="event_btnbox">
					    	<a href="#none" class="button">이벤트 보기</a>
					    </div>
				    </div>
			    </div> <!-- // section01 -->  
			    <div class="section02 aos-init aos-animate" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
			    	<div class="minr">
				    	<div class="tit_box">
				    		<p class="txt">국내 인기 바다여행지를 추천해드립니다.</p>
					        <p class="tit">베스트 <strong>여행 추천 일정</strong></p>
					    </div>
					    <div class="vest_recommend_box">
					    	<div class="name_tit">BEST 여행일정</div>
					    	<div class="col01">
					    		<div class="img"><a href="#none"><img src="/travel/common/images/main/img_vest_photo01.jpg" alt="" /></a></div>
					    		<div class="tbox">
					    			<span>[삼척]</span>
					    			<p>맑고 깨끗한 삼척의<br />바다를 즐기다</p>
					    		</div>
					    	</div>
					    	<div class="col02">
					    		<ul>
					    			<li>
					    				<a href="#none">
						    				<span class="img"><img src="/travel/common/images/main/img_vest_photo02.jpg" alt="" /></span>
						    				<span class="text"><span class="local">[부산]</span>부산의 바다를 제대로 감상하고 맛볼 수 있는 해운대..</span>
					    				</a>
					    			</li>
					    			<li>
					    				<a href="#none">
						    				<span class="img"><img src="/travel/common/images/main/img_vest_photo03.jpg" alt="" /></span>
						    				<span class="text"><span class="local">[전남]</span>여수시 우주과학 체험여행</span>
					    				</a>
					    			</li>
					    			<li>
					    				<a href="#none">
						    				<span class="img"><img src="/travel/common/images/main/img_vest_photo04.jpg" alt="" /></span>
						    				<span class="text"><span class="local">[경남]</span>공룡발자국 따라 떠나는 고성 바다여행</span>
					    				</a>
					    			</li>
					    			<li>
					    				<a href="#none">
						    				<span class="img"><img src="/travel/common/images/main/img_vest_photo05.jpg" alt="" /></span>
						    				<span class="text"><span class="local">[전남]</span>전남 여수시 우주과학 체험여행</span>
					    				</a>
					    			</li>
					    		</ul>
					    	</div>
					    </div>
					    <div class="writer_recommend_box">
					    	<div class="name_tit">여행작가<br />추천일정</div>
					    	<div class="tit_box">
					    		<p class="txt">국내 인기 바다여행지를 추천해드립니다.</p>
						        <p class="tit">여행작가 <strong>여행 추천 일정</strong></p>
						    </div>
							<div class="area_ctrl">
								<button type="button" class="play"> 재생</button>
								<button type="button" class="pause active"> 정지</button>
							</div>
					    	<div class="main_writer_slider">
								<div class="main_writer_item">
							        <div class="main_writer_img">
							            <img src="/travel/common/images/main/img_writer_photo01.jpg" alt="" />
							        </div>
							        <div class="main_writer_txt">
							        	<p class="tit">
							        		부산의 바다를 제대로 감상하고
											맛볼 수 있는 해운대 & 기장 여행
							        	</p>
							        	<p class="txt">
							        		대한팔경의 하나인 해운대 해수욕장은 백사장의 길이가 1.5Km,
											폭 30~50m 이며,  평균수심은 1m(해수욕장의 면적 58,400㎡) 
											정도이며, 여름철평균 수온은 22.6℃로  따뜻해 수온으로 해수욕...
							        	</p>
							        	<p class="more2">
							        		<a href="#none">자세히 보기</a>
							        	</p>
							        </div>
								</div>
								<div class="main_writer_item">
							        <div class="main_writer_img">
							            <img src="/travel/common/images/main/img_writer_photo01.jpg" alt="" />
							        </div>
							        <div class="main_writer_txt">
							        	<p class="tit">
							        		부산의 바다를 제대로 감상하고
											맛볼 수 있는 해운대 & 기장 여행
							        	</p>
							        	<p class="txt">
							        		대한팔경의 하나인 해운대 해수욕장은 백사장의 길이가 1.5Km,
											폭 30~50m 이며,  평균수심은 1m(해수욕장의 면적 58,400㎡) 
											정도이며, 여름철평균 수온은 22.6℃로  따뜻해 수온으로 해수욕...
							        	</p>
							        	<p class="more2"><a href="#none">자세히 보기</a></p>
							        </div>
								</div>
							</div>
					    </div>
			    	</div>
			    </div><!-- // section02 --> 
			    <div class="section03 aos-init aos-animate" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
					<div class="minr">
					    <div class="tit_box">
					    	<p class="txt">다양한 해양레저 컨텐츠를 추천해드립니다.</p>
					        <p class="tit"><strong>해양레저</strong> 추천컨텐츠</p>
					    </div>
	                    <div class="main_cont_wrap">
	                        <div class="slick-control">
	                            <button class="slick-arrows slick-prev main_cont_prev" type="button">PREV</button>
	                            <button class="slick-arrows slick-next main_cont_next" type="button">NEXT</button>
	                        </div><!-- .slick-control -->
	                        <div class="main_cont_slider">
								<div class="main_cont_item">
							        <div class="main_cont_img">
							        	<div class="inner">
								            <img src="/travel/common/images/main/img_cont_photo01.jpg" alt="" />
								            <div class="tbox">
								            	<p class="sub">인천 소무의도</p>
								            	<p class="tit">무의 바다누리길</p>
							            	</div>
								            <div class="more"><a href="#none">자세히보기</a></div>
								            <div class="inner_box"></div>
							            </div>
							        </div>
							        <div class="main_cont_txt">
							        	<p class="tit">
							        		<span>무의 바다누리길</span>
							        		여행코스
							        	</p>
							        	<div class="course">
							        	<ul class="lst">
							        		<li>광명항</li>
							        		<li>소무의인도교</li>
							        		<li>떼무리선착장</li>
							        		<li>진입광장</li>
							        		<li>부처깨미전망대</li>
							        		<li>몽여해변</li>
							        		<li>광명항</li>
							        		<li>소무의인도교</li>
							        		<li>떼무리선착장</li>
							        		<li>진입광장</li>
							        		<li>부처깨미전망대</li>
							        		<li>몽여해변</li>
							        	</ul>	
							        	</div>
							        </div>
								</div>
								<div class="main_cont_item">
							        <div class="main_cont_img">
							        	<div class="inner">
								            <img src="/travel/common/images/main/img_cont_photo01.jpg" alt="" />
								            <div class="tbox">
								            	<p class="sub">여수 금오도</p>
								            	<p class="tit">비렁길 트레킹 여행</p>
							            	</div>
								            <div class="more"><a href="#none">자세히보기</a></div>
								            <div class="inner_box"></div>
							           </div>
							        </div>
							        <div class="main_cont_txt">
							        	<p class="tit">
							        		<span>금오도 비렁길</span>
							        		여행코스
							        	</p>
							        	<div class="course">
							        	<ul class="lst">
							        		<li>함구미</li>
							        		<li>미역널방</li>
							        		<li>송광사절터</li>
							        		<li>신선대</li>
							        		<li>두포</li>
							        	</ul>	
							        	</div>
							        </div>
								</div>
								<div class="main_cont_item">
							        <div class="main_cont_img">
							        	<div class="inner">
								            <img src="/travel/common/images/main/img_cont_photo01.jpg" alt="" />
								            <div class="tbox">
								            	<p class="sub">인천 소무의도</p>
								            	<p class="tit">무의 바다누리길</p>
							            	</div>
								            <div class="more"><a href="#none">자세히보기</a></div>
								            <div class="inner_box"></div>
							            </div>
							        </div>
							        <div class="main_cont_txt">
							        	<p class="tit">
							        		<span>무의 바다누리길</span>
							        		여행코스
							        	</p>
							        	<div class="course">
							        	<ul class="lst">
							        		<li>광명항</li>
							        		<li>소무의인도교</li>
							        		<li>떼무리선착장</li>
							        		<li>진입광장</li>
							        		<li>부처깨미전망대</li>
							        		<li>몽여해변</li>
							        		<li>광명항</li>
							        		<li>소무의인도교</li>
							        		<li>떼무리선착장</li>
							        		<li>진입광장</li>
							        		<li>부처깨미전망대</li>
							        		<li>몽여해변</li>
							        	</ul>	
							        	</div>
							        </div>
								</div>
								<div class="main_cont_item">
							        <div class="main_cont_img">
							        	<div class="inner">
								            <img src="/travel/common/images/main/img_cont_photo01.jpg" alt="" />
								            <div class="tbox">
								            	<p class="sub">여수 금오도</p>
								            	<p class="tit">비렁길 트레킹 여행</p>
							            	</div>
								            <div class="more"><a href="#none">자세히보기</a></div>
								            <div class="inner_box"></div>
							           </div>
							        </div>
							        <div class="main_cont_txt">
							        	<p class="tit">
							        		<span>금오도 비렁길</span>
							        		여행코스
							        	</p>
							        	<div class="course">
							        	<ul class="lst">
							        		<li>함구미</li>
							        		<li>미역널방</li>
							        		<li>송광사절터</li>
							        		<li>신선대</li>
							        		<li>두포</li>
							        	</ul>	
							        	</div>
							        </div>
								</div>
							</div>
						</div>
					</div>
				</div><!-- // section03 --> 
			    <div class="section04 aos-init aos-animate" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
					<div class="minr">
	                    <div class="main_event_wrap">
	                    	<div class="cont_tit">바다여행 축제일정</div>
	                    	<div class="area_ctrl">
								<button type="button" class="play"> 재생</button>
								<button type="button" class="pause active"> 정지</button>
							</div>
	                        <div class="main_event_slider">
								<div class="main_event_item">
							        <figure>
							            <img src="/travel/common/images/main/img_ev_photo01.jpg" alt="" />
							        </figure>
							        <div class="main_event_txt">
							        	<p class="tit"><a href="#none">부산크리스마스트리 문화 축제</a></p>
							        	<p class="date">2020. 01. 21 ~ 2020. 01. 24</p>
							        	<p class="txt">
							        		부산크리스마스트리문화축제가 11회째를 
											맞이했다. 트리축제라는 이름처럼 빛의 향연이 
											광복동 거리를 화려하게 수놓고, 문화축제라...
							        	</p>
							        </div>
								</div>
								<div class="main_event_item">
							        <figure>
							            <img src="/travel/common/images/main/img_ev_photo02.jpg" alt="" />
							        </figure>
							        <div class="main_event_txt">
							        	<p class="tit"><a href="#none">포천산정호수 썰매축제 2020</a></p>
							        	<p class="date">2020. 01. 30</p>
							        	<p class="txt">
							        		다채로운 볼거리와 즐길거리,먹거리가 가득한 
											썰매축제에 가족,연인,친구와 함께 오셔서 
											산정호수 풍경도 감상하시고,썰매축제에...
							        	</p>
							        </div>
								</div>
								<div class="main_event_item">
							        <figure>
							            <img src="/travel/common/images/main/img_ev_photo03.jpg" alt="" />
							        </figure>
							        <div class="main_event_txt">
							        	<p class="tit"><a href="#none">산정호수 윈터 페스타 2019</a></p>
							        	<p class="date">2020. 02. 15 ~ 2020. 02. 18</p>
							        	<p class="txt">
							        		꽁꽁 언 산정호수 위에서 즐기는 스릴만점
											빙상체험 "산정호수 썰매축제"
							        	</p>
							        </div>
								</div>
								<div class="main_event_item">
							        <figure>
							            <img src="/travel/common/images/main/img_ev_photo01.jpg" alt="" />
							        </figure>
							        <div class="main_event_txt">
							        	<p class="tit"><a href="#none">부산크리스마스트리 문화 축제</a></p>
							        	<p class="date">2020. 01. 21 ~ 2020. 01. 24</p>
							        	<p class="txt">
							        		부산크리스마스트리문화축제가 11회째를 
											맞이했다. 트리축제라는 이름처럼 빛의 향연이 
											광복동 거리를 화려하게 수놓고, 문화축제라...
							        	</p>
							        </div>
								</div>
								<div class="main_event_item">
							        <figure>
							            <img src="/travel/common/images/main/img_ev_photo01.jpg" alt="" />
							        </figure>
							        <div class="main_event_txt">
							        	<p class="tit"><a href="#none">부산크리스마스트리 문화 축제</a></p>
							        	<p class="date">2020. 01. 21 ~ 2020. 01. 24</p>
							        	<p class="txt">
							        		부산크리스마스트리문화축제가 11회째를 
											맞이했다. 트리축제라는 이름처럼 빛의 향연이 
											광복동 거리를 화려하게 수놓고, 문화축제라...
							        	</p>
							        </div>
								</div>
							</div>
							<div class="more"><a href="#none">축제일정 더보기</a></div>
						</div>
						<div class="fame_box">
							<div class="txt_area">
								<p class="tit">
									바다여행일정<br />
									<strong>명성이란?</strong>
								</p>
								<p class="txt">
									일정만들기,공유하기,추천하기등<br />
									홈페이 활동에 따라 올라가는 <br />
									내 점수를 확인해보세요.
								</p>
								<p class="more2"><a href="#none">자세히보기</a></p>
							</div>
							<ul class="fame_item">
								<li>
									<span class="icon01"></span>
									<div class="txt">
										<strong>추천하기</strong>
										<p>
											잘 만들어진 여행일정을 <br />
											추천해 보세요.
										</p>
									</div>
								</li>
								<li>
									<span class="icon02"></span>
									<div class="txt">
										<strong>공유하기</strong>
										<p>
											SNS친구들에게<br />
											여행일정을 공유하고<br />
											함께 소통해보세요.
										</p>
									</div>
								</li>
								<li>
									<span class="icon03"></span>
									<div class="txt">
										<strong>일정만들기</strong>
										<p>
											내가 만든 여행일정을<br />
											사람들에게 자랑해보세요.
										</p>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div><!-- // section04 --> 
				<script>// <![CDATA[
			       AOS.init({
			          offset: 0,
			          easing: 'ease-out-quad',
			        });
			// ]]></script>	
			</div>
			<!--// cont_main -->
		</div>
		<!--// container -->
	 <!-- footer -->
		<div id="footer">
			<div class="inr">
				<div class="foot_wrap">
					<ul class="foot_util">
						<li><a href="#none">개인정보처리방침</a></li>
						<li><a href="#none">이메일무단수집거부</a></li>
						<li><a href="#none">이용약관</a></li>
						<li><a href="#none">고객의소리</a></li>
						<li><a href="#none">사이트맵</a></li>
					</ul>
					<ul class="foot_info">
						<li>08588 서울특별시 금천구 가산디지털2로 53 한라시그마밸리 12층</li>
						<li><strong class="color_light_red">080-500-8579</strong>(파도친구) 평일 09:00 ~ 18:00, 점심시간 12:00 ~ 13:00<br /> seantourfipa@gmail.com</li>
						<li>(사) 전국어촌체험마을연합회 | 대표 권영환</li>
					</ul>
				</div>
				<div class="footer_go">
					<a href="#none" class="modipy">
						수정정정요청
					</a>
					<a  href="#none" class="notice">
						공지사항
					</a>
				</div>
				<div class="skip_top">
					<a href="#wrap"><div class="skip_top_btn"><span>TOP</span></div></a>
				</div>
			</div>
		</div>
		<!-- // Footer -->
	</div>
	<!-- // wrap -->
</body>
</html><% /*<!-- /[-CONTENT-] -->*/ %>