<%@ page language="java" contentType = "application/vnd.ms-excel;charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<table>
		<tr>
		<td><c:out value="����"></c:out></td>
		<td><c:out value="����"></c:out></td>
		<td><c:out value="�ۼ���"></c:out></td>
		<td><c:out value="��ȸ��"></c:out></td>
		<td><c:out value="��õ��"></c:out></td>
		</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<li>
					<div>
						<td>${result.routTitle}</td>
						<td>${result.routRegion}</td>
						<td>${result.routRegMemberNm}</td>
						<td>${result.routHit}</td>
						<td>${result.routRecomm}</td>
						<tr>
					</div>
				</li>
			</c:forEach>
	</table>
</body>
</html>