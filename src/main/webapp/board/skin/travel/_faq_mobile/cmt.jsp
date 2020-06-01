<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="jnit.board.*" %>
<% String lang = JnitboardController.lang;  pageContext.setAttribute("lf", "\n"); %>
<c:if test="${!empty message }">
<script type="text/javascript">
<!--
alert("${message}");
//-->
</script>
</c:if>
<form:form commandName="boardcmtVO" name="bbsCmtEditForm" id="bbsCmtEditForm" method="post" enctype="multipart/form-data">	
	<input type="hidden" id="cmtId" name="cmtId" value="" />
	<%--cmtEdit, cmtDelete --%>
	<ul id="cmt_list" class="cmtlist">
		<c:forEach var="cmt" items="${cmtList}" varStatus="status">			
			<li>
				<div class="cmt_content">
					<div class="cmt_h">
						<div class="writer_nm">
							<span class="cmt_writer"><c:out value="${cmt.mbrNm}" /></span>
							<span class="cmt_date">
								<fmt:parseDate var="dateFmt" value="${cmt.created}" pattern="yyyy-MM-dd HH:mm:ss" />
								<fmt:formatDate value="${dateFmt }" pattern="yyyy-MM-dd HH:mm:ss" />
							</span>
						</div>						
						<c:if test="${isAdmin == true || (myId == permMap[cmt.cmtId])}">
							<div class="cmt_btn">
								<div class="edit_btn">
									<a href="#" class="cmt_edit"><%= JnitboardController.isLanguage("수정",lang) %></a>
								</div>
								<div class="edit_cancelBtn" style="display:none;">
									<a href="#" class="cmt_edit_cancel" ><%= JnitboardController.isLanguage("수정",lang) %> <%= JnitboardController.isLanguage("취소",lang) %></a>
								</div>
								<span class="pipe_line">|</span>
								<div class="deleteBtn"> 
									<a href="javascript:Jnit_boardCmtDel('${boardinfoVO.boardId }',${result.id },'${cmt.cmtId }','<c:url value='/board/ajax/cmt.do'/>','delete');" class="Jnit_boardCmtDel" ><%= JnitboardController.isLanguage("삭제",lang) %></a>
								</div>
							</div>
						</c:if>
					</div>
					
					<c:if test="${isAdmin == true || (myId == permMap[cmt.cmtId])}">
						<div class="editText" style="display:none;">
							<table class="bbsCmt table table-bordered" summary="<c:out value="${boardinfoVO.boardTitle}" /><%= JnitboardController.isLanguage("의 덧글입력 테이블입니다.",lang) %>">
								<caption><c:out value="${boardinfoVO.boardTitle}" /><%= JnitboardController.isLanguage("덧글 수정",lang) %></caption>
								<tbody>
									<tr>
										<td class="cmt_text">
											<c:choose>
												<c:when test="${DBType == 'ORACLE' || DBType == 'TIBERO'}">
													<textarea id="cmtEditarea_${cmt.cmtId }" name="cmtEditarea_${cmt.cmtId }" class="cmtEditarea content content input-xxlarge" rows="2" required onKeyUp="javascript:fnByte(this,'2000','${cmt.cmtId }')"><c:out value="${cmtMap[cmt.cmtId]}" /></textarea>
													<span id="byteInfo_${cmt.cmtId }">0</span>/2000Byte
												</c:when>
												<c:otherwise>
													<textarea id="cmtEditarea_${cmt.cmtId }" name="cmtEditarea_${cmt.cmtId }" class="cmtEditarea content content input-xxlarge" rows="2" required onKeyUp="javascript:fnByte(this,'2000','${cmt.cmtId }')"><c:out value="${cmt.cmtText}" /></textarea>
													<span id="byteInfo_${cmt.cmtId }">0</span>/2000Byte
												</c:otherwise>
											</c:choose>
										</td>
										<td class="cmt_btn">
											<a href="javascript:Jnit_boardCmtEdit('${boardinfoVO.boardId }',${result.id },'${cmt.cmtId }','<c:url value='/board/ajax/cmt.do'/>');" class="Jnit_boardCmtEdit" >
												<%= JnitboardController.isLanguage("덧글 수정",lang) %>
											</a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</c:if>
					<p class="board_comment">
						<span class="cmt_body">
							<c:choose>
								<c:when test="${DBType == 'ORACLE' || DBType == 'TIBERO'}">
									<c:out value="${fn:replace(cmtMap[cmt.cmtId],lf,'<br />')}" escapeXml="false" />
								</c:when>
								<c:otherwise>
									<c:out value="${fn:replace(cmt.cmtText,lf,'<br />')}" escapeXml="false" />
								</c:otherwise>
							</c:choose>
						</span>
					</p>
				</div>
			</li>
		</c:forEach>
	</ul>
</form:form>