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
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!--
 <c:set var="registerFlag" value="${empty jnitallimItemVO.itemId ? '등록' : '수정'}"/>			
-->

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>


<title> <c:out value="${registerFlag}"/> </title>
<script type="text/javaScript">

function Jnit_allim_question(num){
	var baseId = "JnitAllimQuestion"+num;
	var baseObject = $("#"+baseId);
	var displayState = baseObject.css("display");
	
	if(displayState == "none"){
		baseObject.show();
	}else{
		baseObject.hide();
	}
}

function fillzero(obj, len) { 
	obj= '000000'+obj; 
	return obj.substring(obj.length-len); 
}

$(document).ready(function(){
	var grpId = "${grpId}";
	if(grpId != ''){
		$("#groupId").val("${grpId}");
	}
	$('#itemMode1').click(function(){
		var cookiCode = ""
						+ "<div class='popup_closebtn'>\r"
							+ "<input type='checkbox' name='box"+'${ItemNextId}'+"' id='box"+'${ItemNextId}'+"' checked='checked' />\r"
							+ "<span class='popup_txt'><label for='box"+'${ItemNextId}'+"' >오늘 하루 이 창을 띄우지 않음</label></span>\r"
							+ "<a href='#' onclick=\"javascript:layer_ok('"+"${ItemNextId}"+"','"+$('#itemExt01').val()+"')\""+">닫기</a>\r"
						+ "</div>";
	
		var aCode = "<a href='#' onclick=\"javascript:layer_ok('"+"${ItemNextId}"+"','"+$('#itemExt01').val()+"')\""+">확인</a>"
		+ "<a href='#' onclick=\"javascript:closeWin('"+"${ItemNextId}"+"','"+$('#itemExt01').val()+"')\""+">닫기</a>";

		$('#cookiCode').text(cookiCode);
		$('#aCode').text(aCode);
	});
	
	<%--
	$('#itemMode2').click(function(){
		var blackCode = "<div class='blackbackground'style='display:none;background:#000; width:100%; height:100%;filter:alpha(opacity=50);-moz-opacity:0.5;-khtml-opacity: 0.5;opacity: 0.5; z-index:500;position:absolute;top:0;left:0;' ></div>";
		$('#blackbgCode').text(blackCode);
	});
	--%>
	
	$('#itemStartdate').datetimepicker();
	$('#itemEnddate').datetimepicker();
	
	if($('#groupCategory').val() == "icon"){
		$('.iconCetegory').show();
	}
	
	//2014-01-12 by.수정 내용 알리미기능이면서 팝업기능 디자인소스코드 넣을때	
	var ItemHtmlcodeYn = "${ItemHtmlcodeYn}";
	if(ItemHtmlcodeYn == 'Y' ){
		$("#htmlCodeYn").val("1");
	}else{
		$("#htmlCodeYn").val("0");
	}
	var type = "${type}";
	if(type == 'allim' || type=="popup" ){
		if(type == 'allim'){			
			//start setting
			var grpId = $("#groupId option:selected").val();
			if(grpId == ' '){
				$('.htmlCode').css('display','none');
				$('.htmlCodeYn').css('display','none');
				$("#htmlCodeYn").val('0');
				$("#htmlCodeYn").select2();
				$('.itemAlt').css('display','');
				$('.itemLink').css('display','');
				$('.itemTarget').css('display','');
			}else{
				$.ajax({
					type : "POST",
					url : "<c:url value='/cms/allim/popup/ajax.do'/>",
					data :"groupId="+grpId
				}).done(function(data){
					var json = $.parseJSON(data);
					
					if(json.category == 'allimPopupVisual' || json.category == 'allimAnimateVisual'){
						$('.htmlCodeYn').css('display','');											
						if($("#htmlCodeYn option:selected").val() == '0'){
							$('.htmlCode').css('display','none');
							$('.itemAlt').css('display','');
							$('.itemLink').css('display','');
							$('.itemTarget').css('display','');
							if(json.category == 'allimAnimateVisual') $(".animateVisual").css("display","");
							$('.file').css('display','');
						}else{
							$('.htmlCode').css('display','');
							$('.itemAlt').css('display','none');
							$('.itemLink').css('display','none');
							$('.itemTarget').css('display','none');
							if(json.category == 'allimAnimateVisual') $(".animateVisual").css("display","none");
							$('.file').css('display','none');
						}
					}else{
						$('.htmlCode').css('display','none');
						$('.htmlCodeYn').css('display','none');
						$('.itemAlt').css('display','');
						$('.itemLink').css('display','');
						$('.itemTarget').css('display',' ');
						$('.file').css('display','');
					}
				});	
			}			
			//start setting end
			
			//change groupId 
			$("#groupId").change(function(){
				var groupId = $("#groupId option:selected").val();
				if(groupId == ' '){					
					$('.htmlCode').css('display','none');
					$('.htmlCodeYn').css('display','none');
					$("#htmlCodeYn").val('0');
					$("#htmlCodeYn").select2();
					
					$('.itemAlt').css('display','');
					$('.itemLink').css('display','');
					$('.itemTarget').css('display','');
				}else{					
					$.ajax({
						type : "POST",
						url : "<c:url value='/cms/allim/popup/ajax.do'/>",
						data :"groupId="+groupId
					}).done(function(data){
						var json = $.parseJSON(data);
						if(json.category == 'allimPopupVisual' || json.category == 'allimAnimateVisual' ){
							$('.htmlCodeYn').css('display','');
						}else{
							$('.htmlCodeYn').css('display','none');
						}
					});					
				}
			});
			//End of change groupId
			
			//디자인 사용하기 
			$("#htmlCodeYn").change(function(){
				
				var itemHtmlcode = $("#itemHtmlcode").val();				
				var groupId = $("#groupId option:selected").val();
				
				$.ajax({
					type : "POST",
					url : "<c:url value='/cms/allim/popup/ajax.do'/>",
					data :"groupId="+groupId
				}).done(function(data){
					var json = $.parseJSON(data);
					
					//set allimPopupVisual
					if(json.category == 'allimPopupVisual'){
						if($("#htmlCodeYn option:selected").val() == '0'){
							$('.htmlCode').css('display','none');
							$('.itemAlt').css('display','');
							$('.itemLink').css('display','');
							$('.itemTarget').css('display','');
						}else{
						
							var html =	+ "<script type='text/javascript'>"
									+ "<!--"
									+ "//파일관리에서 이미지를 등록하여 사용해주세요."									
									+ "//-->"
									+ "<"+"/script>"									
									+ "<a href='이미지경로' title='새창' target='_blank'>\n"
									+ "    <img src='이미지 경로' alt='알트값' width='' height='' />\n"
									+ "</a>";
							
							$("#itemHtmlcode").text(html);
							/*
							if(itemHtmlcode == '' || itemHtmlcode == null){
								$("#itemHtmlcode").text(html);
							}else{
								if(itemHtmlcode.indexOf(html) == -1){
									var html2 =  html;
									$("#itemHtmlcode").text(html2);
								}
							}
							*/
							$('.htmlCode').css('display','');
							$('.itemAlt').css('display','none');
							$('.itemLink').css('display','none');
							$('.itemTarget').css('display','none');								
						}
					//End of allimPopupVisual
						
					//set allimAnimateVisual	
					}else if(json.category == 'allimAnimateVisual'){
						
						if($("#htmlCodeYn option:selected").val() == '0'){							
							$('.htmlCode').css('display','none');
							$('.itemAlt').css('display','');
							$('.itemLink').css('display','');
							$('.itemTarget').css('display','');
							$('.animateVisual').css('display','');
							$('.file').css('display','');
						}else{						 
							var html = "\n"								
									// code
									+ "<li id='${ItemNextId}_li'>\n"
									//script 
									+ "<script type='text/javascript'>\n"
									+ "<!--\n\n"
									+ "/* 이부분은 Sample 디자인 부분입니다 수정 가능합니다\n"
									+ " * 현재 선택하신 그룹 div 크기는 "+json.height+"px 입니다.\n"
									+ " *\n"
									+ " * 그룹 Height 값을 변경하시면 ITEM_HTMLCODE값의 top 값도 변경해주시기 바랍니다.\n"
									+ " * 작성시에 Sample소스를 그대로 사용하셨다면\n"
									+ " * 디자인 사용하기를 사용안함으로 설정하신 후 다시 디자인 사용으로 설정하시면 초기값으로 재설정 됩니다.\n"
									+ " *\n"
									+ " * <script>구문을 새로 생성하여 넣지 마십시요 (ul > li = length 계산 오류가 납니다.)\n"
									+ " * 현재 밑의 스크립트 안에서 함수를 생성하거나 사용하여 주시기 바랍니다.\n"
									+ " *\n"
									+ " * 서버에 바로 적용이되므로 신중히 작성하여 주시기 바랍니다.\n"
									+ " */\n\n"									
									+ "function start_${ItemNextId}(){ \n"
									+ "    var allimZindex = $"+"('#allimZindex').val();\n"	
									+ "    if(allimZindex == '' || allimZindex == null) allimZindex = 1;\n\n"
									
									+ "    /* z-index 으로 구분하여 li, li > div 를 순차적으로  이미지를 보여줍니다.\n"
									+ "     * z-index 값이 높을수록 이미지가 위에 뜹니다.\n"
									+ "     */\n\n"
									
									+ "    $"+"('#${ItemNextId}_li').css({'display': 'list-item', 'z-index': allimZindex, 'top':'0px'});\n"
									+ "    $"+"('#${ItemNextId}_li > #${ItemNextId}_div' ).css({'z-index': allimZindex, 'top':'0px'});\n\n"
									
									+ "    /* ${ItemNextId}_div_1, ${ItemNextId}_div_2, ${ItemNextId}_div_3 의 초기 값을 지정해줍니다 .\n"
									+ "     * 화면의 보여주는 div가 overflow:hidden 이므로 top, bottom, left, right 값으로 임의 위치에서 시작되도록 설정값을 지정하셔야됩니다.\n"
									+ "     * 아래 -> 위로 방향일때 초기 위치 설정값은 top : 그룹div크기px \n"
									+ "     * 위 -> 아래로 방향일때 초기 위치 설정값은 bottom : 0px\n"
									+ "     * 왼쪽 -> 오른쪽 방향일때 초기 위치 설정값은 left : -임의 설정값px\n"
									+ "     * 오른쪽 -> 왼쪽 방향일때 초기 위치 설정값은 right : -임의 설정값px\n"
									+ "     */\n\n"
									
									+ "    $"+"('#${ItemNextId}_li > #${ItemNextId}_div > #${ItemNextId}_div_1').css({'z-index': allimZindex, 'top':'"+json.height+"px', 'left':''});\n"
									+ "    $"+"('#${ItemNextId}_li > #${ItemNextId}_div > #${ItemNextId}_div_2').css({'z-index': allimZindex, 'top':'300px', 'left':'100px'});\n"
									+ "    $"+"('#${ItemNextId}_li > #${ItemNextId}_div > #${ItemNextId}_div_3').css({'z-index': allimZindex, 'top':'350px', 'left':'100px'});\n\n"
									
									+ "    /* ${ItemNextId}_div_1, ${ItemNextId}_div_2, ${ItemNextId}_div_3 의 애니매이션 값을 지정해줍니다 .\n"
									+ "     * 위에서 지정한 임의 초기값 위치에서 애니매이션 시작이 된다고 보시면 됩니다.\n"									
									+ "     * 아래 -> 위로 방향일때 초기 위치에서 top : -= 거리px \n"
									+ "     * 위 -> 아래로 방향일때 초기 위치에서 bottom : -= 거리px\n"
									+ "     * 왼쪽 -> 오른쪽 방향일때 초기 위치에서 left : += 거리px\n"
									+ "     * 오른쪽 -> 왼쪽 방향일때 초기 위치위서 right : += 거리px\n"									
									+ "     * 거리 계산법 : 초기값 위치px - 보여줄려는 위치px = 거리px\n"
									+ "     * 애니매이션 딜레이 설정은 fn_setTimeOut()의 딜레이시간보다 많으면 안됩니다. 주의해주시기 바랍니다.\n\n"
									
									+ "     * jquery animate 이용시 무한클릭을 할때 함수 호출시에 애니매이션 진행중인 상태에서 함수 호출이되어\n"
									+ "     * 그위치에서 애니매이션이 더올라가는 현상이 있습니다.\n"
									+ "     * 이방법을 막기위하여 jquery의 .stop()을 써주셔야됩니다.\n"
									+ "     * ex"+")"+" $"+"(selecter)"+".stop(true)"+".animate"+"("+"{"+"거리"+"}"+",딜레이,function"+"(){ $"+"(this)"+".stop"+"(); "+"}"+")"+";"+" \n"
									+ "     */\n\n"
									
									+ "    $"+"('#${ItemNextId}_li > #${ItemNextId}_div > #${ItemNextId}_div_1').stop(true).delay(500).animate({'top':'-="+json.height+"px'},800,'easeInOutCirc',\n    function(){ $"+"('#${ItemNextId}_div_1').stop(); } ); // item 1( 큰배경이미지 ) 제어\n"	
									+ "    $"+"('#${ItemNextId}_li > #${ItemNextId}_div > #${ItemNextId}_div_2').stop(true).delay(900).animate({'top':'-=210px'},800,'easeInOutCirc',\n    function(){ $"+"('#${ItemNextId}_div_2').stop(); } ); // item 2 ( 작은 요소 ) 제어\n"	
									+ "    $"+"('#${ItemNextId}_li > #${ItemNextId}_div > #${ItemNextId}_div_3').stop(true).delay(1000).animate({'top':'-=210px'},800,'easeInOutCirc',\n    function(){ $"+"('#${ItemNextId}_div_3').stop(); } ); // item 3 ( 작은 요소 ) 제어\n\n"
									
									+ "    /* loop 설정입니다 fn_setTimeOut()의 딜레이 시간만 조절하시면 됩니다.\n"
									+ "     * 현재 초기값은 8초이며 1000당 1초 계산입니다.\n"
									+ "     * div 방식으로 animate 로 구성이 되어있으며 position : absolute로 반드시 지정해주셔야됩니다.\n"
									+ "     */\n\n"
									
									+ "    var length = $"+"('#allimAnimateVisual_ul').find('li').length-1;\n"
									+ "    var index  = $"+"('#${ItemNextId}_li').index();\n"
									+ "    $"+"('#allimActiveId').val('${ItemNextId}')\n"
									+ "    $"+"('#allimZindex').val((parseInt(allimZindex)+1));\n\n"
									+ "    if(index == length){\n"
									+ "        var firstId = $"+"('#allimAnimateVisual_ul > li:first').attr('id');\n"									
									+ "        var firstId_replace = firstId.replace('_li','');\n"
									+ "        var str_firstId_replace = 'start_'"+"+firstId_replace+"+"'()';\n"
									+ "        fn_setTimeOut(str_firstId_replace,8000); //8초후\n"									 
									+ "    }else {\n"
									+ "        var nextId = $('#allimAnimateVisual_ul').find('li').eq((parseInt(index)+1)).attr('id');\n"	
									+ "        var nextId_replace = nextId.replace('_li','');\n"
									+ "        var str_nextId_replace = 'start_'"+"+nextId_replace+"+"'()';\n"
									+ "        fn_setTimeOut(str_nextId_replace,8000); //8초후\n"									
									+ "    }\n"
									+ "    /* img 태그의 사이트명을 적지 마세요 */\n" 
									+ "}\n"
									+ "//-->\n"	
									+ "</"+"script>\n\n"
									//End of script									
									+ "    <div id='${ItemNextId}_div'>\n"
									+ "        <div id='${ItemNextId}_div_1' style='position: absolute; top: "+json.height+"px; left: 0px'>\n"					
									+ "            <img alt='test' src='${pageContext.request.contextPath}/resources/img/allim/visual01_bg.jpg' >\n"
									+ "        </div>\n"
									+ "        <div id='${ItemNextId}_div_2' style='position: absolute; top: 300px; left: 100px'>\n"
									+ "            <img alt='test' src='${pageContext.request.contextPath}/resources/img/allim/visual01_txt01.png' >\n"
									+ "        </div>\n"
									+ "        <div id='${ItemNextId}_div_3' style='position: absolute; top: 350px; left: 100px'>\n"
									+ "            <img alt='test' src='${pageContext.request.contextPath}/resources/img/allim/visual01_txt02.png' >\n"
									+ "        </div>\n"
									+ "    </div>\n"
									+ "</li>\n";															
									//End of code
							$("#itemHtmlcode").text(html);
							/*		
							if(itemHtmlcode == ''){
								
							}else{
								if(itemHtmlcode.indexOf(html) == -1){
									var html2 =  html;
									$("#itemHtmlcode").text(html2);
								}
							}
							*/
							$('.htmlCode').css('display','');
							$('.itemAlt').css('display','none');
							$('.itemLink').css('display','none');
							$('.itemTarget').css('display','none');
							$('.animateVisual').css('display','none');
							$('.file').css('display','none');
						}
					//End allimAnimateVisual					
					//기본 알리미 구조
					}else{
						$('.itemAlt').css('display','');
						$('.itemLink').css('display','');
						$('.itemTarget').css('display',' ');						
						$('.htmlCode').css('display','none');
						$('.file').css('display','');
						
					}
					//End of 기본 알리미 구조
				});
			});
			//End 디자인 사용하기			
		}
	}else{
		$('.htmlCode').attr('display','none');
	}
	//2014-01-12 by.수정 END
});

/* 글 삭제 function */
function fn_egov_delete() {
	if(confirm("삭제 하시겠습니까?")){
		var type = $('#itemType').val();
		var grpId = $('#grpId').val();
	   	document.getElementById("jnitallimItemVO").action = "<c:url value='/cms/allim/itemDeleteProc.do'/>?type="+type+"&grpId="+grpId;
	   	document.getElementById("jnitallimItemVO").submit();			
	}
	
}

/* 글 등록 function */
function fn_egov_save() {
  		
		var groupId = $.trim($('#groupId').val());
		var itemTarget = $.trim($('#itemTarget').val());
		var itemAlt = $('#itemAlt').val();
		var itemLink = $('#itemLink').val();		
		var itemActive = $('#itemActive').val();
		var itemStartdate = $('#itemStartdate').val();
		var itemEnddate = $('#itemEnddate').val();
		
		var classNm = $('#itemExt01').val();
		var option = $("input[name=itemMode]").is(":checked");
		var width = $('#itemWidth').val();
		var height = $('#itemHeight').val();
		var top = $('#itemTop').val();
		var left = $('#itemRight').val();
		var zIndex = $('#itemExt02').val();
		var groupCategory =  $('#groupCategory').val();
		var itemIconTitle = $('#itemIconTitle').val();
		var itemIconComent = $('#itemIconComent').val();
		var itemHtmlcode = $("#itemHtmlcode").val();
		var htmlCodeYn = $("#htmlCodeYn option:selected").val();
		
		var itemSort = $("#itemSort").val();
		var itemExt05 = $("#itemExt05").val();
		var itemExt06 = $("#itemExt06").val();
		var itemExt07 = $("#itemExt07").val();				
		var itemExt11 = $("#itemExt11").val();
		//allimAnimateVisual 경우
		if(groupCategory == 'allimAnimateVisual'){
			if(htmlCodeYn == "0"){ //디자인모드 사용안할때
				if(itemExt05 == null || itemExt05 == ''){
					alert("기본위치 탑 값을 입력해주시기 바랍니다.");
					$("#itemExt05").focus();
					return false;
				}else if(itemExt06 == null || itemExt06 == ''){
					alert("기본위치 레프트 값을 입력해주시기 바랍니다.");
					$("#itemExt06").focus();
					return false;
				}else if(itemExt07 == null || itemExt07 == ''){
					alert("움직일 거리 값을 입력해주시기 바랍니다.");
					$("#itemExt07").focus();
					return false;
				}else if(itemExt11 == null || itemExt11 == ''){
					alert("딜레이 값을 입력해주시기 바랍니다.");
					$("#itemExt11").focus();
					return false;
				}
			}			
		}		
		if(htmlCodeYn == "1"){			
			if(itemStartdate == "" || itemStartdate == null){
				alert('시작일을 지정해주세요');
				document.getElementById("itemStartdate").focus();
				return false;
			}else if(itemEnddate == "" || itemEnddate == null){
				alert('종료일을 지정해주세요');
				document.getElementById("itemEnddate").focus();
				return false;
			}else if(itemHtmlcode == "" || itemHtmlcode == null){
				alert('디자인코드를 입력해주세요');
				document.getElementById("itemHtmlcode").focus();
				return false;
			}
			$('#itemAlt').val('');
			$('#itemLink').val('');
			$('#itemTarget').val(' ');
			$('#itemTarget').select2();
		}else if("${type}" != "popup"){									//알리미, 배너
			if(groupId == "" || groupId == null){
				alert('그룹을 선택해주세요');
				document.getElementById("groupId").focus();
				return false;
			}else if(itemAlt == "" || itemAlt == null){
				alert('이미지 ALT를 입력해주세요');
				document.getElementById("itemAlt").focus();
				return false;
			}else if(itemLink == "" || itemLink == null){
				alert('LINK를 입력해주세요');
				document.getElementById("itemLink").focus();
				return false;
			}else if(itemTarget == "" || itemTarget == null){
				alert('TARGET방식을 지정해주세요');
				document.getElementById("itemTarget").focus();
				return false;
			}else if(itemActive == "" || itemActive == null){
				alert('활성화 여부를 선택해주세요');
				document.getElementById("itemActive").focus();
				return false;
			}else if(groupCategory == 'icon'){
				if(itemIconTitle == "" || itemIconTitle == null){
					alert('이미지 제목을 입력해주세요');
					document.getElementById("itemIconTitle").focus();
					return false;	
				}else if(itemIconComent == "" || itemIconComent == null){
					alert('이미지 내용을 입력해주세요');
					document.getElementById("itemIconComent").focus();
					return false;
				}
			}
			if("${type}" != 'banner'){
				if(itemStartdate == "" || itemStartdate == null){
					alert('시작일을 지정해주세요');
					document.getElementById("itemStartdate").focus();
					return false;
				}else if(itemEnddate == "" || itemEnddate == null){
					alert('종료일을 지정해주세요');
					document.getElementById("itemEnddate").focus();
					return false;
				}
			}			
		}else{
			if(groupId == "" || groupId == null){
				alert('그룹을 선택해주세요');
				document.getElementById("groupId").focus();
				return false;
			}else if(classNm == "" || classNm == null){
				alert('클래스 명을 입력해주세요.');
				document.getElementById("itemExt01").focus();
				return false;
			}else if(option == "" || option == null){
				alert('옵션을 선택해주세요.');
				document.getElementById("itemMode1").focus();
				return false;
			}
			else if(width == "" || width == null){
				alert('WIDTH를 지정해주세요');
				document.getElementById("itemWidth").focus();
				return false;
			}else if(height == "" || height == null){
				alert('HEIGHT를 지정해주세요');
				document.getElementById("itemHeight").focus();
				return false;
			}else if(top == "" || top == null){
				alert('TOP를 입력해주세요');
				document.getElementById("itemTop").focus();
				return false;
			}else if(left == "" || left == null){
				alert('LEFT를 입력해주세요');
				document.getElementById("itemRight").focus();
				return false;
			}else if(zIndex == "" || zIndex == null){
				alert('Z-INDEX를 입력해주세요');
				document.getElementById("itemExt02").focus();
				return false;
			}else if(itemStartdate == "" || itemStartdate == null){
				alert('시작일을 지정해주세요');
				document.getElementById("itemStartdate").focus();
				return false;
			}else if(itemEnddate == "" || itemEnddate == null){
				alert('종료일을 지정해주세요');
				document.getElementById("itemEnddate").focus();
				return false;
			}
		}
		
		if(itemSort == '' || itemSort == null){
			alert("정렬순서를 입력해주시기 바랍니다.");
			$("#itemSort").focus();
			return false;
		}else if(itemSort.match("^[0-9]+$") == null){
			alert("숫자만 써주시기 바랍니다.");
			$("#itemSort").focus();
			return false;
		}
		return true;
}
function litm_save(){
	if(fn_egov_save()){

		var grpId = $('#grpId').val(); <%-- 등록후 기존 페이지 유지 --%>
		var type = $('#itemType').val();
		
		frm = document.getElementById("jnitallimItemVO");
			<c:if test="${registerFlag == '수정'}">
				frm.action = "<c:url value='/cms/allim/itemEditProc.do'/>?grpId="+grpId+"&type="+type;
			</c:if>
			<c:if test="${registerFlag == '등록'}">
				frm.action = "<c:url value='/cms/allim/itemAddProc.do'/>?grpId="+grpId+"&type="+type;
			</c:if>
			
    	frm.submit();			
	}
}
// -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
       	<div class="row-fluid">
           	<div class="span12">
               	<div class="widget-box">
                   	<div class="widget-title">
                   		<h3>아이템 <c:out value='${registerFlag}'/></h3>
                   		<a href="<c:url value='/cms/allim/groupList.do'/>?type=${type}&grpId=${grpId}" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						<a href="javascript:litm_save()" class="btn btn-small"><i class="icon-ok-sign"></i> <c:out value='${registerFlag}'/></a>
						<c:if test="${registerFlag == '수정'}">
							<a href="javascript:fn_egov_delete()" class="btn btn-small btn-del" style="float:right;" ><i class="icon-minus-sign"></i> 삭제</a>
						</c:if>
                    </div>
					<div class="widget-content nopadding">
						<form:form commandName="jnitallimItemVO"  enctype="multipart/form-data">
							<input type="hidden" id="grpId" name="grpId" value="${grpId}" />
							<form:hidden path="itemType" id="itemType" value="${type}"/>
							<input type="hidden" id="groupCategory" name="groupCategory" value="${groupCategory }"/>
							
							<table class="table table-bordered table-striped th_left" summary="아이템 테이블">
								<c:if test="${registerFlag == '수정'}">
									<input type="hidden" name="screenMode" value="up" />
								</c:if>
								<c:if test="${registerFlag == '등록'}">
									<input type="hidden" name="screenMode" value="" />
								</c:if>
								<%-- //타입 지정 --%>
								<c:if test="${type == 'banner'}">
									<tr>
										<th style="width:110px;">유형</th>
										<td><strong>배너</strong></td>
									</tr>
								</c:if>
								<c:if test="${type == 'allim'}">
									<tr>
										<th style="width:110px;">유형</th>
										<td><strong>알리미</strong></td>
									</tr>
								</c:if>
								<c:if test="${type == 'popup'}">
									<tr>
										<th style="width:110px;">유형</th>
										<td><strong>팝업</strong></td>
									</tr>
								</c:if>
								<%-- 타입지정// --%>
								<tr>
									<th>그룹 선택 </th>
									<td>
										<form:select path="groupId" id="groupId">
											<form:option value=" " label="-선택-"></form:option>
											<c:forEach var="group" items="${groupList}">
												<form:option value="${group.groupId}" label="${group.groupNm}"></form:option>
											</c:forEach>
										</form:select>
									</td>
								</tr>
								<tr>
									<th>정렬 순서</th>
									<td>
										<form:input path="itemSort" id="itemSort"/>
									</td>
								</tr>
								<c:if test="${groupCategory == 'icon' }" >								
								<tr class="iconCetegory" style="display: none;">
									<th>이미지 제목</th>
									<td><input type="text" id="itemIconTitle" name="itemIconTitle" value="${itemIconTitle }" /></td>
								</tr>
								<tr class="iconCetegory" style="display: none;">
									<th>이미지 내용</th>
									<td><input type="text" id="itemIconComent" name="itemIconComent" value="${itemIconComent }" /></td>
								</tr>
								</c:if>
								<c:if test="${type == 'popup'}">
								<tr>
									<th>팝업 클래스명</th>
										<td>
											<form:input path="itemExt01" cssClass="txt"/>
											&nbsp;<form:errors path="itemExt01" />
										</td>
								</tr>
								</c:if>
								<%-- <tr>
									<th>적용 사이트 명</th>
									<td>
										<form:input path="itemDescript" cssClass="txt"/>
										&nbsp;<form:errors path="itemDescript" />
									</td>
								</tr> --%>
								<c:if test="${type != 'popup'}">
								<tr class="itemAlt">
									<th>이미지 ALT명</th>
									<td>
										<form:textarea path="itemAlt" rows="13" style="width:97%;"/>
										<form:errors path="itemAlt" />
									</td>
								</tr>
								</c:if>
								<%--
								<tr>
									<th>ITEM_TYPE</th>
									<td>
										<form:input path="itemType" cssClass="txt"/>
										&nbsp;<form:errors path="itemType" />
									</td>
								</tr>
								--%>
								<c:if test="${type != 'popup'}">
								<tr class="itemLink">
									<th>이미지 LINK 주소</th>
									<td>
										<form:input path="itemLink" cssClass="txt" style="width:97%;"/>
										&nbsp;<form:errors path="itemLink" />
									</td>
								</tr>	
								<tr class="itemTarget">
									<th>TARGET 방식</th>
									<td>
										<form:select path="itemTarget">
											<form:option value=" " label="선택해주세요" />
											<form:option value="_blank" label="_blank" />
											<form:option value="_self" label="_self" />
											<form:option value="_parent" label="_parent" />
											<form:option value="_top" label="_top" />
										</form:select>
									</td>
								</tr>
								</c:if>
								<c:if test="${type == 'allim' }">
								<tr class="animateVisual" style="display: none;">
									<th><font color="red">기본위치 위,아래 선택</font></th>
									<td>										
										<form:select path="itemExt05" id="itemExt05">
											<form:option value="top" label="top" />
											<form:option value="bottom" label="bottom" />
										</form:select>					    
									</td>
								</tr>
								<tr class="animateVisual" style="display: none;">
									<th>기본위치 값&nbsp;<a href="javascript:Jnit_allim_question('1');"><i class="icon-question-sign"></i></a></th>
									<td>
										<form:input path="itemExt06" id="itemExt06" />
										
										<div id="JnitAllimQuestion9" style="display: none;"><br />										
											 * itemId_div_1, itemId_div_2, itemId_div_3 의 초기 값을 지정해줍니다 .<br />
										     * 화면의 보여주는 div가 overflow:hidden 이므로 top, bottom, left, right 값으로 임의 위치에서 시작되도록 설정값을 지정하셔야됩니다.<br />
										     * 아래 -> 위로 방향일때 초기 위치 설정값은 top : 그룹div크기px <br />
										     * 위 -> 아래로 방향일때 초기 위치 설정값은 bottom : 0px<br />
										     * 왼쪽 -> 오른쪽 방향일때 초기 위치 설정값은 left : -임의 설정값px<br />
										     * 오른쪽 -> 왼쪽 방향일때 초기 위치 설정값은 right : -임의 설정값px
										</div>									     
									</td>
								</tr>
								<tr class="animateVisual" style="display: none;">
									<th>기본위치 좌,우 선택</th>
									<td>
										<form:select path="itemExt07" id="itemExt07" >
											<form:option value="left" label="left" />
											<form:option value="right" label="right" />
										</form:select>
									</td>
								</tr>
								<tr class="animateVisual" style="display: none;">
									<th>기본위치 값&nbsp;<a href="javascript:Jnit_allim_question('2');"><i class="icon-question-sign"></i></a></th>
									<td>
										<form:input path="itemExt08" id="itemExt08" />
										
										<div id="JnitAllimQuestion2" style="display: none;"><br />
										 * itemId_div_1, itemId_div_2, itemId_div_3 의 초기 값을 지정해줍니다 .<br />
									     * 화면의 보여주는 div가 overflow:hidden 이므로 top, bottom, left, right 값으로 임의 위치에서 시작되도록 설정값을 지정하셔야됩니다.<br />
									     * 아래 -> 위로 방향일때 초기 위치 설정값은 top : 그룹div크기px <br />
									     * 위 -> 아래로 방향일때 초기 위치 설정값은 bottom : 0px<br />
									     * 왼쪽 -> 오른쪽 방향일때 초기 위치 설정값은 left : -임의 설정값px<br />
									     * 오른쪽 -> 왼쪽 방향일때 초기 위치 설정값은 right : -임의 설정값px
										</div>									     
									</td>
								</tr>
								<tr class="animateVisual" style="display: none;">
									<th>움직일 거리 위,아래 선택</th>
									<td>
										<form:select path="itemExt09" id="itemExt09" >
											<form:option value="top" label="top" />
											<form:option value="bottom" label="bottom" />
										</form:select>
									</td>
								</tr>
								<tr class="animateVisual" style="display: none;">
									<th>움직일 거리 값&nbsp;<a href="javascript:Jnit_allim_question('3');"><i class="icon-question-sign"></i></a></th>
									<td>
										<form:input path="itemExt10" id="itemExt10" /> ex) -=250 , +=250
										
										<div id="JnitAllimQuestion3" style="display: none;"><br />
										 * itemId_div_1, itemId_div_2, itemId_div_3 의 애니매이션 값을 지정해줍니다 .<br />
									     * 위에서 지정한 임의 초기값 위치에서 애니매이션 시작이 된다고 보시면 됩니다.<br />
									     * 아래 -> 위로 방향일때 초기 위치에서 top : -= 거리px <br />
									     * 위 -> 아래로 방향일때 초기 위치에서 bottom : -= 거리px<br />
									     * 왼쪽 -> 오른쪽 방향일때 초기 위치에서 left : += 거리px<br />
									     * 오른쪽 -> 왼쪽 방향일때 초기 위치위서 right : += 거리px<br />
									     * 거리 계산법 : 초기값 위치px - 보여줄려는 위치px = 거리px<br />
									     * 애니매이션 딜레이 설정은 fn_setTimeOut()의 딜레이시간보다 많으면 안됩니다. 주의해주시기 바랍니다.<br /><br />
									
									     * jquery animate 이용시 무한클릭을 할때 함수 호출시에 애니매이션 진행중인 상태에서 함수 호출이되어<br />
									     * 그위치에서 애니매이션이 더올라가는 현상이 있습니다.<br />
									     * 이방법을 막기위하여 jquery의 .stop()을 써주셔야됩니다.<br />
									     * ex) $(selecter).stop(true).animate({거리},딜레이,function(){ $(this).stop(); });
										</div>
									</td>
								</tr>
								<tr class="animateVisual" style="display: none;">
									<th>딜레이</th>
									<td>
										<%-- <form:input path="itemExt11" id="itemExt11" /> --%>
										<input type="text" name="itemExt11" id="itemExt11" value="${empty jnitallimItemVO.itemExt11 ? '8000' :  jnitallimItemVO.itemExt11}"> (1000 = 1초)
									</td>
								</tr>
								</c:if>
								<%--
								<tr>
									<th>이미지 원본 명</th>
									<td>
										<form:input path="itemOrigin" cssClass="txt"/>
										&nbsp;<form:errors path="itemOrigin" />
									</td>
								</tr>
								--%>
								<%-- <tr>
									<th>이미지 URL</th>
									<td>
										<form:input path="itemUrl" cssClass="txt"/>
										&nbsp;<form:errors path="itemUrl" />
									</td>
								</tr> --%>
								<c:if test="${type == 'popup'}">
								<tr>
									<th>팝업 옵션</th>
									<td>
										<form:checkbox path="itemMode" label="쿠키 설정" value="1"/>
										<form:checkbox path="itemMode" label="blackbg 설정" value="2"/>
										<form:checkbox path="itemMode" label="백그라운드 이미지 사용" value="3"/>
										<br />
										<span style="color:red">팝업 클래스명을 적어주셔야 정상적인 코드가 생성됩니다.</span>
									</td>
								</tr>
								<c:if test="${registerFlag == '수정'}">
								<script type="text/javascript">
								<%-- 수정시 체크박스 다중선택 --%>
										$(document).ready(function(){
											var popList = "${resultList.itemMode}";
											
											var popVal = new Array();
											popVal = popList.split(",");
											for(var i=0; i<popVal.length;i++){
												$('input[name=itemMode][value='+popVal[i]+']').get(0).checked=true;
											}
										});
								</script>
								</c:if>
								<tr>
									<th>팝업 Width</th>
									<td>
										<form:input path="itemWidth" cssClass="txt"/>
										&nbsp;<form:errors path="itemWidth" />
									</td>
								</tr>	
								<tr>
									<th>팝업 Height</th>
									<td>
										<form:input path="itemHeight" cssClass="txt"/>
										&nbsp;<form:errors path="itemHeight" />
									</td>
								</tr>
								<tr>
									<th>팝업 TOP</th>
									<td>
										<form:input path="itemTop" cssClass="txt"/>
										&nbsp;<form:errors path="itemTop" />
									</td>
								</tr>
								<tr>
									<th>팝업 LEFT</th>
									<td>
										<form:input path="itemRight" cssClass="txt"/>
										&nbsp;<form:errors path="itemRight" />
									</td>
								</tr>
								<tr>
									<th>Z-index</th>
										<td>
											<form:input path="itemExt02" cssClass="txt"/>
											&nbsp;<form:errors path="itemExt02" />
										</td>
								</tr>
								</c:if>
								<%--
								<tr>
									<th>정렬 순서</th>
									<td>
										<form:input path="itemSort" cssClass="txt"/>
										&nbsp;<form:errors path="itemSort" />
									</td>
								</tr>
								--%>		
								<%-- <tr>
									<th>설명</th>
									<td>
										<form:input path="itemMemo" cssClass="txt"/>
										&nbsp;<form:errors path="itemMemo" />
									</td>
								</tr> --%>
								<c:choose>
									<c:when test="${type == 'banner'}">
									
									</c:when>
									<c:otherwise>
										<tr>
											<th>시작일</th>
											<td>
												<%-- <form:input path="itemStartdate" value="" cssClass="txt" />
												&nbsp;<form:errors path="itemStartdate" /> --%>
												<c:if test="${registerFlag == '등록'}">
													<input type="text" id="itemStartdate" name="itemStartdate" value=""/>
												</c:if>
												<c:if test="${registerFlag == '수정'}">
													<input type="text" id="itemStartdate" name="itemStartdate" value="<fmt:formatDate value="${resultList.itemStartdate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
												</c:if>
											</td>
										</tr>	
										<tr>
											<th>종료일</th>
											<td>
												<%-- <form:input path="itemEnddate" cssClass="txt" />
												&nbsp;<form:errors path="itemEnddate" /> --%>
												<c:if test="${registerFlag == '등록'}">
													<input id="itemEnddate" name="itemEnddate" type="text" value=""/>
												</c:if>
												<c:if test="${registerFlag == '수정'}">
													<input id="itemEnddate" name="itemEnddate" type="text" value="<fmt:formatDate value="${resultList.itemEnddate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
												</c:if>
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
								<c:if test="${type == 'allim' }">
								<tr class="htmlCodeYn">
									<th>디자인 사용하기</th>
									<td>
										<select name="htmlCodeYn" id="htmlCodeYn">
											<option value="0">사용안함</option>
											<option value="1">사용</option>
										</select>
									</td>
								</tr>
								</c:if>
								<c:if test="${type == 'popup' || type == 'allim' }">									
								<tr class="htmlCode">
									<th>ITEM_HTMLCODE</th>
									<td>
										<form:textarea path="itemHtmlcode" id="itemHtmlcode" cssClass="text"  rows="13" style="width:97%;"/>&nbsp;
										
										<form:errors path="itemHtmlcode" /><br/>
										<c:if test="${registerFlag == '수정'}">
										<span style="color:red" id="codeHtml">아이템 ID : ${jnitallimItemVO.itemId} top : ${height }</span>
										</c:if>
									</td>
								</tr>
								</c:if>
								<c:if test="${type == 'popup'}">
								<tr>
									<th>확인, 닫기 코드</th>
									<td>
										<textarea id="aCode" rows="5" style="width:97%;"></textarea><br />
									<span style="color:red">javascript:closeWin은 쿠키저장 및 self.close()를 수행합니다</span>
									</td>
								</tr>
								<tr>
									<th>쿠키 코드</th>
									<td>
										<textarea id="cookiCode" rows="5" style="width:97%;"></textarea><br />
										<%--
										<span style="color:red">확인,닫기,쿠키 코드는 저장되지 않으며 ITEM_HTMLCODE에 적용해야합니다.<br />
										여러명이 동시에 팝업 생성을 하는 경우, 아이템 아이디 값(ITEM1234)이 다를 수 있으니 주의해야 합니다.</span>
										 --%>
									</td>
								</tr>
								<%--
								<tr>
									<th>blackbg 코드</th>
									<td>
										<textarea id="blackbgCode" rows="5" cols="100"></textarea>
									</td>
								</tr>
								 --%>
								</c:if>
								<tr>
									<th>활성화 여부</th>
									<td>
										<form:select path="itemActive">
											<form:option value="0" label="활성화" />
											<form:option value="1" label="비활성화" />
										</form:select>
									</td>
								</tr>
								<tr class="file">
									<th>이미지 파일</th>
									<td>
										<c:if test="${registerFlag == '등록' }">											
											<input type="file" name="upfile" />
											<c:if test="${groupCategory == 'icon' || groupCategory == 'visual'  }" >
												<font color="red">파일을 올리실때 화면이미지 사이즈에 맞게 올려주시기 바랍니다.</font>
											</c:if>
										</c:if>
										<c:if test="${registerFlag == '수정' }">
											<c:if test="${resultImgUrl == null }">
												<input type="file" name="upfile" />
											</c:if>
											<c:if test="${resultImgUrl != null }">						
												<img src="<c:url value="${resultImgUrl }" />" width="100" /><br/>
												<input type="file" id="upfile" name="upfile" />
											</c:if>
										</c:if>			
									</td>
								</tr>
							</table>
							<!-- 검색조건 유지 -->
							<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
							<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>