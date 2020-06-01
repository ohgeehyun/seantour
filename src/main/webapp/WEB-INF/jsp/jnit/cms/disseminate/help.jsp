<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>소스코드</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap-responsive.css"/>" />

<script src="<c:url value="/resources/js/jquery.min.js"/> "></script>
<script src="<c:url value="/resources/js/bootstrap.js"/>" ></script>
<script type="text/javascript">
<!--
function Jnit_copy(num){
	var htmlSrc = $("#copyText"+num).val();
	var IE=(document.all)?true:false;
	if (IE) {
		window.clipboardData.setData("Text", htmlSrc);
	}else {
		temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", htmlSrc);
	}
}

$(document).ready(function(){
	var html4 = ""
				+ "<"+"c:import url='/total/search.do'>\r"
				+ "<"+"c:param name='uri' value='$"+'{fn:replace(pageContext.request.requestURI,pageContext.request.contextPath,"") }'+"'>\r"
				+ "</"+"c:param>\r"
				+ "<"+"c:param name='contentPath' value='현재 콘텐츠 경로/'></"+"c:param>\r"
				+ "</"+"c:import>";
	/* $("#copyText4").html(html4); */
	var html6 = ""
			+ "<"+"c:import url='/menu/getSiteMap.do'>\r"
			+ "<"+"c:param name='siteNm' value='$"+'{fn:replace(pageContext.request.requestURI,pageContext.request.contextPath,"") }'+"'>\r"
			+ "</"+"c:param>\r"
			+ "<"+"c:param name='titles' value='대메뉴(1뎁스) 메뉴명을 콤마(,)로 구분하여 입력 해주시기 바랍니다.'></"+"c:param>\r"
			+ "</"+"c:import>";
	$("#copyText6").html(html6);
	var html7 = ""
			+ "<"+"c:import url=\"/disseminate/workspace.do\">\r"
			+ "<"+"c:param name=\"contentPath\" value=\"콘텐츠 경로명/\" />\r"
			+ "<"+"c:param name=\"sitePath\" value=\"$"+"{Jnit_sitePath }\" />\r"
			+ "</"+"c:import>";	
	$("#copyText7").html(html7);
});
//-->
</script>
</head>
<body>
	<table class="table table-bordered">
		<tr>
			<th style="width: 10%">게시판 코드</th>
			<td>
<textarea id="copyText1" rows="15" style="width: 96%">
&lt;!--
	최근 게시판 code 
	board_id : 게시판 아이디, count : 가져올 게시물수, type : 출력될 유형
	base_path : 콘텐츠 경로 
--&gt;
&lt;jsp:include page=&quot;/&#36;&#123;ctxRoot&#125;/board/latest.do&quot;&gt; 
	&lt;jsp:param name=&quot;board_id&quot; value=&quot;${boardId }&quot;/&gt;
	&lt;jsp:param name=&quot;count&quot; value=&quot;7&quot;/&gt;
	&lt;jsp:param name=&quot;type&quot; value=&quot;main&quot;/&gt;
	&lt;jsp:param name=&quot;base_path&quot; value=&quot;콘텐츠경로를 입력해주시기 바랍니다.&quot;/&gt;
&lt;/jsp:include&gt;

&lt;!-- 
	게시판 code
	board_id : 게시판 아이디
	useSkeleton : true로 입력하면 게시판의 html 뼈대 없이 가져옵니다.
	customSkin : 게시판 설정을 무시하고 스킨 설정
--&gt;
&lt;jsp:include page=&quot;/&#36;&#123;ctxRoot&#125;/board/board.do&quot;&gt;
	&lt;jsp:param name=&quot;boardId&quot; value=&quot;${boardId }&quot;/&gt;
	&lt;jsp:param name=&quot;fixedCategory&quot; value=&quot;&quot;/&gt;
	&lt;jsp:param name=&quot;useSkeleton&quot; value=&quot;true&quot;/&gt;
	&lt;jsp:param name=&quot;customSkin&quot; value=&quot;&quot;/&gt;
	&lt;jsp:param name=&quot;isMobile&quot; value=&quot;false&quot;/&gt;
&lt;/jsp:include&gt;
</textarea>
			</td>
		</tr>
		<tr>
			<th style="width: 10%">통합검색 코드</th>
			<td>
<textarea id="copyText4" rows="10" style="width: 96%">
	&lt;c:import url='/total/search.do'&gt
		&lt;c:param name='uri' value='&#36;{fn:replace(pageContext.request.requestURI,pageContext.request.contextPath,"") }'&gt
		&lt;/c:param&gt
		&lt;c:param name='contentPath' value='현재 콘텐츠 경로/'&gt&lt;/c:param&gt
	&lt;/c:import&gt

	&lt;!-- header search_box --&gt
	&lt;script type="text/javascript"&gt
		&lt;!--
                   
		function main_search(){				
			var search1 = $("#search_box").val();								
			var searchUrl = encodeURI("통합검색이 적용된 페이지 경로?searchKeyword="+search1);
			document.getElementById("searchform").action=searchUrl;
			document.getElementById("searchform").submit();
		}
		$(document).ready(function(){
			$("#search_key").click(function(e){
				e.preventDefault();					
				var search = $("#search_box").val();					
				var searchUrl = encodeURI("통합검색이 적용된 페이지 경로?searchKeyword="+search);
				document.getElementById("searchform").action=searchUrl;
				document.getElementById("searchform").submit();
			});				
		});	
		//--&gt
	&lt;/script&gt
	&lt;form name="searchform" id="searchform" action="" method="post"&gt
		&lt;div class="search_wrap m_hidden search_form"&gt
			&lt;input type="text" name="search_box" title="검색박스" id="search_box" class="search_input01" placeholder="검색어를 입력하세요" onkeydown="if(event.keyCode == 13) main_search();" value="" /&gt
			&lt;a href="#" id="search_key" class="search_btn"&gt&lt;i class="icon-search"&gt&lt;/i&gt&lt;span class="comment"&gt검색&lt;/span&gt&lt;/a&gt
		&lt;/div&gt
    &lt;/form&gt
	&lt;!-- //search_box --&gt
</textarea>
			</td>
		</tr>
		<tr>
			<th style="width: 10%">탑메뉴 코드</th>
			<td>
<textarea id="copyText5" rows="6" style="width: 96%">
	&lt;c:import url="/menu/getTopMenu.do"&gt;
		&lt;c:param name="target" value="[탑메뉴 target명]" /&gt;
		&lt;c:param name="menuNm" value="[메뉴명]" /&gt;
		&lt;c:param name="depth" value="[뎁스]" /&gt;
		&lt;c:param name="order" value="[class순서 ex:0]" /&gt;
		&lt;c:param name="menuId" value="[메뉴아이디,메뉴명이 겹칠경우 사용]" /&gt;
	&lt;/c:import&gt;
</textarea>
			</td>
		</tr>
		<tr>
			<th style="width: 10%">사이트맵<br />코드</th>
			<td>
				<textarea id="copyText6" rows="7" style="width: 96%"></textarea>
			</td>
		</tr>
		
	</table>
</body>
</html>