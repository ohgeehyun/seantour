<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000127_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><!-- contaniner -->
		<div id="container" >

            <div class="section_visual sub01 trans400">
                <div class="section_tit_box">
		            <h2 class="tit trans300">FAQ</h2>
		            <p class="txt trans300">자주묻는질문들을 정리하였습니다.</p>
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
					<div class="tabmenu">
						<a href="#none">Q&A<span class="unfd sprh_com"></span></a>
						<ul>
							<li><a href="./index.jsp" class="on"><span>FAQ</span></a></li>
							<li><a href="../faq_customer/index.jsp" ><span>고객의 소리</span></a></li>
							<li><a href="../updateinfo/index.jsp"><span>정보수정제안</span></a></li>
						</ul>
					</div>					
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
					<div id="faq_wrap" class="faq_2">
				      <section id="faq_con">
				        <h2>FAQ 목록</h2>
				        <ol>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">관광에 궁금한 사항이 있으면 어디로 문의해야 하나요?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>관광에 대한 문의는 전국 어디서나 전화번호 1330입니다.<br /> 연중무휴로 24시간 관광안내를 해 드리고 있으며, 업무시간 중에는 지역 관광안내소와 연결되어 안내를 해드리고 있으니, 언제 어디서나 관광에 대한 궁금증이나 어려움이 있을때 1330으로 전화주시기 바랍니다.<br />보다 자세한 사항은「동해관광안내(☎033-1330)」으로 연락주세요. 친절히 안내해 드리겠습니다.</p>
				            <!--<div class="con_closer"><button type="button" class="closer_btn btn_b03">닫기</button></div>-->
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">모바일로 바다여행 정보를 볼 수는 없나요?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>동해시 관광홈페이지는 어디서나 확인 가능한 모바일 서비스를 함께 제공하고 있습니다.<br />모바일로 http://www.dh.go.kr/tour로 접속하시면 모바일 홈페이지를 만나보실 수 있습니다.</p>
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">여행을 가려고 합니다. 사전에 홍보물을 받아볼 수 있을까요?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>여행도우미 > 관광안내책자란에 ‘신청하기'를 클릭 후 이름, 주소 등을 등록해주시면 동해시관광지도와 관광안내책자 각 1부를 발송해 드립니다.<br />홍보물은 우편으로 발송되어 2~3일내에 수령이 가능합니다.</p>
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">문화관광해설사 예약문의는 어떻게 하나요?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>동해시 주요관광지 3월부터 11월까지 매일 근무하며 해설활동 중이고, <br />아래 배치장소를 방문하시는 분은 누구나 문화관광해설사로부터 문화유적 및 관광자원에 대한 상세한 설명과 친절한 안내를 받으실 수 있습니다.<br />배치장소 및 현황은 관광여건에 따라 변동될 수 있습니다.<br />안내전화 : 동해시청 관광과 TEL 033-530-2232 / FAX 033-530-2725 </p>
				            </div>
				          </li>
				          <li>
				            <h3><span class="tit_bg">Q</span><a href="#none" onclick="return faq_open(this);">여행에 대해 자세히 알고 싶을 때는 어디에 문의하면 되는지?</a></h3>
				            <div class="con_inner">
				            <span class="tit_bg">A</span>
				            <p>홈페이지를 새롭게 단장하여 여러분에게 편리함을 극대화하도록 최선의 노력을 다했습니다. <br />변화하는 트랜드와 새로운 정보를 실시간으로 보충하여 더욱 알차게 만들어 지도록 노력합니다. <br />특히 그동안 불편함을 많이 호소하였던 지도의 불편함을 해소하기 위해 새로운 입체지도를 만들어 여러분에 손과 발이 되도록 정성을 기울였습니다. <br />다양한 정보를 제공받으시고 상세한 정보나 궁금하신 사항은 관광안내소와 상담하세요.<br />관광안내소 (063)324-2114, 320-2570</p>
				            </div>
				          </li>
				        </ol>
				      </section>
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
