<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/init.jsp" %>
<script type="text/javascript">
function goList(){
	$("#saMode").val('list');
	$("#listForm").submit();
}

function goWrite(){
	$("#saMode").val('write');
	$("#listForm").submit();
}
function goDelete(){
	if(confirm('정말로 삭제하시겠습니까?')){
		$.ajax({
			type:"post",
			url:"<c:url value='/jnit/sample/index.do'/>",
			data:{saMode:"deleteAction",sampleId:$("#sampleId").val()},
			dataType : "json"
		}).done(function(data){			
			if(data.isSuccess == true){
				alert("정상처리되었습니다");
				location.href= "<c:url value='?'/>";
			}else{
				alert("삭제에 실패하였습니다.");				
			}
		});	
	}
}
</script>
<div class="adminWrap">
  <div class="sub09-1">
    <div class="admin-top">
      <h1>상세보기</h1>
    </div>
    <div class="admin-sub-top">
      <div class="btn-area">
        <div class="span3 listbtn">
          <a href="#" class="btn" onclick="goList();return false;">목록</a>
          <a href="#" class="btn" onclick="goWrite();return false;">수정</a>
      <c:if test="${isAdmin == 'isadmin'}">
          <a href="#" class="btn" onclick="goDelete();return false;">삭제</a>
      </c:if>
        </div>
      </div>
    </div>
    <div class="row-fluid ">
        <form id="listForm" action="">
          <input type="hidden" name="saMode" id="saMode" value="">
          <input type="hidden" name="sampleId" id="sampleId" value="<c:out value="${result.sampleId }" />">
          <input type="hidden" name="pageIdx" id="pageIdx" value="<c:out value="${empty param.pageIdx?'1':param.pageIdx }" />">
        </form>
          <div class="table-responsive">
            <table summary="상세정보입니다." class="table table-view">
              <caption>상세정보</caption>
              <colgroup>
                <col class="tablewidth12"/>
                <col class="tablewidth38"/>
                <col class="tablewidth12"/>
                <col class="tablewidth38"/>
              </colgroup>
              <tbody>
              	<tr>
              		<th>ID</th>
              		<td colspan="3"><c:out value="${result.sampleId}" /></td>
              	</tr>
              	<tr>
              		<th>TITLE</th>
              		<td colspan="3"><c:out value="${result.sampleTitle}" /></td>
              	</tr>
              </tbody>
            </table>
          </div>
          </div><!-- sub09-1 -->
        </div>
</div>