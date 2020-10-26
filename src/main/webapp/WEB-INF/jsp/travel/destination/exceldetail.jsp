<%@ page language="java" contentType = "application/vnd.ms-excel;charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
  table {
    width: 10%;
    border: 1px solid #444444;
  }
   th, td {
    border: 1px solid #444444;
  }
</style>
</head>
<body>
	<table>		
		<tr style="font-weight: bold; text-align: center; color: red;">			
			<td><c:out value="�̸�"></c:out></td>
			<td><c:out value="����"></c:out></td>
			<td><c:out value="�ּ�"></c:out></td>
			<td><c:out value="����ó"></c:out></td>
			<td><c:out value="Ȩ������"></c:out></td>
			<td><c:out value="����������"></c:out></td>
			<td><c:out value="����� ��Ÿ�1"></c:out></td>
			<td><c:out value="����� ��Ÿ�2"></c:out></td>
			<td><c:out value="����� ��Ÿ�3"></c:out></td>
			<td><c:out value="����� ���ڸ�1"></c:out></td>
			<td><c:out value="����� ���ڸ�2"></c:out></td>
			<td><c:out value="����� ���ڸ�3"></c:out></td>
		</tr>		
		
				<li>
					<div>
						<td style = "text-align: center;">${travelDestination.destTitle}</td>
						<td style = "text-align: center;">${travelDestination.destRegion}</td>
						<td style = "text-align: center;">${travelDestination.destAddress}</td>
						<td style = "text-align: center;">${travelDestination.destPhone}</td>
						<td style = "text-align: center;">${travelDestination.destWebsiteUrl}</td>
						<td style = "text-align: center;">${travelDestination.destInformation}</td>
						<c:forEach var="result" items="${nearPlayPoints}" varStatus="status">
						<td style = "text-align: center;">${result.destTitle}</td>
						</c:forEach>
							<c:forEach var="result" items="${nearStayPoints}" varStatus="status">
						<td style = "text-align: center;">${result.destTitle}</td>
						</c:forEach>
					</div>
	</table>
	<script>
		let a = 0;
		function a_stack(){
			a++;
		}
	</script>
</body>
</html>