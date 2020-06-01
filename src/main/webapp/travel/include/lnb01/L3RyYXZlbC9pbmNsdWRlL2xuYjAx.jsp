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
         </ul>
     </div>
</div><!-- // section_lnb --><% /*<!-- /[-CONTENT-] -->*/ %>