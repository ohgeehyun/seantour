<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/board/header.jsp" %>
<%@ page import="jnit.board.BoardSession" %>
<link rel="stylesheet" type="text/css" href="/travel/common/css/base.css">
<link rel="stylesheet" type="text/css" href="/travel/common/css/font.css">
<link rel="stylesheet" type="text/css" href="/travel/common/css/layout.css">
<link rel="stylesheet" type="text/css" href="/travel/common/css/common.css">
<link rel="stylesheet" type="text/css" href="/travel/common/css/board.css">
<link rel="stylesheet" type="text/css" href="/travel/common/css/content.css">
<link rel="stylesheet" type="text/css" href="/travel/common/css/slick.css">
<link rel="stylesheet" type="text/css" href="/travel/common/css/aos.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="/travel/common/js/jquery-1.12.2.min.js"></script>
<script type="text/javascript" src="/travel/common/js/jquery.bxslider.js"></script>
<script type="text/javascript" src="/travel/common/js/TweenMax.min.js"></script>
<script type="text/javascript" src="/travel/common/js/slick.min.js"></script>
<script type="text/javascript" src="/travel/common/js/aos.js"></script>
<script type="text/javascript" src="/travel/common/js/common.js"></script>
<script type="text/javascript" src="/travel/common/js/content.js"></script>

<%
	BoardSession.initBoardSession();		//게시판 세션 초기화
	BoardSession.setBoardSession();			//게시판 세션 생성 ( info : boardId, useSkeleton, fixedCategory, customSkin, customCss jsp:param 데이터를 담는다.)
%>
<%--
<%//write.jsp 참고%>
<form:form commandName="jnitboarddbVO" name="bbsForm" id="bbsForm" method="post" enctype="multipart/form-data" action="?">
--%>
<body>
	<div id="wrap" style="position:static;">
		<div id="accessibility"><a href="#content">본문 바로가기</a></div>
		<!-- header -->
		<div id="header" class="trans">
				<h1 class="logo trans"><a href="/travel/index.jsp" class="trans">바다여행 |바다여행 일정만들기</a></h1>
				<ul class="util_top trans">
					<li><a href="/travel/login/index.jsp">로그인</a></li>
                                	<li><a href="/travel/mypage/mypage_honor/index.jsp">마이페이지</a></li>
				</ul>
                <!-- GNB -->
                <div class="gnb_wrap">
                    <ul id="gnb">
                        <li><a href="/travel/seantour/index.jsp">바다여행</a>
                            <div>
                                <ul>
	                        		<li><a href="/travel/seantour/index.jsp">부산광역시</a></li>
	                        		<li><a href="#none">대구광역시</a></li>
	                        		<li><a href="#none">인천광역시</a></li>
	                        		<li><a href="#none">대전광역시</a></li>
	                        		<li><a href="#none">울산광역시</a></li>
	                        		<li><a href="#none">경기도</a></li>
	                        		<li><a href="#none">충청북도</a></li>
	                        		<li><a href="#none">충정남도</a></li>
	                        		<li><a href="#none">전라북도</a></li>
	                        		<li><a href="#none">전라남도</a></li>
	                        		<li><a href="#none">경상북도</a></li>
	                        		<li><a href="#none">경상남도</a></li>
	                        		<li><a href="#none">제주특별자치도</a></li>
	                        	</ul>
                            </div>
                        </li>
                        <li><a href="/travel/my_travel/index.jsp">나만의 여행지 만들기</a></li>
                        <li><a href="/travel/recommendation/index.jsp">추천일정</a></li>
                        <li><a href="/travel/honor/index.jsp">명성</a></li>
                        <li><a href="/travel/info_square/index.jsp">정보광장</a>
                            <div>
                               <ul>
	                                <li><a href="/travel/info_square/notice/index.jsp">공지사항</a></li>
	                                <li><a href="/travel/info_square/faq/index.jsp">Q&A</a></li>
	                                <li><a href="/travel/info_square/statistics/index.jsp">통계</a></li>
	                                <li><a href="">개인정보처리방침</a></li>
	                                <li><a href="">이용약관</a></li>
	                            </ul>
                            </div>
                        </li>
                    </ul>
                 </div>
                <!-- // GNB -->
                <!-- 모바일 전체메뉴 -->
                <div class="mobile_wholeview">
                    <button type="button" class="btn_wv">전체메뉴</button>
                    <div id="wholeView" class="open">
                        <div class="wv_wrap">
                            <div class="wv_wrap_head">
                                <ul class="util_top trans">
									<li><a href="/travel/login/index.jsp">로그인</a></li>
                                	<li><a href="/travel/mypage/mypage_honor/index.jsp">마이페이지</a></li>
								</ul>
                                <button type="button" class="btn_close">전체메뉴 닫기</button>
                            </div>
                            <div class="nav">
                                <ul id="gnb_mobile">
                                    <li><a href="#">바다여행</a>
                                    	<ul>
                                    		<li><a href="#none">부산광역시</a></li>
                                    		<li><a href="#none">대구광역시</a></li>
                                    		<li><a href="#none">인천광역시</a></li>
                                    		<li><a href="#none">대전광역시</a></li>
                                    		<li><a href="#none">울산광역시</a></li>
                                    		<li><a href="#none">경기도</a></li>
                                    		<li><a href="#none">충청북도</a></li>
                                    		<li><a href="#none">충정남도</a></li>
                                    		<li><a href="#none">전라북도</a></li>
                                    		<li><a href="#none">전라남도</a></li>
                                    		<li><a href="#none">경상북도</a></li>
                                    		<li><a href="#none">경상남도</a></li>
                                    		<li><a href="#none">제주특별자치도</a></li>
                                    	</ul>
                                    </li>
                                    <li><a href="/travel/my_travel/index.jsp">나만의 여행일정 만들기</a></li>
                                    <li><a href="/travel/recommendation/index.jsp">추천여행일정</a></li>
                                    <li><a href="/travel/honor/index.jsp">명성</a></li>
                                    <li><a href="/travel/info_square/index.jsp">정보광장</a>
                                       <ul>
                                            <li><a href="/travel/info_square/notice/index.jsp">공지사항</a></li>
			                                <li><a href="/travel/info_square/faq/index.jsp">Q&A</a></li>
			                                <li><a href="/travel/info_square/statistics">통계</a></li>
			                                <li><a href="">개인정보처리방침</a></li>
			                                <li><a href="">이용약관</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="wvBg"></div>
                    </div>
                </div>
                <!-- //모바일 전체메뉴 -->
		      </div>
		<!-- // header -->
		<!-- contaniner -->
		<div id="container" >
            <div class="section_visual sub01 trans400">
                <div class="section_tit_box">
		            <h2 class="tit trans300">추천여행일정</h2>
		            <p class="txt trans300">틀별하고 즐거움이 가득한 국내 바다여행 여행지 추천</p>
        		</div>
            </div><!-- // section_visual -->
             <div class="section_lnb">
             	<div class="inr">
			        <ul id="lnb">
			        	<li><a href="#none"><span class="sprh_com">HOME</span></a></li>
			        	<li id="firstmenu"><!--<a href="/www/main"><span class="unfd sprh_com">홈</span></a>-->
			                <a href="#none">추천여행일정<span class="unfd">같은 레벨 메뉴 보기</span></a>
			                <div>
			                    <ul>
									<li><a href="#none">1차메뉴</a></li>
									<li><a href="#none">1차메뉴</a></li>
									<li><a href="#none">1차메뉴</a></li>
									<li><a href="#none">1차메뉴</a></li>
			                	</ul>
			                </div>  
			            </li>
			            <li id="secondmenu">
			                <a href="#none">작가 추전일정<span class="unfd sprh_com">같은 레벨 메뉴 보기</span></a>
			                <div class="snb_wrap">
			                   <ul class="snb">
									<li><a href="#none">작가 추전일정</a></li>
									<li><a href="#none">2차메뉴</a></li>
									<li><a href="#none">2차메뉴</a></li>
									<li><a href="#none">2차메뉴</a></li>
									<li><a href="#none">2차메뉴</a></li>
			                	</ul> 
			                </div>
			            </li>                       
			         </ul>
		         </div>
    		</div><!-- // section_lnb -->




<c:url value="/board/board.do" var="actionUrl"/>
<form:form commandName="jnitboarddbVO" name="bbsForm" id="bbsForm" method="post" enctype="multipart/form-data" action="${actionUrl }">
<input type="hidden" id="retUrl" name="retUrl" value="${retUrl }" />
<input type="hidden" name="boardId" value="<c:out value="${boardinfoVO.boardId}"/>" />
<input type="hidden" name="mode" value="<c:out value="${param.mode}"/>" />
<input type="hidden" name="cntId" value="<c:out value="${param.cntId}"/>" />
<%--
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	</div>
	<div class="modal-body">
		<dl class="email_dl">
			<dt>e-mail보내기</dt>
			<dd>
				<label for="sname" style="width:70px;">성명</label><input type="text" id="sname" name="sname" value="" class="email_1">
			</dd>
			<dd>
				<label for="semail" style="width:70px;">보내는이</label><input type="text" id="semail" name="semail" value="" class="email_2">
			</dd>
			<dd>
				<label for="remail" style="width:70px;">받는이</label><input type="text" id="remail" name="remail" value="" class="email_2">
			</dd>
			<dd>
				<a id="sendMail_submit" href="#" class="btn" >발송</a>
				<div id="waitDialog" style="display:none; position:absolute; color:#ff9900; font-weight:bold; font-size:15px; border:2px white solid; padding:10px; text-align:center;"><img src="/resources/img/wait_js.gif" width="30" align="absmiddle" /> &nbsp; '처리중입니다 잠시만 기다리세요'</div>
			</dd>
		</dl>
		<br /><br />
	</div>
</div>
 --%>
<table class="bbsView table table-bordered" summary="<c:out value="${boardinfoVO.boardTitle}" /><%= JnitboardController.isLanguage("의 조회 테이블로",lang) %><c:if test="${not empty lbl.writer}"><c:out value="${lbl.writer}" />,</c:if><c:if test="${not empty lbl.created}"><c:out value="${lbl.created}" />,</c:if><c:if test="${not empty lbl.hit}"><c:out value="${lbl.hit}" />,</c:if><c:if test="${not empty fileList && boardinfoVO.useFile != 0}" ><%= JnitboardController.isLanguage("첨부",lang) %><%--  --%>,</c:if><c:forEach var="k" items="${sIdx}" varStatus="status"><c:out value="${lbl[k]}" /><c:out value="${status.last ? '' : ','}" /></c:forEach><%= JnitboardController.isLanguage("으로 구성되어 있습니다.",lang) %>">
	<caption><c:out value="${boardinfoVO.boardTitle}" /> <%= JnitboardController.isLanguage("조회",lang) %></caption>
	<thead>
		<tr>
			<th colspan="6" class="title"><c:if test="${isAdmin == true && result.isdel == 1}"><span class="delArticle">(<%= JnitboardController.isLanguage("삭제글",lang) %>) </span></c:if><c:out value="${result.title}" /></th>
		</tr>
	</thead>
	<tbody>
	<tr>
		<c:if test="${not empty lbl.writer}">
		<th class="writer"><c:out value="${lbl.writer}" /></th><td class="writer"><c:out value="${result.writer}" /><%--<c:if test="${isAdmin == true}"><span style="font-size:10px;">(<c:out value="${result.mbrIp}"/>)</span></c:if> --%></td>
		</c:if>
		<c:if test="${not empty lbl.created}">
		<th class="created"><c:out value="${lbl.created}" /></th><td class="created"><fmt:formatDate value="${result.created}" pattern="yyyy-MM-dd" /></td>
		</c:if>
		<c:if test="${not empty lbl.hit}">
		<th class="hit"><c:out value="${lbl.hit}" /></th><td class="hit"><c:out value="${result.hit}" /></td>
		</c:if>
	</tr>
	<c:if test="${not empty fileList && boardinfoVO.useFile != 0 || !empty mainFileVO }" >
	<tr>
		<th class="file" scope="row"><%= JnitboardController.isLanguage("첨부",lang) %></th>
		<td colspan="5">
		<%-- <c:if test="${!empty mainFileVO && mainFileVO.ismain != '1'}">
			<span class="file">
				<img src="<c:url value="/board/_common/img/icoFile2.gif" />" alt="<%= JnitboardController.isLanguage("파일 다운로드",lang) %>" />&nbsp;
				<a href="javascript:Jnit_boardDownload('<c:url value="${fileUrl[0]}"/>','<c:url value="/board/ajax/file/downloadCount.do?fileId=${mainFileVO.fileId }"/>','0');" target="_self">
					<c:out value="${mainFileVO.fileOnm}"/>&nbsp;(<span id="download0"><%= JnitboardController.isLanguage("다운로드",lang) %> <c:out value="${mainFileVO.fileDownloadCount } 회"/></span>)
				</a>
			</span>
		</c:if> --%>
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
		</td>
	</tr>
	</c:if>
	<c:forEach var="k" items="${sIdx}" varStatus="s">
	<tr>
	<c:choose>
		<c:when test="${k == 'content'}">
		<td colspan="6" class="content">
			<div class="board_content">
			<c:if test="${result.isHtml == 1}">				
				<c:out value="${result.content}" escapeXml="false" />			
			</c:if>
			<c:if test="${result.isHtml == 0}">
				<c:out value="${fn:replace(result.content,lf,'<br />')}" escapeXml="false" />				
			</c:if>
			</div>
		</td>
		</c:when>
		<c:otherwise>
			<th class="${k}"><c:out value="${f[k].lbl}" /></label></th>
			<td colspan="5">
					<c:choose>
					<%--input--%>
					<c:when test="${f[k].type == 'input'}">
					<c:out value="${result[k]}" />
					</c:when>
					<%--textarea--%>
					<c:when test="${f[k].type == 'textarea'}">
					<c:out value="${result[k]}" />
					</c:when>
					<%--date yyyy-MM-dd--%>
					<c:when test="${f[k].type == 'datetime'}">
					<fmt:formatDate value="${result[k]}" pattern="yyyy-MM-dd HH:mm:ss" />
					</c:when>
					<%--date yyyy-MM-dd hh:mm:ss--%>
					<c:when test="${f[k].type == 'date'}">
					<fmt:formatDate value="${result[k]}" pattern="yyyy-MM-dd" />
					</c:when>
					<%--select--%>
					<c:when test="${f[k].type == 'select'}">
					<c:out value="${result[k]}" />
					</c:when>
					
					<c:otherwise>
					<c:out value="${result[k]}" />
					</c:otherwise>
					</c:choose>
					</td>
				</tr>
			</td>
		</c:otherwise>
	</c:choose>
	</tr>
	</c:forEach>
	</tbody>
</table>
<%-- 소셜댓글 --%>
<c:if test="${boardinfoVO.useSocial == 1 }">
<%
	String boardId = request.getParameter("boardId");
	String cntId = request.getParameter("cntId");
	String uid = boardId+"_"+cntId;
%>
<c:set var="uid" value="<%= uid %>" />
<script type="text/javascript" charset="utf-8" src="http://v2.ttalk.co.kr/js/jquery.ttalk.min.js"></script>
<script type="text/javascript" charset="utf-8" src="http://v2.ttalk.co.kr/js/init.ttalk.min.js"></script>
<script type="text/javascript" charset="utf-8">
try {
 ttparam = {
         sitekey : "d4159e4b9fcd85b4828cebce7d1b4fcd2fde1d98",
         ttalkmaindiv : ["ttalk_div_20150602152700"],
         ttalkratingdiv : [""],
         article_uid : ["${uid}"],
         article_url : [window.location.href],
         article_catecd : [""],
         article_img :  [""],
         article_title : ["${result.title}"],
         mobile : "n",
         list_view : ["a"]
 }
 var ttalk = new TTalkLoad();
 ttalk.init();
} catch(e) {}
</script>

<div id="ttalk_div_20150602152700"></div> <!-- 댓글 div -->
</c:if>

<c:if test="${boardinfoVO.useCmt == 1}" >
	<input type="hidden" id="boarcmtUrl" value="<c:url value='/board/ajax/cmt.do'/>"/>
	<div id="Jnit_boardCmt"></div>
	<c:if test ="${permCmt}" >	
		<table class="bbsCmt table table-bordered" summary="<c:out value="${boardinfoVO.boardTitle}" /><%= JnitboardController.isLanguage("의 덧글입력 테이블입니다.",lang) %>">	
			<caption><c:out value="${boardinfoVO.boardTitle}" /> <%= JnitboardController.isLanguage("덧글 입력",lang) %></caption>
			<tbody>
				<tr>
					<td class="cmt_text"><textarea id="cmtsubmit_text" name="cmtsubmit_text" class="content content input-xxlarge" rows="2" required onKeyUp="javascript:fnByte(this,'2000','cmt')"></textarea><span id="byteInfo_cmt">0</span>/2000Byte</td>
					
					<td class="cmt_btn"><a href="javascript:Jnit_boardCmtAdd('<c:url value='/board/ajax/cmt.do'/>');" ><%= JnitboardController.isLanguage("등록",lang) %></a></td>
				</tr>
			</tbody>
		</table>
	</c:if>
</c:if>

<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${param.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${param.searchKeyword}'/>"/>
<input type="hidden" name="pageIdx" id="pageIdx"  value="<c:out value="${param.pageIdx}"/>" />
</form:form>
<div class="PNList">
	<table class="table bbsPNList" summary="<%= JnitboardController.isLanguage("다음글,이전글 목록입니다.",lang) %>">
		<c:forEach var="result" items="${prevList}" varStatus="status">
			<tr>
				<th><%= JnitboardController.isLanguage("다음글",lang) %> ▲</th>
					<c:forEach var="k" items="${sIdxPN}" varStatus="s">
						<c:choose>
						<%--title--%>
						<c:when test="${k == 'title'}">
						<td class="title">
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
						</td>
						</c:when>
						<%--writer--%>
						<c:when test="${k == 'writer'}">
						<td class="writer">
							<c:choose>
							<c:when test="${result.isSecret == 1 && (result.mbrId != loginVO.mbrId && not isAdmin )}">
								<c:out value="${fn:substring(result.writer,0,fn:length(result.writer)-1)}" />*
							</c:when>
							<c:otherwise>
								<c:out value="${result.writer}" />
							</c:otherwise>
							</c:choose>
						</td>
						</c:when>
						<%--created--%>
						<c:when test="${k == 'created'}">
						<td class="created">
							<fmt:parseDate var="dateFmt" value="${result.created}" pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${dateFmt }" pattern="yyyy-MM-dd" />
						</td>
						</c:when>
						</c:choose>
					</c:forEach>
			</tr>
			</c:forEach>
			<c:forEach var="result" items="${nextList}" varStatus="status">
			<tr>
				<th><%= JnitboardController.isLanguage("이전글", lang) %> ▼</th>
					<c:forEach var="k" items="${sIdxPN}" varStatus="s">
						<c:choose>
						<%--title--%>
						<c:when test="${k == 'title'}">
						<td class="title">
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
						</td>
						</c:when>
						<%--writer--%>
						<c:when test="${k == 'writer'}">
						<td class="writer">
							<c:choose>
							<c:when test="${result.isSecret == 1 && (result.mbrId != loginVO.mbrId && not isAdmin )}">
								<c:out value="${fn:substring(result.writer,0,fn:length(result.writer)-1)}" />*
							</c:when>
							<c:otherwise>
								<c:out value="${result.writer}" />
							</c:otherwise>
							</c:choose>
						</td>
						</c:when>
						<%--created--%>
						<c:when test="${k == 'created'}">
						<td class="created">
							<fmt:parseDate var="dateFmt" value="${result.created}" pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${dateFmt }" pattern="yyyy-MM-dd" />
						</td>
						</c:when>
						</c:choose>
					</c:forEach>
		</tr>
		</c:forEach>
</table>
</div>
<div id="fb-root"></div>
<div class="viewbtn">
	<span class="boardlike"><a href="#none" id="btnGood" class="btn" onclick="jnitBoardGood();return false;" >${goodCnt} <%= JnitboardController.isLanguage("추천 하기",lang) %></a></span>
	<c:if test="${isAdmin == true}">
	<a id="linkManage" class="article btn" href="<c:url value="/board/manage/article.do" />?boardId=${boardinfoVO.boardId}&amp;cntId=${result.id}"><%= JnitboardController.isLanguage("게시물관리",lang) %></a>
	</c:if>
	<c:if test="${boardinfoVO.hideWrite != 1 || permWrite}">
	<c:if test="${result.isNotice == '0'}">
	<c:if test="${permReply == true || isAdmin == true }">
		<c:if test="${boardinfoVO.useReply == '1' }">
			<a id="linkReply" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=write&amp;cntId=${result.id}"><%= JnitboardController.isLanguage("답변",lang) %></a>
		</c:if>
	</c:if>
	</c:if>
	</c:if>
	<%--<a id="sendMail" class="btn" href="#">메일전송</a> --%>
	<c:if test="${isAdmin == true || isMine == true}">
	<a id="linkEdit" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=edit&amp;cntId=${result.id}&amp;pageIdx=<c:out value="${param.pageIdx}" />"><%= JnitboardController.isLanguage("수정",lang) %></a>
		<c:if test="${result.isdel == 0 || result.isdel == 2}">
	    <c:choose>
	    	<c:when test="${isAdmin == true}">
			    <a id="linkDelete" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=delete&amp;cntId=${result.id}&amp;retUrl=${retUrl}"><%= JnitboardController.isLanguage("삭제",lang) %></a>
	    	</c:when>
	    	<c:when test="${isAdmin != true && loginVO.mbrId != null}">
	    		<c:if test="${result.mbrId != null}">
	    			<a id="linkDelete" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=delete&amp;cntId=${result.id}&amp;retUrl=${retUrl}"><%= JnitboardController.isLanguage("삭제",lang) %></a>
	    		</c:if>
			    <c:if test="${result.mbrId == null}">
			    	<a id="deletebtn" class="btn" href="#none;" onclick="return false;"><%= JnitboardController.isLanguage("삭제",lang) %></a>
				    <span id="yourInput" style="display: none;">
				    	<input type="password" id="yourinput" name="yourinput"/>
				    	<a id="linkDelete" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=delete&amp;cntId=${result.id}&amp;retUrl=${retUrl}" class="btn"><%= JnitboardController.isLanguage("확인",lang) %></a>
				    	<a id="deleteCancle" href="#none;" class="btn" onclick="return false;"><%= JnitboardController.isLanguage("취소",lang) %></a>
				    </span>
			    </c:if>
	    	</c:when>
	    	<c:when test="${isAdmin != true && loginVO.mbrId == null}">
				<a id="deletebtn" class="btn" href="#none;" onclick="return false;"><%= JnitboardController.isLanguage("삭제",lang) %></a>
			    <span id="yourInput" style="display: none;">
			    	<input type="password" id="yourinput" name="yourinput"/>
			    	<a id="linkDelete" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=delete&amp;cntId=${result.id}&amp;retUrl=${retUrl}" class="btn"><%= JnitboardController.isLanguage("확인",lang) %></a>
			    	<a id="deleteCancle" href="#none;" class="btn" onclick="return false;"><%= JnitboardController.isLanguage("취소",lang) %></a>
			    </span>
	    	</c:when>
	    </c:choose>
	    </c:if>
	    <c:if test="${isAdmin }">
	    <a id="linkAllDelete" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=allDelete&amp;cntId=${result.id}&amp;retUrl=${retUrl}"><%= JnitboardController.isLanguage("영구삭제",lang) %></a>
	    </c:if>	    
	</c:if>
    <c:if test="${isAdmin == true}">
	    <c:if test="${result.isdel == 1}">
	    <a id="linkRecovery" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=proc&amp;proc=recovery&amp;cntId=${result.id}&amp;retUrl=${retUrl}"><%= JnitboardController.isLanguage("복구",lang) %></a>
	    </c:if>
	</c:if>   
	<a class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=list&amp;category=${category}&amp;pageIdx=<c:out value="${param.pageIdx}" />"><%= JnitboardController.isLanguage("목록",lang) %></a> 
</div>

	 <!-- footer -->
		<div id="footer">
			<div class="inr">
				<div class="foot_wrap">
					<ul class="foot_util">
						<li><a href="#none">개인정보처리방침</a></li>
						<li><a href="#none">이메일무단수집거부</a></li>
						<li><a href="#none">이용약관</a></li>
						<li><a href="#none">고객의소리</a></li>
						<li><a href="#none">사이트맵</a></li>
					</ul>
					<ul class="foot_info">
						<li>08588 서울특별시 금천구 가산디지털2로 53 한라시그마밸리 12층</li>
						<li><strong class="color_light_red">080-500-8579</strong>(파도친구) 평일 09:00 ~ 18:00, 점심시간 12:00 ~ 13:00<br /> seantourfipa@gmail.com</li>
						<li>(사) 전국어촌체험마을연합회 | 대표 권영환</li>
					</ul>
				</div>
				<div class="footer_go">
					<a href="#none" class="modipy">
						수정정정요청
					</a>
					<a  href="#none" class="notice">
						공지사항
					</a>
				</div>
				<div class="skip_top">
					<a href="#wrap"><div class="skip_top_btn"><span>TOP</span></div></a>
				</div>
			</div>
		</div>
		<!-- // Footer -->
	</div>
	<!-- // wrap -->
