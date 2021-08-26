<%@ page language="java"
	contentType="application/vnd.ms-excel;charset=euc-kr"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
  table {
    width: 100%;
    border: 1px solid #444444;
  }
  th, td {
    border: 1px solid #444444;
  }
</style>
</head>
<body>
	<table>
		<c:choose>
			<c:when test="${allCnt eq '1' or allCnt eq 1}"></c:when>
			<c:otherwise>
				<td style="font-weight: bold; text-align: center; color: red;"><c:out value="�ѰԽù� ��"></c:out></td>
				<td style="text-align: center;">${allCnt}</td>
			</c:otherwise>
		</c:choose>				
		<tr style="font-weight: bold; text-align: center; color: red;">
			<td><c:out value="����"></c:out></td>
			<td><c:out value="ī�װ�"></c:out></td>
			<td><c:out value="�ּ�"></c:out></td>
			<td><c:out value="����"></c:out></td>
			<td><c:out value="Ŭ����"></c:out></td>
			<td><c:out value="���ƿ��"></c:out></td>
			<td><c:out value="�̹������"></c:out></td>
		</tr>

		<c:forEach var="result" items="${resultList}" varStatus="status">
			<li>
				<div>
				<tr>
					<td style = "text-align: center;">${result.destTitle}</td>
					<td style = "text-align: center;">${result.destCategory}</td>
					<td style = "text-align: center;">${result.destAddress}</td>
					<td style = "text-align: center;">${result.destRegion}</td>
					<td style = "text-align: center;">${result.destClipPoint}</td>
					<td style = "text-align: center;">${result.destRecommPoint}</td>
					<c:choose>
						<c:when test="${result.destImgPath eq '' or result.destImgPath eq null}"><td style = "text-align: center;">�̹�����ΰ� �����ϴ�.</td></c:when>
						<c:otherwise>
							<td style = "text-align: center;">${result.destImgPath}</td>
						</c:otherwise>
					</c:choose>
			</tr>
			</div>
			</li>
		</c:forEach>

	</table>
</body>
</html>