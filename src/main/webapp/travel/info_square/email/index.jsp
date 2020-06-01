<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000138_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><div class="inr">
	              <div class="email_notice">
						<img src="${pageContext.request.contextPath}/seantour_map/images/travel/content/email_img.png" alt="이메일무단수집거부" />
						<p class="emp">이메일 무단수집거부!</p>
						<p class="txt">
							본 웹사이트에 게시된 이메일주소가 전자우편 수집 프로그램이나 그 밖의 기술적 장치를 이용하여 무단으로 수집되는 것을 거부하며, 이를 위반 시 정보통신망법에 의해 형사처벌됨을 유념하시기 바랍니다.
							이메일을 기술적 장치를 사용하여 무단으로 수집, 판매, 유통하거나 이를 이용한 자는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제50조의 2 규정에 의하여 1년이하의 징역 또는 1천만원 이하의 벌금형에 처해집니다.
						</p>
					</div>
					<div class="email_row">
						<p class="tit">정보통신망 이용촉진 및 정보보호 등에 관한 법률 제50조의2 (전자우편주소의 무단 수집행위 등 금지)</p>
						<ul class="lst">
							<li>1. 누구든지 인터넷 홈페이지 운영자 또는 관리자의 사전 동의 없이 인터넷 홈페이지에서 자동으로 전자우편주소를 수집하는 프로그램이나 그 밖의 기술적 장치를 이용하여 전자우편주소를 수집하여서는 아니 된다.</li>
							<li>2. 누구든지 제1항을 위반하여 수집된 전자우편주소를 판매ㆍ유통하여서는 아니 된다.</li>
							<li>3. 누구든지 제1항과 제2항에 따라 수집ㆍ판매 및 유통이 금지된 전자우편주소임을 알면서 이를 정보 전송에 이용하여서는 아니된다.</li>
						</ul>
					</div>
				
				</div>
            </div><!-- cont_body --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000138_E.jsp' %>
