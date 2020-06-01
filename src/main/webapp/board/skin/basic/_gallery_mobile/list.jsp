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

<div class="m_boardWrap m_gallery">
	<c:if test="${boardinfoVO.useCategory == 1 && empty fixedCategory}"> 
	<div class="m_categoryGroup">
	<select name="category" class="m_category" title="<c:out value="${lbl['category']}" /> <%= JnitboardController.isLanguage("선택",lang) %>">
		<option value=""><%= JnitboardController.isLanguage("전체",lang) %></option>
	<c:forEach var="category" items="${categoryList}" varStatus="status">
		<option value="<c:out value="${category}"/>" <c:out value="${param.category == category ? 'selected' : ''}"/>><c:out value="${category}"/></option>
	</c:forEach>
	</select>
	<input type="image" id="btnSubmit" src="<c:url value="/board/_common/img/btnMove.gif" />" alt="<%= JnitboardController.isLanguage("이동",lang) %>"/>
	</div>
	</c:if>
    <div class="m_board_list">	
		<ul class="m_gallery_list">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<%
				Map rst = (Map)pageContext.getAttribute("result");				
				if(rst.get("fileUrl") != null && !"".equals(rst.get("fileUrl"))){
					String fileUrl = (String)rst.get("fileUrl");
					String[] fileUrlArr = fileUrl.split("/");
					fileUrlArr[fileUrlArr.length-1] = "list_" + fileUrlArr[fileUrlArr.length-1];
					fileUrl = StringUtils.join(fileUrlArr,"/");
					request.setAttribute("fileUrl",fileUrl);
					
				}else{
					request.setAttribute("fileUrl","/images/noimg.gif");
				}
			%>
			<li>
				<p class="img"><a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}" ><img src="<c:url value="${fileUrl}" />" alt="<c:out value="${empty result.fileExt01 ? result.title : result.fileExt01}" /><c:out value="${empty result.fileExt01 ? ' boardEdit37' : ''}" />" /></a></p>
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
									<c:out value="${fn:substring(result.title,0,13)}" /><c:out value="${fn:length(result.title) > 13 ? '...': '' }"/>
								</a>
							</c:if>
							<c:if test="${result.mbrId != null &&  loginVO.mbrId != null}"><!-- 회원글 -->
								<c:if test="${result.mbrId == loginVO.mbrId || isAdmin == true}">
									<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >
										<c:out value="${fn:substring(result.title,0,13)}" /><c:out value="${fn:length(result.title) > 13 ? '...': '' }"/>
									</a>
								</c:if>
								<c:if test="${result.mbrId != loginVO.mbrId && isAdmin == false}">
										<c:out value="${fn:substring(result.title,0,13)}" /><c:out value="${fn:length(result.title) > 13 ? '...': '' }"/>
								</c:if>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${result.mbrId == null || result.mbrId == ''}"><!-- 비회원글 -->
								<a href="?boardId=${boardinfoVO.boardId}&amp;mode=pw&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >
									<c:out value="${fn:substring(result.title,0,13)}" /><c:out value="${fn:length(result.title) > 13 ? '...': '' }"/>
								</a>
							</c:if>
							<c:if test="${result.mbrId != null && result.mbrId != ''}"><!-- 회원글 -->
								<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >
									<c:out value="${fn:substring(result.title,0,13)}" /><c:out value="${fn:length(result.title) > 13 ? '...': '' }"/>
								</a>
							</c:if>
						</c:otherwise>
					</c:choose>
					${jtag:makeIconImg(boardinfoVO, result)}
				</p>
			</li>
		</c:forEach>
		<c:if test="${empty resultList}">
			<li>
				<p class="title">
					<%= JnitboardController.isLanguage("조회된 게시물이 없습니다.",lang) %>
				</p>
			</li>
		</c:if>
		</ul>
	</div>				
	<div class="m_board_nav">
		<div class="m_pagenabi"> 
			<ui:pagination paginationInfo = "${paginationInfo}"   type="jnitDefault"   jsFunction="jnitBoardPage"   />
			<input type="hidden" name="pageIdx" id="pageIdx"  value="<c:out value="${param.pageIdx}"/>" />
		</div>
		<div class="m_listbtn">
			<c:if test="${boardinfoVO.hideWrite != 0 || permWrite}">
			<a class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=write&amp;category=${category}"><%= JnitboardController.isLanguage("등록",lang) %></a>
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