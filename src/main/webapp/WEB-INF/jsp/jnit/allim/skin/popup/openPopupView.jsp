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
<script src="<c:url value="/resources/js/jquery.min.js"/> "></script>
<script type="text/javascript">
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
	 self.close();
}
function PopupOption(itemMode,itemclass,itemUrl,itemId){
	var popList = itemMode;
	var popVal = new Array();
	popVal = popList.split(",");
	for(var i=0; i<popList.length;i++){
		if(popVal[i] == 2){
			if(getCookie(itemId) != "done") {
				$('.blackbackground').css("display","block");
			}
		}
		if(popVal[i] == 3){
			$('.'+itemclass).css("background","#fff url("+itemUrl+")");
		}
		if(popVal[i] == 4){
			if(getCookie(itemId) == "done") {
				self.close();
			}
		}
	}
	
}
</script>
<div class='blackbackground'style='display:none;background:#000; width:100%; height:100%;filter:alpha(opacity=50);-moz-opacity:0.5;-khtml-opacity: 0.5;opacity: 0.5; z-index:500;position:absolute;top:0;left:0;' ></div>
				<div class="${popup.itemExt01}" Style="display:none; width:${popup.itemWidth}px; position:absolute; height:${popup.itemHeight}px; top:${popup.itemTop}px; left:${popup.itemRight}px;  z-index:${popup.itemExt02};">
					${popup.itemHtmlcode}		
				</div>
			<script type="text/javascript">
			    PopupOption("${popup.itemMode}","${popup.itemExt01}","${popup.itemUrl}","${popup.itemId}");
				if(getCookie('${popup.itemId}') != "done") {
					//display none;
					
					$('.${popup.itemExt01}').css("display","block");
				}
			</script>