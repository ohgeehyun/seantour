<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>


<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>			

<!--For Commons Validator Client Side-->
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="jnitcmsmbrtypeVO" staticJavascript="false" xhtml="true" cdata="false"/>

<c:if test="${registerFlag == '수정'}">
	<c:set var="TypeLvValue" value="${jnitcmsmbrtypeVO.typeLv}"/>
</c:if>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitcmsmbrtypeVO").action = "<c:url value='/cms/sub2/0201.do'/>";
   	document.getElementById("jnitcmsmbrtypeVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitcmsmbrtypeVO").action = "<c:url value='/cms/sub2/0202del.do'/>";
   	document.getElementById("jnitcmsmbrtypeVO").submit();		
}

function Jnit_delete(){
	if(confirm("정말 삭제하시겠습니까?")){
		$.ajax({
			type:"post",
			url:"<c:url value='/cms/sub2/ajax/delete.do'/>",
			data:"typeId="+$("#typeId").val()
		}).done(function(data){			
			var json = $.parseJSON(data);
			if(json.status == 'success'){
				alert("정상처리되었습니다");
				location.href= "<c:url value='/cms/sub2/0201.do'/>";
			}else{
				alert("삭제 할 수 없습니다. 유형코드를 참조하는 회원이 "+json.count+"명 있습니다.");				
			}
		});
	}
}
/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitcmsmbrtypeVO");

        /* ClientSite Validator */
	//if(!validateJnitcmsmbrtypeVO(frm)){
	//		return;
	//}

	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/cms/sub2/0202up.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/cms/sub2/0202add.do'/>";
	</c:if>
    frm.submit();

}

// -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
       	<div class="row-fluid">
           	<div class="span12">
               	<div class="widget-box">
                   	<div class="widget-title">
                   		<h3>유형 등록</h3>
                   		<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
						<c:if test="${registerFlag == '수정'}">
							<a href="javascript:Jnit_delete();" class="btn btn-small btn-del" style="float:right;"><i class="icon-minus-sign"></i> 삭제</a>
						</c:if>
                    </div>
					<div class="widget-content nopadding">
						<form:form commandName="jnitcmsmbrtypeVO">
						    <table class="table table-bordered table-striped th_left" summary="유형 등록">
						        <tbody>
						            <tr>
						                <th style="width:10%;"><font color="red">*</font> 유형코드</th>
						                <td>
						                
						                <c:if test="${registerFlag == '수정'}">
						                <c:out value='${jnitcmsmbrtypeVO.typeId}'/>
						                <input type="hidden" id="typeId" name="typeId" value="<c:out value='${jnitcmsmbrtypeVO.typeId}'/>" />
						                <input type="hidden" name="screenMode" value="up" />
						                </c:if>
						                <c:if test="${registerFlag == '등록'}">
						                <c:if test="${empty jnitcmsmbrtypeVO.typeId}">
						                <input readonly type="text" id="typeId" name="typeId" value="<c:out value='${nid}'/>" />
						                </c:if>
						                <c:if test="${not empty jnitcmsmbrtypeVO.typeId}">
						                <input readonly type="text" id="typeId" name="typeId" value="<c:out value='${jnitcmsmbrtypeVO.typeId}'/>" />
						                </c:if>
						                <input type="hidden" name="screenMode" value="" />
						                </c:if>
						                &nbsp;<form:errors path="typeId" />
						                
						                </td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 유형명</th>
						                <td>
						                <form:input path="typeNm" cssClass="txt"/>
						                &nbsp;<form:errors path="typeNm" />
						                </td>
						            </tr>
						            <tr>
						                <th>레벨</th>
						                <td>
						                <select name="typeLv" id="typeLv">
						                <option value="A" <c:out value='${TypeLvValue == "A" ? "selected" : "" }'/>>A</option>
						                <option value="B" <c:out value='${TypeLvValue == "B" ? "selected" : "" }'/>>B</option>
						                <option value="C" <c:out value='${TypeLvValue == "C" ? "selected" : "" }'/>>C</option>
						                <option value="D" <c:out value='${TypeLvValue == "D" ? "selected" : "" }'/>>D</option>
						                <option value="E" <c:out value='${TypeLvValue == "E" ? "selected" : "" }'/>>E</option>
						                <option value="F" <c:out value='${TypeLvValue == "F" ? "selected" : "" }'/>>F</option>
						                <option value="G" <c:out value='${TypeLvValue == "G" ? "selected" : "" }'/>>G</option>
						                <option value="H" <c:out value='${TypeLvValue == "H" ? "selected" : "" }'/>>H</option>
						                <option value="I" <c:out value='${TypeLvValue == "I" ? "selected" : "" }'/>>I</option>
						                <option value="J" <c:out value='${TypeLvValue == "J" ? "selected" : "" }'/>>J</option>
						                <option value="K" <c:out value='${TypeLvValue == "K" ? "selected" : "" }'/>>K</option>
						                <option value="L" <c:out value='${TypeLvValue == "L" ? "selected" : "" }'/>>L</option>
						                <option value="M" <c:out value='${TypeLvValue == "M" ? "selected" : "" }'/>>M</option>
						                <option value="N" <c:out value='${TypeLvValue == "N" ? "selected" : "" }'/>>N</option>
						                <option value="O" <c:out value='${TypeLvValue == "O" ? "selected" : "" }'/>>O</option>
						                <option value="P" <c:out value='${TypeLvValue == "P" ? "selected" : "" }'/>>P</option>
						                <option value="Q" <c:out value='${TypeLvValue == "Q" ? "selected" : "" }'/>>Q</option>
						                <option value="R" <c:out value='${TypeLvValue == "R" ? "selected" : "" }'/>>R</option>
						                <option value="S" <c:out value='${TypeLvValue == "S" ? "selected" : "" }'/>>S</option>
						                <option value="T" <c:out value='${TypeLvValue == "T" ? "selected" : "" }'/>>T</option>
						                <option value="U" <c:out value='${TypeLvValue == "U" ? "selected" : "" }'/>>U</option>
						                <option value="V" <c:out value='${TypeLvValue == "V" ? "selected" : "" }'/>>V</option>
						                <option value="W" <c:out value='${TypeLvValue == "W" ? "selected" : "" }'/>>W</option>
						                <option value="X" <c:out value='${TypeLvValue == "X" ? "selected" : "" }'/>>X</option>
						                <option value="Y" <c:out value='${TypeLvValue == "Y" ? "selected" : "" }'/>>Y</option>
						                <option value="Z" <c:out value='${TypeLvValue == "Z" ? "selected" : "" }'/>>Z</option>
						                </select>
						                <strong>CMS에 관련한 담당자에게는 레벨을 A 로 주셔야 합니다.</strong>
						                </td>
						            </tr>
						    	</tbody>
						    </table>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--콘텐츠끝-->
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
