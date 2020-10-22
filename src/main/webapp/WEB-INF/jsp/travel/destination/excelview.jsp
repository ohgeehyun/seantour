<%@ page language="java"
	contentType="application/vnd.ms-excel;charset=euc-kr"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<table>
		<tr>
			<td><c:out value="力格"></c:out></td>
			<td><c:out value="墨抛绊府"></c:out></td>
			<td><c:out value="林家"></c:out></td>
			<td><c:out value="瘤开"></c:out></td>
		</tr>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<li>
				<div>
					<td>${result.destTitle}</td>
					<td>${result.destCategory}</td>
					<td>${result.destAddress}</td>
					<td>${result.destRegion}</td>
					<tr>
				</div>
			</li>
		</c:forEach>
	</table>
</body>
</html>