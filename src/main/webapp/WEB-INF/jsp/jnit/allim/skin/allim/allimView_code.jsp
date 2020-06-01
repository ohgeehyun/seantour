<!--
/**
 *@version 3.2.0.1
 **/
-->
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="${grpValue.groupClassName}">
	<ul class="allimiControl">
	  <li><a href="#none"   onclick="popupZoneStop2('p');" onkeypress="popupZoneStop2('p');"  ><img src="<c:url value="/common/img/Jnit_btn_stop.gif"/>" alt="일시정지" /></a></li>
	  <li><a href="#none"   onclick="popupZoneStop2('s');" onkeypress="popupZoneStop2('s');" ><img src="<c:url value="/common/img/Jnit_btn_play.gif"/>" alt="재생" /></a></li>
	</ul>
	<ul class="allimiNum">
		<c:forEach var="allim" items="${resultList}" varStatus="status">
		<li style="float: left; display: inline;">
			<a href="#none;" id="popnum${status.count}" class="allimiNumber_off" onmousedown="popupZoneMove(${status.count})" onfocus="this.onmousedown();">${status.count}</a>
			<p id="popBanner_${status.count}">
			<c:if test="${allim.itemTarget == '_blank'}">
				<a href="${allim.itemLink}" title="새창" target="${allim.itemTarget}">
			</c:if>
			<c:if test="${allim.itemTarget != '_blank'}">
				<a href="${allim.itemLink}" title="" target="${allim.itemTarget}">
			</c:if>
			<img src="<c:url value="${allim.itemUrlPath}"/>" alt="<c:out value="${allim.itemAlt}"/>" width="<c:out value="${allim.groupWidth}"/>" height="<c:out value="${allim.groupHeight}"/>" id="popup_zone${status.count }" /></a></p>
		</li>
		</c:forEach>
	</ul>
</div>


<script type="text/javascript">
<!--
		var popup_size = $(".allimiNum > li").size();
		var popupItemCount = popup_size;
		var popupZoneVal = 0;
		var popupZoneTmpVal = 0;
		var autocontrolvar = "";
		var changeTime = ${grpValue.groupChangeTime};

		function popupZone(){
			for(i=1;i<=popupItemCount;i++){
				if(popupZoneTmpVal!=1) {
					popupZoneVal = popupZoneTmpVal;
					popupZoneTmpVal = 1;
				}
				if(popupZoneVal == popupItemCount+1)	popupZoneVal = 1;
				if(popupZoneVal==0) popupZoneVal = 1;

				id1 = "popnum"+i
				id2 = "popBanner_"+i

				if(popupZoneVal==i){
					document.getElementById(id1).setAttribute('class',"allmiNumber_on");
					document.getElementById(id2).style.display	= "";
				}else{
					document.getElementById(id1).setAttribute('class',"allmiNumber_off");
					document.getElementById(id2).style.display	= "none";
				}
			}

			popupZoneVal = popupZoneVal + 1;
			var time = changeTime; //알리미 개당 지속시간(초)
			autocontrolvar=setTimeout("popupZone()",time*1000);
		}
	function popupZoneStop(chk){
		if(chk){
			clearTimeout(autocontrolvar);
		}else{
			clearTimeout(autocontrolvar);
			popupZone();
		}
	}

	function popupZoneStop2(chk){

		if(chk == "p"){
			clearTimeout(autocontrolvar);
		}else{

			clearTimeout(autocontrolvar);

			popupZone();
		}
	}
	function popupZoneMove(num){
		for(i=1;i<=popupItemCount;i++){
			id1 = "popnum"+i;
			id2 = "popBanner_"+i;
			if(num==i){
				document.getElementById(id1).setAttribute('class',"allmiNumber_on");
				document.getElementById(id2).style.display	= "";
			}else{
				document.getElementById(id1).setAttribute('class',"allmiNumber_off");
				document.getElementById(id2).style.display	= "none";
			}
		}
		popupZoneVal = num;
		popupZoneTmpVal = num;
	}


	function popupZoneShow(type){
		if(type){
			document.getElementById("spot_1").style.display = "none";
			document.getElementById("spot_2").style.display = "";
		}else{
			document.getElementById("spot_1").style.display = "";
			document.getElementById("spot_2").style.display = "none";
		}
	}

	$(document).ready(function(){
		popupZoneStop2();
	});
// -->
</script>