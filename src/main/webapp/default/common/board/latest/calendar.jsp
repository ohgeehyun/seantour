<%
/**
 *@version 3.2.0.1
 **/
%>

<div class="span4">
	<div class="box">
		<div class="tab-header">
			<c:out value="${infoVO.boardTitle}" />
			<span class="pull-right">
               	<span class="options">
              		<a href="${basePath}?boardId=${boardId}&amp;mode=list"><i class="icon-plus"></i></a>
                </span>
             </span>
        </div>
		<div class="padded">
        	<div class="main-calendar">
        		<p class="month_choice">
        			<a href="${basePath}?boardId=${boardId}&amp;searchDate=${calPrevMonth}"><i class="icon-chevron-left"></i></a>
					<strong><c:out value="${calCurrentYear}" />년 <c:out value="${calCurrentMonth}" />월</strong>
					<a href="${basePath}?boardId=${boardId}&amp;searchDate=${calNextMonth}"><i class="icon-chevron-right"></i></a>
				</p>
				<table cellpadding="0" cellspacing="0" class="table table-bordered main-calendar-table box" summary="<c:out value="${calCurrentMonth}" />월 일정 달력입니다.">
					<caption class="comment"><c:out value="${calCurrentMonth}" />월 일정</caption>
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
							<td class="<c:out value="${((vs.index % 7) == 0)?'sun':(d == calCurrentDate)?'on':((vs.index + 8 )% 7 == 0)?'sat':''}" /><c:out value="${(vs.count < calDayOfWeek || vs.count >= (calLastDay + calDayOfWeek))? ' nodate' : ''}" />">
							<c:if test="${vs.count >= calDayOfWeek && vs.count < (calLastDay + calDayOfWeek)}">
										<a href="${basePath}?boardId=${boardId}&amp;searchDate=<c:out value="${calCurrentYear}" />-<c:out value="${calCurrentMonth<10?'0':''}${calCurrentMonth}" />-<c:out value="${d<10?'0':''}${d}" />"><c:out value="${d}" /></a>

							</c:if>
							</td>
						<c:if test="${((vs.index + 8 )% 7) == 0 }"></tr></c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<%--
			<c:out value="${infoVO.boardTitle}"/> : 게시판제목
			반복시작 : <c:forEach var="result" items="${resultList}"><c:if test="${!empty result.date01 && result.date01 != 'null'}"><c:set var="date01" value="${result.date01}" /><fmt:parseDate value="${result.date01}" var="date01" pattern="yyyy-MM-dd HH:mm:ss"/></c:if>
			                    <c:out value="${result.title}"/> : 제목
			                    <a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}" class="title"><c:out value="${result.title}" /></a> : 제목링크
			                    <c:if test="${!empty result.date01 && result.date01 != 'null'}"><fmt:formatDate value="${date01}" pattern="dd"/></c:if><c:if test="${empty date01 && result.date01 == 'null'}">시작날짜를 수정해주시기 바랍니다.</c:if> 작성일
			                    <c:set var="boardLatestContent" value="${jtag:removeHtmlTag(fn:replace(fn:replace(fn:replace(result.content,'&nbsp;',''),'&lt;','<'),'&gt;','>'))}"/><c:out value="${fn:substring(boardLatestContent,0,15)}" escapeXml="false" /><c:out value="${fn:length(boardLatestContent) > 15 ? '...' : ''}"/> : 내용
			                    <c:out value="${result.writer}"/> : 작성자
			                    <c:out value="${result.hit}" /> : 조회수
			반복끝 :</c:forEach>
			--%>
			<c:out value="${infoVO.boardTitle}"/>
			<c:forEach var="result" items="${resultList}"><c:if test="${!empty result.date01 && result.date01 != 'null'}"><c:set var="date01" value="${result.date01}" /><fmt:parseDate value="${result.date01}" var="date01" pattern="yyyy-MM-dd HH:mm:ss"/></c:if>
			<c:out value="${result.title}"/>
			<a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}" class="title"><c:out value="${result.title}" /></a>
			<c:if test="${!empty result.date01 && result.date01 != 'null'}"><fmt:formatDate value="${date01}" pattern="dd"/></c:if><c:if test="${empty date01 && result.date01 == 'null'}">시작날짜를 수정해주시기 바랍니다.</c:if>
			<c:set var="boardLatestContent" value="${jtag:removeHtmlTag(fn:replace(fn:replace(fn:replace(result.content,'&nbsp;',''),'&lt;','<'),'&gt;','>'))}"/><c:out value="${fn:substring(boardLatestContent,0,15)}" escapeXml="false" /><c:out value="${fn:length(boardLatestContent) > 15 ? '...' : ''}"/>
			<c:out value="${result.writer}"/>
			<c:out value="${result.hit}" />
			</c:forEach>
		</div>
	</div>
</div>