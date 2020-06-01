<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/WEB-INF/jsp/jnit/board/header.jsp" %>
<form:form commandName="searchVO" name="bbsForm" id="bbsForm" method="get">
<input type="hidden" name="mode" value="<c:out value="${mode}" />" />
<input type="hidden" name="boardId" value="<c:out value="${boardinfoVO.boardId}"/>" />
<c:if test="${boardinfoVO.useCategory == 1 && empty fixedCategory}">
<div class="categoryGroup">
<select name="category" class="category" title="<c:out value="${lbl['category']}" /> <%= JnitboardController.isLanguage("선택",lang) %>">
	<option value=""><%= JnitboardController.isLanguage("전체",lang) %></option>
<c:forEach var="category" items="${categoryList}" varStatus="status">
	<option value="<c:out value="${category}"/>" <c:out value="${param.category == category ? 'selected' : ''}"/>><c:out value="${category}"/></option>
</c:forEach>
</select>
<input type="image" id="btnSubmit" src="<c:url value="/board/_common/img/btnMove.gif" />" alt="<%= JnitboardController.isLanguage("이동",lang) %>"/>
</div>
</c:if>

<p class="total">
	<c:choose>
		<c:when test="${searchVO.searchCondition == 'title'}">
			<c:out value="${lbl['title']}" />
		</c:when>
		<c:when test="${searchVO.searchCondition == 'writer'}">
			<c:out value="${lbl['writer']}" />
		</c:when>
		<c:when test="${searchVO.searchCondition == 'content'}">
			<c:out value="${lbl['content']}" />
		</c:when>
		<c:otherwise>
			<%= JnitboardController.isLanguage("전체",lang) %>
		</c:otherwise>
	</c:choose>
	<strong>${totCnt}</strong>
	<span>(<c:out value="${empty param.pageIdx ? '1' : param.pageIdx}"/>/${lastPage})</span>
</p>
<table class="bbsList table table-bordered table-hover" summary="<c:out value="${boardinfoVO.boardTitle}" /> <%= JnitboardController.isLanguage("의 게시글 목록으로",lang) %><c:forEach var="k" items="${sIdx}" varStatus="status"><c:out value="${lbl[k]}" /><c:out value="${status.last ? '' : ','}" /></c:forEach> <%= JnitboardController.isLanguage("로 구성되어 있습니다.",lang) %>">
	<caption><c:out value="${boardinfoVO.boardTitle}" /></caption>
	<thead>
		<tr>
			<c:forEach var="k" items="${sIdx}" varStatus="status">
			<th scope="col" class="${k}<c:out value="${k == 'no' ? ' hidden-phone' : k == 'created' ? ' hidden-phone' : k == 'hit' ? ' hidden-phone' : ''}" /><c:out value="${status.first ? ' start' : status.last ? ' end' : ''}" />"><c:out value="${lbl[k]}" /></th>
			</c:forEach>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">

			<tr style="cursor:pointer;"><%-- onclick="location.href='?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}'" --%>
				<c:forEach var="k" items="${sIdx}" varStatus="s">
					<td class="${k}<c:out value="${k == 'no' ? ' hidden-phone' : k == 'created' ? ' hidden-phone' : k == 'hit' ? ' hidden-phone' : ''}" /><c:out value="${s.first ? ' start' : s.last ? ' end' : ''}" />">
					<c:choose>
					<%--no--%>
					<c:when test="${k == 'no'}">
						<c:if test="${result.isNotice == 1}"><span class="articleTitle"  style="font-weight:bold;">[<%= JnitboardController.isLanguage("공지",lang) %></span>]</c:if><c:if test="${result.isNotice == 0}"><c:out value="${startNum-status.index}" /></c:if>
					</c:when>
					<%--img--%>
					<c:when test="${k == 'img'}">
						<img src="<c:url value="${result.thumbUrl}" />" alt="<c:out value="${empty result.fileExt01 ? result.title : result.fileExt01}" /><c:out value="${empty result.fileExt01 ? ' boardlist37' : ''}" />" />
					</c:when>
					<%--title--%>
					<c:when test="${k == 'title'}">
						<c:if test="${isAdmin == true && result.isdel == 1}"><span class="delArticle">(<%= JnitboardController.isLanguage("삭제글",lang) %>)</span></span></c:if>

						<c:choose>
						<c:when test="${result.isdel == 2}">
							(<%= JnitboardController.isLanguage("이동된 글",lang) %>)<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}" ><c:out value="${result.title}" /></a>
						</c:when>
						<c:when test="${result.isSecret == 1}"><!-- 비밀글 -->
							<span class="secretArticle"><img src="/resources/img/lock_icon.gif" alt="<%= JnitboardController.isLanguage("비밀 게시물",lang) %>" /></span>
							<c:if test="${result.mbrId == null || loginVO.mbrId == null}"><!-- 비회원글 -->
								<a href="?boardId=${boardinfoVO.boardId}&amp;mode=pw&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >
									<c:out value="${result.title}" />
								</a>
							</c:if>
							<c:if test="${result.mbrId != null &&  loginVO.mbrId != null}"><!-- 회원글 -->
								<c:if test="${result.mbrId == loginVO.mbrId || isAdmin == true}">
									<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >
										<c:out value="${result.title}" />
									</a>
								</c:if>
								<c:if test="${result.mbrId != loginVO.mbrId && isAdmin == false}">
										<c:out value="${result.title}" />
								</c:if>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${result.mbrId == null || result.mbrId == ''}"><!-- 비회원글 -->
								<a href="?boardId=${boardinfoVO.boardId}&amp;mode=pw&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >
							</c:if>
							<c:if test="${result.mbrId != null && result.mbrId != ''}"><!-- 회원글 -->
								<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >
							</c:if>
									<span class="title"><c:out value="${result.title}" /></span>
									<span class="board_content">
									<c:set var="content" value="${jtag:removeHtmlTag(fn:replace(fn:replace(contentMap[result.id],'&lt;','<'), '&nbsp;' ,''))}" />
									<c:out value="${fn:substring(content,0,100)}${fn:length(content)>100?'...':''}" /></span>
									<%-- <c:out value="${jtag:removeHtmlTag(fn:substring(fn:replace(contentMap[result.id],'&nbsp;',''),0,100))}${fn:length(jnit:removeHtmlTag(contentMap[result.id]))>100?'...':''}" /></span> --%>
									<%-- <p><c:out value="${fn:substring(result.content,0,100)}${fn:length(result.content)>100?'...':''}" /></p>
									<p>
										<c:out value="${jtag:removeHtmlTag(fn:substring(fn:replace(contentMap[result.id],'&nbsp;',''),0,100))}${fn:length(jnit:removeHtmlTag(contentMap[result.id]))>100?'...':''}" />
									</p>
									--%>
								</a>
						</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${k == 'file'}">
						<c:choose>
						<c:when test="${!empty boardFileMap[result.id]}">
							<c:forEach var="resultfile" items="${boardFileMap[result.id]}" varStatus="status2">
								<c:if test="${resultfile.ismain != 1 }">
								<span class="list_file">
									<a href="javascript:Jnit_boardDownload('<c:url value="${resultfile.fileUrl}"/>','<c:url value="/board/ajax/file/downloadCount.do?fileId=${resultfile.fileId }"/>','${status.count }');" target="_self">
										<img src="<c:url value="/board/_common/img/icon_${boardFileType[resultfile.fileId] == 'jpeg' ? 'jpg' :  boardFileType[resultfile.fileId] }.png" />" alt="<c:out value="${resultfile.fileOnm}"/> <%= JnitboardController.isLanguage("파일 다운로드",lang) %>" />
									</a>
								</span>
								</c:if>
							</c:forEach>
						</c:when>
						<c:when test="${result.fileUrl == null || result.fileUrl == ''}">

						</c:when>
						<c:otherwise>
						<span class="ltst_file">
							<a href="javascript:Jnit_boardDownload('<c:url value="${result.fileUrl}"/>','<c:url value="/board/ajax/file/downloadCount.do?fileId=${result.fileId }"/>','${status.count }');" target="_self">
								<img src="<c:url value="/board/_common/img/icoFile2.gif" />" alt="<c:out value="${result.fileOnm}"/> <%= JnitboardController.isLanguage("파일 다운로드",lang) %>" />
							</a>
						</span>
						</c:otherwise>
						</c:choose>
					</c:when>
					<%--writer--%>
					<c:when test="${k == 'writer'}">
						<c:out value="${result.writer}" />
					</c:when>
					<%--created--%>
					<c:when test="${k == 'created'}">
						<fmt:parseDate var="dateFmt" value="${result.created}" pattern="yyyy-MM-dd" />
						<fmt:formatDate value="${dateFmt }" pattern="yyyy-MM-dd" />
						<%-- <c:out value="${dateFmt }" /> --%>
					</c:when>
					<%--기본--%>
					<c:otherwise>
						<c:out value="${result[k]}" />
					</c:otherwise>
					</c:choose>
					</td>
				</c:forEach>
			</tr>
		</c:forEach>
		<c:if test="${empty resultList}">
			<tr>
				<td colspan="<c:out value="${fn:length(sIdx)}" />" class="nodata"><%= JnitboardController.isLanguage("조회된 게시물이 없습니다.",lang) %></td>
			</tr>
		</c:if>
	</tbody>
</table>
<div class="row-fluid board-rss">
	<div class="span12 form-fed">
			<a id="rss_board" class="btn rssBtn" target="_blank" title="<%= JnitboardController.isLanguage("새창으로 열립니다",lang) %>" href="${ctxRoot}/board/rss.do?boardId=${boardinfoVO.boardId}&amp;mode=fed&amp;proc=rss"><i class="icon-rss"></i>RSS</a>
			<a id="atom_board" class="btn atomBtn" target="_blank" title="<%= JnitboardController.isLanguage("새창으로 열립니다",lang) %>" href="${ctxRoot}/board/rss.do?boardId=${boardinfoVO.boardId}&amp;mode=fed&amp;proc=atom"><c:out value="atom" /></a>
	</div>
</div>
<div class="row-fluid board-nav">
	<div class="span6 offset3">
	<ui:pagination paginationInfo = "${paginationInfo}"   type="jnitDefault"   jsFunction="jnitBoardPage"   />
	 <input type="hidden" name="pageIdx" id="pageIdx"  value="<c:out value="${param.pageIdx}"/>" />
	</div>
	<div class="span3 listbtn">
		<c:if test="${boardinfoVO.hideWrite != 0 || permWrite}">
		<a class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=write&amp;category=${category}"><%= JnitboardController.isLanguage("등록",lang) %></a>
		</c:if>
	</div>
</div>
<div class="row-fluid board-search">
	<div class="span12 form-search">
		<select name="searchCondition" class="input-small" title="<%= JnitboardController.isLanguage("검색 분류 선택",lang) %>">
			<option value="all"><%= JnitboardController.isLanguage("제목",lang) %>+<%= JnitboardController.isLanguage("내용",lang) %></option>
			<c:forEach var="k" items="${sIdx}" varStatus="status">
				<c:choose>
					<c:when test="${k == 'no'}">

					</c:when>
					<%--title--%>
					<c:when test="${k == 'title'}">
					<option value="title" <c:out value="${searchVO.searchCondition == 'title' ? 'selected=\"selected\"' : ''}" />><c:out value="${lbl['title']}" /></option>
					</c:when>
					<c:when test="${k == 'file'}">
					</c:when>
					<%--writer--%>
					<c:when test="${k == 'writer'}">
					<option value="writer" <c:out value="${searchVO.searchCondition == 'writer' ? 'selected=\"selected\"' : ''}" />><c:out value="${lbl['writer']}" /></option>
					</c:when>
					<%--created--%>
					<c:when test="${k == 'created'}">
					</c:when>
					<c:when test="${k == 'category'}">
					</c:when>
					<c:when test="${k == 'img'}">
					</c:when>
					<c:when test="${k == 'hit'}">
					</c:when>
					<c:otherwise>
					<c:set var="searchKey" value="search${k}" />
					<option value="${searchKey}" <c:out value="${searchVO.searchCondition == searchKey ? 'selected=\"selected\"' : ''}" />><c:out value="${lbl[k]}" /></option>

					</c:otherwise>
				</c:choose>
			</c:forEach>
			<%--
			<option value="title" <c:out value="${searchVO.searchCondition == 'title' ? 'selected=\"selected\"' : ''}" />><c:out value="${lbl['title']}" /></option>
			<option value="writer" <c:out value="${searchVO.searchCondition == 'writer' ? 'selected=\"selected\"' : ''}" />><c:out value="${lbl['writer']}" /></option>
			<option value="content" <c:out value="${searchVO.searchCondition == 'content' ? 'selected=\"selected\"' : ''}" />><c:out value="${lbl['content']}" /></option>
			 --%>
		</select>
		<label for="searchKeyword" class="hide"><%= JnitboardController.isLanguage("검색어",lang) %></label>
		<input id="searchKeyword" name="searchKeyword" type="text" class="input-medium search-query" value="<c:out value="${searchVO.searchKeyword}" />" />
		<button type="submit" class="btn"><%= JnitboardController.isLanguage("검색",lang) %></button>
	</div>
</div>

</form:form>