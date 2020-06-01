<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header_skeleton.jsp" %>

<div class="content_skeleton container-fluid">
<%-- Contents Start --%>
	<div class="row-fluid">
		<div class="span12">
			<div class="widget-box">
				<form:form commandName="jnitcmstplVO" action="${ctxRoot}/cms/file/save.do">
				<input type="hidden" name="fileSave" value="fileSave" />
				<div class="widget-title">
					<span class="icon"><i class="icon-cog"></i></span>
					<button type="submit" class="btn btn-small"><i class="icon icon-ok"></i> 저장</button>
					<a class="btn btn-small" href="<c:url value="${file.linkpath}"/>" target="_blank" title="새 창으로 열립니다.">
						<i class="icon icon-zoom-in"></i> 새창으로
					</a>
				</div>
				<div class="widget-content nopadding">
					<table class="table table-bordered table-striped th_left" summary="파일설정">
						<tbody>
							<tr>
								<th>파일</th>
								<td><span class="filename"><c:out value="${file.name}"/></span></td>
								<th>크기</th>
								<td><span class="filesize"><fmt:formatNumber maxFractionDigits="1" minFractionDigits="1" value="${file.size}" />k</span></td>
							</tr>
							<tr>
								<th>형식</th>
								<td><span class="mimetype"><c:out value="${file.mime}"/></span></td>
								<th>수정일시</th>
								<td><span class="filedate"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${file.date}" /></span></td>
							</tr>
							<tr>
								<th>링크경로</th>
								<td colspan="3"><a href="<c:url value="${file.linkpath}"/>" target="_blank"><c:url value="${file.linkpath}"/></a></td>
							</tr>
						</tbody>
					</table>
					<input type="hidden" name="screenMode" value="" />
					<input type="hidden" name="siteId" value="" />
					<input type="hidden" name="tplId" value="" />
					<input type="hidden" name="sitePath" value="<c:out value="${sitePath}" />" />
					<input type="hidden" name="searchKeyword" value="<c:out value="${param.bindType}" />,<c:out value="${param.dirType}" />,<c:out value="${param.fileName}" />" />	
					<div class="tplSrcBox">
					<p><strong>ㆍ 소스 편집</strong></p>
					<form:textarea path="tplSrc" rows="20" style="width:95%" escape="false"/><br />
					<form:errors path="tplSrc" />
					</div>
				</div>
				</form:form>
			</div>
		</div>
	</div>
<%-- Contents End --%>
</div>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer_skeleton.jsp" %>