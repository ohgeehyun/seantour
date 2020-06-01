$(document).ready(function(){
	
	$("*[data-toggle='tooltip']").tooltip();
	
	$('#user-nav a').click(function(e){
		e.preventDefault();
		var menuId = $(this).data('menu-id');
		$.ajax({url: context_path + '/cms/helper/cmsMenu.do',data: {menuId: menuId}
		}).done(function(data){
			$('#submenu').empty();
			$('#submenu').html(data);
		});
	});
	$(document).on("click",'#submenu  li > a',function(e){
		e.preventDefault();
		
		var submenu = $(this).siblings('ul');
		var li = $(this).parent();
		if(submenu.length>0){
			
			//하위 뎁스가 있더라도 클릭한 메뉴에 link값이 있으면 페이지 이동
			var thisObj	= $(this);
			var aHref = thisObj.attr('href');
			if(aHref != null && aHref != ''){
				var postsubmit = document.createElement("form");
				postsubmit.setAttribute("method", "post");
				postsubmit.setAttribute("action", $(this).attr('href'));
				
				var postmenuId = document.createElement("input");
				postmenuId.setAttribute("type", "hidden");
				postmenuId.setAttribute("name", "menuId");
				postmenuId.setAttribute("value", $(this).data('menu-id'));
				postsubmit.appendChild(postmenuId);
				
				document.body.appendChild(postsubmit);
				postsubmit.submit();
			}
			
			//하위메뉴 열기
			if(li.hasClass('open')){
				if(($(window).width() > 768) || ($(window).width() < 479)) {
					submenu.slideUp();
				} else {
					submenu.fadeOut(250);
				}
				li.removeClass('open');
			} else {
				if(($(window).width() > 768) || ($(window).width() < 479)) {
					submenu.slideDown();
				} else {
					submenu.fadeIn(250);
				}		
				li.addClass('open');	
			}
		}else{
			var postsubmit = document.createElement("form");
			postsubmit.setAttribute("method", "post");
			postsubmit.setAttribute("action", $(this).attr('href'));
			
			var postmenuId = document.createElement("input");
			postmenuId.setAttribute("type", "hidden");
			postmenuId.setAttribute("name", "menuId");
			postmenuId.setAttribute("value", $(this).data('menu-id'));
			postsubmit.appendChild(postmenuId);
			
			document.body.appendChild(postsubmit);
			postsubmit.submit();
			
			//$(location).attr('href',$(this).attr('href'));
		}
	});


	
	var ul = $('#sidebar > ul');
	// === Resize window related === //
	$(window).resize(function()
	{
		if($(window).width() > 479)
		{
			ul.css({'display':'block'});	
			$('#content-header .btn-group').css({width:'auto'});		
		}
		if($(window).width() < 479)
		{
			ul.css({'display':'none'});
			fix_position();
		}
		if($(window).width() > 768)
		{
			$('#user-nav > ul').css({width:'auto',margin:'0'});
            $('#content-header .btn-group').css({width:'auto'});
		}
	});
	
	if($(window).width() < 468)
	{
		ul.css({'display':'none'});
		fix_position();
	}
	if($(window).width() > 479)
	{
	   $('#content-header .btn-group').css({width:'auto'});
		ul.css({'display':'block'});
	}
	
	// === Tooltips === //
	$('.tip').tooltip();	
	$('.tip-left').tooltip({ placement: 'left' });	
	$('.tip-right').tooltip({ placement: 'right' });	
	$('.tip-top').tooltip({ placement: 'top' });	
	$('.tip-bottom').tooltip({ placement: 'bottom' });	
	
	// === Search input typeahead === //
	$('#search input[type=text]').typeahead({
		source: ['Dashboard','Form elements','Common Elements','Validation','Wizard','Buttons','Icons','Interface elements','Support','Calendar','Gallery','Reports','Charts','Graphs','Widgets'],
		items: 4
	});
	
	// === Fixes the position of buttons group in content header and top user navigation === //
	function fix_position()
	{
		var uwidth = $('#user-nav > ul').width();
		$('#user-nav > ul').css({width:uwidth,'margin-left':'-' + uwidth / 2 + 'px'});
        
        var cwidth = $('#content-header .btn-group').width();
        $('#content-header .btn-group').css({width:cwidth,'margin-left':'-' + uwidth / 2 + 'px'});
	}
	
	// === Style switcher === //
	$('#style-switcher i').click(function()
	{
		if($(this).hasClass('open'))
		{
			$(this).parent().animate({marginRight:'-=220'});
			$(this).removeClass('open');
		} else 
		{
			$(this).parent().animate({marginRight:'+=220'});
			$(this).addClass('open');
		}
		$(this).toggleClass('icon-arrow-left');
		$(this).toggleClass('icon-arrow-right');
	});
	
	$('#style-switcher a').click(function()
	{
		var style = $(this).attr('href').replace('#','');
		$('.skin-color').attr('href','css/unicorn.'+style+'.css');
		$(this).siblings('a').css({'border-color':'transparent'});
		$(this).css({'border-color':'#aaaaaa'});
	});
	
	$("#leftMenuLink").click(function(e){
		e.preventDefault();		
		if($("#submenu").css("display") == "none"){
			$("#submenu").css("display","block");
		}else{
			$("#submenu").css("display","none");
		};
	});
});



var siteReloadStopMsg = "";
var siteReloadStop = false;
$(document).ready(function(){
	loadSite();
});

var loadSite = function() { 
	var parseUrl = document.createElement('a');
	parseUrl.href = location.href;
	
	$.getJSON(context_path + '/cms/sub3/0101ajax.do', '', function(data, status) {
		var items = [];
		
		items.push('<option value="">사이트를 선택하세요.</option>');
		var i = 0;
		$.each(data.sites, function(k, v){
			items.push('<option value="'+k+'">'+v+'</option>');	
		});
	
		$('select[name=sites]').html(items.join(''));
	
		getSite();
	});
};

var getSite = function() {
	$.getJSON(context_path + '/cms/getSessSiteId.do', '', function(data, status) {
		//$('select[name=sites]').val( data.siteid );
		
		if($.trim(data.siteid) != ""){
			$('select[name=sites]').find('option[value="'+data.siteid+'"]').attr("selected","selected");
		}else{
			$('select[name=sites]').find('option:eq(0)').attr("selected","selected");
		}
		if($('select[name=sites]').val() != "") {
			//$('tr.selectSiteMenuBtns').show();	
		}else {
			//$('tr.selectSiteMenuBtns').hide();
		}
		if(mobilecheck()){
			$('select[name=sites]').select2({
				placeholder: "사이트를 선택하세요.",
				minimumResultsForSearch: -1,
				width: '200px;'
			});
		}else{
			$('select[name=sites]').select2({
				placeholder: "사이트를 선택하세요.",
				width: '200px;'
			});
		}
		if($.trim(data.siteid) == ""){
			$('#s2id_sites .select2-choice span').text("사이트를 선택하세요.");
		}
	});
};
var sitesSelect = function(site) {
	$.getJSON(context_path + '/cms/setSessSiteId.do?siteId='+ site +'', '', function(data, status) {
			//location.replace(window.location.href);
			location.href=context_path+"/cms/sub10/0101.do";
	});
};
var mobilecheck = function() {
	  var check = false;
	  (function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
	  return check;
	};