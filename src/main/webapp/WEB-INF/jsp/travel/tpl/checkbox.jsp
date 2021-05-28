<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>
<script>
	var referrer = document.reffer
</script>


<c:if test ="${param.destCategory eq '관광지'}">
<div class = "tagcheck">
						
						 <label><input type="checkbox" name="tourism" value="공원" >공원</label>
     					 <label><input type="checkbox" name="tourism" value="등대">등대</label>	
     					  <label><input type="checkbox" name="tourism" value="문화유적">문화유적</label>
     					 <label><input type="checkbox" name="tourism" value="섬">섬</label>	
     					  <label><input type="checkbox" name="tourism" value="승마장">승마장</label>	
     					  <label><input type="checkbox" name="tourism" value="어촌체험" >어촌체험</label>
     					 <label><input type="checkbox" name="tourism" value="영화" >영화/드라마촬영지</label>		
     					  <label><input type="checkbox" name="tourism" value="일출" >일출/낙조경관도로</label>
     					 <label><input type="checkbox" name="tourism" value="전망대" >전망대/조망시설</label>		
     					  <label><input type="checkbox" name="tourism" value="전시관" >전시관/미술관/박물관/기념관</label>
     					 <label><input type="checkbox" name="tourism" value="체험프로그램">체험프로그램</label>	
     					 <label><input type="checkbox" name="tourism" value="축제" >축제/행사</label>
     					 <label><input type="checkbox" name="tourism" value="항구">항구</label>
     					 <label><input type="checkbox" name="tourism" value="휴양림">휴양림</label>
     					 <label><input type="checkbox" name="tourism" value="기타관광지">기타관광지</label>		
     					 <label><input type="hidden" name="urlparam" value="관광지"></label>		
</div>
</c:if>

<c:if test ="${param.destCategory eq '숙박'}">
<div class = "tagcheck">
						
						 <label><input type="checkbox" name="lodgment" value="게스트하우스">게스트하우스</label>
     					 <label><input type="checkbox" name="lodgment" value="리조트">리조트/콘도</label>	
     					  <label><input type="checkbox" name="lodgment" value="민박">민박</label>
     					 <label><input type="checkbox" name="lodgment" value="여관" >여관/모텔</label>		
     					  <label><input type="checkbox" name="lodgment" value="캠핑장">캠핑장</label>
     					 <label><input type="checkbox" name="lodgment" value="펜션">펜션</label>		
     					  <label><input type="checkbox" name="lodgment" value="호텔">호텔</label>
     					  <label><input type="hidden" name="urlparam" value="숙박"></label>	
</div>
</c:if>

<c:if test ="${param.destCategory eq '레져'}">
<div class = "tagcheck">
						
						 <label><input type="checkbox" name= "leisure" value="낚시" >낚시</label>
     					 <label><input type="checkbox" name= "leisure" value="마리나">마리나</label>	
     					 <label><input type="checkbox" name= "leisure" value="유람선">유람선/크루즈</label>
     					 <label><input type="checkbox" name= "leisure" value="유람선">케이블카</label>		
     					  <label><input type="checkbox" name="leisure" value="해수욕장">해수욕장</label>
     					 <label><input type="checkbox" name= "leisure" value="해안자전거길">해안 자전거길</label>		
     					  <label><input type="checkbox" name="leisure" value="해안누리길">해안누리길</label>
     					  <label><input type="checkbox" name="leisure" value="해안산책로">해안산책로</label>		
     					  <label><input type="checkbox" name="leisure" value="해양레포츠">해양레포츠</label>
     					  <label><input type="checkbox" name="leisure" value="해양레포츠장비">해양레포츠장비</label>
     					  <label><input type="checkbox" name="leisure" value="기타">기타</label>	
     					    <label><input type="hidden" name="urlparam" value="레져"></label>		
     					 
</div>
</c:if>


<c:if test ="${param.destCategory eq '음식점'}">
<div class = "tagcheck">				
						 <label><input type="checkbox" name="restaurant" value="식도락" >식도락</label>
     					 <label><input type="checkbox" name="restaurant" value="양식" >양식</label>	
     					  <label><input type="checkbox" name="restaurant" value="일식">일식</label>
     					 <label><input type="checkbox" name="restaurant" value="중식">중식</label>		
     					  <label><input type="checkbox" name="restaurant" value="한식">한식</label>
     					 <label><input type="checkbox" name="restaurant" value="횟집">횟집</label>	
     					  <label><input type="hidden" name="urlparam" value="음식점"></label>	
     					 
</div>
</c:if>

<c:if test ="${param.destCategory eq '쇼핑'}">
<div class = "tagcheck">
						
						 <label><input type="checkbox" name="shopping" value="가공">가공</label>
     					 <label><input type="checkbox" name="shopping" value="전자제품">전자제품</label>	
     					  <label><input type="checkbox" name="shopping" value="어시장">어시장</label>
     					  <label><input type="hidden" name="urlparam" value="쇼핑 "></label>	
</div>
</c:if>
