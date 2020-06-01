<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/include/cms/header_ajax.jsp" %>
  
<script type="text/javaScript" language="javascript" defer="defer">
// <!--
function fn_egov_back() {	
	$.ajax({
		  type: "GET",
		  url: "<c:url value="${backurl}" />",
		  success:function(data) {
			$("div#attrEditor").html(data);
		  },
		  error:function(result) {
			//alert(result);
		  }
	});
}

// -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
		      <td><h2>메뉴 정보 입력</h2></td>
		    </tr>
		    <tr>
		      <td>
		          <table class="table"  width="100%" border="0" cellspacing="0" cellpadding="0" height="500px">
		            <tr>
		              <td width="93%" valign="top">
		                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="line-height:25px;" class="table content3_table">
							<tr>
								<td class="title">
									&nbsp; <c:out value="${msg}" />
								</td>
							</tr>
							<tr>
								<td align="center">
									<a href="javascript:fn_egov_back();">뒤로가기</a>
								</td>
							</tr>
		                </table>
		               
		              </td>
		            </tr>
		            
		          </table>
		
		      </td>
		    </tr>
		  </table>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
  