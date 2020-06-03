<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

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
	                        <c:forEach var="result" items="${resultList}" varStatus="status">
							        	<c:if test="${status.index gt 0}">
								<div class="main_cont_item">
							        <div class="main_cont_img">
							        	<div class="inner">	
										<c:set var="routThumbPath" value="${empty result.destImgPath ? '/images/travel/content/noimg.jpg' : result.destImgPath}" />
								            <img src="/seantour_map/${result.destImgPath}" alt="" />
								            <div class="tbox">
								            	<p class="sub">${result.destRegion}</p>
								            	<p class="tit">${result.destTitle}</p>
							            	</div>
								           <div class="more"><a href="/seantour_map/travel/destination/detail.do?destId=${result.destId}">자세히보기</a></div>
								            <div class="inner_box"></div>
							            </div>
							        </div>
							        </c:if>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div><!-- // section03 --> 