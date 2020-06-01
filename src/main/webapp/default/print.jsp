<%
/**
 *@version 3.2.0.1
 **/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인쇄 페이지</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
{-CONFIG_CSS-}
{-CSS-}
<script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js'/>"></script>
{-CONFIG_JS-}
</head>
<body>
	<div id="middle">
		<div class="content">
			<div class="print_content">
				<div class="print">
					<a href="#wrap" onclick="print(); return false;">
						인쇄<img src="${pageContext.request.contextPath }/resources/img/Jnit_text_print.gif" alt="화면 인쇄"/>
					</a>
					<a href="#" onclick="javascript:window.close();">
						<img src="${pageContext.request.contextPath }/{-SITEPATH-}/common/img/scrap_del.gif" alt="인쇄 닫기" width="26px"/>
					</a>
				</div>
				<div class="pagetitle">페이지 타이틀 : {-PAGETITLE-}</div>
				<div class="pagelinknav">페이지 링크형 네비 : {-PAGELINKNAV-}</div>
				<div class="print_boby">
					{-PRINT_CONTENT-}
				</div>
			</div>
		</div>
	</div>
</body>
</html>