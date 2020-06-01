<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script type="text/javascript">
<!--
function fn_egov_save() {	
	if($("#analyticsKeyFile").val() != null && $("#analyticsKeyFile").val() != ''){
		var fileExt = $("#analyticsKeyFile").val().slice($("#analyticsKeyFile").val().indexOf(".") + 1).toLowerCase();
		if(fileExt != "p12"){
			alert("p12 파일만 업로드 가능합니다.");
			return false;
		}
	}
	frm = document.getElementById("configForm");
	frm.action = "<c:url value='/cms/config/analyticsSave.do'/>";
    frm.submit();
}
$(document).ready(function(){	
});
//-->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
        	<div class="row-fluid">
            	<div class="span12">
                	<div class="widget-box">
                	<form id="configForm" name="configForm" method="post" action="<c:url value='/cms/config/analyticsSave.do'/>" enctype="multipart/form-data">
                    	<div class="widget-title">
                        	<span class="icon"><i class="icon-cog"></i></span>
                           <a href="javascript:fn_egov_save();" class="btn btn-small">저장</a>
                        </div>
                        <div class="widget-content nopadding">
	                           <table class="table table-bordered table-striped th_left">
	                               <tbody>
	                                   <tr>
	                                       <th style="width: 110px;">apiEmail</th>
	                                       <td><input type="text" name="apiEmail" style='width:98%;' value="<c:out value='${analytics["apiEmail"]}'/>" /></td>
	                                   </tr>
	                                   <tr>
	                                       <th>ApplicationName</th>
	                                       <td><input type="text" name="applicationName" style='width:98%;' value="<c:out value='${analytics["applicationName"]}'/>" /></td>
	                                   </tr>
	                                   <tr>
	                                       <th>view (profile) ID</th>
	                                       <td><input type="text" name="viewId" style='width:98%;' value="<c:out value='${analytics["viewId"]}'/>" /></td>
	                                   </tr>
	                                   <tr>
	                                       <th rowspan="2">analyticsKeyFile</th>
	                                       <td>
	                                          <input type="file" name="analyticsKeyFile" id="analyticsKeyFile"/>
	                                       </td>
	                                   </tr>
	                                   <tr>
	                                       <td>
	                                           <c:out value='${analytics["analyticsKeyFile"]}'/>
	                                       </td>
	                                   </tr>
	                               </tbody>
	                           </table>
                        </div>
                    </form>
                    </div>
                </div>
            </div>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>