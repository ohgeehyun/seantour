<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javascript">

$(document).ready(function(){
	$(document).find('#commandBox').hide();
	$('#myModal').modal('hide');
});

$(document).unload(function(){
	$(document).find('#commandBox').hide();
	$('#myModal').modal('hide');
});

var upFile = function() {
	<%--
	$(document).find('#commandBox').css('position', 'absolute');
	$(document).find('#commandBox').css('width', 300);
	$(document).find('#commandBox').css('height', 100);
	$(document).find('#commandBox').css('top', 40);
	$(document).find('#commandBox').css('left', 5);
	--%>
	
	$(document).find('#ifmCommand').attr('src', '<c:url value="/cms/file/upfile.do?bindType=${param.bindType}&dirType=${param.dirType}"/>');
	$(document).find('#commandBox').show();
	$('#myModal').modal('toggle');
}

var addFile = function() {
	<%--
	$(document).find('#commandBox').css('position', 'absolute');
	$(document).find('#commandBox').css('width', 290);
	$(document).find('#commandBox').css('height',100);
	$(document).find('#commandBox').css('top', 180);
	$(document).find('#commandBox').css('left', 180);
	--%>
	$(document).find('#ifmCommand').attr('src', '<c:url value="/cms/file/new.do?bindType=${param.bindType}&dirType=${param.dirType}"/>');
	$(document).find('#commandBox').show();
	$('#myModal').modal('toggle');
}

var delFile = function() {
	if($('ul.filelist li input:checked[type=checkbox]').size() > 0) {
		if(confirm("선택한 파일 "+$('ul.filelist li input:checked[type=checkbox]').size()+"개를 삭제하시겠습니까?") == true) {
			$('ul.filelist li input:checked[type=checkbox]').each(function(k, el){
				alert(el.value);
			});			
		}
	}else {
		alert('삭제할 파일을 체크하신 후 이용하세요.');
	}
}

var editName = function() {
	if($('ul.filelist li input:checked[type=checkbox]').size() > 1) {
		alert("이름을 변경할 파일을 1개만 선택하세요.");
		return;
	}
	
	$('ul.filelist li input:checked[type=checkbox]').each(function(k, el){
		alert(el.value);
	});
}

var editFile = function(file, mime) {
	$(parent.document).find('#ifmContent').attr('src', '<c:url value="/cms/file/view.do?bindType=${param.bindType}&dirType=${param.dirType}&fileName="/>'+file);
	/*
	if(mime.search('^text*') != -1) {
		alert('text');
		http://localhost:8080/suncheon/cms/file/view.do?bindType=all&dirType=file&fileName=test.txt
	}else if(mime.search('^image*') != -1) {
		alert('image');
		$(parent.document).find('#ifmContent').attr('src', '<c:url value="/${sitePath}"/>/common/file/'+file);
	}else if(mime.search('^image*') != -1) {
		alert('etc');
	}*/
}

</script>

<style>
	ul.filelist li {
		line-height:1.5em;
	}
	ul.filelist li input {
		margin-left:5px;
	}
	ul.filelist li a {
		margin-left:5px;
	}
	
	span.filesize {
		float:right;
		margin-right:5px;
	}
	div.list_content2{width:350px; height:100%; border:1px solid #a5a5a5; float:left;overflow:hidden;}
	div.view_content2{height:100%; border:1px solid #a5a5a5; overflow:hidden;}
	div.list_content2 {
		background-color: white;
	}
</style>
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	</div>
	<div class="modal-body">
		<iframe title="커맨드 아이프레임" id="ifmCommand" name="ifmCommand" style="width:100%; border:0px; height:100%;" frameborder="no"></iframe>
	</div>
</div>

	<div id="content">
		<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
		<div class="content_view container-fluid">
			<%-- Contents Start --%>
			<div class="list_content2">
			<div class="content_btn">
				<a class="btn btn-small" onclick="javascript:addFile();"><i class="icon icon-file"></i><span>생성</span></a>
				<%--
				<a class="btn btn-small" onclick="javascript:upFile();"><i class="icon icon-arrow-up"></i><span>업로드</span></a>
				
				<a class="btn btn-small" onclick="javascript:delFile();"><i class="icon icon-trash"></i><span>삭제</span></a>
				 --%>
				<a class="btn btn-small" onclick="javascript:location.reload();"><i class="icon-repeat"></i><span>새로고침</span></a>
			</div>
				<ul class="filelist">
				<c:forEach var="file" items="${files}" varStatus="status">
					<li>
					<input type="checkbox" value="<c:out value="${file.name}"/>"/><a href="javascript:editFile('<c:out value="${file.name}"/>','<c:out value="${file.mime}"/>');" title="<c:out value="${file.name}"/> 수정"><span class="filename"><c:out value="${file.name}"/></span></a>
					<span class="filesize"><fmt:formatNumber maxFractionDigits="1" minFractionDigits="1" value="${file.size}" />k</span>
					</li>
				</c:forEach>
				<c:if test="${empty files}">
					<li>파일 없음</li>
				</c:if>
				</ul>
				<%--
				<div id="commandBox" style="display:none;">
					<iframe title="커맨드 아이프레임" id="ifmCommand" name="ifmCommand" style="width:100%; border:0px; height:100%;" scrolling="yes" frameborder="no"></iframe>
				</div>
				 --%>
				
				
				
			</div>
			<div class="view_content2">
					<iframe title="뷰 아이프레임" id="ifmContent" name="ifmContent" style="width:100%; border:0px; height:540px;" scrolling="yes" frameborder="no"></iframe>
				
				<!-- 메뉴 & 콘텐츠 정보 수정 Ajax -->
				<%--
				<div id="attrEditor" style="width:100%;"></div>
				<div id="mbrSearch" style="width:400px; position:absolute;  display:none; top:250px; right:40px; background-color:#ffffff;"></div>
		 		--%>
			</div>
			<%-- Contents End --%>
		</div>
	</div>



<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>