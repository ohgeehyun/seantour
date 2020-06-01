<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ include file="/WEB-INF/jsp/jnit/_common/init.jsp" %>
<script type="text/javascript">
var repeatInterval = ${conf.clippingConfRepeatInterval };
var page = <c:out value="${param.pageEnd}" />;
var minPage = <c:out value="${param.pageStart}" />;
var allDelete = false;
var timer;
$(document).ready(function(){
	$("#myModalLabel").html("<strong>초기데이터구축</strong>");
	
	$("#btnStop").click(function(){stop();});
	$("#btnPlay").click(function(){play();});
	$("#btnComplete").click(function(){location.reload();});
	 
	$("#btnStop").hide();
	$("#btnComplete").hide();
	
	$("#myModal .modal-footer .btn").click(function(){
		location.reload();
	});
	calRemainTime();
});

function getData(){
	calRemainTime();
	if(page < minPage){
		complete();
		return;
	}
	
	if(!allDelete){
		$("#td_delete").html("실행중");
		$.ajax({
			url:"<c:url value="/cms/clipping/crawler/initExcuteDeleteAll.do" />"
			,data:{"clippingConfId":"<c:out value="${conf.clippingConfId}" />", pageStart:"<c:out value="${param.pageStart}" />", pageEnd:"<c:out value="${param.pageEnd}" />"}
			,dataType : "json"
			,success:function(data){
				console.log(data);
				if(data.isSuccess == true){
					$("#td_delete").html("성공");
					allDelete = true;
					getData();
				}else{
					$("#td_delete").html("실패");
					stop();
				}
			}
			,fail:function(xhr){
				alert(xhr);
				$("#td_delete").html("실패");
				stop();
			}
		});
	}else{
		$("#td_"+page).html("수집중");
		var val = page;
		$.ajax({
			url:"<c:url value="/cms/clipping/crawler/initExcuteAction.do" />"
			,data:{"clippingConfId":"<c:out value="${conf.clippingConfId}" />", page:val}
			,dataType : "json"
			,success:function(data){
				if(data.isSuccess){
					$("#td_"+page).html("성공");
				}else{
					$("#td_"+page).html("실패");
				}
				page--;
				getData();
			}
			,fail:function(xhr){
				alert(xhr);
				$("#td_"+page).html("실패");
				page--;
				getData();
			}
		});
	}
	
}

function complete(){
	$("#btnComplete").show();
	$("#btnPlay").hide();
	$("#btnStop").hide();
}
function stop(){
	$(".modal-backdrop").bind("click",function(){$("#myModal").modal('toggle');});
	$("#btnPlay").show();
	$("#btnStop").hide();
	page--;
	if(page < minPage){
		complete();
	}
	$("#myModal .modal-header .close").show();
	$("#myModal .modal-footer .btn").show();
	$("#myModal .modal-header .close").unbind("click");
	$("#myModal .modal-header .close").click(function(){
		location.reload();
	});
	$("#myModal .modal-footer .btn").unbind("click");
	$("#myModal .modal-footer .btn").click(function(){
		location.reload();
	});
}
function play(){
	$(".modal-backdrop").unbind("click");
	$("#btnPlay").hide();
	$("#btnStop").show();
	$("#myModal .modal-header .close").hide();
	$("#myModal .modal-footer .btn").hide();
	getData();
}

function calRemainTime(){
	var remainInterval = repeatInterval;
	if(remainInterval == 0)remainInterval = 1000;
	var remainTime = (page - minPage + 1)*remainInterval*1*10;
	if(remainTime < 0)remainTime = 0;
	
	remainTime = remainTime/1000;
	
	var hour = parseInt(remainTime/3600);
	var min = parseInt((remainTime%3600)/60);
	var sec = remainTime%60;
	
	$("#spanTime").html(hour+" 시간 "+min+" 분 " + sec+ " 초");
}
</script>
	<div>
		<div class="widget-content nopadding">
		<a href="#" class="btn btn-small" id="btnComplete"><i class="icon-ok-sign"></i> 완료</a>
		<a href="#" class="btn btn-small" id="btnStop"><i class="icon-ok-sign"></i> 일시정지</a>
		<a href="#" class="btn btn-small" id="btnPlay"><i class="icon-ok-sign"></i> 시작</a>
		<table id="clippingTable" class="table table-bordered table-striped table-hover">
              	<thead>
               	<tr>
               		<th>PAGE</th>
               		<th>수집</th>
               	</tr>
              	</thead>
              	<tbody>
              	<tr>
              		<td><c:out value="${param.pageStart }" />~<c:out value="${param.pageEnd }" />Page삭제</td>
              		<td id="td_delete">대기중</td>
              	</tr>
			<c:forEach begin="${param.pageStart }" end="${param.pageEnd }" var="pageVal">
			<c:set var="page" value="${param.pageEnd - pageVal + 1}" />
				<tr>
					<td>${page }</td>
					<td id="td_${page }">대기중</td>
				</tr>
			</c:forEach>
          		</tbody>
        </table>
		</div>
        <br />
        남은 수집 예상 시간 : <span id="spanTime"></span> 입니다.(한페이지당 데이터 10개 기준)
	</div>