<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

		<div id="header" class="trans">
			<h1 class="logo trans"><a href="<c:url value='/travel/'/>" class="trans">바다여행 |바다여행 일정만들기</a></h1>
			<ul class="util_top trans">
            <c:if test="${loginVO == null}">
				<li><a href="<c:url value='/travel/login.jsp'/>">로그인</a></li>
				<li><a href="<c:url value="/images/travel/content/leaflet_down.pdf"/>">리플렛다운</a></li>
            </c:if>
            <c:if test="${loginVO != null}">
                <li><a href="<c:url value="/uat/uia/actionLogout.do"/>">로그아웃</a></li>
				<li><a href="<c:url value="/travel/member/mypage.do"/>">마이페이지</a></li>
				<li><a href="<c:url value="/images/travel/content/leaflet_down.pdf"/>">리플렛다운</a></li>
            </c:if>
			</ul>
            <!-- GNB -->
            <div class="gnb_wrap">
                <ul id="gnb">
                    <li><a href="<c:url value='/travel/destination/list.do'/>">바다여행</a>
                        <div>
                            <ul>
                        		<li><a href="<c:url value='/travel/destination/list.do?destRegion=강원'/>">강원도</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=경기'/>">경기도</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=경남'/>">경상남도</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=경북'/>">경상북도</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=광주'/>">광주광역시</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=대구'/>">대구광역시</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=대전'/>">대전광역시</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=부산'/>">부산광역시</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=서울'/>">서울특별시</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=세종'/>">세종특별자치시</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=울산'/>">울산광역시</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=인천'/>">인천광역시</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=전남'/>">전라남도</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=전북'/>">전라북도</a></li>
                          		<li><a href="<c:url value='/travel/destination/list.do?destRegion=제주'/>">제주도</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=충남'/>">충청남도</a></li>
                           		<li><a href="<c:url value='/travel/destination/list.do?destRegion=충북'/>">충청북도</a></li>
                        	</ul>
                        </div>
                    </li>
                    
                    
                    <li><a href="<c:url value='/travel/route/register.do'/>">나만의 여행지 만들기</a></li>
                    <li><a href="<c:url value='/travel/route/list.do'/>">추천일정</a></li>
                    <li><a href="<c:url value='/travel/fame/ranking.do'/>">명성</a></li>
                    <li><a href="<c:url value='/travel/info_square/notice/index.jsp'/>">정보광장</a>
                    <!-- <li><a href="<c:url value='/travel/info_square/notice/index.jsp'/>">정보광장</a> -->
                        <div>
                            <ul>
                                <li><a href="<c:url value='/travel/info_square/notice/index.jsp'/>">공지사항</a></li>
                                <li><a href="<c:url value='/travel/info_square/faq/index.jsp'/>">Q&A</a></li>
                                 <%-- <li><a href="<c:url value='/travel/info_square/statistics/index.jsp'/>">통계</a></li> --%>
                                <li><a href="<c:url value='/travel/destination/stats.do'/>">통계</a></li>
                                <li><a href="<c:url value='/travel/info_square/leaflet/index.jsp'/>">리플렛</a></li>
                                 <li><a href="<c:url value='/travel/info_square/recommendation/index.jsp'/>">추천10선</a></li>
                               	<li><a href="<c:url value='/travel/info_square/info_policy/index.jsp'/>">저작권정책</a></li>
                               	<li><a href="<c:url value='/travel/info_square/email/index.jsp'/>">이메일무단수집거부</a></li>
                            </ul>
                        </div> 
                    </li>
                      <li><a href="<c:url value='/travel/destination/summerlist.do'/>">여름시즌</a>
                       <div>
                        <ul>
                         <li><a href="<c:url value='/travel/destination/summerlist.do'/>">한적한 해수욕장25선</a></li>
                        <li><a href="<c:url value='/travel/reservation/area.do'/>">예약시스템</a></li>
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
                            	<li><a href="<c:url value='/travel/login.jsp'/>">로그인</a></li>
                            	<li><a href="<c:url value='/travel/member/mypage.do'/>">마이페이지</a></li>
                            	
							</ul>
                            <button type="button" class="btn_close">전체메뉴 닫기</button>
                        </div>
                        <div class="nav">
                            <ul id="gnb_mobile">
                                <li><a href="<c:url value='/travel/destination/list.do'/>">바다여행</a>
                                	<ul>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=강원'/>">강원도</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=경기'/>">경기도</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=경남'/>">경상남도</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=경북'/>">경상북도</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=광주'/>">광주광역시</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=대구'/>">경기도</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=대전'/>">대전광역시</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=부산'/>">부산광역시</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=서울'/>">서울특별시</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=세종'/>">세종특별자치시</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=울산'/>">울산광역시</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=인천'/>">인천광역시</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=전남'/>">전라남도</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=전북'/>">전라북도</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=제주'/>">제주도</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=충남'/>">충청남도</a></li>
                                		<li><a href="<c:url value='/travel/destination/list.do?destRegion=충북'/>">충청북도</a></li>
                                	</ul>
                                </li>
                                <li><a href="<c:url value='/travel/route/register.do'/>">나만의 여행일정 만들기</a></li>
                                <li><a href="<c:url value='/travel/route/list.do'/>">추천여행일정</a></li>
                                <li><a href="<c:url value='/travel/fame/ranking.do'/>">명성</a></li>
                                <li><a href="<c:url value='/travel/info_square/notice/index.jsp'/>">정보광장</a>
                                    <ul>
                                        <li><a href="<c:url value='/travel/info_square/notice/index.jsp'/>">공지사항</a></li>
                            		    <li><a href="<c:url value='/travel/info_square/faq/index.jsp'/>">Q&A</a></li>
		                                <%-- <li><a href="<c:url value='/travel/info_square/statistics/index.jsp'/>">통계</a></li> --%>
                                        <li><a href="<c:url value='/travel/destination/stats.do'/>">통계</a></li>
                                        <li><a href="<c:url value='/travel/info_square/leaflet/index.jsp'/>">리플렛</a></li>
                                         <li><a href="<c:url value='/travel/info_square/recommendation/index.jsp'/>">추천10선</a></li>
                               		    <li><a href="<c:url value='/travel/info_square/info_policy/index.jsp'/>">저작권정책</a></li>
                               			<li><a href="<c:url value='/travel/info_square/email/index.jsp'/>">이메일무단수집거부</a></li>
                               			
                                    </ul>
                                </li>
                                 <li><a href="<c:url value='/travel/destination/summerlist.do'/>">여름시즌</a>
                      				 <div>
                      				  <ul>
                      				  	 <li><a href="<c:url value='/travel/destination/summerlist.do'/>">한적한 해수욕장25선</a></li>
                       					 <li><a href="<c:url value='/travel/reservation/area.do'/>">해수욕장 예약시스템</a></li>
                     				  </ul>
                     			    </div>
                     </li>
                            </ul>
                        </div>
                    </div>
                    <div class="wvBg"></div>
                </div>
            </div>
            <!-- //모바일 전체메뉴 -->
		</div>
