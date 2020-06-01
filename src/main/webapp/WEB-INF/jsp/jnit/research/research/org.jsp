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
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=utf-8 />
<title>설문조사 대상그룹</title>
<script src="<c:url value="/js/research/jquery.min.js"/> "></script>
<script src="<c:url value="/js/research/jquery.ui.latest.custom.min.js"/> "></script>
<script src="<c:url value="/js/research/jquery.ui.datepicker-ko.js" /> "></script>
<script src="<c:url value="/js/research/jquery.ui.timepicker.addon.js" /> "></script>
<script src="<c:url value="/js/research/select2.min.js" /> "></script>
<script type="text/javascript">
<!--
var after_i = -1;
var search_val = '';
$(document).ready(function(){
	$('#searchBtn').click( function(){
		  if( !$('#searchKey').val() )
		  {
		   alert( "검색어를 입력해주세요.");
		   $('#searchKey').focus();
		   return false;
		  }
		  else
		  {
		   var s_item = $('#searchKey').val();
		  }

		  if( s_item != search_val )
		  {
		   after_i = -1;
		   search_val = s_item;
		  }

		  var scroll_height = $('#boardList').prop('scrollHeight'); // 셀렉트박스의 스크롤 길이
		  var this_count = $('#boardList option').size(); // 셀렉트박스의 count
		  var this_height = scroll_height/this_count;
		  var i = 0;

		  $('#boardList option').each( function(){ $(this).removeAttr('selected'); }); // 셀렉트 된것 해제

		  $('#boardList option').each( function(){
		   if( $(this).text().toLowerCase().indexOf( s_item.toLowerCase() ) >= 0 && i>after_i)
		   {
		    var tst = Math.round(this_height*i);
		    after_i = i;
		    $(this).attr("selected", "selected");
		    $('#boardList').scrollTop( tst );
		    return false;
		   }
		   if( after_i == i ) after_i = -1;
		   i++;
		  });
	});
});
$(document).on("change",'#searchBoardGroup',function(e){
	var group = $(this).val();
	var kwd = $('#searchKeyword').val();
	searchBoard(group,kwd);
});
$(document).on("keyup",'#searchKeyword',function(e){
	var group = $('#searchBoardGroup').val();
	var kwd = $(this).val();
	searchBoard(group,kwd);
});
var searchBoard = function(group,kwd){
	group =  encodeURIComponent(group);
	kwd =  encodeURIComponent(kwd);
	$.getJSON('<c:url value="/cms/board/searchAjax.do" />',{searchBoardGroup:group,searchCondition:'1',searchKeyword:kwd},function(data){
		$('#boardList').empty();
		$.each(data,function(k,v){
			$('#boardList').append('<option value="'+v.boardId+'">['+v.boardSkin+':'+v.boardType+'] '+v.boardTitle+'</option>');
		});
	});
};
var addBoard = function(){
	var selectedItem = $('#boardList').children("option:selected");
	$.each(selectedItem,function(k,v){
		if($('#tgBoardDp').children('option[value="'+$(v).val()+'"]').length<1){
			//alert($(v).val());
			var kwd = $(v).val();
			$('#targetList').append('<div id="'+kwd+'"></div>');
			if(kwd == '1750000'){
				$('#'+kwd).append('|국민안전처(전체)|');
			}else{
				$.getJSON('<c:url value="/research/org/searchAjax.do" />',{searchCondition:'1',searchKeyword:kwd},function(data){
					$.each(data,function(key,value){
						$('#'+kwd).append('|'+value.orgnztNm);
					});
				});
			}
			$('#tgBoardDp').append($(v).clone());
		}else{
			//alert("이미 추가된 부서는 제외되고 추가되었습니다.");
		}
	});
};
var removeBoard = function(){
	$('#tgBoardDp').children("option:selected").each(function(){
		$('#'+$(this).val()).remove();
	});
	$('#tgBoardDp').children("option:selected").remove();
};
var boardResult = function(){
	var result = "";
	var itemObj = $('#tgBoardDp').children("option");
	$.each(itemObj,function(k,v){
		result += $(v).val() + ',';
	});
	return result;
};
$(document).on("click",'#orgSubmit',function(e){
	$("#researchTarget",opener.document).children("option").remove();
	var selectedItem = $('#tgBoardDp').children("option").attr("selected","selected");
	$.each(selectedItem,function(k,v){
		//$("#researchTarget",opener.document).append($(v).clone());
		$("#researchTarget",opener.document).append("<option value='"+$(v).val()+"' selected=\"selected\" >"+$(v).text()+"</option>");
		
	});
	window.opener.selectPopActive();
	window.close();
});

$(document).on("change","#action", function(){
	var thisVal = $(this).val();
	
	if(thisVal == 'move_with_tracks'){
		$("#moveConfig").addClass("on");
		$("#moveConfig").show();
	}else{
		$("#targetUrl").val('http://');
		$("#comment").val('');
		$("#moveConfig").removeClass("on");
		$("#moveConfig").hide();
	}
});

// -->
</script>
<style>
#boardList{width:100%;height:300px;}
#tgBoardDp{width:100%;height:300px;}
.boardWrap .bbsView th {width:150px;}
.manage{border-collapse: collapse;width:800px;}
.manage th{color:#26231c;padding:3px 5px 5px 5px;height:32px; background:#ededed;border-bottom:1px solid #bebebe;}
.manage td{padding:3px 5px 5px 5px;height:32px;border-bottom:1px solid #bebebe;}
</style>
</head>
<body>
<input type="hidden" name="orgResult" value="" />
	<div class="boardWrap">
	<table class="manage" summary="부서 선택 테이블입니다.">
		<thead>
			<tr>
				<th colspan="3" class="title">부서 선택</th>
			</tr>
		</thead>
		<tbody>
		<tr>
			<th scope="col" class="field" style="width:350px;">부서 목록</th>
			<td rowspan="2" style="width:100px;" align="center">
				<p><a href="javascript:addBoard();">추가▶</a></p>
				<p><a href="javascript:removeBoard();">제거◀</a></p>
			</td>
			<th scope="col" class="field" style="width:350px;">대상 부서</th>
		</tr>
		<tr>
			<td>
				<input type="text" id="searchKey" value="" /><button id="searchBtn">검색</button>
                <select multiple="multiple" name="boardList" id="boardList">
	                <c:forEach var="groupResult" items="${result}" varStatus="status">
	                	<option value="<c:out value="${groupResult.orgnztId}"/>">
	                		<fmt:parseNumber var="descriptionLength" value="${fn:length(groupResult.descriptionid)/7}" integerOnly="true" />
	                			<c:forEach begin="0" end="${descriptionLength}">&nbsp;&nbsp;</c:forEach>
	                			<c:out value="${groupResult.orgnztNm}"/>
	                	</option>
	                </c:forEach>
                </select>
			</td>
			<td>
                <select multiple="multiple" name="tgBoardDp" id="tgBoardDp">
                </select>
			</td>
		</tr>
		<tr>
			<td colspan="3" align="center">
				<div id="targetList"></div>
			</td>
		</tr>
		<tr>
			<td colspan="3" align="center">
				<%-- 
				<input type="image" src="<c:url value="/images/jnit/cms/submitbut.gif" />" alt="적용" />
				--%>
				<button id="orgSubmit">적용</button>
			</td>
		</tr>
		</tbody>
	</table>
	</div>
</body>
</html>