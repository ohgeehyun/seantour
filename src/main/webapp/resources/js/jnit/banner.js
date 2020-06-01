/**
 * 
 */
var bannerInit = function(){
	if($('div.banner').length > 0) {
		$("head").append("<link>");     
		css = $("head").children(":last");     
		css.attr({
		        rel: "stylesheet",
		        type: "text/css",
		        href: '/jcms/css/jnit/banner.css'     
		});
		$.each($('div.banner'),function(idx,val){
			var id = $(this).attr('id');
			var cssClass = $(this).attr('class').split(' ');
			var type = cssClass[1];

			switch(type){
				case "type1":
					//console.log("Type1");
					var bannerWrap = $(this).children('ul.itemWrap');
					var itemCount = bannerWrap.children('li').length-1;
					bannerWrap.children('li').removeAttr('style');
					bannerWrap.children('li').hide();
					bannerWrap.children('li:eq(0)').fadeIn();

					var curIdx = 0;
					var aniFunction = function(){
						bannerWrap.children('li:eq('+curIdx+')').fadeOut(function(){
							bannerWrap.children('li').hide();
							$('#'+id+' .nav li').removeClass('on');
							curIdx = ( (curIdx+1) > itemCount ) ? curIdx=0 : curIdx+1 ;
							bannerWrap.children('li:eq('+curIdx+')').fadeIn();
							$('#'+id+' .nav li:eq('+curIdx+')').addClass('on');
						});
						
					};
					var interval = setInterval(aniFunction,5000);
					var controlElem = "";
					controlElem += '<ul class="control">';
					controlElem += '<li><a class="stop" href="#" alt="정지"><img alt="정지" src="/kr/img/main/popup_btn1.gif" /></a></li>';
					controlElem += '<li><a class="start" href="#" alt="재생"><img alt="재생" src="/kr/img/main/popup_btn2.gif" /></a></li>';
					controlElem += "</ul>";
					bannerWrap.after(controlElem);
					$('#'+id+' .control .stop').click(function(e){
						e.preventDefault();
						clearInterval(interval);
					});
					$('#'+id+' .control .start').click(function(e){
						e.preventDefault();
						clearInterval(interval);
						interval = setInterval(aniFunction,5000);
					});
					var navElem = "";
					navElem += '<ul class="nav">';
					var page = 0;
					for(var i=0;i<=itemCount;i++){
						page = i+1;
						navElem += '<li><a href="#" data-idx='+i+'>'+page+'</a></li>';
					}
					navElem += "</ul>";
					bannerWrap.after(navElem);
					$('#'+id+' .nav li:eq(0)').addClass('on');

					$('#'+id+' .nav li a').click(function(e){
						e.preventDefault();
						var dataIdx = $(this).data('idx');
						clearInterval(interval);
						bannerWrap.children('li:eq('+curIdx+')').fadeOut(function(){
							bannerWrap.children('li').hide();
							$('#'+id+' .nav li').removeClass('on');
							curIdx = ( (dataIdx) > itemCount ) ? curIdx=0 : dataIdx ;
							bannerWrap.children('li:eq('+curIdx+')').fadeIn(function(){
							$('#'+id+' .nav li:eq('+curIdx+')').addClass('on');
								interval = setInterval(aniFunction,5000);
							});
						});
					});
					break;
				default:
					//console.log("default");
					break;
			}
		});


	}
};
(function (window, document, jQuery) {

	  var head = document.getElementsByTagName('head')[0],
	      loadedCompleteRegExp = /loaded|complete/,
	      callbacks = {},
	      callbacksNb = 0,
	      timer;

	  jQuery.getCSS = function (url, options, callback) {

	    if (jQuery.isFunction(options)) {
	      callback = options;
	      options  = {};
	    }

	    var link = document.createElement('link');

	    link.rel   = 'stylesheet';
	    link.type  = 'text/css';
	    link.media = options.media || 'screen';
	    link.href  = url;

	    if (options.charset) {
	      link.charset = options.charset;
	    }

	    if (options.title) {
	      callback = (function (callback) {
	        return function () {
	          link.title = options.title;
	          callback(link, "success");
	        };
	      })(callback);
	    }

	    // onreadystatechange
	    if (link.readyState) {

	      link.onreadystatechange = function () {
	        if (loadedCompleteRegExp.test(link.readyState)) {
	          link.onreadystatechange = null;
	          callback(link, "success");
	        }
	      };

	    // If onload is available, use it
	    } else if (link.onload === null /* exclude Webkit => */ && link.all) {
	      link.onload = function () {
	        link.onload = null;
	        callback(link, "success");
	      };

	    // In any other browser, we poll
	    } else {

	      callbacks[link.href] = function () {
	        callback(link, "success");
	      };

	      if (!callbacksNb++) {
	        // poll(cssPollFunction);

	        timer = window.setInterval(function () {

	          var callback,
	              stylesheet,
	              stylesheets = document.styleSheets,
	              href,
	              i = stylesheets.length;

	          while (i--) {
	            stylesheet = stylesheets[i];
	            if ((href = stylesheet.href) && (callback = callbacks[href])) {
	              try {
	                // We store so that minifiers don't remove the code
	                callback.r = stylesheet.cssRules;
	                // Webkit:
	                // Webkit browsers don't create the stylesheet object
	                // before the link has been loaded.
	                // When requesting rules for crossDomain links
	                // they simply return nothing (no exception thrown)
	                // Gecko:
	                // NS_ERROR_DOM_INVALID_ACCESS_ERR thrown if the stylesheet is not loaded
	                // If the stylesheet is loaded:
	                //  * no error thrown for same-domain
	                //  * NS_ERROR_DOM_SECURITY_ERR thrown for cross-domain
	                throw 'SECURITY';
	              } catch(e) {
	                // Gecko: catch NS_ERROR_DOM_SECURITY_ERR
	                // Webkit: catch SECURITY
	                if (/SECURITY/.test(e)) {

	                  // setTimeout(callback, 0);
	                  callback(link, "success");

	                  delete callbacks[href];

	                  if (!--callbacksNb) {
	                    timer = window.clearInterval(timer);
	                  }

	                }
	              }
	            }
	          }
	        }, 13);
	      }
	    }
	    head.appendChild(link);
	  };

	})(this, this.document, this.jQuery);
