<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javaScript" src="<c:url value="/resources/stats/plugins/amcharts.js"/>"></script>
<script type="text/javaScript" src="<c:url value="/resources/stats/plugins/serial.js"/>" ></script>
<script type="text/javaScript" src="<c:url value="/resources/stats/plugins/lights.js"/>"></script>
<script type="text/javaScript" src="<c:url value="/resources/stats/plugins/pie.js"/>"></script>
<script type="text/javascript">
<!--
var chart;

var chartData = [
	<c:forEach items="${pageviewList}" var="item" varStatus="status">
	{
	    "time": "${status.index}분 전",
	    "pageview": ${item[2]}
	}<c:if test="${not status.last}">,</c:if>
	
	</c:forEach>
];

AmCharts.ready(function () {
    // SERIAL CHART
    chart = new AmCharts.AmSerialChart();
    chart.dataProvider = chartData;
    chart.categoryField = "time";
    chart.startDuration = 1;

    // AXES
    // category
    var categoryAxis = chart.categoryAxis;
    categoryAxis.labelRotation = 90;
    categoryAxis.gridPosition = "start";

    // value
    // in case you don't want to change default settings of value axis,
    // you don't need to create it, as one value axis is created automatically.

    // GRAPH
    var graph = new AmCharts.AmGraph();
    graph.valueField = "pageview";
    graph.balloonText = "[[category]]: <b>[[value]]</b>";
    graph.type = "column";
    graph.lineAlpha = 0;
    graph.fillAlphas = 0.8;
    chart.addGraph(graph);

    // CURSOR
    var chartCursor = new AmCharts.ChartCursor();
    chartCursor.cursorAlpha = 0;
    chartCursor.zoomable = false;
    chartCursor.categoryBalloonEnabled = false;
    chart.addChartCursor(chartCursor);

    chart.creditsPosition = "top-right";

    chart.write("result1div");
});

AmCharts.makeChart("result2div", {
    "type": "pie",
    "dataProvider": [
    <c:forEach items="${diviceList}" var="item" varStatus="status">
	{
	    "device": "${item[0]}",
	    "user": ${item[1]}
	}<c:if test="${not status.last}">,</c:if>
	
	</c:forEach>
	],
    "titleField": "device",
    "valueField": "user",
    "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
    "legend": {
        "align": "center",
        "markerType": "circle"
    }

});

 // -->
</script>

<div>
	<div id="result1div" style="height: 400px; width: 100%; font-size: 11px"></div>
	<div id="result2div" style="height: 400px; width: 100%; font-size: 11px"></div>
</div>

<c:forEach items="${list}" var="item">
    ${item[0]}<br />
</c:forEach>
