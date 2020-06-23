<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
	<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
</head>
<body>
	<div id="wrap">
		<div id="accessibility"><a href="#content">본문 바로가기</a></div>
		<!-- header -->
			<%@ include file="/WEB-INF/jsp/travel/tpl/gnb.jsp" %>
		<!-- // header -->

		<!-- contaniner -->
		<div id="container" >

			<%@ include file="/WEB-INF/jsp/travel/tpl/navigation.jsp" %>

        	<div id="content" class="cont_wrap">

			 <div class="cont_head">
                <h2 class="title">해수욕장 예약시스템</h2>
            </div><!--// cont_head -->
            <div class="cont_body">
	            <div class="inr">
	            	<!-- 검색 -->
					<div class="bx_srch_event">
						<fieldset>
						<legend>검색</legend>
						<div class="field01">
							<select id="" name="" title="지역">
					      		<option value="">전라남도</option>
				      		</select>	
				      		<select id="" name="" title="해수용장">
				    	  		<option value="">해수욕장 선택</option>
					      		<option value="">외달도해수욕장</option>
					      		<option value="">웅천해수욕장</option>
					      		<option value="">풍류해수욕장</option>
					      		<option value="">율포솔밭해수욕장</option>
					      		<option value="">수문해수욕장</option>
					      		<option value="">송호해수욕장</option>
					      		<option value="">돌머리해수욕장</option>
					      		<option value="">가마미해수욕장</option>
					      		<option value="">송이도해수욕장</option>
					      		<option value="">신지명사십리해수욕장</option>
					      		<option value="">금갑해수욕장</option>
					      		<option value="">대광해수욕장</option>
					      		<option value="">백길해수욕장</option>
					      		<option value="">짱뚱어해수욕장</option>
				      		</select>
			      		</div>
			      		<div class="field02">
				      		<select id="" name="" title="월">
				    	  		<option value="">월선택</option>
					      		<option value="">7월</option>
					      		<option value="">8월</option>
					      		<option value="">9월</option>
				      		</select>
				      		<select id="" name="" title="일">
				    	  		<option value="">일선택</option>
				    	  		<option value="">1일</option>
					      		<option value="">2일</option>
					      		<option value="">3일</option>
					      		<option value="">4일</option>
					      		<option value="">5일</option>
					      		<option value="">5일</option>
					      		<option value="">6일</option>
					      		<option value="">7일</option>
					      		<option value="">8일</option>
					      		<option value="">9일</option>
					      		<option value="">10일</option>
					      		<option value="">11일</option>
					      		<option value="">12일</option>
					      		<option value="">13일</option>
					      		<option value="">14일</option>
					      		<option value="">15일</option>
					      		<option value="">16일</option>
					      		<option value="">17일</option>
					      		<option value="">18일</option>
					      		<option value="">19일</option>
					      		<option value="">20일</option>
					      		<option value="">21일</option>
					      		<option value="">22일</option>
					      		<option value="">23일</option>
					      		<option value="">24일</option>
					      		<option value="">25일</option>
					      		<option value="">26일</option>
					      		<option value="">27일</option>
					      		<option value="">28일</option>
					      		<option value="">29일</option>
					      		<option value="">30일</option>
					      		<option value="">31일</option>
				      		</select>
				      		<select id="" name="" title="시간">
				    	  		<option value="">시간선택</option>
				    	  		<option value="">09:00~10:00</option>
					      		<option value="">10:00~12:00</option>
					      		<option value="">12:00~14:00</option>
					      		<option value="">14:00~16:00</option>
					      		<option value="">16:00~18:00</option>
				      		</select>
						</div>
						<div class="btn">
							<a href="#none">검색</a>
						</div>
						</fieldset>
					</div>
					<!-- 검색 -->
					<div class="reserv_wrap">
	            		<dl class="form_group">
	            			<dt>해수욕장</dt>
	            			<dd><div class="reserv_view"><span class="loc">전남</span>/<span class="pool">외달도해수욕장</span></div>
	            				<p class="note">선택하신 해수욕장이름과 지역을 꼭 확인해주세요</p>
	            			</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>날짜</dt>
	            			<dd><input type="text" id="" name="" /></dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>시간</dt>
	            			<dd><div class="reserv_view">10:00~12:00</div></dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>인원</dt>
	            			<dd>
	            				<select>
	            					<option value="">1</option>
	            					<option value="">2</option>
	            					<option value="">3</option>
	            					<option value="">4</option>
	            					<option value="">5</option>
	            					<option value="">6</option>
	            					<option value="">7</option>
	            					<option value="">8</option>
	            					<option value="">9</option>
	            					<option value="">10명이상</option>
	            				</select>
							</dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>이름</dt>
	            			<dd><input type="text" id="" name="" /></dd>
	            		</dl>
	            		<dl class="form_group">
	            			<dt>전화번호</dt>
	            			<dd class="tel">
	            				<select>
	            					<option value="">010</option>
	            					<option value="">017</option>
	            					<option value="">019</option>
	            				</select>
	            				<em>-</em><input type="text" id="" name="" />
	            				<em>-</em><input type="text" id="" name="" />
	            				<p class="note">예약 확인을 위해 정확한 정보 입력 부탁드립니다.</p>
	            			</dd>
	            		</dl>
	            	</div>
	            	<h3 class="lec_privacy_tit">개인정보 수집 및 이용에 대한안내</h3>
					<div class="lec_privacy">
						<textarea cols="30" rows="10" title="개인정보수집 및 이용에 대한 안내">
개인정보 수집 및 이용에 대한 안내
바다여행일정만들기 사이트는 정보주체의 동의에 의해 개인정보를 수집·이용합니다.
홈페이지 회원관리를 위해 수집·보유하고 있는 주요 개인정보 파일은 다음과 같습니다.
- 수집 및 이용목적 : 바다여행일정만들기의 원활한 서비스 이용
- 개인정보 항목 : 이름, 휴대전화번호
- 보유 및 이용기간 : 회원가입 ~ 회원탈퇴(탈퇴 시 삭제)
- 정보주체의 권리 : 본인에 관한 개인정보 열람, 정정.삭제 청구권
 </textarea>
						<p>
							<input type="checkbox" id="chkAgree2" name="agree_box" /> 
							<label for="chkAgree2">동의합니다.</label>
						</p>
					</div>
	            	<div class="reservBtn_box tac">
	            		<!-- <a href="#none" class="button light_gray">이전화면</a> -->
	            		<a href="#none" class="button red">예약하기</a>
	            	</div>
					<!-- 
					<div class="reserv_info">
						<strong for="my_reserv">나의 예약 조회</strong>
						<span><lable for="my_reserv_name">이름</lable><input type=text" id="my_reserv_name" name="" /></span>
						<span><lable for="my_reserv_tel">전화번호</lable><input type=text" id="my_reserv_tel" name="" placeholder="'-'없이 숫자만 입력 " /></span>
						<a href="#none" class="btn">조회</a>
					</div> -->
					<!-- 구역 이미지 -->
					<!-- <div class="reserv_img">
						<img src="/seantour_map/images/travel/content/img_reserv01.jpg" alt="" />
					</div>
					<div class="reserv_area">
						<table border="0" class="tbl_calendar">
							<caption>달력</caption>
							<colgroup>
								<col style="width:16.666%;" />
								<col style="width:16.666%;" />
								<col style="width:16.666%;" />
								<col style="width:16.666%;" />
								<col style="width:16.666%;" />
								<col />
							</colgroup>
							<thead>
								<th scope="col">구역</th>
								<th scope="col">가능여부</th>
								<th scope="col">예약</th>
								<th scope="col">구역</th>
								<th scope="col">가능여부</th>
								<th scope="col">예약</th>
							</thead>
							<tbody>
								<tr>
									<td>1구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
									<td>26구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>2구역</td>
									<td><p class="end">불가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>27구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>3구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>28구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>4구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>29구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>5구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>30구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>6구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>31구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>7구역</td>
									<td><p class="end">불가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>32구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>8구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>33구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>9구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>34구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>10구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>35구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>11구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>36구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>12구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>37구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>13구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>38구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>14구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>39구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>15구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>40구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>16구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>41구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>17구역</td>
									<td><p class="end">불가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>42구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>18구역</td>
									<td><p class="end">불가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>43구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>19구역</td>
									<td><p class="end">불가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>44구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>20구역</td>
									<td><p class="end">불가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>45구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>21구역</td>
									<td><p class="end">불가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>46구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>22구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>47구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>23구역</td>
									<td><p class="end">불가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>48구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>24구역</td>
									<td><p class="end">불가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>49구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
								<tr>
									<td>25구역</td>
									<td><p class="end">불가능</p></td>
									<td><a href="#none" class="btn_end">종료</a></td>
									<td>50구역</td>
									<td><p class="possible">가능</p></td>
									<td><a href="#none" class="btn_reserv">예약</a></td>
								</tr>	
							</tbody>
						</table>	
					</div> -->
					<!-- 달력  -->
	            </div>	
            </div><!-- cont_body -->

        	</div><!-- // cont_wrap -->
        </div>
        <!--// container -->

		<!-- footer -->
		<%@ include file="/WEB-INF/jsp/travel/tpl/foot.jsp" %>
		<!--//footer -->
	</div>
	
</body>


</html>
