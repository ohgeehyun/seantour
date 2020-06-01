<%
/**
 *@version 3.2.0.1
 **/
%>
<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%><%@ page import="java.util.Date" %><%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script src="<c:url value="/resources/js/ap/js_bannerRolling.js"/> "></script>
<script type="text/javascript">
var Direction =${grpValue.groupDirection};
var ShowItems = ${grpValue.groupShowItems};
var TimerDelay = ${grpValue.groupTimerDelay};
var AnimationDelay = ${grpValue.groupAnimationDelay};
var Auto = ${grpValue.groupAuto};
if(Auto == 1){
	Auto = true;
}else{
	Auto = false;
};
var ImgWidth = ${grpValue.groupWidth};
var ImgHeight = ${grpValue.groupHeight};

var rolldata = {
		direction : Direction, //방향설정  1.왼쪽 2.오른쪽 3.위쪽 4.아래쪽
		showItems : ShowItems,	// 보여질 아이템수
		imgWidth : ImgWidth, // 이미지 가로크기
		imgHeight : ImgHeight, // 이미지 세로크기
		TimerDelay: TimerDelay, // 배너 딜레이 속도 1000 = 1초
		animationDelay : AnimationDelay, //애니매이션 속도  값이 클수록 느려짐
		auto : Auto // 자동롤링 : true 켜짐 , false 꺼짐 (일부 조작가능)
};

$(document).ready(function(){
	$("#banner_rolling").rolling(rolldata);

	$('#more').click(function(){
		var bannerMorePath = $("#bannerMorePath").val() == '' ? '${bannerMorePath}' : $("#bannerMorePath").val();
		if(bannerMorePath == ''){
			alert('콘텐츠경로가 없습니다.');
			$('#more').focus();
			return false;
		};
	});
});
function bannerLeft(){
	left();
};

function bannerRight(){
	right();
};

function bannerStop(){
	pause();
};

function bannerStart(){
	start();
};

</script>


<!-- banner -->
<p class="banner_title">배너모음</p>
<ul class="bannerControl">
	<li>
		<a href="#none" onclick="bannerLeft();return false;" onkeypress="bannerLeft()">
		<img src="<c:url value="/common/img/Jnit_btn_prev.gif"/>" alt='이전' />
	</a>
	</li>
	<li>
		<a href="#none" onclick="bannerStop();return false;" onkeypress="bannerStop()">
			<img src="<c:url value="/common/img/Jnit_btn_stop2.gif"/>" alt='정지' />
		</a>
	</li>
	<li>
		<a href="#none" onclick="bannerRight();return false;" onkeypress="bannerRight()">
			<img src="<c:url value="/common/img/Jnit_btn_next.gif"/>" alt='다음' />
		</a>
	</li>
	<li>
		<a href="<c:out value="${bannerMorePath }?jnitallim/bannerMore.do?groupId=${grpValue.groupId }" />"  id="more" >
			<img src="<c:url value="/common/img/Jnit_btn_more.gif"/>" alt="배너링크" />
		</a>
	</li>
</ul>
<div id="banner_list">
	<ul id="banner_rolling">
		<c:forEach var="result" items="${resultList}" varStatus="status" end="100">
			<li>
				<a href="<c:url value="${result.itemLink}"/>" title="새창" target="<c:out value="${result.itemTarget}"/>" >
					<img src="<c:url value="${result.itemUrlPath }" />" alt="<c:out value="${result.itemAlt}" />"  width="<c:out value="${result.groupWidth }" />"  height="<c:out value="${result.groupHeight }" />"  />
				</a>
			</li>
		</c:forEach>
	</ul>
</div>