<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
	<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
</head>
<body>
	<div id="wrap">
		<div id="accessibility"><a href="#content">본문 바로가기</a></div>
		<!-- header -->
			<%@ include file="/WEB-INF/jsp/travel/tpl/gnb.jsp" %>
		<!-- // header -->

		<!-- contaniner -->
		<div id="container" >

			<%@ include file="/WEB-INF/jsp/travel/tpl/navigation.jsp" %>

        	<div id="content" class="cont_wrap">

			<div class="cont_head">
                <h2 class="title">해수욕장 예약확인</h2>
            </div><!--// cont_head -->
            <div class="cont_body">
	           <div class="inr">
	            	<div class="reserv_wrap_confirm">
	            		<dl class="form_group">
	            			<dt>예약번호</dt>
	            			<dd>
	            				<p>p21146348643</p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>해수욕장</dt>
	            			<dd>
	            				<p>전남 / 외달도해수욕장</p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>날짜</dt>
	            			<dd>
	            				<p>2020년 7월 4일</p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>시간</dt>
	            			<dd>
	            				<p>오후</p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>인원</dt>
	            			<dd>
	            				<p>2명</p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>이름</dt>
	            			<dd>
	            				<p>홍길동</p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>전화번호</dt>
	            			<dd>
	            				<p>010-1246-2346</p>
	            			</dd>
	            		</dl>
	            	</div>	
	            	<div class="reservBtn_box tac">
	            		<a href="#none" class="button lightblue">출력하기</a>
	            	</div>
            	</div>
            </div><!-- cont_body -->

        	</div><!-- // cont_wrap -->
        </div>
        <!--// container -->

		<!-- footer -->
		<%@ include file="/WEB-INF/jsp/travel/tpl/foot.jsp" %>
		<!--//footer -->
	</div>
	
</body>


</html>
