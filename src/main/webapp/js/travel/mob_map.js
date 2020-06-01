// JavaScript Document
/*-----------------------------------------------------------------*/
// 
/*-----------------------------------------------------------------*/

$(function() {
	
		$("#wizard").steps({
             headerTag: "h2",
             bodyTag: "section",
             transitionEffect: "slideLeft",
             enablePagination: false //페이지네이션 비활성화
         });
		
		//tab_menu
		var index =0;
		$(".tab_mn > ul > li > a").eq(index).addClass("on");
		//$(".cssSelect").hide();
		//$(".cssSelect").eq(index).show();
		
		//상단 이미지 클릭시 처리	
		$(".cssSelect").prev("a").click(function(){
			//console.log($(".cssSelect").prev("a").index($(this)));
			index = $(".cssSelect").prev("a").index($(this));
			
			//이미지 표시
			$(".tab_mn > ul > li > a").removeClass("on");
			$(".tab_mn > ul > li > a").eq(index).addClass("on");
			
			//$(".cssSelect").eq(index).toggleClass("on");
			
			//아래쪽 목록표시
			$(".cssSelect").hide();
			$(".cssSelect").eq(index).show();
			
			//css표출
			$(".cssSelect").removeClass("on");
			//$(".cssSelect").eq(index).addClass("on");
		});
		
		$(".cssSelect").find("button").click(function(){
			$(".cssSelect").eq(index).toggleClass("on");
		});
		
		//
		$(".mob_detail_info_area").hide();
	    // $(".tbox").on("click", function() {
	    $(document).on("click", ".tbox", function(){
	        $(this).siblings(".mob_detail_info_area").slideToggle();
	    });
	    
	   //
		$(".day_area").hide();
		$(".first").show();
	    // $(".day_title").on("click", function() {
	    $(document).on("click", ".day_title", function(){
	        $(this).siblings(".day_area").slideToggle();
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


