
function setCookie(name, value, expires, path, domain, secure) {
	var expireDay = new Date();
	expireDay.setDate(expireDay.getDate()+expires);
	path = "/";
	var curCookie = name + "=" + escape(value) +
		 ((expires) ? "; expires=" + expireDay.toUTCString() : "") +
		 ((path) ? "; path=" + path : "") +
		 ((domain) ? "; domain=" + domain : "") +
		 ((secure) ? "; secure" : "");
	document.cookie = curCookie;
}

function getCookie(name) {
  var dc = document.cookie;
  var prefix = name + "=";
  var begin = dc.indexOf("; " + prefix);
  if (begin == -1) {
   begin = dc.indexOf(prefix);
   if (begin != 0) return null;
  } else
   begin += 2;
  var end = document.cookie.indexOf(";", begin);
  if (end == -1)
   end = dc.length;
  return unescape(dc.substring(begin + prefix.length, end));
}

function deleteCookie(name, path, domain) {
	path = "/";
  if (getCookie(name)) {
   document.cookie = name + "=" +
   ((path) ? "; path=" + path : "") +
   ((domain) ? "; domain=" + domain : "") +
   "; expires=Thu, 01-Jan-70 00:00:01 GMT";
  }
}