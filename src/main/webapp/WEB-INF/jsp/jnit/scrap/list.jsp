<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/_common/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="subject" content="스크랩 팝업창" />
<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/>"></script>

<script type="text/javascript">
/* try {
	if(jQuery.ajax) {}
}catch(e) {
	jqueryScriptCode = "<script type=\"text/javascript\" src='<c:url value='\/resources\/jquery.min.js'/>'><\/script>";
	document.write(jqueryScriptCode);
} */

/**

var addScrap = function() {
	var thisTitle = $.trim($('#pageLinkNav').text());
	if(thisTitle == "") {
		thisTitle = $.trim($('title').text());
	}
	$.ajax({
		url:"/scrap/add.do",
		data:{
			url:location.href,
			title:thisTitle
		},
		success:function(data){
			var msg = $.trim(data);

			if(msg == "OK") {
				if(confirm("스크랩 되었습니다.\n\n스크랩 목록을 보시겠습니까?") == true) {
					var popMsg = window.open('/scrap/list.do', 'CLIENT_WINDOW', 'resizable=yes scrollbars=no width=460 height=500');
				}
			}else if(msg == "E01") {
				alert("로그인 후 이용하세요.");
			}else if(msg == "E04") {
				if(confirm("스크랩은 20개까지만 가능합니다.\n\n스크랩 목록을 보시겠습니까?") == true) {
					var popMsg = window.open('/scrap/list.do', 'CLIENT_WINDOW', 'resizable=yes scrollbars=no width=460 height=500');
				}
			}else {
				alert("스크랩을 할 수 없습니다.");
			}
		}
	});
}

**/

var delScrap = function(scrapId) {
	if(confirm("정말 삭제하시겠습니까?") == true) {
		$.ajax({
			url:"<c:url value="/scrap/del.do"/>",
			data:{
				scrapId:scrapId
			},
			success:function(data) {
				if($.trim(data) == "OK") {
					$('tr[rel='+scrapId+']').remove();
				}
			}
		});
	}
}
</script>
<title>스크랩 팝업창</title>

<link rel="stylesheet" type="text/css" href="/kr/common/css/scrap.css" media="all" />
</head>
<body>
	<c:if test="${!empty msg}">
		로그인 후 이용하세요.
	</c:if>
	<c:if test="${empty msg}">
	<table cellpadding="0" cellspacing="0" border="0" class="scrapTable AlignCenter" width="440" summary="스크랩한 메뉴가 보입니다.">
    	<caption>스크랩 목록</caption>
        <thead>
        	<tr>
            	<th>순번</th>
            	<th>메뉴명</th>
            	<th>삭제</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="result" items="${resultList}" varStatus="status">
        	<tr rel="${result.scrapId}">
            	<td>${fn:length(resultList)-status.index}</td>
            	<td class="AlignLeft"><a href="${result.url}" target="_blank" title="새 창으로 열립니다.">${result.title}</a></td>
            	<td><a href="javascript:delScrap('${result.scrapId}');"><img src="/kr/images/common/scrap_del.gif" alt="스크랩 삭제" /></a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    </c:if>
</body>
</html>