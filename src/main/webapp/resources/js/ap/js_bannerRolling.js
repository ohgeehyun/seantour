$(function(){
	 $.f_rollingBanner = {
		 defaults:{ // 기본값설정
			 direction : 1, //방향
			 showItems : 1, // 보여질 아이템수
			 id : null, //banner_rolling id
			 Timer: null, //타이머			  
			 TimerDelay : 5000, // 딜레이	
			 animationDelay : 1000, //배너 애니매이션 속도
			 auto : false, //자동롤링
			 animationPx : 1, //auto : true = 1 , false = 이미지 가로, 세로 길이
			 movepx:null
			 	
		 }
	 };
	 
	 $.fn.rolling = function(rolldata){    	
		 var rolldata = $.extend({},$.f_rollingBanner.defaults,rolldata);
		 rolldata.id = "#"+this.attr("id");
		 rollingStart(rolldata);
		 showItem(rolldata);		 
		 return this;
	 };
	 //
	 function showItem(rolldata){	
		 if(rolldata.direction == 1 || rolldata.direction == 2){			 
			 $('#banner_list').css('width',""+(rolldata.showItems*rolldata.imgWidth)+"px"); //px
			 //$('#banner_list').css('width',""+(rolldata.showItems*10)+"%") // width = %			 
			 $('#banner_list').css('height',""+(rolldata.imgHeight)+"px");
			 $(""+rolldata.id+""+" li").css('float','left');			 
		 }
		 if(rolldata.direction == 3 || rolldata.direction == 4){			 
			 $('#banner_list').css('width',""+(rolldata.imgWidth)+"px");
			 $('#banner_list').css('height',""+(rolldata.showItems*rolldata.imgHeight)+"px"); //px
			 //$('#banner_list').css('height',""+(rolldata.showItems*10)+"%"); // height = %
			 $(""+rolldata.id+""+" li").css('float','');
		 }
	 }
	 
	 function rollingStart(rolldata){		 
		 if(rolldata.auto == true){
			 animationPx = 1;
			 rolldata.TimerDelay = 10;
			 rolldata.animationDelay=0;
		 }else{
			 if(rolldata.direction == 1 || rolldata.direction == 2){
				 animationPx = rolldata.imgWidth; 
			 }
			 if(rolldata.direction == 3 || rolldata.direction == 4){
				 animationPx = rolldata.imgHeight;
			 }			 
			 rolldata.animationDelay=rolldata.animationDelay;
			 rolldata.TimerDelay = this.rolldata.TimerDelay;			 
		 }
		 if(rolldata.direction == 1){ 
			 $(""+rolldata.id+"").animate({
				 left: "-="+animationPx+""
			 },rolldata.animationDelay,function(){
				 if(rolldata.auto == true){
					 if($(""+rolldata.id+"").css('left') == "-"+rolldata.imgWidth+"px"){
						 $(""+rolldata.id+""+">li:first").appendTo(""+rolldata.id+"");
						 $(""+rolldata.id+"").css('left','0px');						 
					 } 
				 }else{
					 $(""+rolldata.id+""+">li:first").appendTo(""+rolldata.id+"");
					 $(""+rolldata.id+"").css('left','0px'); 
				 }				 
			 });			 
		 }
		 if(rolldata.direction == 2){
			 $(""+rolldata.id+"").animate({
				 left:"+="+animationPx+""
			 },rolldata.animationDelay,function(){
				 if(rolldata.auto == true){
					if($(""+rolldata.id+"").css('left') == ""+rolldata.imgWidth+"px"){
						$(""+rolldata.id+""+">li:last").prependTo(""+rolldata.id+"");
						$(""+rolldata.id+"").css('left','0px');
					} 
				 }else{
					 $(""+rolldata.id+""+">li:last").prependTo(""+rolldata.id+"");
					 $(""+rolldata.id+"").css('left','0px'); 
				 }				 
			 });
		 }
		 if(rolldata.direction == 3){
			 $(""+rolldata.id+"").animate({
				 top:"-="+animationPx+""
			 },rolldata.animationDelay,function(){
				 if(rolldata.auto == true){
					 if($(""+rolldata.id+"").css('top') == "-"+rolldata.imgHeight+"px"){
						 $(""+rolldata.id+""+">li:first").appendTo(""+rolldata.id+"");
						 $(""+rolldata.id+"").css('top','0px');
					 }
				 }else{
					 $(""+rolldata.id+""+">li:first").appendTo(""+rolldata.id+"");
					 $(""+rolldata.id+"").css('top','0px'); 
				 }				 
			 });
		 }
		 if(rolldata.direction == 4){
			 $(""+rolldata.id+"").animate({
				 top:"+="+animationPx+""
			 },rolldata.animationDelay,function(){
				 if(rolldata.auto == true){
					 if($(""+rolldata.id+"").css('top') == ""+rolldata.imgHeight+"px"){
						 $(""+rolldata.id+""+">li:last").prependTo(""+rolldata.id+"");
						 $(""+rolldata.id+"").css('top','0px');
					 }
				 }else{
					 $(""+rolldata.id+""+">li:last").prependTo(""+rolldata.id+"");
					 $(""+rolldata.id+"").css('top','0px'); 
				 }				 
			 });
		 }
		 rolldata.animationDelay = this.rolldata.animationDelay;
		 rolldata.Timer = setTimeout(function(){rollingStart(rolldata)}, rolldata.TimerDelay);
		 
		 var indexli = null;		 
		 //tab key focus function
		 $(""+rolldata.id+""+">li").focusin(function(){			 
			 indexli = $(this).index();			 
			 clearTimeout(rolldata.Timer);			 
		 }).focusout(function(){
			 clearTimeout(rolldata.Timer);
			 var indexlast = $(""+rolldata.id+""+">li:last").index();			 
			 if( indexlast == indexli ){				 
				 //$(""+rolldata.id+"").css('left','1578px');								 
			 }
			 rolldata.Timer = setTimeout(function(){rollingStart(rolldata)}, rolldata.TimerDelay);
			 
		 });
		 //end tab key focus function
		 
		 //mouseenter(mouseover) && mouseleave(mouseout) function
		 $(""+rolldata.id+"").mouseenter(function(){			 
			 clearTimeout(rolldata.Timer);
		 }).mouseleave(function(){
			 clearTimeout(rolldata.Timer);
			 rolldata.Timer = setTimeout(function(){rollingStart(rolldata)}, rolldata.TimerDelay);
		 });
		 // end mouseenter(mouseover) && mouseleave(mouseout) function
		 
		 right = function(){
			 clearTimeout(rolldata.Timer);
			 if( rolldata.direction == 1 ||rolldata.direction == 2){
				 $(""+rolldata.id+"").animate({
					 left:"+="+rolldata.imgWidth+""
				 },100,function(){
					 $(""+rolldata.id+""+">li:last").prependTo(""+rolldata.id+"");
					 $(""+rolldata.id+"").css('left','0px');
				 });				
			 }
			 
			 if(rolldata.direction == 3 || rolldata.direction == 4){
				 $(""+rolldata.id+"").animate({
					 top:"+="+rolldata.imgHeight+""
				 },100,function(){
					 $(""+rolldata.id+""+">li:last").prependTo(""+rolldata.id+"");
					 $(""+rolldata.id+"").css('top','0px');
				 });
			 }
			 rolldata.Timer = setTimeout(function(){rollingStart(rolldata)}, rolldata.TimerDelay);
		 }
		 
		 left = function(){
			 clearTimeout(rolldata.Timer);
			 if(rolldata.direction == 1 || rolldata.direction == 2 ){ 
				 $(""+rolldata.id+"").animate({
					 left: "-="+rolldata.imgWidth+""				 	 
				 },100,function(){				 
					 $(""+rolldata.id+""+">li:first").appendTo(""+rolldata.id+"");
					 $(""+rolldata.id+"").css('left','0px');
				 });			 
			 }
			 if(rolldata.direction == 3 || rolldata.direction == 4){
				 $(""+rolldata.id+"").animate({
					 top:"-="+rolldata.imgHeight+""
				 },100,function(){
					 $(""+rolldata.id+""+">li:first").appendTo(""+rolldata.id+"");
					 $(""+rolldata.id+"").css('top','0px');
					 
				 });
			 }			 
			 rolldata.Timer = setTimeout(function(){rollingStart(rolldata)}, rolldata.TimerDelay);
		 }
		 
		 pause = function(){			 
			 clearTimeout(rolldata.Timer);			 
		 }
		 
		 start = function(){
			 if(rolldata.auto == true){
				 rolldata.animationDelay = 0; 
			 }else{
				 rolldata.animationDelay = 100;
			 }			 
			 clearTimeout(rolldata.Timer);			 
			 rollingStart(rolldata);			 
		 }
	 }
});