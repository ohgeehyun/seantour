// JavaScript Document


 
/*-----------------------------------------------------------------*/
// 신호등 혼잡도
/*-----------------------------------------------------------------*/
$(function() {
	$('.blinker').hide();
	$(".btn_loc").removeClass('on');
	$(".tbl_icon").removeClass('on');
	
    $(".btn_loc").click(function(){
    	var order = $(".btn_loc").index(this);
    	console.log(order);
    	$('.blinker').hide();
    	$(".btn_loc").removeClass('on');
		$(".tbl_icon").removeClass('on');
    	$('.blinker').eq(order).show();
    	$(".btn_loc").eq(order).addClass('on');
    	$(".tbodyc tr").eq(order).children("td").eq(1).children("span").addClass('on');
    	
    });
});