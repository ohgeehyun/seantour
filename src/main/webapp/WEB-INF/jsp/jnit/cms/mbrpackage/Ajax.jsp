<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/include/cms/header_ajax.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

$(document).ready(function(){
	
	var target = "${target}";
	var type = "${type}";
	
	if(target == 'mbr'){
		if(type == 'access'){
			$("[id*='choice']").on("click", function(e){
				e.preventDefault();

				var mbrAccessVal = $("#mbrAccess").val();
				var mbrLogin = $(this).val();
				
				if( mbrAccessVal != null && mbrAccessVal.indexOf(mbrLogin) != '-1'){
					alert("등록되어 있는 데이터입니다. \n※화면에 값이 없는데도 계속 등록되었다고 나오면 \n페이지를 새로고침 해주세요.");
					return false;
				}
				
				$("#mbrAccess").append("<option value='" + mbrLogin +"' selected='selected'>" + mbrLogin +"</option>");
				$("#mbrAccess").select2();
				
				$("#modal").modal("hide");
			});
		}else if(type == 'deny'){
			$("[id*='choice']").on("click", function(e){
				e.preventDefault();
				
				var mbrDenyVal = $("#mbrDeny").val();
				var mbrLogin = $(this).val();
				
				if(mbrDenyVal != null && mbrDenyVal.indexOf(mbrLogin) != '-1'){
					alert("등록되어 있는 데이터입니다. \n※화면에 값이 없는데도 계속 등록되었다고 나오면 \n페이지를 새로고침 해주세요.");
					return false;
				}
				
				var mbrLogin = $(this).val();
				
				$("#mbrDeny").append("<option value='" + mbrLogin +"' selected='selected'>" + mbrLogin +"</option>");
				$("#mbrDeny").select2();
				
				$("#modal").modal("hide");
			});
		}
	}else if(target == 'org'){
		
		if(type == 'access'){
			$("[id*='choice']").on("click", function(e){
				e.preventDefault();
				
				var thisVal = $(this).val();
				var split = thisVal.split(",");
				var orgId = split[0];
				var orgNm = split[1];
				
				var orgAccessVal = $("#orgAccess").val();
				
				if(orgAccessVal != null && orgAccessVal.indexOf(orgId) != '-1'){
					alert("등록되어 있는 데이터입니다. \n※화면에 값이 없는데도 계속 등록되었다고 나오면 \n페이지를 새로고침 해주세요.");
					return false;
				}
				
				$("#orgAccess").append("<option value='" + orgId +"' selected='selected'>" + orgNm +"</option>");
				$("#orgAccess").select2();
				
				$("#modal").modal("hide");
			});
		}else if(type == 'deny'){
			$("[id*='choice']").on("click", function(e){
				e.preventDefault();
				
				var thisVal = $(this).val();
				var split = thisVal.split(",");
				var orgId = split[0];
				var orgNm = split[1];
				
				var orgDenyVal = $("#orgDeny").val();
				
				if(orgDenyVal != null && orgDenyVal.indexOf(orgId) != '-1'){
					alert("등록되어 있는 데이터입니다. \n※화면에 값이 없는데도 계속 등록되었다고 나오면 \n페이지를 새로고침 해주세요.");
					return false;
				}
				
				$("#orgDeny").append("<option value='" + orgId +"' selected='selected'>" + orgNm +"</option>");
				$("#orgDeny").select2();
				
				$("#modal").modal("hide");
			});
		}
	}else if(target == 'pos'){
		
		if(type == 'access'){
			$("[id*='choice']").on("click", function(e){
				e.preventDefault();
				
				var thisVal = $(this).val();
				var split = thisVal.split(",");
				var posId = split[0];
				var posNm = split[1];
				
				var posAccessVal = $("#posAccess").val();
				
				if(posAccessVal != null && posAccessVal.indexOf(posId) != '-1'){
					alert("등록되어 있는 데이터입니다. \n※화면에 값이 없는데도 계속 등록되었다고 나오면 \n페이지를 새로고침 해주세요.");
					return false;
				}
				
				$("#posAccess").append("<option value='" + posId +"' selected='selected'>" + posNm +"</option>");
				$("#posAccess").select2();
				
				$("#modal").modal("hide");
			});
		}else if(type == 'deny'){
			$("[id*='choice']").on("click", function(e){
				e.preventDefault();
				
				var thisVal = $(this).val();
				var split = thisVal.split(",");
				var posId = split[0];
				var posNm = split[1];
				
				var posDenyVal = $("#posDeny").val();
				
				if(posDenyVal != null && posDenyVal.indexOf(posId) != '-1'){
					alert("등록되어 있는 데이터입니다. \n※화면에 값이 없는데도 계속 등록되었다고 나오면 \n페이지를 새로고침 해주세요.");
					return false;
				}
				
				$("#posDeny").append("<option value='" + posId +"' selected='selected'>" + posNm +"</option>");
				$("#posDeny").select2();
				
				$("#modal").modal("hide");
			});
		}
	}else if(target == 'type'){
		
		if(type == 'access'){
			$("[id*='choice']").on("click", function(e){
				e.preventDefault();
				
				var thisVal = $(this).val();
				var split = thisVal.split(",");
				var typeId = split[0];
				var typeNm = split[1];
				
				var typeAccessVal = $("#typeAccess").val();
				
				if(typeAccessVal != null && typeAccessVal.indexOf(typeId) != '-1'){
					alert("등록되어 있는 데이터입니다. \n※화면에 값이 없는데도 계속 등록되었다고 나오면 \n페이지를 새로고침 해주세요.");
					return false;
				}
				
				$("#typeAccess").append("<option value='" + typeId +"' selected='selected'>" + typeNm +"</option>");
				$("#typeAccess").select2();
				
				$("#modal").modal("hide");
			});
		}else if(type == 'deny'){
			$("[id*='choice']").on("click", function(e){
				e.preventDefault();
				
				var thisVal = $(this).val();
				var split = thisVal.split(",");
				var typeId = split[0];
				var typeNm = split[1];
				
				var typeDenyVal = $("#typeDeny").val();
				
				if(typeDenyVal != null && typeDenyVal.indexOf(typeId) != '-1'){
					alert("등록되어 있는 데이터입니다. \n※화면에 값이 없는데도 계속 등록되었다고 나오면 \n페이지를 새로고침 해주세요.");
					return false;
				}
				
				$("#typeDeny").append("<option value='" + typeId +"' selected='selected'>" + typeNm +"</option>");
				$("#typeDeny").select2();
				
				$("#modal").modal("hide");
			});
		}
	}
	
});

function fn_submit_form() {
	
	frm = document.getElementById("listForm");
	
	$.ajax({
		  type: "POST",
		  url: frm.action,
		  data: $("form#listForm").serialize(),
		  success:function(data) {
			  $('div#mbrSearch').html(data);
		  },
		  error:function(result) {
			
		  }
	});
	
	return false;
}

 // -->
</script>

<form:form commandName="searchVO" name="listForm" id="listForm" method="post" onsubmit="return fn_submit_form();">
 	<input type="hidden" name="target" value="${target}" />
 	<input type="hidden" name="type" value="${type}" />
 	
<table border="0" cellspacing="0" width="100%" cellpadding="0" class="table content2_table" summary="관리자 선택" style="color: #000;">
	<caption>관리자 선택</caption>
    <tbody>
        <tr>
            <td valign="top" style="border:0;">
            	<%-- JNITCMS_MBR HEAD --%>
            	<c:if test="${target == 'mbr'}">
	                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:0;">
	                    <tr>
	                        <td width="22%" style="border:0;">
	                            <select name="searchCondition">
	                            	<option value="4" <c:out value="${searchCondition == '4' ? 'selected' : ''}"/>>아이디</option>                                
	                                <option value="5" <c:out value="${searchCondition == '5' ? 'selected' : ''}"/>>이름</option>
	                            </select>
	                        </td>
	                        <td width="65%" align="center" style="border:0;"><input name="searchKeyword" value="<c:out value='${searchKeyword}'/>" type="text" style=" width:95%;"/></td>
	                        <td width="13%" align="center" style="border:0;vertical-align:middle;"><button class="btn btn-small">검색</button><%--<input type=image src='<c:url value="/resources/img" />/btn_search.gif' align=absmiddle>--%></td>                        
	                    </tr>
	                </table>
                </c:if>
                <%-- JNITCMS_ORG HEAD --%>
            	<c:if test="${target == 'org'}">
	                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:0;">
	                    <tr>
	                        <td width="22%" style="border:0;">
	                            <select name="searchCondition">
	                            	<option value="1" <c:out value="${searchCondition == '1' ? 'selected' : ''}"/>>부서명</option>                                
	                            </select>
	                        </td>
	                        <td width="65%" align="center" style="border:0;"><input name="searchKeyword" value="<c:out value='${searchKeyword}'/>" type="text" style=" width:95%;"/></td>
	                        <td width="13%" align="center" style="border:0;vertical-align:middle;"><button class="btn btn-small">검색</button><%--<input type=image src='<c:url value="/resources/img" />/btn_search.gif' align=absmiddle>--%></td>                        
	                    </tr>
	                </table>
                </c:if>
                
                <%-- JNITCMS_POS HEAD --%>
            	<c:if test="${target == 'pos'}">
	                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:0;">
	                    <tr>
	                        <td width="22%" style="border:0;">
	                            <select name="searchCondition">
	                            	<option value="1" <c:out value="${searchCondition == '1' ? 'selected' : ''}"/>>직급명</option>                                
	                            </select>
	                        </td>
	                        <td width="65%" align="center" style="border:0;"><input name="searchKeyword" value="<c:out value='${searchKeyword}'/>" type="text" style=" width:95%;"/></td>
	                        <td width="13%" align="center" style="border:0;vertical-align:middle;"><button class="btn btn-small">검색</button><%--<input type=image src='<c:url value="/resources/img" />/btn_search.gif' align=absmiddle>--%></td>                        
	                    </tr>
	                </table>
                </c:if>
                <%-- JNITCMS_MBR_TYPE HEAD --%>
            	<c:if test="${target == 'type'}">
	                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:0;">
	                    <tr>
	                        <td width="22%" style="border:0;">
	                            <select name="searchCondition">
	                            	<option value="1" <c:out value="${searchCondition == '1' ? 'selected' : ''}"/>>유형명</option>                                
	                            </select>
	                        </td>
	                        <td width="65%" align="center" style="border:0;"><input name="searchKeyword" value="<c:out value='${searchKeyword}'/>" type="text" style=" width:95%;"/></td>
	                        <td width="13%" align="center" style="border:0;vertical-align:middle;"><button class="btn btn-small">검색</button><%--<input type=image src='<c:url value="/resources/img" />/btn_search.gif' align=absmiddle>--%></td>                        
	                    </tr>
	                </table>
                </c:if>
			</td>
		</tr>
			<tr>
               	<td style="border:0;">
               		<%-- JNITCMS_MBR HEAD --%>
               		<c:if test="${target == 'mbr'}">
	                    <table cellspacing="0" cellpadding="0" class="content2_table" style="width:100%;">
	                        <thead>
	                            <tr>
	                                <th align="center">아이디</th>
	                                <th align="center">이름</th>
	                                <th align="center">선택</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                        	<c:if test="${fn:length(resultList) < 1}">
	                        		<tr>
	                        			<c:if test="${searchKeyword != ''}">
	                        				<td colspan="3" style="text-align: center;">해당 데이터가 존재하지 않습니다.</td>
	                        			</c:if>
	                        			<c:if test="${searchKeyword == ''}">
	                        				<td colspan="3" style="text-align: center;">검색해주세요.</td>
	                        			</c:if>
	                        		</tr>
	                        	</c:if>
	                            <c:forEach var="result" items="${resultList}" varStatus="status">
	                                <tr>
	                                    <td align="center"><c:out value="${result.mbrLogin}"/></td>
	                                    <td align="center"><c:out value="${result.mbrNm}"/></td>
	                                    <td align="center">
	                                    	<button class="btn btn-mini" value="${result.mbrLogin}" id="choice">선택</button>
	                                    </td>
	                                </tr>
	                            </c:forEach>
	                        </tbody>
	                    </table>
					</c:if>
					<%-- JNITCMS_POS HEAD --%>
               		<c:if test="${target == 'pos'}">
	                    <table cellspacing="0" cellpadding="0" class="content2_table" style="width:100%;">
	                        <thead>
	                            <tr>
	                                <th align="center">직급명</th>
	                                <th align="center">선택</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                        	<c:if test="${fn:length(resultList) < 1}">
	                        		<tr>
	                        			<c:if test="${searchKeyword != ''}">
	                        				<td colspan="2" style="text-align: center;">해당 데이터가 존재하지 않습니다.</td>
	                        			</c:if>
	                        			<c:if test="${searchKeyword == ''}">
	                        				<td colspan="2" style="text-align: center;">검색해주세요.</td>
	                        			</c:if>
	                        		</tr>
	                        	</c:if>
	                            <c:forEach var="result" items="${resultList}" varStatus="status">
	                                <tr>
	                                    <td align="center"><c:out value="${result.posNm}"/></td>
	                                    <td align="center">
	                                    	<button class="btn btn-mini" value="${result.posId},${result.posNm}" id="choice">선택</button>
	                                    </td>
	                                </tr>
	                            </c:forEach>
	                        </tbody>
	                    </table>
					</c:if>
					<%-- JNITCMS_ORG HEAD --%>
               		<c:if test="${target == 'org'}">
	                    <table cellspacing="0" cellpadding="0" class="content2_table" style="width:100%;">
	                        <thead>
	                            <tr>
	                                <th align="center">부서명</th>
	                                <th align="center">선택</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                        	<c:if test="${fn:length(resultList) < 1}">
	                        		<tr>
	                        			<c:if test="${searchKeyword != ''}">
	                        				<td colspan="2" style="text-align: center;">해당 데이터가 존재하지 않습니다.x</td>
	                        			</c:if>
	                        			<c:if test="${searchKeyword == ''}">
	                        				<td colspan="2" style="text-align: center;">검색해주세요.</td>
	                        			</c:if>
	                        		</tr>
	                        	</c:if>
	                            <c:forEach var="result" items="${resultList}" varStatus="status">
	                                <tr>
	                                    <td align="center"><c:out value="${result.orgNm}"/></td>
	                                    <td align="center">
	                                    	<button class="btn btn-mini" value="${result.orgId},${result.orgNm}" id="choice">선택</button>
	                                    </td>
	                                </tr>
	                            </c:forEach>
	                        </tbody>
	                    </table>
					</c:if>
					<%-- JNITCMS_MBR_TYPE HEAD --%>
               		<c:if test="${target == 'type'}">
	                    <table cellspacing="0" cellpadding="0" class="content2_table" style="width:100%;">
	                        <thead>
	                            <tr>
	                                <th align="center">유형명</th>
	                                <th align="center">레벨</th>
	                                <th align="center">선택</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                        	<c:if test="${fn:length(resultList) < 1}">
	                        		<tr>
	                        			<c:if test="${searchKeyword != ''}">
	                        				<td colspan="3" style="text-align: center;">해당 데이터가 존재하지 않습니다.</td>
	                        			</c:if>
	                        			<c:if test="${searchKeyword == ''}">
	                        				<td colspan="3" style="text-align: center;">검색해주세요.</td>
	                        			</c:if>
	                        		</tr>
	                        	</c:if>
	                            <c:forEach var="result" items="${resultList}" varStatus="status">
	                                <tr>
	                                    <td align="center"><c:out value="${result.typeNm}"/></td>
	                                    <td align="center"><c:out value="${result.typeLv}"/></td>
	                                    <td align="center">
	                                    	<button class="btn btn-mini" value="${result.typeId},${result.typeNm}" id="choice">선택</button>
	                                    </td>
	                                </tr>
	                            </c:forEach>
	                        </tbody>
	                    </table>
					</c:if>
           		</td>
       		</tr>
    </tbody>
</table>
       

</form:form>

<%@ include file="/WEB-INF/jsp/jnit/include/cms/footer.jsp" %>