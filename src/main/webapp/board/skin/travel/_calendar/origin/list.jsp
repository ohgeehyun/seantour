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

<div class="container-fluid">
   	<div class="calendar">
		<p class="month_choice">
			<a href="?boardId=${boardinfoVO.boardId}&amp;searchDate=${calPrevMonth}" title="<%= JnitboardController.isLanguage("이전달",lang)%>"><i class="icon-chevron-left"></i></a> <strong><c:out value="${calCurrentYear}" /><%= JnitboardController.isLanguage("년",lang) %> <c:out value="${calCurrentMonth}" /><%= JnitboardController.isLanguage("월",lang) %></strong> <a href="?boardId=${boardinfoVO.boardId}&amp;searchDate=${calNextMonth}" title="<%= JnitboardController.isLanguage("다음달",lang)%>"><i class="icon-chevron-right"></i></a>
		</p>
		<div class="calendargroup">
			<table width="100%" cellspacing="0" class="bbsList table table-bordered" cellpadding="0" summary="<c:out value="${calCurrentYear}" /><%= JnitboardController.isLanguage("년",lang) %> <c:out value="${calCurrentMonth}" /><%= JnitboardController.isLanguage("월의 날짜별로 일정정보를 안내합니다.",lang) %>">
				<caption><%= JnitboardController.isLanguage("일정표",lang) %></caption>
				<thead>
					<tr>
						<th scope="col" class="sun"><%= JnitboardController.isLanguage("일",lang) %></th>
						<th scope="col"><%= JnitboardController.isLanguage("월",lang) %></th>
						<th scope="col"><%= JnitboardController.isLanguage("화",lang) %></th>
						<th scope="col"><%= JnitboardController.isLanguage("수",lang) %></th>
						<th scope="col"><%= JnitboardController.isLanguage("목",lang) %></th>
						<th scope="col"><%= JnitboardController.isLanguage("금",lang) %></th>
						<th scope="col" class="sat"><%= JnitboardController.isLanguage("토",lang) %></th>
					</tr>
				</thead>
				<tbody>
					<c:set var="d" value="${1}" />
					<c:forEach var="result" varStatus="vs" begin="0" end="41">
					<c:if test="${vs.count > calDayOfWeek}" >
					<c:set var="d" value="${d+1}"/>
					</c:if>
					<c:if test="${(vs.index % 7) == 0 }"><tr></c:if>
						<td class="<c:out value="${((vs.index % 7) == 0)?'sun':(d == calCurrentDate)?'checkit':((vs.index + 8 )% 7 == 0)?'sat':''}" /><c:out value="${(vs.count < calDayOfWeek || vs.count >= (calLastDay + calDayOfWeek))? ' nodate' : ''}" />">
						<c:if test="${vs.count >= calDayOfWeek && vs.count < (calLastDay + calDayOfWeek)}">
							<div class="rel">
								<div class="date">
									<c:out value="${d}" />
								</div>
								<c:if test="${not empty calList[d]}">
								<ul>
									<c:forEach var="rst" items="${calList[d]}" varStatus="status">
									<li>
										<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${rst.id}&amp;category=${rst.category}&&searchMonth=<c:out value="${calCurrentYear}" />-<c:out value="${calCurrentMonth<10?'0':''}${calCurrentMonth}" />-<c:out value="${d<10?'0':''}${d}" />"><c:out value="${rst.title}" /></a>
										${jtag:makeIconImg(boardinfoVO, rst)}
									</li>
									</c:forEach>
								</ul>
								</c:if>
							</div>
						</c:if>
						</td>
					<c:if test="${((vs.index + 8 )% 7) == 0 }"></tr></c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="row-fluid board-rss">
			<div class="span12 form-fed">
					<a id="rss_board" class="btn rssBtn" target="_blank" title="<%= JnitboardController.isLanguage("새창으로 열립니다",lang) %>" href="${ctxRoot}/board/rss.do?boardId=${boardinfoVO.boardId}&amp;mode=fed&amp;proc=rss" ><i class="icon-rss"></i><c:out value="rss" /></a>
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
	</div>
</div>

</form:form>