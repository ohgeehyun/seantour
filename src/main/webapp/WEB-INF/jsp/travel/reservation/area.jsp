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
				    	  		<option value="">지역선택</option>
					      		<option value=""></option>
					      		<option value=""></option>
					      		<option value=""></option>
					      		<option value=""></option>
				      		</select>	
				      		<select id="" name="" title="해수용장">
				    	  		<option value="">해수욕장 선택</option>
					      		<option value=""></option>
					      		<option value=""></option>
					      		<option value=""></option>
					      		<option value=""></option>
				      		</select>
			      		</div>
			      		<div class="field02">
				      		<select id="" name="" title="월">
				    	  		<option value="">월선택</option>
					      		<option value="">6월</option>
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
					<!-- 구역 이미지 -->
					<div class="reserv_img">
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
					</div>
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