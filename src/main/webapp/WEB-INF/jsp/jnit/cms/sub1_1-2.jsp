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
<validator:javascript formName="jnitcmsposVO" staticJavascript="false" xhtml="true" cdata="false"/>

<c:if test="${registerFlag == '수정'}">
	<c:set var="PosLvValue" value="${jnitcmsposVO.posLv}"/>
</c:if>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitcmsposVO").action = "<c:url value='/cms/sub1/0101.do'/>";
   	document.getElementById("jnitcmsposVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitcmsposVO").action = "<c:url value='/cms/sub1/0102del.do'/>";
   	document.getElementById("jnitcmsposVO").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitcmsposVO");

	/* TODO Validation기능 보완 */
	//if(!validateJnitcmsposVO(frm)){
	//		return;
	//}
	
	<c:if test="${registerFlag == '수정'}">
		frm.action = "<c:url value='/cms/sub1/0102upexe.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/cms/sub1/0102add.do'/>";
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
                        	<h3>직급 등록</h3>
							<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
							<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
                        </div>
                        <div class="widget-content nopadding">
                        	<form:form commandName="jnitcmsposVO" >
                                <table class="table table-bordered table-striped th_left">
						        <tbody>
						            <tr>
						                <th style="width: 70px;"><font color="red">*</font> 직급코드</th>
						                <td>
						                
						                <c:if test="${registerFlag == '수정'}">
						                <c:out value='${jnitcmsposVO.posId}'/>
						                <input type="hidden" id="posId" name="posId" value="<c:out value='${jnitcmsposVO.posId}'/>" />
						                <input type="hidden" name="screenMode" value="up" />
						                </c:if>
						                <c:if test="${registerFlag == '등록'}">
						                <c:if test="${empty jnitcmsposVO.posId}">
						                <input readonly type="text" id="posId" name="posId" value="<c:out value='${nid}'/>" />
						                </c:if>
						                <c:if test="${not empty jnitcmsposVO.posId}">
						                <input readonly type="text" id="posId" name="posId" value="<c:out value='${jnitcmsposVO.posId}'/>" />
						                </c:if>
						                <input type="hidden" name="screenMode" value="" />
						                </c:if>
						                &nbsp;<form:errors path="posId" /></td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 직급명</th>
						                <td><form:input path="posNm" cssClass="txt"/>
						                &nbsp;<form:errors path="posNm" /></td>
						            </tr>
						            <tr>
						                <th>등급</th>
						                <td>
						                <select name="posLv" id="posLv">
						                <option value="1" <c:out value='${PosLvValue == "1" ? "selected" : "" }'/>>1</option>
						                <option value="2" <c:out value='${PosLvValue == "2" ? "selected" : "" }'/>>2</option>
						                <option value="3" <c:out value='${PosLvValue == "3" ? "selected" : "" }'/>>3</option>
						                <option value="4" <c:out value='${PosLvValue == "4" ? "selected" : "" }'/>>4</option>
						                <option value="5" <c:out value='${PosLvValue == "5" ? "selected" : "" }'/>>5</option>
						                <option value="6" <c:out value='${PosLvValue == "6" ? "selected" : "" }'/>>6</option>
						                <option value="7" <c:out value='${PosLvValue == "7" ? "selected" : "" }'/>>7</option>
						                <option value="8" <c:out value='${PosLvValue == "8" ? "selected" : "" }'/>>8</option>
						                <option value="9" <c:out value='${PosLvValue == "9" ? "selected" : "" }'/>>9</option>
						                <option value="10" <c:out value='${PosLvValue == "10" ? "selected" : "" }'/>>10</option>
						                </select>
						                &nbsp;<form:errors path="posLv" />                            
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
