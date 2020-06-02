<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000138_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><div id="content" class="cont_wrap ">
      
            <div class="cont_body">
	            <div class="inr">
	          
	            <c:choose>
					<c:when test ="${fn:contains(pageContext.request.requestURI , 'seantour_map/travel/info_square/notice/')}"></c:when>
					<c:otherwise>
					<div class="tabmenu">
					 <c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/faq/')}">
						<a href="#none">Q&A<span class="unfd sprh_com"></span></a>
					 </c:if> 
					  <c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/updateinfo')}">
						<a href="#none">정보수정제안<span class="unfd sprh_com"></span></a>
					 </c:if>
					  <c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/faq_customer')}">
						<a href="#none">고객의소리<span class="unfd sprh_com"></span></a>
					 </c:if>	 
						<ul>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/faq/')}">
							<li><a href="<c:url value="/travel/info_square/faq/index.jsp"/>" class='on'><span>FAQ</span></a></li>
							<li><a href="<c:url value="/travel/info_square/faq_customer/index.jsp"/>"><span>고객의 소리</span></a></li>
							<li><a href="<c:url value="/travel/info_square/updateinfo/index.jsp"/>"><span>정보수정제안</span></a></li>
						</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/updateinfo')}">
							<li><a href="<c:url value="/travel/info_square/faq/index.jsp"/>"><span>FAQ</span></a></li>
							<li><a href="<c:url value="/travel/info_square/faq_customer/index.jsp"/>"><span>고객의 소리</span></a></li>
							<li><a href="<c:url value="/travel/info_square/updateinfo/index.jsp"/>" class='on' ><span>정보수정제안</span></a></li>
						</c:if>
							<c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/faq_customer')}">
							<li><a href="<c:url value="/travel/info_square/faq/index.jsp"/>"><span>FAQ</span></a></li>
							<li><a href="<c:url value="/travel/info_square/faq_customer/index.jsp"/>" class='on'><span>고객의 소리</span></a></li>
							<li><a href="<c:url value="/travel/info_square/updateinfo/index.jsp"/>"><span>정보수정제안</span></a></li>
						</c:if>	
						</ul>
					</div>					
					</c:otherwise>
					</c:choose>
                  <div id="faq_wrap" class="faq_2">
				      <section id="faq_con">
				        <h2>FAQ 목록</h2>
				        <ol>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">나만의 여행지 만들기 사용 매뉴얼이 있나요?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>공지사항 나만의 여행지만들기 사용자 매뉴얼에서 확인 하실 수 있습니다.</p>
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">바다여행 일정만들기는 어떤 사이트인가요?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>바다여행을 중심으로 나만의 여행 일정을 만들어 pc, 태블릿, 모바일에서 언제든지 내가 만든 일정 및 경로를 확인할 수 있는 사이트입니다. 여행지의 경우 전수조사는 물론이고 해양수산부, 한국관광공사, 지역관광공사 등 검증된 광광정보 연계를 통해 제공된 여행지를 기반으로 나만의 여행지를 만들고 또 공유할 수 있습니다. </p>
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">이달의 인기추천여행일정 선정 기준은 무엇인가요?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>나만의 여행지 만들기에서 일정 등록 후 마이페이지> 나의여행일정에서 올리기 버튼을 클릭하면 내가 올리는 추천일정에 표출됩니다. 표출된 일정 중 조회수와 추천수가 많은 추천일정이 이달의 인기추천여행일정으로 선정됩니다.</p>
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">나만의 여행지 만들기에서 경유지 위치가 표출되지 않는 여행지가 있습니다.</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>폭포 또는 OO과 같이 주소가 명확하지 않을 경우에는 지도에서 경로 표시가 되지 않을 수 있습니다.</p>
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">내가 가본 여행지 중 추천 하고 싶은 여행지가 있는데 방법이 있을까요?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>추천하고 싶은 여행지가 있거나, 내가 찾는 여행지가 없는데 일정에 추가하고 싶은 경우, 사용자가 직접 여행지를 등록할 수 있습니다. 로그인 후 바다여행 목록페이지에 들어가서 등록 버튼을 클릭 후 필수 입력값을 입력 하고 저장하시면 됩니다.(비속어나 욕설 사용 등 관리자의 사전 검열 후 등록됩니다.) </p>
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">나만의 여행지만들기는 당일만 가능한가요?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>7일까지 여행일정 만들기가 가능합니다. 나만의 여행지만들기에서 day 버튼을 클릭하여 여행일정을 추가 하실 수 있습니다.</p>
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">나만의 여행지를 만들려니 여행지를 어디서부터 잡아야 할지 막막합니다. 코스로 추천받을 수 있을까요?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>추천여행일정에 작가가 추천한 지역별 여행코스와 사용자들이 직접 짜서 올린 여행코스 추천이 있습니다. 일정 및 경로를 한눈에 확인 할 수 있습니다.</p>
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">메모장의 용도는 무엇인가요?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>나만의 여행지 만들기에서 여행지 등록 시 체크할 사항들을 기록하면 마이페이지 > 나의여행일정에서 확인 가능합니다.</p>
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">여행지 정보(전화번호, 주소 등)가 잘못 입력되어 있습니다. </a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>사이트 하단 정보수정제안(정보광장 > Q&A > 정보수정제안)에 글 남겨 주시면 확인 후 수정하도록 하겠습니다.</p>
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">명성점수는 어떻게 받게 되나요?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>명성 > 명성이란? 에 자세한 내용 확인 가능합니다.</p>
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">친구에게 일정을 공유하고 싶습니다. 어떻게 하면 될까요?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>추천일정에 나의 일정 만들기를 등록하고 SNS를 통하여 공유가 가능합니다.</p>
				            </div>
				          </li>
				        </ol>
				      </section>
				    </div><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000138_E.jsp' %>