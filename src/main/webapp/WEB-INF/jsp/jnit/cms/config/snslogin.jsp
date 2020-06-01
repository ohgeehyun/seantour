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
	frm = document.getElementById("configForm");
	frm.action = "<c:url value='/cms/config/snsloginSave.do'/>";
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
                	<form id="configForm" name="configForm" method="post" action="<c:url value='/cms/config/snsloginSave.do'/>" enctype="multipart/form-data">
                    	<div class="widget-title">
                        	<span class="icon"><i class="icon-cog"></i></span>
                            <button type="submit" class="btn btn-small"><i class="icon icon-ok"></i> 저장</button>
                        </div>
                        <div class="widget-content nopadding">
	                           <table class="table table-bordered table-striped th_left">
	                               <tbody>
	                                   <tr>
	                                       <th>facebookClientId</th>
	                                       <td><input type="text" name="facebookOauthId" style="width:330px" value="<c:out value='${snslogin["facebookOauthId"]}'/>" /></td>
	                                   </tr>
	                                   <tr>
	                                       <th>facebookClientSecret</th>
	                                       <td><input type="text" name="facebookOauthSecret" style="width:330px" value="<c:out value='${snslogin["facebookOauthSecret"]}'/>" /></td>
	                                   </tr>
	                                   <tr>
	                                       <th>googleClientId</th>
	                                       <td><input type="text" name="googleOauthId" style="width:330px" value="<c:out value='${snslogin["googleOauthId"]}'/>" /></td>
	                                   </tr>
	                                   <tr>
	                                       <th>googleClientSecret</th>
	                                       <td><input type="text" name="googleOauthSecret" style="width:330px" value="<c:out value='${snslogin["googleOauthSecret"]}'/>" /></td>
	                                   </tr>
	                                   <tr>
	                                       <th>twitterConsumerKey</th>
	                                       <td><input type="text" name="twitterOauthId" style="width:330px" value="<c:out value='${snslogin["twitterOauthId"]}'/>" /></td>
	                                   </tr>
	                                   <tr>
	                                       <th>twitterConsumerSecret</th>
	                                       <td><input type="text" name="twitterOauthSecret" style="width:330px" value="<c:out value='${snslogin["twitterOauthSecret"]}'/>" /></td>
	                                   </tr>
	                                   <tr>
	                                       <th>naverClientId</th>
	                                       <td><input type="text" name="naverOauthId" style="width:330px" value="<c:out value='${snslogin["naverOauthId"]}'/>" /></td>
	                                   </tr>
	                                   <tr>
	                                       <th>naverClientSecret</th>
	                                       <td><input type="text" name="naverOauthSecret" style="width:330px" value="<c:out value='${snslogin["naverOauthSecret"]}'/>" /></td>
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