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
<%@ page import="java.util.Date" %>
<%@ page import = "jnit.cms.*, jnit.cms.mbr.*, jnit.cms.handler.*, egovframework.com.cmm.service.EgovProperties"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<link href="<c:url value="/resources/menutree/structure/modules/infragistics.theme.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/menutree/structure/modules/infragistics.css"/>"  rel="stylesheet"/>

    
	
	<script src="<c:url value="/resources/menutree/modernizr-2.8.3.js"/>" ></script>
	<script src="<c:url value="/resources/menutree/jquery-1.11.3.min.js"/>" ></script>
	<script src="<c:url value="/resources/menutree/jquery-ui.min.js"/>" ></script>
	<script src="<c:url value="/resources/menutree/infragistics.core.js"/>" ></script>
	<script src="<c:url value="/resources/menutree/infragistics.lob.js"/>" ></script>
	<script src="<c:url value="/resources/menutree/waitingfor.js"/>" ></script>
	
    <!-- Ignite UI Required Combined JavaScript Files -->
    
    
	<script type="text/javascript">
	<!--
	function save() {	
		if(confirm("메뉴 순서를 변경하시겠습니까?")){
			if(menuSave()){
				/*
				frm = document.getElementById("menuChangeForm");
			 	frm.action = "<c:url value="/cms/menutree/menuChangeSave.do"/>";
			   	frm.submit();
			   	*/
			   	$(".blackbackground").show();
				$.ajax({
		 					type : "POST",
		 					url : "<c:url value="/cms/menutree/menuChangeSave.do"/>",
		 					cache : false,
		 					data : $("#menuChangeForm").serialize(),
		 					success: function(data)
		 		           	{
		 		            	alert("메뉴순서가 변경되었습니다.");
		 		            	location.href="/cms/";
		 		           	},
		 					error :  function(data)
			 		        {
			 		        	alert("메뉴순서를 변경하지 못하였습니다.");
			 		        }
				});
			}
		}
	}
	function onSuccess(json, status){alert($.trim(json));}
	function onError(data, status){alert("error");}
	function revert() {	
		if(confirm("메뉴 순서를 초기화 하시겠습니까?")){
			treeSet();
		}
	}
	 // -->
	</script>
<div class='blackbackground'style='display:none;background:#000; width:100%; height:100%;filter:alpha(opacity=50);-moz-opacity:0.5;-khtml-opacity: 0.5;opacity: 0.5; z-index:500;position:fixed;top:0;left:0;' >
	 <div style="position:absoulte;width:100%;height:100%;">
  		<img src="/resources/img/loading.gif" alt="처리중입니다." style="position: absolute;top: 0; bottom: 0;left:0; right: 0;margin: auto;width: 80px;height: 80px" />
	</div>
</div>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<div class="row-fluid">
           	<div class="span12">
               	<div class="widget-box">
                   	<div class="widget-title">
                       	<h3></h3>
                    	<a href="#" onclick="javascript:save(); return false;" class="btn btn-small"><i class="icon-ok-sign"></i>저장</a>
                        <a href="#" onclick="javascript:revert(); return false;" class="btn btn-small"><i class="icon-repeat"></i>되돌리기</a>
                    </div>
					
				</div>
				
				<div class="containerTree">
			        <div id="left" style="background-color: white;">
			            <!--igTree target element-->
			            <div id="menuTree"></div>
			        </div>
			        <div id="right">
			        
			        </div>
	   			</div>
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript">
    $(document).ready(function(){
    	treeSet();
    });
	    function treeSet(){
	   		var files = ${menuJson};
	   		$("#menuTree").igTree({
	               singleBranchExpand: true,
	               dataSource: $.extend(true, [], files),
	               dataSourceType: 'json',
	             // initialExpandDepth: 0,
	               pathSeparator: '.',
	               bindings: {
	                   textKey: 'menuName',
	                  	valueKey: 'file',
	                 //  imageUrlKey: 'ImageUrl',
	                  	primaryKey: 'menuCodeId',
	                   childDataProperty: 'child'
	               },
	               nodeClick: function(evt, ui) {
						//alert($(this));
	               },
	               dragAndDrop: true,
	               dragAndDropSettings: {
	                   allowDrop: true,
	                   customDropValidation: function (element) {
	                       // Validates the drop target
	                       var valid = true,
							droppableNode = $(this);
	
	                       if (droppableNode.is('a') && droppableNode.closest('li[data-role=node]').attr('data-value') === 'File') {
	                           valid = false;
	                       }
	                      
	                        if(element.closest('ul').attr('data-depth') != droppableNode.closest('ul').attr('data-depth')){
	                       	valid = false;
	                       }
	                       return valid;
	                   }
	               }
	    	});
	    }
	</script>
    
    <script type="text/javascript">
    	function depthValueSet(data){
    		if(data <= 9){
    			data = "0"+data
    		}
    		return data;
    	}
    	function depthTreeSet(ids,depthValue){
    		$("#menuChange").html();
    		var id = ids.split(".");
    		id = id[id.length-1];
    		var depthData = "00000000";
    		depthData = depthData.replace(depthData.substring(0,depthValue.length),depthValue);
    		
    		makeData = "<input type=\"hidden\" id=\""+id+"\" name=\""+id+"\" value=\"m"+depthData+"\" />";
    		
    		$("#menuChange").append(makeData);
    	}
    	function menuSave(){
    		  $.each($(".ui-igtree-collection > li"),function(index){
    				var depthValue="";
    				var parent1Value="";
    				depthValue=depthValueSet(index+1);
    				parent1Value=depthValue;
    				if($(this).attr("data-path") != null){
    					//console.log(index+" : "+$(this).attr("data-path") + " : "+depthValue +" : "+$(this).children("ul").children("li").size());
    					depthTreeSet($(this).attr("data-path"),depthValue);
    				}

    				$.each($(this).children("ul").children("li"),function(index){
    						depthValue=parent1Value+depthValueSet(index+1);
    						var parent2Value=depthValue;
    						//console.log(index+" : "+$(this).attr("data-path") + " : "+depthValue);
    						depthTreeSet($(this).attr("data-path"),depthValue);
    						$.each($(this).children("ul").children("li"),function(index){
    							depthValue=parent2Value+depthValueSet(index+1);
    							var parent3Value=depthValue;
    							//console.log(index+" : "+$(this).attr("data-path") + " : "+depthValue);
    							depthTreeSet($(this).attr("data-path"),depthValue);
    							$.each($(this).children("ul").children("li"),function(index){
    								depthValue=parent3Value+depthValueSet(index+1);
    								var parent4Value=depthValue;
    								//console.log(index+" : "+$(this).attr("data-path") + " : "+depthValue);
    								depthTreeSet($(this).attr("data-path"),depthValue);
    								$.each($(this).children("ul").children("li"),function(index){
	                        			depthValue=parent4Value+depthValueSet(index+1);
	                        			var parent5Value=depthValue;
	                        			//console.log(index+" : "+$(this).attr("data-path") + " : "+depthValue);
	                        			depthTreeSet($(this).attr("data-path"),depthValue);
    			   		 			});
    			   		 		});
    			   		 	});
    			    });
    			});
    		  return true;
    	}
    </script>
    <form:form name="menuChangeForm" id="menuChangeForm" >
    	<div id="menuChange" style="display:none;">
    	
    	</div>
    </form:form>
    
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.peity.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.flot.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.flot.resize.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.dataTables.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.fullcalendar.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jquery.plugins/jquery.alphanumeric.pack.js"/> "></script>
	<script src="<c:url value="/resources/js/excanvas.min.js"/>" ></script>    
	<script src="<c:url value="/resources/js/bootstrap.js"/>" ></script>
	<script src="<c:url value="/resources/js/bootstrap-colorpicker.js"/>" ></script>
	<script src="<c:url value="/resources/js/select2.min.js"/>" ></script>
	<script src="<c:url value="/resources/js/jnit.tables.js"/>" ></script>
	<script src="<c:url value="/resources/js/jnit.js" />" ></script>
</body>
</html>