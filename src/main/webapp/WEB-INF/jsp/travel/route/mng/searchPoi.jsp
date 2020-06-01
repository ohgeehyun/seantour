<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우편번호 검색</title>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">
<style>
* {
    padding: 0;
    margin: 0;
    border: 0;
    box-sizing: border-box;
}

body {
    color: #666;
    font-size: 15px;
    font-family: 'Noto Sans', sans-serif;
    word-break: keep-all;
    word-wrap: break-word;
    white-space: normal;
    line-height: 1.5;
    overflow: hidden;
}

table {
    width: 100%;
    border-spacing: 0;
    border-collapse: collapse;
}

a {
    color: inherit;
    text-decoration: none;
}

ul,
ol {
    list-style: none;
}

.blind {
    position: absolute;
    overflow: hidden;
    clip: rect(0px, 0px, 0px, 0px);
    margin: 10px;
    width: 1px;
    height: 1px;
}

.mainDiv {
    width: 100%;
    position: relative;
	max-width: 600px;
	margin:auto;
}

/* -------TOP------- */

#divtop {
    position: relative;
    background: #ff7a00;
    height: 45px;
    text-align: center;
}

#divtop h3 {
    width: 200px;
    height: 45px;
    line-height: 45px;
    margin: 0 auto;
}

#divtop .top_tit {
    font-size: 18px;
    font-weight: 400;
    position: relative;
    color: #fff;
}
/* -------CONTENT------- */

#divSearch {
    padding: 15px 20px;
    /*background: beige;*/
}

#divSearch p {
    font-size: 14px;
    margin-top: 8px;
    margin-left: 15px;
    color: #333;
}

#divSearch p b {
    color: #ff7a00;
}

#divSearch .search_box {
    border-bottom: 2px solid #ff7a00;
    padding: 0 15px;
}

#divSearch .search_box .inputGrp {
    overflow: hidden;
}

.inputGrp .btn_sch {
    background: transparent;
    border: 0;
    float: right;
    height: 44px;
    line-height: 44px;
    outline: 0;
    position: relative;
}

.inputGrp .btn_sch .ico_sch {
    display: inline-block;
    width: 24px;
    height: 24px;
    line-height: 24px;
    position: relative;
    cursor: pointer;
    vertical-align: middle;
}

.inputGrp .btn_sch .ico_sch:before,
.inputGrp .btn_sch .ico_sch:after {
    content: '';
    display: block;
    position: absolute;
    top: 0;
    left: 0;
}

.inputGrp .btn_sch .ico_sch:before {
    width: 13px;
    height: 13px;
    border: 2px solid #ff7a00;
    border-radius: 100%;
    -webkit-border-radius: 100%;
    -moz-border-radius: 100%;
}

.inputGrp .btn_sch .ico_sch:after {
    width: 2px;
    height: 10px;
    background: #ff7a00;
    transform: rotate(-45deg);
    -webkit-transform: rotate(-45deg);
    -moz-transform: rotate(-45deg);
    -o-transform: rotate(-45deg);
    -ms-transform: rotate(-45deg);
    top: 12px;
    left: 16px;
}

.inputGrp .input_sch {
    height: 44px;
    background: #fff;
    padding: 5px 9px 0 0px;
    overflow: hidden;
}

.inputGrp .input_sch input {
    border: none;
    padding: 0px;
    margin: 0px;
    width: 100%;
    height: 100%;
    outline: none;
    font-size: 17px;
}

#divSearchlist {
    background: #f4f4f4;
    padding: 20px;
    clear: both;
}
#divSearchlist .result {
    margin-bottom: 8px;
}
#divSearchlist .tb_wrap {
    height: 400px;
    overflow-y: auto;
}

#divSearchlist table {
    border-top: 1px solid #dbdbdb;
    border-bottom: 1px solid #dbdbdb;
}

#divSearchlist table thead * {
    height: 0ox;
    line-height: 0px;
    text-indent: -9999px;
    font-size: 0;
    color: #fff;
}

#divSearchlist table tbody td {
    background: #fff;
    padding: 10px 15px;
    border-bottom: 1px solid #dbdbdb;
}

ul.tb1 {
    display: table;
    width: 100%;
}

ul.tb1>li.row {
    display: table-row !important;
}

ul.tb1>li.row div:nth-child(2) {
    padding-bottom: 7px;
}

ul.tb1>li.row>div.th {
    display: table-cell;
    width: 70px;
}

ul.tb1>li.row span.label {
    display: inline-block;
    width: 60px;
    text-align: center;
    color: #fff;
    padding: 2px 5px;
    font-size: 13px;
    font-weight: 600;
}

ul.tb1>li.row span.st {
    background: #8faae4;
    width: 240px;
    margin-right: 10px;
}

ul.tb1>li.row span.num {
    background: #b5bbd1;
}

ul.tb1>li.row span.sel {
    background: #ff6600;
    cursor: pointer;
}

ul.tb1>li.row .post {
    color: #ff2121;
    font-size: 18px;
}

/* Page navigation */
#pageZone {
    padding: 5px 0;
    text-align: center;
}

.btn_pageNum {
    width: 35px;
    height: 30px;
    line-height: 30px;
    text-align: center;
    background-color: #f9f9f9;
    border: 1px solid #eeeeee;
    display: inline-block;
    color: inherit;
    font-size: 12px;
}

.btn_pageNum_active {
    background-color: #fce1d8;
}

.btn_pageNum:hover {
    background-color: #fef1ec;
}

.btn_pageNum:active {
    background-color: #fce1d8;
}
</style>
</head>
<body>
<div class="mainDiv">
	<input type="hidden" id="inpPage" type="text" value="1">
	<input type="hidden" id="inpTotLimit" type="text" value="7">
    <div id="divtop">
            <h3>
                <span class="ico_sch"></span>
                <span class="top_tit">명칭 검색</span>
            </h3>
        </div>
        <div id="divcont">
            <div id="divSearch">
                <fieldset class="search_box">
                    <legend class="blind">검색어 입력창</legend>
                    <div class="inputGrp">
                        <button class="btn_sch" name="btn_sch" id="inpSearch">
                            <span class="ico_sch"></span>
                        </button>
                        <div class="input_sch">
                            <input type="text" id="inpKeyword" title="검색" placeholder="예) 을지로, 바다식당">
                        </div>
                    </div>
                </fieldset>
            </div>
            <div id="divSearchlist">
               <div class="result">
                   <p>검색결과 : 총 <strong id="spanTotCnt">0</strong>건</p>
               </div>
                <div class="tb_wrap">
                    <table>
                        <caption class="blind">검색결과 리스트</caption>
                        <thead>
                            <tr>
                                <th>우편번호/도로명/지명</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyResult">
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div id="pageZone"></div>
	
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script>
		function init(){
			$('#inpKeyword').focus();
		}
		
		function isValidate() {
			var keyword = $('#inpKeyword').val();
			var totLimit = $('#inpTotLimit').val();
			var page = $('#inpPage').val();
			
			if( $.trim( keyword ) == '' ) {
				alert('검색어를 입력해주세요.');
				return false;
			}
			
			if( $.trim( totLimit ) == '' || $.isNumeric( totLimit ) == false || totLimit <= 0 ) {
				$('#inpTotLimit').val('20');
			}
			
			if( $('#inpTotLimit').val() > 200 ) {
				$('#inpTotLimit').val('200');
				alert('200개 이상의 항목은 페이지번호를 이용해주세요.');
			}
			
			if( $.trim( page ) == '' || $.isNumeric( page ) == false || page <= 0 ) {
				$('#inpPage').val('1');
			}
			
			return true;
		}
		
		// 검색어 입력 창
		$('#inpKeyword').keydown(function(e){
			if(e.keyCode == 13) {
				$('.btn_sch').trigger('click');
			}
		});
		
		// 페이지 수 입력 창
		$('#inpPage').keydown(function(e){
			if(e.keyCode == 13) {
				$('.btn_sch').trigger('click');
			}
		});
		
		// 검색 결과 제한 수 입력 창
		$('#inpTotLimit').keydown(function(e){
			if(e.keyCode == 13) {
				$('.btn_sch').trigger('click');
			}
		});
		
		// 페이징 클릭
		function goPage(movePage){
			$('#inpPage').val(movePage);
			$('.btn_sch').trigger('click');
		}
		
		// 검색 버튼
		$('#inpSearch').click(function(){
			// 유효성 검사
			isValidate();
			
			var appKey='l7xxdc2398be8423441f817695db47fd1e32';
			var url = 'https://apis.openapi.sk.com/tmap/pois';
		
			// https://apis.openapi.sk.com/tmap/pois?version={version}&page={page}&count={count}&searchKeyword={searchKeyword}&areaLLCode={areaLLCode}&areaLMCode={areaLMCode}&resCoordType={resCoordType}&searchType={searchType}&searchtypCd={searchtypCd}&radius={radius}&reqCoordType={reqCoordType}&centerLon={centerLon}&centerLat={centerLat}&multiPoint={multiPoint}&callback={callback}&appKey={appKey}

			var params = {
				"appKey" : appKey,
				"version" : "1",
				"searchKeyword" : $('#inpKeyword').val(),
				// "searchType" : "name", // all:통합검색, name:명칭검색, telno:전화번호 검색
				// "areaLLCode" : $('#inpTotLimit').val(),
				"page" : $('#inpPage').val(),
				"count" : $('#inpTotLimit').val()
			};
			$.get(url, params, success)
			 .fail(fail);
		});

		function success( data ) {
			console.log(data); //return;

			var arrResult = data.searchPoiInfo.pois.poi;
			var error = data.error;
			var strHtml = '';
			
			// var jibunAddr = '';
			// var newRoadAddr = '';
			
			// 전체 검색 수
			var totalCnt = data.searchPoiInfo.totalCount;
			$('#spanTotCnt').html( totalCnt );
			
			//페이징 처리----------------------------------------------------------------
			var totalCnt = data.searchPoiInfo.totalCount; //전체 검색 건수
				console.log("totalCnt", totalCnt);
			var totalPage = Math.ceil(totalCnt/$('#inpTotLimit').val());//페이지 수
				console.log("totalPage", totalPage);
			var curentPage = $('#inpPage').val();//현재 페이지
				console.log("curentPage", curentPage);
			var pageHtml; //페이지 리스트
			
			var pageGroup = Math.ceil(curentPage/10);    //페이지 그룹 넘버링

			var next = pageGroup*10;
			var prev = next-9;            
			
			var goNext = next+1;
			if(prev-1<=0){
				var goPrev = 1;
			}else{
				var goPrev = prev-1;
			}    
			
			if(next>totalPage){
				var goNext = totalPage;
				next = totalPage;
			}else{
				var goNext = next+1;
			}
			
			if(totalPage>1){
				var prevStep = " <a class='btn_pre btn_pageNum' href='javascript:goPage("+goPrev+");'>◀</a> ";
				var nextStep = " <a class='btn_nxt btn_pageNum' href='javascript:goPage("+goNext+");'>▶</a> ";
			}
			
			$("#pageZone").empty();
			$("#pageZone").append(prevStep);
			for(var i=prev; i<=next;i++){
				if(curentPage == i){
					PageHtml = "<strong><a class='btn_pageNum btn_pageNum_active' href='javascript:goPage("+i+");'>"+i+"</a></strong> ";
				}else{
					PageHtml = "<strong><a class='btn_pageNum' href='javascript:goPage("+i+");'>"+i+"</a></strong> ";
				}
				$("#pageZone").append(PageHtml);
			}    
			$("#pageZone").append(nextStep);
			//페이징 처리----------------------------------------------------------------			
			
			for( var i in arrResult ) {
				
				/*//법정동 마지막 문자 
				var lastLegal = arrResult[i].legalDong.charAt(arrResult[i].legalDong.length-1);*/
				
				/*// 새주소 
				newRoadAddr = arrResult[i].city_do + ' ' + arrResult[i].gu_gun + ' '; 
				
				if(arrResult[i].eup_myun == '' && (lastLegal=="읍"||lastLegal=="면")){//읍면
					newRoadAddr +=  arrResult[i].legalDong;	
				}else{
					newRoadAddr +=  arrResult[i].eup_myun;
				}
				newRoadAddr += ' ' +arrResult[i].newRoadName + ' ' + arrResult[i].newBuildingIndex;
				
				// 새주소 법정동& 건물명 체크
				if(arrResult[i].legalDong != '' && (lastLegal!="읍"&&lastLegal!="면")){//법정동과 읍면이 같은 경우
					
					if(arrResult[i].buildingName != ''){//빌딩명 존재하는 경우
						newRoadAddr +=  (' (' + arrResult[i].legalDong + ', ' +arrResult[i].buildingName +') ');
					}else{
						newRoadAddr += (' (' + arrResult[i].legalDong + ')');
					}
				}else if(arrResult[i].buildingName != ''){//빌딩명만 존재하는 경우
					newRoadAddr +=  (' (' + arrResult[i].buildingName +') ');
				}*/
				
				// 구주소
				/*jibunAddr = arrResult[i].city_do + ' ' + arrResult[i].gu_gun + ' ' + arrResult[i].legalDong + ' '+ arrResult[i].ri + ' ' + arrResult[i].bunji;
				//구주소 빌딩명 존재
				if(arrResult[i].buildingName != ''){//빌딩명만 존재하는 경우
					jibunAddr +=  (' '+arrResult[i].buildingName);
				}*/
				
				strHtml+='<tr>';
				strHtml+='	<td>';
				strHtml+='		<ul class="tb1">';
				/*strHtml+='			<li class="row">';
				strHtml+='				<div class="th blind">명칭</div>';
				strHtml+='				<div class="post">'+ arrResult[i].name +'</div>';
				strHtml+='			</li>';*/
				strHtml+='			<li class="row">';
				strHtml+='				<div class="th"><span class="label st">'+ arrResult[i].name +'</span></div>';
				strHtml+='				<div> ' + arrResult[i].upperAddrName + arrResult[i].middleAddrName + arrResult[i].lowerAddrName + '</div>';
				strHtml+='				<div class="th"><span class="label sel" onclick="setAddress(\''+ arrResult[i].name +'\', \''+ arrResult[i].frontLat +'\', \''+ arrResult[i].frontLon +'\');">선택</span></div>';
				strHtml+='			</li>';
				strHtml+='		</ul>';
				strHtml+='	</td>';
				strHtml+='</tr>';
				
			}
			if( error || arrResult.length <= 0 ) {
				strHtml+='<tr>';
				strHtml+='	<td colspan="2">';
				strHtml+='		<span>검색결과가 없습니다.</span>';
				strHtml+='	</td>';
				strHtml+='</tr>';
			}
			
			$('#tbodyResult').html(strHtml);
		}
		
		function fail(){
			var strHtml="";
			strHtml+='<tr>';
			strHtml+='	<td>';
			strHtml+='		<span>검색결과가 없습니다.</span>';
			strHtml+='	</td>';
			strHtml+='</tr>';
			
			$('#spanTotCnt').html( '0' );
			$('#tbodyResult').html(strHtml);
		}

		function setAddress(roadFullAddr, latitude, longitude) {
			if(typeof(window.opener) != "undefined") {
				window.opener.addrCallBack(roadFullAddr, latitude, longitude, '${status}');
				window.self.close();
			}			
		}
		
		$(function(){
			init();
			
		});
	</script>
</div>	
</body>
</html>