<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
	var referrer = document.reffer
</script>

			
			<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/list')}">
			<c:set value="sub01" var="sub_visual"/>
            </c:if>
            <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/detail')}">
            <c:set value="sub01" var="sub_visual"/>
            </c:if>
            <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/register')}">
            <c:set value="sub01" var="sub_visual"/>
            </c:if>
            <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/route')}">
            <c:set value="sub02" var="sub_visual"/>
            </c:if>
            <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/fame')}">
			<c:set value="sub03" var="sub_visual"/>
            </c:if>
            <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square')}">
			<c:set value="sub04" var="sub_visual"/>
            </c:if>
            <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/stats')}">
            <c:set value="sub04" var="sub_visual"/>
            </c:if>
            <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/member')}">
			<c:set value="sub05" var="sub_visual"/>
            </c:if> 
            
             <div class="section_visual <c:out value="${sub_visual}"/> trans400">
                <div class="section_tit_box">
		            <h2 class="tit trans300">
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/list')}">바다여행</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/detail')}">바다여행</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/register')}">바다여행</c:if>       
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/member')}">마이페이지</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/route')}">추천일정</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/fame')}">명성</c:if>
		         		<%--<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/member')}">마이페이지</c:if> --%>
		            	<%-- <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/statistics')}">통계</c:if> --%>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/stats')}">통계</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/email')}">이메일무단수집거부</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/info_policy')}">저작권정책</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/notice')}">공지사항</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/faq/')}">Q&A</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/faq_customer/')}">고객의소리</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/updateinfo')}">정보수정제안</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/leaflet')}">리플렛</c:if>
		        	</h2>
		            <%-- <p class="txt trans300">${pageSlogan}</p> --%>
		            <p class="txt trans300">특별하고 즐거움이 가득한 국내 바다여행</p>
        		</div>
            </div><!-- // section_visual -->
            <div class="section_lnb">
             	<div class="inr">
			        <ul id="lnb">
			        	<li><a href="<c:url value='/travel/'/>"><span class="sprh_com">HOME</span></a></li>
			        	<li id="firstmenu"><%-- <a href="/www/main"><span class="unfd sprh_com">홈</span></a> --%>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/list')}"><a href="#none">바다여행</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/detail')}"><a href="#none">바다여행</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/register')}"><a href="#none">바다여행</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/stats')}"><a href="#none">정보광장</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/member/')}"><a href="#none">마이페이지</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/route/')}"><a href="#none">추천일정</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/fame')}"><a href="#none">명성</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square')}"><a href="#none">정보광장</c:if>
			                	<span class="unfd">같은 레벨 메뉴 보기</span></a>
			                <div>
			                    <ul>
			                    <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination') || 
											fn:contains(pageContext.request.requestURI, 'travel/route') || 
											fn:contains(pageContext.request.requestURI, 'travel/fame') || 
											fn:contains(pageContext.request.requestURI, 'travel/member') || 
											fn:contains(pageContext.request.requestURI, 'board/board') ||
											fn:contains(pageContext.request.requestURI, 'travel/info_square')
											}">	
				                    <li><a href="<c:url value='/travel/destination/list.do'/>">바다여행</a></li>
				                    <li><a href="<c:url value='/travel/route/register.do'/>">나만의 여행지 만들기</a></li>
				                    <li><a href="<c:url value='/travel/route/list.do'/>">추천일정</a></li>
				                    <li><a href="<c:url value='/travel/fame/ranking.do'/>">명성</a></li>
				                    <li><a href="<c:url value='/travel/info_square/notice/index.jsp'/>">정보광장</a></li>
				                    <li><a href="<c:url value='/travel/member/mypage.do'/>">마이페이지</a></li>
								</c:if>              
			                	</ul>              
			                </div>              
			            </li>       
			                        
                         <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/list') ||
                         		 fn:contains(pageContext.request.requestURI, 'travel/destination/detail') ||
								fn:contains(pageContext.request.requestURI, 'travel/member') ||
								fn:contains(pageContext.request.requestURI, 'travel/destination/stats') ||
								fn:contains(pageContext.request.requestURI, 'travel/info_square')}">
						
								
			            <li id="secondmenu">
			                <%-- <a href="#none">작가 추전일정 --%>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/list')}"><a href="#none" class=""><c:out value="${empty pageContext.request.getParameter('destRegion') ? '전체' : pageContext.request.getParameter('destRegion')}"/></c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/detail')}"><a href="#none" class=""><c:out value="${empty pageContext.request.getParameter('destRegion') ? '전체' : pageContext.request.getParameter('destRegion')}"/></c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/mypage')}"><a href="#none">나의정보</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/detail')}"><a href="#none">나의 여행일정</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/myroute')}"><a href="#none">나의여행일정</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/clipboard')}"><a href="#none">클립보드</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/notice')}"><a href="#none">공지사항</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/faq')}"><a href="#none">Q&A</c:if>
						<%-- <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/statistics')}"><a href="#none">통계</c:if> --%>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/stats')}"><a href="#none">통계</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/info_policy')}"><a href="#none">저작권정책</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/email')}"><a href="#none">이메일수집거부</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/updateinfo')}"><a href="#none">Q&A</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/info_square/leaflet')}"><a href="#none">리플렛</c:if>
						<%-- 
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/clipboard')}"><a href="#none">공지사항</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/clipboard')}"><a href="#none">Q&A</c:if> 
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/clipboard')}"><a href="#none">통계</c:if> 
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/clipboard')}"><a href="#none">개인정보처리방침</c:if> 
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/clipboard')}"><a href="#none">이용약관</c:if> 
						--%>
			                <span class="unfd sprh_com">같은 레벨 보기</span>
			                </a>
			                <div class="snb_wrap">
			                   <ul class="snb">
			                    <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination/list') ||
			                   				 fn:contains(pageContext.request.requestURI, 'travel/destination/detail')}">	
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
								</c:if>
				
			                    <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/member/')}">
									<li><a href="<c:url value='/travel/member/mypage.do'/>">나의정보</a></li>
									<li><a href="<c:url value='/travel/member/myroute.do'/>">나의여행일정</a></li>
									<li><a href="<c:url value='/travel/member/clipboard.do'/>">클립보드</a></li>								
								</c:if>
			                    <c:if test="${fn:contains(pageContext.request.requestURI, 'board/board') || 
			                 	   fn:contains(pageContext.request.requestURI, 'travel/info_square')||
			                       fn:contains(pageContext.request.requestURI, 'travel/destination/stats')}">	
	                                <li><a href="<c:url value='/travel/info_square/notice/index.jsp'/>">공지사항</a></li>
                            		<li><a href="<c:url value='/travel/info_square/faq/index.jsp'/>">Q&A</a></li>
	                                <%-- <li><a href="<c:url value='/travel/info_square/statistics/index.jsp'/>">통계</a></li> --%>
	                                <li><a href="<c:url value='/travel/destination/stats.do'/>">통계</a></li>
	                                <li><a href="<c:url value='/travel/info_square/leaflet/index.jsp'/>">리플렛</a></li>
	                                <li><a href="<c:url value='/travel/info_square/info_policy/index.jsp'/>">저작권정책</a></li>
	                                <li><a href="<c:url value='/travel/info_square/email/index.jsp'/>">이메일무단수집거부</a></li>
								</c:if> 
			                	</ul>
			                </div>
			            </li> 
					</c:if>
					</ul>
		         </div>
    		</div><!-- // section_lnb -->
