/*-----------------------------------------------------------------*/
// Box Slider
/*-----------------------------------------------------------------*/
$(function(){
	$('.btn-example').click(function(){
        var $href = $(this).attr('href');
        layer_popup($href);
    });
    function layer_popup(el){

        var $el = $(el);        //레이어의 id를 $el 변수에 저장
        var isDim = $el.prev().hasClass('dimBg');   //dimmed 레이어를 감지하기 위한 boolean 변수

        isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

        var $elWidth = ~~($el.outerWidth()),
            $elHeight = ~~($el.outerHeight()),
            docWidth = $(document).width(),
            docHeight = $(document).height();

        // 화면의 중앙에 레이어를 띄운다.
        if ($elHeight < docHeight || $elWidth < docWidth) {
            $el.css({
                marginTop: -$elHeight /2,
                marginLeft: -$elWidth/2
            })
        } else {
            $el.css({top: 0, left: 0});
        }

        $el.find('a.btn-layerClose').click(function(){
            isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
            return false;
        });

        $('.layer .dimBg').click(function(){
            $('.dim-layer').fadeOut();
            return false;
        });

    }
    
	//스팟존
	$('.spotzone .list').bxSlider({
			mode: 'fade',//슬라이드 효과설정
			slideZIndex: 30,//
			auto: true,
			autoHover: true,
			autoControls: true,//paly, stop, puase 슬라이드 컨트롤 버튼
			controls: true,
			autoControlsCombine: true,
			pager: true
			/*	onSliderLoad:  function (index){
			console.log("load",index);
			var $el_txt = $('.main_visual_content').eq(index);
			var y_pos = 0;

			TweenMax.set($el_txt, {autoAlpha:1});
			y_pos = 50;

			TweenMax.set($el_txt, {autoAlpha:1});
			TweenMax.fromTo($el_txt.find('.tit'), 1.5, {y:y_pos, autoAlpha:0}, {y: 0, autoAlpha:1, force3D:true, ease: Power1.easeOut, delay: 0.3});
			TweenMax.fromTo($el_txt.find('.sub_tit'), 1.5, {y:y_pos, autoAlpha:0}, {y: 0, autoAlpha:1, force3D:true, ease: Power1.easeOut, delay: 0.8});
			TweenMax.fromTo($el_txt.find('.img_lst'), 1.5, {y:y_pos, autoAlpha:0}, {y: 0, autoAlpha:1, force3D:true, ease: Power1.easeOut, delay: 1.5});
			TweenMax.fromTo($el_txt.find('div'), 1.5, {y:y_pos, autoAlpha:0}, {y: 0, autoAlpha:1, force3D:true, ease: Power1.easeOut, delay: 0.5});
			TweenMax.fromTo($el_txt.find('a'), 1.5, {y:y_pos, autoAlpha:0}, {y: 0, autoAlpha:1, force3D:true, ease: Power1.easeOut, delay: 0.7});

		},
		onSlideBefore: function($el_txt){
			console.log("after:", $el_txt)
			var y_pos = 50;

			TweenMax.set($el_txt, {autoAlpha:1});
			TweenMax.fromTo($el_txt.find('.tit'), 1.5, {y:y_pos, autoAlpha:0}, {y: 0, autoAlpha:1, force3D:true, ease: Power1.easeOut, delay: 0.3});
			TweenMax.fromTo($el_txt.find('.sub_tit'), 1.5, {y:y_pos, autoAlpha:0}, {y: 0, autoAlpha:1, force3D:true, ease: Power1.easeOut, delay: 0.8});
			TweenMax.fromTo($el_txt.find('.img_lst'), 1.5, {y:y_pos, autoAlpha:0}, {y: 0, autoAlpha:1, force3D:true, ease: Power1.easeOut, delay: 1.5});
			TweenMax.fromTo($el_txt.find('div'), 1.5, {y:y_pos, autoAlpha:0}, {y: 0, autoAlpha:1, force3D:true, ease: Power1.easeOut, delay: 0.5});
			TweenMax.fromTo($el_txt.find('a'), 1.5, {y:y_pos, autoAlpha:0}, {y: 0, autoAlpha:1, force3D:true, ease: Power1.easeOut, delay: 0.7});
		}	*/					
		
	});
	$(".bx-controls-auto").click(function() { $(this).find("a").focus(); }); // 시작,정지 토글 키보드 접근시 포커스
	
	
});
/*-----------------------------------------------------------------*/
$(function(){
	$.fn.slide = function(){
		// Common
		var $wrapSlick = $('.slickwrap'),
		$navSlick = $wrapSlick.find(".nav"),
		$prevSlick = $navSlick.find(".prev"),
		$nextSlick = $navSlick.find(".next"),
		$pauseSlick = $navSlick.find(".pause"),
		$playSlick = $navSlick.find(".play");
		$prevSlick.click(function(){
			$(this).closest('.slickwrap').find('.slider').slick('slickPrev');
		});
		$nextSlick.click(function(){
			$(this).closest('.slickwrap').find('.slider').slick('slickNext');
		});
		$playSlick.click(function(){
			$(this).closest('.slickwrap').find('.slider').slick('slickPlay');
			$(this).removeClass("active");
			$(this).closest('.slickwrap').find('.pause').addClass("active");
		});
		$pauseSlick.click(function(){
			$(this).closest('.slickwrap').find('.slider').slick('slickPause');
			$(this).removeClass("active");
			$(this).closest('.slickwrap').find('.play').addClass("active");
		});
};
	$.fn.slide();
});
//main_pull_slider
function main_pull_slider(){

    var $slider = $('.main_pull_slider');

    if( !$slider.length ){ return; }

    // init
    $slider.slick({
		slidesToShow: 1,
		slidesToScroll: 1,
        speed: 1000,
        autoplay: true,
        arrows: false,
        dots: false,
        //dotsClass: 'slick-dots',
        //appendDots: $(".main_event_wrap .area_ctrl"),
       adaptiveHeight: true,
        infinite: true,
        responsive: [
            {
                breakpoint: 769,
                settings: {
                    slidesToShow: 1
                }
            },
            {
	      breakpoint: 600,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1
	      }
	    },
	    {
	      breakpoint: 480,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1
	      }
	    }
        ]
	});

}
// main recommendation slider
function main_event_slider(){

    var $slider = $('.main_event_slider');

    if( !$slider.length ){ return; }

    // init
    $slider.slick({
		slidesToShow: 3,
		slidesToScroll: 1,
        speed: 1000,
        autoplay: true,
        arrows: false,
        dots: true,
        dotsClass: 'slick-dots',
        appendDots: $(".main_event_wrap .area_ctrl"),
       adaptiveHeight: true,
        infinite: true,
        responsive: [
            {
                breakpoint: 769,
                settings: {
                    slidesToShow: 2
                }
            },
            {
	      breakpoint: 600,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1
	      }
	    },
	    {
	      breakpoint: 480,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1
	      }
	    }
        ]
	});

    // controler
    $('.play').click(function(e){
        e.preventDefault();
        $slider.slick('slickPlay');
        $(this).hide();
		$(".pause").show();
    });
    $('.pause').click(function(e){
        e.preventDefault();
        $slider.slick('slickPause');
        $(this).hide();
		$(".play").show();
    });


}

// main recommendation slider
function main_writer_slider(){

    var $slider = $('.main_writer_slider');
	
    if( !$slider.length ){ return; }

    // init
    $slider.closest('.main_writer_slider').find(".pause").addClass("active");
    $slider.slick({
		slidesToShow: 1,
		slidesToScroll: 1,
        speed: 1000,
        autoplay: true,
        arrows: false,
        infinite: true,
        dots: true,
        //dotsClass: 'slick-dots',
       appendDots: $(".writer_recommend_box .area_ctrl"),
       adaptiveHeight: true,
        responsive: [
            {
                breakpoint: 769,
                settings: {
                    slidesToShow: 1
                }
            },
            {
	      breakpoint: 600,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1
	      }
	    },
	    {
	      breakpoint: 480,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1
	      }
	    }
        ]
	});

    // controler
    $('.play').click(function(e){
        e.preventDefault();
        $slider.slick('slickPlay');
        $(this).hide();
		$(".pause").show();
    });
    $('.pause').click(function(e){
        e.preventDefault();
        $slider.slick('slickPause');
        $(this).hide();
		$(".play").show();
    });

}
// main recommendation slider
function main_cont_slider(){

    var $slider = $('.main_cont_slider');

    if( !$slider.length ){ return; }

    // init
    $slider.slick({
		slidesToShow: 3,
		slidesToScroll: 1,
        speed: 1000,
        //autoplay: true,
        arrows: false,
        infinite: true,
        responsive: [
            {
                breakpoint: 769,
                settings: {
                    slidesToShow:2
                }
            },
            {
	      breakpoint: 600,
	      settings: {
	        slidesToShow: 2,
	        slidesToScroll: 1
	      }
	    },
	    {
	      breakpoint: 480,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1
	      }
	    }
        ]
	});

    // controler
    $('.main_cont_prev').click(function(e){
        e.preventDefault();
        $slider.slick('slickPrev');
    });
    $('.main_cont_next').click(function(e){
        e.preventDefault();
        $slider.slick('slickNext');
    });

}

jQuery(function($) {
main_pull_slider();
main_event_slider();
main_writer_slider();
main_cont_slider();


});