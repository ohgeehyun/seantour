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
<%
  response.setHeader("Content-Type", "application/vnd.ms-xls; charset=euc-kr");

  response.setHeader("Content-Disposition", "inline; filename=mbrlist.xls");
%>

<html>
<head>
<style type="text/css">
	td { mso-number-format:\@ }
</style>
</head>
<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	<table class="table table-bordered table-striped table-hover"summary="회원 리스트" border="1">
		<thead>
			<tr>				
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호/회사번호/이메일</th>				
				<th>부서</th>
				<th>사업자번호</th>
				<th>회사명</th>
				<th>직책</th>
				<th>담당업무</th>
				<th>유형</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			 		<tr>
						<td><c:out value="${result.mbrLogin}"/></a></td>
						<td align="center"><c:out value="${result.mbrNm}"/></a></td>
						<td>
							<c:out value="${result.tel}"/><br />
							<c:out value="${result.mobile}"/><br />
							<c:out value="${result.email}"/>
						</td>
						<td><c:out value="${result.orgNm}"/></td>
						<td><c:out value="${result.establishment }"/></td>
						<td><c:out value="${result.groupTitle }"/></td>
						<td><c:out value="${result.gradeNm }"/></td>
						<td><c:out value="${result.workContents}"/></td>
						<td><c:out value="${result.typeNm}"/></td>
						<td><fmt:formatDate value="${result.created }" pattern="yyyy-MM-dd" /></td>
					</tr>
			</c:forEach>
		</tbody>
	</table>
</form:form>
</body>
</html>