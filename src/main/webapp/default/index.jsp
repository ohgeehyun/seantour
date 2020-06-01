<%
/**
 *@version 3.2.0.1
 **/
%>
{-STATE-}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>사이트이름</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
{-CONFIG_CSS-}

<script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js'/>"></script>
{-CONFIG_JS-}
</head>

<body>

<div id="wrap">
	<!-- header -->
	<div id="header">
    	<ul class="util">
    		<li><a href="${pageContext.request.contextPath }/${Jnit_sitePath}">HOME</a></li>
    		<c:if test="${loginVO.mbrId == null }">
	        	<li><a href="${pageContext.request.contextPath }/${Jnit_sitePath}/login.jsp">로그인</a></li>	            
            </c:if>
            <c:if test="${loginVO.mbrId != null }">
	        	<li><a href="${pageContext.request.contextPath }/uat/uia/actionLogout.do">로그아웃</a></li>
	            <li><a href="${pageContext.request.contextPath }/${Jnit_sitePath}/mbr/myPage.jsp">마이페이지</a></li>
        		<li><a href="javascript:Jnit_workspace('<c:url value="/disseminate/workspace.do?mode=pop&sitePath=${Jnit_sitePath }"/>');" title="새 창으로 열립니다.">내업무함</a></li>
	            <li><a href="#" onclick="window.open('${pageContext.request.contextPath }/sms/view/page.do', 'CLIENT_WINDOW', 'resizable=yes scrollbars=no width=1040 height=725');" title="새 창으로 열립니다.">SMS</a></li>
            </c:if>
        </ul>
    	<p class="header_txt">HEADER</p>
    </div>
    <!-- End of header -->
	<!-- middle -->
	<div id="middle">
    	<div class="visual">
        	VISUAL        	
        </div>
        <div class="board">
        	BOARD
        </div>
        <div class="allimy">
        	ALLIMY
        </div>
    </div>
    <!-- End of middle -->
	<!-- footer -->
	<div id="footer">
    	FOOTER
    </div>
    <!-- End of footer -->
</div>

</body>
</html>