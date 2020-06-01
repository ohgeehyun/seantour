<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header_skeleton.jsp" %>

<style>

span.linkpath {
	display:block;
}

</style>
<div class="content_skeleton container-fluid">
<%-- Contents Start --%>
	<div class="row-fluid">
		<div class="span12">
			<div class="widget-box">
				<form:form commandName="jnitcmstplVO" action="${ctxRoot}/cms/file/save.do">
				<input type="hidden" name="fileSave" value="fileSave" />
				<div class="widget-title">
					<span class="icon"><i class="icon-cog"></i></span>
					<a class="btn btn-small" href="javascript:location.reload();">
						<i class="icon icon-zoom-in"></i> 새로고침
					</a>
				</div>
				<div class="widget-content nopadding">
					<table class="table table-bordered table-striped th_left" summary="<c:out value="${file.name}"/>">
				        <tbody>
				            <tr>
				                <th width="30%"><font color="red"></font> 파일</th>
				                <td>
				                	<span class="filename"><c:out value="${file.name}"/></span>
				                </td>
				                <th width="30%"><font color="red"></font> 크기</th>
				                <td>
				                	<span class="filesize"><fmt:formatNumber maxFractionDigits="1" minFractionDigits="1" value="${file.size}" />k</span>
				                </td>
				            </tr>
				            <tr>
				                <th width="30%"><font color="red"></font> 형식</th>
				                <td>
				                	<span class="mimetype"><c:out value="${file.mime}"/></span>
				                </td>
				                <th width="30%"><font color="red"></font> 수정일시</th>
				                <td>
				                	<span class="filedate"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${file.date}" /></span>
				                </td>
				            </tr>
				            <tr>
				                <th width="30%"><font color="red"></font> 링크경로</th>
				                <td colspan="3">
				                	<span class="linkpath">
				                		<a href="<c:url value="${file.linkpath}"/>" target="_blank"><c:url value="${file.linkpath}"/></a>
				                	</span>                	
				                </td>
				            </tr>            
				        </tbody>
				     </table>
				     
				     <table class="table table-bordered table-striped th_left" summary="미리보기">
				        <tbody>
				            <tr>
				                <td align="center"><a href="<c:url value="${file.linkpath}"/>" target="_blank"><img src="<c:url value="${file.linkpath}"/>" border="0" alt="새창" /></a></td>
				            </tr>
				        </tbody>
				     </table>
				</div>
			</form:form>
			</div>
		</div>		
		<%-- Contents End --%>
	</div>
</div>



<%@ include file="/WEB-INF/jsp/jnit/_common/footer_skeleton.jsp" %>