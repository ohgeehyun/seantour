<%
/**
 *@version 3.2.0.1
 **/
%>
<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0); 
if (request.getProtocol().equals("HTTP/1.1")) 
response.setHeader("Cache-Control", "no-cache");
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("lf", "\n"); %>
<%@ page import = "org.springframework.web.context.*, org.springframework.web.context.support.*, jnit.visit.log.JnitvisitlogImportController, egovframework.com.utl.fcc.service.NullUtil, org.json.simple.*, java.util.TreeMap, org.json.simple.parser.JSONParser" %>
<%@ page import = "jnit.cms.*, jnit.cms.mbr.*, jnit.cms.handler.*, egovframework.com.cmm.service.EgovProperties, jnit.com.util.IpFilterUtil, jnit.cms.config.ConfigUtil,egovframework.com.cmm.service.Globals" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/security_ipCheck.jsp" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/menu_Check.jsp" %>
<%
	/* MENU Check */
	Boolean menuCheck = AdminUtil.menuCheck();
	String menuRetUrl = "/cms";
	//cms menu Access Check
	if(!menuCheck){
		out.print("<script type=\"text/javascript\"> alert(\"해당 컨텐츠에 접근권한이 없습니다.\"); location.href='"+menuRetUrl+"'; </script>");
		return;
	}
%>
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
                if(loginVO.getTypeVO().getTypeLv().equals(admLevels[i1]) || loginVO.getTypeVO().getTypeLv().equals("A")) {
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
<%
String cmsTitle = AdminUtil.getMenuName((String)request.getAttribute("menuId"));
cmsTitle = ("".equals(cmsTitle)) ? "" : " :: " + cmsTitle;
%>
<%
	//Boolean overlap = ConfigUtil.getDefaultProp();
	String overlap = ConfigUtil.getDefaultProp("overlap");
	String skinMode = ConfigUtil.getDefaultProp("skinMode");
%>
<c:set var="overlap" value="<%= overlap %>"/>
<c:set var="skinMode" value="<%= skinMode %>"/>
<c:set var="cmsTitle" value="<%=cmsTitle%>" />
<c:set var="isFilegoActive" value="<%=Globals.FILEGO_ACTIVE%>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
	<title>JNITCMS<c:out value="${cmsTitle}" /></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="author" type="text/plain" href="<c:url value="/humans.txt" />" />
	
	<!--[if IE 7]>
  		<link rel="stylesheet" href="<c:url value="/resources/css/font-awesome-ie7.min.css"/>" />
  		<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/ie7_main.css"/>" />
  	<![endif]-->
	 
	<%-- 기본(default) CSS --%>
	<c:if test="${empty skinMode || skinMode == 'default'}">
		<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/jnit.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/jnit.main.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/select.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/select2.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/js/codemirror-5.25.0/lib/codemirror.css" />" />
	</c:if>
	
	<%-- 블랙(balck) CSS --%>
	<c:if test="${skinMode == 'black'}">
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black//bootstrap.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/jnit.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/jnit.main.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/jquery-ui.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/select.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/select2.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/black/codemirror.css"/>" />
	</c:if>
	
	<%-- 화이트(white) CSS --%>
	<c:if test="${skinMode == 'white'}">
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/bootstrap.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/jnit.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/jnit.main.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/jquery-ui.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/select.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/cms/white/select2.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/js/codemirror-5.25.0/lib/codemirror.css" />" />
	</c:if>
	 
	<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap-responsive.css"/>" />
	<link rel="stylesheet" href="<c:url value="/resources/css/font-awesome.min.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/jnit.dashboard.css"/>" />
	<link rel="stylesheet" href="<c:url value="/resources/css/calendar.css"/>" />
	<link rel="stylesheet" href="<c:url value="/resources/css/color_picker.css"/>" />
	
	<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/> "></script>
	<script type="text/javascript" src="<c:url value="/resources/js/codemirror-5.25.0/lib/codemirror.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/codemirror-5.25.0/mode/xml/xml.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/codemirror-5.25.0/mode/css/css.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/codemirror-5.25.0/mode/javascript/javascript.js" />"></script>
	<style type="text/css">
		.CodeMirror {border: 1px solid black;}
		.activeline {background: #e8f2ff !important;}
	</style>
	<script type="text/javascript">
		function popGallery(num){
			var url = "tour_galley_main_0" + num + ".html";
			var popup = window.open(url, "tour", "width=585, height=600, scrollbars=no;");
			popup.focus();
		}
		
		function resizeEditor() {
			$('div.view').css('padding-left', 10);
			$('div.view').css('overflow', 'hidden');
			$('textarea[name=cntSrc]').css('height', $(window).height()-100);
			$('.CodeMirror').css('width', $(window).width()-300 );
			$('.CodeMirror').css('height', $(window).height()-500 );
			$('.CodeMirror-scroll').css('height', $(window).height()-500 );
			$('.CodeMirror-scrollbar').css('height', $(window).height()-500 );
		}
		
		var CodeEditor;
		var CodeHl;
		$(document).ready(function(){
			
				try {
					CodeEditor = CodeMirror.fromTextArea(document.getElementById("tplSrc"), {
					  mode: "application/xml",
					  lineNumbers: true,
					  lineWrapping: true,
					  onCursorActivity: function() {
					    CodeEditor.setLineClass(CodeHl, null, null);
					    CodeHl = CodeEditor.setLineClass(CodeEditor.getCursor().line, null, "activeline");
					  }
					});
					CodeHl = CodeEditor.setLineClass(0, "activeline");
					
					$('.CodeMirror').css('width', $(window).width()-400 );
					$('td.content_1').css('width', $(window).width()-550 );
					$('td.content_1').css('margin-right', '10px');
					$('.CodeMirror').css('height', $('textarea[name=tplSrc]').height()-10 );
					$('.CodeMirror-scroll').css('height', $('textarea[name=tplSrc]').height()-10 );
					$('.CodeMirror-scrollbar').css('height', $('textarea[name=tplSrc]').height()-10 );
					
					resizeEditor();
					$(window).bind('resize', resizeEditor);
				}catch(e) {
					//
				}
				
				try {
					CodeEditor = CodeMirror.fromTextArea(document.getElementById("cntSrc"), {
					  mode: "application/xml",
					  lineNumbers: true,
					  lineWrapping: true,
					  onCursorActivity: function() {
					    CodeEditor.setLineClass(CodeHl, null, null);
					    CodeHl = CodeEditor.setLineClass(CodeEditor.getCursor().line, null, "activeline");
					  }
					});
					CodeHl = CodeEditor.setLineClass(0, "activeline");
					
					$('.CodeMirror').css('width', $('textarea[name=cntSrc]').width() );
					$('.CodeMirror').css('height', $('textarea[name=cntSrc]').height()-10 );
					$('.CodeMirror-scroll').css('height', $('textarea[name=cntSrc]').height()-10 );
					$('.CodeMirror-scrollbar').css('height', $('textarea[name=cntSrc]').height()-10 );
				}catch(e) {
					//
				}
				
				//탑메뉴, 좌측 상단 탑메뉴 명칭 변경
				$('ul#leftMenuUl li a').on('click', function(){
					var thisObj = $(this);
					var spanObj = thisObj.find('span');			//span 오브젝트
					var iObj = thisObj.find('i');				//icon 오브젝트
					var iHtml = 
					
					
					$('ul#leftMenuUl li a').removeClass('on');	//탑메뉴 on 클래스 초기화 
					thisObj.addClass('on');						//탑메뉴 선택된 메뉴 on class 추가
					
					$('.sidetitle').show();						//선택된 메뉴가 없을때 hidden처리된 좌측메뉴 상단 메뉴명 show로 변경
					$('.sidetitle').empty().append(iObj[0].outerHTML+'&nbsp;'+spanObj.text());		//좌측메뉴 상단 선택된 메뉴명 표시
				});
		});
	</script>
	
	<script type="text/javascript">
		var request_uri = '<c:out value="${requestScope['javax.servlet.forward.request_uri']}" />';
		var context_path = '<c:out value="${requestScope['javax.servlet.forward.context_path']}" />';
		request_uri = request_uri.replace(context_path, '');
		var menuId = '<c:out value="${menuId}" />';
	</script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#manualOpen').click(function(e){
			e.preventDefault();
			/*
			var url = "http://ltskorea.co.kr/JNITCMS_manual.zip";
			window.open(url,"CMS메뉴얼", "width=721, height=900, toolbar=yes, scrollbars=yes");
			*/
			location.href="http://ltskorea.co.kr/JNITCMS_manual.zip";
		});
	});
</script>
</head>

<body>
<div id="header">
	<h1><a href="<c:url value="/cms/" />">LTS JNITCMS</a></h1>
</div>
<div id="user-nav" class="navbar navbar-inverse">
	<ul id="leftMenuUl" class="nav btn-group">
	<%
	AdminUtil.setGnb();
	%>
	<c:forEach items="${gnb}" var="d1" varStatus="status">
		<li class="btn btn-inverse"><a class="cmsMenu <c:out value="${fn:substring(menuId,0,3) == fn:substring(d1.key,0,3) ? 'on' : '' }" />" href="#!/${d1.key}/" data-menu-id="${d1.key}" ><i class="icon icon-${d1.value.icon}"></i><span class="txt">${d1.value.name}</span></a></li>
	</c:forEach>
	</ul>
</div>

<div id="sidebar">
	<label class="control-label" style="display:none;">사이트 선택</label>
	<div class="controls">           		
		<select name="sites" id="sites" class="noSelect2" onchange="sitesSelect(this.value);"></select>            	
	</div>
	<%
		request.setAttribute("menuAttr",AdminUtil.getMenuAttr(String.valueOf(request.getAttribute("menuId"))));
		request.setAttribute("topMenuAttr",AdminUtil.getMenuAttr(String.valueOf(request.getAttribute("menuId")).substring(0,3).concat("000000")));
	%>
	<p class="sidetitle" style="display: <c:out value="${topMenuAttr != null ? 'block' : 'none'}" /> "><i class="icon icon-<c:out value="${topMenuAttr.icon}" />"></i> <c:out value="${topMenuAttr.name}" /></p>
	<a href="<c:url value="${menuAttr.link}" />" class="visible-phone" id="leftMenuLink"><i class="icon icon-<c:out value="${menuAttr.icon}" />"></i><span><c:out value="${menuAttr.name}" /></span></a>
	<ul id="submenu">
		<%
		String menuId = String.valueOf(request.getAttribute("menuId"));
    	String topMenuId = menuId.substring(0,3) + "000000";
    	JSONObject data = (JSONObject) new JSONParser().parse(AdminUtil.getJSON());
    	TreeMap<String, JSONObject> dataMap = new TreeMap<String, JSONObject>();
    	TreeMap<String, JSONObject> treeMap = new TreeMap<String, JSONObject>();
    	dataMap = AdminUtil.jobj2map(dataMap, data);
    	treeMap = AdminUtil.map2treemap(dataMap, treeMap);
    	request.setAttribute("treeMap", treeMap.get(topMenuId));
		%>
		<%@ include file="/WEB-INF/jsp/jnit/_common/leftMenu.jsp" %>
	</ul>
</div>