<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript">

function goPopup(){
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	var pop = window.open("/suncheon/popup/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}


function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.form.roadFullAddr.value = roadFullAddr;
		document.form.roadAddrPart1.value = roadAddrPart1;
		document.form.roadAddrPart2.value = roadAddrPart2;
		document.form.addrDetail.value = addrDetail;
		document.form.engAddr.value = engAddr;
		document.form.jibunAddr.value = jibunAddr;
		document.form.zipNo.value = zipNo;
		document.form.admCd.value = admCd;
		document.form.rnMgtSn.value = rnMgtSn;
		document.form.bdMgtSn.value = bdMgtSn;
}

</script>
<title>주소 입력 샘플</title>
</head>
<body>
<form name="form" id="form" method="post">

	<input type="button" onClick="goPopup();" value="팝업_domainChk"/>
	<div id="list"></div>
	<div id="callBackDiv">
		<table>
			<tr><td>도로명주소 전체(포멧)</td><td><input type="text"  style="width:500px;" id="roadFullAddr"  name="roadFullAddr" /></td></tr>
			<tr><td>도로명주소           </td><td><input type="text"  style="width:500px;" id="roadAddrPart1"  name="roadAddrPart1" /></td></tr>
			<tr><td>고객입력 상세주소    </td><td><input type="text"  style="width:500px;" id="addrDetail"  name="addrDetail" /></td></tr>
			<tr><td>참고주소             </td><td><input type="text"  style="width:500px;" id="roadAddrPart2"  name="roadAddrPart2" /></td></tr>
			<tr><td>영문 도로명주소      </td><td><input type="text"  style="width:500px;" id="engAddr"  name="engAddr" /></td></tr>
			<tr><td>지번 주소            </td><td><input type="text"  style="width:500px;" id="jibunAddr"  name="jibunAddr" /></td></tr>
			<tr><td>우편번호             </td><td><input type="text"  style="width:500px;" id="zipNo"  name="zipNo" /></td></tr>
			<tr><td>행정구역코드        </td><td><input type="text"  style="width:500px;" id="admCd"  name="admCd" /></td></tr>
			<tr><td>도로명코드          </td><td><input type="text"  style="width:500px;" id="rnMgtSn"  name="rnMgtSn" /></td></tr>
			<tr><td>건물관리번호        </td><td><input type="text"  style="width:500px;" id="bdMgtSn"  name="bdMgtSn" /></td></tr>
		</table>
	</div>

</form>
</body>
</html>