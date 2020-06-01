<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

$(document).ready(function(){
	$('#searchReset').click(function(){
		document.getElementById("listForm").ccMode.value = "";
		$('#pageIndex').val(1);
	});
});

/* 글 수정 화면 function */
function fn_egov_select(clippingConfId) {
    document.getElementById("listForm").clippingConfId.value = clippingConfId;
    document.getElementById("listForm").ccMode.value = "write";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").clippingConfId.value = "";
	document.getElementById("listForm").ccMode.value = "write";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").clippingConfId.value = "";
	document.getElementById("listForm").ccMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
   	document.getElementById("listForm").submit();
}


function fn_init(clippingConfId){
    document.getElementById("listForm").clippingConfId.value = clippingConfId;
    document.getElementById("listForm").ccMode.value = "viewInit";
   	document.getElementById("listForm").submit();
}

function fn_recent(clippingConfId){
	
	$("#myModal").modal('toggle');
	$("#myModal .modal-body").html("");
	$.ajax({
		url:"<c:url value="/cms/clipping/crawler/recentExcutePopup.do" />"
		,data:{"clippingConfId":clippingConfId}
		,success:function(data){
			$("#myModal .modal-body").html(data);
		}
		,fail:function(xhr){
			console.log(xhr);
		}
	});
	return false;
}


function fn_period_use(clippingConfId, clippingConfPeriodUse){
	var msg = (clippingConfPeriodUse == 1)?'실행설정':'실행중지';
	if(confirm(msg + "상태로 변경하시겠습니까?")){
		$.ajax({
			url:"<c:url value="/cms/clipping/conf/index.do" />"
			,data:{"ccMode":"updatePeriodUseAction","clippingConfId":clippingConfId, "clippingConfPeriodUse":clippingConfPeriodUse}
			,success:function(data){
				alert("변경되었습니다.");
				location.reload();
			}
			,fail:function(xhr){
				console.log(xhr);
			}
		});	
	}
	return false;
}

function fn_delete_alldata(clippingSiteId, clippingConfId){
	if(confirm("수집된 데이터를 모두 삭제하며 복구하실 수 없습니다.\n\n정말로 삭제하시겠습니까?")){
		$.ajax({
			url:"<c:url value="/cms/clipping/data/index.do" />"
			,data:{"cdMode":"deleteAllDataAction","clippingSiteId":clippingSiteId,"clippingConfId":clippingConfId}
			,success:function(data){
				alert("초기화가 완료되었습니다.");
				location.reload();
			}
			,fail:function(xhr){
				console.log(xhr);
			}
		});	
	}
}
 // -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form id="listForm" action="?">
			<input type="hidden" name="clippingConfId" />
			<input type="hidden" name="ccMode" />
			<input type="hidden" name="searchCondition" value="1" />
			<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value="${searchVO.pageIndex }" />" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>수집설정 리스트</h3>
	                       	<a href="?ccMode=write" class="btn btn-small"><i class="icon-plus-sign"></i> 추가</a>
	                       	<select id="clippingSiteId" name="clippingSiteId" class="noSelect2">
			                	<option value="">수집사이트 선택</option>
			                <c:forEach items="${clippingSiteList }" var="site">
			                	<option value="${site.clippingSiteId }"${site.clippingSiteId == searchVO.clippingSiteId?' selected="selected"':''  }><c:out value="${site.clippingSiteName }" /></option>
			                </c:forEach>
			                </select>
	                       	<input type="text" name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>">
	       					<button class="btn btn-small" id="searchReset"><i class="icon-search"></i> 검색</button>
	                    </div>
	                    <div class="widget-content nopadding">	
							<table class="table table-bordered table-striped table-hover" summary="수집설정 리스트">
						        <thead>
						        	<tr>
						                <th width="10%">사이트명</td>
						                <th width="10%">설정명</td>
						                <th width="15%">기초데이터</td>
						                <th width="25%">신규데이터수집사용</td>
						                <th width="10%">수정일</td>
						                <th width="10%">데이터초기화</td>
						        	</tr>
						        
						        <tbody>
						            <c:forEach var="result" items="${resultList}" varStatus="status">
						            <tr>
						                <td>
						                <c:forEach items="${clippingSiteList }" var="site">
						                	<c:if test="${site.clippingSiteId == result.clippingSiteId }"><c:out value="${site.clippingSiteName }" /></c:if>
						                </c:forEach>
						                </td>
						                <td><a href="javascript:fn_egov_select('<c:out value="${result.clippingConfId}"/>')"><c:out value="${result.clippingConfName}"/></a></td>
						                <td>
						                ${result.isinited?'수집됨':'수집않됨' }
						                <a class="btn btn-small" onclick="fn_init('<c:out value="${result.clippingConfId}"/>')">
						                	<i class="icon-search"></i> 수집하기
						                </a>
						                </td>
						                <td>
						                <c:choose>
						                	<c:when test="${result.isinited }">
						                	${result.clippingConfPeriodUse?'실행중':'정지됨' }
						                	<a class="btn btn-small" onclick="fn_period_use('<c:out value="${result.clippingConfId}"/>','${result.clippingConfPeriodUse?'0':'1' }')">
						                		<i class="icon-${result.clippingConfPeriodUse?'stop':'play' }"></i> ${result.clippingConfPeriodUse?'실행중지':'실행설정' }
						                	</a>
						                	<a class="btn btn-small" onclick="fn_recent('<c:out value="${result.clippingConfId}"/>')">
						                		<i class="icon-search"></i> 즉시수집
						                	</a>
						                	</c:when>
						                	<c:otherwise>기초데이터를 먼저 수집해야합니다.</c:otherwise>
						                </c:choose>
						                </td>
						                <td><a href="javascript:fn_egov_select('<c:out value="${result.clippingConfId}"/>')"><fmt:formatDate value="${result.modified }" pattern="yyyy-MM-dd HH:mm:ss"/></a></td>
						                <td><a class="btn btn-small" href="javascript:fn_delete_alldata('<c:out value="${result.clippingSiteId}"/>','<c:out value="${result.clippingConfId}"/>')">데이터 초기화</a></td>
						            </tr>
						            </c:forEach>
						        </tbody>
						    </table>
						</div>
					</div>
				</div>
			</div>
			<div id="page_navi" class="pagination">
				<ul>
					<ui:pagination paginationInfo = "${paginationInfo}"
							   type="jnitDefault"
							   jsFunction="fn_egov_link_page"
							   />
				</ul>
			</div>
		</form>
	</div>
</div>

<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel"></h3>
	</div>
	<div class="modal-body">
	</div>
	<div class="modal-footer">
		<span id="actionBtn"></span>
		<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>		
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
