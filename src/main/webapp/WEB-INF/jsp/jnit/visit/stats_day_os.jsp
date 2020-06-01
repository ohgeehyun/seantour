<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<style>
 #flashcontent11 embed {width:100%}
 #flashcontent5 embed {width:100%}
</style>

<script type="text/javascript" src="http://chart.cafen.net/JS/swfobject.js"></script>
<script type="text/javascript" charset="utf-8" src="http://chart.cafen.net/JS/rainOpenSWFChart.js"></script>

<script type="text/javaScript" language="javascript" defer="defer">
var searchStats = function(){
	$('#search_form').attr('method','post');
	$('#search_form').submit();
};
$(document).ready(function(){
	var searchSite = "${searchVO.searchSite}";
	var day = "${day}";
	var date = "${searchDateStr}";

	if(date == '' || date == '-'){
		if(day == 2){
			$('#search_year2').val(' ');
		}else if(day == 3){
			$('#search_year3').val(' ');
		}
	}else{
		if(day == 2){
			var dateSplit = date.split("-");
			$('#search_year2').val(dateSplit[0]);
			$('#search_month2').val(dateSplit[1]);
		}else if(day == 3){
			$('#search_year3').val(date);
		}
	}

	if(searchSite == ''){
		$('#searchSite').val(' ');
	}else{
		$('#searchSite').val(searchSite);
	}
	
	if(day == 1 || day == 2){
		$('.datepicker').datepicker({ changeYear: true, changeMonth: true });
	}else{
		$('.datepicker').datepicker({ changeYear: true});
	}
});
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<div class="row-fluid">
           	<div class="span4">
               	<div class="widget-box">
                   	<div class="widget-title" style="height: 100%;">
						<form id="search_form" name="search_form">
							<select id="searchSite" name="searchSite">
								<option value=" ">  - 전체사이트 -  </option>
								<c:forEach var="site" items="${resultSiteList}" varStatus="status">
									<option value="${site.sitePath}">${site.siteNm}</option>
								</c:forEach>
							</select>
							<c:if test="${day == 1}">
								<input name="search_day1" style="margin-left:3px;margin-bottom:3px;" id="search_day" type="text" class="datepicker" value="<c:out value="${searchDateStr}" />" style="width: 100px;"/>
							</c:if>
							<c:if test="${day == 2}">
								<select id="search_year2" name="search_day1" style="marin-rigth: 5px;">
									<option value=" "> - 년도 선택- </option>
									<c:forEach var="year" begin="2013" end="2020">
										<option value="${year}">${year}년</option>
									</c:forEach>
								</select>
								<select id="search_month2" name="search_day2">
									<option value=" "> - 월 선택 - </option>
									<c:forEach var="month" begin="1" end="12">
										<option value="${month}">${month}월</option>
									</c:forEach>
								</select>
							</c:if>
							<c:if test="${day == 3}">
								<select id="search_year3" name="search_day1">
									<option value=" "> - 년도 선택 - </option>
									<c:forEach var="year" begin="2013" end="2020">
										<option value="${year}">${year}년</option>
									</c:forEach>
								</select>
							</c:if>
							<a href="javascript:searchStats();" class="btn btn-small"><i class="icon-search"></i> 검색</a>
						</form>
                    </div>
                    <div class="widget-content nopadding">
						<table class="table table-bordered table-striped table-hover" summary="일간 사용자OS별 방문자">
							<thead>
								<tr>
									<th>사용자 OS</td>
									<th>방문수</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result">
								<tr>
									<td align="center"><c:out value="${result.userOs}" escapeXml="true" /></td>
									<td align="center"><c:out value="${result.hit}" escapeXml="true" /></td>
								</tr>
								</c:forEach>
								<tr>
									<td align="center">총합</td>
									<td align="center">${sum}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="span8">
				<div id="flashcontent11"></div>
				<div id="flashcontent5"></div>
			</div>
		</div>
	</div>
</div>
<script>

var resultList = "${resultList}";

var max = 0;
var val = 0;

///////////클래스 바///////////
var bar_1 = new bar_glass( 55, '#D54C78', '#C31812' );

// add 10 bars with random heights
<c:forEach var="stats" items="${resultList}" varStatus="status">
	bar_1.data.push(${stats.hit});
</c:forEach>

//
// create a 2nd set of bars:
	
// create the chart:
//
var g = new graph(800, 260);
g.title( '', '{font-size:20px; color: #bcd6ff; '+
	'margin:10px; background-color: #5E83BF; padding: 5px 15px 5px 15px;}' );

// add both sets of bars:
g.data_sets.push(bar_1);

// label the X axis (10 labels for 10 bars):
g.set_x_labels( [<c:forEach var="stats" items="${resultList}" varStatus="status">
						'${stats.userOs}'<c:if test="${!status.last}">,</c:if>
				</c:forEach>] );

// colour the chart to make it pretty:
g.x_axis_colour( '#909090', '#D2D2FB' );
g.y_axis_colour( '#909090', '#D2D2FB' );

g.set_y_min( 0 );
g.set_y_max( (${max})+(${max}/10) );
g.y_label_steps( 10 );
g.set_y_legend( '', 10, '#736AFF' );
g.render('flashcontent5');

/////원차트/////

var data = [];
  <c:forEach var="stats" items="${resultList}" varStatus="status">
  	data.push(${stats.hit});
  </c:forEach>

var g = new graph(800, 300);

//
// 파이 차트, 60% alpha
//
g.pie(60,'#505050','{font-size: 12px; color: #404040;}');
//
// pass in two arrays, one of data, the other data labels
//
g.pie_values( data, [<c:forEach var="stats" items="${resultList}" varStatus="status">
					<c:if test="${status.count != fn:length(resultList)}">
						'${stats.userOs}',
					</c:if>
					<c:if test="${status.count == fn:length(resultList)}">
						'${stats.userOs}'
					</c:if>
					</c:forEach>] );
//
// Colours for each slice, in this case some of the colours
// will be re-used (3 colurs for 5 slices means the last two
// slices will have colours colour[0] and colour[1]):
//
g.pie_slice_colours( ['#d01f3c','#356aa0','#C79810'] );

g.set_tool_tip( '#val#명' );

g.title( '', '{font-size:20px; color: #bcd6ff; '+
'margin:10px; background-color: #5E83BF; padding: 5px 15px 5px 15px;}' );

g.render('flashcontent11');
</script>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
