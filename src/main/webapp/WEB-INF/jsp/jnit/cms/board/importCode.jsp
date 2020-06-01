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
<%-- &lt;!--
	최근 게시판 code 
	board_id : 게시판 아이디, count : 가져올 게시물수, type : 출력될 유형
	base_path : 콘텐츠 경로 
--&gt;
&lt;jsp:include page=&quot;/&#36;&#123;ctxRoot&#125;/board/latest.do&quot;&gt; 
	&lt;jsp:param name=&quot;board_id&quot; value=&quot;${boardId }&quot;/&gt;
	&lt;jsp:param name=&quot;count&quot; value=&quot;7&quot;/&gt;
	&lt;jsp:param name=&quot;type&quot; value=&quot;main&quot;/&gt;
	&lt;jsp:param name=&quot;base_path&quot; value=&quot;콘텐츠경로를 입력해주시기 바랍니다.&quot;/&gt;
&lt;/jsp:include&gt; --%>
<textarea id="boardImportCode" rows="20" style="width: 90%">
&lt;%-- 
	게시판 code 사용법
	* boardid : 게시판 아이디
	* useSkeleton : true로 입력하면 게시판의 html 뼈대 없이 가져옵니다.
	* customSkin : 게시판 설정을 무시하고 스킨 설정
--%&gt;
&lt;jsp:include page=&quot;/&#36;&#123;ctxRoot&#125;/board/board.do&quot;&gt;
	&lt;jsp:param name=&quot;boardId&quot; value=&quot;${boardId }&quot;/&gt;
	&lt;jsp:param name=&quot;fixedCategory&quot; value=&quot;&quot;/&gt;
	&lt;jsp:param name=&quot;useSkeleton&quot; value=&quot;true&quot;/&gt;
	&lt;jsp:param name=&quot;customSkin&quot; value=&quot;&quot;/&gt;
	&lt;jsp:param name=&quot;isMobile&quot; value=&quot;false&quot;/&gt;
&lt;/jsp:include&gt;
</textarea>