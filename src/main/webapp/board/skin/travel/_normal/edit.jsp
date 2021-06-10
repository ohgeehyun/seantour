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

<body>
<div id="wrap" style="position:static;">   	
  
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

				<input type="hidden" name="mode" value="proc" />
				<input type="hidden" name="proc" value="edit" />
				<input type="hidden" name="boardId" value="<c:out value="${boardinfoVO.boardId}"/>" />
				<input type="hidden" name="cntId" value="<c:out value="${result.id}"/>" />
				<c:if test="${boardinfoVO.useCategory == '1' && not empty fixedCategory}">
				<input type="hidden" name="category" value="${fixedCategory}" />
				</c:if>

	            <div class="inr">

					<div class="reviews_write">
					<c:if test="${boardinfoVO.useCategory == '1' && empty fixedCategory}">
						<dl>
							<dt><label for="category"><c:out value="${lbl.category}" /></label></dt>
							<td><select name="category" class="category" title="<c:out value="${lbl['category']}" /> <%= JnitboardController.isLanguage("선택",lang) %>">
									<option value=""><%= JnitboardController.isLanguage("전체",lang) %></option>
									<c:forEach var="category" items="${categoryList}" varStatus="status">
									<option value="<c:out value="${category}"/>" <c:out value="${result.category == category ? 'selected' : ''}"/>><c:out value="${category}"/></option>
									</c:forEach>
							</select></dd>
						</dl>
					</c:if>
					<c:if test="${isAdmin == true && !empty getTmp1 }">
						<dl id="iconshow" style="display: none;">
							<dt><%= JnitboardController.isLanguage("아이콘 강제 노출",lang) %></dt>
							<dd>
								<c:forEach var="iconJSON" items="${getTmp1 }">
									 <c:set var="iconkey" value="${fn:substring(iconJSON,0,fn:indexOf(iconJSON,'='))}" />
									 <c:if test="${getTmp1[iconkey].type == '3' }">
									 	<c:catch var="e_icon"><c:set var="icon_select" value="${boardTmp4[iconkey] == 'Y' ? 'checked' : '' }" /></c:catch>
										 <input type="checkbox" name="${iconkey }_tmp4" value="Y" ${icon_select } />
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
							</dd>
						</dl>
					</c:if>
					<c:if test="${isAdmin == true && boardinfoVO.useLatestlist == '1' }">
						<dl>
							<dt><label for="tmp3"></label><%= JnitboardController.isLanguage("최근게시물 표시",lang) %></dt>
							<dd><input type="checkbox" name="tmp3" id="tmp3" value="1" <c:out value="${result.tmp3 == '1' ? 'checked' : '' }"/>></dd>
						</dl>
					</c:if>
					<c:if test="${isAdmin == true && boardinfoVO.useNotice == '1'}">
						<dl>
							<dt><label for="isNotice"><%= JnitboardController.isLanguage("공지글",lang) %></label></dt>
							<dd><input type="checkbox" name="isNotice" id="isNotice" value="1" <c:out value="${result.isNotice == '1' ? 'checked' : ''}"/>/></dd>
						</dl>
					</c:if>
					<c:if test="${boardinfoVO.useSecret == '1' && loginVO.mbrId != null}">
						<dl>
							<dt><label for="isSecret"><%= JnitboardController.isLanguage("비밀글",lang) %></label></dt>
							<dd><input type="checkbox" name="isSecret" id="isSecret" value="1" <c:out value="${result.isSecret == '1' ? 'checked' : ''}"/>/></dd>
						</dl>
					</c:if>
					<c:forEach var="k" items="${sIdx}" varStatus="s">
						<c:choose>
						<%--no--%>
						<c:when test="${k == 'no'}">
						</c:when>
						<%--adminField--%>
						<c:when test="${k == 'writer' || k == 'hit'}">
						<c:if test="${isAdmin == true}">
						<dl>
							<dt><label for="${k}"><c:out value="${f[k].lbl}" /></label></dt>
							<dd><input name="${k}" value="<c:out value="${result[k]}" />" id="${k}" class="w100 boxstyle ${k} input-xxlarge" type="text" /></dd>
						</dl>
						</c:if>
						</c:when>
						<%--created--%>
						<c:when test="${k == 'created'}">
						<c:if test="${isAdmin == true}">
						<dl>
							<dt><label for="${k}"><c:out value="${f[k].lbl}" /></label></dt>
							<dd><input name="${k}" value="<fmt:formatDate value="${result[k]}" pattern="yyyy-MM-dd HH:mm:ss" />" id="${k}" class="w100 boxstyle ${k} datetime" type="text" data-datetype="yyyy-MM-dd hh:mm:ss" required/></dd>
						</dl>
						</c:if>
						</c:when>
						<%--title--%>
						<c:when test="${k == 'title'}">
						<dl>
							<dt><label for="${k}"><c:out value="${f[k].lbl}" /></label></dt>
							<dd><input name="${k}" value="<c:out value="${result[k]}" />" id="${k}" class="w100 boxstyle ${k} input-xxlarge" type="text" required/></dd>
						</dl>
						<%--비회원작성자 --%>
						<c:if test="${boardinfoVO.anonPermWrite == '1' && isAdmin != true && isMine != true}">
						<dl>
							<dt><label for="writer"><%= JnitboardController.isLanguage("작성자",lang) %></label></dt>
							<dd><input name="writer" value="<c:out value="${result.writer}" />" id="writer" class="input-xxlarge w100 boxstyle ${k}" required type="text" /></dd>
						</dl>
						<dl>
							<dt><label for="<%= JnitboardController.isLanguage("비밀번호",lang) %>"><%= JnitboardController.isLanguage("비밀번호",lang) %></label></dt>
							<dd><input name="password" value="" id="password" class="input-xxlarge w100 boxstyle ${k}" required type="password" /></dd>
						</dl>
						</c:if>
						</c:when>
						<%--content--%>
						<c:when test="${k == 'content'}">
						<dl>
							<%-- <dt><label for="${k}"><c:out value="${f[k].lbl}" /></label></dt> --%>
							<dd colspan="2" class="board_td_content">
								<c:if test="${boardinfoVO.useWyswyg != 1}">
									<textarea id="${k}" class="${k} content input-xxlarge boxstyle w100" rows="10" cols="30" name="${k}" required style="overflow-x:hidden;"><c:out value="${result[k]}" /></textarea>
								</c:if>
								<c:if test="${boardinfoVO.useWyswyg == 1}">
									<c:if test="${boardinfoVO.useImage == 1 && boardinfoVO.useWyswygType == 'tinymce'}">
										<div class="editTinymceImages"><a href="javascript:Jnit_img_upload('<c:url value='/broad/pupup.do?boardId=${boardinfoVO.boardId }'/>');"><%= JnitboardController.isLanguage("사진업로드",lang) %></a></div>
									</c:if>
									<textarea id="Jnit_edit" name="content" row="10"><c:out value="${result.content }" escapeXml="false" /></textarea>
								</c:if>
							</dd>
						</dl>
						</c:when>
						<%--기본--%>
						<c:otherwise>
						<dl>
							<dt><label for="${k}"><c:out value="${f[k].lbl}" /></label></dt>
							<dd>
							<c:choose>
							<%--input--%>
							<c:when test="${f[k].type == 'input'}">
							<input name="${k}" id="${k}" value="<c:out value="${result[k]}" />" class="w100 boxstyle ${k} input-xxlarge" type="text" <c:out value="${f[k].required?' required':''}"/>>
							</c:when>
							<c:when test="${f[k].type == 'email'}">
							<input name="${k}" id="${k}" value="<c:out value="${result[k]}" />" class="input-xxlarge w100 boxstyle boardEmail ${k} " type="text" <c:out value="${f[k].required?' required':''}"/>>
							</c:when>
							<%--textarea--%>
							<c:when test="${f[k].type == 'textarea'}">
							<textarea id="${k}" rows="10" name="${k}" class="${k} input-xxlarge w100" <c:out value="${f[k].required?' required':''}"/>><c:out value="${result[k]}" /></textarea>
							</c:when>
							<%--address--%>
							<c:when test="${f[k].type == 'address'}">
							<input name="${k}" id="${k}" value="<c:out value="${result[k]}" />" class="w100 address ${k} input-xxlarge" type="text" <c:out value="${f[k].required?' required':''}"/>>
							<input name="tmpAddrDetail" id="tmpAddrDetail" value="" type="hidden">
							</c:when>
							<%--date--%>
							<c:when test="${f[k].type == 'date'}">
							<input name="${k}" id="${k}" value="<fmt:formatDate value="${result[k]}" pattern="yyyy-MM-dd" />" class="w100 date ${k}" type="text" data-datetype="yyyy-MM-dd" <c:out value="${f[k].required?' required':''}"/>>
							</c:when>
							<%--datetime--%>
							<c:when test="${f[k].type == 'datetime'}">
							<input name="${k}" id="${k}" value="<fmt:formatDate value="${result[k]}" pattern="yyyy-MM-dd HH:mm:ss" />" class="w100 datetime ${k}" type="text" data-datetype="yyyy-MM-dd HH:mm:ss" <c:out value="${f[k].required?' required':''}"/>>
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
							<input name="${k}" id="${k}" value="<c:out value="${result[k]}" />" class="w100 boxstyle ${k} input-xxlarge" type="text" <c:out value="${f[k].required?' required':''}"/>>
							</c:otherwise>
							</c:choose>
							</dd>
						</dl>
						</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${boardinfoVO.useFile == 1}">
					<dl>
						<dt><label><%= JnitboardController.isLanguage("첨부",lang) %></label> <span id="upfileAdd"><a href="#none">+</a></span> <span id="upfileDel"><a href="#none">-</a></span></dt>
						<dd>
						<c:if test="${not empty fileList}" >
							<div id="files_list">
							<c:forEach var="bbsfile" items="${fileList}" varStatus="status">
								<span class="file"><label for="delFile" class="blind"><a href="<c:url value="${bbsfile.fileUrl }"/>" target="_blank"><c:out value="${bbsfile.fileOnm}"/></a></label><input type="checkbox" id="delFile" name="delFile" value="<c:out value="${bbsfile.fileId}"/>" /><%= JnitboardController.isLanguage("삭제",lang) %> (<img src="<c:url value="/board/_common/img/icoFile2.gif" />" alt="<%= JnitboardController.isLanguage("파일삭제",lang) %>" /><c:out value="${bbsfile.fileOnm}"/>)</span><br />
							</c:forEach>
							</div>
						</c:if>
							<div class="upfileWrap">
								<div class="upfileElem"><label for="upfile1" class="blind"><%= JnitboardController.isLanguage("파일",lang) %></label> <input type="file" id="upfile1" name="upfile1"></div>
							</div>
						</dd>
					</dl>
					</c:if>

				</div>

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

				<div class="btnArea tac">
					<input type="submit" id="btnSubmit" class="button border" value="<%= JnitboardController.isLanguage("등록",lang) %>" />
					<a id="btnCancel" class="button border" href="?boardId=${boardinfoVO.boardId}&amp;mode=list&amp;category=${category}"><%= JnitboardController.isLanguage("취소",lang) %></a>
				</div>

				<input type="hidden" name="searchCondition" value="<c:out value='${param.searchCondition}'/>"/>
				<input type="hidden" name="ㅣbtnSubmitsearchKeyword" value="<c:out value='${param.searchKeyword}'/>"/>
				<input type="hidden" name="pageIndex" value="<c:out value='${param.pageIndex}'/>"/>
				<input type="hidden" name="fileuploadList" id="fileuploadList" value=""/>
			</form:form>

			</div>  
		</div>
	</div>    
    <!-- End of middle -->
	<!-- footer -->
   <!-- End of footer -->
</div>

</body>
</html>