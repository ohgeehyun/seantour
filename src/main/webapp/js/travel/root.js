/*-----------------------------------------------------------------*/
// 모바일 맵
/*-----------------------------------------------------------------*/
// $(document).on('click', '#content .schedule_content .tab_mn > ul > li > a, #wizard-p-1 .schedule_content .tab_mn > ul > li > a', function() {
$(document).on('click', '.tab_mn > ul > li > a', function() {
	$('.tab_mn > ul > li > a').removeClass('on');
	$(this).addClass('on');
	$("#wizard-p-1 .schedule_content .cssSelect").hide();
	$(this).next('.cssSelect').show();
});
$(document).on('click', '#wizard-p-1 .schedule_content .cssSelect > button', function() {
	$(this).parent('.cssSelect').toggleClass('on');
});

$(function() {
	
		$("#wizard").steps({
             headerTag: "h2",
             bodyTag: "section",
             transitionEffect: "slideLeft",
             enablePagination: false //페이지네이션 비활성화
         });
		
		//tab_menu
		// var index =0;
		// $(".tab_mn > ul > li > a").eq(index).addClass("on");
		$("#content .schedule_content .tab_mn > ul > li > a").removeClass("on");
		$("#content .schedule_content .tab_mn > ul > li > a").eq(0).addClass("on");
		$("#content .schedule_content .cssSelect").hide();
		$("#content .schedule_content .cssSelect").eq(0).show();

		$("#wizard-p-1 .schedule_content .tab_mn > ul > li > a").removeClass("on");
		$("#wizard-p-1 .schedule_content .tab_mn > ul > li > a").eq(0).addClass("on");
		$("#wizard-p-1 .schedule_content .cssSelect").hide();
		$("#wizard-p-1 .schedule_content .cssSelect").eq(0).show();

		//$(".cssSelect").hide();
		//$(".cssSelect").eq(index).show();
		// $("#content .schedule_content .cssSelect").hide();
		// $("#content .schedule_content .cssSelect").eq(index).show();
		
		//상단 이미지 클릭시 처리	
		// $(".cssSelect").prev("a").click(function(){
		/*$("#content .schedule_content .cssSelect").prev("a").click(function(){
			//console.log($(".cssSelect").prev("a").index($(this)));
			// index = $(".cssSelect").prev("a").index($(this));
			var index = $("#content .schedule_content .cssSelect").prev("a").index($(this));
			
			//이미지 표시
			// $(".tab_mn > ul > li > a").removeClass("on");
			// $(".tab_mn > ul > li > a").eq(index).addClass("on");
			//$("#content .schedule_content .tab_mn > ul > li > a").removeClass("on");
			//$("#content .schedule_content .tab_mn > ul > li > a").eq(index).addClass("on");
			
			//$(".cssSelect").eq(index).toggleClass("on");
			
			//아래쪽 목록표시
			// $(".cssSelect").hide();
			// $(".cssSelect").eq(index).show();
			$("#content .schedule_content .cssSelect").hide();
			$("#content .schedule_content .cssSelect").eq(index).show();
			
			//css표출
			// $(".cssSelect").removeClass("on");
			$("#content .schedule_content .cssSelect").removeClass("on");
			//$(".cssSelect").eq(index).addClass("on");
		});*/
		
		// $(".cssSelect").find("button").click(function(){
			// $(".cssSelect").eq(index).toggleClass("on");
		/*$("#content .schedule_content .cssSelect").find("button").click(function(){
			$(this).css('border', '1ps solid red');
			var index = $("#content .schedule_content .cssSelect").find("button").index($(this));
			console.log(index);
			$("#content .schedule_content .cssSelect").removeClass("on");
			$("#content .schedule_content .cssSelect").eq(index).addClass("on");
		});*/
		
		//
		$(".mob_detail_info_area").hide();
	    // $(".tbox").on("click", function() {
	    $(document).on("click", ".tbox", function(){
	        $(this).siblings(".mob_detail_info_area").slideToggle();
	    });
	    
	   //
		//$(".day_area").hide();
		//$(".first").show();
	    //// $(".day_title").on("click", function() {
	   // $(document).on("click", ".day_title", function(){
	    //    $(this).siblings(".day_area").slideToggle();
	   // });
	   
	    var map = $("#mob_map");
	    $(map).removeClass("open");
	    $(".mapView").click(function(){
			
			$(map).addClass("open");
			$("div.mapBg").show();
		});
	    
	    
	   // Get the modal
		var modal = document.getElementById("myModal");
		
		// Get the button that opens the modal
		var btn = document.getElementById("myBtn");
		
		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];
		
		// When the user clicks the button, open the modal 
		btn.onclick = function() {
		  modal.style.display = "block";
		}
		
		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
		  modal.style.display = "none";
		}
		
		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
		  if (event.target == modal) {
		    modal.style.display = "none";
		  }
		}
		

	});


/*-----------------------------------------------------------------*/
// 나의 여행지 만들기 일정 추가
/*-----------------------------------------------------------------*/
$(function() {
	var v_c = 1;
	var tab_mn =$(".day_lst > ul > li"); 
	var tab_mn_div =$(".day_lst > ul > li > div");
	// tab_mn.hide().eq(0).show();
	// tab_mn_div.hide().eq(0).show();
	$(".tab_close").hide();
	
	// $(".tabh").click(function(){
	$(".tabh").on("click", function(){
		tab_mn_div.hide();
		$(this).next("div").show();
		$(this).css("border", "1px solid red");
		$(".tabh").not($(this)).css("border", "none");

		var idx = $(".tabh").index($(this));
		$("div.day_tit").find("span").text(idx+1);
	});
	
	
	
	// $(".plus").click(function(){
	$(".plus").on("click", function(){

		if ($(".day_lst > ul >li:visible").length >=7){
			alert("7일까지만 추가할 수 있습니다");
		}else{
			//레이어 동적 변경사항(삭제)에 대응하기 위해 아래 라인 추가
			var idx = $("#day_lst>ul>li:visible").index($("#day_lst>ul>li:visible").last());
			v_c = idx + 1;
			tab_mn.eq(v_c).show();
			tab_mn_div.eq(v_c).show();
			$(".tab_close").hide();
			$(".tab_close").eq(v_c).show();
			v_c +=1;
			$("#day_lst").removeClass();
			$("#day_lst").addClass("day_lst col"+v_c);
			
		}

	});
	
	// $(".tab_close").click(function(e){
	$(".tab_close").on("click", function(){
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
	// $(".ico_close").click(function(){
	$(".ico_close").on("click", function(){
		$(this).parent("div").parent("li").hide();
	});	
	
	/***** 이 코드 때문에 Day 삭제 시 다른 레이어까지 display:none 되는 현상 발생 *****
	// $(".day_delect").click(function(){
	/*$(".day_delect").on("click", function(){
		$(".tab_list > li:visible").hide();
	});***************************************************************************/	
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
	    animation: 150,
	    sort: false,
	    filter: ".way-point-info"
		,onAdd: function (evt) {
			// console.log('added');
			// console.log(evt);
			addPointByDrag(evt);
		}
		,onUpdate: function (evt) {
			// console.log('updated');
			// console.log(evt);
		}
		,onChange: function (evt) {
			// console.log('changed');
			// console.log(evt);
		}
		,onClone: function (evt) {
			console.log('cloned');
			// var origEl = evt.item;
			// var cloneEl = evt.clone;
		}
		,onRemove: function (evt) {
			// console.log('removed');
		}
	});
	
	new Sortable(example3Left2, {
	    group: 'shared',
	    animation: 150,
	    sort: false,
	    filter: ".way-point-info"
		,onAdd: function (evt) {
			addPointByDrag(evt);
		}
	});
	new Sortable(example3Left3, {
	    group: 'shared',
	    animation: 150,
	    sort: false,
	    filter: ".way-point-info"
		,onAdd: function (evt) {
			addPointByDrag(evt);
		}
	});
	new Sortable(example3Left4, {
	    group: 'shared',
	    animation: 150,
	    sort: false,
	    filter: ".way-point-info"
		,onAdd: function (evt) {
			addPointByDrag(evt);
		}
	});
	new Sortable(example3Left5, {
	    group: 'shared',
	    animation: 150,
	    sort: false,
	    filter: ".way-point-info"
		,onAdd: function (evt) {
			addPointByDrag(evt);
		}
	});
	new Sortable(example3Left6, {
	    group: 'shared',
	    animation: 150,
	    sort: false,
	    filter: ".way-point-info"
		,onAdd: function (evt) {
			addPointByDrag(evt);
		}
	});
	new Sortable(example3Left7, {
	    group: 'shared',
	    animation: 150,
	    sort: false,
	    filter: ".way-point-info"
		,onAdd: function (evt) {
			addPointByDrag(evt);
		}
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
	$(".memo_btn .close, .memo_btn .add").click(function(){
		$(".memo_box").hide();
	});
	
	$(".mob_day_memo").click(function(){
		$(this).siblings("div").center().slideToggle();
	});
	
	$(".memo_btn .close, .memo_btn .add").click(function(){
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
		
