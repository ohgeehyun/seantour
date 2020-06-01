<%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/_header.jsp' %><%@ page import="jnit.cms.handler.*" %><%@ page import="jnit.com.util.CclUtil" %><%@ page import="jnit.cms.menu.JnitcmsmenuController" %><c:set var="handingType" value="TPL_000126" /><% /* cset_s */ %><% String servletPath = request.getServletPath(); %><% String[] Jnit_ServletPath = servletPath.split("/"); String Jnit_sitePath = Jnit_ServletPath[1]; %><c:set var="Jnit_sitePath" value="<%= Jnit_sitePath %>" scope="request"/><%@ page import="egovframework.com.utl.fcc.service.StringUtil"%><% String localYn = ""; if(StringUtil.isExistString(request.getRequestURL().toString(),"local")) localYn="Y"; %><c:set var="localYn" value="<%= localYn %>" scope="request" /><% /* cset_e */ %><%
/**
 *@version 3.2.0.1
 **/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%= JnitcmsmenuController.getMenuJSON("pageNavTitle") %></title>
<%@ include file="/travel/common/config/handing/metaHanding.jsp" %>

  
<%@ include file="/travel/common/config/handing/cssHanding.jsp" %>

  
 <!-- script -->
<%@ include file="/travel/common/config/handing/jsHanding.jsp" %>
</head>

<body>
	<div id="wrap" style="position:static;">
		<div id="accessibility"><a href="#content">본문 바로가기</a></div>
		<!-- header -->
		<div id="header" class="trans">
				<h1 class="logo trans"><a href="/travel/index.jsp" class="trans">바다여행 |바다여행 일정만들기</a></h1>
				<ul class="util_top trans">
				<li><a href="/travel/login/index.jsp">로그인</a></li>
                                	<li><a href="/travel/mypage/mypage_honor/index.jsp">마이페이지</a></li>
				</ul>
                <!-- GNB -->
                <div class="gnb_wrap">
                    <ul id="gnb">
                        <li><a href="/travel/seantour/index.jsp">바다여행</a>
                            <div>
                                <ul>
	                        		<li><a href="/travel/seantour/index.jsp">부산광역시</a></li>
	                        		<li><a href="#none">대구광역시</a></li>
	                        		<li><a href="#none">인천광역시</a></li>
	                        		<li><a href="#none">대전광역시</a></li>
	                        		<li><a href="#none">울산광역시</a></li>
	                        		<li><a href="#none">경기도</a></li>
	                        		<li><a href="#none">충청북도</a></li>
	                        		<li><a href="#none">충정남도</a></li>
	                        		<li><a href="#none">전라북도</a></li>
	                        		<li><a href="#none">전라남도</a></li>
	                        		<li><a href="#none">경상북도</a></li>
	                        		<li><a href="#none">경상남도</a></li>
	                        		<li><a href="#none">제주특별자치도</a></li>
	                        	</ul>
                            </div>
                        </li>
                        <li><a href="/travel/my_travel/index.jsp">나만의 여행지 만들기</a></li>
                        <li><a href="/travel/recommendation/index.jsp">추천일정</a></li>
                        <li><a href="/travel/honor/index.jsp">명성</a></li>
                        <li><a href="/travel/info_square/index.jsp">정보광장</a>
                            <div>
                               <ul>
	                                <li><a href="/travel/info_square/notice/index.jsp">공지사항</a></li>
	                                <li><a href="/travel/info_square/faq/index.jsp">Q&A</a></li>
	                                <li><a href="/travel/info_square/statistics/index.jsp">통계</a></li>
	                                <li><a href="">개인정보처리방침</a></li>
	                                <li><a href="">이용약관</a></li>
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
                                <ul class="util_top trans">
									<li><a href="/travel/login/index.jsp">로그인</a></li>
                                	<li><a href="/travel/mypage/mypage_honor/index.jsp">마이페이지</a></li>
								</ul>
                                <button type="button" class="btn_close">전체메뉴 닫기</button>
                            </div>
                            <div class="nav">
                                <ul id="gnb_mobile">
                                    <li><a href="#">바다여행</a>
                                    	<ul>
                                    		<li><a href="#none">부산광역시</a></li>
                                    		<li><a href="#none">대구광역시</a></li>
                                    		<li><a href="#none">인천광역시</a></li>
                                    		<li><a href="#none">대전광역시</a></li>
                                    		<li><a href="#none">울산광역시</a></li>
                                    		<li><a href="#none">경기도</a></li>
                                    		<li><a href="#none">충청북도</a></li>
                                    		<li><a href="#none">충정남도</a></li>
                                    		<li><a href="#none">전라북도</a></li>
                                    		<li><a href="#none">전라남도</a></li>
                                    		<li><a href="#none">경상북도</a></li>
                                    		<li><a href="#none">경상남도</a></li>
                                    		<li><a href="#none">제주특별자치도</a></li>
                                    	</ul>
                                    </li>
                                    <li><a href="/travel/my_travel/index.jsp">나만의 여행일정 만들기</a></li>
                                    <li><a href="/travel/recommendation/index.jsp">추천여행일정</a></li>
                                    <li><a href="/travel/honor/index.jsp">명성</a></li>
                                    <li><a href="/travel/info_square/index.jsp">정보광장</a>
                                       <ul>
                                            <li><a href="/travel/info_square/notice/index.jsp">공지사항</a></li>
			                                <li><a href="/travel/info_square/faq/index.jsp">Q&A</a></li>
			                                <li><a href="/travel/info_square/statistics">통계</a></li>
			                                <li><a href="">개인정보처리방침</a></li>
			                                <li><a href="">이용약관</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="wvBg"></div>
                    </div>
                </div>
                <!-- //모바일 전체메뉴 -->
		      </div>
		<!-- // header -->
      
