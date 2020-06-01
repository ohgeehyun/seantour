<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ include file="/WEB-INF/jsp/jnit/_common/init.jsp" %>
<script type="text/javascript">
var repeatInterval = ${conf.clippingConfRepeatInterval };
var page = <c:out value="${conf.clippingConfListPageParamMax }" />;
var minPage = 1;
var timer;
$(document).ready(function(){
	$("#myModalLabel").html("<strong>신규데이터즉시수집</strong>");
	
	$("#btnStop").click(function(){stop();});
	$("#btnPlay").click(function(){play();});
	$("#btnComplete").click(function(){location.reload();});
	 
	$("#btnStop").hide();
	$("#btnComplete").hide();

	
});

function getData(){
	
	if(page < minPage){
		stop();
		return;
	}
	
	$("#td_"+page).html("수집중");
	var val = page;
	$.ajax({
		url:"<c:url value="/cms/clipping/crawler/recentExcuteAction.do" />"
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
			<c:forEach begin="1" end="${conf.clippingConfListPageParamMax }" var="pageVal">
			<c:set var="page" value="${conf.clippingConfListPageParamMax - pageVal + 1}" />
				<tr>
					<td>${page }</td>
					<td id="td_${page }">대기중</td>
				</tr>
			</c:forEach>
          		</tbody>
        </table>
		</div>
	</div>