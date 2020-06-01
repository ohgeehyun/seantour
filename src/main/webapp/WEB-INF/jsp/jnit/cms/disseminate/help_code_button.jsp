
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
<!--
function code_insert(id){
	var cm = $('.CodeMirror')[0].CodeMirror;
    var doc = cm.getDoc();
    var cursor = doc.getCursor(); // gets the line number in the cursor position
    var line = doc.getLine(cursor.line); // get the line contents
    var pos = { // create a new object to avoid mutation of the original selection
        line: cursor.line,
        ch: line.length  // set the character position to the end of the line
    }
    doc.replaceRange('\n'+$("#"+id).val()+'\n', pos); // adds a new line
}
function code_toggle(){
	if($(".codeBtnList").is(":visible")){
		$("#codeToggleBtn").text("임포트 코드 리스트 열기");
		$("#codeBtnList").hide()
	}else{
		$("#codeToggleBtn").text("임포트 코드 리스트 닫기");
		$("#codeBtnList").show();
	}
}
$(document).ready(function(){
	
});
//-->
</script>
<!-- 
<a href="javascript:;" id="codeToggleBtn" onclick="javascript:code_toggle(); return false;" class="btn btn-small">임포트 코드 리스트 열기</a>
<br />
 -->

<div id="codeBtnList" class="codeBtnList" >
	<a href="javascript:;" onclick="javascript:code_insert('latestBoardImportCode'); return false;" class="btn btn-small"><i class="icon-list" style="vertical-align: text-bottom;"></i> 최근 게시물</a>
	
	<a href="javascript:;" onclick="javascript:code_insert('boardImportCode'); return false;" class="btn btn-small"><i class="icon-list-alt" style="vertical-align: text-bottom;"></i> 게시판</a>
	
	<a href="javascript:;" onclick="javascript:code_insert('totalSearchImportCode'); return false;" class="btn btn-small"><i class="icon-search" style="vertical-align: text-bottom;"></i> 통합검색</a>
	
	<a href="javascript:;" onclick="javascript:code_insert('topmenuImportCode'); return false;" class="btn btn-small"><i class="icon-th" style="vertical-align: text-bottom;"></i> 탑메뉴</a>
	
</div>

<div id="helpCodeList" style="display:none;">
		<textarea id="latestBoardImportCode">
		&lt;%--
			최근 게시판 code 
			board_id : 게시판 아이디, 
			count : 가져올 게시물수, 
			type : 출력될 유형
			base_path : 콘텐츠 경로(ex:/home/board/page/) 
		--%&gt;
		&lt;!-- 최근 게시판 코드 시작 --&gt;
		&lt;jsp:include page="/${ctxRoot}/board/latest.do"> 
			&lt;jsp:param name="board_id" value=""/>
			&lt;jsp:param name="count" value="7"/>
			&lt;jsp:param name="type" value="main"/>
			&lt;jsp:param name="base_path" value="콘텐츠경로를 입력해주시기 바랍니다."/>
		&lt;/jsp:include>
		&lt;!-- 최근 게시판 코드 끝 --&gt;
		</textarea>
		<textarea id="boardImportCode">
			&lt;%-- 
				게시판 code
				board_id : 게시판 아이디
				useSkeleton : true로 입력하면 게시판의 html 뼈대 없이 가져옵니다.
				customSkin : 게시판 설정을 무시하고 스킨 설정
			--%&gt;
			&lt;!-- 게시판 코드 시작 --&gt;
			&lt;jsp:include page="/${ctxRoot}/board/board.do">
				&lt;jsp:param name="boardId" value=""/>
				&lt;jsp:param name="fixedCategory" value=""/>
				&lt;jsp:param name="useSkeleton" value="true"/>
				&lt;jsp:param name="customSkin" value=""/>
				&lt;jsp:param name=&quot;isMobile&quot; value=&quot;false&quot;/&gt;
			&lt;/jsp:include>
			&lt;!-- 게시판 코드 끝 --&gt;
		</textarea>
		<textarea id="researchImportCode">
			&lt;%--
			searchCondition = "" : 전체 설문조사 리스트
			searchCondition = 2 : 진행중인 설문조사 리스트
			searchCondition = 3 : 종료된 설문조사 리스트
			category = 카테고리ID 입력시 해당 카테로리로 구분된 리스트 출력
			--%&gt;
			&lt;!-- 설문조사 코드 시작 --&gt;
			&lt;jsp:include page="/research/ImportResearch.do"&gt;
			&lt;jsp:param name="searchCondition" value="" /&gt;
			&lt;jsp:param name="category" value="CATEGORY_0001" /&gt;
			&lt;/jsp:include&gt;
			&lt;!-- 설문조사 코드 끝 --&gt;
		</textarea>
		<textarea id="totalSearchImportCode">
		&lt;!-- 통합검색 코드 시작 --&gt;
			&lt;c:import url='/total/search.do'&gt
				&lt;c:param name='uri' value='&#36;{fn:replace(pageContext.request.requestURI,pageContext.request.contextPath,"") }'&gt
				&lt;/c:param&gt
				&lt;c:param name='contentPath' value='현재 콘텐츠 경로/'&gt&lt;/c:param&gt
			&lt;/c:import&gt
		
			&lt;!-- header search_box --&gt
			&lt;script type="text/javascript"&gt
				&lt;!--
		                   
				function main_search(){				
					var search1 = $("#search_box").val();								
					var searchUrl = encodeURI("통합검색이 적용된 페이지 경로?searchKeyword="+search1);
					document.getElementById("searchform").action=searchUrl;
					document.getElementById("searchform").submit();
				}
				$(document).ready(function(){
					$("#search_key").click(function(e){
						e.preventDefault();					
						var search = $("#search_box").val();					
						var searchUrl = encodeURI("통합검색이 적용된 페이지 경로?searchKeyword="+search);
						document.getElementById("searchform").action=searchUrl;
						document.getElementById("searchform").submit();
					});				
				});	
				//--&gt
			&lt;/script&gt;
			&lt;form name="searchform" id="searchform" action="" method="post"&gt;
				&lt;div class="search_wrap m_hidden search_form"&gt;
					&lt;input type="text" name="search_box" title="검색박스" id="search_box" class="search_input01" placeholder="검색어를 입력하세요" onkeydown="if(event.keyCode == 13) main_search();" value="" /&gt;
					&lt;a href="#" id="search_key" class="search_btn"&gt;&lt;i class="icon-search"&gt;&lt;/i&gt;&lt;span class="comment"&gt;검색&lt;/span&gt&lt;/a&gt;
				&lt;/div&gt
		    &lt;/form&gt
			&lt;!-- //search_box --&gt
			&lt;!-- 통합검색 코드 끝 --&gt;
		</textarea>
		<textarea id="topmenuImportCode">
		&lt;!-- 탑메뉴 코드 시작 --&gt;
			&lt;c:import url="/menu/getTopMenu.do"&gt;
				&lt;c:param name="target" value="[탑메뉴 target명]" /&gt;
				&lt;c:param name="menuNm" value="[메뉴명]" /&gt;
				&lt;c:param name="depth" value="[뎁스]" /&gt;
				&lt;c:param name="order" value="[class순서 ex:0]" /&gt;
				&lt;c:param name="menuId" value="[메뉴아이디,메뉴명이 겹칠경우 사용]" /&gt;
			&lt;/c:import&gt;
		&lt;!-- 탑메뉴 코드 끝 --&gt;	
		</textarea>
		<textarea id="sitemapImportCode">
			&lt;!-- 사이트맵 코드 시작 --&gt;	
			&lt;c:import url='/menu/getSiteMap.do'&gt;
				&lt;c:param name='siteNm' value='${fn:replace(pageContext.request.requestURI,pageContext.request.contextPath,"") }'&gt;
				&lt;/c:param&gt;
				&lt;c:param name='titles' value='대메뉴(1뎁스) 메뉴명을 콤마(,)로 구분하여 입력 해주시기 바랍니다.'>&lt;/c:param&gt;
			&lt;/c:import&gt;
			&lt;!-- 사이트맵 코드 끝 --&gt;
		</textarea>
		<textarea id="myinfoImportCode">
			&lt;!-- 마이페이지 코드 시작 --&gt;
			&lt;c:import url="/disseminate/workspace.do"&gt;
				&lt;c:param name="contentPath" value="콘텐츠 경로명" /&gt;
			&lt;/c:import&gt;
			&lt;!-- 마이페이지 코드 끝 --&gt;	
		</textarea>
	</div>