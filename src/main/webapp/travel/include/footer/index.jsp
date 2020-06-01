<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><!-- footer -->
		<div id="footer">
			<div class="inr">
				<div class="foot_wrap">
					<ul class="foot_util">
						<li><a href="/travel/info_square/NULL/index.jsp">개인정보처리방침</a></li>
						<li><a href="/travel/info_square//NULL/index.jsp">이메일무단수집거부</a></li>
						<li><a href="/travel/info_square//NULL/index.jsp">이용약관</a></li>
						<li><a href="/travel/info_square/faq_customer/index.jsp">고객의소리</a></li>
						<!--<li><a href="#none">사이트맵</a></li>-->
					</ul>
					<ul class="foot_info">
						<li>08588 서울특별시 금천구 가산디지털2로 53 한라시그마밸리 12층</li>
						<li><strong class="color_light_red">080-500-8579</strong>(파도친구) 평일 09:00 ~ 18:00, 점심시간 12:00 ~ 13:00<br /> seantourfipa@gmail.com</li>
						<li>(사) 전국어촌체험마을연합회 | 대표 권영환</li>
					</ul>
				</div>
				<div class="footer_go">
					<a href="/travel/info_square/updateinfo/index.jsp" class="modipy">
						수정정정요청
					</a>
					<a  href="/travel/info_square/notice/index.jsp" class="notice">
						공지사항
					</a>
				</div>
				<div class="skip_top">
					<a href="#wrap"><div class="skip_top_btn"><span>TOP</span></div></a>
				</div>
			</div>
		</div>
		<!-- // Footer --><% /*<!-- /[-CONTENT-] -->*/ %>
