<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>
<script>
	var referrer = document.reffer
</script>

<form:form commandName="checkbox" method="get">
<c:if test ="${param.destCategory eq '관광지'}">
<div class = "tagcheck">
						
						 <label><input type="checkbox" name="color" value="blue">공원</label>
     					 <label><input type="checkbox" name="color" value="red">등대</label>	
     					  <label><input type="checkbox" name="color" value="blue">문화유적</label>
     					 <label><input type="checkbox" name="color" value="red">섬</label>		
     					  <label><input type="checkbox" name="color" value="blue">어촌체험마을</label>
     					 <label><input type="checkbox" name="color" value="red">영화/드라마촬영지</label>		
     					  <label><input type="checkbox" name="color" value="blue">일출/낙조경관도로</label>
     					 <label><input type="checkbox" name="color" value="red">전망대/조망시설</label>		
     					  <label><input type="checkbox" name="color" value="blue">전시관/미술관/박물관</label>
     					 <label><input type="checkbox" name="color" value="red">체험프로그램</label>	
     					 <label><input type="checkbox" name="color" value="blue">축제/행사</label>
     					 <label><input type="checkbox" name="color" value="red">항구</label>
     					 <label><input type="checkbox" name="color" value="blue">휴양림</label>
     					 <label><input type="checkbox" name="color" value="red">기타관광지</label>				
</div>
</c:if>

<c:if test ="${param.destCategory eq '숙박'}">
<div class = "tagcheck">
						
						 <label><input type="checkbox" name="color" value="blue">게스트하우스</label>
     					 <label><input type="checkbox" name="color" value="red">리조트/콘도</label>	
     					  <label><input type="checkbox" name="color" value="blue">민박</label>
     					 <label><input type="checkbox" name="color" value="red">여관/모텔</label>		
     					  <label><input type="checkbox" name="color" value="blue">캠핑장</label>
     					 <label><input type="checkbox" name="color" value="red">펜션</label>		
     					  <label><input type="checkbox" name="color" value="blue">호텔</label>
     					 
</div>
</c:if>

<c:if test ="${param.destCategory eq '체험'}">
<div class = "tagcheck">
						
						 <label><input type="checkbox" name="color" value="blue">낚시터</label>
     					 <label><input type="checkbox" name="color" value="red">마리나</label>	
     					  <label><input type="checkbox" name="color" value="blue">수상여가</label>
     					 <label><input type="checkbox" name="color" value="red">유람선/크루즈</label>		
     					  <label><input type="checkbox" name="color" value="blue">해수욕장</label>
     					 <label><input type="checkbox" name="color" value="red">해안 자전거길</label>		
     					  <label><input type="checkbox" name="color" value="blue">해안누리길</label>
     					  <label><input type="checkbox" name="color" value="red">해안산책로</label>		
     					  <label><input type="checkbox" name="color" value="blue">해양스포츠/장비임대</label>
     					  <label><input type="checkbox" name="color" value="red">기타</label>		
     					 
</div>
</c:if>


<c:if test ="${param.destCategory eq '음식점'}">
<div class = "tagcheck">				
						 <label><input type="checkbox" name="color" value="blue">식도락</label>
     					 <label><input type="checkbox" name="color" value="red">양식</label>	
     					  <label><input type="checkbox" name="color" value="blue">일식</label>
     					 <label><input type="checkbox" name="color" value="red">중식</label>		
     					  <label><input type="checkbox" name="color" value="blue">한식</label>
     					 <label><input type="checkbox" name="color" value="red">횟집</label>	
</div>
</c:if>

<c:if test ="${param.destCategory eq '쇼핑'}">
<div class = "tagcheck">
						
						 <label><input type="checkbox" name="color" value="blue">가공</label>
     					 <label><input type="checkbox" name="color" value="red">전자제품</label>	
     					  <label><input type="checkbox" name="color" value="blue">어시장-</label>
</div>
</c:if>
</form:form>