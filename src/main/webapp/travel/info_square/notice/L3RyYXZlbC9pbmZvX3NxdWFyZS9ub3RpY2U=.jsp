<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000127_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><!-- contaniner -->
		<div id="container" >
            <div class="section_visual sub01 trans400">
                <div class="section_tit_box">
		            <h2 class="tit trans300">추천여행일정</h2>
		            <p class="txt trans300">틀별하고 즐거움이 가득한 국내 바다여행 여행지 추천</p>
        		</div>
            </div><!-- // section_visual -->
             <div class="section_lnb">
             	<div class="inr">
			        <ul id="lnb">
			        	<li><a href="#none"><span class="sprh_com">HOME</span></a></li>
			        	<li id="firstmenu"><!--<a href="/www/main"><span class="unfd sprh_com">홈</span></a>-->
			                <a href="#none">추천여행일정<span class="unfd">같은 레벨 메뉴 보기</span></a>
			                <div>
			                    <ul>
									<li><a href="#none">1차메뉴</a></li>
									<li><a href="#none">1차메뉴</a></li>
									<li><a href="#none">1차메뉴</a></li>
									<li><a href="#none">1차메뉴</a></li>
			                	</ul>
			                </div>  
			            </li>
			            <li id="secondmenu">
			                <a href="#none">작가 추전일정<span class="unfd sprh_com">같은 레벨 메뉴 보기</span></a>
			                <div class="snb_wrap">
			                   <ul class="snb">
									<li><a href="#none">작가 추전일정</a></li>
									<li><a href="#none">2차메뉴</a></li>
									<li><a href="#none">2차메뉴</a></li>
									<li><a href="#none">2차메뉴</a></li>
									<li><a href="#none">2차메뉴</a></li>
			                	</ul> 
			                </div>
			            </li>                       
			         </ul>
		         </div>
    		</div><!-- // section_lnb -->


         <div id="content" class="cont_wrap">
            <!--<div class="cont_head">
                <h2 class="title">센터현황</h2>
            </div><!-- cont_head -->
            <div class="cont_body">
	            <div class="inr">
					<div class="search_box">
						<fieldset>
							<legend>검색</legend>
							<select name="key" id="key" class="select" title="검색조건선택">
								<option value="">제목</option>
								<option value="">내용</option>
								<option value=""></option>
							</select> 
				
							<!--<script type="text/javascript">
							$("select[name='key'] option[value='']").prop("selected", true);				
							</script>-->
				
							<input name="keyword" type="text" class="word" value="" maxlength="35" placeholder="검색어를 입력하세요" /> 
							<input class="button black" type="submit" value="검색" />
						</fieldset>
					</div>

	            	<div class="board_list">
						<table class="tac">
							<caption>게시판으로 제목, 글쓴이, 날짜, 조회수에 대한 정보를 표시합니다.</caption>
							<colgroup>
								<col width="10%" data-table-type="brd_number" />
								<col width="" data-table-type="brd_subject" />
								<col width="10%" data-table-type="brd_file_count" />
								<col width="15%" data-table-type="brd_w_date" />
								<col width="10%" data-table-type="brd_views_count" />
							</colgroup>
							<thead>
								<tr>
									<th data-table-type="brd_number" >번호</th>
									<th data-table-type="brd_subject" >제목</th>
									<th data-table-type="brd_file_count" >첨부</th>
									<th data-table-type="brd_w_date" >등록일</th>
									<th data-table-type="brd_views_count" >조회수</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td data-table-type="brd_number">10</td>
									<td data-table-type="brd_subject" class="tal"><a href="./bbs_view.html">홈페이지를 오픈하였습니다.</a></td>
									<td data-table-type="brd_file_count"><span class="valm"><img src="./images/board/ico_file.png" alt="파일" /></span></td>
									<td data-table-type="brd_w_date">2019.05.01</td>
									<td data-table-type="brd_views_count">5</td>
								</tr>
								<tr>
									<td data-table-type="brd_number">9</td>
									<td data-table-type="brd_subject" class="tal"><a href="#none">홈페이지를 오픈하였습니다.</a></td>
									<td data-table-type="brd_file_count"><span class="valm"><img src="./images/board/ico_file.png" alt="파일" /></span></td>
									<td data-table-type="brd_w_date">2019.05.01</td>
									<td data-table-type="brd_views_count">5</td>
								</tr>
								<tr>
									<td data-table-type="brd_number">8</td>
									<td data-table-type="brd_subject" class="tal"><a href="#none">홈페이지를 오픈하였습니다.</a></td>
									<td data-table-type="brd_file_count"><span class="valm"><img src="./images/board/ico_file.png" alt="파일" /></span></td>
									<td data-table-type="brd_w_date">2019.05.01</td>
									<td data-table-type="brd_views_count">5</td>
								</tr>
								<tr>
									<td data-table-type="brd_number">7</td>
									<td data-table-type="brd_subject" class="tal"><a href="#none">홈페이지를 오픈하였습니다.</a></td>
									<td data-table-type="brd_file_count"><span class="valm"><img src="./images/board/ico_file.png" alt="파일" /></span></td>
									<td data-table-type="brd_w_date">2019.05.01</td>
									<td data-table-type="brd_views_count">5</td>
								</tr>
								<tr>
									<td data-table-type="brd_number">6</td>
									<td data-table-type="brd_subject" class="tal"><a href="#none">홈페이지를 오픈하였습니다.</a></td>
									<td data-table-type="brd_file_count"><span class="valm"><img src="./images/board/ico_file.png" alt="파일" /></span></td>
									<td data-table-type="brd_w_date">2019.05.01</td>
									<td data-table-type="brd_views_count">5</td>
								</tr>
								<tr>
									<td data-table-type="brd_number">5</td>
									<td data-table-type="brd_subject" class="tal"><a href="#none">홈페이지를 오픈하였습니다.</a></td>
									<td data-table-type="brd_file_count"><span class="valm"><img src="./images/board/ico_file.png" alt="파일" /></span></td>
									<td data-table-type="brd_w_date">2019.05.01</td>
									<td data-table-type="brd_views_count">5</td>
								</tr>
								<tr>
									<td data-table-type="brd_number">4</td>
									<td data-table-type="brd_subject" class="tal"><a href="#none">홈페이지를 오픈하였습니다.</a></td>
									<td data-table-type="brd_file_count"><span class="valm"><img src="./images/board/ico_file.png" alt="파일" /></span></td>
									<td data-table-type="brd_w_date">2019.05.01</td>
									<td data-table-type="brd_views_count">5</td>
								</tr>
								<tr>
									<td data-table-type="brd_number">3</td>
									<td data-table-type="brd_subject" class="tal"><a href="#none">홈페이지를 오푼하였습니다.</a></td>
									<td data-table-type="brd_file_count"><span class="valm"><img src="./images/board/ico_file.png" alt="파일" /></span></td>
									<td data-table-type="brd_w_date">2019.05.01</td>
									<td data-table-type="brd_views_count">5</td>
								</tr>
								<tr>
									<td data-table-type="brd_number">2</td>
									<td data-table-type="brd_subject" class="tal"><a href="#none">홈페이지를 오푼하였습니다.</a></td>
									<td data-table-type="brd_file_count"><span class="valm"><img src="./images/board/ico_file.png" alt="파일" /></span></td>
									<td data-table-type="brd_w_date">2019.05.01</td>
									<td data-table-type="brd_views_count">5</td>
								</tr>
								<tr>
									<td data-table-type="brd_number">1</td>
									<td data-table-type="brd_subject" class="tal"><a href="#none">홈페이지를 오푼하였습니다.</a></td>
									<td data-table-type="brd_file_count"><span class="valm"><img src="./images/board/ico_file.png" alt="파일" /></span></td>
									<td data-table-type="brd_w_date">2019.05.01</td>
									<td data-table-type="brd_views_count">5</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- pagination -->
            		<ul class="paging">
            			<li class="first"><a href="#none"></a></li>
            			<li class="prev"><a href="#none"></a></li>
            			<li><a href="#none">1</a></li>
            			<li><a href="#none">2</a></li>
            			<li><a href="#none">3</a></li>
            			<li><a href="#none">4</a></li>
            			<li><a href="#none">5</a></li>
            			<li class="next"><a href="#none"></a></li>
            			<li class="last"><a href="#none"></a></li>
            		</ul>
            		<!-- //pagination --> 
    		       </div>   
				</div><!-- cont_body -->
        	</div><!-- // cont_wrap -->
        </div>
        <!--// container --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000127_E.jsp' %>