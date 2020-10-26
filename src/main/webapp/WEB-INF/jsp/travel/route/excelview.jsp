<%@ page language="java" contentType = "application/vnd.ms-excel;charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
				<td style="font-weight: bold; text-align: center; color: red;"><c:out value="총게시물 수"></c:out></td>
				<td style="text-align: center;">${allCnt}</td>
			</c:otherwise>
		</c:choose>		
		<tr style="font-weight: bold; text-align: center; color: red;">			
			<td><c:out value="제목"></c:out></td>
			<td><c:out value="지역"></c:out></td>
			<td><c:out value="작성자"></c:out></td>
			<td><c:out value="조회수"></c:out></td>
			<td><c:out value="추천수"></c:out></td>
			<td><c:out value="이미지경로"></c:out></td>
		</tr>		
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<li>
					<div>
						<td style = "text-align: center;">${result.routTitle}</td>
						<td style = "text-align: center;">${result.routRegion}</td>
						<td style = "text-align: center;">${result.routRegMemberNm}</td>
						<td style = "text-align: center;">${result.routHit}</td>
						<td style = "text-align: center;">${result.routRecomm}</td>
						<td style = "text-align: center;">${result.routThumbPath}</td>
						<tr>
					</div>
				</li>
			</c:forEach>
	</table>
	<script>
		let a = 0;
		function a_stack(){
			a++;
		}
	</script>
</body>
</html>