<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><div class="section_visual sub01 trans400">
                <div class="section_tit_box">
		            <h2 class="tit trans300">
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination')}">바다여행</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/route')}">추천여행일정</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/fame')}">명성</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/member')}">마이페이지</c:if>
		        	</h2>
		            <%-- <p class="txt trans300">${pageSlogan}</p> --%>
		            <p class="txt trans300">특별하고 즐거움이 가득한 국내 바다여행</p>
        		</div>
            </div><!-- // section_visual -->
            <div class="section_lnb">
             	<div class="inr">
			        <ul id="lnb">
			        	<li><a href="#none"><span class="sprh_com">HOME</span></a></li>
			        	<li id="firstmenu"><%-- <a href="/www/main"><span class="unfd sprh_com">홈</span></a> --%>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination')}"><a href="#none">바다여행</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/route')}"><a href="#none">추천여행일정</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/fame')}"><a href="#none">명성</c:if>
		            	<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/member')}"><a href="#none">마이페이지</c:if>
			                	<span class="unfd">같은 레벨 메뉴 보기</span></a>
			                <div>
			                    <ul>
			                    <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination') || 
											fn:contains(pageContext.request.requestURI, 'travel/route') || 
											fn:contains(pageContext.request.requestURI, 'travel/fame') || 
											fn:contains(pageContext.request.requestURI, 'travel/member') || 
											fn:contains(pageContext.request.requestURI, 'board/board')}">	
				                    <li><a href="/travel/destination/list.do">바다여행</a></li>
				                    <li><a href="/travel/route/register.do">나만의 여행지 만들기</a></li>
				                    <li><a href="/travel/route/list.do">추천일정</a></li>
				                    <li><a href="/travel/fame/ranking.do">명성</a></li>
				                    <li><a href="/board/board.do?boardId=bbs_0000000000000014">정보광장</a>
				                    <li><a href="/travel/member/mypage.do">마이페이지</a>
								</c:if>
			                	</ul>
			                </div>  
			            </li>
                    <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination') || 
								fn:contains(pageContext.request.requestURI, 'travel/member') || 
								fn:contains(pageContext.request.requestURI, 'board/board')}">	
			            <li id="secondmenu">
			                <%-- <a href="#none">작가 추전일정 --%>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination')}"><a href="#none"><c:out value="${empty pageContext.request.getParameter('destRegion') ? '전체' : pageContext.request.getParameter('destRegion')}"/></c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/mypage')}"><a href="#none">나의정보</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/myroute')}"><a href="#none">나의여행일정</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/clipboard')}"><a href="#none">클립보드</c:if>
	                        		<%-- 
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
	                        		--%>
						<%-- 
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/clipboard')}"><a href="#none">공지사항</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/clipboard')}"><a href="#none">Q&A</c:if> 
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/clipboard')}"><a href="#none">통계</c:if> 
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/clipboard')}"><a href="#none">개인정보처리방침</c:if> 
						<c:if test="${fn:contains(pageContext.request.requestURI, 'member/clipboard')}"><a href="#none">이용약관</c:if> 
						--%>
			                	<span class="unfd sprh_com">같은 레벨 메뉴 보기</span></a>
			                <div class="snb_wrap">
			                   <ul class="snb">
			                    <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/destination')}">	
	                        		<li><a href="/travel/destination/list.do">전체</a></li>
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
								</c:if>
			                    <c:if test="${fn:contains(pageContext.request.requestURI, 'travel/member')}">	
									<li><a href="/travel/member/mypage.do">나의정보</a></li>
									<li><a href="/travel/member/myroute.do">나의여행일정</a></li>
									<li><a href="/travel/member/clipboard.do">클립보드</a></li>
								</c:if>
			                    <c:if test="${fn:contains(pageContext.request.requestURI, 'board/board')}">	
	                                <li><a href="/board/board.do?boardId=bbs_0000000000000014">공지사항</a></li>
	                                <li><a href="/board/board.do?boardId=bbs_0000000000000021">Q&A</a></li>
	                                <li><a href="#">통계</a></li>
	                                <li><a href="#">개인정보처리방침</a></li>
	                                <li><a href="#">이용약관</a></li>
								</c:if> 
			                	</ul> 
			                </div>
			            </li> 
					</c:if>
					</ul>
		         </div>
    		</div><!-- // section_lnb --><% /*<!-- /[-CONTENT-] -->*/ %>