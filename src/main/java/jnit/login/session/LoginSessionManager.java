package jnit.login.session;

import java.util.Iterator;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jnit.cms.CmsHelper;
import jnit.cms.LoginManager;
import jnit.cms.mbr.JnitcmsmbrVO;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.com.utl.fcc.service.NullUtil;
public class LoginSessionManager extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		ModelMap model = new ModelMap();
		
		JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
		String mbrLogin = NullUtil.nullString(mbrVO.getMbrLogin());
		String clientSessionTime = Long.toString(request.getSession().getCreationTime());
		boolean duplicationLoginCheck = false;
		if(!mbrLogin.equals("")){
			duplicationLoginCheck = LoginManager.duplicationLoginCheck(mbrLogin, clientSessionTime);
			 
			if(!duplicationLoginCheck){
				try{
					ModelAndView modelAndView;
			    	request.getSession().setAttribute("loginVO", null);
			    	model.addAttribute("alert", "다른 PC에서 로그인이 되어 현재 사용중인 PC는 로그아웃 됩니다.");
					model.addAttribute("path","/");
					modelAndView = new ModelAndView("/jnit/util/alertMove",model);
					throw new ModelAndViewDefiningException(modelAndView);
				}catch(java.lang.IllegalStateException e){
					
				}
			}
		}
		return super.preHandle(request, response, handler);
	}
	
	
}       


