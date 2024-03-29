<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><c:set var="Jnit_sitePath" value="travel" /><%@ page import="jnit.cms.mbr.MbrUtil" %><% Boolean siauth = MbrUtil.siauth(); Boolean gpinauth = MbrUtil.gpinauth(); Boolean pkiauth = MbrUtil.pkiauth(); %><% String retType = request.getParameter("retType"); %><%@ include file='/travel/_tpls/B/TPL_000111_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><%
/**
 *@version 3.2.0.1
 **/
%>
<div class="member_content">
	<c:set var="siauth" value="<%=siauth %>" />
	<c:set var="gpinauth" value="<%=gpinauth %>" />
	<c:set var="pkiauth" value="<%=pkiauth %>" />
	<c:set var="retType" value="<%=retType %>" />
	<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/>" ></script>
	<script type="text/javascript" src="<c:url value="/resources/js/jnit.member.js"/> "></script>
	<script type="text/javascript" src="<c:url value="/total_login/common/js/auth_login.js" />" ></script>
	<script type="text/javascript" src="<c:url value="/total_login/common/js/search_idpw.js" />" ></script>
	
	<div class="member_box">
		<form name="mbrLoginForm" id="mbrLoginForm" method="post" action="">
			<input type="hidden" id="returnUrl" name="returnUrl" value="${Jnit_sitePath }" />
			<input type="hidden" id="checkAgree" name="checkAgree" value="ok"/>
			<input type="hidden" id="retParam" name="retParam" value="signup" />
			<input type="hidden" id="retType" name="retType" value="${retType }" />
			<c:if test="${siauth == false &&  gpinauth == false}">
				<input type="hidden" id="authDefaultYn" name="authDefaultYn" value="Y"/>
			</c:if>
		    <textarea style="width:94%;height:500px;" readonly="readonly">◆ 저희 JNITCMS 이용자 약관
 제1조(목적 등)
 
① 저희 JNITCMS 서비스 약관(이하 "본 약관"이라 합니다)은 이용자가 JNITCMS(이하 "JNITCMS"이라 합니다)에서 제공하는 인터넷 관련 서비스
(이하 "서비스"라 합니다)를 이용함에 있어 이용자와 "JNITCMS"의 권리와 의무 및 책임사항을 규정함을 목적으로 합니다. 

② 이용자가 되고자 하는 자가 "JNITCMS"가 정한 소정의 절차를 거쳐서 "등록하기" 단추를 누르면 본 약관에 동의하는 것으로 간주합니다. 본 약관에 정
하는 이외의 이용자와 "JNITCMS"의 권리, 의무 및 책임사항에 관해서는 전기통신사업법 기타 대한민국의 관련 법령과 상관습에 의합니다. 


제2조(이용자의 정의)


① "이용자"란 "JNITCMS"에 접속하여 본 약관에 따라 "JNITCMS" 회원으로 가입하여 "JNITCMS"가 제공하는 서비스를 받는 자를 말합니다. 


제3조(회원 가입)


① 이용자가 되고자 하는 자는 "JNITCMS"가 정한 가입 양식에 따라 회원정보를 기입하고 "등록하기" 단추를 누르는 방법으로 회원 가입을 신청합니다. 

② "JNITCMS"는 제1항과 같이 회원으로 가입할 것을 신청한 자가 다음 각 호에 해당하지 않는 한 신청한 자를 회원으로 등록합니다.

1. 가입신청자가 본 약관 제6조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우. 다만 제6조 제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 
"JNITCMS"의 회원재가입 승낙을 얻은 경우에는 예외로 합니다. 
2. 등록 내용에 허위, 기재누락, 오기가 있는 경우 
3. 기타 회원으로 등록하는 것이 "JNITCMS"의 기술상 현저히 지장이 있다고 판단되는 경우 

③ 회원가입계약의 성립시기는 "JNITCMS"의 승낙이 가입신청자에게 도달한 시점으로 합니다. 

④ 회원은 제1항의 회원정보 기재 내용에 변경이 발생한 경우, 즉시 변경사항을 정정하여 기재하여야 합니다. 


제4조(서비스의 제공 및 변경)


① "JNITCMS"는 이용자에게 아래와 같은 서비스를 제공합니다.
1. 영어글쓰기대회를 비롯한 일체의 영어 관련 시험에 대한 정보 제공과 시험 접수 및 시험 결과 통보 서비스
2. 온라인상의 시험 서비스
3. 회원을 위한 가정통신문, 부모님께 드리는 편지, 투약의뢰서 등의 서비스
4. 기타 "JNITCMS"가 자체 개발하거나 다른 회사와의 협력계약 등을 통해 회원들에게 제공할 일체의 서비스

② "JNITCMS"는 그 변경될 서비스의 내용 및 제공일자를 제7조 제2항에서 정한 방법으로 이용자에게 통지하고, 제1항에 정한 서비스를 변경하여 제공할 
수 있습니다.


제5조(서비스의 중단)


① "JNITCMS"는 컴퓨터 등 정보통신설비의 보수점검 과교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있고, 새로운 서비스로의 교체 기타 "JNITCMS"가 적절하다고 판단하는 사유에 기하여 현재 제공되는 서비스를 완전히 중단할 수 있습니다. 

② 제1항에 의한 서비스 중단의 경우에는 "JNITCMS"는 제7조 제2항에서 정한 방법으로 이용자에게 통지합니다. 다만, "JNITCMS"가 통제할 수 없는 사유로 인한 서비스의 중단(시스템 관리자의 고의, 과실이 없는 디스크 장애, 시스템 다운 등)으로 인하여 사전 통지가 불가능한 경우에는 그러하지 아니합니다. 


제6조(이용자 탈퇴 및 자격 상실 등)


① 이용자는 "JNITCMS"에 언제든지 자신의 회원 등록을 말소해 줄 것(이용자 탈퇴)을 요청할 수 있으며 "JNITCMS"는 위 요청을 받은 즉시 해당 이용자의 회원 등록 말소를 위한 절차를 밟습니다. 

② 이용자가 다음 각 호의 사유에 해당하는 경우, "JNITCMS"는 이용자의 회원자격을 적절한 방법으로 제한 및 정지, 상실시킬 수 있습니다. 

1. 가입 신청 시에 허위 내용을 등록한 경우 
2. 다른 사람의 "서비스" 이용을 방해하거나 그 정보를 도용하는 등 전자거래질서를 위협하는 경우 
3. "서비스"를 이용하여 법령과 본 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우 

③ "JNITCMS"가 이용자의 회원자격을 상실시키기로 결정한 경우에는 회원등록을 말소합니다. 이 경우 이용자인 회원에게 회원등록 말소 전에 이를 통지
하고, 소명할 기회를 부여합니다. 


제7조(이용자에 대한 통지)


① "JNITCMS"가 특정 이용자에 대한 통지를 하는 경우 "JNITCMS"에 등록된 메일주소로 할수있습니다.

② "JNITCMS"가 불특정다수 이용자에 대한 통지를 하는 경우 "JNITCMS" 게시판에 게시함으로써 개별 통지에 갈음할 수 있습니다. 


제8조(이용자의 개인정보보호)


"JNITCMS"는 관련법령이 정하는 바에 따라서 이용자 등록정보를 포함한 이용자의 개인정보를 보호하기 위하여 노력합니다. 이용자의 개인정보보호에 
관해서는 관련법령 및 "JNITCMS"가 정하는 "개인정보보호정책"에 정한 바에 의합니다. 


제9조("JNITCMS"의 의무)


① "JNITCMS"는 법령과 본 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 본 약관이 정하는 바에 따라 지속적이고, 안정적으로 서비스를 제공하기 위해서 노력합니다. 

② "JNITCMS"는 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 구축합니다. 

③ "JNITCMS"는 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다. 



제10조(이용자의 ID 및 비밀번호에 대한 의무)


① "JNITCMS"가 관계법령, "개인정보보호정책"에 의해서 그 책임을 지는 경우를 제외하고, 자신의 ID와 비밀번호에 관한 관리책임은 각 이용자에게 있습니다. 

② 이용자는 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다. 

③ 이용자는 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 "JNITCMS에 통보하고 "JNITCMS"의 안내가 있는 경우에는 그에 따라야 합니다. 


제11조(이용자의 의무)


① 이용자는 다음 각 호의 행위를 하여서는 안됩니다. 

1. 회원가입신청 또는 변경시 허위내용을 등록하는 행위 
2. "JNITCMS"에 게시된 정보를 변경하는 행위
3. "JNITCMS" 기타 제3자의 인격권 또는 지적재산권을 침해하거나 업무를 방해하는 행위 
4. 다른 회원의 ID를 도용하는 행위 
5. 정크메일(junk mail), 스팸메일(spam mail), 행운의 편지(chain letters), 피라미드 조직에 가입할 것을 권유하는 메일, 외설 또는 폭력적인 메시지, 화상, 음성 등이 담긴 메일을 보내거나 기타 공서양속에 반하는 정보를 공개 또는게시하는 행위. 
6. 관련 법령에 의하여 그 전송 또는 게시가 금지되는 정보(컴퓨터 프로그램 등)의 전송 또는 게시하는 행위
7. 다음의 직원이나 다음 서비스의 관리자를 가장하거나 사칭하여 또는 타인의 명의를 모용하여 글을 게시하거나 메일을 발송하는 행위
8. 컴퓨터 소프트웨어, 하드웨어, 전기통신 장비의 정상적인 가동을 방해, 파괴할 목적으로 고안된 소프트웨어 바이러스, 기타 다른 컴퓨터 코드, 파일, 프로
그램을 포함하고 있는 자료를 게시하거나 전자우편으로 발송하는 행위
9. 스토킹(stalking) 등 다른 이용자를 괴롭히는 행위
10. 다른 이용자에 대한 개인정보를 그 동의 없이 수집,저장,공개하는 행위
11. 불특정 다수의 자를 대상으로 하여 광고 또는 선전을 게시하거나 스팸메일을 전송하는 등의 방법으로 "JNITCMS"의 서비스를 이용하여 영리목적의 활
동을 하는 행위
12. "JNITCMS"가 제공하는 서비스에 정한 약관 기타 서비스 이용에 관한 규정을 위반하는 행위

② 제1항에 해당하는 행위를 한 이용자가 있을 경우 "JNITCMS"는 본 약관 제6조 제2, 3항에서 정한 바에 따라 이용자의 회원자격을 적절한 방법으로 제한 
및 정지, 상실시킬 수 있습니다.

③ 이용자는 그 귀책사유로 인하여 "JNITCMS"나 다른 이용자가 입은 손해를 배상할 책임이 있습니다.


제12조(공개게시물의 삭제)


이용자의 공개게시물의 내용이 다음 각 호에 해당하는 경우 "JNITCMS"는 이용자에게 사전 통지 없이 해당 공개게시물을 삭제할 수 있고, 해당 이용자의 
회원 자격을 제한, 정지 또는 상실시킬 수 있습니다. 
1. 다른 이용자 또는 제3자를 비방하거나 중상 모략으로 명예를 손상시키는 내용
2. 공서양속에 위반되는 내용의 정보, 문장, 도형 등을 유포하는 내용
3. 범죄행위와 관련이 있다고 판단되는 내용
4. 다른 이용자 또는 제3자의 저작권 등 기타 권리를 침해하는 내용
5. 기타 관계 법령에 위배된다고 판단되는 내용


제13조(저작권의 귀속 및 이용제한)


① "JNITCMS"가 작성한 저작물에 대한 저작권 기타 지적재산권은 "JNITCMS"에 귀속합니다. 

② 이용자는 "JNITCMS"를 이용함으로써 얻은 정보를 "JNITCMS"의 사전승낙 없이 복제, 전송, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이
용하거나 제3자에게 이용하게 하여서는 안됩니다. 


제14조(약관의 개정)


① "JNITCMS"는 약관의규제등에관한법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진등에관한법률 등 관련법을 위배하지 않는 범위에서 본 약관
을 개정할 수 있습니다. 

② "JNITCMS"가 본 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 초기화면에 그 적용일자 칠(7일) 이전부터 적용일자 전일
까지 공지합니다. 

③ "이용자"는 변경된 약관에 대해 거부할 권리가 있습니다. "이용자"는 변경된 약관이 공지된 후 십오(15)일 이내에 거부의사를 표명할 수 있습니다. "이용
자"가 거부하는 경우 "JNITCMS"는 당해 "이용자"와의 계약을 해지할 수 있습니다. 만약 "이용자"가 변경된 약관이 공지된 후 십오(15)일 이내에 거부의사
를 표시하지 않는 경우에는 동의하는 것으로 간주합니다. 


제15조(재판관할)


"JNITCMS"와 이용자간에 발생한 서비스 이용에 관한 분쟁에 대하여는 대한민국 법을 적용하며, 본 분쟁으로 인한 소는 민사소송법상의 관할을 가지는 대한민국의 법원에 제기합니다. 
		    </textarea>
			<p class="check"><input type="checkbox" name="agree" id="agree"  /><label for="agree">위 이용약관에 동의합니다.</label></p>
			
			<div class="membership_btn btn-group">
				<c:if test="${siauth == true}" >
					<a href="javascript:authSi();" class="button blue">
						<c:if test="${retType == '' }" >실명인증회원가입</c:if>
						<c:if test="${retType == 'kid' }" >보호자 실명인증회원가입</c:if>
					</a>
				</c:if>
				<c:if test="${gpinauth == true}" >
					<a href="javascript:authGpin();" class="button blue">
						<c:if test="${retType == '' }" >공공I-PIN회원가입</c:if>
						<c:if test="${retType == 'kid' }" >보호자 I-PIN</c:if>
					</a>
				</c:if>
				<c:if test="${siauth == false &&  gpinauth == false}">
					<a href="javascript:Jnit_authDefault();" class="button blue">회원가입</a>
				</c:if>				
			</div>
		</form>
	</div>
</div><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000111_E.jsp' %>