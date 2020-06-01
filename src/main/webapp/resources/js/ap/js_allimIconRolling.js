$(function(){
	 $.f_iconrollingBanner = {
		 defaults:{ // 기본값설정
			 icondirection : 1, //방향
			 iconshowItems : 1, // 보여질 아이템수
			 iconid : null, //banner_rolling id
			 iconTimer: null, //타이머			  
			 iconTimerDelay : 5000, // 딜레이	
			 iconanimationDelay : 1000, //배너 애니매이션 속도
			 iconauto : false, //자동롤링
			 	iconanimationPx : 1 //iconauto : true = 1 , false = 이미지 가로, 세로 길이
		 }
	 };
	 
	 $.fn.iconrolling = function(iconrolldata){    	
		 var iconrolldata = $.extend({},$.f_iconrollingBanner.defaults,iconrolldata);
		 iconrolldata.iconid = "#"+this.attr("id");				 
		 iconrollingStart(iconrolldata);
		 iconshowItem(iconrolldata);		 
		 return this;
	 };	 
	 function iconshowItem(iconrolldata){	
		 if(iconrolldata.icondirection == 1 || iconrolldata.icondirection == 2){			 
			 /*$('#banner_list').css('width',""+(iconrolldata.iconshowItems*iconrolldata.iconimgWidth)+"px");*/ //px			 
			 $(""+iconrolldata.iconid+""+" li").css('float','left');			 
		 }
		 if(iconrolldata.icondirection == 3 || iconrolldata.icondirection == 4){			 			 
			 $(""+iconrolldata.iconid+""+" li").css('float','');
		 }
	 }
	 
	 function iconrollingStart(iconrolldata){		 
		 if(iconrolldata.iconauto == true){			 
			 iconanimationPx = 1;
			 iconrolldata.iconTimerDelay = 10;
			 iconrolldata.iconanimationDelay=0;
		 }else{
			 if(iconrolldata.icondirection == 1 || iconrolldata.icondirection == 2){
				 iconanimationPx = iconrolldata.iconimgWidth; 
			 }
			 if(iconrolldata.icondirection == 3 || iconrolldata.icondirection == 4){
				 iconanimationPx = iconrolldata.iconimgHeight;
			 }			 
			 iconrolldata.iconanimationDelay=iconrolldata.iconanimationDelay;
			 iconrolldata.iconTimerDelay = this.iconrolldata.iconTimerDelay;			 
		 }
		 if(iconrolldata.icondirection == 1){ 
			 $(""+iconrolldata.iconid+"").animate({
				 left: "-="+iconanimationPx+""
			 },iconrolldata.iconanimationDelay,function(){ 				
				 if(iconrolldata.iconauto == true){
					 if($(""+iconrolldata.iconid+"").css('left') == "-"+iconrolldata.iconimgWidth+"px"){
						 $(""+iconrolldata.iconid+""+">li:first").appendTo(""+iconrolldata.iconid+"");
						 $(""+iconrolldata.iconid+"").css('left','0px');						 
					 } 
				 }else{					 
					 $(""+iconrolldata.iconid+""+">li:first").appendTo(""+iconrolldata.iconid+"");					 
					 $(""+iconrolldata.iconid+"").css('left','0px'); 
					 //$("#icon_rolling").css('left','0px');
				 }				 
			 });			 
		 }
		 if(iconrolldata.icondirection == 2){
			 $(""+iconrolldata.iconid+"").animate({
				 left:"+="+iconanimationPx+""
			 },iconrolldata.iconanimationDelay,function(){
				 if(iconrolldata.iconauto == true){
					if($(""+iconrolldata.iconid+"").css('left') == ""+iconrolldata.iconimgWidth+"px"){
						$(""+iconrolldata.iconid+""+">li:last").prependTo(""+iconrolldata.iconid+"");
						$(""+iconrolldata.iconid+"").css('left','0px');
					} 
				 }else{
					 $(""+iconrolldata.iconid+""+">li:last").prependTo(""+iconrolldata.iconid+"");
					 $(""+iconrolldata.iconid+"").css('left','0px'); 
				 }				 
			 });
		 }
		 if(iconrolldata.icondirection == 3){
			 $(""+iconrolldata.iconid+"").animate({
				 top:"-="+iconanimationPx+""
			 },iconrolldata.iconanimationDelay,function(){
				 if(iconrolldata.iconauto == true){
					 if($(""+iconrolldata.iconid+"").css('top') == "-"+iconrolldata.iconimgHeight+"px"){
						 $(""+iconrolldata.iconid+""+">li:first").appendTo(""+iconrolldata.iconid+"");
						 $(""+iconrolldata.iconid+"").css('top','0px');
					 }
				 }else{
					 $(""+iconrolldata.iconid+""+">li:first").appendTo(""+iconrolldata.iconid+"");
					 $(""+iconrolldata.iconid+"").css('top','0px'); 
				 }				 
			 });
		 }
		 if(iconrolldata.icondirection == 4){
			 $(""+iconrolldata.iconid+"").animate({
				 top:"+="+iconanimationPx+""
			 },iconrolldata.iconanimationDelay,function(){
				 if(iconrolldata.iconauto == true){
					 if($(""+iconrolldata.iconid+"").css('top') == ""+iconrolldata.iconimgHeight+"px"){
						 $(""+iconrolldata.iconid+""+">li:last").prependTo(""+iconrolldata.iconid+"");
						 $(""+iconrolldata.iconid+"").css('top','0px');
					 }
				 }else{
					 $(""+iconrolldata.iconid+""+">li:last").prependTo(""+iconrolldata.iconid+"");
					 $(""+iconrolldata.iconid+"").css('top','0px'); 
				 }				 
			 });
		 }
		 iconrolldata.iconanimationDelay = this.iconrolldata.iconanimationDelay;
		 iconrolldata.iconTimer = setTimeout(function(){iconrollingStart(iconrolldata)}, iconrolldata.iconTimerDelay);
		 
		 $(""+iconrolldata.iconid+"").mouseenter(function(){			 
			 clearTimeout(iconrolldata.iconTimer);
		 }).mouseleave(function(){
			 clearTimeout(iconrolldata.iconTimer);
			 iconrolldata.iconTimer = setTimeout(function(){iconrollingStart(iconrolldata)}, iconrolldata.iconTimerDelay);
		 });
		 
		 iconright = function(){
			 clearTimeout(iconrolldata.iconTimer);
			 if( iconrolldata.icondirection == 1 ||iconrolldata.icondirection == 2){
				 $(""+iconrolldata.iconid+"").animate({
					 left:"+="+iconrolldata.iconimgWidth+""
				 },100,function(){
					 $(""+iconrolldata.iconid+""+">li:last").prependTo(""+iconrolldata.iconid+"");
					 $(""+iconrolldata.iconid+"").css('left','0px');
				 });				
			 }
			 
			 if(iconrolldata.icondirection == 3 || iconrolldata.icondirection == 4){
				 $(""+iconrolldata.iconid+"").animate({
					 top:"+="+iconrolldata.iconimgHeight+""
				 },100,function(){
					 $(""+iconrolldata.iconid+""+">li:last").prependTo(""+iconrolldata.iconid+"");
					 $(""+iconrolldata.iconid+"").css('top','0px');
				 });
			 }
			 iconrolldata.iconTimer = setTimeout(function(){iconrollingStart(iconrolldata)}, iconrolldata.iconTimerDelay);
		 }
		 
		 iconleft = function(){
			 clearTimeout(iconrolldata.iconTimer);
			 if(iconrolldata.icondirection == 1 || iconrolldata.icondirection == 2 ){ 
				 $(""+iconrolldata.iconid+"").animate({
					 left: "-="+iconrolldata.iconimgWidth+""				 	 
				 },100,function(){				 
					 $(""+iconrolldata.iconid+""+">li:first").appendTo(""+iconrolldata.iconid+"");
					 $(""+iconrolldata.iconid+"").css('left','0px');
				 });			 
			 }
			 if(iconrolldata.icondirection == 3 || iconrolldata.icondirection == 4){
				 $(""+iconrolldata.iconid+"").animate({
					 top:"-="+iconrolldata.iconimgHeight+""
				 },100,function(){
					 $(""+iconrolldata.iconid+""+">li:first").appendTo(""+iconrolldata.iconid+"");
					 $(""+iconrolldata.iconid+"").css('top','0px');
					 
				 });
			 }			 
			 iconrolldata.iconTimer = setTimeout(function(){iconrollingStart(iconrolldata)}, iconrolldata.iconTimerDelay);
		 }
		 
		 iconpause = function(){			 
			 clearTimeout(iconrolldata.iconTimer);			 
		 }
		 
		 iconstart = function(){
			 if(iconrolldata.iconauto == true){
				 iconrolldata.iconanimationDelay = 0; 
			 }else{
				 iconrolldata.iconanimationDelay = 100;
			 }			 
			 clearTimeout(iconrolldata.iconTimer);			 
			 iconrollingStart(iconrolldata);			 
		 }
		 
	 }
	
	
});