<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/board/header.jsp" %>
<%@ page import="jnit.board.BoardSession" %>


<%
	BoardSession.initBoardSession();		//게시판 세션 초기화
	BoardSession.setBoardSession();			//게시판 세션 생성 ( info : boardId, useSkeleton, fixedCategory, customSkin, customCss jsp:param 데이터를 담는다.)
%>
<%--
<%//write.jsp 참고%>
<form:form commandName="jnitboarddbVO" name="bbsForm" id="bbsForm" method="post" enctype="multipart/form-data" action="?">
--%>


 
 <div id="content" class="cont_wrap ">
      
            <div class="cont_body">
	            <div class="inr">
	          
	            <c:choose>
					<c:when test ="${fn:contains(pageContext.request.requestURI , 'seantour_map/travel/info_square/notice/')}"></c:when>
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
							<li><a href="<c:url value="/travel/info_square/faq/index.jsp"/>" class='on'><span>FAQ</span></a></li>
							<li><a href="<c:url value="/travel/info_square/faq_customer/index.jsp"/>"><span>고객의 소리</span></a></li>
							<li><a href="<c:url value="/travel/info_square/updateinfo/index.jsp"/>"><span>정보수정제안</span></a></li>
						</c:if>
						<c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/updateinfo')}">
							<li><a href="<c:url value="/travel/info_square/faq/index.jsp"/>"><span>FAQ</span></a></li>
							<li><a href="<c:url value="/travel/info_square/faq_customer/index.jsp"/>"><span>고객의 소리</span></a></li>
							<li><a href="<c:url value="/travel/info_square/updateinfo/index.jsp"/>" class='on' ><span>정보수정제안</span></a></li>
						</c:if>
							<c:if test="${fn:contains(pageContext.request.requestURI, 'seantour_map/travel/info_square/faq_customer')}">
							<li><a href="<c:url value="/travel/info_square/faq/index.jsp"/>"><span>FAQ</span></a></li>
							<li><a href="<c:url value="/travel/info_square/faq_customer/index.jsp"/>" class='on'><span>고객의 소리</span></a></li>
							<li><a href="<c:url value="/travel/info_square/updateinfo/index.jsp"/>"><span>정보수정제안</span></a></li>
						</c:if>	
						</ul>
					</div>					
					</c:otherwise>
					</c:choose>
	            

				<c:url value="/board/board.do" var="actionUrl"/>
				<form:form commandName="jnitboarddbVO" name="bbsForm" id="bbsForm" method="post" enctype="multipart/form-data" action="${actionUrl }">
					<input type="hidden" id="retUrl" name="retUrl" value="${retUrl }" />
					<input type="hidden" name="boardId" value="<c:out value="${boardinfoVO.boardId}"/>" />
					<input type="hidden" name="mode" value="<c:out value="${param.mode}"/>" />
					<input type="hidden" name="cntId" value="<c:out value="${param.cntId}"/>" />

					<div class="board_view">
					<h3 class="tit"><c:if test="${isAdmin == true && result.isdel == 1}"><span class="delArticle">(<%= JnitboardController.isLanguage("삭제글",lang) %>) </span></c:if><c:out value="${result.title}" /></h3>
					<div class="info_area">
					<c:if test="${not empty fileList && boardinfoVO.useFile != 0 || !empty mainFileVO }" >	
						<ul class="f_left">
							<li>
								<strong><%= JnitboardController.isLanguage("첨부",lang) %> </strong>
							<c:forEach var="bbsfile" items="${fileList}" varStatus="status">
								<c:if test="${fn:contains(bbsfile.fileUrl, '.')}">
									<c:set var="fileUrl" value="${fn:split(bbsfile.fileUrl,'.')}" />
								</c:if>
								<span class="file">
									<img src="<c:url value="/board/_common/img/icoFile2.gif" />" alt="<%= JnitboardController.isLanguage("파일 다운로드",lang) %>" />&nbsp;
									<a href="javascript:Jnit_boardDownload('<c:url value="${fileUrl[0]}"/>','<c:url value="/board/ajax/file/downloadCount.do?fileId=${bbsfile.fileId }"/>','${status.count }');" target="_self">
										<c:out value="${bbsfile.fileOnm}"/>&nbsp;(<span id="download${status.count }"><%= JnitboardController.isLanguage("다운로드",lang) %> <c:out value="${bbsfile.fileDownloadCount } 회"/></span>)
									</a>
								</span>
							</c:forEach>
							</li>
						</ul>
					</c:if>	
						<ul class="f_right">
						<c:if test="${not empty lbl.writer}">
							<li><strong><c:out value="${lbl.writer}" /></strong><c:out value="${result.writer}" /></li>
						</c:if>
						<c:if test="${not empty lbl.created}">
							<li><strong><c:out value="${lbl.created}" /></strong><fmt:formatDate value="${result.created}" pattern="yyyy-MM-dd" /></li>
						</c:if>
						<c:if test="${not empty lbl.hit}">
							<li><strong><c:out value="${lbl.hit}" /></strong><c:out value="${result.hit}" /></li>
						</c:if>
						</ul>
					</div>
					<div class="brd_view_cont">
						<c:if test="${result.isHtml == 1}">				
							<c:out value="${result.content}" escapeXml="false" />			
						</c:if>
						<c:if test="${result.isHtml == 0}">
							<c:out value="${fn:replace(result.content,lf,'<br />')}" escapeXml="false" />				
						</c:if>
					</div>
					</div>
					<div class="btnArea tac">
						<c:if test="${isAdmin == true || isMine == true}">
						<a id="linkEdit" class="button border" href="?boardId=${boardinfoVO.boardId}&amp;mode=edit&amp;cntId=${result.id}&amp;pageIdx=<c:out value="${param.pageIdx}" />"><%= JnitboardController.isLanguage("수정",lang) %></a>
							<c:if test="${result.isdel == 0 || result.isdel == 2}">
						    <c:choose>
						    	<c:when test="${isAdmin == true}">
								    <a id="linkDelete" class="button gray" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=delete&amp;cntId=${result.id}&amp;retUrl=${retUrl}"><%= JnitboardController.isLanguage("삭제",lang) %></a>
						    	</c:when>
						    	<c:when test="${isAdmin != true && loginVO.mbrId != null}">
						    		<c:if test="${result.mbrId != null}">
						    			<a id="linkDelete" class="button gray" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=delete&amp;cntId=${result.id}&amp;retUrl=${retUrl}"><%= JnitboardController.isLanguage("삭제",lang) %></a>
						    		</c:if>
								    <c:if test="${result.mbrId == null}">
								    	<a id="deletebtn" class="button gray" href="#none;" onclick="return false;"><%= JnitboardController.isLanguage("삭제",lang) %></a>
									    <span id="yourInput" style="display: none;">
									    	<input type="password" id="yourinput" name="yourinput"/>
									    	<a id="linkDelete" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=delete&amp;cntId=${result.id}&amp;retUrl=${retUrl}" class="button border"><%= JnitboardController.isLanguage("확인",lang) %></a>
									    	<a id="deleteCancle" href="#none;" class="button border" onclick="return false;"><%= JnitboardController.isLanguage("취소",lang) %></a>
									    </span>
								    </c:if>
						    	</c:when>
						    	<c:when test="${isAdmin != true && loginVO.mbrId == null}">
									<a id="deletebtn" class="button gray" href="#none;" onclick="return false;"><%= JnitboardController.isLanguage("삭제",lang) %></a>
								    <span id="yourInput" style="display: none;">
								    	<input type="password" id="yourinput" name="yourinput"/>
								    	<a id="linkDelete" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=delete&amp;cntId=${result.id}&amp;retUrl=${retUrl}" class="button border"><%= JnitboardController.isLanguage("확인",lang) %></a>
								    	<a id="deleteCancle" href="#none;" class="button border" onclick="return false;"><%= JnitboardController.isLanguage("취소",lang) %></a>
								    </span>
						    	</c:when>
						    </c:choose>
						    </c:if>
						    <c:if test="${isAdmin }">
						    <a id="linkAllDelete" class="button gray" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=allDelete&amp;cntId=${result.id}&amp;retUrl=${retUrl}"><%= JnitboardController.isLanguage("영구삭제",lang) %></a>
						    </c:if>	    
						</c:if>
					    <c:if test="${isAdmin == true}">
						    <c:if test="${result.isdel == 1}">
						    <a id="linkRecovery" class="button border" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=recovery&amp;cntId=${result.id}&amp;retUrl=${retUrl}"><%= JnitboardController.isLanguage("복구",lang) %></a>
						    </c:if>
						</c:if>   
						<a class="button black" href="?boardId=${boardinfoVO.boardId}&amp;mode=list&amp;category=${category}&amp;pageIdx=<c:out value="${param.pageIdx}" />"><%= JnitboardController.isLanguage("목록",lang) %></a> 

					</div>

					<div class="table_nav">
					<c:forEach var="result" items="${prevList}" varStatus="status">
						<dl class="prev">
							<dt><span><%= JnitboardController.isLanguage("이전글", lang) %></span></dt>
							<%-- <c:forEach var="k" items="${sIdxPN}" varStatus="s">
								<c:choose>
								<c:when test="${k == 'title'}"> --%>
								<dd>
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
								</dd>
								<%-- </c:when>
								
								<c:when test="${k == 'writer'}">
								<dd>
									<c:choose>
									<c:when test="${result.isSecret == 1 && (result.mbrId != loginVO.mbrId && not isAdmin )}">
										<c:out value="${fn:substring(result.writer,0,fn:length(result.writer)-1)}" />*
									</c:when>
									<c:otherwise>
										<c:out value="${result.writer}" />
									</c:otherwise>
									</c:choose>
								</dd>
								</c:when>
								<c:when test="${k == 'created'}">
								<dd>
									<fmt:parseDate var="dateFmt" value="${result.created}" pattern="yyyy-MM-dd" />
									<fmt:formatDate value="${dateFmt }" pattern="yyyy-MM-dd" />
								</dd>
								</c:when>
								</c:choose>
							</c:forEach> --%>
						</dl>
					</c:forEach>
					<c:forEach var="result" items="${nextList}" varStatus="status">
						<dl class="next">
							<dt><span><%= JnitboardController.isLanguage("다음글",lang) %></span></dt>
							<%-- <c:forEach var="k" items="${sIdxPN}" varStatus="s">
								<c:choose>
								<c:when test="${k == 'title'}"> --%>
								<dd>
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
								</dd>
								<%-- </c:when>

								<c:when test="${k == 'writer'}">
								<dd>
									<c:choose>
									<c:when test="${result.isSecret == 1 && (result.mbrId != loginVO.mbrId && not isAdmin )}">
										<c:out value="${fn:substring(result.writer,0,fn:length(result.writer)-1)}" />*
									</c:when>
									<c:otherwise>
										<c:out value="${result.writer}" />
									</c:otherwise>
									</c:choose>
								</dd>
								</c:when>

								<c:when test="${k == 'created'}">
								<dd>
									<fmt:parseDate var="dateFmt" value="${result.created}" pattern="yyyy-MM-dd" />
									<fmt:formatDate value="${dateFmt }" pattern="yyyy-MM-dd" />
								</dd>
								</c:when>
								</c:choose>
							</c:forEach> --%>
						</dl>
					</c:forEach>
					</div> 



					<!-- 검색조건 유지 -->
					<input type="hidden" name="searchCondition" value="<c:out value='${param.searchCondition}'/>"/>
					<input type="hidden" name="searchKeyword" value="<c:out value='${param.searchKeyword}'/>"/>
					<input type="hidden" name="pageIdx" id="pageIdx"  value="<c:out value="${param.pageIdx}"/>" />
				</form:form>

	            </div>
			</div>
		</div>