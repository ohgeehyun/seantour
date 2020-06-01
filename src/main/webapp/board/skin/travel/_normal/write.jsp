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
<%//spring에서 multipart로 넘어온 데이터는 한번 controller를 타고 나면 초기화 시킴.따라서 직접 .do로 호출하고
retUrl에 현재 jsp의 URL을 넘겨 board.do에서 처리된 다음 다시 jsp로 리다이렉트 되도록 처리%>
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
		
          
      
        <div id="content" class="cont_wrap ">
      
            <div class="cont_body">

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

	            <div class="inr">

					<div class="reviews_write">
						<c:if test="${boardinfoVO.useCategory == '1' && empty fixedCategory}">
							<dl>
								<dt><label for="category"><c:out value="${lbl.category}" /></label></dt>
								<dd>
									<select name="category" class="category" title="<c:out value="${lbl['category']}" /> <%= JnitboardController.isLanguage("선택",lang) %>">
										<option value=""><%= JnitboardController.isLanguage("전체",lang) %></option>
										<c:forEach var="category" items="${categoryList}" varStatus="status">
										<option value="<c:out value="${category}"/>" <c:out value="${param.category == category ? 'selected' : ''}"/>><c:out value="${category}"/></option>
										</c:forEach>
									</select>
								</dd>
							</dl>
						</c:if>
						<c:if test="${isAdmin == true && !empty getTmp1 }">	
							<dl id="iconshow">
								<dt><%= JnitboardController.isLanguage("아이콘 강제 노출",lang) %></dt>
								<dd>
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
								</dd>
							</dl>
						</c:if>
					
						<c:if test="${isAdmin == true && boardinfoVO.useLatestlist == '1' }">
							<dl>
								<dt><label for="tmp3"></label><%= JnitboardController.isLanguage("최근게시물 표시",lang) %></dt>
								<dd><input type="checkbox" name="tmp3" id="tmp3" value="1"></dd>
							</dl>
						</c:if>
						<c:if test="${isAdmin == true && boardinfoVO.useNotice == '1'}">
							<dl>
								<dt><label for="isNotice"><%= JnitboardController.isLanguage("공지글",lang) %></label></dt>
								<dd><input type="checkbox" name="isNotice" id="isNotice" value="1" /></dd>
							</dl>
						</c:if>
						<c:if test="${boardinfoVO.useSecret == '1' && loginVO.mbrId != null}">
							<dl>
								<dt><label for="isSecret"><%= JnitboardController.isLanguage("비밀글",lang) %></label></dt>
								<dd><input type="checkbox" name="isSecret" id="isSecret" value="1" /></dd>
							</dl>
						</c:if>
						<c:forEach var="k" items="${sIdx}" varStatus="s">
							<c:choose>
							<%--adminField--%>
							<c:when test="${k == 'writer'}">
							<c:if test="${isAdmin == true}">
							<dl>
								<dt><label for="${k}"><c:out value="${f[k].lbl}" /></label></dt>
								<dd><input name="${k}" id="${k}" class="w100 boxstyle ${k} input-xxlarge" type="text" value="<c:out value='${loginVO.mbrNm}'/>"/></dd>
							</dl>
							</c:if>
							</c:when>
							<c:when test="${ k == 'hit'}">
							<c:if test="${isAdmin == true}">
							<dl>
								<dt><label for="${k}"><c:out value="${f[k].lbl}" /></label></dt>
								<dd><input name="${k}" value="" id="${k}" class="w100 boxstyle ${k} input-xxlarge" type="text" /></dd>
							</dl>
							</c:if>
							</c:when>
							<%--created--%>
							<c:when test="${k == 'created'}">
							<c:if test="${isAdmin == true}">
							<dl>
								<dt><label for="${k}"><c:out value="${f[k].lbl}" /></label></dt>
								<dd><input name="${k}" id="${k}" class="w100 input-xxlarge boxstyle  ${k} datetime" type="text" data-datetype="yyyy-MM-dd hh:mm:ss"/></dd>
							</dl>
							</c:if>
							</c:when>
							<%--title--%>
							<c:when test="${k == 'title'}">
							<dl>
								<dt><label for="${k}"><c:out value="${f[k].lbl}" /></label></dt>
								<dd><input name="${k}" value="" id="${k}" class="w100 input-xxlarge boxstyle ${k}" type="text" required/></dd>
							</dl>
							<%--비회원작성자 --%>
							<c:if test="${boardinfoVO.anonPermWrite == '1' && loginVO.mbrId == null}">
							<dl>
								<dt><label for="writer"><%= JnitboardController.isLanguage("작성자",lang) %></label></dt>
								<dd><input name="writer" id="writer" class="w100 input-xxlarge boxstyle ${k}" required type="text" value="<c:out value='${loginVO.mbrNm}'/>"/></dd>
							</dl>
							<dl>
								<dt><label for="<%= JnitboardController.isLanguage("비밀번호",lang) %>"><%= JnitboardController.isLanguage("비밀번호",lang) %></label></dt>
								<dd><input name="password" value="" id="password" class="input-xxlarge boxstyle ${k}" required type="password" /></dd>
							</dl>
							</c:if>
							</c:when>
							<%--content--%>
							<c:when test="${k == 'content'}">
							<dl class="textarea_cont">
								<%-- <dt><label for="${k}"><c:out value="${f[k].lbl}" /></label></dt> --%>
								<dd>
									<c:if test="${boardinfoVO.useWyswyg != 1}">
										<textarea id="${k}" class="${k} content input-xxlarge boxstyle w100" rows="10" cols="30" name="${k}" required style="overflow-x:hidden;"></textarea>
									</c:if>
									<c:if test="${boardinfoVO.useWyswyg == 1}">						
										<c:if test="${boardinfoVO.useImage == 1 && boardinfoVO.useWyswygType == 'tinymce'}">
											<div class="editTinymceImages"><a href="javascript:Jnit_img_upload('<c:url value='/broad/pupup.do?boardId=${boardinfoVO.boardId }'/>');"><%= JnitboardController.isLanguage("사진업로드",lang) %></a></div>
										</c:if>
										<textarea id="Jnit_edit" name="content" row="10"></textarea>
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
								<input name="${k}" id="${k}" value="" class="w100 input-xxlarge boxstyle ${k}" type="text" <c:out value="${f[k].required?' required':''}"/>>
								</c:when>
								<c:when test="${f[k].type == 'email'}">
								<input name="${k}" id="${k}" value="" class="w100 input-xxlarge boxstyle boardEmail ${k} " type="text" <c:out value="${f[k].required?' required':''}"/>>
								</c:when>
								<%--textarea--%>
								<c:when test="${f[k].type == 'textarea'}">
								<textarea id="${k}" rows="10" name="${k}" class="content input-xxlarge ${k}" <c:out value="${f[k].required?' required':''}"/>></textarea>
								</c:when>
								<%--address--%>
								<c:when test="${f[k].type == 'address'}">
								<input name="${k}" id="${k}" value="" class="w100 input-xxlarge address ${k}" type="text" <c:out value="${f[k].required?' required':''}"/>>
								<input name="tmpAddrDetail" id="tmpAddrDetail" value="" type="hidden">
								</c:when>
								<%--date--%>
								<c:when test="${f[k].type == 'date'}">
								<input name="${k}" id="${k}" value="" class="w100 date ${k}" type="text" data-datetype="yyyy-MM-dd" <c:out value="${f[k].required?' required':''}"/>>
								</c:when>
								<%--datetime--%>
								<c:when test="${f[k].type == 'datetime'}">
								<input name="${k}" id="${k}" value="" class="w100 datetime ${k}" type="text" data-datetype="yyyy-MM-dd hh:mm:ss" <c:out value="${f[k].required?' required':''}"/>>
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
								${f[k].type}<input name="${k}" id="${k}" value="" class="w100 boxstyle ${k}" type="text" <c:out value="${f[k].required?' required':''}"/>>
								</c:otherwise>
								</c:choose>
								</dd>
							</dl>
							</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${boardinfoVO.useFile == 1}">
						<dl class="attach">
							<dt><label><%= JnitboardController.isLanguage("첨부",lang) %></label> <span id="upfileAdd"><a href="#none">+</a></span> <span id="upfileDel"><a href="#none">-</a></span></dt>
							<dd>
								<div id="files_list"></div>
								<div class="upfileWrap">
								   <!--  -->
									<div class="upfileElem"><label for="upfile1" class="blind"><%= JnitboardController.isLanguage("파일",lang) %></label><input type="file" id="upfile1" name="upfile1"></div>
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

				</div>	
				<div class="btnArea tac">
	           		<button id="btnSubmit" class="button border"><%= JnitboardController.isLanguage("등록",lang) %></button>
	           		<a id="linkCancel" class="button border" href="?boardId=${boardinfoVO.boardId}&amp;mode=list&amp;category=${category}" ><%= JnitboardController.isLanguage("취소",lang) %></a>
				</div>

				<input type="hidden" name="searchCondition" value="<c:out value='${param.searchCondition}'/>"/>
				<input type="hidden" name="searchKeyword" value="<c:out value='${param.searchKeyword}'/>"/>
				<input type="hidden" name="pageIndex" value="<c:out value='${param.pageIndex}'/>"/>
				<input type="hidden" name="fileuploadList" id="fileuploadList" value=""/>
			</form:form>
			<script>
			$(function(){
				var uploadFile = $('.fileBox .uploadBtn');
				uploadFile.on('change', function(){
					if(window.FileReader){
						var filename = $(this)[0].files[0].name;
					} else {
						var filename = $(this).val().split('/').pop().split('\\').pop();
					}
					$(this).siblings('.fileName').val(filename);
				});
			});
			</script>
			</div>  
		</div>
	</div>    
	</div>    
    <!-- End of middle -->