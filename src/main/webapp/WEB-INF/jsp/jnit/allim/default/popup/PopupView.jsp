<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
<!--
function setCookie(name, value, expiredays) {
	 var todayDate = new Date();
	 todayDate.setDate(todayDate.getDate() + expiredays);
	 document.cookie = name + "=" + escape(value) + ";"+ "path=/"+";"+ "expires=" + todayDate.toUTCString() + ";";
}
function getCookie(name) {
	 var nameOfCookie = name + "=";
	 var x = 0;
	 while(x<= document.cookie.length) {
	  var y = (x+nameOfCookie.length);
	  if(document.cookie.substring(x,y)==nameOfCookie) {
	   if((endOfCookie = document.cookie.indexOf(";", y)) == -1) {
	    endOfCookie = document.cookie.length;
	   }
	   return unescape(document.cookie.substring(y, endOfCookie));
	  }
	  x = document.cookie.indexOf(" ", x)+1;
	  if(x==0) {
	   break;
	  }
	 }
	 return "";
}

function closeWin(itemId,itemclass) {
	  var itemcheck = 'box'+itemId;
	  if($('#'+itemcheck).is(':checked')){
	   setCookie(itemId, "done", 1);
	   $('.'+itemclass).css("display","none"); // display none;
	   $('.blackbackground').css("display","none");
	  }else{
		  $('.'+itemclass).css("display","none");
		  $('.blackbackground').css("display","none");
	  }
	  self.close();
}
function layer_ok(itemId,itemclass){
	var itemcheck = 'box'+itemId ;
	if($('#'+itemcheck).is(':checked')) {
		   setCookie(itemId, "done", 1);
		$('.'+itemclass).css("display","none");
		$('.blackbackground').css("display","none");
	}
	$('.'+itemclass).css("display","none");
	$('.blackbackground').css("display","none");

}
function PopupOption(itemMode,itemclass,itemUrl,itemId){
	var popList = itemMode;
	var popVal = new Array();
	popVal = popList.split(",");
	for(var i=0; i<popList.length;i++){
		if(popVal[i] == 1){
			if(getCookie(itemId) == "done") {
				$('.blackbackground').css("display","none");
			}
		}
		if(popVal[i] == 2){
			if(getCookie(itemId) != "done") {
				$('.blackbackground').css("display","block");
			}
		}
		if(popVal[i] == 3){
			$('.'+itemclass).css("background","#fff url(${pageContext.request.contextPath}"+itemUrl+")");
		}
		if(popVal[i] == 4){
			if(getCookie(itemId) == "done") {
				self.close();
			}
		}
	}

}
// -->
</script>
<div class='blackbackground'style='display:none;background:#000; width:100%; height:100%;filter:alpha(opacity=50);-moz-opacity:0.5;-khtml-opacity: 0.5;opacity: 0.5; z-index:500;position:fixed;top:0;left:0;' ></div>
		<c:forEach var="popup" items="${resultList}" varStatus="status">
				<div class="${popup.itemExt01}" style="display:none; width:${popup.itemWidth}px; position:absolute; height:${popup.itemHeight}px; top:${popup.itemTop}px; left:${popup.itemRight}px;  z-index:${popup.itemExt02};">
					${popup.itemHtmlcode}
				</div>
		</c:forEach>
		<c:forEach var="popup" items="${resultList}" varStatus="status">
			<script type="text/javascript">
			<!--
				if(getCookie('${popup.itemId}') != "done") {
					//display none;
					var filter = "win16|win32|win64|mac";
					if( navigator.platform  ){
						if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
							window.open("/jnitallim/JnitOpenPopup.do?groupId=${popup.itemId}", "_blank", "width=${popup.itemWidth}, height=${popup.itemHeight}, toolbar=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no" );
						}else{
							PopupOption("${popup.itemMode}","${popup.itemExt01}","${empty popup.itemUrlPath ? popup.itemUrl : popup.itemUrlPath }","${popup.itemId}");
							$('.${popup.itemExt01}').css("display","block");
						}
					}else{
						PopupOption("${popup.itemMode}","${popup.itemExt01}","${empty popup.itemUrlPath ? popup.itemUrl : popup.itemUrlPath }","${popup.itemId}");
						$('.${popup.itemExt01}').css("display","block");
					}
				}
			//-->
			</script>
		</c:forEach>