<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/board/header.jsp" %>
<%@ page import="jnit.board.BoardSession" %>
<%
	BoardSession.initBoardSession();		//게시판 세션 초기화
	BoardSession.setBoardSession();			//게시판 세션 생성 ( info : boardId, useSkeleton, fixedCategory, customSkin, customCss jsp:param 데이터를 담는다.)
%>
<%--
<%//write.jsp 참고%>
<form:form commandName="jnitboarddbVO" name="bbsForm" id="bbsForm" method="post" enctype="multipart/form-data" action="?">
--%>
<c:url value="/board/board.do" var="actionUrl"/>
<form:form commandName="jnitboarddbVO" name="bbsForm" id="bbsForm" method="post" enctype="multipart/form-data" action="${actionUrl }">
<input type="hidden" id="retUrl" name="retUrl" value="${retUrl }" />
<input type="hidden" name="boardId" value="<c:out value="${boardinfoVO.boardId}"/>" />
<input type="hidden" name="mode" value="<c:out value="${param.mode}"/>" />
<input type="hidden" name="cntId" value="<c:out value="${param.cntId}"/>" />

<table class="bbsView table table-bordered" summary="<c:out value="${boardinfoVO.boardTitle}" /><%= JnitboardController.isLanguage("의 조회 테이블로",lang) %><%-- 의 조회 테이블로 --%> <c:if test="${not empty lbl.writer}"><c:out value="${lbl.writer}" />,</c:if><c:if test="${not empty lbl.created}"><c:out value="${lbl.created}" />,</c:if><c:if test="${not empty lbl.hit}"><c:out value="${lbl.hit}" />,</c:if><c:if test="${not empty fileList && boardinfoVO.useFile != 0}" ><%= JnitboardController.isLanguage("첨부",lang) %><%--  --%>,</c:if><c:forEach var="k" items="${sIdx}" varStatus="status"><c:out value="${lbl[k]}" /><c:out value="${status.last ? '' : ','}" /></c:forEach><%= JnitboardController.isLanguage("으로 구성되어 있습니다.",lang) %><%--  --%>">
	<caption><c:out value="${boardinfoVO.boardTitle}" /> <%= JnitboardController.isLanguage("조회",lang) %></caption>
	<thead>
		<tr>
			<th colspan="6" class="title"><c:if test="${isAdmin == true && result.isdel == 1}"><span class="delArticle">(<%= JnitboardController.isLanguage("삭제글",lang) %>) </span></c:if><c:out value="${result.title}" /></th>
		</tr>
	</thead>
	<tbody>
	<tr>
		<c:if test="${not empty lbl.writer}">
		<th class="writer"><c:out value="${lbl.writer}" /></th><td class="writer"><c:out value="${result.writer}" /><%--<c:if test="${isAdmin == true}"><span style="font-size:10px;">(<c:out value="${result.mbrIp}"/>)</span></c:if> --%></td>
		</c:if>
		<c:if test="${not empty lbl.created}">
		<th class="created"><c:out value="${lbl.created}" /></th><td class="created"><fmt:formatDate value="${result.created}" pattern="yyyy-MM-dd" /></td>
		</c:if>
		<c:if test="${not empty lbl.hit}">
		<th class="hit"><c:out value="${lbl.hit}" /></th><td class="hit"><c:out value="${result.hit}" /></td>
		</c:if>
	</tr>
	<c:if test="${not empty fileList && boardinfoVO.useFile != 0}" >
	<tr>
		<th class="file" scope="row"><%= JnitboardController.isLanguage("첨부",lang) %></th>
		<td colspan="5">
		<c:forEach var="bbsfile" items="${fileList}" varStatus="status">
			<c:if test="${fn:contains(bbsfile.fileUrl, '.')}">
				<c:set var="fileUrl" value="${fn:split(bbsfile.fileUrl,'.')}" />
			</c:if>
			<span class="file">
				<img src="<c:url value="/board/_common/img/icoFile2.gif" />" alt="<%= JnitboardController.isLanguage("파일 다운로드",lang) %>" />&nbsp;
				<a href="javascript:Jnit_boardDownload('<c:url value="${fileUrl[0]}"/>','<c:url value="/board/ajax/file/downloadCount.do?fileId=${bbsfile.fileId }"/>','${status.count }');" target="_self">
					<c:out value="${bbsfile.fileOnm}"/>&nbsp;(<span id="download${status.count }"><%= JnitboardController.isLanguage("다운로드",lang) %> <c:out value="${bbsfile.fileDownloadCount } 회"/></span>)
				</a>
			</span>
		</c:forEach>
		</td>
	</tr>
	</c:if>
	<c:forEach var="k" items="${sIdx}" varStatus="s">
	<tr>
	<c:choose>
		<c:when test="${k == 'content'}">
		<td colspan="6" class="content">
			<div class="board_content">
			<c:if test="${result.isHtml == 1}">
						<%--<c:out value="${fn:replace(result.content,'<','&lt;')}" escapeXml="false" />  --%>
							<c:out value="${fn:replace(result.content,'<script>','****')}" escapeXml="false" />
					</c:if>
					<c:if test="${result.isHtml == 0}">
						<%--<c:out value="${fn:replace(result.content,lf,'<br />')}" escapeXml="false" /> --%>
							<c:out value="${fn:replace(fn:replace(result.content,lf,'<br />'),'<script>','****')}" escapeXml="false" />
						
					</c:if>
			</div>
		</td>
		</c:when>
		<c:otherwise>
			<th scope="row" class="${k}"><c:out value="${f[k].lbl}" /></label></th>
			<td colspan="5">
					<c:choose>
					<%--input--%>
					<c:when test="${f[k].type == 'input'}">
					<c:out value="${result[k]}" />
					</c:when>
					<%--textarea--%>
					<c:when test="${f[k].type == 'textarea'}">
					<c:out value="${result[k]}" />
					</c:when>
					<%--date yyyy-MM-dd--%>
					<c:when test="${f[k].type == 'datetime'}">
					<fmt:formatDate value="${result[k]}" pattern="yyyy-MM-dd HH:mm:ss" />
					</c:when>
					<%--date yyyy-MM-dd hh:mm:ss--%>
					<c:when test="${f[k].type == 'date'}">
					<fmt:formatDate value="${result[k]}" pattern="yyyy-MM-dd" />
					</c:when>
					<%--select--%>
					<c:when test="${f[k].type == 'select'}">
					<c:out value="${result[k]}" />
					</c:when>
					<c:otherwise>
					<c:out value="${result[k]}" />
					</c:otherwise>
					</c:choose>
					</td>
				</tr>
			</td>
		</c:otherwise>
	</c:choose>
	</tr>
	</c:forEach>
	</tbody>
</table>
<%-- 소셜댓글 --%>
<c:if test="${boardinfoVO.useSocial == 1 }">
<%
	String boardId = request.getParameter("boardId");
	String cntId = request.getParameter("cntId");
	String uid = boardId+"_"+cntId;
%>
<c:set var="uid" value="<%= uid %>" />
<script type="text/javascript" charset="utf-8" src="http://v2.ttalk.co.kr/js/jquery.ttalk.min.js"></script>
<script type="text/javascript" charset="utf-8" src="http://v2.ttalk.co.kr/js/init.ttalk.min.js"></script>
<script type="text/javascript" charset="utf-8">
try {
 ttparam = {
         sitekey : "d4159e4b9fcd85b4828cebce7d1b4fcd2fde1d98",
         ttalkmaindiv : ["ttalk_div_20150602152700"],
         ttalkratingdiv : [""],
         article_uid : ["${uid}"],
         article_url : [window.location.href],
         article_catecd : [""],
         article_img :  [""],
         article_title : ["${result.title}"],
         mobile : "n",
         list_view : ["a"]
 }
 var ttalk = new TTalkLoad();
 ttalk.init();
} catch(e) {}
</script>

<div id="ttalk_div_20150602152700"></div> <!-- 댓글 div -->
</c:if>

<c:if test="${boardinfoVO.useCmt == 1}" >
	<div id="Jnit_boardCmt"></div>
	<input type="hidden" id="boarcmtUrl" value="<c:url value='/board/ajax/cmt.do'/>"/>
	<c:if test ="${permCmt}" >	
		<table class="bbsCmt table table-bordered" summary="<c:out value="${boardinfoVO.boardTitle}" /><%= JnitboardController.isLanguage("의 덧글입력 테이블입니다.",lang) %>">
			<caption><c:out value="${boardinfoVO.boardTitle}" /> <%= JnitboardController.isLanguage("덧글 입력",lang) %></caption>
			<tbody>
				<tr>
					<td class="cmt_text"><textarea id="cmtsubmit_text" name="cmtsubmit_text" class="content content input-xxlarge" rows="2" required onKeyUp="javascript:fnByte(this,'2000','cmt')"></textarea><span id="byteInfo_cmt">0</span>/2000Byte</td>
					<td class="cmt_btn"><a href="javascript:Jnit_boardCmtAdd('<c:url value='/board/ajax/cmt.do'/>');" ><%= JnitboardController.isLanguage("등록",lang) %></a></td>
				</tr>
			</tbody>
		</table>
	</c:if>
</c:if>
	
<div class="viewbtn">
	<span class="boardlike"><a href="#none" id="btnGood" class="btn" onclick="jnitBoardGood();return false;" >${goodCnt} <%= JnitboardController.isLanguage("추천 하기",lang) %></a></span>
	<c:if test="${isAdmin == true}">
	<a id="linkManage" class="article btn" href="<c:url value="/board/manage/article.do" />?boardId=${boardinfoVO.boardId}&amp;cntId=${result.id}"><%= JnitboardController.isLanguage("게시물관리",lang) %></a>
	</c:if>
	<c:if test="${boardinfoVO.hideWrite != 1 || permWrite}">
	<c:if test="${result.isNotice == '0'}">
	<c:if test="${permReply == true || isAdmin == true }">
		<c:if test="${boardinfoVO.useReply == '1' }">
			<a id="linkReply" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=write&amp;cntId=${result.id}"><%= JnitboardController.isLanguage("답변",lang) %></a>
		</c:if>
	</c:if>
	</c:if>
	</c:if>
	<%--<a id="sendMail" class="btn" href="#">메일전송</a> --%>
	<c:if test="${isAdmin == true || isMine == true}">
	<a id="linkEdit" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=edit&amp;cntId=${result.id}&amp;pageIdx=<c:out value="${param.pageIdx}" />"><%= JnitboardController.isLanguage("수정",lang) %></a>
		<c:if test="${result.isdel == 0 || result.isdel == 2}">
	    <c:choose>
	    	<c:when test="${isAdmin == true}">
			    <a id="linkDelete" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=delete&amp;cntId=${result.id}&amp;retUrl=${retUrl}"><%= JnitboardController.isLanguage("삭제",lang) %></a>
	    	</c:when>
	    	<c:when test="${isAdmin != true && loginVO.mbrId != null}">
	    		<c:if test="${result.mbrId != null}">
	    			<a id="linkDelete" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=delete&amp;cntId=${result.id}&amp;retUrl=${retUrl}"><%= JnitboardController.isLanguage("삭제",lang) %></a>
	    		</c:if>
			    <c:if test="${result.mbrId == null}">
			    	<a id="deletebtn" class="btn" href="#none;" onclick="return false;"><%= JnitboardController.isLanguage("삭제",lang) %></a>
				    <span id="yourInput" style="display: none;">
				    	<input type="password" id="yourinput" name="yourinput"/>
				    	<a id="linkDelete" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=delete&amp;cntId=${result.id}&amp;retUrl=${retUrl}" class="btn"><%= JnitboardController.isLanguage("확인",lang) %></a>
				    	<a id="deleteCancle" href="#none;" class="btn" onclick="return false;"><%= JnitboardController.isLanguage("취소",lang) %></a>
				    </span>
			    </c:if>
	    	</c:when>
	    	<c:when test="${isAdmin != true && loginVO.mbrId == null}">
				<a id="deletebtn" class="btn" href="#none;" onclick="return false;"><%= JnitboardController.isLanguage("삭제",lang) %></a>
			    <span id="yourInput" style="display: none;">
			    	<input type="password" id="yourinput" name="yourinput"/>
			    	<a id="linkDelete" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=delete&amp;cntId=${result.id}&amp;retUrl=${retUrl}" class="btn"><%= JnitboardController.isLanguage("확인",lang) %></a>
			    	<a id="deleteCancle" href="#none;" class="btn" onclick="return false;"><%= JnitboardController.isLanguage("취소",lang) %></a>
			    </span>
	    	</c:when>
	    </c:choose>
	    </c:if>
	    <c:if test="${isAdmin }">
	    <a id="linkAllDelete" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=allDelete&amp;cntId=${result.id}&amp;retUrl=${retUrl}"><%= JnitboardController.isLanguage("영구삭제",lang) %></a>
	    </c:if>
	</c:if>
    <c:if test="${isAdmin == true}">
	    <c:if test="${result.isdel == 1}">
	    <a id="linkRecovery" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=recovery&amp;cntId=${result.id}"><%= JnitboardController.isLanguage("복구",lang) %></a>
	    </c:if>
	</c:if>   
	<a class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=list&amp;category=${category}&amp;pageIdx=<c:out value="${param.pageIdx}" />"><%= JnitboardController.isLanguage("목록",lang) %></a> 
</div>
<div id="fb-root"></div>
</form:form>
