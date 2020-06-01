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
<%//spring에서 multipart로 넘어온 데이터는 한번 controller를 타고 나면 초기화 시킴.따라서 직접 .do로 호출하고
retUrl에 현재 jsp의 URL을 넘겨 board.do에서 처리된 다음 다시 jsp로 리다이렉트 되도록 처리%>
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

<input type="hidden" id="mode" name="mode" value="proc" />
<input type="hidden" id="proc" name="proc" value="write" />
<input type="hidden" id="boardId" name="boardId" value="<c:out value="${boardinfoVO.boardId}"/>" />
<input type="hidden" id="pid" name="pid" value="${pid}" />
<c:if test="${boardinfoVO.useCategory == '1' && not empty fixedCategory}">
<input type="hidden" name="category" value="${fixedCategory}" />
</c:if>
<table class="bbsWrite table table-bordered" summary="<c:out value="${boardinfoVO.boardTitle}" /><%= JnitboardController.isLanguage("에 글을 작성하기 위한 입력폼으로",lang) %><c:if test="${boardinfoVO.useCategory == '1' && empty fixedCategory}"><c:out value="${lbl.category}" />, </c:if><c:if test="${boardinfoVO.useSecret == '1'}"><%= JnitboardController.isLanguage("비밀글 여부",lang) %>, </c:if><c:forEach var="k" items="${sIdx}" varStatus="s"><c:choose><c:when test="${k == 'writer' || k == 'hit'}"><c:if test="${isAdmin == true}"><c:out value="${f[k].lbl}" /></c:if></c:when><c:otherwise><c:out value="${f[k].lbl}" /></c:otherwise></c:choose><c:out value="${s.last ? '' : ','}" /></c:forEach><c:if test="${boardinfoVO.useFile == 1}">, <%= JnitboardController.isLanguage("첨부",lang) %></c:if> <%= JnitboardController.isLanguage("으로 구성되어 있습니다.",lang) %>">
	<caption><c:out value="${boardinfoVO.boardTitle}" /><%= JnitboardController.isLanguage("입력폼",lang) %>  </caption>
	<tbody>
		<c:if test="${boardinfoVO.useCategory == '1' && empty fixedCategory}">
			<tr>
				<th scope="row"><label for="category"><c:out value="${lbl.category}" /></label></th>
				<td><select name="category" class="category" title="<c:out value="${lbl['category']}" /> <%= JnitboardController.isLanguage("선택",lang) %>">
						<option value=""><%= JnitboardController.isLanguage("전체",lang) %></option>
						<c:forEach var="category" items="${categoryList}" varStatus="status">
						<option value="<c:out value="${category}"/>" <c:out value="${param.category == category ? 'selected' : ''}"/>><c:out value="${category}"/></option>
						</c:forEach>
				</select></td>
			</tr>
		</c:if>
		<c:if test="${isAdmin == true && !empty getTmp1 }">	
			<tr id="iconshow" style="display: none;">
				<th><%= JnitboardController.isLanguage("아이콘 강제 노출",lang) %></th>
				<td>
					<c:forEach var="iconJSON" items="${getTmp1 }">
						 <c:set var="iconkey" value="${fn:substring(iconJSON,0,fn:indexOf(iconJSON,'='))}" />
						 <c:if test="${getTmp1[iconkey].type == '3' }">
							 <input type="checkbox" name="${iconkey }_tmp4" value="Y" />&nbsp;
							 <c:out value="${getTmp1[iconkey].nm }"/><br />
							 <script type="text/javascript">
							 <!--
							 	$(document).ready(function(){
							 		$("#iconshow").css("display","");
							 	});
							 //-->
							 </script>
						 </c:if>
					</c:forEach>
				</td>
			</tr>
		</c:if>
		<c:if test="${isAdmin == true && boardinfoVO.useLatestlist == '1' }">
			<tr>
				<th scope="row" style="width: 18%;"><label for="tmp3"></label><%= JnitboardController.isLanguage("최근게시물 표시",lang) %></th>
				<td><input type="checkbox" name="tmp3" id="tmp3" value="1"></td>
			</tr>
		</c:if>
		<c:if test="${isAdmin == true && boardinfoVO.useNotice == '1'}">
			<tr>
				<th scope="row" style="width: 18%;"><label for="isNotice"><%= JnitboardController.isLanguage("공지글",lang) %></label></th>
				<td><input type="checkbox" name="isNotice" id="isNotice" value="1" /></td>
			</tr>
		</c:if>
		<c:if test="${boardinfoVO.useSecret == '1' && loginVO.mbrId != null}">
			<tr>
				<th scope="row" style="width: 18%;"><label for="isSecret"><%= JnitboardController.isLanguage("비밀글",lang) %></label></th>
				<td><input type="checkbox" name="isSecret" id="isSecret" value="1" /></td>
			</tr>
		</c:if>
		<c:forEach var="k" items="${sIdx}" varStatus="s">
			<c:choose>
			<%--adminField--%>
			<c:when test="${k == 'writer'}">
			<c:if test="${isAdmin == true}">
			<tr>
				<th scope="row"><label for="${k}"><c:out value="${f[k].lbl}" /></label></th>
				<td><input name="${k}" id="${k}" class="boxstyle ${k} input-xxlarge" type="text" value="<c:out value='${loginVO.mbrNm}'/>"/></td>
			</tr>
			</c:if>
			</c:when>
			<c:when test="${ k == 'hit'}">
			<c:if test="${isAdmin == true}">
			<tr>
				<th scope="row"><label for="${k}"><c:out value="${f[k].lbl}" /></label></th>
				<td><input name="${k}" value="" id="${k}" class="boxstyle ${k} input-xxlarge" type="text" /></td>
			</tr>
			</c:if>
			</c:when>
			<%--created--%>
			<c:when test="${k == 'created'}">
			<c:if test="${isAdmin == true}">
			<tr>
				<th scope="row"><label for="${k}"><c:out value="${f[k].lbl}" /></label></th>
				<td><input name="${k}" id="${k}" class="input-xxlarge boxstyle  ${k} datetime" type="text" data-datetype="yyyy-MM-dd hh:mm:ss"/></td>
			</tr>
			</c:if>
			</c:when>
			<%--title--%>
			<c:when test="${k == 'title'}">
			<tr>
				<th scope="row" style="width: 18%;"><label for="${k}"><c:out value="${f[k].lbl}" /></label></th>
				<td><input name="${k}" value="" id="${k}" class="input-xxlarge boxstyle ${k}" type="text" required/></td>
			</tr>
			<%--비회원작성자 --%>
			<c:if test="${boardinfoVO.anonPermWrite == '1' && loginVO.mbrId == null}">
			<tr>
				<th scope="row"><label for="writer"><%= JnitboardController.isLanguage("작성자",lang) %></label></th>
				<td><input name="writer" id="writer" class="input-xxlarge boxstyle ${k}" required type="text" value="<c:out value='${loginVO.mbrNm}'/>"/></td>
			</tr>
			<tr>
				<th scope="row"><label for="<%= JnitboardController.isLanguage("비밀번호",lang) %>"><%= JnitboardController.isLanguage("비밀번호",lang) %></label></th>
				<td><input name="password" value="" id="password" class="input-xxlarge boxstyle ${k}" required type="password" /></td>
			</tr>
			</c:if>
			</c:when>
			<%--content--%>
			<c:when test="${k == 'content'}">
			<tr>
				<%-- <th scope="row"><label for="${k}"><c:out value="${f[k].lbl}" /></label></th> --%>
				<td colspan="2" class="board_td_content">
					<c:if test="${boardinfoVO.useWyswyg != 1}">
						<textarea id="${k}" class="${k} content input-xxlarge boxstyle" rows="10" name="${k}" required></textarea>
					</c:if>
					<c:if test="${boardinfoVO.useWyswyg == 1}">						
						<c:if test="${boardinfoVO.useImage == 1 && boardinfoVO.useWyswygType == 'tinymce'}">
							<div class="editTinymceImages"><a href="javascript:Jnit_img_upload('<c:url value='/broad/pupup.do?boardId=${boardinfoVO.boardId }'/>');"><%= JnitboardController.isLanguage("사진업로드",lang) %></a></div>
						</c:if>
						<textarea id="Jnit_edit" name="content" row="10"></textarea>
					</c:if>
				</td>
			</tr>
			</c:when>
			<%--기본--%>
			<c:otherwise>
			<tr>
				<th scope="row"><label for="${k}"><c:out value="${f[k].lbl}" /></label></th>
				<td>
				<c:choose>
				<%--input--%>
				<c:when test="${f[k].type == 'input'}">
				<input name="${k}" id="${k}" value="" class="input-xxlarge boxstyle ${k}" type="text" <c:out value="${f[k].required?' required':''}"/>>
				</c:when>
				<c:when test="${f[k].type == 'email'}">
				<input name="${k}" id="${k}" value="" class="input-xxlarge boxstyle boardEmail ${k} " type="text" <c:out value="${f[k].required?' required':''}"/>>
				</c:when>
				<%--textarea--%>
				<c:when test="${f[k].type == 'textarea'}">
				<textarea id="${k}" rows="10" name="${k}" class="content input-xxlarge ${k}" <c:out value="${f[k].required?' required':''}"/>></textarea>
				</c:when>
				<%--address--%>
				<c:when test="${f[k].type == 'address'}">
				<input name="${k}" id="${k}" value="" class="input-xxlarge address ${k}" type="text" <c:out value="${f[k].required?' required':''}"/>>
				<input name="tmpAddrDetail" id="tmpAddrDetail" value="" type="hidden">
				</c:when>
				<%--date--%>
				<c:when test="${f[k].type == 'date'}">
				<input name="${k}" id="${k}" value="" class="date ${k}" type="text" data-datetype="yyyy-MM-dd" <c:out value="${f[k].required?' required':''}"/>>
				</c:when>
				<%--datetime--%>
				<c:when test="${f[k].type == 'datetime'}">
				<input name="${k}" id="${k}" value="" class="datetime ${k}" type="text" data-datetype="yyyy-MM-dd hh:mm:ss" <c:out value="${f[k].required?' required':''}"/>>
				</c:when>
				<%--select--%>
				<c:when test="${f[k].type == 'select'}">
				<select name="${k}" id="${k}" class="${k}" >
						<c:forEach var="itm" items="${f[k].item}" varStatus="status">
						<option value="<c:out value="${itm}"/>" <c:out value="${result[k] == itm ? 'selected' : ''}"/>><c:out value="${itm}"/></option>
						</c:forEach>
				</select>
				</c:when>
				<c:when test="${f[k].type == 'check'}">
						<c:forEach var="itm" items="${f[k].item}" varStatus="status">
						<input type="checkbox" name="${k}" id="${k}" value="${itm}" <c:out value="${f[k].required?' required':''}"/> ><lable for="${k}">${itm}</lable>
						</c:forEach>
				</c:when>
				<c:otherwise>
				${f[k].type}<input name="${k}" id="${k}" value="" class="boxstyle ${k}" type="text" <c:out value="${f[k].required?' required':''}"/>>
				</c:otherwise>
				</c:choose>
				</td>
			</tr>
			</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${boardinfoVO.useFile == 1}">
		<tr>
			<th scope="row"><label><%= JnitboardController.isLanguage("첨부",lang) %></label> <span id="upfileAdd"><a href="#none">+</a></span> <span id="upfileDel"><a href="#none">-</a></span></th>
			<td>
				<div id="files_list"></div>
				<div class="upfileWrap">
					<div class="upfileElem"><label for="upfile1" class="blind"><%= JnitboardController.isLanguage("파일",lang) %></label><input type="file" id="upfile1" name="upfile1"></div>
				</div>
			</td>
		</tr>
		
		</c:if>
	</tbody>
</table>
<c:if test="${boardinfoVO.useFile == 2}">
<jsp:include page="/board/fileupload/list.do" flush="false">
	<jsp:param name="boardId"					value="${boardinfoVO.boardId}" />
	<jsp:param name="multiple"					value="true" />
	<jsp:param name="dragDrop"					value="true" />
	<jsp:param name="blacklist"					value="${boardinfoVO.fileBlacklist}" />
	<jsp:param name="maxFileCount"				value="${boardinfoVO.fileLimitCount}" />
	<jsp:param name="maxFileSize"				value="${boardinfoVO.fileLimitSize}MB" />
</jsp:include>
</c:if>
<div class="writebtn">
	<button id="btnSubmit" class="btn"><%= JnitboardController.isLanguage("등록",lang) %></button>
	<a id="linkCancel" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=list&amp;category=${category}" ><%= JnitboardController.isLanguage("취소",lang) %></a>
</div>
<input type="hidden" name="searchCondition" value="<c:out value='${param.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${param.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${param.pageIndex}'/>"/>
<input type="hidden" name="fileuploadList" id="fileuploadList" value=""/>
</form:form>

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

