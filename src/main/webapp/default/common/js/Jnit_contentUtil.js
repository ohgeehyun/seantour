$(document).ready(function() {
	$(document).ready(function(){
		var currentUrl = encodeURIComponent($(location).attr('href'));
		var title = encodeURIComponent($(document).attr('title'));
		var twt = "http://twitter.com/share?url="+currentUrl+"&amp;text="+title;
		var fb = "http://www.facebook.com/sharer.php?u="+currentUrl;
		$('.twitter a').attr('href',twt);
		$('.facebook a').attr('href',fb);
		$('.kakaostory a').on('click',function(e){
			e.preventDefault();
			Kakao.init('3ed450e23ea094c5c2d86652493bc23f');
			Kakao.Story.share({
				url: $(location).attr('href'),
				text: $(document).attr('title')
			});
		});
	});
	$($('ul.content_util li p').get(0)).bind('click', function(e){
        e.preventDefault();
	$('.content').css('font-size', parseInt($('.content').css('font-size'))+1 );
	$('.content a').css('font-size', parseInt($('.content a').css('font-size'))+1 );
	$('.content p').css('font-size', parseInt($('.content p').css('font-size'))+1 );
	$('.content span').css('font-size', parseInt($('.content span').css('font-size'))+1 );
	$('.content table').css('font-size', parseInt($('.content table').css('font-size'))+1 );
	$('.content td').css('font-size', parseInt($('.content td').css('font-size'))+1 );
	$('.content th').css('font-size', parseInt($('.content th').css('font-size'))+1 );		
	$('.content ul li').css('font-size', parseInt($('.content p').css('font-size'))+1 );
	$('.content h4').css('font-size', parseInt($('.content p').css('font-size'))+1 );
	$('.content h5').css('font-size', parseInt($('.content p').css('font-size'))+1 );
	$('.content h6').css('font-size', parseInt($('.content p').css('font-size'))+1 );
	});
	
	$($('ul.content_util li p').get(1)).bind('click', function(e){
	        e.preventDefault();
	$('.content').css('font-size', parseInt($('.content').css('font-size'))-1 );
	$('.content a').css('font-size', parseInt($('.content a').css('font-size'))-1 );
	$('.content p').css('font-size', parseInt($('.content p').css('font-size'))-1 );
	$('.content span').css('font-size', parseInt($('.content span').css('font-size'))-1 );
	$('.content table').css('font-size', parseInt($('.content table').css('font-size'))-1 );
	$('.content td').css('font-size', parseInt($('.content td').css('font-size'))-1 );
	$('.content th').css('font-size', parseInt($('.content th').css('font-size'))-1 );		
	$('.content ul li').css('font-size', parseInt($('.content p').css('font-size'))-1 );
	$('.content h4').css('font-size', parseInt($('.content p').css('font-size'))-1 );
	$('.content h5').css('font-size', parseInt($('.content p').css('font-size'))-1 );
	$('.content h6').css('font-size', parseInt($('.content p').css('font-size'))-1 );
	});
});