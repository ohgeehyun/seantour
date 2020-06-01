<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/WEB-INF/jsp/jnit/board/header.jsp" %>
<form:form commandName="searchVO" name="bbsForm" id="bbsForm" method="get">
<input type="hidden" name="mode" value="<c:out value="${mode}" />" />
<input type="hidden" name="boardId" value="<c:out value="${boardinfoVO.boardId}"/>" />
<div class="m_boardWrap m_normal">
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
	<div id="m_board_list">
		<ul class="m_list">
		<c:if test="${empty resultList}">
			<li><a href="#"><strong class="title">등록된 글이 없습니다.</strong></a></li>
		</c:if>
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
				<c:choose>				
					<c:when test="${result.isSecret == 1}"><!-- 비밀글 -->
						<c:if test="${result.mbrId == null || loginVO.mbrId == null}"><!-- 비회원글 -->
							<a href="?boardId=${boardinfoVO.boardId}&amp;mode=pw&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >									
						</c:if>
						<c:if test="${result.mbrId != null &&  loginVO.mbrId != null}"><!-- 회원글 -->
							<c:if test="${result.mbrId == loginVO.mbrId || isAdmin == true}">
								<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >										
							</c:if>
							<c:if test="${result.mbrId != loginVO.mbrId && isAdmin == false}">
								<a href="#" >										
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
					</c:otherwise>
				</c:choose>
					<div class="thumb">
						<img src="<c:url value="${fileUrl}" />" alt="<c:out value="${empty result.fileExt01 ? result.title : result.fileExt01}" /><c:out value="${empty result.fileExt01 ? ' boardEdit37' : ''}" />" />
					</div>				
					<strong class="title">
						<c:if test="${!empty result.category }"><span class="category"><c:out value="${result.category }"/></span></c:if>
						<c:if test="${result.isdel == 2}">이동된 게시물입니다.</c:if>
						<c:if test="${isAdmin == true && result.isdel == 1}">(삭제글)</c:if>
						<c:out value="${fn:substring(result.title,0,30) }"/><c:out value="${fn:length(result.title) > 30 ? '...' : ''}" />
					</strong>
					${jtag:makeIconImg(boardinfoVO, result)}
					<span class="info">
						<span class="writer"><c:out value="${result.writer}" /></span>
						<span class="created">				
							<%-- cubrid 버전
							<fmt:formatDate value="${result.created}" pattern="yyyy-MM-dd" /> --%>
							
							<%-- oracle 버전 --%>
							<fmt:parseDate var="created" value="${result.created }" pattern="yyyy-MM-dd" ></fmt:parseDate>
							<fmt:formatDate value="${created}" pattern="yyyy-MM-dd" />
						</span>
					</span>
				</a>
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