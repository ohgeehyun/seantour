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
<div class="m_boardWrap m_faq">
	<c:if test="${boardinfoVO.useCategory == 1 && empty fixedCategory}">	
	<div class="m_categoryGroup">
		<select name="category" class="m_category" title="<%= JnitboardController.isLanguage("카테고리", lang) %><%= JnitboardController.isLanguage("선택", lang) %>">
		<option value=""><%= JnitboardController.isLanguage("전체",lang) %></option>
			<c:forEach var="category" items="${categoryList}" varStatus="status">
				<option value="<c:out value="${category}"/>" <c:out value="${param.category == category ? 'selected' : ''}"/>><c:out value="${category}"/></option>
			</c:forEach>
		</select>
		<input type="image" id="btnSubmit" src="<c:url value="/board/_common/img/btnMove.gif" />" alt="<%= JnitboardController.isLanguage("이동",lang) %>"/>
	</div>
	</c:if>
	<div id="m_faq_list">
		<ul class="m_list">
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<li class="quest on">
					<c:forEach var="k" items="${sIdx}" varStatus="s">
						<c:choose>
							<c:when test="${k == 'title'}">
								<c:choose>
								<c:when test="${isAdmin == true && result.isdel == 1}">
									<a href="#">
								</c:when>
								<c:when test="${isAdmin == true && result.isdel == 0}">
									<a href="#none" onclick="javascript:opendata(${startNum-status.index})">									
								</c:when>
								<c:otherwise>
									<a href="#none" onclick="javascript:opendata(${startNum-status.index})">											
								</c:otherwise>
								</c:choose>
										<strong class="title">
											<img src="<c:url value="/images/btn_q.png" />" alt="<%= JnitboardController.isLanguage("질문 이미지",lang) %>" />
											<c:if test="${!empty result.category }">
												<span class="category">[<c:out value="${result.category }" />]</span>
											</c:if>
											<c:if test="${result.isdel == 1}">
												(<%= JnitboardController.isLanguage("삭제글",lang) %>)
											</c:if>
											<c:out value="${fn:substring(result.title,0,30)}"/><c:out value="${fn:length(result.title) > 30 ? '...' : '' }" />
										</strong>
										${jtag:makeIconImg(boardinfoVO, result)}
									</a>
									<c:if test="${isAdmin == true && result.isdel == 0}">
										<c:if test="${isAdmin == true}"><a id="linkEdit" class="btn btn-mini" href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}"><%= JnitboardController.isLanguage("관리",lang) %></a></c:if>
									</c:if>
							</c:when>
						</c:choose>
					</c:forEach>
				</li>
				<li id="g${startNum-status.index}" class="answer tl" style="display : none;">
	                    <strong class="m_content">
							<img src="<c:url value="/images/btn_a.png" />" alt="<%= JnitboardController.isLanguage("답변 이미지",lang) %>" />
							<c:out value="${fn:replace(contentMap[result.id],lf,'<br />')}" escapeXml="false" />
						</strong>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div class="m_board_nav">
		<div class="m_pagenabi">
		    <ui:pagination paginationInfo = "${paginationInfo}"   type="jnitDefault"   jsFunction="jnitBoardPage"   />
		    <input type="hidden" name="pageIdx" id="pageIdx"  value="<c:out value="${param.pageIdx}"/>" />
	    </div>
		<div class="m_listbtn">
		    <c:if test="${boardinfoVO.hideWrite != 0 || permWrite}">
				<a class="m_btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=write&amp;category=${category}"><%= JnitboardController.isLanguage("등록",lang) %></a>
			</c:if>
		</div>
	</div>
	
	<div class="m_board-search">
		<div class="m_form-search">		
			<select name="searchCondition" class="m_searchCondition" title="<%= JnitboardController.isLanguage("검색 분류 선택",lang) %>">
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
			</select>
			<label for="m_searchKeyword" class="hide"><%= JnitboardController.isLanguage("검색어",lang) %></label>
			<input id="m_searchKeyword" name="searchKeyword" type="text" class="m_search" value="<c:out value="${searchVO.searchKeyword}" />" />
			<button type="submit" class="m_btn"><%= JnitboardController.isLanguage("검색",lang) %></button>
		</div>
	</div>
</div>
</form:form>