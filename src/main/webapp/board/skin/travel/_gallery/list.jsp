<%
/**
 *@version 3.2.0.1
 **/
%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
	<div class="row-fluid">
   		<div class="span12">
        	<div class="box">
        	    <div class="padded">
        	        <div class="gallery">
						<ul>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<li>
									<c:forEach var="k" items="${sIdx}" varStatus="s">
										<c:choose>
											<c:when test="${k == 'img'}">
												<p class="thumb"><a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}" ><img src="<c:url value="${result.thumbUrl}" />" alt="<c:out value="${empty result.fileExt01 ? result.title : result.fileExt01}" /><c:out value="${empty result.fileExt01 ? ' boardEdit37' : ''}" />" /></a></p>
											</c:when>
											<c:when test="${k == 'no'}">
												<p>
													<c:if test="${result.isNotice == 1}">
														<span class="articleTitle"  style="font-weight:bold;">[<%= JnitboardController.isLanguage("공지",lang) %>]
													</c:if>
													<c:if test="${result.isNotice == 0}">
														<c:out value="${startNum-status.index}" />
													</c:if>
												</p>
											</c:when>
											<c:when test="${k == 'title'}">
												<p class="title">
													<c:if test="${not empty result.idx && result.idx != ''}"><span class="replyArtile depth<c:out value="${fn:length(result.idx)}" />"><img src="/resources/img/replace_icon.gif" alt="<%= JnitboardController.isLanguage("답변 게시물",lang) %>" /></span></c:if>
													<c:if test="${isAdmin == true && result.isdel == 1}"><span class="delArticle">(<%= JnitboardController.isLanguage("삭제글",lang) %>)</span></c:if>
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
																	<c:out value="${result.title}" />
																</a>
															</c:if>
															<c:if test="${result.mbrId != null && result.mbrId != ''}"><!-- 회원글 -->
																<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >
																	<c:out value="${result.title}" />
																</a>
															</c:if>
														</c:otherwise>
													</c:choose>
													${jtag:makeIconImg(boardinfoVO, result)}
													 <span class="board_content"><c:out value="${jtag:removeHtmlTag(fn:substring(fn:replace(contentMap[result.id],'&nbsp;',''),0,100))}${fn:length((contentMap[result.id]))>100?'...':''}" /></span>
												</p>
											</c:when>
											<c:when test="${k == 'writer'}">
												<p class="writer">
													<c:choose>
													<c:when test="${result.isSecret == 1 && (result.mbrId != loginVO.mbrId && not isAdmin )}">
														<c:out value="${fn:substring(result.writer,0,fn:length(result.writer)-1)}" />*
													</c:when>
													<c:otherwise>
														<c:out value="${result.writer}" />
													</c:otherwise>
													</c:choose>
												</p>
											</c:when>
											<%--created--%>
											<c:when test="${k == 'created'}">
												<p class="created">
													<fmt:parseDate var="dateFmt" value="${result.created}" pattern="yyyy-MM-dd" />
													<fmt:formatDate value="${dateFmt }" pattern="yyyy-MM-dd" />
												</p>
											</c:when>
											<%--기본--%>
											<c:otherwise>
												<p class="${k}">
													<c:out value="${result[k]}" />
												</p>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</li>
							</c:forEach>
							<c:if test="${empty resultList}">
								<li>
									<%= JnitboardController.isLanguage("조회된 게시물이 없습니다.",lang) %>
								</li>
							</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
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