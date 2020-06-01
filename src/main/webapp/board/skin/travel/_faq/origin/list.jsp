<%
/**
 *@version 3.2.0.1
 **/
%>
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
<table class="bbsList table table-bordered table-hover" summary="<c:out value="${boardinfoVO.boardTitle}" /> <%= JnitboardController.isLanguage("의 게시글 목록으로",lang) %><c:forEach var="k" items="${sIdx}" varStatus="status"><c:out value="${lbl[k]}" /><c:out value="${status.last ? '' : ','}" /></c:forEach> <%= JnitboardController.isLanguage("로 구성되어 있습니다.",lang) %>">
	<caption><c:out value="${boardinfoVO.boardTitle}" /></caption>
	<thead>
		<tr>
			<th scope="col" class="start">Q&amp;A</th>
			<%-- <th scope="col" class="title"><%= JnitboardController.isLanguage("질문을 클릭하면 답변내용이 나옵니다.",lang) %></th> --%>
			<c:forEach var="k" items="${sIdx}" varStatus="status">
				<th scope="col" class="${k}<c:out value="${k == 'no' ? ' hidden-phone' : k == 'created' ? ' hidden-phone' : k == 'hit' ? ' hidden-phone' : ''}" /><c:out value="${status.first ? ' start' : status.last ? ' end' : ''}" />"><c:out value="${lbl[k]}" /></th>
			</c:forEach>
		</tr>
	</thead>
	<tbody>
	
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td class="qnaboard-qimg"><span class="board_question">Q</span><%--img src="<c:url value="/images/btn_q.png" />" alt="<%= JnitboardController.isLanguage("질문 이미지",lang) %>" /> --%></td>
				<c:forEach var="k" items="${sIdx}" varStatus="s">
					<td class="${k}<c:out value="${k == 'no' ? ' hidden-phone' : k == 'created' ? ' hidden-phone' : k == 'hit' ? ' hidden-phone' : ''}" /><c:out value="${s.first ? ' start' : s.last ? ' end' : ''}" />">
						<c:choose>
							<%--hit--%>
							<c:when test="${k == 'no'}">
								<c:if test="${result.isNotice == 1}"><span class="articleTitle"  style="font-weight:bold;"><%= JnitboardController.isLanguage("공지",lang) %></span></c:if><c:if test="${result.isNotice == 0}"><c:out value="${startNum-status.index}" /></c:if>
							</c:when>
							<%--title--%>
							<c:when test="${k == 'title'}">
								<c:choose>
									<c:when test="${isAdmin == true && result.isdel == 1}">
										<span class="delArticle">(<%= JnitboardController.isLanguage("삭제글",lang) %>)<c:out value="${result.title}" /><a id="linkEdit" class="btn btn-mini" href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}"><%= JnitboardController.isLanguage("관리",lang) %></a></span>
									</c:when>
									<c:when test="${isAdmin == true && result.isdel == 0}">
										<a href="#none" onclick="javascript:opendata(${startNum-status.index})"><c:out value="${result.title}" /></a>
										<c:if test="${isAdmin == true}"><a id="linkEdit" class="btn btn-mini" href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}"><%= JnitboardController.isLanguage("관리",lang) %></a></c:if>
									</c:when>
									<c:otherwise>
										<a href="#none" onclick="javascript:opendata(${startNum-status.index})"><c:out value="${result.title}" /></a>
									</c:otherwise>
								</c:choose>
								${jtag:makeIconImg(boardinfoVO, result)}
							</c:when>					
							<c:when test="${k == 'file'}">
								<c:choose>
								<c:when test="${!empty boardFileMap[result.id]}">						
									<c:forEach var="resultfile" items="${boardFileMap[result.id]}" varStatus="status2">																															
										<span class="list_file">
											<a href="javascript:Jnit_boardDownload('<c:url value="${resultfile.fileUrl}"/>','<c:url value="/board/ajax/file/downloadCount.do?fileId=${resultfile.fileId }"/>','${status.count }');" target="_self">
												<img src="<c:url value="/board/_common/img/icon_${boardFileType[resultfile.fileId]}.png" />" alt="<c:out value="${resultfile.fileOnm}"/> <%= JnitboardController.isLanguage("파일 다운로드",lang) %>" />
											</a>
										</span>
									</c:forEach>
								</c:when>								
								</c:choose>
							</c:when>
							<%--writer--%>
							<c:when test="${k == 'writer'}">
								<c:choose>
								<c:when test="${result.isSecret == 1 && (result.mbrId != loginVO.mbrId && not isAdmin )}">
									<c:out value="${fn:substring(result.writer,0,fn:length(result.writer)-1)}" />*
								</c:when>
								<c:otherwise>
									<c:out value="${result.writer}" />
								</c:otherwise>
								</c:choose>
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
			<tr>
				<td colspan="4" id="g${startNum-status.index}" class="tl bgcolor" style="display : none;">
					<span class="a board_answer">
						A<%--<img src="<c:url value="/images/btn_a.png" />" alt="<%= JnitboardController.isLanguage("답변 이미지",lang) %>" /> --%>
					</span>
					<span class="txt">
						<c:out value="${fn:replace(contentMap[result.id],lf,'<br />')}" escapeXml="false" />
					</span>
				</td>
			</tr>
		</c:forEach>
		<%--
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td class="qnaboard-qimg"><img src="<c:url value="/images/btn_q.png" />" alt="<%= JnitboardController.isLanguage("질문 이미지",lang) %>" /></td>
				<%-- <td><c:out value="${startNum-status.index}" /></td> --%>
		<%--
				<td class="faq-title">
					<a href="#none" onclick="javascript:opendata(${startNum-status.index})"><c:out value="${result.title}" /></a>
					<c:if test="${isAdmin == true}"><a id="linkEdit" class="btn btn-mini" href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}"><%= JnitboardController.isLanguage("관리",lang) %></a></c:if>
				</td>
			</tr>
			<tr>
				<td colspan="4" id="g${startNum-status.index}" class="tl bgcolor" style="display : none;">
					<span class="a">
						<img src="<c:url value="/images/btn_a.png" />" alt="<%= JnitboardController.isLanguage("답변 이미지",lang) %>" />
					</span>
					<span class="txt">
						<c:out value="${fn:replace(contentMap[result.id],lf,'<br />')}" escapeXml="false" />
					</span>
				</td>
			</tr>
		</c:forEach>
		--%>
		<c:if test="${empty resultList}">
			<tr>
				<td colspan="<c:out value="${fn:length(sIdx)+1}" />" class="nodata"><%= JnitboardController.isLanguage("조회된 게시물이 없습니다.",lang) %></td>
			</tr>
		</c:if>
	</tbody>
</table>
<div class="row-fluid board-rss">
	<div class="span12 form-fed ">
			<a id="rss_board" class="btn rssBtn" target="_blank" title="<%= JnitboardController.isLanguage("새창으로 열립니다",lang) %>" href="${ctxRoot}/board/rss.do?boardId=${boardinfoVO.boardId}&amp;mode=fed&amp;proc=rss" ><i class="icon-rss"></i>RSS</a>
			<a id="atom_board" class="btn atomBtn" target="_blank" title="<%= JnitboardController.isLanguage("새창으로 열립니다",lang) %>" href="${ctxRoot}/board/rss.do?boardId=${boardinfoVO.boardId}&amp;mode=fed&amp;proc=atom" ><c:out value="atom" /></a>
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
		<select name="searchCondition" class="input-small">
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