
$(document).ready(function(){
	$.getJSON('/_common/menu_owner.json', function(data) {
			var valStrs = "";
		  $.each(data, function(key, val) {
			   valStrs = "";
			  $.each(val, function(key, val) {
				  valStrs += ",\""+val+"\"";
			  });
			  $.globalEval( "var _" + key + " = ["+ valStrs.substring(1) + "];" );
		  });
		  
		if($.inArray(_thisId, _own01) != -1) {
			$('div#own01').show();
		}
		
		if($.inArray(_thisId, _own02) != -1) {
			$('div#own02').show();
		}
		
		if($.inArray(_thisId, _own03) != -1) {
			$('div#own03').show();
		}
	});
	
	var _thisId = $('body').attr('id').replace('uid_', '');
	
	if($.browser.msie != true) {
		console.log(_thisId);
	}else {
		//alert(_thisId);
	}
});