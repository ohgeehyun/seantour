<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>
<div class="toy_list <c:out value="${(not empty wrapClass) ? wrapClass : ''}" />" data-uiq="${wrapClass}">
	<p class="toy_btn1"><a href="#" class="latestPrev"><img src="/toy/img/main/btn_prev.png" alt="앞으로" /></a></p>
	<c:forEach var="result" items="${resultList}" varStatus="status">
	<ul <c:out value="${status.index >= 4 ? 'style=\"display:none\"' : ''}" escapeXml="false" />>
		<li class="img"><a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"><img width="141" height="99" src="<c:out value="${result.fileUrl}" />&thumb=true" alt="<c:out value="${result.title}" />"></a></li>
		<li class="txt"><a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"><c:out value="${fn:substring(fn:trim(result.title),0,15)}"/></a></li>
	</ul>
	</c:forEach>
	<p class="toy_btn2"><a href="#"" class="latestNext"><img src="/toy/img/main/btn_next.png" alt="뒤로" /></a></p>
</div>
<%--
//메인 장난감 슬라이더 by.Dael @ JNIT
$(document).on("click",'.latestPrev',function(e){
	e.preventDefault();
	var uiq = $(this).parent().parent().data('uiq');
	$('div .toy_list[data-uiq="'+uiq+'"]').children('ul:not(:hidden):last').css('display','none').insertBefore($('div .toy_list[data-uiq="'+uiq+'"]').children('ul:first'));
	$('div .toy_list[data-uiq="'+uiq+'"]').children('ul:not(:hidden):first').prev().show();
});
$(document).on("click",'.latestNext',function(e){
	e.preventDefault();
	var uiq = $(this).parent().parent().data('uiq');
	$('div .toy_list[data-uiq="'+uiq+'"]').children('ul:not(:hidden):first').css('display','none').insertAfter($('div .toy_list[data-uiq="'+uiq+'"]').children('ul:last'));
	$('div .toy_list[data-uiq="'+uiq+'"]').children('ul:not(:hidden):last').next().show();
});
//end of //메인 장난감 슬라이더
--%>