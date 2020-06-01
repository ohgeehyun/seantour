package jnit.cms;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.util.CookieGenerator;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import jnit.cms.mbr.CmsOauthService;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.mbrtype.JnitcmsmbrtypeService;
import jnit.cms.mbrtype.JnitcmsmbrtypeVO;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.auth.RequestToken;
import twitter4j.conf.Configuration;
import twitter4j.conf.ConfigurationBuilder;

@Controller
public class CmsOauthController {
	
	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name = "jnitcmsmbrService")
	private JnitcmsmbrService jnitcmsmbrService;
	@Resource(name = "jnitcmsmbrtypeService")
	private JnitcmsmbrtypeService jnitcmsmbrtypeService;
	@Resource(name = "cmsOauthService")
	private CmsOauthService cmsOauthService;

	public static final String FACEBOOK = "facebook";
	public static final String GOOGLE	= "google"; 
	public static final String TWITTER	= "twitter";
	public static final String NAVER	= "naver";
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");

	String code ="";
	String vd ="";

	@RequestMapping(value="/cms/oauth/snslogin.do")
	public String snslogin(HttpServletRequest request, ModelMap model)
		throws Exception{
		String vender = NullUtil.nullString(request.getParameter("vender")).trim();
		
		if(vender.equals("facebook"))	vd = FACEBOOK;
		if(vender.equals("google"))		vd = GOOGLE;
		if(vender.equals("twitter"))	vd = TWITTER;
		if(vender.equals("naver")){
			vd = NAVER;
			String state = generateState();
			request.getSession().setAttribute("state", state);
		}
		
		request.getSession().setAttribute("vd", vd);
		
		cmsOauthService.setRedirectUrl(request, "/callback.do");
		HashMap<String,String> venderInfo = cmsOauthService.getVender(vd,request);
		
		
		model.addAttribute("venderInfo", venderInfo);
				
		return "/jnit/cms/oauth_login";
	}
	
	@RequestMapping("/cms/oauth/callback.do")
	public String callbackTest(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception{
		String vender = (String)request.getSession().getAttribute("vd");
		String vc = "30026";
		
		if(vender.equals("facebook")) {
			vd = FACEBOOK;
			vc = "30026";
		}
		if(vender.equals("google"))	{
			vd = GOOGLE;
			vc = "30036";
		}
		if(vender.equals("twitter")) {
			vd = TWITTER;
			vc = "30035";
		}
		if(vender.equals("naver")) {
			vd = NAVER;
			vc = "30037";
		}
		
		code = NullUtil.nullString(request.getParameter("code"));
		
		//네이버state 검증
		String state = NullUtil.nullString(request.getParameter("state"));
		if(!state.equals("")){
			String storedState = (String) request.getSession().getAttribute("state");
			log.debug("storedState : "+storedState);
			log.debug("responState : "+state);
			if( !state.equals( storedState ) ) {
			     //401 unauthorized
			} else {
			     //200 success
			}
		}
		String token = cmsOauthService.getToken(vd, code, request);
		
		HashMap<String, String> userData = cmsOauthService.getUserData(vd, token, request);
		
		if("true".equals(deDug)) log.debug(userData);
		
		
    	JnitcmsmbrVO jnitcmsmbrVO = new JnitcmsmbrVO();
    	jnitcmsmbrVO.setTypeId(vc);
    	jnitcmsmbrVO.setMbrNm(userData.get("name"));
    	jnitcmsmbrVO.setEmail(userData.get("email"));
    	jnitcmsmbrVO.setMbrLogin(userData.get("id"));
    	
    	String userDataPicture = userData.get("picture");
    	if(vd == FACEBOOK) {
    		userDataPicture = "http://graph.facebook.com/"+userData.get("id")+"/picture";
    	}
    	jnitcmsmbrVO.setMbrPhoto(userDataPicture);
    	
    	
    	jnitcmsmbrVO.setPasswd(userData.get("id")+"passwd");
    	if("true".equals(deDug)) log.debug(jnitcmsmbrVO);
    	//해당 아이디가 있는지 확인한다.
    	
    	if(jnitcmsmbrService.hasJnitcmsmbr(jnitcmsmbrVO) == false ){
    		if("true".equals(deDug)) log.debug("아이디 없음");
    		jnitcmsmbrVO.setPasswd(EgovFileScrty.encryptPassword(jnitcmsmbrVO.getPasswd()));
    		jnitcmsmbrService.insertJnitcmsmbr(jnitcmsmbrVO);
        	jnitcmsmbrVO.setPasswd(userData.get("id")+"passwd");
        	this.actionLogin(jnitcmsmbrVO, request, response, model);
    	}else{
    		jnitcmsmbrVO.setPasswd(userData.get("id")+"passwd");
        	this.actionLogin(jnitcmsmbrVO, request, response, model);		
    	}
    	//return "jnit/util/json";
    	return "jnit/util/openerReload";
    	
    	//return "redirect:/";
    	//return "redirect:/kr";
	}
	 @RequestMapping("/cms/mbr/twitterSignin.do")
	    public String mbrTwitterSignin(
	    		HttpServletRequest request,
	    		HttpServletResponse response,
	    		ModelMap map) throws Exception {
	    	
		 	HashMap<String,String> venderInfo = cmsOauthService.getVender(TWITTER,request);
		 	
		 	ConfigurationBuilder builder = new ConfigurationBuilder();
		 	builder.setOAuthConsumerKey(venderInfo.get("oauthId"));
		 	builder.setOAuthConsumerSecret(venderInfo.get("oauthSecret"));
		 	Configuration configuration = builder.build();
		 	TwitterFactory factory = new TwitterFactory(configuration);
		 	Twitter twitter = factory.getInstance();
		 	//Twitter twitter = TwitterFactory.getSingleton();
		 	//log.debug("key:" + twitter.getConfiguration().getOAuthConsumerKey());
		 	//log.debug("secret: " + twitter.getConfiguration().getOAuthConsumerSecret());
		 	try{
		 		twitter.setOAuthConsumer(venderInfo.get("oauthId"), venderInfo.get("oauthSecret"));
		        request.getSession().setAttribute("twitter", twitter);
		 	}catch(java.lang.IllegalStateException e){
		 		//log.error(e.getMessage());
		 		request.getSession().setAttribute("twitter", twitter);
		 	}
	        try {
	            StringBuffer callbackURL = request.getRequestURL();
	            int index = callbackURL.lastIndexOf("/");
	            callbackURL.replace(index, callbackURL.length(), "").append("/twitterCallback.do");

	            RequestToken requestToken = twitter.getOAuthRequestToken(callbackURL.toString());
	            request.getSession().setAttribute("requestToken", requestToken);
	            response.sendRedirect(requestToken.getAuthenticationURL());

	        } catch (TwitterException e) {
	            throw new Exception(e);
	        }
	    	
	    	return "jnit/util/json";
	    }
	    
	    @RequestMapping("/cms/mbr/twitterCallback.do")
	    public String mbrTwitterCallback(
	    		HttpServletRequest request,
	    		HttpServletResponse response,
	    		ModelMap map) throws Exception {
	    	
	    	Twitter twitter = (Twitter) request.getSession().getAttribute("twitter");
	        RequestToken requestToken = (RequestToken) request.getSession().getAttribute("requestToken");
	        String verifier = request.getParameter("oauth_verifier");
	        /*
	        log.debug("requestToken: " + requestToken);
	        log.debug("verifier: " + verifier);
	        */
	        try {
	            twitter.getOAuthAccessToken(requestToken, verifier);
	            User user = twitter.showUser(twitter.getId());
	            
	            /*
	            log.debug("twt name: " + user.getName());
	            log.debug("twt id: " + user.getId());
	            log.debug("twt email: " + user.getScreenName());
	            log.debug("twt photo: " + user.getProfileImageURL());
	            */
	            
	            JnitcmsmbrVO jnitcmsmbrVO = new JnitcmsmbrVO();
	        	jnitcmsmbrVO.setTypeId("30035");
	        	jnitcmsmbrVO.setMbrNm(user.getName());
	        	jnitcmsmbrVO.setMbrLogin(user.getScreenName()+"@twitterUser.com");
	        	jnitcmsmbrVO.setMbrPhoto(user.getProfileImageURL());
	        	jnitcmsmbrVO.setPasswd(user.getId()+"passwd");
	        	
	            request.getSession().removeAttribute("requestToken");
	        	//해당 아이디가 있는지 확인한다.
	        	
	        	if(jnitcmsmbrService.hasJnitcmsmbr(jnitcmsmbrVO) == false ){
	        		jnitcmsmbrVO.setPasswd(EgovFileScrty.encryptPassword(jnitcmsmbrVO.getPasswd()));
	        		jnitcmsmbrService.insertJnitcmsmbr(jnitcmsmbrVO);
	            	jnitcmsmbrVO.setPasswd(user.getId()+"passwd");
	            	
	            	this.actionLogin(jnitcmsmbrVO, request, response, map);
	        	}else{
	        		jnitcmsmbrVO.setPasswd(user.getId()+"passwd");
		        	this.actionLogin(jnitcmsmbrVO, request, response, map);	
	        	}
	        	
	        	} catch (TwitterException e) {
	            throw new Exception(e);
	        }
	        //response.sendRedirect(request.getContextPath() + "/");
	    	
	    	//return "jnit/util/json";
	    	return "jnit/util/openerReload";
	    }
	
	/**
	 * 일반(세션) 로그인을 처리한다
	 * 
	 * @param vo
	 *            - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request
	 *            - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping("/cms/oauth/exeLogin.do")
	public String actionLogin(
			@ModelAttribute("jnitcmsmbrVO") JnitcmsmbrVO jnitcmsmbrVO,
			HttpServletRequest request,
			HttpServletResponse response ,
			ModelMap model) throws Exception {

		// 1. 일반 로그인 처리
		JnitcmsmbrVO resVO = jnitcmsmbrService.exeLogin(request, jnitcmsmbrVO);
		// JnitcmsmbrVO resVO = new JnitcmsmbrVO();

        if (resVO != null && resVO.getMbrId() != null && !resVO.getMbrId().equals("")) {
        	
        	// 로그인 회원 등급 로딩
        	JnitcmsmbrtypeVO mbrtypeVO = new JnitcmsmbrtypeVO();
        	mbrtypeVO.setTypeId(resVO.getTypeId());
        	mbrtypeVO = jnitcmsmbrtypeService.selectJnitcmsmbrtype(mbrtypeVO);
        	resVO.setTypeVO(mbrtypeVO);
        	request.getSession().setAttribute("loginVO", resVO);
        	if("true".equals(deDug)) log.debug(request.getParameter("returnUrl"));
        	
        	// 2-1. 로그인 정보를 세션에 저장
        	
        	if(request.getParameter("returnUrl") == null) {
        		return "redirect:/";
        	}else {
        		return "redirect:"+request.getParameter("returnUrl");
        	}
        } else {
        	if(request.getParameter("returnUrl") != null) {
        		model.addAttribute("returnUrl", request.getParameter("returnUrl"));
        	}
        	
        	model.addAttribute("message", "로그인 정보가 올바르지 않습니다.");
        	return "redirect:/";
        }

	}
	/**
	 * 일반(세션) 로그아웃을 처리한다
	 * 
	 * @param request
	 *            - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그아웃결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping("/cms/oauth/logout.do")
	public String actionLogout(
			HttpServletRequest request,
			HttpServletResponse response ,
			ModelMap model) throws Exception { 


			request.getSession().setAttribute("snsLogin", null);
		
			CookieGenerator cg = new CookieGenerator();
			cg.setCookieName("snsLogin");
			cg.addCookie(response, null);
			cg.setCookieMaxAge(0);
			cg.setCookiePath("/"); 

			HashMap<String, String> snsLogin = new HashMap<String, String>();

			
			request.getSession().setAttribute("snsLogin", null);
			

			if (request.getParameter("returnUrl") == null) {
				return "redirect:/kr";
			} else {
				return "redirect:" + request.getParameter("returnUrl");
			}

		
	}
	
	public String generateState()
	{
	    SecureRandom random = new SecureRandom();
	    return new BigInteger(130, random).toString(32);
	}
}