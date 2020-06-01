<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><div class="section_visual sub01 trans400">
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
                <a href="#none">바다여행<span class="unfd sprh_com">같은 레벨 메뉴 보기</span></a>
                <div>
                     <ul>
						<li><a href="/travel/destination/list.do">바다여행</a>
						<li><a href="/travel/route/list.do">추천일정</a></li>
						<li><a href="/travel/honor/index.jsp">명성</a></li>
						<li><a href="/travel/info_square/index.jsp">정보광장</a></li>
                	</ul> 
                </div>  
            </li>
            <li id="secondmenu">
                <a href="">부산광역시<span class="unfd sprh_com">같은 레벨 메뉴 보기</span></a>
                <div class="snb_wrap">
                   <ul class="snb">
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
         </ul>
     </div>
</div><!-- // section_lnb --><% /*<!-- /[-CONTENT-] -->*/ %>
