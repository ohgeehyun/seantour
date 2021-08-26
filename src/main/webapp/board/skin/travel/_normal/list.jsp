<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/board/header.jsp" %>

       
       <div id="content" class="cont_wrap ">
            <div class="cont_body">
	            <div class="inr">
	            <c:choose>
					<c:when test ="${fn:contains(pageContext.request.requestURI , 'seantour_map/travel/info_square/notice/')}"></c:when>
					<c:when test ="${fn:contains(pageContext.request.requestURI , 'seantour_map/travel/info_square/safe_info/')}"></c:when>					
					<c:otherwise>
					 <div class="tabmenu">					 
					 <c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/faq/')}">
						<a href="#none">Q&A<span class="unfd sprh_com"></span></a>
					 </c:if> 
					  <c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/updateinfo')}">
						<a href="#none">정보수정제안<span class="unfd sprh_com"></span></a>
					 </c:if>
					  <c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/faq_customer')}">
						<a href="#none">고객의소리<span class="unfd sprh_com"></span></a>
					 </c:if>	 
						<ul>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/faq/')}">
							<li><a href="<c:url value="/travel/info_square/faq/index.jsp"/>" class='on'><span>Q&A</span></a></li>
							<li><a href="<c:url value="/travel/info_square/faq_customer/index.jsp"/>"><span>고객의 소리</span></a></li>
							<li><a href="<c:url value="/travel/info_square/updateinfo/index.jsp"/>"><span>정보수정제안</span></a></li>
						</c:if>                         
						<c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/updateinfo')}">
							<li><a href="<c:url value="/travel/info_square/faq/index.jsp"/>"><span>Q&A</span></a></li>
							<li><a href="<c:url value="/travel/info_square/faq_customer/index.jsp"/>"><span>고객의 소리</span></a></li>
							<li><a href="<c:url value="/travel/info_square/updateinfo/index.jsp"/>" class='on' ><span>정보수정제안</span></a></li>
						</c:if>
							<c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/faq_customer')}">
							<li><a href="<c:url value="/travel/info_square/faq/index.jsp"/>"><span>Q&A</span></a></li>
							<li><a href="<c:url value="/travel/info_square/faq_customer/index.jsp"/>" class='on'><span>고객의 소리</span></a></li>
							<li><a href="<c:url value="/travel/info_square/updateinfo/index.jsp"/>"><span>정보수정제안</span></a></li>
						</c:if>	
						</ul>
						
					</div>				
					</c:otherwise>
					</c:choose>
	            

				<form:form commandName="searchVO" name="bbsForm" id="bbsForm" method="get">
				<input type="hidden" name="mode" value="<c:out value="${mode}" />" />
				<input type="hidden" name="boardId" value="<c:out value="${boardinfoVO.boardId}"/>" />
				<%-- <c:if test="${boardinfoVO.useCategory == 1 && empty fixedCategory}"> 
				<div class="categoryGroup">
				<select name="category" class="category" title="<c:out value="${lbl['category']}" /> <%= JnitboardController.isLanguage("선택",lang) %>">
					<option value=""><%= JnitboardController.isLanguage("전체",lang) %></option>
				<c:forEach var="category" items="${categoryList}" varStatus="status">
					<option value="<c:out value="${category}"/>" <c:out value="${param.category == category ? 'selected' : ''}"/>><c:out value="${category}"/></option>
				</c:forEach>
				</select>
				<input type="image" id="btnSubmit" src="<c:url value="/board/_common/img/btnMove.gif" />" alt="<%= JnitboardController.isLanguage("이동",lang) %>"/>
				</div>
				</c:if> --%>

					<div class="search_box">
						<fieldset>
							<legend>검색</legend>
							<select name="searchCondition" id="searchCondition" class="select" title="<%= JnitboardController.isLanguage("검색 분류 선택",lang) %>">
								<option value="all"><%= JnitboardController.isLanguage("제목",lang) %>+<%= JnitboardController.isLanguage("내용",lang) %></option>
					<c:forEach var="k" items="${sIdx}" varStatus="status">
						<c:choose>
							<c:when test="${k == 'no'}"></c:when>
							<c:when test="${k == 'title'}">
								<option value="title" <c:out value="${searchVO.searchCondition == 'title' ? 'selected=\"selected\"' : ''}" />><c:out value="${lbl['title']}" /></option>
							</c:when>
							<c:when test="${k == 'file'}"></c:when>
								<%--writer--%>
							<c:when test="${k == 'writer'}">
								<option value="writer" <c:out value="${searchVO.searchCondition == 'writer' ? 'selected=\"selected\"' : ''}" />><c:out value="${lbl['writer']}" /></option>
							</c:when>
								<%--created--%>
							<c:when test="${k == 'created'}"></c:when>
							<c:when test="${k == 'category'}"></c:when>
							<c:when test="${k == 'img'}"></c:when>
							<c:when test="${k == 'hit'}"></c:when>
							<c:otherwise>
								<c:set var="searchKey" value="search${k}" />
								<option value="${searchKey}" <c:out value="${searchVO.searchCondition == searchKey ? 'selected=\"selected\"' : ''}" />><c:out value="${lbl[k]}" /></option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
							</select>
							
							<input name="searchKeyword" id="searchKeyword" type="text" class="word" value="" maxlength="35" placeholder="검색어를 입력하세요" value="<c:out value="${searchVO.searchKeyword}" />" /> 
							<button class="button black" type="submit" value='<%= JnitboardController.isLanguage("검색",lang) %>' />검색
						</fieldset>
					</div>                     


	            	<div class="board_list">
						<table class="tac" summary="<c:out value="${boardinfoVO.boardTitle}" /> <%= JnitboardController.isLanguage("의 게시글 목록으로",lang) %> <c:forEach var="k" items="${sIdx}" varStatus="status"><c:out value="${lbl[k]}" /><c:out value="${status.last ? '' : ','}" /></c:forEach> <%= JnitboardController.isLanguage("로 구성되어 있습니다.",lang) %>">
							<caption><c:out value="${boardinfoVO.boardTitle}" /></caption>
							<colgroup>
							<c:forEach var="k" items="${sIdx}" varStatus="status">
								<c:choose>
									<c:when test="${k == 'no'}"><col width="10%" data-table-type="brd_number" /></c:when>					
									<c:when test="${k == 'title'}"><col width="" data-table-type="brd_subject" /></c:when>					
									<c:when test="${k == 'file'}"><col width="10%" data-table-type="brd_file_count" /></c:when>	
									<c:when test="${k == 'created'}"><col width="15%" data-table-type="brd_w_date" /></c:when>	
									<c:when test="${k == 'hit'}"><col width="10%" data-table-type="brd_views_count" /></c:when>	
									<c:otherwise><col /></c:otherwise>
								</c:choose>
							</c:forEach>
							</colgroup>
							<thead>
								<tr>
								<c:forEach var="k" items="${sIdx}" varStatus="status">	
									<c:choose>
										<c:when test="${k == 'no'}"><th data-table-type="brd_number"><c:out value="${lbl[k]}" /></th></c:when>					
										<c:when test="${k == 'title'}"><th data-table-type="brd_subject"><c:out value="${lbl[k]}" /></th></c:when>					
										<c:when test="${k == 'file'}"><th data-table-type="brd_file_count"><c:out value="${lbl[k]}" /></th></c:when>	
										<c:when test="${k == 'created'}"><th data-table-type="brd_w_date"><c:out value="${lbl[k]}" /></th></c:when>	
										<c:when test="${k == 'hit'}"><th data-table-type="brd_views_count"><c:out value="${lbl[k]}" /></th></c:when>	
										<c:otherwise><th><c:out value="${lbl[k]}" /></th></c:otherwise>
									</c:choose>
								</c:forEach>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${noticeList}" varStatus="status">
									<tr>
										<c:forEach var="k" items="${sIdx}" varStatus="s">
											<%-- <td class="notice ${k}<c:out value="${k == 'no' ? ' hidden-phone' : k == 'created' ? ' hidden-phone' : k == 'hit' ? ' hidden-phone' : ''}" /><c:out value="${s.first ? ' start' : s.last ? ' end' : ''}" />"> --%>
											<c:choose>
												<c:when test="${k == 'no'}"><td data-table-type="brd_number"></c:when>
												<c:when test="${k == 'title'}"><td data-table-type="brd_subject"></c:when>
												<c:when test="${k == 'file'}"><td data-table-type="brd_file_count"></c:when>
												<c:when test="${k == 'created'}"><td data-table-type="brd_w_date"></c:when>
												<c:when test="${k == 'hit'}"><td data-table-type="brd_views_count"></c:when>
												<c:otherwise><td></c:otherwise>
											</c:choose>
											<c:choose>
											<%--hit--%>
											<c:when test="${k == 'no'}">
												<c:if test="${result.isNotice == 1}"><span class="articleTitle"  style="font-weight:bold;"><%= JnitboardController.isLanguage("공지",lang) %></span></c:if><c:if test="${result.isNotice == 0}"><c:out value="${startNum-status.index}" /></c:if>
											</c:when>
											<%--title--%>
											<c:when test="${k == 'title'}">
												<c:if test="${not empty result.idx && result.idx != ''}"><span class="replyArtile depth<c:out value="${fn:length(result.idx)}" />"><img src="/resources/img/replace_icon.gif" alt="<%= JnitboardController.isLanguage("답변 게시물",lang) %>" /></span></c:if>
												<c:if test="${isAdmin == true && result.isdel == 1}"><span class="delArticle">(<%= JnitboardController.isLanguage("삭제글",lang) %>)</span></c:if>
												<c:choose>						
													<c:when test="${result.isdel == 2}">
													(<%= JnitboardController.isLanguage("이동된 글",lang) %>)<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}" ><c:out value="${result.title}" /></a>
													</c:when>						
													<c:when test="${result.isSecret == 1}"><!-- 비밀글 -->
														<span class="secretArticle"><img src="<c:url value="/resources/img/lock_icon.gif"/>" alt="<%= JnitboardController.isLanguage("비밀 게시물",lang) %>" /></span>
														<c:if test="${result.mbrId == null || loginVO.mbrId == null}"><!-- 비회원글 -->
															<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >
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
															<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >
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
											</c:when>					
											<c:when test="${k == 'file'}">
												<c:choose>
												<c:when test="${!empty boardFileMap[result.id]}">						
													<c:forEach var="resultfile" items="${boardFileMap[result.id]}" varStatus="status2">																															
														<span class="list_file">
															<a href="javascript:Jnit_boardDownload('<c:url value="${resultfile.fileUrl}"/>','<c:url value="/board/ajax/file/downloadCount.do?fileId=${resultfile.fileId }"/>','${status.count }');" target="_self">
																<img src="<c:url value="/board/_common/img/icon_${fn:toLowerCase(boardFileType[resultfile.fileId] == 'jpeg' ? 'jpg' :  boardFileType[resultfile.fileId])}.png" />" alt="<c:out value="${resultfile.fileOnm}"/> <%= JnitboardController.isLanguage("파일 다운로드",lang) %>" />
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
								</c:forEach>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<c:forEach var="k" items="${sIdx}" varStatus="s">
											<%-- <td class="${k}<c:out value="${k == 'no' ? ' hidden-phone' : k == 'created' ? ' hidden-phone' : k == 'hit' ? ' hidden-phone' : ''}" /><c:out value="${s.first ? ' start' : s.last ? ' end' : ''}" />"> --%>
											<c:choose>
												<c:when test="${k == 'no'}"><td data-table-type="brd_number"></c:when>
												<c:when test="${k == 'title'}"><td data-table-type="brd_subject"></c:when>
												<c:when test="${k == 'file'}"><td data-table-type="brd_file_count"></c:when>
												<c:when test="${k == 'created'}"><td data-table-type="brd_w_date"></c:when>
												<c:when test="${k == 'hit'}"><td data-table-type="brd_views_count"></c:when>
												<c:otherwise><td></c:otherwise>
											</c:choose>
											<c:choose>
											<%--hit--%>
											<c:when test="${k == 'no'}">
												<c:if test="${result.isNotice == 1}"><span class="articleTitle"  style="font-weight:bold;">[<%= JnitboardController.isLanguage("공지",lang) %>]</c:if><c:if test="${result.isNotice == 0}"><c:out value="${startNum-status.index}" /></c:if>
											</c:when>
											<%--title--%>
											<c:when test="${k == 'title'}">
												<c:if test="${not empty result.idx && result.idx != ''}"><span class="replyArtile depth<c:out value="${fn:length(result.idx)}" />"><img src="/resources/img/replace_icon.gif" alt="<%= JnitboardController.isLanguage("답변 게시물",lang) %>" /></span></c:if>
												<c:if test="${isAdmin == true && result.isdel == 1}"><span class="delArticle">(<%= JnitboardController.isLanguage("삭제글",lang) %>)</span></c:if>
												<c:if test="${result.tmp3 == '1'}"><%--최근게시물 체크된 글<img src="<c:url value="/board/_common/img/new_icon.gif" />" alt="" /> --%></c:if>
												<c:choose>						
													<c:when test="${result.isdel == 2}">
													(<%= JnitboardController.isLanguage("이동된 글",lang) %>)<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}" ><c:out value="${result.title}" /></a>
													</c:when>						
													<c:when test="${result.isSecret == 1}"><!-- 비밀글 -->
														<span class="secretArticle"><img src="<c:url value="/resources/img/lock_icon.gif"/>" alt="<%= JnitboardController.isLanguage("비밀 게시물",lang) %>" /></span>
														<c:if test="${result.mbrId == null || loginVO.mbrId == null}"><!-- 비회원글 -->
															<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >
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
															<a href="?boardId=${boardinfoVO.boardId}&amp;mode=view&amp;cntId=${result.id}&amp;category=${jtag:encodeUrl(result.category)}&amp;pageIdx=<c:out value="${param.pageIdx}" />" >
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
											</c:when>
											<c:when test="${k == 'file'}">
												<c:choose>						
												<c:when test="${!empty boardFileMap[result.id]}">						
													<c:forEach var="resultfile" items="${boardFileMap[result.id]}" varStatus="status2">
														<span class="list_file">
															<a href="javascript:Jnit_boardDownload('<c:url value="${resultfile.fileUrl}"/>','<c:url value="/board/ajax/file/downloadCount.do?fileId=${resultfile.fileId }"/>','${status.count }');" target="_self">
																<img src="<c:url value="/board/_common/img/icon_${boardFileType[resultfile.fileId] == 'jpeg' ? 'jpg' :  boardFileType[resultfile.fileId] }.png" />" alt="<c:out value="${resultfile.fileOnm}"/> <%= JnitboardController.isLanguage("파일 다운로드",lang) %>" />
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
								</c:forEach>		
								<c:if test="${empty resultList}">
									<tr>
										<td colspan="<c:out value="${fn:length(sIdx)}" />" class="nodata">					
											<%= JnitboardController.isLanguage("조회된 게시물이 없습니다.",lang) %>
										</td>
									</tr>
								</c:if>
							<tbody>
						</table>
					</div>

					<!-- pagination -->
            		<ul class="paging">
						<ui:pagination paginationInfo = "${paginationInfo}"   type="travelBoard"   jsFunction="jnitBoardPage"   />
						<input type="hidden" name="pageIdx" id="pageIdx"  value="<c:out value="${param.pageIdx}"/>" />
            		</ul>
            		<!-- //pagination --> 
				<c:if test="${boardinfoVO.hideWrite != 0 || permWrite}">
        			<div class="btnArea tac">
                   		<a href="?boardId=${boardinfoVO.boardId}&amp;mode=write&amp;category=${category}" class="button border"><%= JnitboardController.isLanguage("등록",lang) %>하기</a>
                    </div>
				</c:if>

				</form:form>
				</div>
				</div><!-- cont_body -->
        	</div><!-- // cont_wrap -->