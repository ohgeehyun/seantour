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
			<td><c:out value="이름"></c:out></td>
			<td><c:out value="작성자타입"></c:out></td>
			<td><c:out value="조회수"></c:out></td>
			<td><c:out value="여행지경로"></c:out></td>
			<td><c:out value="여행기간"></c:out></td>
		
		</tr>		
		
				<li>
					<div>
						<td style = "text-align: center;">${travelRoute.routTitle}</td>
						<td style = "text-align: center;">${travelRoute.routType}</td>
						<td style = "text-align: center;">${travelRoute.routHit}</td>
						<td style = "text-align: center;">${travelRoute.routeDailyList[0].routWayPoint}</td>
						<td style = "text-align: center;">${travelRoute.routeDailyList[0].routDays}</td>			
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