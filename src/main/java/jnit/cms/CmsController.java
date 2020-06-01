/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import jnit.cms.config.CmsConfigController;
import jnit.cms.config.ConfigUtil;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.mbrpackage.MbrpackageUtil;
import jnit.cms.mbrsess.JnitcmsmbrsessDefaultVO;
import jnit.cms.mbrsess.JnitcmsmbrsessService;
import jnit.cms.mbrsess.JnitcmsmbrsessVO;
import jnit.cms.mbrtype.JnitcmsmbrtypeService;
import jnit.cms.mbrtype.JnitcmsmbrtypeVO;
import jnit.cms.menu.JnitcmsmenuDefaultVO;
import jnit.cms.menu.JnitcmsmenuService;
import jnit.cms.menu.JnitcmsmenuVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.db.JnitdbService;
import jnit.db.JnitdbVO;
import jnit.login.log.loginlogUtil;

@Controller
public class CmsController {
	
	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;

    @Resource(name = "jnitcmsmbrtypeService")
    private JnitcmsmbrtypeService jnitcmsmbrtypeService;

    @Resource(name = "jnitcmsmenuService")
    private JnitcmsmenuService jnitcmsmenuService;

    @Resource(name="jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;

    @Resource(name="jnitdbService")
    private JnitdbService jnitdbService;

    @Resource(name = "jnitcmsmbrsessService")
    private JnitcmsmbrsessService jnitcmsmbrsessService;


    @RequestMapping("/cms/login.do")
    public String formLogin(
    	HttpServletRequest request,
		ModelMap model) throws Exception {

    	if(!AdminUtil.isLoginPagePass(request)) return "";		//로그인 페이지 접근권한이 없으면 404 오류 발생
    	
    	if(request.getParameter("returnUrl") != null) {
    		model.addAttribute("returnUrl", request.getParameter("returnUrl"));
    	}
    	model.addAttribute("hostdom", request.getServerName());

    	return "jnit/cms/login";
    }

    @RequestMapping(value="/session/logout.do")
	public String siteLogout(HttpServletRequest request, ModelMap model)
			throws Exception {

    	String returnUrl = NullUtil.nullString(request.getParameter("returnUrl"));
    	if(returnUrl.equals("")){
    		returnUrl = "/";
    	}
    	request.getSession().setAttribute("loginVO", null);

    	model.addAttribute("alert", "로그아웃 되었습니다.");
    	model.addAttribute("path", returnUrl);

    	return "/jnit/util/alertMove";
    }

    /**
	 * 일반(세션) 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
    @RequestMapping("/exeLogin.do")
    public String actionLogin(
    		@ModelAttribute("jnitcmsmbrVO") JnitcmsmbrVO jnitcmsmbrVO,
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	String mbrId = NullUtil.nullString(request.getParameter("mbrLogin"));
    	String siteId = NullUtil.nullString(request.getParameter("siteId"));

    	Properties properties = CmsConfigController.getCmsDefaultProp(request);

    	// 1. 일반 로그인 처리
    	JnitcmsmbrVO resVO = jnitcmsmbrService.exeLogin(request, jnitcmsmbrVO);

    	//2014-04-21 by.나성재 수정 redirect시 &깨짐현상 수정조치 = refererUrl
    	String referer = "";
    	if(request.getParameter("refererUrl") != null){
    		referer = request.getParameter("refererUrl");
    	}else{
    		String[] refererExp = request.getHeader("referer").split("message");
    		referer = refererExp[0];
    	}

        if (resVO != null && resVO.getMbrId() != null && !resVO.getMbrId().equals("")) {
        	String returnUrl = NullUtil.nullString(request.getParameter("returnUrl"));
        	if(returnUrl.equals("")/* 2019.06.10 요청에 의해 외부 사이트 redirect 가능하도록 수정 || returnUrl.contains("http")*/){
        		returnUrl = "/";
        	}


        	//단체회원 서류 인증 체크
        	if(resVO.getTypeId().equals("30006")){
        		try{
	        		if(resVO.getGrpConfirm().equals("N")){
	        			model.addAttribute("alert", "관리자의 승인이 필요합니다.");
	        			return "jnit/util/alertBack";
	        		}
        		} catch (NullPointerException e){
        			log.error(e.getMessage());
        			model.addAttribute("alert", "관리자에게 문의하여 주십시오.");
        			return "jnit/util/alertBack";
        		}catch(Exception e){
        			log.error(e.getMessage());
        			model.addAttribute("alert", "관리자에게 문의하여 주십시오.");
        			return "jnit/util/alertBack";
        		}
        	}
        	//탈퇴회원처리
        	if(resVO.getTypeId().equals("30016")){
    			model.clear();
            	if(request.getParameter("returnUrl") != null) {
            		model.addAttribute("returnUrl", request.getParameter("returnUrl"));
            	}
            	if(referer.indexOf("?") > -1){
            		return "redirect:"+referer+"&message="+URLEncoder.encode("로그인정보가 올바르지 않습니다.","utf-8")+"&returnUrl="+returnUrl;
            	}else{
            		return "redirect:"+referer+"?message="+URLEncoder.encode("로그인정보가 올바르지 않습니다.","utf-8")+"&returnUrl="+returnUrl;
            	}
    		}

        	//로그인막기
        	int pwMiscnt = resVO.getPwMiscnt();
        	if(pwMiscnt > NullUtil.nullInt(Globals.LOGIN_PW_MISS_MAX_COUNT)){
    			if(referer.indexOf("?") > -1){
    				return "redirect:"+referer+"&message=로그인 가능 횟수 "+Globals.LOGIN_PW_MISS_MAX_COUNT+"회 초과하셨습니다.<br/>관리자에게 문의해주시기 바랍니다.&returnUrl="+returnUrl;
    			}else{
    				return "redirect:"+referer+"?message=로그인 가능 횟수 "+Globals.LOGIN_PW_MISS_MAX_COUNT+"회 초과하셨습니다.<br/>관리자에게 문의해주시기 바랍니다.&returnUrl="+returnUrl;
    			}
    		}


        	// 로그인 회원 등급 로딩
        	JnitcmsmbrtypeVO mbrtypeVO = new JnitcmsmbrtypeVO();
        	mbrtypeVO.setTypeId(resVO.getTypeId());
        	mbrtypeVO = jnitcmsmbrtypeService.selectJnitcmsmbrtype(mbrtypeVO);
        	resVO.setTypeVO(mbrtypeVO);

        	// 로그인 세션DB 체크
        	JnitcmsmbrsessDefaultVO sessSearchVO = new JnitcmsmbrsessDefaultVO();
        	sessSearchVO.setSearchCondition("0");
        	sessSearchVO.setSearchKeyword(resVO.getMbrId());
        	int isSess = jnitcmsmbrsessService.selectJnitcmsmbrsessListTotCnt(sessSearchVO);

        	int isLock = 0;
        	JnitcmsmbrsessVO sessVO = new JnitcmsmbrsessVO();
    		sessVO.setMbrId(resVO.getMbrId());
    		sessVO.setMbrSess(request.getSession().getId());

        	if(isSess == 0) {
        		jnitcmsmbrsessService.insertJnitcmsmbrsess(sessVO); //세션 임시가입
        	}else {
        		JnitcmsmbrsessVO oldsessVO = jnitcmsmbrsessService.selectJnitcmsmbrsess(sessVO);
        		if(oldsessVO.getMbrSess().equals(request.getSession().getId())) {
        			// 세션키가 같으면...
        			isLock = 0;
        		}else {
        			// 세션키가 다르면...
        			isLock = oldsessVO.getSessLock().intValue();
        		}
        	}

        	if(isLock == 0) {
        		// 락이 아닌경우...

        		// 세션 정보 갱신
        		sessVO.setSessLock(BigDecimal.valueOf(0));
        		jnitcmsmbrsessService.updateJnitcmsmbrsess(sessVO);

        		/* 중복 로그인 프로세스*/
        		String overlap = NullUtil.nullString((String) properties.get("overlap"));
        		if(overlap.equals("1")){
	            	if(LoginManager.duplicationLoginCheck(mbrId, Long.toString(request.getSession().getCreationTime()))){
	           			LoginManager.logout(mbrId);
	            	}
	            	LoginManager.setSession(mbrId, Long.toString(request.getSession().getCreationTime()));
        		}else{
        			LoginManager.logout(mbrId);
        		}

        		// 2-1. 로그인 정보를 세션에 저장
        		resVO.setCmsMenutree(AdminUtil.CmsMenuTree(resVO.getTypeId())/*getCmsMenuTree(request, model)*/);
        		request.getSession().setAttribute("loginVO", resVO);

        		String sessReturnUrl = "";
        		if( request.getSession().getAttribute("sessReturnUrl") != null ) {
        			sessReturnUrl = NullUtil.nullString( request.getSession().getAttribute("sessReturnUrl").toString() );
        		}

        		if(!sessReturnUrl.equals("")) {
        			request.getSession().removeAttribute("sessReturnUrl");
        			return "redirect:"+sessReturnUrl;
        		}
        	}else {
        		// 락중인경우 물어보기...
        		request.getSession().setAttribute("sessReturnUrl", returnUrl);
        		jnitcmsmbrVO.setMbrId(resVO.getMbrId());
        		request.getSession().setAttribute("sessMbrVO", jnitcmsmbrVO);

        		model.clear();
        		model.addAttribute("sess", "islock");
            	return "redirect:"+request.getHeader("referer"); //jnit/cms/login";

        	}

        	Boolean loginLog = loginlogUtil.loginLog();

        	if(loginLog == true){ //로그인기록 성공시 insert ip
        		resVO.setPwMiscnt(1);
        		jnitcmsmbrService.updateJnitcmsmbr(resVO);
        		return "redirect:"+returnUrl;
        	}else{
        		model.addAttribute("message", "로그인 기록이 올바르지 않습니다.");
        		return "redirect:"+request.getHeader("referer"); //jnit/cms/login
        	}
        } else {
        	model.clear();
        	String returnUrl = NullUtil.nullString(request.getParameter("returnUrl"));
        	if(returnUrl.equals("")) returnUrl = "/";

        	//로그인 막기
        	JnitcmsmbrVO mbroutVO = new JnitcmsmbrVO();
        	jnitcmsmbrVO.setSelectCondition("1");
        	try {
        		if("0".equals(ConfigUtil.getDefaultProp("sso")) && !"".equals(siteId)){
        			jnitcmsmbrVO.setSiteIdYn("Y");
        			jnitcmsmbrVO.setSiteId(siteId);
        		}
        		mbroutVO = jnitcmsmbrService.selectJnitcmsmbr(jnitcmsmbrVO);
        	} catch (NullPointerException e){
    			log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
        	if(mbroutVO.getMbrId() != null){
        		int pwMiscnt = mbroutVO.getPwMiscnt();
        		if(pwMiscnt > NullUtil.nullInt(Globals.LOGIN_PW_MISS_MAX_COUNT)){
        			if(referer.indexOf("?") > -1){
        				return "redirect:"+referer+"&message="+URLEncoder.encode("로그인 가능 횟수 "+Globals.LOGIN_PW_MISS_MAX_COUNT+"회 초과하셨습니다.<br/>관리자에게 문의해주시기 바랍니다.","utf-8")+"&returnUrl="+returnUrl;
        			}else{
        				return "redirect:"+referer+"?message="+URLEncoder.encode("로그인 가능 횟수 "+Globals.LOGIN_PW_MISS_MAX_COUNT+"회 초과하셨습니다.<br/>관리자에게 문의해주시기 바랍니다.","utf-8")+"&returnUrl="+returnUrl;
        			}
        		}else{
        			mbroutVO.setPwMiscnt(pwMiscnt+1);
        			mbroutVO.setUpdateCondition("1");
        			jnitcmsmbrService.updateJnitcmsmbr(mbroutVO);

        			if(referer.indexOf("?") > -1){
                		return "redirect:"+referer+"&message="+URLEncoder.encode("로그인 인증 실패 (비밀번호 "+pwMiscnt+"회 오류) 하였습니다.<br/>비밀번호 오류가 "+Globals.LOGIN_PW_MISS_MAX_COUNT+"회이상 발생할 경우 서비스 이용이 불가 하오니 정확히 입력해 주시기 바랍니다.","utf-8")+"&returnUrl="+returnUrl;
                	}else{
                		return "redirect:"+referer+"?message="+URLEncoder.encode("로그인 인증 실패 (비밀번호 "+pwMiscnt+"회 오류) 하였습니다.<br/>비밀번호 오류가 "+Globals.LOGIN_PW_MISS_MAX_COUNT+"회이상 발생할 경우 서비스 이용이 불가 하오니 정확히 입력해 주시기 바랍니다.","utf-8")+"&returnUrl="+returnUrl;
                	}
        		}
        	}
        	if(referer.indexOf("?") > -1){
        		return "redirect:"+referer+"&message="+URLEncoder.encode("로그인정보가 올바르지 않습니다.","utf-8")+"&returnUrl="+returnUrl;
        	}else{
        		return "redirect:"+referer+"?message="+URLEncoder.encode("로그인정보가 올바르지 않습니다.","utf-8")+"&returnUrl="+returnUrl;
        	}
        }
    }
    /**
	 * 세션 Lock 해제 후 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
    @RequestMapping("/exeLoginSess.do")
    public String actionLogin2(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {

    	JnitcmsmbrVO jnitcmsmbrVO = (JnitcmsmbrVO)request.getSession().getAttribute("sessMbrVO");

    	//log.debug("sessLogin:" + jnitcmsmbrVO);

    	JnitcmsmbrsessVO sessVO = new JnitcmsmbrsessVO();
		sessVO.setMbrId(jnitcmsmbrVO.getMbrId());
		sessVO.setMbrSess(request.getSession().getId());
		sessVO.setSessLock(BigDecimal.valueOf(0));
    	jnitcmsmbrsessService.updateJnitcmsmbrsess(sessVO);

    	request.getSession().removeAttribute("sessMbrVO");

		return actionLogin(jnitcmsmbrVO, request, model);
    }

    @SuppressWarnings("unchecked")
	@RequestMapping("/exeLoginAuth.do")
    public String actionAuthLogin(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {

    	HttpSession sess = request.getSession();
    	HashMap<String, String> snAuth = new HashMap<String, String>();
    	snAuth = (HashMap)sess.getAttribute("snAuth");

    	if(snAuth.get("dp") == null) {
    		return null;
    	}
    	if(NullUtil.nullString(snAuth.get("dp")).equals("")) {
    		return null;
    	}

    	JnitcmsmbrVO companyVO = new JnitcmsmbrVO();
    	companyVO.setTypeId("30032");
    	companyVO.setDp(NullUtil.nullString(snAuth.get("dp")));
    	companyVO.setEstablishment(NullUtil.nullString(snAuth.get("establishment")));
    	int isUser = jnitcmsmbrService.selectJnitcmsmbrDpSnTot(companyVO);

    	JnitcmsmbrVO jnitcmsmbrVO = new JnitcmsmbrVO();
    	if(isUser == 0) {
    		jnitcmsmbrVO.setMbrNm(NullUtil.nullString(snAuth.get("nm")));
    		jnitcmsmbrVO.setMbrLogin(NullUtil.nullString(snAuth.get("dp")).substring(25,30)+NullUtil.nullString(snAuth.get("dp")).substring(50,55));
    		jnitcmsmbrVO.setDp(NullUtil.nullString(snAuth.get("dp")));
    		jnitcmsmbrVO.setSn(NullUtil.nullString(snAuth.get("sn")));

    		if(NullUtil.nullString(snAuth.get("param")).equals("si")) {
    			jnitcmsmbrVO.setTypeId("30015"); //실명인증 비회원
    		}
    		if(NullUtil.nullString(snAuth.get("param")).equals("gpin")) {
    			jnitcmsmbrVO.setTypeId("30014"); //G-pin 비회원
    		}
    		if(NullUtil.nullString(snAuth.get("param")).equals("sign")) {
    			jnitcmsmbrVO.setTypeId("30013");// 공인인증 비회원
    		}
    		jnitcmsmbrVO.setPasswd(EgovFileScrty.encryptPassword(NullUtil.nullString(snAuth.get("dp")).substring(15,25)+NullUtil.nullString(snAuth.get("dp")).substring(50,55)));
    	    if(!NullUtil.nullString(snAuth.get("establishment")).equals("")){
    	    	jnitcmsmbrVO.setEstablishment(NullUtil.nullString(snAuth.get("establishment")));
    	    }
    		//log.debug(snAuth.get("param"));

    		jnitcmsmbrService.insertJnitcmsmbr(jnitcmsmbrVO);
    	}
   		if(snAuth.get("snRetUrl") != null) {
   			sess.setAttribute("snRetUrl", snAuth.get("snRetUrl"));
   		}

    	// 1. 일반 로그인 처리
    	jnitcmsmbrVO.setMbrLogin(NullUtil.nullString(snAuth.get("dp")).substring(25,30)+NullUtil.nullString(snAuth.get("dp")).substring(50,55));
    	jnitcmsmbrVO.setPasswd(NullUtil.nullString(snAuth.get("dp")).substring(15,25)+NullUtil.nullString(snAuth.get("dp")).substring(50,55));
    	JnitcmsmbrVO resVO = jnitcmsmbrService.exeLogin(request, jnitcmsmbrVO);

    	//JnitcmsmbrVO resVO = new JnitcmsmbrVO();
    	if(isUser != 0){ //가입된 로그인 처리
    		JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    		if(!NullUtil.nullString(snAuth.get("dp")).equals("")){
    			mbrVO.setDp(NullUtil.nullString(snAuth.get("dp")));
    		}
    		if(!NullUtil.nullString(snAuth.get("establishment")).equals("")){ //사업자 번호가 있을시
    			mbrVO.setEstablishment(NullUtil.nullString(snAuth.get("establishment")));
    		}
    		JnitcmsmbrVO loginVO = jnitcmsmbrService.selectDpJnitcmsmbr(mbrVO);
    		//회원 등급 로딩
    		JnitcmsmbrtypeVO mbrtypeVO = new JnitcmsmbrtypeVO();
    		mbrtypeVO.setTypeId(loginVO.getTypeId());
    		mbrtypeVO = jnitcmsmbrtypeService.selectJnitcmsmbrtype(mbrtypeVO);
    		loginVO.setTypeVO(mbrtypeVO);

    		//로그인 정보를 세션에 저장
    		request.getSession().setAttribute("loginVO", loginVO);
    		String returnUrl = NullUtil.nullString(sess.getAttribute("snRetUrl").toString());

    		/*request.getSession().setAttribute("snAuth", null);*/ //인증정보 세션을 제거한다.

    		return "redirect:"+returnUrl;
    	}
        if (resVO != null && resVO.getMbrId() != null && !resVO.getMbrId().equals("")) { //임시로그인처리
        	String returnUrl = NullUtil.nullString(sess.getAttribute("snRetUrl").toString());
        	if(returnUrl.equals("")) returnUrl = "/";

        	// 로그인 회원 등급 로딩
        	JnitcmsmbrtypeVO mbrtypeVO = new JnitcmsmbrtypeVO();
        	mbrtypeVO.setTypeId(resVO.getTypeId());
        	mbrtypeVO = jnitcmsmbrtypeService.selectJnitcmsmbrtype(mbrtypeVO);
        	resVO.setTypeVO(mbrtypeVO);

        	/* 중복 로그인 프로세스*/
        	Properties properties = new Properties();
        	String mbrId = resVO.getMbrLogin();
    		String overlap = NullUtil.nullString((String) properties.get("overlap"));
    		if(overlap.equals("1")){
            	if(LoginManager.duplicationLoginCheck(mbrId, Long.toString(request.getSession().getCreationTime()))){
           			LoginManager.logout(mbrId);
            	}
            	LoginManager.setSession(mbrId, Long.toString(request.getSession().getCreationTime()));
    		}else{
    			LoginManager.logout(mbrId);
    		}

    		// 2-1. 로그인 정보를 세션에 저장
        	request.getSession().setAttribute("loginVO", resVO);

       		return "redirect:"+returnUrl;
        } else {
        	if(!NullUtil.nullString(snAuth.get("snRetUrl").toString()).equals("")) {

        		model.addAttribute("returnUrl", NullUtil.nullString(snAuth.get("snRetUrl").toString())); //sess.getAttribute("snRetUrl")
        	}
        	model.addAttribute("message", "로그인 정보가 올바르지 않습니다.");
        	return "redirect:"+request.getHeader("referer"); //jnit/cms/login";
        }

    }
    /**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/exeAjaxLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model)
			throws Exception {

    	request.getSession().setAttribute("loginVO", null);
    	model.addAttribute("json","{\"result\":\"success\"}");
    	return "/jnit/util/json";
    }
    /**
	 * 메뉴 뷰
	 * @param vo - JnitcmsmenuVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
    @RequestMapping("/getLeftMenu.do")
    public String getLeftMenu(
    		@RequestParam("siteId") java.lang.String siteId,
    		@RequestParam("prefixMenuId") java.lang.String prefixMenuId,
    		HttpServletRequest request,
    		ModelMap model) throws Exception {

    	JnitcmsmenuDefaultVO searchVO = new JnitcmsmenuDefaultVO();

    	String schQuery = "PID='"+prefixMenuId+"'";

    	searchVO.setSiteId(siteId);
    	searchVO.setSearchCondition("2");
    	searchVO.setSearchKeyword(schQuery);

		MessageDigest md5 = MessageDigest.getInstance("MD5");

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(siteId);
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

    	List menuList1 = jnitcmsmenuService.selectJnitcmsmenuList(searchVO);
    	HashMap<String, List> submenu = new HashMap<String, List>();
    	HashMap<String, String> hashmenu = new HashMap<String, String>();
    	HashMap<String, String> pathmenu = new HashMap<String, String>();
    	for(int i=0; i<menuList1.size(); i++) {
        	JnitcmsmenuDefaultVO subsearchVO = new JnitcmsmenuDefaultVO();
        	String subschQuery = "PID='"+((EgovMap)menuList1.get(i)).get("menuId")+"'";
        	subsearchVO.setSiteId(siteId);
        	subsearchVO.setSearchCondition("2");
        	subsearchVO.setSearchKeyword(subschQuery);

        	 List submenuList = jnitcmsmenuService.selectJnitcmsmenuList(subsearchVO);
        	 for(int j=0; j<submenuList.size(); j++) {
        		 String pageIdHash = "";
        		 byte[] bip = md5.digest( ((EgovMap)submenuList.get(j)).get("cntId").toString().getBytes() );
        		 for(int s=0; s<bip.length; s++) {
        			pageIdHash += Integer.toHexString((int) bip[s] & 0x000000ff);
        		 }

        		 hashmenu.put(
        			((EgovMap)submenuList.get(j)).get("cntId").toString(),
        			 pageIdHash.toString()
        		);

    	        JnitcmsmenuVO menuVO2 = new JnitcmsmenuVO();
    	        //log.debug("submenuList : " + submenuList.get(j));
    	        menuVO2.setSiteId(siteId);
    	        menuVO2.setIslink( ( (Boolean)((EgovMap)submenuList.get(j)).get("islink") == true ) ? Byte.valueOf((byte) 1) : Byte.valueOf((byte) 0));
    	        menuVO2.setLinkurl( ( ((EgovMap)submenuList.get(j)).get("linkurl") != null) ? ((EgovMap)submenuList.get(j)).get("linkurl").toString() : "" );
    	        menuVO2.setMenuId(((EgovMap)submenuList.get(j)).get("menuId").toString());
    	        menuVO2 = jnitcmsmenuService.selectJnitcmsmenu(menuVO2);
        		pathmenu.put(
        			((EgovMap)submenuList.get(j)).get("menuId").toString(),
        			(String)jnitcmsmenuService.makeMenuDirectoryName(menuVO2, siteVO.getSitePath())+"/"
        		);

        	 }
        	submenu.put(((EgovMap)menuList1.get(i)).get("menuId").toString(), submenuList);
    	}

    	model.addAttribute("menuList", menuList1);
    	model.addAttribute("submenuList", submenu);
    	model.addAttribute("hashmenu", hashmenu);
    	model.addAttribute("pathmenu", pathmenu);

    	return "/jnit/cms/leftmenu";
    }

    /**
	 * 세션 정보 확인 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
    @RequestMapping("/isRealSess.do")
    public String isRealSess(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {

    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);

    	if(loginVO == null || NullUtil.nullString(loginVO.getMbrId()).equals("")) {
    		model.addAttribute("msg", "E01");
    		return "jnit/msg";
    	}

    	JnitcmsmbrsessVO sessVO = new JnitcmsmbrsessVO();
    	sessVO.setMbrId(loginVO.getMbrId());
    	sessVO = jnitcmsmbrsessService.selectJnitcmsmbrsess(sessVO);

    	if(!sessVO.getMbrSess().equals(request.getSession().getId())) {
    		request.getSession().removeAttribute("loginVO");
    		model.addAttribute("msg", "E02");
    		return "jnit/msg";
    	}

    	model.addAttribute("msg", "OK");
		return "jnit/msg";
    }

	@RequestMapping("/searchId.do")
    public String searchId(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {

    	HttpSession sess = request.getSession();
    	HashMap<String, String> snAuth = new HashMap<String, String>();
    	snAuth = (HashMap)sess.getAttribute("snAuth");

    	if(snAuth.get("dp") == null && snAuth.get("sn") == null) {
    		return null;
    	}
    	String dp = NullUtil.nullString( snAuth.get("dp") );
    	String sn = NullUtil.nullString( snAuth.get("sn") );

    	JnitcmsmbrVO companyVO = new JnitcmsmbrVO();
    	companyVO.setTypeId("30032");
    	companyVO.setDp((dp.equals("") ? "DP" : dp));
    	companyVO.setSn((dp.equals("") ? "SN" : sn));
    	int isUser = jnitcmsmbrService.selectJnitcmsmbrDpSnTot(companyVO);
    	
    	if(isUser > 0) {
    			companyVO = jnitcmsmbrService.selectJnitcmsmbrDpSn(companyVO);
    			model.addAttribute("msg", "사용중인 아이디는 <strong>"+NullUtil.nullString(companyVO.getMbrLogin())+"</strong>입니다.");
    	}else {
    			model.addAttribute("msg", "가입된 정보가 없습니다.");
    	}

    	return "jnit/msg";
	}

	@RequestMapping("/searchIdFind.do")
    public String searchIdFind(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {

		HashMap<String, String> snAuth = (HashMap)request.getSession().getAttribute("snAuth");
		if(snAuth != null){
			String dp = NullUtil.nullString( snAuth.get("dp") );
	    	String sn = NullUtil.nullString( snAuth.get("sn") );

	    	JnitcmsmbrVO companyVO = new JnitcmsmbrVO();
	    	companyVO.setTypeId("30032");
	    	companyVO.setDp(dp);
	    	int isUser = jnitcmsmbrService.selectJnitcmsmbrDpSnTot(companyVO);
	    	
	    	if(isUser > 0) {
	    			JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
	    			mbrVO.setDp(dp);
	    			mbrVO = jnitcmsmbrService.selectDpJnitcmsmbr(mbrVO);
	    			model.addAttribute("msg", "사용중인 아이디는 <strong>"+mbrVO.getMbrLogin()+"</strong>입니다.");
	    	}else {
	    			model.addAttribute("msg", "가입된 정보가 없습니다. 관리자에게 문의해 주시기 바랍니다.");
	    	}
	    	return "jnit/msg";
		}else{
			String mbrNm = NullUtil.nullString(request.getParameter("mbrNm"));
			String email = NullUtil.nullString(request.getParameter("email"));
			String mobile = NullUtil.nullString(request.getParameter("mobile"));

			JSONObject JSON = new JSONObject();
			JnitcmsmbrVO isUserVO = new JnitcmsmbrVO();
			isUserVO.setMbrNm(mbrNm);
			isUserVO.setEmail(email);
			isUserVO.setMobile(mobile);
			isUserVO.setSelectCondition("2");
			try {
				isUserVO = jnitcmsmbrService.selectJnitcmsmbr(isUserVO);
				JSON.put("message", "회원님의 아이디찾기 정보를 "+isUserVO.getEmail()+" 메일로 발송되었습니다.");
				AdminUtil.sendMail(isUserVO.getMbrNm(), isUserVO.getMbrLogin(), isUserVO.getEmail(), "email2.html", "회원님의 회원 아이디는 다음과 같습니다.", request);
			} catch (NullPointerException e){
				log.error(e.getMessage());
				JSON.put("message", "정보가 없습니다.");
			} catch (Exception e) {
				log.error(e.getMessage());
				JSON.put("message", "정보가 없습니다.");
			}
			model.addAttribute("json", JSON.toString());
			return "jnit/util/json";
		}
	}

	@RequestMapping("/searchPwFind.do")
    public String searchPwFind(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
		JSONObject JSON = new JSONObject();
		String mbrLogin = NullUtil.nullString(request.getParameter("mbrLogin"));
		String site = NullUtil.nullString(request.getParameter("site"));
		String contextPath = request.getSession().getServletContext().getContextPath().toString();


		HashMap<String, String> snAuth = (HashMap)request.getSession().getAttribute("snAuth");
		if(snAuth != null){
			String dp = NullUtil.nullString( snAuth.get("dp") );
	    	String sn = NullUtil.nullString( snAuth.get("sn") );

	    	JnitcmsmbrVO companyVO = new JnitcmsmbrVO();
	    	companyVO.setTypeId("30032");
	    	companyVO.setDp(dp);
	    	int isUser = jnitcmsmbrService.selectJnitcmsmbrDpSnTot(companyVO);

	    	if(isUser > 0) {
				JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
				mbrVO.setDp(dp);
				mbrVO = jnitcmsmbrService.selectDpJnitcmsmbr(mbrVO);
				JSON.put("status", "success");
				JSON.put("message", mbrVO.getMbrLogin());
	    	}else {
	    		JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
	    		mbrVO.setMbrLogin(mbrLogin);
	    		mbrVO.setSelectCondition("1");
	    		try {
	    			mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
	    		} catch (NullPointerException e){
	    			JSON.put("status", "error");
					JSON.put("message", "가입된 정보가 없습니다. 관리자에게 문의해 주시기 바랍니다.");
					model.addAttribute("json", JSON.toJSONString());
			    	return "/jnit/util/json";
				} catch (Exception e) {
					JSON.put("status", "error");
					JSON.put("message", "가입된 정보가 없습니다. 관리자에게 문의해 주시기 바랍니다.");
					model.addAttribute("json", JSON.toJSONString());
			    	return "/jnit/util/json";
				}
				if(mbrVO.getMbrId() != null){
					JSON.put("status", "error");
					JSON.put("message", "고유 식별 번호가 없는 회원입니다. 관리자에게 문의하여 비밀번호를 재설정해주시기 바랍니다.");
				}
	    	}
		}else{
			String mbrNm = NullUtil.nullString(request.getParameter("mbrNm"));
			String email = NullUtil.nullString(request.getParameter("email"));
			String mobile = NullUtil.nullString(request.getParameter("mobile"));

			JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
			mbrVO.setSelectCondition("3");
			mbrVO.setMbrLogin(mbrLogin);
			mbrVO.setMbrNm(mbrNm);
			mbrVO.setEmail(email);
			mbrVO.setMobile(mobile);
			try {
				mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
			} catch (NullPointerException e){
				log.error(e.getMessage());
				JSON.put("status", "error");
				JSON.put("message", "가입된 정보가 없습니다. 관리자에게 문의해 주시기 바랍니다.");
				model.addAttribute("json", JSON.toJSONString());
				return "/jnit/util/json";
			} catch (Exception e) {
				log.error(e.getMessage());
				JSON.put("status", "error");
				JSON.put("message", "가입된 정보가 없습니다. 관리자에게 문의해 주시기 바랍니다.");
				model.addAttribute("json", JSON.toJSONString());
				return "/jnit/util/json";
			}

			mbrVO.setUpdateCondition("4");
			mbrVO.setPasswd(EgovFileScrty.encryptPassword("1234"));

			if(!MbrpackageUtil.getMbrpackageExist("PACK_00001", mbrLogin)){
				jnitcmsmbrService.updateJnitcmsmbr(mbrVO);
				JSON.put("redirect", contextPath+"/"+site);
				JSON.put("status", "success");
				JSON.put("message", "비밀번호가 초기화 되었습니다. 초기비밀번호는 1234 입니다.");
			}else{
				JSON.put("status", "error");
				JSON.put("message", "가입된 정보가 없습니다. 관리자에게 문의해 주시기 바랍니다.");
			}
		}
    	model.addAttribute("json", JSON.toJSONString());
    	return "/jnit/util/json";
	}

	@RequestMapping("/searchPw.do")
    public String searchPw(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {

    	HttpSession sess = request.getSession();
    	HashMap<String, String> snAuth = new HashMap<String, String>();
    	snAuth = (HashMap)sess.getAttribute("snAuth");

    	if(snAuth.get("dp") == null && snAuth.get("sn") == null) {
    		return null;
    	}
    	String dp = NullUtil.nullString( snAuth.get("dp") );
    	String sn = NullUtil.nullString( snAuth.get("sn") );

    	JnitcmsmbrVO companyVO = new JnitcmsmbrVO();
    	companyVO.setTypeId("30032");
    	companyVO.setDp((dp.equals("") ? "DP" : dp));
    	companyVO.setSn((dp.equals("") ? "SN" : sn));
    	int isUser = jnitcmsmbrService.selectJnitcmsmbrDpSnTot(companyVO);
    	
    	if(isUser > 0) {
    			companyVO = jnitcmsmbrService.selectJnitcmsmbrDpSn(companyVO);
    			model.addAttribute("msg", "사용중인 아이디는 <strong>"+NullUtil.nullString(companyVO.getMbrLogin())+"</strong>입니다.");
    	}else {
    			model.addAttribute("msg", "가입된 정보가 없습니다.");
    	}

    	return "jnit/msg";
	}

	@RequestMapping("/total_login/login.do")
	public String logindo(HttpServletRequest request, ModelMap model)throws Exception{
		String sitePath = NullUtil.nullString(request.getParameter("sitePath"));
		String returnUrl = NullUtil.nullString(request.getParameter("returnUrl"));
		model.addAttribute("sitePath", sitePath);
		model.addAttribute("returnUrl", returnUrl);
		return "jnit/total_login/login";
	}
}