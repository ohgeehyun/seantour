<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("lf", "\n"); %>
<%@ page import = "org.springframework.web.context.*, org.springframework.web.context.support.*, jnit.visit.log.JnitvisitlogImportController, egovframework.com.utl.fcc.service.NullUtil, org.json.simple.*, java.util.TreeMap, org.json.simple.parser.JSONParser"%>
<%@ page import = "jnit.cms.*, jnit.cms.mbr.*, jnit.cms.handler.*, egovframework.com.cmm.service.EgovProperties"%>
<% final String deDug = EgovProperties.getProperty("Globals.Debug"); %>
<%
WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletConfig().getServletContext());
CmsProperty cmsProperty = (CmsProperty)ctx.getBean("cmsProperty");
cmsProperty.setClientProperty(new CmsClientProperty());
CmsClientProperty cmsClientProperty = cmsProperty.getClientProperty();
cmsClientProperty.init(request);
request.setAttribute("ctxRoot",request.getContextPath());
//System.out.println(request);
//System.out.println("==>" + cmsClientProperty.request);
JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
%>
<% if(loginVO.getTypeId() == null) { %>
<script type="text/javascript">
/* TypeId is Null*/
	var request_uri = '<c:out value="${requestScope['javax.servlet.forward.request_uri']}" />';
	var context_path = '<c:out value="${requestScope['javax.servlet.forward.context_path']}" />';
	request_uri = request_uri.replace(context_path, '');

	location.replace('<c:url value="/cms/login.do"/>'+(request_uri ? '?returnUrl='+request_uri : ''));
</script>
<% return; } %>
<%
/* 관리자 레벨 */
final String admLevelProp = EgovProperties.getProperty(EgovProperties.getProperty("Webadm.Properties"), "Webadm.Levels");
final String[] admLevels = admLevelProp.split(",");
boolean loginAdmin = false;
for(int i1=0; i1<admLevels.length; i1++) {
	//System.out.println(admLevels[i1]);
        if(loginAdmin == false) {
                if(loginVO.getTypeVO().getTypeLv().equals(admLevels[i1])) {
                        loginAdmin = true;
                }
        }
}
if(!loginAdmin) { %>
<script type="text/javascript">
        var request_uri = '<c:out value="${requestScope['javax.servlet.forward.request_uri']}" />';
        var context_path = '<c:out value="${requestScope['javax.servlet.forward.context_path']}" />';
        request_uri = request_uri.replace(context_path, '');
        location.replace('<c:url value="/"/>');
</script>
<% return; } %>
<c:set var="globalListThumb" value="true"/>
<%--
<script src="<c:url value="/resources/js/jquery.min.js"/> "></script>
	 --%>
	<script type="text/javascript">
		var request_uri = '<c:out value="${requestScope['javax.servlet.forward.request_uri']}" />';
		var context_path = '<c:out value="${requestScope['javax.servlet.forward.context_path']}" />';
		request_uri = request_uri.replace(context_path, '');
		var menuId = '<c:out value="${menuId}" />';
	</script>


<script type="text/javaScript" language="javascript" defer="defer">
<!--
$(document).on("change",'#searchCondition',function(e){
	var con = $(this).val();
	var kwd = $('#searchKeyword').val();
	searchId(con,kwd);
});
$(document).on("keyup",'#searchKeyword',function(e){
	var con = $('#searchCondition').val();
	var kwd = $(this).val();
	searchId(con,kwd);
});
var searchId = function(con,kwd){
	kwd =  encodeURIComponent(kwd);
	$.getJSON('<c:url value="/cms/mbrtype/searchAjax.do" />',{searchCondition:con,searchKeyword:kwd},function(data){
		$('#typeId').empty();
		$.each(data,function(k,v){
			$('#typeId').append('<option value="'+v.typeId+'">['+v.typeId+'] '+v.typeNm+' : '+v.typeLv+'</option>');
		});
	});
};
var selectType = function(){
	var typeIdStr = "";
	var selectedItem = $('#typeId').val();
	$.each(selectedItem,function(k,v){
		typeIdStr += v + ','; 
	});
	
	var originData = $(parent.document).contents().find("#<c:out value="${domId}" />").val();
	$(parent.document).contents().find("#<c:out value="${domId}" />").val(originData + typeIdStr);
	$(parent.document).contents().find("#menuModal").attr('style','display:none;');
	$(parent.document).contents().find(".modal-backdrop").attr('style','display:none;');
	
};

var selectClose = function(){
	$(parent.document).contents().find("#menuModal").attr('style','display:none;');
	$(parent.document).contents().find(".modal-backdrop").attr('style','display:none;');
};
$(document).ready(function(){
	searchId('ajax','');
	
	
	
});
// -->
</script>
<style>
#typeId{width:100%;height:300px;}
</style>
<a href="javascript:selectType();" class="btn btn-small">추가</a>
<a href="javascript:selectClose();" class="btn btn-small">닫기</a>
<div class="view">
<!--콘텐츠시작-->
    <table border="0" cellspacing="0" cellpadding="0" class="table content2_table" summary="유형검색">
        <caption>유형검색</caption>
        <tbody>
        	<%--
            <tr>
                <th width="30%">
                	<select name="searchCondition" id="searchCondition">
                		<option value="ajax">유형명</option>
                	</select>
                </th>
                <td>
                	<input type="text" name="searchKeyword" id="searchKeyword" /> <a href="javascript:selectType();" class="btn btn-small">추가</a>
                </td>
            </tr>
             --%>
            <tr>
                <th colspan="2">Ctrl 키를 누르면 다중 선택 가능
                </th>
            </tr>
            <tr>
                <td colspan="2">
                	<select multiple="multiple" name="typeId" id="typeId">
                	</select>
                </td>
            </tr>
        </tbody>
    </table>
<!--콘텐츠끝-->
</div>
<!-- 검색조건 유지 -->