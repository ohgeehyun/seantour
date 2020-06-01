<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-top:1px solid #ffffff; border-bottom:1px solid #c7c7c7; background-color:#f1f1f1;" height="61">
    <tr>
        <td width="185" style="padding-left:9px;">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                	<td><strong>사이트선택</strong></td>
                </tr>
                <tr>
                	<td>
                	<div id="sites"></div>
                	<select name="sites" id="sites" onchange="sitesSelect(this.value);" style="width:140px;">
					</select>
                	</td>
                </tr>
            </table>
        </td>
        <td id="rsvMenu" style="padding-left:10px;">
        	<a href="<c:url value="/rsv" />/sub8/0101.do"><img src="<c:url value="/images/jnit/cms" />/topbut.gif"></a>
        </td>
        <td width="95" style="padding-left:10px;"><a href="<c:url value="/gis" />/sub10/010101.do"><img src="<c:url value="/images/jnit/cms" />/topbut3.gif"></a></td>
        <td width="95" style="padding-left:10px;"><a href="<c:url value="/cult" />/sub11/0101.do"><img src="<c:url value="/images/jnit/cms" />/top_but4.gif"></a></td>
        <td width="95" style="padding-left:10px;"><a href="<c:url value="/org" />/sub12/0101.do"><img src="<c:url value="/images/jnit/cms" />/top_but5.gif"></a></td>
        <td width="745" style="padding-left:10px;"><a href="<c:url value="/banner" />/index.do">알리미관리</a></td>
    </tr>
</table>

<script type="text/javascript">

var siteReloadStopMsg = "";
var siteReloadStop = false;
$(document).ready(function(){
	var parseUrl = document.createElement('a');
	parseUrl.href = location.href;
	
	if(parseUrl.hostname != "namdotours.net") {
		$('#qrMenu').show();
	}
	
	$.getJSON('<c:url value="/cms/sub3/0101ajax.do" />', '', function(data, status) {
		var items = [];
		
		items.push('<option value="">--- 사이트선택 ---</option>');	
		$.each(data.sites, function(k, v){
			items.push('<option value="'+k+'">'+v+'</option>');	
		});

		$('select[name=sites]').append(items.join(''));
		
		getSite();
    });
	
	var getSite = function() {
		$.getJSON('<c:url value="/cms/getSessSiteId.do" />', '', function(data, status) {
			//console.log(data.siteid);
			$('select[name=sites]').val( data.siteid );
			
			if($('select[name=sites]').val() != "") {
				$('tr.selectSiteMenuBtns').show();	
			}else {
				$('tr.selectSiteMenuBtns').hide();
			}
		});
	}
});
var sitesSelect = function(site) {
	if(siteReloadStop == true && siteReloadStopMsg != "") {
		alert(siteReloadStopMsg);
		$('select[name=sites]').val("");
		return;
	}
	$.getJSON('<c:url value="/cms/setSessSiteId.do?siteId='+ site +'" />', '', function(data, status) {
		//alert(data.siteid);
		if(siteReloadStop == false) {
			location.replace("<c:url value="/cms/" />");
		}
	});
}

</script>