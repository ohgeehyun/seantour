<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script type="text/javascript">
<!--

// -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_skeleton container-fluid">
	<%-- Contents Start --%>
		<div class="row-fluid">
			<div class="span12">
				<%-- 코딩 삽입 --%>		
				<div id="tamMenu" class="tamplate_lay">
					<table>
						<tbody>
							  <tr class="tl1">
							    <td class="tl_01">&nbsp;</td>
							    <td class="tl_02">&nbsp;</td>
							    <td class="tl_03">&nbsp;</td>
							    <td class="tl_04">&nbsp;</td>
							    <td class="tl_05" style="text-align: right;"><a href="/cms/page/view.do?bindType=sitemap" style="width: 40%;" class="tip-bottom tlb_btn01" data-original-title="소스 편집 페이지로 이동">사이트맵</a></td>
							    <td class="tl_06">&nbsp;</td>
							  </tr>
							  <tr class="tl2">
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							    <td colspan="2"><a href="/cms/page/view.do?bindType=topMenu" class="tip-bottom tlb_btn02" data-original-title="소스 편집 페이지로 이동">상단 메뉴</a></td>
							    <td style="text-align: right;"><a href="/cms/page/view.do?bindType=sitemap" style="width: 40%;" class="tip-bottom tlb_btn03" data-original-title="소스 편집 페이지로 이동">통합검색</a></td>
							    <td>&nbsp;</td>
							  </tr>
							  <tr class="tl3">
							    <td>&nbsp;</td>
							    <td rowspan="2"><a href="/cms/page/view.do?bindType=leftMenu" style="padding: 21% 2%;" class="tip-bottom tlb_btn04" data-original-title="좌측메뉴 소스 편집 페이지에서 수정하실수 있습니다.">좌측제목</a></td>
							    <td><a href="/cms/sub4/0102.do" style="width: 112px;float: left;" class="tip-bottom tlb_btn05" data-original-title="템플릿 관리에서 수정">페이지네비게이션</a></td>
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							  </tr>
							  <tr class="tl4">
							    <td>&nbsp;</td>
							    <td><a href="/cms/sub4/0102.do" style="width: 80px;float: left;" class="tip-bottom tlb_btn06" data-original-title="템플릿 관리에서 수정">제목</a></td>
							    <td>&nbsp;</td>
							    <td><a href="/cms/sub4/0102.do" style="width: 60%;float: right;" class="tip-bottom tlb_btn07" data-original-title="템플릿 관리에서 수정">유틸메뉴</a></td>
							    <td>&nbsp;</td>
							  </tr>
							  <tr class="tl5">
							    <td>&nbsp;</td>
							    <td style="vertical-align: top;"><a href="/cms/page/view.do?bindType=leftMenu" style="padding: 60% 2%;"  class="tip-bottom tlb_btn08" data-original-title="소스 편집 페이지로 이동">좌측메뉴</a></td>
							    <td class="tlcont" colspan="3" rowspan="2"><a href="/cms/sub4/0102.do" style="padding: 26% 2%;" class="tip-bottom  tlb_btn09" data-original-title="템플릿 관리에서 수정 / 내부 내용은 콘텐츠 관리에서 수정">콘텐츠내용</a></td>
							    <td>&nbsp;</td>
							  </tr>
							  <tr class="tl6">
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							  </tr>
							  <tr class="tl7">
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							    <td colspan="3"><a href="/cms/sub4/0102.do" style="padding: 2% 2%;" class="tip-bottom tlb_btn10" data-original-title="템플릿 관리에서 수정">QR코드</a></td>
							    <td>&nbsp;</td>
							  </tr>
							  <tr class="tl8">
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							    <td colspan="3"><a href="/cms/rsc/page.do" style="padding: 1.3% 2%;"  class="tip-bottom tlb_btn11" data-original-title="소스 편집 페이지로 이동">페이지평가</a></td>
							    <td>&nbsp;</td>
							  </tr>
							  <tr class="tl9">
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							    <td><a href="/cms/page/view.do?bindType=contentAdmin" style="width: 60%;float:left;" class="tip-bottom tlb_btn12" data-original-title="소스 편집 페이지로 이동">콘텐츠담당표시</a></td>
							    <td>&nbsp;</td>
							    <td><a href="/cms/page/view.do?bindType=updateButton" style="width: 60%;float:right;" class="tip-bottom tlb_btn13" data-original-title="소스 편집 페이지로 이동">수정버튼표시</a></td>
							    <td>&nbsp;</td>
							  </tr>
							  <tr class="tl10">
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							    <td><a href="/cms/sub4/0102.do" style="width: 60%;float:left;" class="tip-bottom tlb_btn14" data-original-title="템플릿 관리에서 수정">ccl 표시</a></td>
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							  </tr>
							  <tr class="tl11">
							    <td>&nbsp;</td>
							    <td colspan="4"><a href="/cms/allim/groupList.do?type=banner" class="tip-bottom tlb_btn15" data-original-title="배너관리에서 수정">배너</a></td>
							    <td>&nbsp;</td>
							  </tr>
							  <tr class="tl12">
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							    <td><a href="/cms/page/view.do?bindType=updateButton" style="width: 60%;float:right;" class="tip-bottom tlb_btn16" data-original-title="소스 편집 페이지로 이동">방문자 카운트 표시</a></td>
							    <td>&nbsp;</td>
							  </tr>
						  </tbody>
					</table>
	
				</div>

				<%-- 코딩 삽입 --%>	
				<div id="tamSubMenu" class="tamplate_lay_info">
					<div class="tlb_info01"><b>사이트맵</b><br />
						<ul>
							<li>사이트맵으로 사용할 콘텐츠 페이지에 코드를 입력합니다.<br />
								<div class="tlb_code">&lt;c:import url='/menu/getSiteMap.do'&gt;<br />
									　&lt;c:param name='siteNm' value='${fn:replace(pageContext.request.requestURI,pageContext.request.contextPath,"") }'&gt;&lt;/c:param&gt;<br />
									　&lt;c:param name='titles' value='<strong>대메뉴(1뎁스) 메뉴명을 콤마(,)로 구분하여 입력 해주시기 바랍니다.</strong>'&gt;&lt;/c:param&gt;<br />
								&lt;/c:import&gt;</div><br />
								<img src="../../resources/img/tamplateinfo/tlb_info01_img.png" alt="메뉴/콘텐츠 페이지 1뎁스 메뉴 선택" />
							</li>
							<li>대메뉴를 입력합니다. <span class="ex">ex)메뉴A,메뉴B,메뉴C</span></li>
							<li><b>,</b> 이후에 띄어쓰기 없이 입력해주세요.</li>
							<li>사이트맵 적용 이후 메뉴/콘텐츠 명이 변경 됬을 경우 빌드를 해주셔야 사이트맵에 적용됩니다.</li>
							<li>대메뉴(1뎁스)명이 중복 될 경우 중복된 메뉴가 모두 나오기 때문에 메뉴명에 주의해주세요.</li>
							<li>일부 메뉴를 사이트맵에서 숨기고 싶으실 경우 콘텐츠관리 &gt; 메뉴/콘텐츠관리 &gt; 숨기고 싶은 메뉴 혹은 콘텐츠를 누르시면 메뉴노출여부를 설정하실 수 있습니다.</li>
							<li>사이트맵 코드의 메뉴 입력 순서와 상관없이 메뉴/콘텐츠 관리에 있는 메뉴 순서대로 나오는데, 사이트맵에 나오는 메뉴 순서를 바꾸고 싶으실 경우 위의 사이트맵 코드를 추가한 뒤 코드당 메뉴 하나씩 원하슨 순서로 넣으시면 됩니다.</li>
						</ul>
					</div>
					<div class="tlb_info02"><b>상단메뉴</b><br />
						<ul>
							<li>상단메뉴가 들어갈 콘텐츠 페이지에 코드를 입력합니다.<br />
								<div class="tlb_code"><p>&lt;c:import url="/menu/getTopMenu.do"&gt;<br /> 
									　&lt;c:param name="target" value="<strong>[탑메뉴 target명]</strong>" /&gt;<br />
									 　&lt;c:param name="menuNm" value="<strong>[메뉴명]</strong>" /&gt;<br />
									 　&lt;c:param name="depth" value="<strong>[뎁스]</strong>" /&gt;<br />
									　&lt;c:param name="order" value="<strong>[class순서 ex:0]</strong>" /&gt;<br />
									　&lt;c:param name="menuId" value="<strong>[메뉴아이디,메뉴명이 겹칠경우 사용]</strong>" /&gt;<br /> 
									&lt;/c:import&gt;</p></div>
							</li>
							<li><strong>target</strong> 은 탑메뉴 디자인 유형을 선택합니다. 템플릿 관리 &gt; 콘텐츠영역 템플릿 &gt; 상단메뉴에서 원하시는 유형을 추가/제거 하실 수 있습니다.</li>
							<li><strong>menuNm</strong> 은 노출시킬 메뉴명을 입력합니다. 대메뉴(1댑스)를 입력합니다.</li>
							<li><strong>depth</strong> 는 선택한 대메뉴의 하위메뉴를 어디까지 보여줄지 설정할수 있습니다. 1댑스까지만 노출시키길 원하시면 1, 2번째 하위메뉴까지 노출 시키려면 2를 입력합니다.</li>
							<li><strong>order</strong> 은 생성한 메뉴 class에 번호를 추가시킵니다. 다른 대메뉴와 번호가 겹치지 않게 설정해주세요.</li>
							<li><strong>menuId</strong> 는 대메뉴의 명칭이 중복됬을경우 원하는 메뉴의 메뉴아이디를 입력해 정확한 메뉴룰 노츌시킬 수 있습니다. <br />
								메뉴 아이디는 메뉴/콘텐츠관리의 해당메뉴를 선택하시면 확인하실 수 있습니다. </li>						
						</ul>
					</div>
					<div class="tlb_info03"><b>통합검색</b><br />
						<ul>
							<li>검색 결과 페이지로 사용할 콘텐츠 페이지에 코드를 입력합니다.<br />
								<div class="tlb_code"><p>&lt;c:import url='/total/search.do'&gt;<br /> 
										　&lt;c:param name='uri' value='${fn:replace(pageContext.request.requestURI,pageContext.request.contextPath,"") }'&gt;&lt;/c:param&gt;<br /> 
										　&lt;c:param name='contentPath' value='<strong>현재 콘텐츠페이지 경로/</strong>'&gt;&lt;/c:param&gt;<br /> 
									&lt;/c:import&gt;</p></div>
							</li>
							<li>현재 코드가 들어가 있는 콘텐츠페이지의 경로를 입력합니다. 경로 마지막에 /를 넣어주세요.</li>
							<li>통합검색바가 들어갈 곳에 코드를 입력합니다.<br />
								<div class="tlb_code">
									<p>&lt;script type="text/javascript"&gt;<br />
										　&lt;!--<br />
										　function main_search(){ <br />
										　　 var search1 = $("#search_box").val(); <br />
										　　 var searchUrl = encodeURI("<strong>통합검색 결과 페이지가 적용된 페이지 경로</strong>?searchKeyword="+search1);<br />
										　　 document.getElementById("searchform").action=searchUrl;<br />
										　　 document.getElementById("searchform").submit();<br />
										　 }<br />
										　 $(document).ready(function(){<br />
										　　 $("#search_key").click(function(e){<br />
										　 　　e.preventDefault(); <br />
										 　　　var search = $("#search_box").val(); <br />
										　　　 var searchUrl = encodeURI("<strong>통합검색 결과 페이지가 적용된 페이지 경로</strong>?searchKeyword="+search);<br />
										　　　 document.getElementById("searchform").action=searchUrl;<br />
										　　　 document.getElementById("searchform").submit();<br />
										　　 }); <br />
										　 }); <br />
										　 //--&gt;<br />
										 &lt;/script&gt;<br />
										 &lt;form name="searchform" id="searchform" action="" method="post"&gt;<br />
										　 &lt;div class="search_wrap m_hidden search_form"&gt;<br />
										　　 &lt;input type="text" name="search_box" title="검색박스" id="search_box" class="search_input01" placeholder="검색어를 입력하세요" onkeydown="if(event.keyCode == 13) main_search();" value="" /&gt;<br />
										　　 &lt;a href="#" id="search_key" class="search_btn"&gt;&lt;i class="icon-search"&gt;&lt;/i&gt;&lt;span class="comment"&gt;검색&lt;/span&gt;&lt;/a&gt;<br />
										　 &lt;/div&gt;<br />
										 &lt;/form&gt;</p></div>
							</li>
							<li>통합검색의 금지어 및 검색이 안되게 설정 하려면 컴포넌트관리 &gt; 통합검색관리에서 설정할 수 있습니다. </li>						
						</ul>
					</div>
					<div class="tlb_info04"><b>좌측제목</b><br />
						<ul>
							<li>좌측메뉴에 포함되어 있습니다. 좌측메뉴 디자인 관리에서 소스의<br />
								<div class="tlb_code">
									<p>&lt;h2&gt;<strong>$&#123;menu.title&#125;</strong> &lt;/h2&gt;</p></div>
									에 위치합니다.
							</li>
							<li>서브템플릿에서 좌측메뉴를 등록시 같이 노출됩니다.</li>	
							<li>좌측제목은 대메뉴(1뎀스)가 표시됩니다.</li>					
							<li>내용은 콘텐츠관리 &gt; 메뉴/콘텐츠관리에서 메뉴명 을 변경하실 수 있습니다.<br />
							<img src="../../resources/img/tamplateinfo/tlb_info01_img.png" alt="메뉴/콘텐츠 페이지 1뎁스 메뉴" /></li>						
						</ul>
					</div>
					<div class="tlb_info05"><b>페이지네비게이션</b><br />
						<ul>
							<li>템플릿 관리 &gt; 서브템플릿 관리에서 원하시는 위치에 추가할 수 있습니다.<br />
								<div class="tlb_code">
									<p><strong>$&#123;-PAGENAV-&#125;</strong></p></div>
							</li>		
							<li>
								<div class="tlb_code">
									<p>&lt;span id="pageLinkNav"&gt;<br />
									　&lt;a href="#" class="menu-home"&gt;&lt;span&gt;Home&lt;/span&gt;&lt;/a&gt;<br />
									　&lt;span class="gt"&gt; &amp;gt; &lt;/span&gt;<br />
									　 &&lt;a href="/demo_01/sub01"&gt;&lt;span&gt;1댑스메뉴명&lt;/span&gt;&lt;/a&gt;<br />
									　&lt;span class="gt"&gt; &amp;gt; &lt;/span&gt;<br />
									　 &lt;span class="menu-active"&gt;2댑스 메뉴명&lt;/span&gt;<br />
									&lt;/span&gt;</p></div>
									위와 같은식으로 소스가 나타나며 소스는 변경이 불가능합니다.
							</li>						
						</ul>
					</div>
					<div class="tlb_info06"><b>제목</b><br />
						<ul>
							<li>템플릿 관리 &gt; 서브템플릿 관리에서 원하시는 위치에 추가할 수 있습니다.<br />
								<div class="tlb_code">
									<p><strong>$&#123;-PAGETITLE-&#125;</strong></p></div>
							</li>
							<li>좌측제목은 현재 보고있는 컨텐츠페이지의 메뉴명이 표시됩니다.</li>											
						</ul>
					</div>
					<div class="tlb_info07"><b>유틸메뉴</b><br />
						<ul>
							<li>템플릿 관리 &gt; 서브템플릿 관리에서 추가할 수 있습니다.</li>
							<li>기본적으로 글씨 크기조절/인쇄/스크랩/sns로 공유하기 기능이 들어가있습니다.</li>											
						</ul>
					</div>
					<div class="tlb_info08"><b>좌측메뉴</b><br />
						<ul>
							<li>템플릿 관리 &gt; 콘텐츠영역 템플릿 &gt; 좌측메뉴에서 코드를 수정할 수 있습니다.</li>
							<li>템플릿 관리 &gt; 서브템플릿 관리에서 아래 코드를 원하시는 위치에 두어 추가할 수 있습니다.<br />
								<div class="tlb_code">
									<p>&lt;jsp:include page="/cms/import/getSubMenu.jsp"&gt;&lt;/jsp:include&gt;</p>
								</div>
							</li>					
							<li>좌측메뉴에 외부링크 추가하시려면 콘텐츠관리 &gt; 메뉴/콘텐츠관리에서 메뉴폴더를 클릭, 링크URL 사용설정하시면 됩니다.</li>											
						</ul>
					</div>
					<div class="tlb_info09"><b>콘텐츠내용</b><br />
						<ul>
							<li>템플릿 관리 &gt; 서브템플릿 관리에서 원하시는 위치에 추가할 수 있습니다.<br />
								<div class="tlb_code">
									<p><strong>$&#123;-CONTENT-&#125;</strong></p></div>
							</li>
							<li>콘텐츠관리 &gt; 메뉴/콘텐츠관리의 콘텐츠에 입력한 내용이 표시되는 부분입니다.</li>										
						</ul>
					</div>
					<div class="tlb_info10"><b>QR코드</b><br />
						<ul>
							<li>템플릿 관리 &gt; 서브템플릿 관리에서 원하시는 위치에 추가할 수 있습니다.<br />
								<div class="tlb_code">
									<p>&lt;div class="qrcode"&gt;<br />
									　&lt;script type="text/javascript"&gt;<br />
									　&lt;!--<br />
									　　$(document).ready(function(){<br />
									　　　var location = $(document.location).attr('href');<br />
									　　　var title = $("h3").text();<br />
									　　　$(".txtQrcode").html("오른쪽 QR Code 이미지를 스마트폰에 인식시키면 자동으로 이 페이지로 연결됩니다.&lt;br /&gt; 이 QR Code는 &lt;strong&gt;"+title+"&lt;/strong&gt; 페이지의 정보를 담고 있습니다.");<br />
									　　　$("#qrCode").attr("alt","스마트폰으로 찍으면 현재 페이지("+title+" "+location+") 으로 연결되는 QR코드");<br />
									 <br />
									　　　$("#qrCodeZoom").attr("alt","스마트폰으로 찍으면 현재 페이지("+title+" "+location+") 으로 연결되는 QR코드");<br />
									　　　$("#qrCode").attr("src", "${pageContext.request.contextPath }/qr/mini/make.do?w=100&amp;amp;h=100").error(function() {<br />
									　　　　this.src = "http://chart.apis.google.com/chart?cht=qr&amp;chs=100x100&amp;chl="+location;<br />
									　　　});<br />
									　　　$("#qrCodeZoom").attr("src", "${pageContext.request.contextPath }/qr/mini/make.do?w=200&amp;amp;h=200").error(function() {<br />
									　　　　this.src = "http://chart.apis.google.com/chart?cht=qr&amp;chs=200x200&amp;chl="+location;<br />
									　　　});<br />
									 <br />
									　　});<br />
									　　var zoomQr = function(){<br />
									　　　if($('div.qrZoom').css('display') == 'none') {<br />
									　　　　$('div.qrZoom').fadeIn();<br />
									　　　}else {<br />
									　　　　$('div.qrZoom').fadeOut();<br />
									　　　}<br />
									　　}<br />
									　　// --&gt;<br />
									　&lt;/script&gt;<br />
									　&lt;p class="qr_title"&gt;QR CODE&lt;/p&gt;<br />
									　&lt;p class="txtQrcode"&gt;오른쪽 QR Code 이미지를 스마트폰에 인식시키면 자동으로 이 페이지로 연결됩니다.&lt;br /&gt;<br />
									　이 QR Code는 &lt;strong&gt;현재 페이지&lt;/strong&gt; 의 정보를 담고 있습니다.&lt;/p&gt;<br />
									　&lt;a href="javascript:zoomQr();"&gt;&lt;img id="qrCode" src="${pageContext.request.contextPath }/qr/mini/make.do?w=100&amp;amp;h=100" alt="현재페이지로 연결되는 QR코드" /&gt;&lt;/a&gt;<br />
									 <br />
									 &lt;/div&gt;
									 </p>
								</div>
							</li>
							<li>서브템플릿에 기본적으로 들어가 있으며 현재 보고 있는 페이지의 링크를 담고 있는 qr코드를 페이지에 보여줍니다.</li>		
						</ul>
					</div>
					<div class="tlb_info11"><b>페이지평가</b><br />
						<ul>
							<li>템플릿 관리 &gt; 서브템플릿 관리에서 원하시는 위치에 추가할 수 있습니다.<br />
								<div class="tlb_code">
									<p>&lt;jsp:include page="/cms/import/rscPage.jsp"&gt;&lt;/jsp:include&gt;</p>
								</div>
							</li>	
							<li>보고있는 페이지에 대한 사용자의 평가와 의견을 볼수 있습니다.</li>
							<li>템플릿 관리 &gt; 콘텐츠영역 템플릿 &gt; 페이지평가템플릿 에서 모든 페이지의 결과와 조회수를 확인할수 있습니다.</li>
							<li>원하는 기간의 평가를 엑셀파일로 다운 받을수 있습니다.</li>
						</ul>
					</div>
					<div class="tlb_info12"><b>콘텐츠담당표시</b><br />
						<ul>
							<li>템플릿 관리 &gt; 서브템플릿 관리에서 원하시는 위치에 추가할 수 있습니다.<br />
								<div class="tlb_code">
									<p>&lt;jsp:include page="/cms/import/local_dev_content_admin.jsp"&gt;&lt;/jsp:include&gt;</p>
								</div>
							</li>	
							<li>템플릿 관리 &gt; 콘텐츠영역 템플릿 &gt; 콘텐츠담당표시에서 소스를 수정할 수 있습니다.</li>
							<li>콘텐츠담당자는 콘텐츠관리 &gt; 메뉴/콘텐츠관리에서 원하시는 콘텐츠를 클릭하여 최대 2명까지 지정할 수 있습니다.  </li>
							<li>등록된 회원의 이름과 전화번호가 표시되며 콘텐츠 페이지의 최종 수정일이 표시됩니다.</li>
							<li>로그인템플릿, 회원템플릿 관련 페이지에는 표출되지 않습니다.</li>
						</ul>
					</div>
					<div class="tlb_info13"><b>수정버튼표시</b><br />
						<ul>
							<li>템플릿 관리 &gt; 서브템플릿 관리에서 원하시는 위치에 추가할 수 있습니다.<br />
								<div class="tlb_code">
									<p>&lt;jsp:include page="/cms/import/local_dev_updateButton.jsp"&gt;&lt;/jsp:include&gt;</p>
								</div>
							</li>	
							<li>템플릿 관리 &gt; 콘텐츠영역 템플릿 &gt; 콘텐츠담당표시에서 소스를 수정할 수 있습니다.</li>
							<li>관리자로 로그인시 cms에 들어오지 않고 웹에서 바로 해당 페이지의 콘텐츠수정팝업창이 열립니다.</li>
							<li>로그인템플릿, 회원템플릿 관련 페이지에는 표출되지 않습니다.</li>
						</ul>
					</div>
					<div class="tlb_info14"><b>ccl표시</b><br />
						<ul>
							<li>템플릿 관리 &gt; 서브템플릿 관리에서 원하시는 위치에 추가할 수 있습니다.<br />
								<div class="tlb_code">
									<p>&lt;!-- ccl표기 시작 --&gt;<br />
										　&lt;a href='{-CCL_LINK-}' target="_blank" title="새창으로 열립니다."&gt;&lt;img src='${pageContext.request.contextPath }/resources/img/ccl/{-CCL_GENERAL_IMG-}' alt='{-CCL_ALT-}' /&gt;&lt;/a&gt;<br />
										　&lt;p&gt;&lt;strong&gt;[{-CCL_KEYWORD-}]&lt;/strong&gt;&lt;br /&gt;&lt;span&gt;{-CCL_TEXT-}&lt;/span&gt;&lt;/p&gt;<br />
									&lt;!-- ccl표기 끝 --&gt;</p>
								</div>
							</li>
							<li>ccl 설정은 콘텐츠관리 &gt; 메뉴/콘텐츠관리에서 해당 콘텐츠를 클릭후 변경 하실 수 있습니다.</li>								
						</ul>
					</div>
					<div class="tlb_info15"><b>배너</b><br />
						<ul>
							<li>컴포넌트관리 아래 배너, 알리미, 팝업 등의 메뉴에서 추가 가능하며 형태와 위치에 따라 여러가지 용도로 활용이 가능합니다.</li>
							<li>해당 폴더아래 디자인 유형을 여러가치 추가 할 수 있습니다.</li>											
							<li><strong>배너</strong> : 주로 흘러가는 이미지, 로고들을 보여지는데 쓰입니다. </li>											
							<li><strong>알리미</strong> : 메인이나 사이트 최상단 등 이벤트나 공지사항 알림판으로 쓰입니다. 날짜를 예약해 올리거나 내리는게 가능합니다.</li>			
							<li><strong>팝업</strong> : 사이트내에 레이어 팝업창을 띄웁니다. 사용자가 원할경우 일정 기간동안 보이지 않게 할 수 있습니다.  날짜를 예약해 올리거나 내리는게 가능합니다.</li>	
						</ul>
					</div>
					<div class="tlb_info16"><b>방문자 카운트 표시</b><br />
						<ul>
							<li>템플릿 관리에서 원하시는 위치에 추가할 수 있습니다.<br />
								<div class="tlb_code">
									<p>
									<strong>&#123;-STATE-&#125;</strong> 사이트별 통계 호출 코드 (필수)<br />
									<strong>&#123;-STATE_TOTAL-&#125;</strong> 총 접속자 수<br />
									<strong>&#123;-STATE_TODAY-&#125;</strong> 오늘 접속자 수<br />
									<strong>&#123;-STATE_YESTERDAY-&#125;</strong> 어제 접속자 수
									</p>
								</div>
							</li>
						</ul>
					</div>
					
				</div>
				
				  
<script>

    $(document).ready(function(){
    	$("a[class*='tlb_btn']").on('mouseover', function(){
    		var thisClass = $(this).attr('class');
    		var infoClass = $.trim(thisClass.replace('btn', 'info').replace('tip-bottom', ''));
    		
    		$("."+infoClass).parent().find('div').removeClass('on');
    		$("."+infoClass).addClass('on');
    		//소스 삽입
    	});
    });
    </script>
      
			</div>
			
		</div>
	<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>