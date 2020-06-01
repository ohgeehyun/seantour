<%
/**
 *@version 3.2.0.1
 **/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<title>::건물명검색::</title>
<link rel="stylesheet" href="<c:url value="/resources/css/new-addr.css"/>" />
<script src="<c:url value="/resources/js/newaddrcommon.js" /> "></script>

<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js" />"></script>

<script type="text/javascript">
/*
 *  ver  : 1.0
 *  date : 2012-08-07
 *  make : yjkim 
 */
 
	var xmlHttp;
	var mode;											
	var dataFrom;	
	var dataTo;		
	var objFrom;	
	var objTo;		
	var objClear;					
	var areaIdx;	
	var bldnm,group_nm,oldaddr_nm,newaddr_nm,livein_cnt,corplist;	

	function createXMLHttpRequest() {
	
	  if(xmlHttp != null) {
	  	xmlHttp.Abort();
	  	delete xmlHttp;
	  	xmlHttp = null;
	  }
	  	
	  if (window.ActiveXObject) {
	       xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	  } 
	  else if (window.XMLHttpRequest) {
	       xmlHttp = new XMLHttpRequest();
	  }



	}
	

   function changeAreaList(idx, obj){
		if(obj.id == '' || obj.id == 'undefined')
			return;
		
		areaIdx = idx;
   		mode 	= 'area';
		
	
		dataFrom, dataTo, objFrom, objTo, objClear;   		

		// 통합검색 
		if(obj.id == 'city1'){
			dataFrom 	= 'city';
			dataTo 		= 'county';
			objFrom		= 'city1';
			objTo		= 'county1';
			objClear	= 'town1_oldaddr';	

			//①세종시예외처리 
			document.getElementById("county1").disabled = false;


			if(document.getElementById(obj.id).value =='36'){
				document.getElementById("county1").disabled = true;
				dataTo 		= 'town';
				objTo		= 'town1_oldaddr';
			}	

			clearList(objTo);
		}
		// 통합검색 
		else if(obj.id == 'county1'){
			dataFrom 	= 'county';
			objFrom		= 'county1';
			objClear	= '';
			dataTo 		= 'town';
			objTo		= 'town1_oldaddr';

			clearList(objTo);
		}
		else if(obj.id == 'town1_oldaddr'){
			dataFrom 	= 'town';
			objFrom		= 'town1_oldaddr';
			objClear	= '';
			dataTo 		= 'ri';
			objTo		= 'ri1_oldaddr';
			
			
		}
		// 통합검색 
		else if(obj.id == 'rd_nm_idx1'){
			dataFrom 	= 'county';
			objFrom		= 'county1';
			objClear	= '';
			
			if(searchType == 'NORMAL1'){		//	새주소검색
				dataTo 		= 'rd_nm';
				objTo		= 'rd_nm1';
			}
		}

		//	update해야 할 select를 초기화
		
		
		//	clear해야 할 select가 설정된 경우 초기화


		
		// from object 선택값이 없으면 return
		if(document.getElementById(objFrom).value == ''){
			return;
		}
		
		var url = "<c:url value="/gis/newGisZip/ajax.do"/>" + "?getUrl=http://www.juso.go.kr/getAreaCode.do?" + escape(createParameter());
		 
	  	createXMLHttpRequest();
	 	xmlHttp.onreadystatechange = handleStateChange;
	  	xmlHttp.open("GET", url, true);
	  	xmlHttp.send(null);
	}
	
	
	/*
	 *	행정구역 조회 쿼리에 사용할 파라메터값 설정
	 */
	function createParameter() {
		
		var rdIndex;
		
		// 도로명 clear인 경우, 도로명 인덱스 선택 초기화
		if(dataTo.indexOf("rd_nm") != -1){
			var rdIdxName = 'rd_nm_idx'+areaIdx;
			rdIndex = document.getElementById(rdIdxName).value;
		}
		
		if(objFrom!='')
			valFrom		= document.getElementById(objFrom).value;
		if(objTo!='')
		valTo		= document.getElementById(objTo).value;

		//	시군구>도로명, 시군구>지번주소인 경우
		//	시도코드도 가져가야함
		if(dataFrom == 'county' && (areaIdx == 1 || areaIdx == 3)){
			var cityName = 'city'+areaIdx;
			var cityVal = document.getElementById(cityName).value;
			
			valFrom = cityVal+valFrom;
		}else if(dataFrom == 'town' && (areaIdx == 1 || areaIdx == 3)){
			var cityName	= 'city'+areaIdx;
			var countyName	= 'county'+areaIdx;
			
			valFrom = document.getElementById(cityName).value+document.getElementById(countyName).value+valFrom;
		}
		
		var queryString = "from="+encodeURI(dataFrom)+"&to="+encodeURI(dataTo)+"&valFrom="+encodeURI(valFrom)+"&valTo="+encodeURI(valTo)+"&rdIndex="+encodeURI(rdIndex);


		//②세종시 예외처리
		if(encodeURI(valFrom)=='36'){
			valFrom +='110';
		}
	  	return queryString;
	}
	
	/*
	 *	응답을 받아 리스트를 update
	 */
	function handleStateChange() {
		
	  if(xmlHttp.readyState == 4) {
	       if(xmlHttp.status == 200) 
	           	updateAreaList();
	           	delete xmlHttp;
	           	xmlHttp = null;
	       }
	  }
	

	function handleStateChangeSearch() {
	      var j = 1;
	      if(xmlHttp.readyState == 2||xmlHttp.readyState == 3)
		 		document.getElementById("formbox").innerHTML="--처리중입니다.--";
		  if(xmlHttp.readyState == 4) {
		       if(xmlHttp.status == 200)
		    	   var siNm 		= xmlHttp.responseXML.getElementsByTagName('siNm');
			       var sggNm 		= xmlHttp.responseXML.getElementsByTagName('sggNm');
			       var emdNm 		= xmlHttp.responseXML.getElementsByTagName('emdNm');
			       var liNm 		= xmlHttp.responseXML.getElementsByTagName('liNm');
			       var rn 			= xmlHttp.responseXML.getElementsByTagName('rn');
			       var rnCd 		= xmlHttp.responseXML.getElementsByTagName('rnCd');
			       var buldMnnm 	= xmlHttp.responseXML.getElementsByTagName('buldMnnm');
			       var buldSlno 	= xmlHttp.responseXML.getElementsByTagName('buldSlno');
			       var lnbrMnnm 	= xmlHttp.responseXML.getElementsByTagName('lnbrMnnm');
			       var lnbrSlno 	= xmlHttp.responseXML.getElementsByTagName('lnbrSlno');
			       var udrtYn  	 	= xmlHttp.responseXML.getElementsByTagName('udrtYn');
			       var mtYn 	 	= xmlHttp.responseXML.getElementsByTagName('mtYn');
			       var bdNm		 	= xmlHttp.responseXML.getElementsByTagName('bdNm');    
			       var bdKd		 	= xmlHttp.responseXML.getElementsByTagName('bdkd');
			       var zipCl		= xmlHttp.responseXML.getElementsByTagName('zipCl');
			       var intCurrentPage		= xmlHttp.responseXML.getElementsByTagName('intCurrentPage');
			       var intCountPerPage		= xmlHttp.responseXML.getElementsByTagName('intCountPerPage');
			       var totalCount		= xmlHttp.responseXML.getElementsByTagName('totalCount');

			       var setDetailJuso = '';

			       
			        document.getElementById("formbox").innerHTML="";

				 	for(var i = 0; i < sggNm.length; i++) {
				 		var tempLnbr="";
					 	var tempBuld="";
					 	var jibun="";
					 	var newaddr="";
					 	var zip="";
					 	var oldJuso="";
					 	var newJuso="";
					 	
					 	if(lnbrSlno[i].firstChild.nodeValue!="0"){
					 		tempLnbr=lnbrMnnm[i].firstChild.nodeValue+'-'+lnbrSlno[i].firstChild.nodeValue;
					 	}else{
					 		tempLnbr=lnbrMnnm[i].firstChild.nodeValue;
					 	}
					 	if(buldSlno[i].firstChild.nodeValue!="0"){
					 		tempBuld=buldMnnm[i].firstChild.nodeValue+'-'+buldSlno[i].firstChild.nodeValue;
					 	}else{
					 		tempBuld=buldMnnm[i].firstChild.nodeValue;
					 	}
					 	
						if(siNm[i].firstChild.nodeValue=="세종특별자치시"){
							var temp=bdKd[i].firstChild.nodeValue;
						 	if(temp.substring(0,2)=='02'&&bdNm[i].childNodes.length!='0')
						 		setDetailJuso = "("+bdNm[i].firstChild.nodeValue+")";
					 		if(liNm[i].childNodes.length == '0') {
					 			newaddr = siNm[i].firstChild.nodeValue+' '+rn[i].firstChild.nodeValue+' '+tempBuld;
						 		jibun = siNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+tempLnbr;
					 		}else{
					 			newaddr = siNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+rn[i].firstChild.nodeValue+' '+tempBuld;
						 		jibun = siNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+liNm[i].firstChild.nodeValue+' '+tempLnbr;
					 		}
					 		
					 	}else{
					 		if(liNm[i].childNodes.length == '0') {
							 	var temp=bdKd[i].firstChild.nodeValue;
							 	if(temp.substring(0,2)=='02'&&bdNm[i].childNodes.length!='0')
							 		setDetailJuso = "("+emdNm[i].firstChild.nodeValue+"，"+bdNm[i].firstChild.nodeValue+")";
							 	else
							 		setDetailJuso = "("+emdNm[i].firstChild.nodeValue+")";
							 	newaddr = siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+rn[i].firstChild.nodeValue+' '+tempBuld;
						 		jibun = siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+tempLnbr;
						 		newJuso = siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+rn[i].firstChild.nodeValue;
						 		oldJuso = siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue;
						 	}else{
						 		var temp=bdKd[i].firstChild.nodeValue;
						 		if(temp.substring(0,2)=='02'&&bdNm[i].childNodes.length!='0')
							 		setDetailJuso = "("+bdNm[i].firstChild.nodeValue+")";
						 		newaddr = siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' ' +rn[i].firstChild.nodeValue+' '+tempBuld;
						 		jibun = siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+liNm[i].firstChild.nodeValue+' '+tempLnbr;
						 		newJuso = siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+rn[i].firstChild.nodeValue;
						 		oldJuso = siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+liNm[i].firstChild.nodeValue;
						 	}
					 	}
					 	

					 	if(bdNm[i].childNodes.length!='0')
					 		jibun += ' '+bdNm[i].firstChild.nodeValue;

				 		if(zipCl[i].childNodes.length=='0'){
					 		zip = "-";
				 		}else{
				 			zip = zipCl[i].firstChild.nodeValue;
				 		}
					 		
				 		
				 		if(i%2=='0'){
							document.getElementById("formbox").innerHTML += "<ul class='item'>";
			 				document.getElementById("formbox").innerHTML += "<li class='road'><a href='javascript:setParentValue(\""+zip+","+oldJuso+","+tempLnbr+","+newJuso+","+tempBuld+","+setDetailJuso+"\")'>"+"[도로명]"+newaddr+"</a></li>";
			 				document.getElementById("formbox").innerHTML += "<li class='road'>"+"[지 번]"+jibun+"</li>";
			 				document.getElementById("formbox").innerHTML += "<li class='road'>"+"[우편번호]"+zipCl[i].firstChild.nodeValue+"</li>";
			 				document.getElementById("formbox").innerHTML += "</ul>";
						}
					 	else{
					 		document.getElementById("formbox").innerHTML += "<ul class='item'>";
					 		document.getElementById("formbox").innerHTML += "<li class='road2'><a href='javascript:setParentValue(\""+zip+","+oldJuso+","+tempLnbr+","+newJuso+","+tempBuld+","+setDetailJuso+"\")'>"+"[도로명]"+newaddr+"</a></li>";
			 				document.getElementById("formbox").innerHTML += "<li class='road2'>"+"[지번]"+jibun+"</li>";
			 				document.getElementById("formbox").innerHTML += "<li class='road2'>"+"[우편번호]"+zipCl[i].firstChild.nodeValue+"</li>";
			 				document.getElementById("formbox").innerHTML += "</ul>";
					 	}
					 		
		 				
			 	   }
				 	if(siNm.length>0)
				 		document.getElementById("formbox").innerHTML+=getPaging(intCountPerPage[0].firstChild.nodeValue,'5',totalCount[0].firstChild.nodeValue,document.check.currentPage.value,"");
				
					if(siNm.length=="0")
				 		document.getElementById("formbox").innerHTML="검색된 결과가 없습니다.";
		           	delete xmlHttp;
		           	xmlHttp = null;
		       }
		  }
	
	
	/*
	 *	행정구역코드 모든 리스트를 초기화
	 */
	function clearAllList() {
	
	  	var countyObj = document.getElementById(vCounty);
	  
	  	countyObj.options.length = 0;
   		countyObj.options[0] = new Option('::선택::', '');
	   
	   	clearList(to);
	}
	
	/*
	 *	지정된 행정구역코드 리스트를 초기화
	 */
	 function clearList(obj) {
			if(obj != '' ){
			
				var toObject = document.getElementById(obj);
				  
				toObject.options.length = 0;
				toObject.options[0] = new Option('::선택::', '');
			}
			
		}		
	/*
	 *	행정구역코드 리스트를 update
	 */
	function updateAreaList() {
	  var toObj 	= document.getElementById(objTo);
	  var values 	= xmlHttp.responseXML.getElementsByTagName('value');
	  var names 	= xmlHttp.responseXML.getElementsByTagName('name');
	  var j = 1;

	  //  리스트 수만큼 option을 달아준다
	  for(var i = 0; i < values.length; i++) {
			
			if(isExceptArea(names[i].firstChild.nodeValue)){
				j = j - 1;				
			}
			else{
				var option = new Option(names[i].firstChild.nodeValue, values[i].firstChild.nodeValue);
				option.title = names[i].firstChild.nodeValue;
	       		toObj.options[i+j] = option;
	       		
	       	}
	   }

	  if(values.length=='0'&&toObj=='county1'){
		   alert('네트워크가 원활하지 않습니다.\n\n다시선택하여 주시기를 바립니다.');
		   return;
	   }
	}

	function normalSearch(currentPage){
		var form = document.check;
		var keyword = "";
		var cityText='',countyText='',townText='',orgNm='순천시청',orgCode='232';
		var special_pattern = /['~!@#$%^&*|\\\'\'';:\.?]/gi;
		
		cityText= form.city1.options[form.city1.selectedIndex].text;
		countyText = form.county1.options[form.county1.selectedIndex].text;
		townText = form.town1_oldaddr.options[form.town1_oldaddr.selectedIndex].text;

		if(form.city1.value=='') cityText='';
		if(form.county1.value=='') countyText='';
		if(form.town1_oldaddr.value=='')	townText = '';
		if(form.bdnm.value=='') {alert("건물명을 입력하세요!"); form.bdnm.focus(); return;}

		form.engineCtpNm.value =cityText;
		form.engineSigNm.value =countyText;
		form.engineEmdNm.value =townText;
		form.engineBdNm.value = trim(form.bdnm.value);
		form.currentPage.value =currentPage;
		
		var url = "";

		url = "<c:url value="/gis/newGisZip/ajax.do"/>" + "?getUrl="+escape("http://www.juso.go.kr/link/search.do?extend=true&mode=bdnm_search&searchType=location_buld&topTab=1&engineCtpNm="+encodeURI(cityText)+"&engineSigNm="+encodeURI(countyText)+"&engineEmdNm="+encodeURI(townText)+"&engineBdNm="+encodeURI(trim(form.bdnm.value))+"&currentPage="+currentPage+"&orgCode="+orgCode+"&orgNm="+encodeURI(orgNm));
		
		createXMLHttpRequest();
		
	 	xmlHttp.onreadystatechange = handleStateChangeSearch;
	  	xmlHttp.open("GET", url, true);
	  	xmlHttp.send(null);
	}
	

	function trim(str){
		var temp = str.replaceAll(" ","");
		return temp;
	}

	function normalSearch2(currentPage){
		var url;
		var form = document.check;
		var orgNm='순천시청',orgCode='232';
		form.currentPage.value =currentPage;

		currentPage=parseInt((currentPage/10)+1);
				   
		url = "<c:url value="/gis/newGisZip/ajax.do"/>" + "?getUrl="+escape("http://www.juso.go.kr/link/search.do?extend=true&mode=road_search&searchType=location_buld&topTab=1&engineCtpNm="+encodeURI(form.engineCtpNm.value)+"&engineSigNm="+encodeURI(form.engineSigNm.value)+"&engineEmdNm="+encodeURI(form.engineEmdNm.value)+"&engineBdNm="+encodeURI(trim(form.engineBdNm.value))+"&currentPage="+currentPage+"&orgCode="+orgCode+"&orgNm="+encodeURI(orgNm));
		
		createXMLHttpRequest();
		
	 	xmlHttp.onreadystatechange = handleStateChangeSearch;
	  	xmlHttp.open("GET", url, true);
	  	xmlHttp.send(null);
	
	}

	/* 
	 fListScale : 한페이지 출력할 게시물수 
	 fPageScale : 페이지수를 표시할 갯수 
	 fTotal : 전체 게시물수 
	 fStart : 리스트를 뿌릴 시작점(최근게시물로 order by 해서 뽑아 내는 자료라면 가장 최근 자료가 0번이 됨 
	 fPagingUrl : 클릭시 넘어갈 페이지 
	 */ 

	 function getPaging(fListScale,fPageScale,fTotal,fStart,fPagingUrl) { 
		 if(fStart=='1')
			 fStart = fStart-1;
	     var fReturn = ""; 
	     var fPage; 
	     var fPP; 
	     var fNP; 
	     var fPreStart; 
	     var fLn; 
	     var fVk; 
	     var fNstart; 
	     var fLast; 
	     if(fTotal > fListScale) { 
	         fPage =  Math.floor(fStart/(fListScale*fPageScale)); 
	 
	         fReturn = fReturn + "<table border='0' cellpadding='0' cellspacing='1'><tr><td align='center' class='paging'> "; 
	 
	         fPP=fStart-fListScale; 
	         fNP=parseInt(fStart)+parseInt(fListScale); 
	         // 처음으로 이동 
	         if(fPP>=0) { 
	        	 fReturn = fReturn + " <a href='javascript:normalSearch2(1)'>처음</a> "; 
	         } 
	 
	         // sPageScale 만큼 앞으로 이동 
	         if( fStart+1 >  fListScale*fPageScale ) { 
	             fPreStart = fListScale*(fPage*fPageScale - 1); 
	             if(fPreStart<0)
	            	 fPreStart=-fPreStart;
	             fReturn  = fReturn + "<a href='javascript:normalSearch2(" +fPreStart+ ")'>이전</a> ";
	              
	         } 
	 
	         // sPageScale 만큼 출력 
	         for(i=0; i < fPageScale ; i++) { 
	             fLn = (fPage * fPageScale + i)*fListScale; 
	             fVk= fPage * fPageScale + i+1; 
	             
	             if(fLn<fTotal) { 
	            	 
						if(fLn!=fStart) {
							fReturn  = fReturn + " <a href='javascript:normalSearch2(" + fLn + ")'>" + fVk + "</a> "; }
						else {
							fReturn  = fReturn + " <span style='color:#FCC600;'>" + fVk + "</span> ";}	
		          }  
	         } 
	 
	         // sPageScale 만큼 뒤로 이동 
	         if(fTotal > ((fPage+1)*fListScale*fPageScale)) { 
	             fNstart=(fPage+1)*fListScale*fPageScale; 
	             fReturn  = fReturn + " <a href='javascript:normalSearch2(" + fNstart+ ")'>다음</a> "; 
	         } 
	 
	         // 마지막 페이지 
	       
	         if(fNP<fTotal) { 
	             fLast = (Math.floor(fTotal/fListScale))*fListScale; 
	             fReturn  = fReturn + "<a href='javascript:normalSearch2(" + fLast+ ")'>마지막</a> "; 
	         } 
	 
	         fReturn  = fReturn + "  </td></tr></table>"; 
	     } 
	     return fReturn; 
	 } 
	/*
		회원가입창으로 파라미터 전송
	*/
	
	function setParentValue(newaddr,setDetailJuso){
		var result = newaddr.split(",");
 		
		document.getElementById("formbox").innerHTML =""; 
 		document.getElementById("formbox").innerHTML += "<li class='popuproad'>도로명 :&nbsp;&nbsp;&nbsp;<input type='text' style='inputroad' value='"+result[3]+" "+result[4]+"' readonly='readOnly'></input></li>";
		document.getElementById("formbox").innerHTML += "<li class='popuproad'>상세주소 :&nbsp;<input type='text' id='detail' name='detail' width='50px' /></li>";
		document.getElementById("formbox").innerHTML += "<li class='popuproad'>참고항목 :&nbsp;<input type='text' value='"+result[5]+"' ></input></li>";
		document.getElementById("formbox").innerHTML += "<li class='popuproad'>우편번호 :&nbsp;<input type='text' id='zip' name ='zip' width='50px' value="+result[0]+" /></li>";
		document.getElementById("formbox").innerHTML += "<li class='popuproad'>※상세주소 : 동·층·호</li>";
		document.getElementById("formbox").innerHTML += "<li class='popuproad'>※참고항목 :(법정동,공동주택명)</li>";
		document.getElementById("formbox").innerHTML += "<li class='inputdata'><a href='javascript:setOpenerValue(\""+newaddr+"\")'><img src='http://www.juso.go.kr/images/link/btn_input.gif' alt='' /></a></li>";
		document.getElementById("formbox").innerHTML += "<li class='inputdata'><img src='http://www.juso.go.kr/images/test.gif' alt='' width='380px' /></li>";
		document.getElementById("formbox").innerHTML += "<li class='inputdata'>자세한 표기법은   <a href='http://www.juso.go.kr' style='font-size: 10px' target='_blank'>도로명주소안내홈페이지</a> 를 참조하세요</li>";
		
		

	 }
	 function setOpenerValue(val){
		 
		 var result = val.split(",");
		 var post = result[0].split("-");
		 var oldAddr1 = result[1];
		 var oldAddr2 = result[2];
		 var newAddr1 = result[3]+ " " + result[4];
		 var newAddr2 = result[5]+ " " + $('#detail').val();
		 
		 var of = opener.document.${param.retForm};
		/* 2014-06-03 by.나성재 수정 값 선언 에러처리 */	 
		try{
			<c:if test="${!empty param.retZip1}">
				of.${param.retZip1}.value = post[0];
			</c:if>
		}catch(e){
			opener.console.log("${param.retZip1} not defined");
		}		
		try{
			<c:if test="${!empty param.retZip2}">
				of.${param.retZip2}.value = post[1];
			</c:if>	 
		}catch(e){
			opener.console.log("${param.retZip2} not defined");	
		}			 
		try{
			<c:if test="${!empty param.retAddr}">
				of.${param.retAddr}.value = oldAddr1;
			</c:if>	 
		}catch(e){
			opener.console.log("${param.retAddr} not defined");		
		}			 
		try{
			<c:if test="${!empty param.retAddrDetail}">
				of.${param.retAddrDetail}.value = oldAddr2;
			</c:if>	 
		}catch(e){
			opener.console.log("${param.retAddrDetail} not defined");	
		}		 
		try{
			<c:if test="${!empty param.retNewaddr}">
				of.${param.retNewaddr}.value = newAddr1;
			</c:if> 
		}catch(e){
			opener.console.log("${param.retNewaddr} not defined");
		}		 
		try{
			<c:if test="${!empty param.retNewaddrDetail}">
				of.${param.retNewaddrDetail}.value = newAddr2;
			</c:if> 
		}catch(e){
			opener.console.log("${param.retNewaddrDetail} not defined");		
		}	 
		/* 2014-06-03 by.나성재 수정 함수호출 주석처리
		<c:if test="${!empty param.retFunction}">
			$(opener.location).attr("href","javascript:${param.retFunction}();");
		</c:if>
		*/
		try{
			<c:if test="${param.retFunction == 'boardZip'}">
				of.${param.retAddr}.value = post[0] +"-"+ post[1] + " " + newAddr1 + " " +newAddr2;
			</c:if>	 
		}catch(e){
			opener.console.log("${param.retAddr} not defined");	
		}		 
		try{
			<c:if test="${param.retFunction == 'addrZip'}">
				of.${param.retPost}.value = post[0] +"-"+ post[1];
				of.${param.retAddr}.value = newAddr1 + " " +newAddr2;
			</c:if>
		}catch(e){
			opener.console.log("${param.retPost} not defined or ${param.retAddr} not defined");		
		}		
		try{
			<c:if test="${param.retFunction == 'plusZip'}">		 	
				of.${param.retPost}.value = post[0] +"-"+ post[1];
				of.${param.retAddr}.value = oldAddr1 + " " +oldAddr2;
				of.${param.retNewaddr}.value = newAddr1 + " " +newAddr2;
		 	</c:if>	 
		}catch(e){
			opener.console.log("${param.retPost} not defined or ${param.retAddr} not defined or ${param.retNewaddr} not defined");		
		}
		
		/*
		//각 jsp의 원하는 함수 호출 
		try{
		//opener.businessAddr();
		}catch(e){
		//alert("fail"); 
		}
		*/
		 window.close();
	 }


	 //
	function selectSearch(mode) {
		if (mode == 'road'){
			document.location.href = "<c:url value="/gis/newGisZip/road.do"/>"+"?retForm=${param.retForm}"
					+"&retZip1=${param.retZip1}"
					+"&retZip2=${param.retZip2}"
					+"&retAddr=${param.retAddr}"
					+"&retAddrDetail=${param.retAddrDetail}"
					+"&retPost=${param.retPost}"
					+"&retNewaddr=${param.retNewaddr}"
					+"&retNewaddrDetail=${param.retNewaddrDetail}"
					+"&retFunction=${param.retFunction}"
					;
		}else if(mode =='jibun'){
			document.location.href = "<c:url value="/gis/zip.do"/>"+"?retForm=${param.retForm}"
					+"&retZip1=${param.retZip1}"
					+"&retZip2=${param.retZip2}"
					+"&retAddr=${param.retAddr}"
					+"&retAddrDetail=${param.retAddrDetail}"
					+"&retPost=${param.retPost}"
					+"&retNewaddr=${param.retNewaddr}"
					+"&retNewaddrDetail=${param.retNewaddrDetail}"
					+"&retFunction=${param.retFunction}"
					;
		}else if(mode=='sangho'){
			document.location.href = "<c:url value="/gis/newGisZip/sangho.do"/>"+"?retForm=${param.retForm}"
					+"&retZip1=${param.retZip1}"
					+"&retZip2=${param.retZip2}"
					+"&retAddr=${param.retAddr}"
					+"&retAddrDetail=${param.retAddrDetail}"
					+"&retPost=${param.retPost}"
					+"&retNewaddr=${param.retNewaddr}"
					+"&retNewaddrDetail=${param.retNewaddrDetail}"
					+"&retFunction=${param.retFunction}"
					;
		}	
	}

	/*
	 *	key down function (엔터키가 입력되면 검색함수 호출)
	 */
	function checkKeyASearch(){
		if(event.keyCode == KEY_ENTER){
			normalSearch('1');
		}
	}
</script>
</head>
<body>
<div id="wrapper">
	<div id="header">
		<h1>
			<img src="http://www.juso.go.kr/images/link/h1.jpg" alt="도로명주소찾기(우편번호)">
		</h1>
	</div>
	<div id="container">
		<div id="content">
			<ul class="tab">
				<li><a href="#n" onclick="selectSearch('road');return false;"><img src="http://www.juso.go.kr/images/link/tab1_off.gif" alt="도로명주소"/></a></li>
				<li><a href="#n" onclick="selectSearch('jibun');return false;"><img src="http://www.juso.go.kr/images/link/tab2_off.gif" alt="지번"/></a></li>
				<li><a href="#n" onclick="selectSearch('sangho');return false;"><img src="http://www.juso.go.kr/images/link/tab3.gif" alt="건물명"/></a></li>
			</ul>
			
				<form name="check" method="post">
					<input type="hidden" name="searchType" id="searchType" value ="" />
					<input type="hidden" name="san1" id="san1"  value="0"/>
					<input type="hidden" name="extend"      id="extend"       value="${extend}"/>
					<input type="hidden" name="engineCtpNm" id="engineCtpNm"  value="${engineCtpNm}"/>
					<input type="hidden" name="engineSigNm" id="engineSigNm"  value="${engineSigNm}"/>
					<input type="hidden" name="engineEmdNm" id="engineEmdNm"  value="${engineEmdNm}"/>
					<input type="hidden" name="engineLiNm" id="engineLiNm"  value="${engineLiNm}"/>
					<input type="hidden" name="engineBdNm" id="engineBdNm"  value="${engineBdNm}"/>
					<input type="hidden" name="engineRdNm" id="engineRdNm"  value="${engineRdNm}"/>
					<input type="hidden" name="engineMtYn" id="engineMtYn"  value="${engineMtYn}"/>
					<input type="hidden" name="engineBdMaSn" id="engineBdMaSn"  value="${engineBdMaSn}"/>
					<input type="hidden" name="engineBdSbSn" id="engineBdSbSn"  value="${engineBdSbSn}"/>
					<input type="hidden" name="currentPage" id="currentPage"  value="${currentPage}"/>
				<div class="form" id="formbox">
					<fieldset>
						<legend>정보 입력</legend>
						
						<div class="group">
						<p class="input">
							<label for="siCode"><strong>시&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;도</strong></label>
							<select title="시/도 선택"  name="city1" onchange="javascript:changeAreaList(1, this);" id="city1" style="width:185px">
								<option value="">::선택::</option>
									<option value="11" title="서울특별시" >서울특별시</option>
									<option value="26" title="부산광역시" >부산광역시</option>
									<option value="27" title="대구광역시" >대구광역시</option>
									<option value="28" title="인천광역시" >인천광역시</option>
									<option value="29" title="광주광역시" >광주광역시</option>
									<option value="30" title="대전광역시" >대전광역시</option>
									<option value="31" title="울산광역시" >울산광역시</option>
									<option value="36" title="세종특별자치시" >세종특별자치시</option>
									<option value="41" title="경기도">경기도</option>
									<option value="42" title="강원도" >강원도</option>
									<option value="43" title="충청북도" >충청북도</option>
									<option value="44" title="충청남도" >충청남도</option>
									<option value="45" title="전라북도" >전라북도</option>
									<option value="46" title="전라남도" >전라남도</option>
									<option value="47" title="경상북도" >경상북도</option>
									<option value="48" title="경상남도" >경상남도</option>
									<option value="50" title="제주특별자치도" >제주특별자치도</option>
							</select>
						</p>
						<p class="input">
							<label for="siCode2"><strong>시&nbsp;&nbsp;군&nbsp;&nbsp;구</strong></label>
							<select title="시/군/구 선택"  name="county1" id="county1" style="width:185px" onchange="javascript:changeAreaList(1, this);">
							<option value="">::선택::</option>
							<c:forEach items="${county}" var="county">
								<option value="${county.countyId}">${county.countyName}</option>
							</c:forEach>
							</select>
						</p>
						<p class="input">
							<label for="siCode3"><strong>읍&nbsp;&nbsp;면&nbsp;&nbsp;동</strong></label>
							<select id="town1_oldaddr" name="town1_oldaddr" title="지번주소" onchange="javascript:changeAreaList(1, this); " style="width:185px"> 
								<option value="">::선택::</option>
											<c:forEach items="${town}" var="county">
												<option value="${town.townId}" >${town.townName }</option>
											</c:forEach>
							</select>
						</p>
						<p class="input" >
							<label for="bd_number1"><strong>건&nbsp;&nbsp;물&nbsp;&nbsp;명</strong></label>
							<input type="text" name="bdnm" value="" id="bdnm" class="text" style="width:185px;ime-mode:active" onkeypress="checkKeyASearch();return false;"/>
						 </p>
						</div>
						<div class="btn">
							<a href="#"><img src="http://www.juso.go.kr/images/link/btn_search.gif" alt="검색" onclick="normalSearch('1');return false;" /></a>
						</div>
						<div >
							<img src="http://www.juso.go.kr/images/test.gif" alt="" width="380px" />
							자세한 표기법은   <a href="http://www.juso.go.kr" style="font-size: 10px" target="_blank">도로명주소안내홈페이지</a> 를 참조하세요
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</div>

</body>
</html>
