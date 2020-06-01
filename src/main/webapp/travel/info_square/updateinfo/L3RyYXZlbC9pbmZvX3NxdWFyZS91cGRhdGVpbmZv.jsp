<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000138_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><%-- 
	게시판 code 사용법
	* boardid : 게시판 아이디
	* useSkeleton : true로 입력하면 게시판의 html 뼈대 없이 가져옵니다.
	* customSkin : 게시판 설정을 무시하고 스킨 설정
--%>
<jsp:include page="/${ctxRoot}/board/board.do">
	<jsp:param name="boardId" value="bbs_0000000000000019"/>
	<jsp:param name="fixedCategory" value=""/>
	<jsp:param name="useSkeleton" value="true"/>
	<jsp:param name="customSkin" value=""/>
	<jsp:param name="isMobile" value="false"/>
</jsp:include><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000138_E.jsp' %>