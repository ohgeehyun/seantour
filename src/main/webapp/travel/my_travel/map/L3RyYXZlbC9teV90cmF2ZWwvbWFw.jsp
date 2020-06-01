<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000126_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><div class="map_wrap_area">
			<div id="map_wrap">
				
			</div>
			<div id="content">
				<div class="day_info">
					<div class="day_tit"><span>1</span>DAY</div>
					<ul class="day_util">
						<li><a href="#none" class="day_memo">메모</a>
							<div class="memo_box">
								<p class="tit">나의 메모</p>
								<div class="txt_memo">
									<textarea cols="30" rows="5">메모입력란입니다.</textarea>
									
								</div>
								<div class="memo_btn">
									<a href="#none" class="close">취소</a>
									<a href="#none" class="add">등록</a>
								</div>
							</div>
						</li>
						<li><a href="#none" class="day_delect">삭제</a></li>
						<li><a href="#none" class="day_reset">초기화</a></li>
					</ul>
				</div>
				<div  id="day_lst" class="day_lst">
					<ul>
						<li>
							<a href="#none" class="tabh">D-1</a>
							<div class="tab_con">
								<div class="start">
									<input type="text" class="start_word" placeholder="출발지를 입력하세요" />
								</div>
								<ul class="tab_list" id="example3Left"  class="list-group col">
									<li class="list-group-item">1
									</li>
								</ul>
								<div class="arrival">
									<input type="text" class="srrival_word" placeholder="도착지를 입력하세요" />
								</div>
							</div>
						</li>
						<li>
							<a href="#none" class="tabh">D-2</a>
							<div class="tab_con">
								<div class="start">
									<input type="text" class="start_word" placeholder="출발지를 입력하세요" />
								</div>
								<ul class="tab_list" id="example3Left2"  class="list-group col">
									<li class="list-group-item">2
									</li>
								</ul>
								<div class="arrival">
									<input type="text" class="srrival_word" placeholder="도착지를 입력하세요" />
								</div>
							</div>
						</li>
						<li>
							<a href="#none" class="tabh">D-3</a>
							<div class="tab_con">
								<div class="start">
									<input type="text" class="start_word" placeholder="출발지를 입력하세요" />
								</div>
								<ul class="tab_list" id="example3Left3"  class="list-group col">
									<li class="list-group-item">3
									</li>
								</ul>
								<div class="arrival">
									<input type="text" class="srrival_word" placeholder="도착지를 입력하세요" />
								</div>
							</div>
						</li>
						<li>
							<a href="#none" class="tabh">D-4</a>
							<div class="tab_con">
								<div class="start">
									<input type="text" class="start_word" placeholder="출발지를 입력하세요" />
								</div>
								<ul class="tab_list" id="example3Left4"  class="list-group col">
									<li class="list-group-item">4
									</li>
								</ul>
								<div class="arrival">
									<input type="text" class="srrival_word" placeholder="도착지를 입력하세요" />
								</div>
							</div>
						</li>
						<li>
							<a href="#none" class="tabh">D-5</a>
							<div class="tab_con">
								<div class="start">
									<input type="text" class="start_word" placeholder="출발지를 입력하세요" />
								</div>
								<ul class="tab_list" id="example3Left5"  class="list-group col">
									<li class="list-group-item">5
									</li>
								</ul>
								<div class="arrival">
									<input type="text" class="srrival_word" placeholder="도착지를 입력하세요" />
								</div>
							</div>
						</li>
						<li>
							<a href="#none" class="tabh">D-6</a>
							<div class="tab_con">
								<div class="start">
									<input type="text" class="start_word" placeholder="출발지를 입력하세요" />
								</div>
								<ul class="tab_list" id="example3Left6"  class="list-group col">
									<li class="list-group-item">6
									</li>
								</ul>
								<div class="arrival">
									<input type="text" class="srrival_word" placeholder="도착지를 입력하세요" />
								</div>
							</div>
						</li>
						<li>
							<a href="#none" class="tabh">D-7</a>
							<div class="tab_con">
								<div class="start">
									<input type="text" class="start_word" placeholder="출발지를 입력하세요" />
								</div>
								<ul class="tab_list" id="example3Left7"  class="list-group col">
									<li class="list-group-item">7
									</li>
								</ul>
								<div class="arrival">
									<input type="text" class="srrival_word" placeholder="도착지를 입력하세요" />
								</div>
							</div>
						</li>
					</ul>
					<a href="#none" class="plus">DAY</a>
					<a href="#none" class="heart">MY</a>
					<a href="#none" class="save">SAVE</a>
				</div><!-- //day_lst -->
				<div class="tour_schedule_detail open">
					<div class="schedule_tbox">
						<div><input type="text" class="sc_tit" placeholder="나만의 여행일정 제목을 입력하세요." /></div>
						<div>
							<select class="sc_local">
								<option value="">부산광역시</option>
								<option value="">대구광역시</option>
								<option value="">인천광역시</option>
								<option value="">대전광역시</option>
								<option value="">울산광역시</option>
								<option value="">경기도</option>
								<option value="">강원도</option>
								<option value="">충청북도</option>
								<option value="">충청남도</option>
								<option value="">전라북도</option>
								<option value="">전라남도</option>
								<option value="">경상북도</option>
								<option value="">경상남도</option>
								<option value="">제주특별자치도</option>
							</select>
						</div>
						<div class="btn_area"><a href="#none">일정상세보기</a></div>
					</div>
					<div class="schedule_content">
						<div class="tab_mn">
							<ul>
								<li><a href="#none">관광</a>
									<div class="cssSelect">
										<button type="button">태그선택</button>
										<ul class="lst">
											<li><a href="#none"><input type="checkbox" class="check" />전체 선택</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />공원</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />낚시터</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />등대</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />문화유적</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />섬</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />어시장</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />어촌체험마을</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />영화/드라마 촬영지</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />유람선</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />일출/낙조경관도로</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />전망대/조망시설</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />전시관</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />캠핑장</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />항구</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />해수욕장</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />해안 자전거길</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />해양레포츠</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />해양산책로</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />기타관광지</a></li>
										</ul>
									</div>
								</li>
								<li><a href="#none">숙박</a>
									<div class="cssSelect">
										<button type="button">태그선택</button>
										<ul class="lst">
											<li><a href="#none"><input type="checkbox" class="check" />전체 선택</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />게스트하우스</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />리조트/콘도</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />민박</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />여관/모텔</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />캠핑장</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />펜션</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />호텔</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />기타</a></li>
										</ul>
									</div>
								</li>
								<li><a href="#none">레져</a>
									<div class="cssSelect">
										<button type="button">태그선택</button>
										<ul class="lst">
											<li><a href="#none"><input type="checkbox" class="check" />전체 선택</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />체험프로그램</a></li>
										</ul>
									</div>
								</li>
								<li><a href="#none">식당</a>
									<div class="cssSelect">
										<button type="button">태그선택</button>
										<ul class="lst">
											<li><a href="#none"><input type="checkbox" class="check" />전체 선택</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />양식</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />일식</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />중식</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />한식</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />횟집</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />기타</a></li>
										</ul>
									</div>
								</li>
								<li><a href="#none">쇼핑</a>
									<div class="cssSelect">
										<button type="button">태그선택</button>
										<ul class="lst">
											<li><a href="#none"><input type="checkbox" class="check" />전체 선택</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />가공</a></li>
											<li><a href="#none"><input type="checkbox" class="check" />신선제품</a></li>
										</ul>
									</div>
								</li>
							</ul>
						</div>
						
						<ul class="result_list" id="example3Right" class="list-group col">
							<li>
								<div class="img"><img src="./images/map/img_sc01.jpg" alt="" /></div>
								<div class="txt_box">
									<p class="txt">[공수마을]오링대공원</p>
									<p class="sub">공원</p>
									<a href="#none" class="more">더보기</a>
								</div>
								<div class="icon_box">
									<a href="#none" class="ico_heart">종아요</a>
									<a href="#none" class="ico_add">추가</a>
									<a href="#none" class="ico_close">닫기</a>
								</div>
							</li>
							<li>
								<div class="img"><img src="./images/map/img_sc02.jpg" alt="" /></div>
								<div class="txt_box">
									<p class="txt">거제 맹중족 테마 공원</p>
									<p class="sub">공원</p>
									<a href="#none" class="more">더보기</a>
								</div>
								<div class="icon_box">
									<a href="#none" class="ico_heart on">종아요</a>
									<a href="#none" class="ico_add">추가</a>
									<a href="#none" class="ico_close">닫기</a>
								</div>
							</li>
							<li>
								<div class="img"><img src="./images/map/img_sc03.jpg" alt="" /></div>
								<div class="txt_box">
									<p class="txt">죽성성당(드라 촬영지)</p>
									<p class="sub">레져</p>
									<a href="#none" class="more">더보기</a>
								</div>
								<div class="icon_box">
									<a href="#none" class="ico_heart on">종아요</a>
									<a href="#none" class="ico_add">추가</a>
									<a href="#none" class="ico_close">닫기</a>
								</div>
							</li>
							<li>
								<div class="img"><img src="./images/map/img_sc04.jpg" alt="" /></div>
								<div class="txt_box">
									<p class="txt">달맞이고개(달맞이마을)</p>
									<p class="sub">공원</p>
									<a href="#none" class="more">더보기</a>
								</div>
								<div class="icon_box">
									<a href="#none" class="ico_heart">종아요</a>
									<a href="#none" class="ico_add">추가</a>
									<a href="#none" class="ico_close">닫기</a>
								</div>
							</li>
						</ul>
					</div>
				</div><!-- // tour_list_wrap -->
				<!--클릭시 DB에서 실시간으로 가져와서 아래 내용을 업그래이드 할것-->
				<div class="detail_info_area">
					<div class="tit_box">
						<p>상세정보</p>
						<a href="#none" class="close">닫기</a>
					</div>
					<div class="bx_box">
						<p class="bx_tit">거제 맹중족 테마 공원</p>
						<div class="detailzone">
							<ul class="lst">
								<li><img src="./images/map/img_detail01.jpg" alt="" /></li>
								<li><img src="./images/map/img_detail01.jpg" alt="" /></li>
								<li><img src="./images/map/img_detail01.jpg" alt="" /></li>
							</ul>
						</div>
					</div>
					<div class="info_lst">
						<ul>
							<li>전화번호 : 051-607-6361</li>
							<li>주소 : 부산광역시 남구 용호동 5 - 4 이기대 </li>
							<li>명칭 : [공수마을]이기대전망대</li>
						</ul>
					</div>
					<div class="detail_txt">
						광안리와 광안대교, 해운대, 달맞이 고개
						까지 한눈에 보이고 일출시간에는 해안절경과
						마린시티에 비친 햇빛이 그림 같은 풍경을
						그려낸다는 설
					</div>
				</div><!-- // detail_info_area -->
			</div>
			<!-- // cotent -->
			<div id="mob_content">
				<div class="line_arrow"><img src="./images/map/icon_line_arr.gif" alt="" /></div>
				<dl class="day_sc">
					<dt class="day_title"><a href="#none">1DAY</a></dt>
					<dd class="day_area first">
						<ul class="day_list">
							<li>
								<span class="num">1</span>
								<div class="day_box">
									<a href="#none" class="tbox">
										<span class="sub">공원</span>
										<span class="txt">[공수마을]오링대공원</span>
									</a>
									<a href="#none" class="delect">삭제</a>
								</div>
							</li>
							<li>
								<span class="num">2</span>
								<div class="day_box">
									<a href="#none" class="tbox">
										<span class="sub">레져</span>
										<span class="txt">죽성성당(드라마촬영지)</span>
									</a>
									<a href="#none" class="delect">삭제</a>
								</div>
							</li>
						</ul>	
						<div class="add_btn_area">
							<a href="./map_detail.html" class="local"><span>장소추가</span></a>
							<a href="#none" class="mob_day_memo"><span>메모추가</span></a>
							<div class="mob_memo_box">
								<p class="tit">나의 메모</p>
								<div class="txt_memo">
									<textarea cols="30" rows="5">메모입력란입니다.</textarea>
									
								</div>
								<div class="memo_btn">
									<a href="#none" class="close">취소</a>
									<a href="#none" class="add">등록</a>
								</div>
							</div>
						</div>					
					</dd>
				</dl>
				<dl class="day_sc">
					<dt class="day_title"><a href="#none">2DAY</a></dt>
					<dd class="day_area">
						<ul class="day_list">
							<li>
								<span class="num">1</span>
								<div class="day_box">
									<a href="#none" class="tbox">
										<span class="sub">공원</span>
										<span class="txt">[공수마을]오링대공원</span>
									</a>
									<a href="#none" class="delect">삭제</a>
								</div>
							</li>
							<li>
								<span class="num">2</span>
								<div class="day_box">
									<a href="#none" class="tbox">
										<span class="sub">레져</span>
										<span class="txt">죽성성당(드라마촬영지)</span>
									</a>
									<a href="#none" class="delect">삭제</a>
								</div>
							</li>
						</ul>	
						<div class="add_btn_area">
							<a href="./map_detail.html" class="local"><span>장소추가</span></a>
							<a href="#none" class="mob_day_memo" data-modal="#modal"><span>메모추가</span></a>
							<div class="mob_memo_box" id="modal" class="modal modal__bg" role="dialog" aria-hidden="true">
								<p class="tit">나의 메모</p>
								<div class="txt_memo">
									<textarea cols="30" rows="5">메모입력란입니다.</textarea>
									
								</div>
								<div class="memo_btn">
									<a href="#none" class="close">취소</a>
									<a href="#none" class="add">등록</a>
								</div>
							</div>
						</div>					
					</dd>
				</dl>
				<div class="day_add"><a href="#none" class="btn_add"><span>DAY 추가</span></a></div>
				<div class="day_save"><a href="#none" class="btn_save"><span>저장</span></a></div>
			</div><!-- // mob_content -->
			<div id="mob_content2">
				<ul class="day_list">
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">공원</span>
								<span class="txt">[공수마을]오링대공원</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">레져</span>
								<span class="txt">죽성성당(드라마촬영지)</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">레져</span>
								<span class="txt">죽성성당(드라마촬영지)</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">레져</span>
								<span class="txt">죽성성당(드라마촬영지)</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">레져</span>
								<span class="txt">죽성성당(드라마촬영지)</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">레져</span>
								<span class="txt">죽성성당(드라마촬영지)</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">레져</span>
								<span class="txt">죽성성당(드라마촬영지)</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
				</ul>	
				<div style="margin:20px 0;" class="day_save tac"><a href="#none" class="button"><span>등록</span></a></div>
			</div>
		</div>

	<!-- // wrap --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000126_E.jsp' %>