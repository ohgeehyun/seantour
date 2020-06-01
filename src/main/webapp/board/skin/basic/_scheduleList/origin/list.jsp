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
<input type="hidden" name="searchDate" value="<c:out value="${param.searchDate}"/>" />
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
    <div class="schedule row-fluid">
		<div class="calendar span5">
			<p class="yymm"><a href="?boardId=${boardinfoVO.boardId}&amp;searchDate=${calPrevMonth}" title="<%= JnitboardController.isLanguage("이전달",lang)%>"><i class="icon-chevron-left"></i><%= JnitboardController.isLanguage("이전달",lang) %></a><c:out value="${calCurrentYear}" /><%= JnitboardController.isLanguage("년",lang) %><c:out value="${calCurrentMonth}" /><%= JnitboardController.isLanguage("월",lang) %> <a href="?boardId=${boardinfoVO.boardId}&amp;searchDate=${calNextMonth}" title="<%= JnitboardController.isLanguage("다음달",lang)%>"><i class="icon-chevron-right"></i><%= JnitboardController.isLanguage("다음달",lang) %></a></p>
			<table class="calTable table table-bordered" summary="<c:out value="${calCurrentYear}" /><%= JnitboardController.isLanguage("년",lang) %> <c:out value="${calCurrentMonth}" /><%= JnitboardController.isLanguage("월 달력의 날짜를 선택하면 해당 날짜의 상세 일정을 볼 수 있습니다",lang) %>">
				<caption class="comment"><c:out value="${calCurrentYear}" /><%= JnitboardController.isLanguage("년",lang) %> <c:out value="${calCurrentMonth}" /><%= JnitboardController.isLanguage("월",lang) %><%= JnitboardController.isLanguage("달력",lang) %></caption>
				<thead>
					<tr>
						<th scope="col" class="sun"><%= JnitboardController.isLanguage("일",lang) %></th>
						<th scope="col"><%= JnitboardController.isLanguage("월",lang) %></th>
						<th scope="col"><%= JnitboardController.isLanguage("화",lang) %></th>
						<th scope="col"><%= JnitboardController.isLanguage("수",lang) %></th>
						<th scope="col"><%= JnitboardController.isLanguage("목",lang) %></th>
						<th scope="col"><%= JnitboardController.isLanguage("금",lang) %></th>
						<th scope="col" class="BorderRightNone sat"><%= JnitboardController.isLanguage("토",lang) %></th>
					</tr>
				</thead>
				<tbody>
					
					<c:set var="d" value="${1}" />
					<c:forEach var="result" varStatus="vs" begin="0" end="41">
					<c:if test="${((vs.index + 8 )% 7) == 1 }"><tr></c:if>
					<c:if test="${vs.count > calDayOfWeek}" >
					<c:set var="d" value="${d+1}" />
					</c:if>
					<c:if test="${(vs.index % 7) == 0 }"><tr></c:if>
					
					<c:choose>
					<c:when test="${vs.count >= calDayOfWeek && vs.count < (calLastDay + calDayOfWeek)}">
						<td class="<c:out value="${((vs.index + 8 )% 7) == 0 ? 'BorderRightNone' : ''}" /> <c:out value="${((vs.index % 7) == 0)?'sun':(d == calCurrentDate)?'checkit':((vs.index + 8 )% 7 == 0)?'sat':''}" /> <c:out value="${d == calCurrentDate ? 'select' : ''}" />">
						<c:if test="${vs.count >= calDayOfWeek && vs.count < (calLastDay + calDayOfWeek)}">
						<a href="?boardId=${boardinfoVO.boardId}&amp;searchDate=<c:out value="${calCurrentYear}" />-<c:out value="${calCurrentMonth<10?'0':''}${calCurrentMonth}" />-<c:out value="${d<10?'0':''}${d}" />"><c:out value="${d}" /></a>
						</c:if>
						</td>
					</c:when>
					<c:otherwise>
						<td class="<c:out value="${((vs.index + 8 )% 7) == 0 ? 'BorderRightNone' : ''}" />">
						</td>
					</c:otherwise>
					</c:choose>
					<c:if test="${vs.count >= calDayOfWeek && vs.count < (calLastDay + calDayOfWeek)}">
					
					</c:if>
					<c:if test="${((vs.index + 8 )% 7) == 0 }"></tr></c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="today_list">
			<div class="tab-header">
				<p><%= JnitboardController.isLanguage("오늘의 일정",lang) %> <c:out value="${calCurrentYear}" /><%= JnitboardController.isLanguage("년",lang) %> <c:out value="${calCurrentMonth}" /><%= JnitboardController.isLanguage("월",lang) %> <c:out value="${calCurrentDate}" /><%= JnitboardController.isLanguage("일",lang) %></p>
			</div>
	        <ul class="todayList">
	        	<c:if test="${empty resultList}">
	        	<li class="none"><%= JnitboardController.isLanguage("등록된 일정이 없습니다.",lang) %></li>
	        	</c:if>
	        	<c:forEach var="result" items="${resultList}" varStatus="status">
	            <li>
					<c:if test="${isAdmin == true && result.isdel == 1}"><span class="delArticle">(<%= JnitboardController.isLanguage("삭제글",lang) %>)</span></c:if>
					<c:if test="${result.isSecret == 1 && (result.mbrId == loginVO.mbrId || isAdmin )}">
					<span class="secretArticle">(<%= JnitboardController.isLanguage("비밀글",lang) %>)</span>
					</c:if>
					<c:choose>
					<c:when test="${result.isSecret == 1}"><!-- 비밀글 -->
						<span class="secretArticle"><img src="/resources/img/lock_icon.gif" alt="<%= JnitboardController.isLanguage("비밀 게시물",lang) %>" /></span>
						<c:if test="${result.mbrId == null || loginVO.mbrId == null}"><!-- 비회원글 -->
							<a href="?boardId=${boardinfoVO.boardId}&amp;mode=pw&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />searchDate=${calCurrentStr}" >
								<c:out value="${result.title}" />
							</a>
						</c:if>
						<c:if test="${result.mbrId != null &&  loginVO.mbrId != null}"><!-- 회원글 -->
							<c:if test="${result.mbrId == loginVO.mbrId || isAdmin == true}">
								<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />searchDate=${calCurrentStr}" >
									<c:out value="${result.title}" />
								</a>
							</c:if>
							<c:if test="${result.mbrId != loginVO.mbrId && isAdmin == false}">
									<c:out value="${result.title}" />
							</c:if>
						</c:if>
					</c:when>
					<c:when test="${result.isdel == 2}">
					<span class="movedTitle">(<%= JnitboardController.isLanguage("이동된 글",lang) %>)</span>
					</c:when>
					<c:otherwise>					
					<%-- <a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;searchDate=${calCurrentStr}"> --%>
					<c:if test="${result.mbrId == null || result.mbrId == ''}"><!-- 비회원글 -->
						<a href="?boardId=${boardinfoVO.boardId}&amp;mode=pw&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />&amp;searchDate=${calCurrentStr}" >
							<c:out value="${result.title}" />
						</a>
					</c:if>
					<c:if test="${result.mbrId != null && result.mbrId != ''}"><!-- 회원글 -->
						<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />&amp;searchDate=${calCurrentStr}" >
							<c:out value="${result.title}" />
						</a>
					</c:if>
					<c:if test="${dbmsType != 'oracle' && dbmsType != 'tibero'}">
						<fmt:formatDate value="${result.date01}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${result.date02}" pattern="yyyy-MM-dd" />
					</c:if>
					<c:if test="${dbmsType == 'oracle' || dbmsType == 'tibero' }">
						<fmt:parseDate var="date01" value="${result.date01 }" pattern="yyyy-MM-dd HH:mm:ss" ></fmt:parseDate>
					 	<fmt:parseDate var="date02" value="${result.date02 }" pattern="yyyy-MM-dd HH:mm:ss" ></fmt:parseDate>
					 	<fmt:formatDate value="${date01}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${date02}" pattern="yyyy-MM-dd" />
				 	</c:if>
					</c:otherwise>
					</c:choose>
					${jtag:makeIconImg(boardinfoVO, result)}
				</li>
	            </c:forEach>
	        </ul>
	    </div>
	</div>
	<!--달력//-->
    <div class="todaySch span7 box">
    <p class="bl"><%= JnitboardController.isLanguage("최근행사",lang) %></p>
		<div class="r_box">
			<ul>
			<c:if test="${empty resultBoardList}">
        		<li class="none"><%= JnitboardController.isLanguage("등록된 일정이 없습니다.",lang) %></li>
        	</c:if>
			<c:forEach var="result" items="${resultBoardList}" varStatus="status">
				<li>
					<c:if test="${isAdmin == true && result.isdel == 1}"><span class="delArticle">(<%= JnitboardController.isLanguage("삭제글",lang) %>)</span></c:if>
					<c:if test="${result.isSecret == 1 && (result.mbrId == loginVO.mbrId || isAdmin )}">
					<span class="secretArticle">(<%= JnitboardController.isLanguage("비밀글",lang) %>)</span>
					</c:if>
					<c:choose>
					<c:when test="${result.isSecret == 1}"><!-- 비밀글 -->
						<span class="secretArticle"><img src="/resources/img/lock_icon.gif" alt="<%= JnitboardController.isLanguage("비밀 게시물",lang) %>" /></span>
						<c:if test="${result.mbrId == null || loginVO.mbrId == null}"><!-- 비회원글 -->
							<a href="?boardId=${boardinfoVO.boardId}&amp;mode=pw&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />searchDate=${calCurrentStr}" >
								<c:out value="${result.title}" />
							</a>
						</c:if>
						<c:if test="${result.mbrId != null &&  loginVO.mbrId != null}"><!-- 회원글 -->
							<c:if test="${result.mbrId == loginVO.mbrId || isAdmin == true}">
								<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />searchDate=${calCurrentStr}" >
									<c:out value="${result.title}" />
								</a>
							</c:if>
							<c:if test="${result.mbrId != loginVO.mbrId && isAdmin == false}">
									<c:out value="${result.title}" />
							</c:if>
						</c:if>
					</c:when>
					<c:when test="${result.isdel == 2}">
					<span class="movedTitle">(<%= JnitboardController.isLanguage("이동된 글",lang) %>)</span>
					</c:when>
					<c:otherwise>
						<c:if test="${result.mbrId == null || result.mbrId == ''}"><!-- 비회원글 -->
							<a href="?boardId=${boardinfoVO.boardId}&amp;mode=pw&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />&amp;searchDate=${calCurrentStr}" >
						</c:if>
						<c:if test="${result.mbrId != null && result.mbrId != ''}"><!-- 회원글 -->
							<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />&amp;searchDate=${calCurrentStr}" >
						</c:if>
								<span>
									<c:if test="${dbmsType != 'oracle' && dbmsType != 'tibero'}">
										<fmt:formatDate value="${result.date01}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${result.date02}" pattern="yyyy-MM-dd" />
									</c:if>
									<c:if test="${dbmsType == 'oracle' || dbmsType == 'tibero' }">
										<fmt:parseDate var="date01" value="${result.date01 }" pattern="yyyy-MM-dd HH:mm:ss" ></fmt:parseDate>
									 	<fmt:parseDate var="date02" value="${result.date02 }" pattern="yyyy-MM-dd HH:mm:ss" ></fmt:parseDate>
									 	<fmt:formatDate value="${date01}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${date02}" pattern="yyyy-MM-dd" />
								 	</c:if>
								</span>
								&nbsp;<c:out value="${result.title}" />
							</a>
					</c:otherwise>
					</c:choose>
					${jtag:makeIconImg(boardinfoVO, result)}
				</li>
			</c:forEach>
			</ul>
		</div>
	</div>
	<div class="span3 listbtn">
		<c:if test="${boardinfoVO.hideWrite != 0 || permWrite}">
		<a class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=write&amp;category=${category}"><%= JnitboardController.isLanguage("등록",lang) %></a>
		</c:if>
	</div>
</div>
</form:form>