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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>반려</title>
<style>
body{margin:0;padding:0;font-size:12px;font-family:Dotum;color:#666;width:100%;}
div.wrap{padding:10px;}
select{width:100%;text-align:center;margin-bottom:10px;}
textarea{width:98%;margin-bottom:10px;}
p{width:100%;display:block;text-align:center;}
/* p a{display:block;} */
</style>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/>"></script>

<script type="text/javascript">
<!--
function fn_egov_close(){
	window.close();
}

function fn_egov_confirm_do(){		
	$.ajax({
		type : "post",
		url : "<c:url value='/cms/disseminate/confirm.do'/>",
		data : $("#memoForm").serialize()
	}).done(function(data){		
		var json = $.parseJSON(data);
		alert(json.message);
		opener.location.reload();
		window.close();
	});	
}

//-->
</script>
</head>
<body>

<form id="memoForm" name="memoForm" method="post" action="">
	<input type="hidden" name="anCntId" id="anCntId" value="${cntId }"/>
	<input type="hidden" name="anConfirm" id="anConfirm" value="${anConfirm }"/>
	<input type="hidden" name="anNum" id="anNum" value="${anNum }"/>
	<input type="hidden" name="anDisseminateId" id="anDisseminateId" value="${disseminateId }" />	
	<input type="hidden" name="mode" id="mode" value="${mode }" />
	
	<div class="wrap">	
		<c:if test="${mode == 'list' }">		
		 	<textarea title="${confirmStr } 사유 입니다." name="anMemo" id="anMemo" rows="10">${jnitminwonVO.minwonMemo }</textarea>   
		    <p><a href="javascript:fn_egov_close();"><img src="${pageContext.request.contextPath }/resources/img/work/btn_close.gif" alt="닫기" /></a></p>
		</c:if>
		<c:if test="${mode == 'edit' }">			
		    <c:out value="${confirmStr } 사유를 입력하세요" />
		    <textarea title="${confirmStr } 사유를 입력하세요" name="anMemo" id="anMemo" rows="10"></textarea>
		    <p>
		    	<c:if test="${confirmStr == '승인' }">
			    	<a href="javascript:fn_egov_confirm_do();"><img src="${pageContext.request.contextPath }/resources/img/work/btn_success.gif" alt="승인" /></a>
			    </c:if>
			    <c:if test="${confirmStr == '반려' }">
			    	<a href="javascript:fn_egov_confirm_do();"><img src="${pageContext.request.contextPath }/resources/img/work/btn_return.gif" alt="반려" /></a>
			    </c:if>
			    <a href="javascript:fn_egov_close();"><img src="${pageContext.request.contextPath }/resources/img/work/btn_close.gif" alt="닫기" /></a>
		    </p>
		</c:if>    
	</div>
</form>

</body>
</html>