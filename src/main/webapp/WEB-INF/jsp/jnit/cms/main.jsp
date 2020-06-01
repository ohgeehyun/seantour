<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javaScript" src="<c:url value="/resources/stats/plugins/amcharts.js"/>" /></script>
<script type="text/javaScript" src="<c:url value="/resources/stats/plugins/serial.js"/>" ></script>
<script type="text/javaScript" src="<c:url value="/resources/stats/plugins/lights.js"/>" ></script>
<script type="text/javaScript" src="<c:url value="/resources/stats/plugins/pie.js"/>" ></script>
<script type="text/javaScript" src="<c:url value="/resources/js/jnit/filego.js"/>" ></script>
<script>
var chart;

var chartData = [
	<c:forEach items="${pageviewList}" var="item" varStatus="status">
	{
	    "time": "-${status.index}분 전",
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

$(document).ready(function(){
	
	// === Prepare peity charts === //
	unicorn.peity();
	
	// === Prepare the chart data ===/
	var sin = [], cos = [];
	var result = ${visitStats};
	var max = 0;
	
    for (var i = 0; i < 10; i++) {
    	max = Math.max(max, result[i]);
    	max = Math.max(max, result[i+200]);
        sin.push([i, result[i]]);
        cos.push([i, result[i+200]]);
    }

	// === Make chart === //
    if($('.chart').length>0){
	    var plot = $.plot($(".chart"),
	           [ { data: sin, label: "오늘 접속자", color: "#BA1E20"}, { data: cos, label: "어제 접속자",color: "#459D1C" } ], {
	               series: {
	                   lines: { show: true },
	                   points: { show: true }
	               },
	               grid: { hoverable: true, clickable: true },
	               yaxis: { min: 0, max: max+(max/10) }
			   });
    }
    
	// === Point hover in chart === //
    var previousPoint = null;
    $(".chart").bind("plothover", function (event, pos, item) {
		
        if (item) {
            if (previousPoint != item.dataIndex) {
                previousPoint = item.dataIndex;
                
                $('#tooltip').fadeOut(200,function(){
					$(this).remove();
				});
                var x = item.datapoint[0].toFixed(2).replace(".00",""),
					y = item.datapoint[1].toFixed(2).replace(".00","");
                    
                unicorn.flot_tooltip(item.pageX, item.pageY,item.series.label + " : "+ y+"명");
            }
            
        } else {
			$('#tooltip').fadeOut(200,function(){
					$(this).remove();
				});
            previousPoint = null;           
        }   
    });	

    // === Popovers === //    
    var placement = 'bottom';
    var trigger = 'hover';
    var html = true;

    $('.popover-visits').popover({
       placement: placement,
       content: '<span class="content-big">전체 사이트</span>',
       trigger: trigger,
       html: html   
    });
    $('.popover-users').popover({
       placement: placement,
       content: '<span class="content-big">전체 페이지</span>',
       trigger: trigger,
       html: html   
    });
    $('.popover-orders').popover({
       placement: placement,
       content: '<span class="content-big">전체 사용자</span>',
       trigger: trigger,
       html: html   
    });
    
    /* $('.popover-tickets').popover({
       placement: placement,
       content: '<span class="content-big">2968</span> <span class="content-small">All Tickets</span><br /><span class="content-big">48</span> <span class="content-small">New Tickets</span><br /><span class="content-big">495</span> <span class="content-small">Solved</span>',
       trigger: trigger,
       html: html   
    }); */
    
    $('#manualOpen').click(function(e){
		e.preventDefault();
		/*
		var url = "http://ltskorea.co.kr/JNITCMS_manual.zip";
		window.open(url,"CMS메뉴얼", "width=721, height=900, toolbar=yes, scrollbars=yes");
		*/
		location.href="http://ltskorea.co.kr/JNITCMS_manual.zip";
    });
   
});


unicorn = {
		// === Peity charts === //
		peity: function(){		
			$.fn.peity.defaults.line = {
				strokeWidth: 1,
				delimeter: ",",
				height: 24,
				max: null,
				min: 0,
				width: 50
			};
			$.fn.peity.defaults.bar = {
				delimeter: ",",
				height: 24,
				max: null,
				min: 0,
				width: 50
			};
			$(".peity_line_good span").peity("line", {
				colour: "#B1FFA9",
				strokeColour: "#459D1C"
			});
			$(".peity_line_bad span").peity("line", {
				colour: "#FFC4C7",
				strokeColour: "#BA1E20"
			});	
			$(".peity_line_neutral span").peity("line", {
				colour: "#CCCCCC",
				strokeColour: "#757575"
			});
			$(".peity_bar_good span").peity("bar", {
				colour: "#459D1C"
			});
			$(".peity_bar_bad span").peity("bar", {
				colour: "#BA1E20"
			});	
			$(".peity_bar_neutral span").peity("bar", {
				colour: "#757575"
			});
		},

		// === Tooltip for flot charts === //
		flot_tooltip: function(x, y, contents) {
			
			$('<div id="tooltip">' + contents + '</div>').css( {
				top: y + 5,
				left: x + 5
			}).appendTo("body").fadeIn(200);
		}
}

//파일고 배포로그 팝업 열기
function filegoPop(state){
	/*
		state 0 : 성공로그
		state 1 : 실패로그
		state 2 : 실패확인로그
	*/
	if(state == undefined || state == null || state == '') state = 0;
	state = Number(state);
	
	var html = filegoListHtml(state);
	$("#filegoModal>.modal-body").empty().append(html);
	$("#filegoModal").modal('show');
}

//파일고 종류별 list html 가져오기
function filegoListHtml(state){
	/*
		state 0 : 성공로그
		state 1 : 실패로그
		state 2 : 실패확인로그
	*/
	if(state == undefined || state == null || state == '') state = 0;
	var html = '';
	var url = '';
	state = Number(state);
	
	if(state == 0){
		url = '/jnit/filego/log/success/list.do';		//성공로그
	}else if(state == 1){
		url = '/jnit/filego/log/fail/list.do';			//실패로그
	}else if(state == 2){
		url = '/jnit/filego/log/failConfirm/list.do';	//실패확인로그
	}else{
		return false;
	}
	
	
	$.ajax({
		type:'post',
		url:'',
		data:{
			
		},
		success:function(data){
			html = data;
		},
		error:function(error){
			alert('다시 시도해주세요.');
		},
		async:false
	});
	
	return html;
}
</script>

<!-- 2014-11-26 by.나성재 수정 -->
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-56893241-10', 'auto');
ga('send', 'pageview');

</script>

<div id="content">
	<div id="content-header">
       	<div class="btn-group">
			<a href="<c:url value="/cms/"/>" title="첫 화면 (Start Page)" class="btn btn-large tip-bottom" data-original-title="HOME"><i class="icon-home"></i></a>
			<button id="manualOpen" class="btn btn-large tip-bottom" data-original-title="메뉴얼(manual)" target="_blank"><i class="icon-question"></i></button>
			<a href="<c:url value="/uat/uia/actionLogout.do"/>" title="로그아웃 (Logout)" class="btn btn-large tip-bottom" data-original-title="Logout"><i class="icon-off"></i></a>
			<a href="#" onclick="javascript:filegoPop();return false;" title="배포 로그" class="btn btn-large tip-bottom" data-original-title="HOME"><i class="icon-share"></i></a>
		</div>
		<h2 class="left_title">DashBoard 111111111111111111111</h2>
	</div>
   	<div class="content_view container-fluid">
   		<div class="row-fluid">
       		<div class="span12 center">
				<ul class="stat-boxes">
					<li class="popover-visits">
						<div class="left peity_bar_good"><i class="icon-signal" style="font-size: 35px;"></i></div>
						<div class="right">
							<strong>${totalMap['totalSite']}</strong>
							Total Site
						</div>
					</li>
					<li class="popover-users">
						<div class="left peity_bar_neutral"><i class="icon-signal" style="font-size: 35px;"></i></div>
						<div class="right">
							<strong>${totalMap['totalPage']}</strong>
							Total Pages
						</div>
					</li>
					<li class="popover-orders">
					<div class="left peity_bar_bad"><i class="icon-signal" style="font-size: 35px;"></i></div>
						<div class="right">
							<strong>${totalMap['totalMbr']}</strong>
							Total Users
						</div>
					</li>
					<%--
					<li class="popover-tickets">
						<div class="left peity_line_good"><span>12,6,9,23,14,10,17</span>+70%</div>
						<div class="right">
							<strong>2968</strong>
							Total posts
						</div>
					</li>
					--%>
				</ul>
			</div>
   		</div>
		<div class="row-fluid">
		<%--
			<div class="alert alert-info">
				<strong>JNIT CMS 입니다.</strong>
				<a href="#" data-dismiss="alert" class="close">×</a>
			</div>
		--%>
			<div class="widget-box">
				<div class="widget-title">
					<span class="icon"><i class="icon-signal"></i></span>
					<h3>Site Statistics</h3>
					<div class="buttons">
						<a href="<c:url value="/cms/"/>" class="btn btn-mini"><i class="icon-refresh"></i> Update state</a>
					</div>
				</div>
               	<div class="widget-content">
               		<div class="row-fluid">
                   		<div class="span4">
                       		<ul class="site-stats">
                           		<li>
									<i class="icon-calendar"></i>
									<strong>${allUser[0]}</strong>
									<small>전체 방문자 수</small>
								</li>
								<li>
									<i class="icon-tasks"></i>
									<strong>${todayUser[0]}</strong>
									<small>금일 방문자 수</small>
								</li>
								<li>
									<div id="result2div" style="height: 200px; width: 100%; font-size: 11px"></div>
								</li>
                           	</ul>
                       	</div>
                       	<div class="span8">
                       	<div id="result1div" style="height: 400px; width: 100%; font-size: 11px"></div>
						
                       	</div>
                   	</div>
               	</div>
           	</div>
		</div>
		<div class="row-fluid">
			<div class="widget-box">
				<div class="widget-content nopadding cmstipbox">
					<table class="table table-bordered table-striped th_left">
					<caption>cms TIP</caption>
					<tbody>
					<tr>
						<th colspan="2">
							<span class="icon" style=" font-size: 20px; font-weight: bold; "><i class="icon-lightbulb"></i> TIP</span>
						</th>
						<td>
							<b>CMS 첫 메인화면은 2가지 버전을 선택할수 있습니다. </b><br />
							 ( 설정 위치 : 환경설정 &gt; 기본설정 &gt; 일반설정 &gt; CMS 메인화면설정 )
						</td>
					</tr>
					</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>       
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>