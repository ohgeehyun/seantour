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
                <h2 class="title">해수욕장 예약하기</h2>
            </div><!--// cont_head -->
            <div class="cont_body">
	            <div class="inr">
	            	<div class="reserv_wrap">
	            		<dl class="form_group">
	            			<dt>해수욕장</dt>
	            			<dd><div class="reserv_view"><span class="loc">부산</span>/<span class="pool">해운대해수욕장</span></div>
	            				<p class="note">선택하신 해수욕장이름과 지역을 꼭 확인해주세요</p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>파라솔번호</dt>
	            			<dd><div class="reserv_view">10번</div></dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>날짜</dt>
	            			<dd><input type="text" id="" name="" /></dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>시간</dt>
	            			<dd><div class="reserv_view">10:00~12:00</div></dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>인원</dt>
	            			<dd>
	            				<select>
	            					<option value="">1</option>
	            					<option value="">2</option>
	            					<option value="">3</option>
	            					<option value="">4</option>
	            					<option value="">5</option>
	            					<option value="">6</option>
	            					<option value="">7</option>
	            					<option value="">8</option>
	            					<option value="">9</option>
	            					<option value="">10명이상</option>
	            				</select>
							</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>이름</dt>
	            			<dd><input type="text" id="" name="" /></dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>전화번호</dt>
	            			<dd class="tel">
	            				<select>
	            					<option value="">010</option>
	            					<option value="">017</option>
	            					<option value="">019</option>
	            				</select>
	            				<em>-</em><input type="text" id="" name="" />
	            				<em>-</em><input type="text" id="" name="" />
	            				<p class="note">예약 확인을 위해 정확한 정보 입력 부탁드립니다.</p>
	            			</dd>
	            		</dl>
	            	</div>
	            	<div class="reservBtn_box tac">
	            		<a href="#none" class="button light_gray">이전화면</a>
	            		<a href="#none" class="button red">예약하기</a>
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
