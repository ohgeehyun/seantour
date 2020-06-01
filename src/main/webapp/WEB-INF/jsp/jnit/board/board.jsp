<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="header.jsp" %>

<c:if test="${not useSkeleton}">
<!DOCTYPE html>
<html>
<head>
	<meta charset=utf-8 />
	<title><c:out value="${boardinfoVO.boardTitle}"/><c:out value=" ${modeStr}"/></title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" /> 
		<link href="<c:url value="/board/_common/css/board.css" />" media="all" rel="stylesheet" type="text/css" />
		<c:if test="${mobileMode }"><%-- 모바일 --%>
			<link href="<c:url value="/${siteVO.sitePath }/common/css/Jnit_media_board.css" />" media="all" rel="stylesheet" type="text/css" />
			<link href="<c:url value="/${siteVO.sitePath }/common/css/Jnit_m_board.css" />" media="all" rel="stylesheet" type="text/css" />
		</c:if>
	<script type="text/javaScript" src="<c:url value="/resources/js/jquery.min.js"/>"></script>
	<script type="text/javaScript" src="<c:url value="/resources/js/jquery.plugins/jquery.ui.latest.custom.min.js"/>"></script>
	<script type="text/javaScript" src="<c:url value="/resources/js/jquery.plugins/jquery.ui.datepicker-ko.js"/>"></script>
	<script type="text/javaScript" src="<c:url value="/resources/js/jquery.plugins/jquery.ui.timepicker.addon.js"/>"></script>
	<script type="text/javaScript" src="<c:url value="/resources/js/bootstrap.js"/>"></script>
	<c:if test="${boardinfoVO.useWyswyg == 1}">
		<c:catch var="callEdit">
			<jsp:include page="../../../../edit/${boardinfoVO.useWyswygType }/edit.jsp" />
		</c:catch>
		<c:if test="${!empty callEdit }">게시판설정을 재저장 해주시기 바랍니다. ${callEdit }</c:if>
	</c:if>
	<script type="text/javaScript" src="<c:url value="/board/_common/js/board.js"/>"></script>
	<script type="text/javaScript">var ctxRoot = '${ctxRoot}';</script>
</head>
<body>
</c:if>
<div class="container-fluid">
	<div class="row-fluid boardWrap <c:out value="${boardinfoVO.boardType}${mobileMode?'_mobile':''}" /> <c:out value="${boardId}" />">
		<c:if test="${empty error}">
			<c:if test="${useSkeleton}">
				<script type="text/javaScript">
				<!--
				$(document).ready(function(){					
					var pageTitle = document.title;
					var boardTitle = "";
					var splitTitle = pageTitle.split("<");
					splitTitle[0] = splitTitle[0] + " ${modeStr}";
					for(var i=0; i<splitTitle.length-1; i++){
						boardTitle = boardTitle + splitTitle[i] + " <";
					}
				    boardTitle = boardTitle + splitTitle[splitTitle.length-1];
					$(document).attr("title",boardTitle);
				});
				// -->
				</script>
				<c:if test="${boardinfoVO.useWyswyg == 1}">
					<script type="text/javaScript">
					<!--
					var fileref=document.createElement("link");
					  fileref.setAttribute("rel", "stylesheet");
					  fileref.setAttribute("type", "text/css");
					  fileref.setAttribute("href", "<c:url value='/board/_editor/css/editor.css' />");
					  <%--
						$('head')[0].appendChild("<link rel='stylesheet' href='<c:url value='/board/_editor/css/editor.css' />' type='text/css' charset='utf-8'/>");
					 --%>
					 $('head')[0].appendChild(fileref);
					// -->
					</script>
				</c:if>
			</c:if>
			<input type="hidden" id="boardUseWyswygType" name="boardUseWyswygType" value="${boardinfoVO.useWyswygType }"/>
			<input type="hidden" id="boardLang" name="boardLang" value="${boardinfoVO.useLanguage }"/>
			<input type="hidden" id="boardType" value="${boardinfoVO.boardType}" />
			<jsp:include page="/board/skin/${boardinfoVO.boardSkin}/_${boardinfoVO.boardType}${mobileMode?'_mobile':''}/${mode}.jsp" flush="false"/>
		</c:if>
		<c:if test="${not empty error}">
		<script type="text/javascript">
		<!--
			//getSitePath = header.jsp
			var returnUrl = "<%=request.getRequestURI()%>";			
			<c:if test="${loginVO.mbrId != null}">
				alert("${error}");
				location.href = "?boardId=${boardinfoVO.boardId}";
			</c:if>	
			<c:if test="${loginVO.mbrId == null}">
				alert("${error} 로그인페이지로 이동합니다.");
				location.href = "<c:url value="/${getSitePath}/login.jsp"/>?sitePath=${getSitePath}&returnUrl=" + encodeURIComponent(returnUrl);
			</c:if>
		//-->
		</script>
		<div class="alert alert-error">
			<strong>Error!</strong>
			<c:out value="${error}"/>
		</div>
		</c:if>
		<input type="hidden" id="boardUseFilter" value="<c:out value="${boardinfoVO.useFilter}" />"/>
	</div>
</div>
<%-- 게시판 필터링 --%>
<%-- 2015-09-03 by.나성재 수정
<c:if test="${boardinfoVO.useFilter == 1 && (mode == 'write' || mode == 'edit')}">
<%@ include file="/webfilter/inc/initCheckWebfilter.jsp"%>
</c:if>
 --%>

<c:if test="${useSkeleton}">
<script type="text/javaScript">var ctxRoot = '${ctxRoot}';</script>
<script type="text/javascript">
<!--
	window.jQuery || document.write('<script src="<c:url value="/resources/js/jquery.min.js"/>"><\/script>');
// -->
</script>

<script type="text/javascript">
<!--
	$.ui || document.write('<script src="<c:url value="/resources/js/jquery.plugins/jquery.ui.latest.custom.min.js"/>"><\/script><script src="<c:url value="/resources/js/jquery.plugins/jquery.ui.datepicker-ko.js"/>"><\/script>');
// -->	
</script>

<c:if test="${mode == 'edit' || mode == 'write'}">
	<script type="text/javascript">
	<!--
		$.timepicker || document.write('<script src="<c:url value="/resources/js/jquery.plugins/jquery.ui.timepicker.addon.js"/>"><\/script>');
	// -->
	</script>
</c:if>

<c:if test="${boardinfoVO.useWyswyg == 1}">
	<%-- <script src="<c:url value="/board/_editor/js/editor_loader.js" />" type="text/javascript" charset="utf-8"></script> --%>
	<c:catch var="callEdit">
			<jsp:include page="../../../../edit/${boardinfoVO.useWyswygType }/edit.jsp" />
	</c:catch>
	<c:if test="${!empty callEdit }">게시판설정을 재저장 해주시기 바랍니다. ${callEdit }</c:if>
</c:if>
<script type="text/javaScript" src="<c:url value="/board/_common/js/board.js"/>"></script>
<%--
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap-responsive.css"/>" />
--%>
</c:if>

<c:if test="${not useSkeleton}">
</body>
</html>
</c:if>
