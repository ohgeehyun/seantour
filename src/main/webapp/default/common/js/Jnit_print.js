/* 프린트 Function */
var Jnit_printPop;
function pagePrint(){
	var path = window.location.pathname;
	var search = window.location.search;	
	if(search.indexOf("?") != '-1'){
		search = search.substring(0,1).replace("?", "&")+search.substring(1,search.length);
	}
	path = path+search;
	var site = path.split("/")[1];
	var url = "/" + site + "/print.jsp"; //document.write
	//var url = "/print/output.do"; //make
	if(Jnit_printPop) Jnit_printPop.close();
	Jnit_printPop = window.open(url+"?path="+path, "PRINT");
}
