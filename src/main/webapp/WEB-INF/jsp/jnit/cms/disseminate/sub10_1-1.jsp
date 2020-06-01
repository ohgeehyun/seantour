<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<%-- BackOffice & site 팝업 공용 --%>
<%@ include file="/WEB-INF/jsp/jnit/cms/disseminate/common/menuContent1_Script.jsp" %>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view">
		<%-- Contents Start --%>
		<div class="list_content2">
			<div class="content_btn">
				<a class="btn btn-small" href="javascript:addFolNode(getActNode());"><i class="icon icon-folder-open"></i><span>새 메뉴</span></a>
				<a class="btn btn-small" href="javascript:addConNode(getActNode());"><i class="icon icon-file"></i><span>새 콘텐츠</span></a>
				<a class="btn btn-small" href="javascript:editNode(getActNode());"><i class="icon icon-wrench"></i><span>수정</span></a>
				<a class="btn btn-small" href="javascript:delNode(getActNode());"><i class="icon icon-trash"></i><span>삭제</span></a>
				<a class="btn btn-small pull-right" href="javascript:rebuildTreeJson();"><i class="icon icon-share"></i><span>빌드</span></a>
			</div>
			
			<div class="content_in">
					<%--
				     <i class="icon icon-edit"></i><a href="#edit">메뉴명수정</a>
				     <i class="icon icon-edit"></i><a href="#del">삭제</a>
				     <i class="icon icon-edit"></i><a href="#folAdd">새 메뉴</a>
				     <i class="icon icon-edit"></i><a href="#conAdd">새 콘텐츠</a> 
				     --%> 
				<div id="tree" style="width: 350px; height: 803px;"> </div>
			</div>
			 
		</div>
		<!-- 메뉴 & 콘텐츠 정보 수정 Ajax -->
		<div class="view_content2">
			<div id="attrEditor" style="width:100%;"></div>
			
			<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				  <div class="modal-header">
				    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				  </div>
				  <div class="modal-body">
					<div id="mbrSearch"></div>
				  </div>
				</div>
			
			</div>
		<%-- Contents End --%>
	</div>
</div>

<div id="footer">
		<p>COPYRIGHT © 2017 JNITCMS. All Rights Reserved.</p>
</div>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.ui.datepicker-ko.js" /> "></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.ui.timepicker.addon.js" /> "></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.peity.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.flot.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.flot.resize.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.dataTables.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.uniform.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.fullcalendar.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.alphanumeric.pack.js"/> "></script>
	<script src="<c:url value="/resources/js/excanvas.min.js"/>" ></script>    
	<script src="<c:url value="/resources/js/bootstrap.js"/>" ></script>
	<script src="<c:url value="/resources/js/bootstrap-colorpicker.js"/>" ></script>
	<script src="<c:url value="/resources/js/select2.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jnit.form_common.js"/>" ></script>
	<script src="<c:url value="/resources/js/jnit.tables.js"/>" ></script>
	<script src="<c:url value="/resources/js/jnit.js" />" ></script>
	
	<div id="filegoModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="filegoModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="width:75%; left:30%; height: 550px; display: none;">
		<div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
	    <div class="modal-body" style="max-height: 450px; overflow: auto;">
	        
	    </div>
	</div>
</body>
</html>

<%--
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
--%>
