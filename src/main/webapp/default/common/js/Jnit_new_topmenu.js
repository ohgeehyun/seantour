$(document).ready(function(){

	$("[class*='Inb']").removeClass("on");
	$("[class*='sub']").find(".on").parent().parent().parent().addClass("on")
	$("[class*='sub']").find(".on").parent().parent().css("display", "block");

	$("ul#topmenu>li>a").on("click", function(e){
		e.preventDefault();

		var thisClass = $(this).parent().attr("class").indexOf("on");
		if(thisClass != -1){
			$(this).parent().removeClass("on");
			$(this).parent().children("div").hide();
			//$(this).parent().children("div").animate({ display: "none" });

			if(pathCheck()){
				//$("div#header").css("height","119");
				$("div#header").animate({ height: "119px" });
			}
		}else{
			$("ul#topmenu>li").removeClass("on");
			$("[class*='Inbsub']").hide();
			$(this).parent().addClass("on");
			$(this).parent().children("div").show();
			//$(this).parent().children("div").animate({ display: "block" });

			if(pathCheck()){
				//$("div#header").css("height","145");
				$("div#header").animate({ height: "145px" });
			}
		}

	});

});

function pathCheck(){
	
	var pathname = $(window.location).attr("pathname");
	var result = false;

	if(pathname == '/kr/' || pathname == '/kr/index.jsp' || pathname == '/kr/index.jsp#' || pathname == '/kr/#'){
		result = true;
	}

	return result;
}