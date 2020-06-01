<%
/**
 *@version 3.2.0.1
 **/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{-PAGENAVTITLE-}</title>
{-CONFIG_SEO-}
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
{-CONFIG_CSS-}

<script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/jquery.ui/js/jquery-ui-1.9.0.custom.min.js'/>"></script>
 <!-- script -->
{-CONFIG_JS-}
</head>

<body>
<div id="wrap">
	<!-- header -->
	<div id="header">
    	<ul class="util">
    		<li><a href="${pageContext.request.contextPath }/${Jnit_sitePath}">HOME</a></li>
    		<c:if test="${loginVO.mbrId == null }">
	        	<li><a href="${pageContext.request.contextPath }/${Jnit_sitePath}/login.jsp">로그인</a></li>	            
            </c:if>
            <c:if test="${loginVO.mbrId != null }">
	        	<li><a href="${pageContext.request.contextPath }/uat/uia/actionLogout.do">로그아웃</a></li>
	            <li><a href="${pageContext.request.contextPath }/${Jnit_sitePath}/mbr/myPage.jsp">마이페이지</a></li>
        		<li><a href="javascript:Jnit_workspace('<c:url value="/disseminate/workspace.do?mode=pop&sitePath=${Jnit_sitePath }"/>');" title="새 창으로 열립니다.">내업무함</a></li>
	            <li><a href="#" onclick="window.open('${pageContext.request.contextPath }/sms/view/page.do', 'CLIENT_WINDOW', 'resizable=yes scrollbars=no width=1040 height=725');" title="새 창으로 열립니다.">SMS</a></li>
            </c:if>
        </ul>
    	<p class="header_txt">HEADER</p>
    </div>
    <!-- End of header -->
	<!-- middle -->
	<div id="middle">    	
    	<jsp:include page="/cms/import/getSubMenu.jsp"></jsp:include>        	
        
        <div class="content_group">
        	<div class="content_top">
            	<h3>{-PAGETITLE-}</h3>
				{-PAGELINKNAV-}
				<ul class="content_util">
					<li class="content_text">
				    	<p><a href="#"><img src="${pageContext.request.contextPath }/{-SITEPATH-}/common/img/Jnit_text_big.gif" alt="글씨 크게" /></a></p>
				    	<p><a href="#"><img src="${pageContext.request.contextPath }/{-SITEPATH-}/common/img/Jnit_text_small.gif" alt="글씨 작게" /></a></p>
				        <p><a href="#wrap" onclick="pagePrint(); return false;"><img src="${pageContext.request.contextPath }/{-SITEPATH-}/common/img/Jnit_text_print.gif" alt="화면 인쇄" /></a></p>
				    	<p><a href="#" onclick="addScrap();"><img src="${pageContext.request.contextPath }/{-SITEPATH-}/common/img/Jnit_text_scrap.gif" alt="스크랩" /></a></p>
				    </li>
				   
					<li class="content_sns">
				    	<p class="twitter"><a href="#" target="_blank" title="새창에서 열립니다."><img src="${pageContext.request.contextPath }/{-SITEPATH-}/common/img/Jnit_content_twitter.gif" alt="내용을 트위터로 공유하기" /></a></p>
				    	<p class="facebook"><a href="#" target="_blank" title="새창에서 열립니다."><img src="${pageContext.request.contextPath }/{-SITEPATH-}/common/img/Jnit_content_facebook.gif" alt="내용을 페이스북으로 공유하기" /></a></p>				    	
				    	<p class="kakaostory"><a href="#" target="_blank" title="새창에서 열립니다."><img src="${pageContext.request.contextPath }/resources/img/kakaostory/story_pc_24x24.png" alt="내용을 카카오스토리로 가져가기" /></a></p>
				    </li>
				</ul>
            </div>
            
            <div class="content">
            <!-- Sample S 이상 -->
{-CONTENT-}
            <!-- Sample E 이하 -->            	
                <div class="qrcode"><!-- QR코드 -->
                	<script type="text/javascript">
                	<!--
                      $(document).ready(function(){
                      var location = $(document.location).attr('href');
                          var title = $("h3").text();
                          $(".txtQrcode").html("오른쪽 QR Code 이미지를 스마트폰에 인식시키면 자동으로 이 페이지로 연결됩니다.<br /> 이 QR Code는 <strong>"+title+"</strong> 페이지의 정보를 담고 있습니다.");
                          $("#qrCode").attr("alt","스마트폰으로 찍으면 현재 페이지("+title+" "+location+") 으로 연결되는 QR코드");
                          
                          $("#qrCodeZoom").attr("alt","스마트폰으로 찍으면 현재 페이지("+title+" "+location+") 으로 연결되는 QR코드");
                          $("#qrCode").attr("src", "${pageContext.request.contextPath }/qr/mini/make.do?w=100&amp;h=100").error(function() {
						  	this.src =  "http://chart.apis.google.com/chart?cht=qr&chs=100x100&chl="+location;
                          });
						  $("#qrCodeZoom").attr("src", "${pageContext.request.contextPath }/qr/mini/make.do?w=200&amp;h=200").error(function() {
						  	this.src =  "http://chart.apis.google.com/chart?cht=qr&chs=200x200&chl="+location;
						  });
                      
                      });
                      var zoomQr = function(){
                        if($('div.qrZoom').css('display') == 'none') {
                            $('div.qrZoom').fadeIn();
                        }else {
                            $('div.qrZoom').fadeOut();
                        }
                    }
                    // -->
                    </script>
                    <p class="qr_title">QR CODE</p>
                    <p class="txtQrcode">오른쪽 QR Code 이미지를 스마트폰에 인식시키면 자동으로 이 페이지로 연결됩니다.<br />
                    이 QR Code는 <strong>현재 페이지</strong> 의 정보를 담고 있습니다.</p>
                  	<a href="javascript:zoomQr();"><img id="qrCode" src="${pageContext.request.contextPath }/qr/mini/make.do?w=100&amp;h=100" alt="현재페이지로 연결되는 QR코드" /></a>
                  	             
                </div>               
                <div class="research"><!-- 만족도조사 -->
                	<jsp:include page="/cms/import/rscPage.jsp"></jsp:include>
                </div>             
                <div class="ccl">
					<!-- ccl표기 시작 -->
                    <a href='{-CCL_LINK-}' target="_blank" title="새창으로 열립니다."><img src='${pageContext.request.contextPath }/resources/img/ccl/{-CCL_GENERAL_IMG-}' alt='{-CCL_ALT-}' /></a>
                    <p><strong>[{-CCL_KEYWORD-}]</strong><br /><span>{-CCL_TEXT-}</span></p>
					<!-- ccl표기 끝 -->
                </div>                
                <div class="contentAdmin">
                	<jsp:include page="/cms/import/{-SITEPATH-}_content_admin.jsp"></jsp:include>   
                </div>
                <div class="updateButton"><!-- 컨텐츠 수정 -->
                	<jsp:include page="/cms/import/{-SITEPATH-}_updateButton.jsp"></jsp:include>   
                </div>
            </div>
        </div>
    </div>
    <!-- End of middle -->
	<!-- footer -->
	<div id="footer">
    	FOOTER
    </div>
    <!-- End of footer -->
</div>
</body>
</html>