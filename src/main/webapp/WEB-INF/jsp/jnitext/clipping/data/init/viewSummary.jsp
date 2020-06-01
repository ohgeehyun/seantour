<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ include file="/WEB-INF/jsp/jnit/_common/init.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#myModalLabel").html("<strong>${result.clippingDataListInitKey}페이지 수집결과 요약</strong>");
});
</script>
						    <table class="table table-bordered table-striped th_left" summary="수집사이트 등록">
						        <tbody>
						            <tr>
						                <th><font color="red">*</font> URL</th>
						                <td colspan="3"><c:out value="${result.clippingDataListInitUrl }" /></td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 메소드</th>
						                <td colspan="3"><c:out value="${result.clippingDataListInitMethod }" /></td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 파라메터</th>
						                <td colspan="3"><c:out value="${result.clippingDataListInitParam }" /></td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 페이지</th>
						                <td colspan="3"><c:out value="${result.clippingDataListInitKey }" /></td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 수집HTML</th>
						                <td colspan="3">
						                <textarea id="" name="" style="width:98%" rows="10"><c:out value="${result.clippingDataListInitHtml }" /></textarea>
						                </td>
						            </tr>
						        <c:if test="${confVO.clippingConfDetailUse }">
						        	<tr>
						        		<th colspan="4">상세수집관련</th>
						        	</tr>
						        	<tr>
						        		<th>상세수집리스트</th>
						        		<td colspan="3">
						        		<table class="table table-bordered table-striped table-hover" summary="키추가" style="margin-bottom: 0px;">
						                	<thead>
							                	<tr>
							                		<th>URL</th>
							                		<th>메소드</th>
							                		<th>파라메터</th>
							                		<th>키</th>
							                		<th>순서</th>
							                	</tr>
						                	</thead>
											<tbody>
											<c:forEach items="${result.detailList }" var="detail">
												<tr>
													<td><c:out value="${detail.clippingDataDetailInitUrl }" /></td>
													<td><c:out value="${detail.clippingDataDetailInitMethod }" /></td>
													<td><c:out value="${detail.clippingDataDetailInitParam }" /></td>
													<td><c:out value="${detail.clippingDataDetailInitKey }" /></td>
													<td><c:out value="${detail.clippingDataDetailInitOrder }" /></td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
						        		</td>
						        	</tr>
						        </c:if>
						    	</tbody>
						    </table>