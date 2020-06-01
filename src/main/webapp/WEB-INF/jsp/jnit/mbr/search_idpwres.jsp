<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="header.jsp" %>
<script type="text/javascript">
function checkEmail(emailStr) {
    if (emailStr.length == 0) {
        return true;
    }
    var emailPat=/^(.+)@(.+)$/;
    var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]";
    var validChars="\[^\\s" + specialChars + "\]";
    var quotedUser="(\"[^\"]*\")";
    var ipDomainPat=/^(\d{1,3})[.](\d{1,3})[.](\d{1,3})[.](\d{1,3})$/;
    var atom=validChars + '+';
    var word="(" + atom + "|" + quotedUser + ")";
    var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
    var domainPat=new RegExp("^" + atom + "(\\." + atom + ")*$");
    var matchArray=emailStr.match(emailPat);
    if (matchArray == null) {
        return false;
    }
    var user=matchArray[1];
    var domain=matchArray[2];
    if (user.match(userPat) == null) {
        return false;
    }
    var IPArray = domain.match(ipDomainPat);
    if (IPArray != null) {
        for (var i = 1; i <= 4; i++) {
           if (IPArray[i] > 255) {
              return false;
           }
        }
        return true;
    }
    var domainArray=domain.match(domainPat);
    if (domainArray == null) {
        return false;
    }
    var atomPat=new RegExp(atom,"g");
    var domArr=domain.match(atomPat);
    var len=domArr.length;
    if ((domArr[domArr.length-1].length < 2) ||
        (domArr[domArr.length-1].length > 3)) {
        return false;
    }
    if (len < 2) {
        return false;
    }
    return true;
 }
 
</script>
<c:if test="${success != 'OK'}">
	<script type="text/javascript">
		$(document).ready(function(){
			if("" == $.trim("<c:out value="${param.mbrNm}"/>")) {
				alert("이름을 입력하세요.");
				$('body').delay(500).queue(function(){ self.close(); });
				return;
			}

			if("" == $.trim("<c:out value="${param.email}"/>") || !checkEmail($.trim("<c:out value="${param.email}"/>")) ) {
				alert("이메일을 정확하게 입력하세요.");
				$('body').delay(500).queue(function(){ self.close(); });
				return;
			}
			
			alert('가입정보를 찾을 수 없습니다.');
			$('body').delay(500).queue(function(){ self.close(); });
		});
	</script>
</c:if>
<c:if test="${success == 'OK'}">
	<c:import url="/${site}/search_idpwres.jsp"></c:import>
</c:if>