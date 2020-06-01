<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<script type="text/javascript">

$(document).ready(function(){
	$.ajax({
		url:"<c:url value="/cms/memo/get.do" />",
		cache:false,
		type: 'POST',
		success:function(data) {
			$("textarea#memo").val($.trim(data));
		}
	});

	$.ajax({
		url:"<c:url value="/cms/memo/gettime.do" />",
		cache:false,
		type: 'POST',
		success:function(data) {
			showSaveTime($.trim(data));
		}
	});
});

var  fillZero = function(s, n) {
	var zero = [];
	
	for (var i = 0; i < n; i++) {
		zero.push('0');
	}

	return (zero.join('') + s).slice(-n);
}

var clearMemo = function(){
	$.ajax({
		url:"<c:url value="/cms/memo/clear.do" />",
		type: 'POST',
		cache:false,
		success:function(data) {
			$("textarea#memo").val("");
			showSaveTime();
		}
	});
}

var saveMemo = function(){
	$.ajax({
		url:"<c:url value="/cms/memo/save.do" />",
		cache:false,
		type: 'POST',
		data: { memo:$("textarea#memo").val() },
		success:function(data) {
			$("textarea#memo").val($.trim(data));
			showSaveTime();
		}
	});
}

var showSaveTime = function(time){
	var curdate = new Date();
	if(time > 0) {
		curdate.setTime(time);
	}	
	$("span#lastUpdate").html(
		curdate.getFullYear()
		+"-"+fillZero(curdate.getMonth(),2)
		+"-"+fillZero(curdate.getDate(),2)
		+" "+fillZero(curdate.getHours(),2)
		+":"+fillZero(curdate.getMinutes(),2)
		+":"+fillZero(curdate.getSeconds(),2)
	);
}

</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
    <tr>
    <td height="1%" valign="top"><iframe src="http://inet.jnit.kr/export/notice.php" frameborder="0" scrolling="no" width="174" height="150" topmargin="0" leftmargin="0" marginheight="0" marginwidth="0"></iframe></td>
  </tr>
    <tr>
    <td  valign="top">
    	<table width="170" border="0" cellspacing="0" cellpadding="0" style="margin:5px 0 10px 5px; line-height:20px;" height="100%">
          <tr>
            <td height="1%" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td rowspan="2"><img src="<c:url value="/images/jnit/cms" />/memo_title.gif"></td>
                    <td colspan="2"><img src="<c:url value="/images/jnit/cms" />/memo_txt.gif"></td>
                  </tr>
                  <tr>
                    <td><a href="javascript:clearMemo();" title="모두지우기"><img src="<c:url value="/images/jnit/cms" />/memo_but1.gif"></a></td>
                    <td><a href="javascript:saveMemo();" title="저장"><img src="<c:url value="/images/jnit/cms" />/memo_but2.gif"></a></td>
                  </tr>
                </table>
                
            	<strong style="letter-spacing:-1px; font-size:8pt;">최종저장 : <span id="lastUpdate"></span></strong>
        
            </td>
          </tr>
          <tr>
            <td valign="top" align="center">
            	<textarea id="memo" style="border:0px; line-height:18px; background:url(<c:url value="/images/jnit/cms" />/memo_bg.gif) center top; width:100%; height:100%"></textarea>
            </td>
          </tr>
        </table>
    </td>
  </tr>
</table>