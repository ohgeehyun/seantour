<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script type="text/javascript">
function goPage(p){
	$("#saMode").val('list');
	$("#dataId").val('');
	$("#pageIndex").val(p);
	$("#listForm").submit();
}

function goView(dataId){
	$("#saMode").val('write');
	$("#dataId").val(dataId);
	$("#listForm").submit();
}

function goWrite(dataId){
	$("#saMode").val('write');
	$("#dataId").val(dataId);
	$("#listForm").submit();
}
$(document).ready(function(){
});
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
	<form action="?" id="listForm" name="listForm" method="get">
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                   		<span style="float: left; margin-left: 5px;">
	                   			<a href="#none" onclick="goWrite('');return false;" class="btn"><i class="icon-plus-sign"></i>추가</a>
	                   		</span>
	                   		<span style="float: right; margin-right: 5px;">
	                   			<input type="text" name="searchKeyword" value="<c:out value="${param.searchKeyword }" />" />
					    		<input type="submit" class="btn btn-submit" value="검색">
					    	</span>
						</div>
					    <div class="widget-content nopadding">
							  <input type="hidden" name="searchCondition" value="2">
						      <input type="hidden" id=pageIndex name="pageIndex" value="<c:out value="${empty param.pageIndex?'1':param.pageIndex }" />" />
						      <input type="hidden" id="saMode" name="saMode" value="list">
						      <input type="hidden" id="dataId" name="dataId" value="" />
					          <div class="table-wrap">
					            <table summary="최근게시물 데이터 세팅  리스트입니다." class="table table-bordered table-striped table-hover">
					              <caption>최근게시물 데이터 셋 리스트</caption>
									<colgroup >
										<col style="width:7%" class="pc"/>
										<col style="width:57%" class="pc"/>
									</colgroup>
					              <thead>
									<tr>
										<th scope="col" class="pc">ID</th>
										<th scope="col" class="title pc">제목</th>
									</tr>
					              </thead>
					              <tbody>
					              <c:forEach items="${resultList }" var="result" varStatus="status">
					                <tr>
					                  <td class="pc">
					                  	<c:out value="${result.dataId }" />
					                  </td>
					                  <td class="title">
					                    <a href="#none" onclick="goView('${result.dataId}');return false;">
					                     <c:out value="${result.dataNm }" />
					                    </a>
					                  </td>
					                </tr>
					              </c:forEach>
					              </tbody>
					            </table>
					          </div>
						</div>
					 </div><!-- sub09-1 -->
				</div>
			</div>
			<div id="page_navi" class="pagination">
					<ui:pagination paginationInfo = "${paginationInfo}"
							   type="jnitDefault"
							   jsFunction="goPage"
							   />
            </div>
		 </form>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>