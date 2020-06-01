<%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/_header.jsp' %><%@ page import="jnit.cms.handler.*" %><%@ page import="jnit.com.util.CclUtil" %><%@ page import="jnit.cms.menu.JnitcmsmenuController" %><c:set var="handingType" value="TPL_000111" />
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
                    <a href='<%=CclUtil.getLink(CmsServletPathProperty.getProp(servletPath,"pageCcl"))%>' target="_blank" title="새창으로 열립니다."><img src='${pageContext.request.contextPath }/resources/img/ccl/<%=CclUtil.getGeneralImg(CmsServletPathProperty.getProp(servletPath,"pageCcl"))%>' alt='<%=CclUtil.getAlt(CmsServletPathProperty.getProp(servletPath,"pageCcl"))%>' /></a>
                    <p><strong>[<%=CclUtil.getKeyword(CmsServletPathProperty.getProp(servletPath,"pageCcl"))%>]</strong><br /><span><%=CclUtil.getText(CmsServletPathProperty.getProp(servletPath,"pageCcl"))%></span></p>
					<!-- ccl표기 끝 -->
                </div>                
                <div class="contentAdmin">
                	<jsp:include page="/cms/import/travel_content_admin.jsp"></jsp:include>   
                </div>
                <div class="updateButton"><!-- 컨텐츠 수정 -->
                	<jsp:include page="/cms/import/travel_updateButton.jsp"></jsp:include>   
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