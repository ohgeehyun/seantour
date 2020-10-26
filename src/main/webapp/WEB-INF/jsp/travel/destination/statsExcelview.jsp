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
		<th style="font-weight: bold; text-align: center;" colspan = '4' bgcolor= 'gray'>계절별-봄</th>
		<tr style="font-weight: bold; text-align: center; color: red;">	
			<td><c:out value="순위"></c:out></td>
			<td><c:out value="이름"></c:out></td>
			<td><c:out value="카테고리"></c:out></td>
			<td><c:out value="지역"></c:out></td>
		</tr>		
			<c:forEach var="result" items="${springList}" varStatus="status">
				<li>
					<div>
						<tr>
						<td style = "text-align: center;">${status.count}</td> 
					    <td style = "text-align: center;">${result.destTitle}</td>
						<td style = "text-align: center;">${result.destCategory}</td>
						<td style = "text-align: center;">${result.destRegion}</td> 	
						</tr>
					</div>
				</li>
			</c:forEach>
		<th style="font-weight: bold; text-align: center;" colspan = '4' bgcolor= 'gray'>계절별-여름</th>
		<tr style="font-weight: bold; text-align: center; color: red;">	
			<td><c:out value="순위"></c:out></td>
			<td><c:out value="이름"></c:out></td>
			<td><c:out value="카테고리"></c:out></td>
			<td><c:out value="지역"></c:out></td>
		</tr>		
			<c:forEach var="result" items="${summerList}" varStatus="status">
				<li>
					<div>
						<tr>
						<td style = "text-align: center;">${status.count}</td> 
					    <td style = "text-align: center;">${result.destTitle}</td>
						<td style = "text-align: center;">${result.destCategory}</td>
						<td style = "text-align: center;">${result.destRegion}</td> 	
						</tr>
					</div>
				</li>
			</c:forEach>
		<th style="font-weight: bold; text-align: center;" colspan = '4' bgcolor= 'gray'>계절별-가을</th>
		<tr style="font-weight: bold; text-align: center; color: red;">	
			<td><c:out value="순위"></c:out></td>
			<td><c:out value="이름"></c:out></td>
			<td><c:out value="카테고리"></c:out></td>
			<td><c:out value="지역"></c:out></td>
		</tr>		
			<c:forEach var="result" items="${autumnList}" varStatus="status">
				<li>
					<div>
						<tr>
						<td style = "text-align: center;">${status.count}</td> 
					    <td style = "text-align: center;">${result.destTitle}</td>
						<td style = "text-align: center;">${result.destCategory}</td>
						<td style = "text-align: center;">${result.destRegion}</td> 	
						</tr>
					</div>
				</li>
			</c:forEach>
		<th style="font-weight: bold; text-align: center;" colspan = '4'  bgcolor= 'gray'>계절별-겨울</th>
		<tr style="font-weight: bold; text-align: center; color: red;">	
			<td><c:out value="순위"></c:out></td>
			<td><c:out value="이름"></c:out></td>
			<td><c:out value="카테고리"></c:out></td>
			<td><c:out value="지역"></c:out></td>
		</tr>		
			<c:forEach var="result" items="${winterList}" varStatus="status">
				<li>
					<div>
						<tr>
						<td style = "text-align: center;">${status.count}</td> 
					    <td style = "text-align: center;">${result.destTitle}</td>
						<td style = "text-align: center;">${result.destCategory}</td>
						<td style = "text-align: center;">${result.destRegion}</td> 	
						</tr>
					</div>
				</li>
			</c:forEach>
		<th style="font-weight: bold; text-align: center;" colspan = '4'  bgcolor= 'gray'>베스트추천</th>
		<tr style="font-weight: bold; text-align: center; color: red;">	
			<td><c:out value="순위"></c:out></td>
			<td><c:out value="이름"></c:out></td>
			<td><c:out value="카테고리"></c:out></td>
			<td><c:out value="지역"></c:out></td>
		</tr>		
			<c:forEach var="result" items="${routeList}" varStatus="status">
				<li>
					<div>
						<tr>
						<td style = "text-align: center;">${status.count}</td> 
					    <td style = "text-align: center;">${result.destTitle}</td>
						<td style = "text-align: center;">${result.destCategory}</td>
						<td style = "text-align: center;">${result.destRegion}</td> 	
						</tr>
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