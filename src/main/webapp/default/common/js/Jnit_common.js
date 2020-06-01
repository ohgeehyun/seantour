/*page_scrap*/
var addScrap = function() {
	var thisTitle = $.trim($('#pageLinkNav').text());	
	if(thisTitle == "") {
		thisTitle = $.trim($('title').text());
	}	
	$.ajax({
		url:"/scrap/add.do",
		data:{
			url:location.href,
			title:thisTitle
		},
		success:function(data){
			var msg = $.trim(data);
			var path = document.location.pathname;
			var paths = path.split("/");

			if(msg == "OK") {
				if(confirm("스크랩 되었습니다.\n\n스크랩 목록을 보시겠습니까?") == true) {
					// var popMsg = window.open('/scrap/list.do', 'CLIENT_WINDOW', 'resizable=yes scrollbars=no width=460 height=500');					
					location.href="/"+paths[1]+"/mbr/myPage.jsp?scrapPageNo=1&tabs=tabs2&tab=tab2";
				}
			}else if(msg == "E01") {
				alert("로그인 후 이용하세요.");
			}else if(msg == "E04") {
				if(confirm("스크랩은 20개까지만 가능합니다.\n\n스크랩 목록을 보시겠습니까?") == true) {
					// var popMsg = window.open('/scrap/list.do', 'CLIENT_WINDOW', 'resizable=yes scrollbars=no width=460 height=500');
					location.href="/"+paths[1]+"/mbr/myPage.jsp?scrapPageNo=1&tabs=tabs2&tab=tab2";
				}
			}else {
				alert("스크랩을 할 수 없습니다.");
			}
		}
	});
}

var delScrap = function(scrapId) {
	var localYn = $("#localYn").val();
	if(confirm("정말 삭제하시겠습니까?") == true) {
		$.ajax({
			url:(localYn == 'Y' ? '../..' : '')+"/scrap/del.do",
			data:{
				scrapId:scrapId
			},
			success:function(data) {
				if($.trim(data) == "OK") {
					$('tr[rel='+scrapId+']').remove();
				}
			}
		});
	}
}

function Jnit_workspace(url){	
	window.open(url,'Jnit_workspace','width=1250,height=400,scrollbars=yes,resizable=yes');
}