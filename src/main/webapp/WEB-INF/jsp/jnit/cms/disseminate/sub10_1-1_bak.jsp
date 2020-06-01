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
<script src="<c:url value="/resources/js/jquery.form.js"/> "></script>

  <script src="<c:url value='/js/dynatree-1.2.1' />/jquery/jquery-ui.custom.js" type="text/javascript"></script>
  <script src="<c:url value='/js/dynatree-1.2.1' />/jquery/jquery.cookie.js" type="text/javascript"></script>

  
  <script src="<c:url value='/js/dynatree-1.2.1'/>/src/jquery.dynatree.js" type="text/javascript"></script>
  <script src="<c:url value='/js/dynatree-1.2.1'/>/src/contextmenu/jquery.contextMenu-custom.js" type="text/javascript"></script>
  <link href="<c:url value='/js/dynatree-1.2.1'/>/src/contextmenu/jquery.contextMenu.css" rel="stylesheet" type="text/css" >

<script type="text/javascript">
var clipboardNode = null;
function addFolNode(node) {
	if(node == null) {
		node = $('#tree').dynatree("getRoot").childList[0];
	}
	if(node.data.menuislink == true) {
		alert('링크URL이 설정된 메뉴는 하위메뉴를 추가할 수 없습니다.');
		return false;
	}
	if(node.data.isFolder == true) {
		var newDepth = 0;
		if( parseInt( node.data.menudepth ) > -1 ) {
			newDepth = parseInt( node.data.menudepth ) + 1;
		}
		
		$.ajax({
			  type: "POST",
			  url: "<c:url value="/cms/sub10/0101add.do" />",
			  data: {
				  menuNm: "새 메뉴",
				  iscnt: "0",
				  pid: node.data.menuid,
				  depth: newDepth,
				  tplid: node.data.menutplid,
				  admid: node.data.menuadmid,
				  method:node.data.menumethod+node.countChildren()
			}
		}).done(function( msg ) {
		    	var newNode = node.addChild(JSON.parse(msg));
		    	node.expand(true);
		    	newNode.activate();
		    	newNode.focus();
		    	reloadDanaTree();
		});
	}else {
		alert('콘텐츠에는 하위메뉴를 추가할 수 없습니다.');
	}
	return;
}

function addConNode(node) {
	
	if(node == null) {
		alert('콘텐츠 추가할 메뉴를 선택하세요.');
		return false;
	}
	if(node.data.menuislink == true) {
		alert('링크URL이 설정된 메뉴는 콘텐츠를 추가할 수 없습니다.');
		return false;
	}
	if(node.data.root == true) {
		alert("최상위 메뉴에는 콘텐츠를 추가할 수 없습니다.");
		return false;
	}
	
	if(node.data.isFolder == true) {
		var newDepth = parseInt( node.data.menudepth ) + 1;
		
		$.ajax({
			  type: "POST",
			  url: "<c:url value="/cms/sub10/0101add.do" />",
			  data: { 
				  	menuNm: "새 콘텐츠",
				  	iscnt: "1",
				  	pid: node.data.menuid,
				  	depth: newDepth,
					tplid: node.data.menutplid,
					admid: node.data.menuadmid,
				  	method:node.data.menumethod+node.countChildren()
			  }
			  
		}).done(function( msg ) {
		    	var newNode = node.addChild(JSON.parse(msg));
		    	node.expand(true);
		    	newNode.activate();
		    	newNode.focus();
		    	reloadDanaTree();
		});
	}else {
		alert('콘텐츠를 추가할 메뉴를 선택하세요.');
	}
	return;
}

function editNode(node) {
 if(node.data.root == true) {
	  alert("최상위 메뉴는 수정할 수 없습니다.");
	  return;
 }
	
 var prevTitle = node.data.title,
 tree = node.tree;
 // Disable dynatree mouse- and key handling
 tree.$widget.unbind();
 // Replace node with <input>
 $(".dynatree-title", node.span).html("<input id='editNode' value='" + prevTitle + "'>");
 // Focus <input> and bind keyboard handler
 $("input#editNode")
   .focus()
   .keydown(function(event){
     switch( event.which ) {
     case 27: // [esc]
       // discard changes on [esc]
       $("input#editNode").val(prevTitle);
       $(this).blur();
       break;
     case 13: // [enter]
   	if( $("input#editNode").val().length < 1) {
   		$("input#editNode").val(prevTitle);	
   	}
       // simulate blur to accept new value
       $(this).blur();
       break;
     }
   }).blur(function(event){
     // Accept new value, when user leaves <input>
     var title = $("input#editNode").val();
     node.setTitle(title);
     
     if( title != prevTitle ) {
     	// DB 처리
  		$.ajax({
  			  type: "POST",
  			  url: "<c:url value="/cms/sub10/0101edit.do" />",
  			  data: {
  				  menuId: node.data.menuid,
  				  menuNm: title
  			}
  		});
  		loadEditorForm(node);
     	//console.log(title + " " + node.data.key);
     }
     
     // Re-enable mouse and keyboard handlling
     tree.$widget.bind();
     node.focus();
   });
}

function delNode(node) {	
	if(node.data.root == true) {
		alert("최상위 메뉴는 수정할 수 없습니다.");
		return;
	}

	var childNodeCount = 0;
	try{
		childNodeCount = node.childList.length;
	}catch(e) {
		//
	}
	if(childNodeCount > 0) {
		alert('하위메뉴 또는 콘텐츠가 존재하는 경우 삭제할 수 없습니다.');
		return;
	}
	
   	if(confirm(node.data.title + ' ' + (node.data.isFolder ? '메뉴를' : '콘텐츠를') + ' 정말 삭제하시겠습니까?')==true) {
   		//alert(node.data.title + " " + node.data.key);
   		
   		node.parent.activate();
   		$.ajax({
 			  type: "POST",
 			  url: "<c:url value="/cms/sub10/0101del.do" />",
 			  data: { menuId: node.data.menuid }
	  		}).done(function( msg ) {
	  			reloadDanaTree();
	  		});
   	}
   	
	return;
}

function getActNode(){
	return $("#tree").dynatree("getTree").getActiveNode();
}

var newNodeKey = "";
function rebuildTreeJson() {
	
	var $pJquery = window.parent.$;
	
	var dialog = '<div id="dialog" title="서버적용중" style="text-align:center;"><br /><br /><img src="<c:url value="/images/loading01.gif"/>" /></div>';
	if($pJquery('#dialog').length>0){
		$pJquery('#dialog').remove();
	}
	$pJquery('body').append(dialog);
	$pJquery('#dialog').dialog({
		modal: true,
		close: function( event, ui ) {
			$pJquery(this).dialog('destroy').remove();
		}
	});
	
	$.ajax({
		url:"<c:url value="/cms/sub10/0101getJson.do"/>",
		data:{
			rebuild:"true"
		},
		success:function(data) {
			if( $.trim(data) == 'OK' ) {
				$pJquery('#dialog').dialog("destroy");
				alert("내보내기 완료.");
			}
		}
	});
}
function initDanaTree(){
 // --- Initialize first Dynatree -------------------------------------------
 $("#tree").dynatree({
   initAjax: {
     url: "<c:url value="/cms/sub10/0101getJson.do"/>"
   },
   autoCollapse: false,
   clickFolderMode: 1,
   persist: true,
   onActivate: function(node) {
     $("#echoActivated").text(node.data.title + ", key=" + node.data.key);
   },
   onClick: function(node, event) {
     // Close menu on click
     if(node.data.isFolder == true) {
//   	  return false;
     }
     if( $(".contextMenu:visible").length > 0 ){
       $(".contextMenu").hide();
//       return false;
     }
     loadEditorForm(node);
   },
   onDblClick: function(node, event) {
       editNode(node);
       return false;
     },
   onKeydown: function(node, event) {
     // Eat keyboard events, when a menu is open
     if( $(".contextMenu:visible").length > 0 )
       return false;

     switch( event.which ) {
         
     case 113: // [F2]
       editNode(node);
       return false;
       break;

     case 46: // [DEL]
       delNode(node);
       return false;
       break;
       
     // Open context menu on [Space] key (simulate right click)
     case 32: // [Space] 
       $(node.span).trigger("mousedown", {
         preventDefault: true,
         button: 2
         })
       .trigger("mouseup", {
         preventDefault: true,
         pageX: node.span.offsetLeft,
         pageY: node.span.offsetTop,
         button: 2
         });
       return false;
	    break;
     }
   },
   /*Bind context menu for every node when it's DOM element is created.
     We do it here, so we can also bind to lazy nodes, which do not
     exist at load-time. (abeautifulsite.net menu control does not
     support event delegation)*/
   onCreate: function(node, span){
     bindContextMenu(span);
   },
   dnd: {
     preventVoidMoves: false, // Prevent dropping nodes 'before self', etc.
     onDragStart: function(node) {
       /** This function MUST be defined to enable dragging for the tree.
        *  Return false to cancel dragging of node.
        */
       return true;
     },
     onDragEnter: function(node, sourceNode) {
       /** sourceNode may be null for non-dynatree droppables.
        *  Return false to disallow dropping on node. In this case
        *  onDragOver and onDragLeave are not called.
        *  Return 'over', 'before, or 'after' to force a hitMode.
        *  Return ['before', 'after'] to restrict available hitModes.
        *  Any other return value will calc the hitMode from the cursor position.
        */
       // Prevent dropping a parent below another parent (only sort
       // nodes under the same parent)
       if(node.parent !== sourceNode.parent){
         return false;
       }
       

       // Don't allow dropping *over* a node (would create a child)
       return ["before", "after"];
     },
     onDrop: function(node, sourceNode, hitMode, ui, draggable) {
       /** This function MUST be defined to enable dropping of items on
        *  the tree.
        */
       sourceNode.move(node, hitMode);
       if(node.data.menuid != sourceNode.data.menuid) {
   		  $.ajax({
  			  type: "POST",
  			  url: "<c:url value="/cms/sub10/0101editMethod.do" />",
  			  data: {
  				  srcId: sourceNode.data.menuid,
  				  dstId: node.data.menuid
  			  }
	   	  }).done(function( msg ) {
		    	reloadDanaTree();
		  });
       }
       //console.log(node, sourceNode);
     }
   }
 });

 setTimeout('focusActNode()', 150);
}

function bindContextMenu(span) {
	$(span).contextMenu({menu: "myMenu"}, function(action, el, pos) {
	 var node = $.ui.dynatree.getNode(el);
	 switch( action ) {
	 case "edit":
	 		editNode(node);
			return false;
	 break;
	 case "del":
			delNode(node);
			return false;
	 break;
	 case "folAdd":
	 	return addFolNode(node);
	   break;
	 case "conAdd":
	 	return addConNode(node);
	   break;
	 default:
	   alert("명령어: '" + action + "'\n선택메뉴: " + node);
	 }
	});
}

var focusActNode = function() {
	try {
		node = $("#tree").dynatree("getTree").getActiveNode();
		if(node == null) {
			node = $('#tree').dynatree("getRoot").childList[0];
		}
		
		node.focus();
		node.activate();
		node.activateSilently();
		loadEditorForm(node);
	}catch(e) {
		//
	}
}

var loadEditorForm = function(node) {
	if(node.data.root == true) {
		$("div#attrEditor").html("");
		return;
	}
	
	if(node.data.menuid == "" || node.data.menuid == null) return;
	
	formUrl = "<c:url value="/cms/sub10/0101editForm.do" />";
	
	$.ajax({
		  type: "POST",
		  url: formUrl,
		  data: {
			  menuId: node.data.menuid
		  },
		  success: function(msg) {			 
			 //console.log(msg);
			 $("div#attrEditor").html(msg);
		  },
		  error: function(msg) {
			  $("div#attrEditor").html("<h2>로딩 실패! (Error Code: "+ msg.status +")</h2>");
		  }
	});
}

var reloadDanaTree = function() {
	$("#tree").dynatree("getTree").reload();
	setTimeout('focusActNode()', 150);
}

$(document).ready(function(){
	initDanaTree();
});
</script>

<style>
ul.dynatree-container
{
	font-family: 굴림, 돋움, arial, helvetica;
	font-size: 15px; /* font size should not be too big */
	white-space: nowrap;
	padding: 3px;
	margin: 0px; /* issue 201 */
	background-color: white;
	border: none;
	overflow: auto;
	height: 100%; /* issue 263 */
}
div.list_content2{width:350px; height:100%; border:1px solid #a5a5a5; float:left;overflow:hidden;}
div.view_content2{height:100%; border:1px solid #a5a5a5; overflow:hidden;}
div.list_content2 {
	background-color: white;
}

</style>
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
	
</body>
</html>

<%--
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
--%>
