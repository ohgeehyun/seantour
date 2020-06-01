// JavaScript Document


 
/*-----------------------------------------------------------------*/
// 나만의 일정 만들기
/*-----------------------------------------------------------------*/

 /*$(function() {
        $(".tab_con2").hide();
        $(".tab_con2").eq(0).show();
        $(".tab_mn2 > li:first").children("a").addClass('on');
        $(".tab_mn2 > li").click(function(){
            var index = $(".tab_mn2 > li").index(this);
            console.log(index);
            $(".tab_con2").hide();
            $(".tab_con2").eq(index).show();
            $(".tab_mn2 > li").children("a").removeClass('on');
            $(this).children("a").addClass('on');
        });
    });
 $(function() {
        $(".tab_con3").hide();
        $(".tab_con3").eq(0).show();
        $(".tab_mn3 > li:first").addClass('on');
        $(".tab_mn3 > li").click(function(){
            var index = $(".tab_mn3 > li").index(this);
            console.log(index);
            $(".tab_con3").hide();
            $(".tab_con3").eq(index).show();
            $(".tab_mn3 > li").removeClass('on');
            $(this).addClass('on');
        });
    });
 $(function() {
        $(".tab_con4").hide();
        $(".tab_con4").eq(0).show();
        $(".tab_mn4 > li:first").addClass('on');
        $(".tab_mn4 > li").click(function(){
            var index = $(".tab_mn4 > li").index(this);
            console.log(index);
            $(".tab_con4").hide();
            $(".tab_con4").eq(index).show();
            $(".tab_mn4 > li").removeClass('on');
            $(this).addClass('on');
        });
    });
   */ 
 /*-----------------------------------------------------------------*/
// content
/*-----------------------------------------------------------------*/
$(document).ready(function(){
	$(".map_day_route dd").hide();
	$(".map_day_route dd").eq(0).show();
	$(".map_day_route dt").eq(0).addClass("on");
	$(".map_day_route dt a").click(function(){
		var indexRoute = $(".map_day_route dt a").index(this);
		$(".map_day_route dd").hide();
		$(".map_day_route dd").eq(indexRoute).slideDown();
		$(".map_day_route dt").removeClass("on");
		$(".map_day_route dt").eq(indexRoute).addClass("on");		
	});
});

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
	var detailzone_slider = $('.detailzone .lst').bxSlider({
			mode: 'fade',//슬라이드 효과설정
			slideZIndex: 30,//
			//auto: true,
			autoHover: true,
			autoControls: false,//paly, stop, puase 슬라이드 컨트롤 버튼
			controls: false,
			//autoStart: false,
			pager: true
	});
	
	//바다여행 상세페이지
	var localzone_slider = $('.localzone .lst').bxSlider({
			mode: 'fade',//슬라이드 효과설정
			slideZIndex: 30,//
			auto: true,
			minSlides: 1,
			maxSlides: 1,
			autoHover: true,
			autoControls: false,//paly, stop, puase 슬라이드 컨트롤 버튼
			controls: false,
			//autoStart: false,
			pagerType: 'short'
	});
	//이전 버튼
	$( '.localzone .prev' ).on( 'click', function () {
		localzone_slider.goToPrevSlide(); 
		return false;              
	} );
	//다음 버튼
	$( '.localzone .next' ).on( 'click', function () {
		localzone_slider.goToNextSlide();
		return false;
	} );
	
	//$(".bx-controls-auto").click(function() { $(this).find("a").focus(); }); // 시작,정지 토글 키보드 접근시 포커스
	
	
});

/*-----------------------------------------------------------------*/
// detail Slider
/*-----------------------------------------------------------------*/
$(function(){
	$(".detail_info_area").hide();
	$(".result_list .more").click(function(){
		//===============================
		//DB에서 값을 가져와서 먼저 update 해놓을것 ajax.
		//===============================
		$(".detail_info_area").show();
	});
	
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
// tab_menu
/*-----------------------------------------------------------------*/
$(function() {
    $(".recommend_box").hide();
    $(".recommend_box").eq(0).show();
    $(".tab_menu > ul > li:first").children("a").addClass('on');
    $(".tab_menu > ul > li").click(function(){
        var index = $(".tab_menu > ul > li").index(this);
        console.log(index);
        $(".recommend_box").hide();
        $(".recommend_box").eq(index).show();
        $(".tab_menu > ul > li").children("a").removeClass('on');
        $(this).children("a").addClass('on');
    });
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
// status map
/*-----------------------------------------------------------------*/
$(function(){
	 var status = 'status';
	//지도 온표시
	$("#Map area").click(function(){
		$("#map-image").attr("src", "./images/content/map_"+$(this).attr("class")+".png");
		//console.log($(this).attr("class"));
	});
});	

$(function(){
	var mapTab = $('.selection_map');
	function onMapTab(e){
		e.preventDefault();
		var t = $(this);
		var myclass = t.attr('id');
		t.parents('.selection_map_area').attr('class', 'selection_map_area '+myclass);
	}
	mapTab.find('>map>area').click(onMapTab);
	//mapTab.find('>span').attr('class','map').click(onMapTab);
});	
/*-----------------------------------------------------------------*/
// FAQ
/*-----------------------------------------------------------------*/
$(function() {
    $(".closer_btn").on("click", function() {
        $(this).closest(".con_inner").slideToggle();
    });
    $("#faq_con ol li a").on("click", function() {
        $(this).toggleClass('on');
    });
});

function faq_open(el)
{
    var $con = $(el).closest("li").find(".con_inner");

    if($con.is(":visible")) {
        $con.slideUp();

    } else {
        $("#faq_con .con_inner:visible").css("display", "none");

        $con.slideDown(

        );
    }

    return false;
} 

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
// 프로토 타입 slider
/*-----------------------------------------------------------------*/
$(function() {
	
		$(".searchMenu .inner > a").click(function() {
			$(".tour_schedule_detail").stop().animate({
				"marginLeft" : "0"
			});
		});
		$(".tour_schedule_detail_close").click(function() {
			$(".tour_schedule_detail").stop().animate({
				"marginLeft" : "-290px"
				});
			});
		
			$(".checkbox_section").find("input[type='checkbox']").change(function(){
				if($(this).is(":checked")){
					console.log("checked");
					$(".tour_schedule_detail").stop().animate({
						"marginLeft" : "0"
					});
				}
			});
		
			$(".day_reset").click(function(){
				$(".tab_list").empty();
			});
			
			
		
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
		
$(document).ready(function(){
});