<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<%-- <script type='text/javascript' src='http://www.google.com/jsapi'></script> --%>
<script type='text/javascript' src='<c:url value="/resources/stats/plugins/jsapi.js" />'></script>
<script type="text/javaScript" src="<c:url value="/resources/js/jnit/filego.js"/>" ></script>
<script type='text/javascript'>
  var cpuUsage = 0;
  var memUsage = 0;
  var hddUsage = 0;
  var netUsage = [
	['Name', 'Process']
  ];
  
  var getUsages = function() {
	  	//console.log("get");
		$.ajax({
			url:'<c:url value="/cms/sysinfo/get.do?type=all"/>',
			data:{"utime":$.now()},
			success:function(data){
				eval("var tData = "+data);
				
				cpuUsage = tData.cpu;
				memUsage = tData.mem;
				hddUsage = tData.hdd;
				
				drawChart();
			}
		});
  }
  
  var getNetUsages = function() {
	  	//console.log("netget");
		$.ajax({
			url:'<c:url value="/cms/sysinfo/netlog.do"/>',
			data:{"utime":$.now()},
			success:function(data){
				eval("var nData = "+data);
				
				netUsage = nData;
				
				drawChart();
			}
		});
}
  
  google.load('visualization', '1', {packages:['gauge', 'imagechart']});
  google.setOnLoadCallback(drawChart);
 
  
  var _data1;
  var _data2;
  var _data3;
  var _data4;
  var _options1;
  var _options2;
  var _options3;
  var _options4;
  var _chart1;
  var _chart2;
  var _chart3;
  function drawChart() {
	  	drawChart1();
	  	drawChart2();
	  	drawChart3();
	  	
	  	$("div.infoBox1 table, div.infoBox2 table, div.infoBox3 table").css("margin", "");
	  	
  }
  
  function drawChart1() {
	    _data1 = google.visualization.arrayToDataTable([
	      ['Label', 'Value'],
	      ['CPU', cpuUsage],
	    ]);
	
	    _options1 = {
	      height:220,
	      redFrom: 90, redTo: 100,
	      yellowFrom:75, yellowTo: 90,
	      minorTicks: 5
	    };
	
	    _chart1.draw(_data1, _options1);
  }
  
  function drawChart2() {
	    _data2 = google.visualization.arrayToDataTable([
	      ['Label', 'Value'],
	      ['Memory', memUsage],
	    ]);
	
	    _options2 = {
	      height:220,
	      redFrom: 90, redTo: 100,
	      yellowFrom:75, yellowTo: 90,
	      minorTicks: 5
	    };
	
		
	    _chart2.draw(_data2, _options2);
  }
  
  function drawChart3() {
	    _data3 = google.visualization.arrayToDataTable([
	      ['Label', 'Value'],
	      ['Storage', hddUsage],
	    ]);
	
	    _options3 = {
	      height:220,
	      redFrom: 90, redTo: 100,
	      yellowFrom:75, yellowTo: 90,
	      minorTicks: 5
	    };
	
		
	    _chart3.draw(_data3, _options3);
  }
  
  $(document).ready(function(){
		_chart1 = new google.visualization.Gauge(document.getElementById('Chart1'));
		_chart2 = new google.visualization.Gauge(document.getElementById('Chart2'));
		_chart3 = new google.visualization.Gauge(document.getElementById('Chart3'));
		
	  getUsages();
	  getNetUsages();
	  var usageInterval = setInterval(getUsages, 3000);
	  var netusageInterval = setInterval(getNetUsages, 60000);  
  });

</script>
<div id="content">
	<div id="content-header">
       	<div class="btn-group">
			<a href="<c:url value="/cms/"/>" title="첫 화면 (Start Page)" class="btn btn-large tip-bottom" data-original-title="HOME"><i class="icon-home"></i></a>
			<button id="manualOpen" class="btn btn-large tip-bottom" data-original-title="메뉴얼(manual)" target="_blank"><i class="icon-question"></i></button>
			<a href="<c:url value="/uat/uia/actionLogout.do"/>" title="로그아웃 (Logout)" class="btn btn-large tip-bottom" data-original-title="Logout"><i class="icon-off"></i></a>
			<c:if test="${isFilegoActive == 'on'}">
				<a id="filegoA" href="#" onclick="javascript:filegoPop();return false;" title="배포 로그" class="btn btn-large tip-bottom" data-original-title="HOME"><i class="icon-share"></i></a>
			</c:if>
		</div>
		<h2 class="left_title">DashBoard</h2>
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
				</ul>
			</div>
   		</div>
   		<div class="row-fluid">
   			<div class="widget-box">
				<div class="widget-title">
					<span class="icon"><i class="icon-signal"></i></span>
					<h3>Server State</h3>
				</div>
               	<div class="widget-content">
               		<div class="row-fluid">
						<div class="infoBox1 span3">
							<div id="Chart1"></div>
						</div>
						<div class="infoBox2 span3">
							<div id="Chart2"></div>
						</div>
						<div class="infoBox3 span3">
							<div id="Chart3"></div>
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
							<b>CMS 첫 메인화면은 2가지 버전을 선택할수 있습니다. </b><br>
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