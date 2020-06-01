/**
 * @version 3.2.0.1
 */
package egovframework.com.uat.uia.web;

import javax.servlet.http.HttpServletRequest;

import jnit.cms.CmsHelper;
import jnit.cms.LoginManager;
import jnit.cms.mbr.JnitcmsmbrVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.fcc.service.NullUtil;


/**
 * 일반 로그인, 인증서 로그인을 처리하는 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  2011.8.26	정진오			IncludedInfo annotation 추가
 *  2011.09.07  서준식          스프링 시큐리티 로그인 및 SSO 인증 로직을 필터로 분리
 *  2011.09.25  서준식          사용자 관리 컴포넌트 미포함에 대한 점검 로직 추가
 *  2011.09.27  서준식          인증서 로그인시 스프링 시큐리티 사용에 대한 체크 로직 추가
 *  2011.10.27  서준식          아이디 찾기 기능에서 사용자 리름 공백 제거 기능 추가
 *  </pre>
 */

@Controller
public class EgovLoginController {

    /**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) 
			throws Exception {
    	
    	/*String userIp = EgovClntInfo.getClntIP(request);
    	
    	// 1. Security 연동
    	return "redirect:/j_spring_security_logout";*/
    	String duplication = NullUtil.nullString(request.getParameter("duplication"));
    	JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	String mbrLogin = NullUtil.nullString(mbrVO.getMbrLogin());
    	request.getSession().setAttribute("loginVO", null);
    	
    	if(!duplication.equals("")){
    		model.addAttribute("alert", "다른 PC에서 로그인이 되어 현재 사용중인 PC는 로그아웃 됩니다.");
    	}else{
    		model.addAttribute("alert", "로그아웃 되었습니다.");
    	}
    	
    	LoginManager.logout(mbrLogin);
    	model.addAttribute("path", request.getHeader("referer"));
    	return "/jnit/util/alertMove";
    }
}