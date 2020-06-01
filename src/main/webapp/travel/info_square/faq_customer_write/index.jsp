<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000127_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><!-- contaniner -->
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
	            	<div class="tabmenu">
						<a href="#none">Q&A<span class="unfd sprh_com"></span></a>
						<ul>
							<li><a href="../faq/index.jsp"><span>FAQ</span></a></li>
							<li><a href="../faq_customer/index.jsp" class="on"><span>고객의 소리</span></a></li>
							<li><a href="../updateinfo/index.jsp"><span>정보수정제안</span></a></li>
						</ul>
					</div>
	            	<div class="reviews_write">
						<dl>
							<dt>제목</dt>
							<dd><input type="text" id="brd_subject" name="brd_subject" title="Title" class="w100" value="" /></dd>
						</dl>
						<dl class="group">
							<dt>이름</dt>
							<dd><input type="text" id="brd_reg_name" name="brd_reg_name" title="Name" class="w100" value="" /></dd>
							<dt>비밀번호</dt>
							<dd><input type="password" id="brd_reg_pw" name="brd_reg_pw" title="Password" class="w100" value="" /></dd>
						</dl>
						<dl>
							<dt>내용</dt>
							<dd>
								<textarea id="brd_content" name="brd_content" rows="20" style="width: 100%; min-width: 10px;"></textarea>
							</dd>
						</dl>
						<dl>
							<dt>개인정보처리방침</dt>
							<dd>
								<div class="privacy shorten">
								</div>
							</dd>
						</dl>
					</div>
						<div class="btnArea">
							<a href="../faq_customer/index.jsp"  class="button">목록</a>
							<a href="#none"  class="button border">저장</a>
						</div>
					</div>
				</div><!-- cont_body -->
        	</div><!-- // cont_wrap -->
        </div>
        <!--// container --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000127_E.jsp' %>
