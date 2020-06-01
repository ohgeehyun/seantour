<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script type="text/javascript">
<!--

//검색
function Jnit_menuList(type){	
	$.ajax({
		type:"post",
		url:"<c:url value='/cms/ajax/cnt/list.do'/>",
		data:"type="+type
	}).done(function(data){		
		$("#listView").empty();
		$("#listView").append(data);
		$('#myModal').modal('toggle');
	});
}

function Jnit_save(){
	if(confirm("저장하시겠습니까?")){
		document.getElementById("jnitcmssearchVO").action = "<c:url value='/cms/search/save.do'/>";
		document.getElementById("jnitcmssearchVO").submit();
	}	
}

$(document).ready(function(){	
	
});
//-->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="jnitcmssearchVO">
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<h3>통합검색 설정</h3>
						<a href="javascript:Jnit_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered">
							<tr>
								<th colspan="2" style="width: 200px;">직원 검색 여부</th>
								<td>
									<select id="limitmbrYn" name="limitmbrYn">
										<option value="Y" <c:out value="${jnitcmssearchVO.limitmbrYn == 'Y' ? 'selected' : '' }"/>>사용함</option>
										<option value="N" <c:out value="${jnitcmssearchVO.limitmbrYn == 'N' ? 'selected' : '' }"/>>사용안함</option>
									</select>
								</td>
							</tr>
							<tr>
								<th colspan="2">콘텐츠 검색 여부</th>
								<td>
									<select id="limitCntYn" name="limitCntYn">
										<option value="Y" <c:out value="${jnitcmssearchVO.limitCntYn == 'Y' ? 'selected' : '' }"/>>사용함</option>
										<option value="N" <c:out value="${jnitcmssearchVO.limitCntYn == 'N' ? 'selected' : '' }"/>>사용안함</option>
									</select>
								</td>
							</tr>
							<tr>
								<th colspan="2">게시판 검색 여부</th>
								<td>
									<select id="limitBoardYn" name="limitBoardYn">
										<option value="Y" <c:out value="${jnitcmssearchVO.limitBoardYn == 'Y' ? 'selected' : '' }"/>>사용함</option>
										<option value="N" <c:out value="${jnitcmssearchVO.limitBoardYn == 'N' ? 'selected' : '' }"/>>사용안함</option>
									</select>
								</td>
							</tr>
							<tr>
								<th colspan="2">금칙어 <br /><strong>콤마(,) 구분하여 입력</strong></th>
								<td><textarea id="limitNm" name="limitNm" rows="10" style="width: 98%">${jnitcmssearchVO.limitNm }</textarea></td>
							</tr>
							<tr>
								<th rowspan="3" style="width: 50px;">콘텐츠</th>
								<th style="width: 150px;">검색기준</th>								
								<td>
									<select id="limitCntSite" name="limitCntSite">
										<option value="Y" <c:out value="${jnitcmssearchVO.limitCntSite == 'Y' ? 'selected' : '' }"/>>현재 사이트</option>
										<option value="N" <c:out value="${jnitcmssearchVO.limitCntSite == 'N' ? 'selected' : '' }"/>>전체 사이트</option>
									</select>
								</td>
							</tr>	
							<tr>
								<th>콘텐츠명 <a href="javascript:Jnit_menuList('CntNm')" class="btn btn-small">추가</a></th>								
								<td>
									<select id="limitCntNm" name="limitCntNm" multiple="multiple">
										<c:forTokens var="cntNm" items="${jnitcmssearchVO.limitCntNm }" delims=",">
											<option value="${cntNm }" selected="selected" >${cntNm }</option>
										</c:forTokens>
									</select>
								</td>
							</tr>	
							<tr>
								<th>콘텐츠 내용 <br /><strong>콤마(,) 구분하여 입력</strong></th>
								<td><textarea id="limitCntSrc" name="limitCntSrc" rows="10" style="width: 98%">${jnitcmssearchVO.limitCntSrc }</textarea></td>
							</tr>
							<tr>
								<th rowspan="4">게시판</th>
								<th>검색기준</th>								
								<td>
									<select id="limitBoardSiteYn" name="limitBoardSiteYn">
										<option value="Y" <c:out value="${jnitcmssearchVO.limitBoardSiteYn == 'Y' ? 'selected' : '' }"/>>현재 사이트</option>
										<option value="N" <c:out value="${jnitcmssearchVO.limitBoardSiteYn == 'N' ? 'selected' : '' }"/>>전체 사이트</option>
									</select>
								</td>
							</tr>	
							<tr>
								<th>게시판ID <a href="javascript:Jnit_menuList('BoardId')" class="btn btn-small">추가</a></th>
								<td>
									<select id="limitBoardId" name="limitBoardId" multiple="multiple">
										<c:forTokens var="boardId" items="${jnitcmssearchVO.limitBoardId }" delims=",">
											<option value="${boardId }" selected="selected" >${boardId }</option>
										</c:forTokens>
									</select>
								</td>
							</tr>																
							<tr>
								<th>게시판 제목 <br /><strong>콤마(,) 구분하여 입력</strong></th>
								<td>
									<textarea id="limitBoardTitle" name="limitBoardTitle" rows="10" style="width: 98%">${jnitcmssearchVO.limitBoardTitle }</textarea>
								</td>
							</tr>
							<tr>
								<th>게시판 내용 <br /><strong>콤마(,) 구분하여 입력</strong></th>
								<td>
									<textarea id="limitBoardContent" name="limitBoardContent" rows="10" style="width: 98%">${jnitcmssearchVO.limitBoardContent }</textarea>
								</td>
							</tr>
							<tr>
								<th rowspan="2">회원</th>
								<th>회원 번호<a href="javascript:Jnit_menuList('MbrId')" class="btn btn-small">추가</a></th>
								<td>
									<select id="limitMbrId" name="limitMbrId" multiple="multiple">
										<c:forTokens var="mbrId" items="${jnitcmssearchVO.limitMbrId }" delims=",">
											<option value="${mbrId }" selected="selected" >${mbrId }</option>
										</c:forTokens>
									</select>
								</td>
							</tr>							
							<tr>
								<th>회원유형 <a href="javascript:Jnit_menuList('MbrType')" class="btn btn-small">추가</a></th>
								<td>
									<select id="limitMbrType" name="limitMbrType" multiple="multiple">
										<c:forTokens var="mbrType" items="${jnitcmssearchVO.limitMbrType }" delims=",">
											<option value="${mbrType }" selected="selected" >${mbrType }</option>
										</c:forTokens>
									</select>
								</td>
							</tr>													
						</table>
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
							<b>DB 쿼리 방식의 게시판 의 금칙어 설정을 할 수 있는 페이지입니다.</b><br />
							<b>현재 자체 디자인 페이지는 제공하지 않으며 css를 제어하셔서 디자인 변경이 가능합니다.</b>
						</td>
					</tr>
					</tbody>
					</table>
				</div>
			</div>
		</div>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">Modal header</h3>
	</div>
	<div class="modal-body">
		<div id="listView"></div>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>		
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>