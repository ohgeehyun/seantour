<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>
<div class="schedule">
	<div class="calGroup">
		<p class="yymm"><c:out value="${calCurrentYear}" /><br><strong><c:out value="${calCurrentMonth}" /></strong></p>
		<ul class="calTop">
			<li class="btnPrev"><a href="${basePath}?boardId=${boardId}&amp;searchDate=${calPrevMonth}"><img src="<c:url value="/board/_common/img/btn_calPrev_nagan.gif"/>" alt="이전달"></a></li>
			<li class="btnNext"><a href="${basePath}?boardId=${boardId}&amp;searchDate=${calNextMonth}"><img src="<c:url value="/board/_common/img/btn_calNext_nagan.gif"/>" alt="다음달"></a></li>
		</ul>
		<table class="calTable" summary="<c:out value="${calCurrentMonth}" />월 행사일정 달력입니다.">
			<caption class="comment"><c:out value="${calCurrentMonth}" />월 행사일정</caption>
			<thead>
				<tr>
					<th class="sun" scope="col">일</th>
					<th scope="col">월</th>
					<th scope="col">화</th>
					<th scope="col">수</th>
					<th scope="col">목</th>
					<th scope="col">금</th>
					<th class="sat" scope="col">토</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="d" value="${1}" />
				<c:forEach var="result" varStatus="vs" begin="0" end="34">
				<c:if test="${vs.count > calDayOfWeek}" >
				<c:set var="d" value="${d+1}"/>
				</c:if>
				<c:if test="${(vs.index % 7) == 0 }"><tr></c:if>
					<td class="<c:out value="${((vs.index % 7) == 0)?'sun':(d == calCurrentDate)?'checkit':((vs.index + 8 )% 7 == 0)?'sat':''}" /><c:out value="${(vs.count < calDayOfWeek || vs.count >= (calLastDay + calDayOfWeek))? ' nodate' : ''}" />">
					<c:if test="${vs.count >= calDayOfWeek && vs.count < (calLastDay + calDayOfWeek)}">
								<a href="${basePath}?boardId=${boardId}&amp;searchDate=<c:out value="${calCurrentYear}" />-<c:out value="${calCurrentMonth<10?'0':''}${calCurrentMonth}" />-<c:out value="${d<10?'0':''}${d}" />"><c:out value="${d}" /></a>
						</div>
					</c:if>
					</td>
				<c:if test="${((vs.index + 8 )% 7) == 0 }"></tr></c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="eventList">
		<ul>
		<c:forEach var="result" items="${resultList}">
			<li><a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"><c:out value="${fn:substring(fn:trim(result.title),0,15)}"/></a></li>
		</c:forEach>
		</ul>
	</div>
</div>