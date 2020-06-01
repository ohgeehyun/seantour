<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>
<div id="photoGallery" <c:out value="${(not empty wrapClass) ? wrapClass : ''}" />" data-uiq="${wrapClass}">
	<h3><img src="/nagan/images/main/photo_title.gif" alt="PHOTO 사진첩" /></h3>
	<p class="btnMore"><a href="/nagan/intro/0003/"><img src="/nagan/images/main/photo_more.gif" alt="사진첩 더보기" /></a></p>
	<ul class="photo_btn">
		<li><a href="#" class="latestPrev"><img src="/nagan/images/main/photo_btn1.gif" alt="이전" /></a></li>
		<li class="next"><a href="#" class="latestNext"><img src="/nagan/images/main/photo_btn2.gif" alt="다음" /></a></li>
	</ul>
	<ul class="photo_content">
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<li <c:out value="${status.index >= 7 ? 'style=\"display:none\"' : ''}" escapeXml="false" />>
		<a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"><img src="<c:out value="${result.fileUrl}" />&thumb=true" alt="<c:out value="${result.title}" />" /></a>
		</li>
	</c:forEach>
	</ul>
</div>
<%--
//메인 사진첩 슬라이더 by.Dael @ JNIT
$(document).on("click",'.latestPrev',function(e){
	e.preventDefault();
	var uiq = $(this).parent().parent().data('uiq');
	$('ul.photo_content').children('li:not(:hidden):last').css('display','none').insertBefore($('ul.photo_content').children('li:first'));
	$('ul.photo_content').children('li:not(:hidden):first').prev().show();
});
$(document).on("click",'.latestNext',function(e){
	e.preventDefault();
	var uiq = $(this).parent().parent().data('uiq');
	$('ul.photo_content').children('li:not(:hidden):first').css('display','none').insertAfter($('ul.photo_content').children('li:last'));
	$('ul.photo_content').children('li:not(:hidden):last').next().show();
});
//end of 메인 사진첩 슬라이더
--%>