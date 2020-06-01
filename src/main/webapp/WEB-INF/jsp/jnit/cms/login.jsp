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
<%@ include file="/WEB-INF/jsp/jnit/_common/security_ipCheck.jsp" %>
<%	
	String message = request.getParameter("message");
	if(request.getParameter("message") != null){
		//String error =	new String(request.getParameter("message").getBytes("8859_1"),"UTF-8");
		String error =	request.getParameter("message");
		message = error;
	}	
%>
<c:set var="error" value="<%= message %>" />
<!DOCTYPE html>
<html lang="ko" xml:lang="ko">
    <head>
        <title>JNITCMS</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>" />
		<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap-responsive.min.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources/css/jnit.login.css"/>" />
		<!--[if IE 7]>
		<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/ie7_main.css"/>" />
		<![endif]-->
		<script src="<c:url value="/resources/js/jquery.min.js"/> "></script>
		<script type="text/javascript">
			var request_uri = '<c:out value="${requestScope['javax.servlet.forward.request_uri']}" />';
			var context_path = '<c:out value="${requestScope['javax.servlet.forward.context_path']}" />';
			request_uri = request_uri.replace(context_path, '');
			var menuId = '<c:out value="${menuId}" />';
		</script>
		    	
		<script type="text/javascript">
		// <c:out value="${hostdom}"/>
		
		var fn_login = function() {
			if( $('input[name=mbrLogin]').val() == "" ) {
				alert("아이디를 입력하세요.");
				return false;
			}
			if( $('input[name=passwd]').val() == "" ) {
				alert("패스워드를 입력하세요.");
				return false;
			}
			
			//$('form#loginForm').submit();
			return true;
		}
		$(document).ready(function(){
			//$('input[name=mbrLogin]').focus();
			
			  if("islock" == "<c:out value="${param.sess}"/>") {
			    if(confirm("중복로그인이 감지되었습니다.\n\n강제로 로그인하시겠습니까?") == true) {
			        location.href="/exeLoginSess.do";
			    }
			  }
		
		});
		</script>
		   			
		<style>
		body {
			background-color:#a4adb5;
			margin:0px;
		}
		form {
			margin:0px;
			padding:0px;
		}
		div.message {
			float:center;
			position:relative;
			top:230px;
			color:#ff9900;
		}
		</style>
    </head>
	<body>

<!-- Content -->
	  <div id="logo">
            <img src="<c:url value="/resources/img/logo.png"/>" alt="LTS JNITCMS" />
        </div>
	<div id="loginbox">
		<form name="loginForm" id="loginForm" class="form-vertical" action ="<c:url value='/exeLogin.do'/>" method="post" onsubmit="return fn_login(this)">
			<input type="hidden" name="returnUrl" value="/cms/" />
			<input type="hidden" id="refererUrl" name="refererUrl" value="/cms/"/>			
			<script type="text/javascript">
				 $(document).ready(function(){
					var pathname = document.location.pathname;
					var host = document.location.host;					
					$('#refererUrl').val("http://"+host+pathname);
				});
			//-->
			 </script>
			<p>&nbsp;</p>
			<c:if test="${error != null }">			
				<div class="alert" style="position: absolute; z-index: 100; top: 210px;">
				  <button type="button" class="close" data-dismiss="alert">&times;</button>
				  <strong>Warning!</strong> ${error } <%-- 로그인 정보가 올바르지 않습니다. --%>
				</div>
			</c:if>
			<div class="control-group">
                    <div class="controls">
                        <div class="input-prepend">
                            <span class="add-on"><i class="icon-user"></i></span><input type="text" placeholder="ID" name="mbrLogin" />
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <div class="input-prepend">
                            <span class="add-on"><i class="icon-lock"></i></span><input type="password" placeholder="PW" name="passwd" />
                        </div>
                    </div>
                </div>
                <div class="form-actions">
                    <span class="pull-right"><input type="submit" class="btn btn-inverse" value="Login" /></span>
                </div>
                <div class="control-group">
                    <div class="controls">                    
                		<span>관리자모드를 좀더 쉽고 빠르게 적용하실려면<br />
							구글프레임 플러그인 설치을 권장합니다. 
							<a href="http://www.ltskorea.co.kr/GoogleChromeframeStandaloneEnterprise.msi" target="_blank">(플러그인설치)</a>
							
						</span>
					</div>
				</div>
		</form>
	</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer_skeleton.jsp" %>

