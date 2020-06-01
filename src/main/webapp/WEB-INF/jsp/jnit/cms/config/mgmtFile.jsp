<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javascript">
<!--

function Jnit_defualtFile_save(){
	frm = document.getElementById("fileList");
	frm.action = "<c:url value='/cms/config/mgmt/file/save.do'/>";
	frm.submit();
}
//->
</script>
<c:if test="${!empty msg }">
<script type="text/javascript">
<!--
alert("파일리스트에 변경이 있어 ${msg} 리스트에서 제외 되었습니다.");
//-->
</script>
</c:if>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form id="fileList" action="?" method="post">
			<input type="hidden" name="size" value="${size }" />
			<input type="hidden" name="mgmtType" value="${mgmtType }" />
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<a href="<c:url value="/cms/mgmt/list.do?mgmtType=${mgmtType }"/>" class="btn btn-small"><i class="icon-repeat"></i> 돌아가기</a>
							<a href="javascript:Jnit_defualtFile_save();" class="btn btn-warning btn-small"><i class="icon-ok-sign"></i> 저장</a>
							<c:if test="${!empty msg || !empty msg2  }"><font color="red">저장버튼을 눌러주시기 바랍니다.</font></c:if>							
						</div>
						<div class="widget-content nopadding">
							<table class="table table-board">
							<c:if test="${!empty msg }">
							<tr>
								<th>제외 대상</th>
								<td>${msg }</td>
							</tr>
							</c:if>
							<c:if test="${!empty msg2 }">
							<tr>
								<th>추가 리스트</th>
								<td>${msg2 }</td>
							</tr>
							</c:if>
							</table>
							<table class="table table-bordered">							
								<tr>
									<th>이름</th>
									<th>정렬</th>									
								</tr>
								<c:if test="${empty resultList }">
									<tr>
										<td colspan="2">파일이 없습니다.</td>
									</tr>
								</c:if>
								<c:forEach var="result" items="${resultList }" varStatus="status">
									<tr>
										<td>
											<c:out value="${result }"/>
											<input type="hidden" name="filename${status.count }" value="${result }" />
										</td>
										<td><input type="text" name="sort${status.count }" value="${JSONn[result] }"/></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<div class="widget-box">
						<table class="table table-board">
							<tr>
								<th>
									- <strong>사이트 생성시</strong> ${mgmtType } 파일의 노출될 순서 목록을 정합니다. -
								</th>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>