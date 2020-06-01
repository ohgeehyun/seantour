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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="author" type="text/plain" href="<c:url value="/humans.txt" />" />
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap-responsive.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/font-awesome.min.css"/>">
<!--[if IE 7]>
 	<link rel="stylesheet" href="<c:url value="/resources/css/font-awesome-ie7.min.css"/>" />
 	<![endif]-->
<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/jnit.css"/>" />
<%-- <link rel="stylesheet" href="<c:url value="/resources/css/jnit.main.css"/>" /> --%>
<link rel="stylesheet" href="<c:url value="/resources/css/jnit.dashboard.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/select.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/calendar.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/color_picker.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/date_picker.css"/>" />
<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/ie7_main.css"/>" />
<![endif]-->
<script src="<c:url value="/resources/js/jquery.min.js"/> "></script>
<script type="text/javascript">
<!--

function Jnit_importCode_copy(num){
	var src = $("#importCode"+num).val();
	var IE = (document.all) ? true : false;
	if(IE){
		window.clipboardData.setData("Text",src);
	}else{
		temp = prompt("Ctrl+C를 눌러 클립보드로 복사하세요",src);
	}
}

function Jnit_importCode_close(){
	self.close();
}
//-->
</script>
</head>
<body>
<table class="table table-bordered">
<tr>
	<th>페이지 이동</th>
	<td><textarea id="importCode1" rows="1" style="width: 98%">onclick="gotoPage(페이지 번호);"</textarea></td>
	<td>
		예시 :<br />
		&lt; li onclick="gotoPage(1);"&gt;Pdf to Pageflip Converter ad&lt;/li&gt; 
	</td>
	<td><a href="javascript:Jnit_importCode_copy('1');" class="btn btn-small">복사</a></td>
</tr>
<tr>
	<th>선택한 페이지 보기</th>
	<td>
	
<textarea id="importCode2" rows="3" style="width: 98%">
onclick="selectFeature(id="feature번호");
&lt;div id="feature1" class="features"&gt;&lt;/div&gt;
</textarea>

	</td>
	<td>예시 : <br />
		&lt;div class="page"&gt; &lt;!-- 1페이지 --&gt;<br />
			&lt;ul&gt;<br />
				&lt;li id="option1" class="selected" onclick="selectFeature(1);"&gt;&lt;/li&gt; &lt;!-- feature1 실행  --&gt;<br />
				&lt;li id="option2" onclick="selectFeature(2);"&gt;&lt;/li&gt; &lt;!-- feature2 실행  --&gt;<br />
			&lt;/ul&gt;<br />
		&lt;/div&gt;<br />
		&lt;div class="page"&gt; &lt;!-- 2페이지 --&gt;<br />
			&lt;div id="feature1" class="features"&gt;<br />
				
			&lt;/div&gt;<br />
			&lt;div id="feature2" class="features off"&gt;<br />
				
			&lt;/div&gt;<br />
		&lt;/div&gt;
	</td>
	<td><a href="javascript:Jnit_importCode_copy('2');" class="btn btn-small">복사</a></td>
</tr>
<tr>
	<th>비디오</th>
	<td>
	
<textarea id="importCode3" rows="3" style="width: 98%">
onclick="videoPlay('#video 태그 id값');"
<video id="아이디값" width="450" height="600" preload="auto" loop="true" poster="uploadFile/이미지경로">
	<source src="uploadFile/비디오파일" type="video/mp4">
	<source src="uploadFile/비디오파일.webm" type="video/webm">
</video>
</textarea>
	
	</td>
	<td>
		예시 : <br />
		&lt;div id="playpause" onclick="videoPlay('#thevideo');"&gt;<br />
			&lt;img src="pageflip/videobutton.svg" width="103" height="50" alt="Play/pause video"&gt;<br />
		&lt;/div&gt;<br />
		&lt;video id="thevideo" width="450" height="600" preload="auto" loop="true" poster="uploadFile/caterpillar2.jpg"&gt;<br />
			&lt;source src="uploadFile/caterpillar.mp4" type="video/mp4"&gt;<br />
			&lt;source src="uploadFile/caterpillar.webm" type="video/webm"&gt;<br />
		&lt;/video&gt;
	</td>
	<td><a href="javascript:Jnit_importCode_copy('3');" class="btn btn-small">복사</a></td>
</tr>
<tr>
	<th>비디오</th>
	<td>
	
<textarea id="importCode4" rows="3" style="width: 98%">
<embed src="uploadFile/파일경로">
</textarea>

	</td>
	<td>
		예시 : <br />
		&lt;embed src="uploadFile/파일경로"&gt;
	</td>
	<td><a href="javascript:Jnit_importCode_copy('4');" class="btn btn-small">복사</a></td>
</tr>
</table>
<a href="javascript:Jnit_importCode_close();">닫기</a> 
</body>
</html>