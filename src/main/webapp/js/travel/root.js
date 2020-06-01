

/*-----------------------------------------------------------------*/
// 나의 여행지 만들기 일정 추가
/*-----------------------------------------------------------------*/
$(function() {
	var v_c = 1;
	var tab_mn =$(".day_lst > ul > li"); 
	var tab_mn_div =$(".day_lst > ul > li > div");
	tab_mn.hide().eq(0).show();
	tab_mn_div.hide().eq(0).show();
	$(".tab_close").hide();
	
	$(".tabh").click(function(){
		tab_mn_div.hide();
		$(this).next("div").show();
		$(this).css("border", "1px solid red");
		$(".tabh").not($(this)).css("border", "none");
	});
	
	
	
	$(".plus").click(function(){

		if ($(".day_lst > ul >li:visible").length >=7){
			alert("7일까지만 추가할 수 있습니다");
		}else{
			tab_mn.eq(v_c).show();
			tab_mn_div.eq(v_c).show();
			$(".tab_close").hide();
			$(".tab_close").eq(v_c).show();
			v_c +=1;
			$("#day_lst").removeClass();
			$("#day_lst").addClass("day_lst col"+v_c);
			
		}

	});
	
	$(".tab_close").click(function(e){
		$(this).parent("li").hide();
		v_c -=1;
		$("#day_lst").removeClass();
		$("#day_lst").addClass("tab_mn col"+v_c);
		$(".tab_close").hide();
		$(".tabh").eq(v_c-1).click();
		if(v_c !=1){
			$(".tab_close").eq(v_c-1).show();
		}
	});
	$(".ico_close").click(function(){
		$(this).parent("div").parent("li").hide();
	});	
	
	$(".day_delect").click(function(){
		$(".tab_list > li:visible").hide();
	});	
});
/*-----------------------------------------------------------------*/
// Box Slider
/*-----------------------------------------------------------------*/
$(function(){

	//나만의 일정 만들기 상세페이지
	/*var detailzone_slider = $('.detailzone .lst').bxSlider({
			mode: 'fade',//슬라이드 효과설정
			slideZIndex: 30,//
			//auto: true,
			autoHover: true,
			autoControls: false,//paly, stop, puase 슬라이드 컨트롤 버튼
			controls: false,
			//autoStart: false,
			pager: true
	});*/
	
	//$(".bx-controls-auto").click(function() { $(this).find("a").focus(); }); // 시작,정지 토글 키보드 접근시 포커스
	
	
});

/*-----------------------------------------------------------------*/
// detail Slider
/*-----------------------------------------------------------------*/
$(function(){
	$(".detail_info_area").hide();
	/*$(".result_list .more").click(function(){
		//===============================
		//DB에서 값을 가져와서 먼저 update 해놓을것 ajax.
		//===============================
		$(".detail_info_area").show();
	});*/
	
	$(".detail_info_area .close").click(function(){
		$(".detail_info_area").hide();
	});
	
	var schedule_slider = $('.tour_schedule_detail');
	var detail_info_slider = $('.detail_info_area');
	$(".tour_schedule_detail").on("click", ".btn_area a", function(){
		 schedule_slider.toggleClass("open");
	});
	/*
	$(".result_list .more").on("click", function(){
		 detail_info_slider.addClass("open");
	});
	$(".detail_info_area .close").on("click", function(){
		 detail_info_slider.removeClass("open");
	});*/
});


/*-----------------------------------------------------------------*/
// progrees bar
/*-----------------------------------------------------------------*/
$(function() {
   /*var barProgress = jQuery(".progressbar");
       

    // value 값의 숫자를 입력함으로서 내용을 채울 수 있다.

    barProgress.eq(0).progressbar({value:25});
    barProgress.eq(0).find(".ui-progressbar-value").css({"background":"#CC66CC"});
    barProgress.eq(1).progressbar({value:25});
    barProgress.eq(1).find(".ui-progressbar-value").css({"background":"#CC66CC"});
    barProgress.eq(2).progressbar({value:25});
    barProgress.eq(2).find(".ui-progressbar-value").css({"background":"#CC66CC"});
    barProgress.eq(3).progressbar({value:25});
    barProgress.eq(3).find(".ui-progressbar-value").css({"background":"#CC66CC"});
    */
});

/*-----------------------------------------------------------------*/
// drop and down
/*-----------------------------------------------------------------*/

$(function() {
	new Sortable(example3Left, {
	     group: 'shared',
	    animation: 150
	});
	
	new Sortable(example3Left2, {
	     group: 'shared',
	    animation: 150
	});
	new Sortable(example3Left3, {
	     group: 'shared',
	    animation: 150
	});
	new Sortable(example3Left4, {
	     group: 'shared',
	    animation: 150
	});
	new Sortable(example3Left5, {
	     group: 'shared',
	    animation: 150
	});
	new Sortable(example3Left6, {
	     group: 'shared',
	    animation: 150
	});
	new Sortable(example3Left7, {
	     group: 'shared',
	    animation: 150
	});
	
	new Sortable(example3Right, {
	    group: {
	        name: 'shared',
	        pull: 'clone',
			put: false // Do not allow items to be put into this list
	    },
	    animation: 150
	});
	/*new Sortable(example3Right2, {
	    group: {
	        name: 'shared',
	        pull: 'clone',
			put: false // Do not allow items to be put into this list
	    },
	    animation: 150
	});*/
	
});


/*-----------------------------------------------------------------*/
// memo
/*-----------------------------------------------------------------*/
$(document).ready(function(){
	$(".day_memo").click(function(){
		$(this).siblings("div").slideToggle();
	});
	$(".memo_btn .close").click(function(){
		$(".memo_box").hide();
	});
	
	$(".mob_day_memo").click(function(){
		$(this).siblings("div").center().slideToggle();
	});
	
	$(".memo_btn .close").click(function(){
		$(".mob_memo_box").hide();
	});
});

$.fn.center = function() {
	this.css({
		'position': 'fixed',
		'left': '50%',
		'top': '50%'
	});
	this.css({
		'margin-left': -this.outerWidth() / 2 + 'px',
		'margin-top': -this.outerHeight() / 2 + 'px'
	});

	return this;
}



/*-----------------------------------------------------------------*/
// 모바일 content
/*-----------------------------------------------------------------*/

//faq형태

$(document).ready(function(){
	$(".day_sc dd").hide();
	$(".day_sc:first dd").show();
	$(".day_sc dt a").click(function(){
		$(this).parent().parent().find("dd").stop(true,false).slideToggle();
		$(this).parent().parent().find("dt").toggleClass("on");
	});

});

$(document).ready(function(){
	$(".day_add a").click(function(){
		
	});

});
		
