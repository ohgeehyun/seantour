<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<c:set var="registerFlag" value="${empty jnitbbsinfoVO.bbsId ? '등록' : '수정'}"/>	

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitbbsinfoVO").action = "<c:url value='/cms/sub5/0101.do'/>";
   	document.getElementById("jnitbbsinfoVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
	if(confirm("정말 삭제하시겠습니까?") == true) {
   		document.getElementById("jnitbbsinfoVO").action = "<c:url value='/cms/sub5/0102del.do'/>";
   		document.getElementById("jnitbbsinfoVO").submit();
	}
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitbbsinfoVO");

        /* ClientSite Validator */
	//if(!validateJnitbbsinfoVO(frm)){
	//		return;
	//}

	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/cms/sub5/0102up.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/cms/sub5/0102add.do'/>";
	</c:if>
    frm.submit();

}

// -->
</script>

<form:form commandName="jnitbbsinfoVO">

<ul class="view_content_btn">
    <!--li class="add"><a href="#">추가</a></li-->
    <li class="back"><a href="javascript:fn_egov_selectList();">되돌아가기</a></li>
    <!--li class="modify"><a href="#">수정</a></li-->
    <li class="delete"><a href="javascript:fn_egov_delete();">삭제</a></li>
    <li class="save"><a href="javascript:fn_egov_save();">저장</a></li>
    <!--li class="search_btn">
        <form action="#" id="search_form" name="search_form">
            <select name="search_select" id="search_select">
                <option selected="selected" value="#">등록일순</option>
                <option value="#">수정일순</option>
                <option value="#">이름순</option>
                <option value="#">설명순</option>
                <option value="#">파일명순</option>
            </select>
            <input name="search" id="search" type="text" />
            <a href="#">검색</a>
        </form>
        <form action="#" id="search_form" name="search_form">
            <input name="search_day1" id="search_day" type="text" />&nbsp;<strong>~</strong>&nbsp;
            <input name="search_day2" id="search_day" type="text" />
            <a href="#">검색</a>
        </form>
    </li-->
</ul>
<div class="view">
<!--콘텐츠시작-->
    <table border="0" cellspacing="0" cellpadding="0" class="table content2_table" summary="게시판 등록">
        <caption>게시판 등록</caption>
        <tbody>
            <tr>
                <th width="30%"><font color="red">*</font> 게시판 제목</th>
                <td><form:input style="width:98%;" path="bbsTitle" cssClass="txt"/>
                &nbsp;<form:errors path="bbsTitle" /></td>
            </tr>
            <tr>
                <th width="30%">게시판 그룹</th>
                <td><form:input style="width:200px;" path="bbsGroup" value="${jnitbbsinfoVO.bbsGroup == '' ? '기본그룹' : ''}"  cssClass="txt"/>
                (게시판관리시 구분을 위해 게시판그룹을 지정할 수 있습니다.)
                &nbsp;<form:errors path="bbsGroup" /></td>
            </tr>
            <tr>
                <th width="30%"><font color="red">*</font> 게시판 유형</th>
                <td>
                <c:if test="${registerFlag == '등록'}">
                <select name="bbsType" id="bbsType" style="width:98%;">
                <option value="normal" <c:out value='${jnitbbsinfoVO.bbsType == "normal" ? "selected" : "" }'/>>일반게시판</option>
                <option value="notice" <c:out value='${jnitbbsinfoVO.bbsType == "notice" ? "selected" : "" }'/>>공지게시판</option>
                <option value="gallery" <c:out value='${jnitbbsinfoVO.bbsType == "gallery" ? "selected" : "" }'/>>겔러리게시판</option>
                <option value="thumbnail" <c:out value='${jnitbbsinfoVO.bbsType == "thumbnail" ? "selected" : "" }'/>>섬네일형게시판</option>
                </select>
                </c:if>
                <c:if test="${registerFlag == '수정'}">
                <form:hidden path="bbsType" />
                <c:out value='${jnitbbsinfoVO.bbsType == "normal" ? "일반게시판" : "" }'/>
                <c:out value='${jnitbbsinfoVO.bbsType == "notice" ? "공지게시판" : "" }'/>
                <c:out value='${jnitbbsinfoVO.bbsType == "gallery" ? "겔러리게시판" : "" }'/>
                <c:out value='${jnitbbsinfoVO.bbsType == "thumbnail" ? "섬네일형게시판" : "" }'/>
                </c:if>
                &nbsp;<form:errors path="bbsType" />
                </td>
            </tr>
            <tr>
                <th width="30%"><font color="red">*</font> 게시판 스킨</th>
                <td>
                <form:input style="width:200px;"  value="${registerFlag == '등록' ? 'default' : ''}" path="bbsSkin" cssClass="txt"/>
                (스킨명을 잘못 입력할 경우 게시판이 오동작할 수 있으니 주의바랍니다.)
                &nbsp;<form:errors path="bbsSkin" />
                </td>
            </tr>
            <tr>
                <th width="30%">페이지 당 게시물 갯수</th>
                <td><form:input style="width:98%;" value="${registerFlag == '등록' ? '15' : ''}" path="rowCnt" cssClass="txt"/>
                &nbsp;<form:errors path="rowCnt" /></td>
            </tr>
            <tr>
                <th width="30%">비밀글 사용 여부</th>
                <td>
                <select name="useSecret" id="useSecret">
                <option value="0" <c:out value="${jnitbbsinfoVO.useSecret == 1 ? 'selected' : ''}"/>>아니오</option>
                <option value="1" <c:out value="${jnitbbsinfoVO.useSecret == 1 ? 'selected' : ''}"/>>예</option>
                </select>
                &nbsp;<form:errors path="useSecret" />
                </td>
            </tr>
            <tr>
                <th width="30%">댓글 사용 여부</th>
                <td>
                <select name="useCmt" id="useCmt">
                <option value="0" <c:out value="${jnitbbsinfoVO.useCmt == 1 ? 'selected' : ''}"/>>아니오</option>
                <option value="1" <c:out value="${jnitbbsinfoVO.useCmt == 1 ? 'selected' : ''}"/>>예</option>
                </select>
                &nbsp;<form:errors path="useCmt" />
                </td>
            </tr>
            <tr>
                <th width="30%">공지글 사용 여부</th>
                <td>
                <select name="useNotice" id="useNotice">
                <option value="1" <c:out value="${jnitbbsinfoVO.useNotice == 1 ? 'selected' : ''}"/>>예</option>
                <option value="0" <c:out value="${jnitbbsinfoVO.useNotice == 0 ? 'selected' : ''}"/>>아니오</option>
                </select>
                &nbsp;<form:errors path="useNotice" />
                </td>
            </tr>
            <tr>
                <th width="30%">카테고리 사용 여부</th>
                <td>
                <select name="useCategory" id="useCategory" onchange="if(this.value == '1') { $('#categoryBox').show(); }else { $('#categoryBox').hide(); }">
                <option value="0" <c:out value="${jnitbbsinfoVO.useCategory == 0 ? 'selected' : ''}"/>>아니오</option>
                <option value="1" <c:out value="${jnitbbsinfoVO.useCategory == 1 ? 'selected' : ''}"/>>예</option>
                </select>
                &nbsp;<form:errors path="useCategory" />
                <div style="display:<c:out value="${jnitbbsinfoVO.useCategory == 1 ? 'block' : 'none'}"/>;" id="categoryBox">
                <form:input style="width:300px;"   path="category" cssClass="txt" />
                ( , 구분자를 사용하여 카테고리를 다중등록 가능합니다.)
                </div>
                
                </td>
            </tr>
            <tr>
                <th width="30%">SMS 발송 사용 여부</th>
                <td>
                <select name="useSms" id="useSms" onchange="if(this.value == '1') { $('#smsBox').show(); }else { $('#smsBox').hide(); }">
                <option value="0" <c:out value="${jnitbbsinfoVO.useSms == 0 ? 'selected' : ''}"/>>아니오</option>
                <option value="1" <c:out value="${jnitbbsinfoVO.useSms == 1 ? 'selected' : ''}"/>>예</option>
                </select>
                &nbsp;<form:errors path="useSms" />
                <div style="display:<c:out value="${jnitbbsinfoVO.useSms == 1 ? 'block' : 'none'}"/>;" id="smsBox">
                <form:input style="width:300px;"   path="sms" cssClass="txt" />
                ( 게시글이 작성되면 이 곳에 등록된 휴대전화번호로 SMS가 발송됩니다.)
                </div>
                
                </td>
            </tr>
            <tr>
            	<th width="30%">위지윅에디터 사용 여부</th>
                <td>
                <select name="useEditor" id="useEditor" onchange="if(this.value == '1') { $('.editorOption').show(); }else { $('.editorOption').hide(); }">
                <option value="1" <c:out value="${jnitbbsinfoVO.useEditor == 1 ? 'selected' : ''}"/>>예</option>
                <option value="0" <c:out value="${jnitbbsinfoVO.useEditor == 0 ? 'selected' : ''}"/>>아니오</option>
                </select>
                &nbsp;<form:errors path="useEditor" />
                </td>
            </tr>
            <tr class="editorOption" <c:out value="${jnitbbsinfoVO.useEditor == 1 ? '' : 'style=\"display:none;\"'}" escapeXml="false" /> >
                <th width="30%">이미지첨부 사용 여부</th>
                <td>
                <select name="useImage" id="useImage">
                <option value="1" <c:out value="${jnitbbsinfoVO.useImage == 1 ? 'selected' : ''}"/>>예</option>
                <option value="0" <c:out value="${jnitbbsinfoVO.useImage == 0 ? 'selected' : ''}"/>>아니오</option>
                </select>
                &nbsp;<form:errors path="useImage" />
                </td>
            </tr>
            <tr class="editorOption" <c:out value="${jnitbbsinfoVO.useEditor == 1 ? '' : 'style=\"display:none;\"'}" escapeXml="false" /> >
                <th width="30%">동영상첨부 사용 여부</th>
                <td>
                <select name="useMovie" id="useMovie">
                <option value="1" <c:out value="${jnitbbsinfoVO.useMovie == 1 ? 'selected' : ''}"/>>예</option>
                <option value="0" <c:out value="${jnitbbsinfoVO.useMovie == 0 ? 'selected' : ''}"/>>아니오</option>
                </select>
                &nbsp;<form:errors path="useMovie" />
                </td>
            </tr>
            <tr>
                <th width="30%"><font color="red">*</font> 관리자 레벨</th>
                <td>
                <form:input style="width:200px;"  value="${registerFlag == '등록' ? 'A,B,C' : ''}" path="admList" cssClass="txt"/>
                ( , 구분자로 사용하여 관리자 레벨을 다중등록 가능합니다.)
                &nbsp;<form:errors path="admList" />
                </td>
            </tr>
            <tr>
                <th width="30%"><font color="red">*</font> 권한설정</th>
                <td>
                
                <c:if test="${registerFlag == '수정'}">
                <c:set var="permListValue" value="${jnitbbsinfoVO.permList}"/>
                <c:set var="permViewValue" value="${jnitbbsinfoVO.permView}"/>
                <c:set var="permWriteValue" value="${jnitbbsinfoVO.permWrite}"/>
                <c:set var="permCmtValue" value="${jnitbbsinfoVO.permCmt}"/>
                <c:set var="anonPermListValue" value="${jnitbbsinfoVO.anonPermList}"/>
                <c:set var="anonPermViewValue" value="${jnitbbsinfoVO.anonPermView}"/>
                </c:if>
                
                <c:if test="${registerFlag == '등록'}">
                <c:set var="permListValue" value="Z"/>
                <c:set var="permViewValue" value="Z"/>
                <c:set var="permWriteValue" value="Z"/>
                <c:set var="permCmtValue" value="Z"/>
                <c:set var="anonPermListValue" value="1"/>
                <c:set var="anonPermViewValue" value="1"/>
                </c:if>
                
                <label>목록</label>
                <select name="permList" id="permList">
                <option value="A" <c:out value='${permListValue == "A" ? "selected" : "" }'/>>A</option>
                <option value="B" <c:out value='${permListValue == "B" ? "selected" : "" }'/>>B</option>
                <option value="C" <c:out value='${permListValue == "C" ? "selected" : "" }'/>>C</option>
                <option value="D" <c:out value='${permListValue == "D" ? "selected" : "" }'/>>D</option>
                <option value="E" <c:out value='${permListValue == "E" ? "selected" : "" }'/>>E</option>
                <option value="F" <c:out value='${permListValue == "F" ? "selected" : "" }'/>>F</option>
                <option value="G" <c:out value='${permListValue == "G" ? "selected" : "" }'/>>G</option>
                <option value="H" <c:out value='${permListValue == "H" ? "selected" : "" }'/>>H</option>
                <option value="I" <c:out value='${permListValue == "I" ? "selected" : "" }'/>>I</option>
                <option value="J" <c:out value='${permListValue == "J" ? "selected" : "" }'/>>J</option>
                <option value="K" <c:out value='${permListValue == "K" ? "selected" : "" }'/>>K</option>
                <option value="L" <c:out value='${permListValue == "L" ? "selected" : "" }'/>>L</option>
                <option value="M" <c:out value='${permListValue == "M" ? "selected" : "" }'/>>M</option>
                <option value="N" <c:out value='${permListValue == "N" ? "selected" : "" }'/>>N</option>
                <option value="O" <c:out value='${permListValue == "O" ? "selected" : "" }'/>>O</option>
                <option value="P" <c:out value='${permListValue == "P" ? "selected" : "" }'/>>P</option>
                <option value="Q" <c:out value='${permListValue == "Q" ? "selected" : "" }'/>>Q</option>
                <option value="R" <c:out value='${permListValue == "R" ? "selected" : "" }'/>>R</option>
                <option value="S" <c:out value='${permListValue == "S" ? "selected" : "" }'/>>S</option>
                <option value="T" <c:out value='${permListValue == "T" ? "selected" : "" }'/>>T</option>
                <option value="U" <c:out value='${permListValue == "U" ? "selected" : "" }'/>>U</option>
                <option value="V" <c:out value='${permListValue == "V" ? "selected" : "" }'/>>V</option>
                <option value="W" <c:out value='${permListValue == "W" ? "selected" : "" }'/>>W</option>
                <option value="X" <c:out value='${permListValue == "X" ? "selected" : "" }'/>>X</option>
                <option value="Y" <c:out value='${permListValue == "Y" ? "selected" : "" }'/>>Y</option>
                <option value="Z" <c:out value='${permListValue == "Z" ? "selected" : "" }'/>>Z</option>
                </select>레벨 이상 ,
                
                <label>보기</label>
                <select name="permView" id="permView">
                <option value="A" <c:out value='${permViewValue == "A" ? "selected" : "" }'/>>A</option>
                <option value="B" <c:out value='${permViewValue == "B" ? "selected" : "" }'/>>B</option>
                <option value="C" <c:out value='${permViewValue == "C" ? "selected" : "" }'/>>C</option>
                <option value="D" <c:out value='${permViewValue == "D" ? "selected" : "" }'/>>D</option>
                <option value="E" <c:out value='${permViewValue == "E" ? "selected" : "" }'/>>E</option>
                <option value="F" <c:out value='${permViewValue == "F" ? "selected" : "" }'/>>F</option>
                <option value="G" <c:out value='${permViewValue == "G" ? "selected" : "" }'/>>G</option>
                <option value="H" <c:out value='${permViewValue == "H" ? "selected" : "" }'/>>H</option>
                <option value="I" <c:out value='${permViewValue == "I" ? "selected" : "" }'/>>I</option>
                <option value="J" <c:out value='${permViewValue == "J" ? "selected" : "" }'/>>J</option>
                <option value="K" <c:out value='${permViewValue == "K" ? "selected" : "" }'/>>K</option>
                <option value="L" <c:out value='${permViewValue == "L" ? "selected" : "" }'/>>L</option>
                <option value="M" <c:out value='${permViewValue == "M" ? "selected" : "" }'/>>M</option>
                <option value="N" <c:out value='${permViewValue == "N" ? "selected" : "" }'/>>N</option>
                <option value="O" <c:out value='${permViewValue == "O" ? "selected" : "" }'/>>O</option>
                <option value="P" <c:out value='${permViewValue == "P" ? "selected" : "" }'/>>P</option>
                <option value="Q" <c:out value='${permViewValue == "Q" ? "selected" : "" }'/>>Q</option>
                <option value="R" <c:out value='${permViewValue == "R" ? "selected" : "" }'/>>R</option>
                <option value="S" <c:out value='${permViewValue == "S" ? "selected" : "" }'/>>S</option>
                <option value="T" <c:out value='${permViewValue == "T" ? "selected" : "" }'/>>T</option>
                <option value="U" <c:out value='${permViewValue == "U" ? "selected" : "" }'/>>U</option>
                <option value="V" <c:out value='${permViewValue == "V" ? "selected" : "" }'/>>V</option>
                <option value="W" <c:out value='${permViewValue == "W" ? "selected" : "" }'/>>W</option>
                <option value="X" <c:out value='${permViewValue == "X" ? "selected" : "" }'/>>X</option>
                <option value="Y" <c:out value='${permViewValue == "Y" ? "selected" : "" }'/>>Y</option>
                <option value="Z" <c:out value='${permViewValue == "Z" ? "selected" : "" }'/>>Z</option>
                </select>레벨 이상 ,
                
                <label>쓰기</label>
                <select name="permWrite" id="permWrite">
                <option value="A" <c:out value='${permWriteValue == "A" ? "selected" : "" }'/>>A</option>
                <option value="B" <c:out value='${permWriteValue == "B" ? "selected" : "" }'/>>B</option>
                <option value="C" <c:out value='${permWriteValue == "C" ? "selected" : "" }'/>>C</option>
                <option value="D" <c:out value='${permWriteValue == "D" ? "selected" : "" }'/>>D</option>
                <option value="E" <c:out value='${permWriteValue == "E" ? "selected" : "" }'/>>E</option>
                <option value="F" <c:out value='${permWriteValue == "F" ? "selected" : "" }'/>>F</option>
                <option value="G" <c:out value='${permWriteValue == "G" ? "selected" : "" }'/>>G</option>
                <option value="H" <c:out value='${permWriteValue == "H" ? "selected" : "" }'/>>H</option>
                <option value="I" <c:out value='${permWriteValue == "I" ? "selected" : "" }'/>>I</option>
                <option value="J" <c:out value='${permWriteValue == "J" ? "selected" : "" }'/>>J</option>
                <option value="K" <c:out value='${permWriteValue == "K" ? "selected" : "" }'/>>K</option>
                <option value="L" <c:out value='${permWriteValue == "L" ? "selected" : "" }'/>>L</option>
                <option value="M" <c:out value='${permWriteValue == "M" ? "selected" : "" }'/>>M</option>
                <option value="N" <c:out value='${permWriteValue == "N" ? "selected" : "" }'/>>N</option>
                <option value="O" <c:out value='${permWriteValue == "O" ? "selected" : "" }'/>>O</option>
                <option value="P" <c:out value='${permWriteValue == "P" ? "selected" : "" }'/>>P</option>
                <option value="Q" <c:out value='${permWriteValue == "Q" ? "selected" : "" }'/>>Q</option>
                <option value="R" <c:out value='${permWriteValue == "R" ? "selected" : "" }'/>>R</option>
                <option value="S" <c:out value='${permWriteValue == "S" ? "selected" : "" }'/>>S</option>
                <option value="T" <c:out value='${permWriteValue == "T" ? "selected" : "" }'/>>T</option>
                <option value="U" <c:out value='${permWriteValue == "U" ? "selected" : "" }'/>>U</option>
                <option value="V" <c:out value='${permWriteValue == "V" ? "selected" : "" }'/>>V</option>
                <option value="W" <c:out value='${permWriteValue == "W" ? "selected" : "" }'/>>W</option>
                <option value="X" <c:out value='${permWriteValue == "X" ? "selected" : "" }'/>>X</option>
                <option value="Y" <c:out value='${permWriteValue == "Y" ? "selected" : "" }'/>>Y</option>
                <option value="Z" <c:out value='${permWriteValue == "Z" ? "selected" : "" }'/>>Z</option>
                </select>레벨 이상 ,
                
                <label>댓글</label>
                <select name="permCmt" id="permCmt">
                <option value="A" <c:out value='${permCmtValue == "A" ? "selected" : "" }'/>>A</option>
                <option value="B" <c:out value='${permCmtValue == "B" ? "selected" : "" }'/>>B</option>
                <option value="C" <c:out value='${permCmtValue == "C" ? "selected" : "" }'/>>C</option>
                <option value="D" <c:out value='${permCmtValue == "D" ? "selected" : "" }'/>>D</option>
                <option value="E" <c:out value='${permCmtValue == "E" ? "selected" : "" }'/>>E</option>
                <option value="F" <c:out value='${permCmtValue == "F" ? "selected" : "" }'/>>F</option>
                <option value="G" <c:out value='${permCmtValue == "G" ? "selected" : "" }'/>>G</option>
                <option value="H" <c:out value='${permCmtValue == "H" ? "selected" : "" }'/>>H</option>
                <option value="I" <c:out value='${permCmtValue == "I" ? "selected" : "" }'/>>I</option>
                <option value="J" <c:out value='${permCmtValue == "J" ? "selected" : "" }'/>>J</option>
                <option value="K" <c:out value='${permCmtValue == "K" ? "selected" : "" }'/>>K</option>
                <option value="L" <c:out value='${permCmtValue == "L" ? "selected" : "" }'/>>L</option>
                <option value="M" <c:out value='${permCmtValue == "M" ? "selected" : "" }'/>>M</option>
                <option value="N" <c:out value='${permCmtValue == "N" ? "selected" : "" }'/>>N</option>
                <option value="O" <c:out value='${permCmtValue == "O" ? "selected" : "" }'/>>O</option>
                <option value="P" <c:out value='${permCmtValue == "P" ? "selected" : "" }'/>>P</option>
                <option value="Q" <c:out value='${permCmtValue == "Q" ? "selected" : "" }'/>>Q</option>
                <option value="R" <c:out value='${permCmtValue == "R" ? "selected" : "" }'/>>R</option>
                <option value="S" <c:out value='${permCmtValue == "S" ? "selected" : "" }'/>>S</option>
                <option value="T" <c:out value='${permCmtValue == "T" ? "selected" : "" }'/>>T</option>
                <option value="U" <c:out value='${permCmtValue == "U" ? "selected" : "" }'/>>U</option>
                <option value="V" <c:out value='${permCmtValue == "V" ? "selected" : "" }'/>>V</option>
                <option value="W" <c:out value='${permCmtValue == "W" ? "selected" : "" }'/>>W</option>
                <option value="X" <c:out value='${permCmtValue == "X" ? "selected" : "" }'/>>X</option>
                <option value="Y" <c:out value='${permCmtValue == "Y" ? "selected" : "" }'/>>Y</option>
                <option value="Z" <c:out value='${permCmtValue == "Z" ? "selected" : "" }'/>>Z</option>
                </select>레벨 이상
                </td>
            </tr>
            
            <tr>
                <th width="30%">비회원접근권한</th>
                <td>
                <label for="anonPermList">목록</label>
                <select name="anonPermList" id="anonPermList">
                <option value="1" <c:out value='${anonPermListValue == "1" ? "selected" : "" }'/>>예</option>
                <option value="0" <c:out value='${anonPermListValue == "0" ? "selected" : "" }'/>>아니오</option>
                </select>
                &nbsp;
                <label for="anonPermView">보기</label>
                <select name="anonPermView" id="anonPermView">
                <option value="1" <c:out value='${anonPermViewValue == "1" ? "selected" : "" }'/>>예</option>
                <option value="0" <c:out value='${anonPermViewValue == "0" ? "selected" : "" }'/>>아니오</option>
                </select>
                
                &nbsp;<form:errors path="anonPermList" />
                &nbsp;<form:errors path="anonPermView" />
                </td>
            </tr>
            
            <tr>
                <th width="30%">사용자 번호 1</th>
                <td>
                <form:input style="width:100px;"  value="${registerFlag == '등록' ? '0' : ''}" path="etcInt1" cssClass="txt"/>
                (지정된 글번호 이하 Writer필드는 *표 처리 표시됩니다.)
                &nbsp;<form:errors path="etcInt1" />
            	</td>
            </tr>
            <tr>
                <th width="30%"> 사용자 번호 2</th>
                <td>
                <form:input style="width:100px;"  value="${registerFlag == '등록' ? '0' : ''}" path="etcInt2" cssClass="txt"/>
                &nbsp;<form:errors path="etcInt2" />
                </td>
            </tr>
            <tr>
                <th width="30%">사용자 문자 1</th>
                <td>
                <form:input style="width:200px;"  value="${registerFlag == '등록' ? '' : ''}" path="etcStr1" cssClass="txt"/>
                &nbsp;<form:errors path="etcStr1" />
                </td>
            </tr>
            <tr>
                <th width="30%">사용자 문자2</th>
                <td>
                <form:input style="width:200px;"  value="${registerFlag == '등록' ? '' : ''}" path="etcStr2" cssClass="txt"/>
                &nbsp;<form:errors path="etcStr2" />
                </td>
            </tr>
        </tbody>
    </table>
<!--콘텐츠끝-->
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>