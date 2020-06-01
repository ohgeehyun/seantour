/**
 * @version 3.2.0.1
 */
package jnit.cms.mbr;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ibm.icu.util.Calendar;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import jnit.cms.CmsHelper;
import jnit.cms.config.ConfigUtil;
import jnit.cms.mbrlog.JnitcmsmbrlogService;
import jnit.cms.mbrsess.JnitcmsmbrsessService;
import jnit.cms.mbrsess.JnitcmsmbrsessVO;
import jnit.cms.mbrtype.JnitcmsmbrtypeService;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.db.JnitdbService;
import jnit.db.JnitdbVO;
import nl.captcha.Captcha;


@Controller
public class CmsSignupController {
	
	private Log log = LogFactory.getLog(getClass());
	
	private int limitSignupAge = 19;
	
	@Resource(name="jnitdbService")
    private JnitdbService jnitdbService;
	
	@Resource(name = "jnitcmsmbrtypeService")
	private JnitcmsmbrtypeService jnitcmsmbrtypeService;
	
    @Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;
    
	@Resource(name = "jnitcmsmbrsessService")
	private JnitcmsmbrsessService jnitcmsmbrsessService;
	
	@Resource(name = "jnitcmsmbrlogService")
	private JnitcmsmbrlogService jnitcmsmbrlogService;
	
	@Resource(name = "jnitcmssiteService")
	private JnitcmssiteService jnitcmssiteService;
	
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
    
    @RequestMapping("/mbr/signup.do")
    public String mbrSignup(		
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	JSONObject jsonObject = new JSONObject();
    	String site = NullUtil.nullString(request.getParameter("site"));
    	int stepInt = 0;
    	if(site.equals("")){
    		jsonObject.put("message", "site값이 없습니다.");    		
    	}
    	String step = NullUtil.nullString(request.getParameter("step"));
    	if(step.equals("")){
    		jsonObject.put("message", "step값이 없습니다.");    		
    	}else{
    		stepInt = Integer.parseInt(step);
    	}
//    	String returnView = "";
    	
    	if(stepInt != 0){
    		switch(stepInt) {
	    		case 1:
//	    			returnView = "jnit/mbr/signup_step1";
	    			jsonObject.put("step", "1");
	   			break;
	    		case 2:
//	    			returnView = "jnit/mbr/signup_step2";
	    			jsonObject.put("step", "2");
	   			break;
	    		case 3:
//	    			returnView = "jnit/mbr/signup_step3";
	    			jsonObject.put("step", "3");	    			
	   			break;
	    		case 4:
	    			jsonObject.put("step", "4");
	    		break;
	    		case 5:
	    			jsonObject.put("step", "5");
	    		break;	
    		}		
//    		model.addAttribute("site", site);
    		jsonObject.put("returnUrl", site);
    		
    	} 	
    	jsonObject.put("result", jsonObject.toJSONString());
    	return "jnit/mbr/redirect";
    }
    
    @RequestMapping("/mbr/modify.do")
    public String mbrSignup(
    		@RequestParam("site") String site,
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
		
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	if(NullUtil.nullString( loginVO.getMbrId() ).equals("")) {
    		return "jnit/mbr/modify";
    	}
    	
    	JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    	mbrVO.setMbrId(loginVO.getMbrId());
    	mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
    	
    	model.addAttribute("site", site);
    	model.addAttribute("mbrVO", mbrVO);
    	
    	return "jnit/mbr/modify";
    }
    
    @RequestMapping("/mbr/modify_savembr.do")
    public String mbrModifySave(
    		@RequestParam("site") String site,
    		@RequestParam("next") String next,
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	
    	model.addAttribute("site", site);

    	String mbrId = NullUtil.nullString(request.getParameter("mbrId"));
    	String passwd = NullUtil.nullString(request.getParameter("passwd"));
    	String passwdConfirm = NullUtil.nullString(request.getParameter("passwdConfirm"));
    	
    	String tel1 = NullUtil.nullString(request.getParameter("tel1"));
    	String tel2 = NullUtil.nullString(request.getParameter("tel2"));
    	String tel3 = NullUtil.nullString(request.getParameter("tel3"));
    	
    	String mobile1 = NullUtil.nullString(request.getParameter("mobile1"));
    	String mobile2 = NullUtil.nullString(request.getParameter("mobile2"));
    	String mobile3 = NullUtil.nullString(request.getParameter("mobile3"));
    	
    	String post = NullUtil.nullString(request.getParameter("post"));
    	//String post1 = NullUtil.nullString(request.getParameter("post1"));
    	//String post2 = NullUtil.nullString(request.getParameter("post2"));
    	String addr = NullUtil.nullString(request.getParameter("addr"));
    	//String addrDetail = NullUtil.nullString(request.getParameter("addrDetail"));
    	
    	//String addr2 = NullUtil.nullString(request.getParameter("addr2"));
    	//String addrDetail2 = NullUtil.nullString(request.getParameter("addrDetail2"));
    	
    	String email = NullUtil.nullString(request.getParameter("email"));
    	String homepage = NullUtil.nullString(request.getParameter("homepage"));
    	
    	int emailRecv = NullUtil.nullInt(request.getParameter("emailRecv"));
    	int smsRecv = NullUtil.nullInt(request.getParameter("smsRecv"));
    	
    	String establishment1 = NullUtil.nullString(request.getParameter("establishment1"));
    	String establishment2 = NullUtil.nullString(request.getParameter("establishment2"));
    	String establishment3 = NullUtil.nullString(request.getParameter("establishment3"));
    	String workContents = NullUtil.nullString(request.getParameter("workContents"));
    	String groupTitle = NullUtil.nullString(request.getParameter("groupTitle")); //회사명
    	String gradeNm = NullUtil.nullString(request.getParameter("gradeNm")); //직책 
    	
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	net.sf.json.JSONObject JSON = new net.sf.json.JSONObject();
    	
    	if(!"".equals(site)){
    		siteVO.setSitePath(site);
    		siteVO.setSelectCondition("1");
    		try {
    			siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
    			JSON = ConfigUtil.getProp(siteVO.getSiteId());
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
			} catch (Exception e) {
				if("true".equals(deDug)) log.debug(e.getMessage());
			}
    	} 
    	String ex01Msg1 = JSON.get("ex01")+" 입력이 누락되었습니다.";		
		String ex02Msg1 = JSON.get("ex02")+" 입력이 누락되었습니다.";		
		String ex03Msg1 = JSON.get("ex03")+" 입력이 누락되었습니다.";
		
    	JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	JSONObject jo = new JSONObject();
    	
    	//no script    	    	
    	String patten = "^[0-9]+$";
    	String patten2 = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[a-zA-Z]{2,4}$";
    	
    	if(!passwd.equals("")) { 
    		
    		if(passwd.equals("") || !passwd.equals(passwdConfirm)) {
        		model.addAttribute("alert", "비밀번호와 비밀번호확인이 다릅니다.");
        		return "jnit/util/alertCashBack";
        	}
        	String regexList = "!,@,#,$,%,^,&,*,(,),_,-,+,~,`,{,},<,>,?,:,\",;,'";
    		String[] regex = regexList.split(",");
    		Boolean regexbln = false;
    		for(int i=0; i<regex.length; i++){
    			if(passwd.indexOf(regex[i]) > -1){
    				regexbln = true;
    				break;
    			}
    		}
        	if(regexbln){
        		if(passwd.length() < 10 || passwd.length() > 16 || passwdConfirm.length() < 10 || passwdConfirm.length() > 16){
            		model.addAttribute("alert", "비밀번호는 영문, 숫자, 특수문자로 조합된 10~16자 이내로 입력해주시기 바랍니다.");
            		return "jnit/util/alertCashBack";
            	}else{
            		mbrVO.setPasswd(EgovFileScrty.encryptPassword(passwd));
            	}
        	}else{    		
        		model.addAttribute("alert", "특수문자 하나이상 포함해야합니다.");
        		return "jnit/util/alertCashBack";
        	}
    	}
    	
    	if(!"".equals(tel2) || !"".equals(tel3)){
			if(!MbrUtil.getPatten2(tel2, tel3, patten)){
    			model.addAttribute("alert", "전화번호 입력이 누락되었거나 숫자만을 입력해주시기 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
		}else if(Integer.parseInt(JSON.get("tel").toString()) == 2){
			if("".equals(tel2) || "".equals(tel3)){
				model.addAttribute("alert", "전화번호 입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}
		}
    	
    	if(!"".equals(mobile2) || !"".equals(mobile3)){
			if(!MbrUtil.getPatten2(mobile2, mobile3, patten)){
    			model.addAttribute("alert", "핸드폰 입력이 누락되었거나 숫자만을 입력해주시기 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
		}else if(Integer.parseInt(JSON.get("phone").toString()) == 2){
			if("".equals(mobile2) || "".equals(mobile3)){
				model.addAttribute("alert", "핸드폰 입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}			
		}
    	
    	if(!"".equals(email)){
			if(!MbrUtil.getPatten(email, patten2)){
    			model.addAttribute("alert", "이메일(E_mail)형식에 맞게 써주시기 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
		}else if(Integer.parseInt(JSON.get("email").toString()) == 2){
			if("".equals(email)){
				model.addAttribute("alert", "이메일입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}		
		}
    	
    	if(!"".equals(post)){
			if(!MbrUtil.getPatten(post, patten)){
    			model.addAttribute("alert", "우편번호 입력이 누락되었거나 숫자만을 입력해주시기 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
		}else if(Integer.parseInt(JSON.get("post").toString()) == 2){
			if("".equals(post)){
				model.addAttribute("alert", "우편번호 입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}			
		}
    	net.sf.json.JSONObject ex01JSON = MbrUtil.setEx01(request, JSON, patten, ex01Msg1);
		if(ex01JSON.get("alert") != null){
			model.addAttribute("alert", ex01JSON.get("alert"));
			return "jnit/util/alertCashBack";
		}else{
			mbrVO.setEx01(ex01JSON.get("ex01").toString());
		}
		
		net.sf.json.JSONObject ex02JSON = MbrUtil.setEx02(request, JSON, patten, ex02Msg1);
		if(ex02JSON.get("alert") != null){
			model.addAttribute("alert", ex02JSON.get("alert"));
			return "jnit/util/alertCashBack";
		}else{
			mbrVO.setEx02(ex02JSON.get("ex02").toString());
		}
		
		net.sf.json.JSONObject ex03JSON = MbrUtil.setEx03(request, JSON, patten, ex03Msg1);
		if(ex03JSON.get("alert") != null){
			model.addAttribute("alert", ex03JSON.get("alert"));
			return "jnit/util/alertCashBack";
		}else{
			mbrVO.setEx03(ex03JSON.get("ex03").toString());
		}
    	//end
    	
    	//주소    	
    	if(!addr.equals("")){
    		mbrVO.setAddress(addr);
    	}else if(Integer.parseInt(JSON.get("post").toString()) == 2){
    		if(!addr.equals("")){
    			model.addAttribute("alert", "주소 입력이 누락되었습니다.");
        		return "jnit/util/alertCashBack";
    		}
    	}
    	
    	if(Integer.parseInt(JSON.get("emailRecv").toString()) == 2){
    		if(emailRecv != 1){
    			model.addAttribute("alert", "메일수신동의를 선택해 주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
    		}
    	}
    	
    	if(Integer.parseInt(JSON.get("smsRecv").toString()) == 2){
    		if(smsRecv != 1){
    			model.addAttribute("alert", "sms수신동의를 선택해 주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
    		}
    	}
    	
    	mbrVO.setGroupTitle(groupTitle);
    	mbrVO.setWorkContents(workContents);
    	mbrVO.setGradeNm(gradeNm);
    	mbrVO.setEmail(!"".equals(email) ? email : null);
    	mbrVO.setTel((!"".equals(tel2) && !"".equals(tel3)) ? (tel1+"-"+tel2+"-"+tel3) : null);
    	mbrVO.setMobile((!"".equals(mobile2) && !"".equals(mobile3)) ? mobile1+"-"+mobile2+"-"+mobile3 : null);
    	mbrVO.setPostcode(post);
    	mbrVO.setEmailRecv((byte)emailRecv);
    	mbrVO.setSmsRecv((byte)smsRecv);
    	mbrVO.setHomepage(homepage);	
    	jnitcmsmbrService.updateJnitcmsmbr(mbrVO);
    	
    	jo.put("status", "okModify");
    	jo.put("site", site);
    	jo.put("next", next);    	
    	model.addAttribute("result", jo.toJSONString());
    	model.addAttribute("request", request);
    	
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	MbrUtil.insertMbrlog(request, mbrVO, loginVO, "수정", site, null);    	
    	return "jnit/mbr/redirect";
    }
    
    
    @RequestMapping("/mbr/signup_savembr.do")
    public String mbrSignupSave(@ModelAttribute("jnitcmsmbrVO") JnitcmsmbrVO jnitcmsmbrVO,
    		@RequestParam("site") String site,
    		@RequestParam("next") String next,
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	
    	model.addAttribute("site", site);
    	
    	String authType = NullUtil.nullString(request.getParameter("authType")); // 실명인증 / G-Pin / 공인인증 구분
    	String retType = NullUtil.nullString(request.getParameter("retType"));   //G-Pin인증후 14세 미만 회원일경우 	
    	if(authType.equals("si")){
    		authType = "30028"; //실명인증
    	}else if(authType.equals("gpin")){
    		if(retType.equals("kid")){
    			authType = "30017"; //14세 미만 회원 인증 
    		}else{
    			authType = "30029"; //G-Pin 인증
    		}
    		
    	}else if(authType.equals("sign")){
    		authType = "30031"; //공인인증 
    	}else{
    		authType = "30012"; //일반회원
    	}
    	JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    	
    	// 실명인증, GPIN -> 중복확인 키
    	String sn = "";
    	String dp = "";
    	String bd = "";
    	
    	HashMap<String, String> snAuth = (HashMap)request.getSession().getAttribute("snAuth");
    	if(snAuth != null) {
    		sn = (String)snAuth.get("sn");
    		dp = (String)snAuth.get("dp");
    		bd = (String)snAuth.get("bd");
    	}
    	
    	String siteId = NullUtil.nullString(request.getParameter("siteId"));
    	String mbrLogin = NullUtil.nullString(request.getParameter("mbrLogin"));
    	String mbrNm = NullUtil.nullString(request.getParameter("mbrNm"));
    	String passwd = NullUtil.nullString(request.getParameter("passwd"));
    	String passwdConfirm = NullUtil.nullString(request.getParameter("passwdConfirm"));
    	
    	String tel1 = NullUtil.nullString(request.getParameter("tel1"));
    	String tel2 = NullUtil.nullString(request.getParameter("tel2"));
    	String tel3 = NullUtil.nullString(request.getParameter("tel3"));
    	
    	String mobile1 = NullUtil.nullString(request.getParameter("mobile1"));
    	String mobile2 = NullUtil.nullString(request.getParameter("mobile2"));
    	String mobile3 = NullUtil.nullString(request.getParameter("mobile3"));
    	
    	String post = NullUtil.nullString(request.getParameter("post"));
    	//String post1 = NullUtil.nullString(request.getParameter("post1"));
    	//String post2 = NullUtil.nullString(request.getParameter("post2"));
    	String addr = NullUtil.nullString(request.getParameter("addr"));
    	//String addrDetail = NullUtil.nullString(request.getParameter("addrDetail"));
    	
    	//String addr2 = NullUtil.nullString(request.getParameter("addr2"));
    	//String addrDetail2 = NullUtil.nullString(request.getParameter("addrDetail2"));
    	
    	String email = NullUtil.nullString(request.getParameter("email"));
    	String homepage = NullUtil.nullString(request.getParameter("homepage"));    	
    	String workContents = NullUtil.nullString(request.getParameter("workContents"));
    	String groupTitle = NullUtil.nullString(request.getParameter("groupTitle")); //회사명
    	String gradeNm = NullUtil.nullString(request.getParameter("gradeNm")); //직책
    	
    	int IDCheck = NullUtil.nullInt(request.getParameter("IDCheck"));
    	int emailRecv = NullUtil.nullInt(request.getParameter("emailRecv"));
    	int smsRecv = NullUtil.nullInt(request.getParameter("smsRecv"));
    	
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	net.sf.json.JSONObject JSON = new net.sf.json.JSONObject();
    	
    	if(!"".equals(site)){
    		siteVO.setSitePath(site);
    		siteVO.setSelectCondition("1");
    		try {
    			siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
    			JSON = ConfigUtil.getProp(siteVO.getSiteId());
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
			} catch (Exception e) {
				if("true".equals(deDug)) log.debug(e.getMessage());
			}
    	}
    	String ex01Msg1 = JSON.get("ex01")+" 입력이 누락되었습니다.";		
		String ex02Msg1 = JSON.get("ex02")+" 입력이 누락되었습니다.";		
		String ex03Msg1 = JSON.get("ex03")+" 입력이 누락되었습니다.";
		
    	JSONObject jo = new JSONObject();    	
    	//no script
    	boolean match;
    	String patten = "^[0-9]+$";
    	String patten2 = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[a-zA-Z]{2,4}$";
    	
    	if(JSON.get("captcha").toString().equals("1")){
    		Captcha captcha = (Captcha) request.getSession().getAttribute(Captcha.NAME);
    		String answer = NullUtil.nullString(request.getParameter("answer"));
			if (captcha.isCorrect(answer)) {
				request.getSession().removeAttribute(Captcha.NAME);
			} else {
				model.addAttribute("alert", "자동가입 방지 입력값이 일치하지 않습니다.");
	    		return "jnit/util/alertCashBack";
			}
    	}
    	
    	if(mbrLogin.equals("")){
    		model.addAttribute("alert", "아이디를입력해주세요");
    		return "jnit/util/alertCashBack";
    	}
    	if(IDCheck == 0){
    		model.addAttribute("alert", "아이디 중복확인을 해주세요");
    		return "jnit/util/alertCashBack";
    	}
    	match =	java.util.regex.Pattern.matches("^[a-zA-Z0-9]*$", mbrLogin);   	
    	if(match == false){
    		model.addAttribute("alert", "아이디는 영문,숫자만 쓸 수 있습니다.");
    		return "jnit/util/alertCashBack";
    	}
    	
    	if(MbrUtil.limitNm(mbrLogin.toLowerCase())){
    		model.addAttribute("alert", "사용할수 없는 아이디입니다.");
    		return "jnit/util/alertCashBack";
    	}    	

    	if(passwd.equals("") || !passwd.equals(passwdConfirm)) {
    		model.addAttribute("alert", "비밀번호와 비밀번호확인이 다릅니다.");
    		return "jnit/util/alertCashBack";
    	}
    	String regexList = "!,@,#,$,%,^,&,*,(,),_,-,+,~,`,{,},<,>,?,:,\",;,'";
		String[] regex = regexList.split(",");
		Boolean regexbln = false;
		for(int i=0; i<regex.length; i++){			
			if(passwd.indexOf(regex[i]) > -1){
				regexbln = true;
				break;
			}
		}		
    	if(regexbln){
    		if(passwd.length() < 10 || passwd.length() > 16 || passwdConfirm.length() < 10 || passwdConfirm.length() > 16){
        		model.addAttribute("alert", "비밀번호는 영문, 숫자, 특수문자로 조합된 10~16자 이내로 입력해주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
        	}
    	}else{    		
    		model.addAttribute("alert", "특수문자 하나이상 포함해야합니다.");
    		return "jnit/util/alertCashBack";
    	}
    	
    	if(!mbrNm.equals("") && !mbrLogin.equals("") && !passwd.equals("")) {
    		mbrVO.setTypeId(authType);
    		mbrVO.setMbrNm(mbrNm);
    		mbrVO.setMbrLogin(mbrLogin);
    		mbrVO.setPasswd(EgovFileScrty.encryptPassword(passwd));
    	}else {    		
    		model.addAttribute("alert", "회원가입 필수정보가 누락되었습니다.");
    		return "jnit/util/alertCashBack";
    	}
    	
    	
    	if(!"".equals(tel2) || !"".equals(tel3)){
			if(!MbrUtil.getPatten2(tel2, tel3, patten)){
    			model.addAttribute("alert", "전화번호 입력이 누락되었거나 숫자만을 입력해주시기 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
		}else if(Integer.parseInt(JSON.get("tel").toString()) == 2){
			if("".equals(tel2) || "".equals(tel3)){
				model.addAttribute("alert", "전화번호 입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}
		}
    	
    	if(!"".equals(mobile2) || !"".equals(mobile3)){
			if(!MbrUtil.getPatten2(mobile2, mobile3, patten)){
    			model.addAttribute("alert", "핸드폰 입력이 누락되었거나 숫자만을 입력해주시기 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
		}else if(Integer.parseInt(JSON.get("phone").toString()) == 2){
			if("".equals(mobile2) || "".equals(mobile3)){
				model.addAttribute("alert", "핸드폰 입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}			
		}
    	
    	if(!"".equals(email)){
			if(!MbrUtil.getPatten(email, patten2)){
    			model.addAttribute("alert", "이메일(E_mail)형식에 맞게 써주시기 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
		}else if(Integer.parseInt(JSON.get("email").toString()) == 2){
			if("".equals(email)){
				model.addAttribute("alert", "이메일입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}		
		}    	
    	if(!"".equals(post)){
			if(!MbrUtil.getPatten(post,patten)){
    			model.addAttribute("alert", "우편번호 입력이 누락되었거나 숫자만을 입력해주시기 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
		}else if(Integer.parseInt(JSON.get("post").toString()) == 2){
			if("".equals(post)){
				model.addAttribute("alert", "우편번호 입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}			
		}
    	
    	
    	net.sf.json.JSONObject ex01JSON = MbrUtil.setEx01(request, JSON, patten, ex01Msg1);
		if(ex01JSON.get("alert") != null){
			model.addAttribute("alert", ex01JSON.get("alert"));
			return "jnit/util/alertCashBack";
		}else{
			mbrVO.setEx01(ex01JSON.get("ex01").toString());
		}
		
		net.sf.json.JSONObject ex02JSON = MbrUtil.setEx02(request, JSON, patten, ex02Msg1);
		if(ex02JSON.get("alert") != null){
			model.addAttribute("alert", ex02JSON.get("alert"));
			return "jnit/util/alertCashBack";
		}else{
			mbrVO.setEx02(ex02JSON.get("ex02").toString());
		}
		
		net.sf.json.JSONObject ex03JSON = MbrUtil.setEx03(request, JSON, patten, ex03Msg1);
		if(ex03JSON.get("alert") != null){
			model.addAttribute("alert", ex03JSON.get("alert"));
			return "jnit/util/alertCashBack";
		}else{
			mbrVO.setEx03(ex03JSON.get("ex03").toString());
		}
    	//end
    	
    	//주소    	
    	if(!addr.equals("")){
    		mbrVO.setAddress(addr);
    		
    	}else if(Integer.parseInt(JSON.get("post").toString()) == 2){
    		if(!addr.equals("")){
    			model.addAttribute("alert", "구주소 입력이 누락되었습니다.");
        		return "jnit/util/alertCashBack";
    		}
    	}
    	
    	if(Integer.parseInt(JSON.get("emailRecv").toString()) == 2){
    		if(emailRecv != 1){
    			model.addAttribute("alert", "메일수신동의를 선택해 주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
    		}
    	}
    	
    	if(Integer.parseInt(JSON.get("smsRecv").toString()) == 2){
    		if(smsRecv != 1){
    			model.addAttribute("alert", "sms수신동의를 선택해 주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
    		}
    	}
    	
    	mbrVO.setGroupTitle(groupTitle);
    	mbrVO.setWorkContents(workContents);
    	mbrVO.setGradeNm(gradeNm);
    	mbrVO.setSiteId(siteId);
    	mbrVO.setEmail(!"".equals(email) ? email : null);
    	mbrVO.setTel((!"".equals(tel2) && !"".equals(tel3)) ? (tel1+"-"+tel2+"-"+tel3) : null);
    	mbrVO.setMobile((!"".equals(mobile2) && !"".equals(mobile3)) ? mobile1+"-"+mobile2+"-"+mobile3 : null);
    	mbrVO.setPostcode(post);    	
    	mbrVO.setHomepage(homepage);
    	mbrVO.setEmailRecv((byte)emailRecv);
    	mbrVO.setSmsRecv((byte)smsRecv);
    	mbrVO.setSn(sn);
    	
    	try {
    		mbrVO.setDp(NullUtil.nullString(snAuth.get("dp")));
    	} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		String id = "";
		String typeId = "";
		JnitcmsmbrVO selectVO = new JnitcmsmbrVO();
    	JnitcmsmbrVO mbrTypeIdVO = new JnitcmsmbrVO();
    	
		if(!"".equals(dp)){
			JnitcmsmbrDefaultVO dpSearchVO = new JnitcmsmbrDefaultVO();
	    	dpSearchVO.setSearchCondition("10");    	
	    	dpSearchVO.setSearchKeyword(NullUtil.nullString(snAuth.get("dp")));
	    	dpSearchVO.setSearchUseYn("Y");
	    	
	    	if(!NullUtil.nullString(bd).equals("")) {
	    		Calendar cal = Calendar.getInstance();
		    	if(((cal.get(Calendar.YEAR))-Integer.valueOf(bd.substring(0,4))) < limitSignupAge) {
		    		model.addAttribute("alert", "만19세 이상 고객만 가입가능합니다.");
		    		return "jnit/util/alertCashBack";
		    	}
	    	}	
	    	
	    	int isDp = jnitcmsmbrService.selectJnitcmsmbrListTotCnt(dpSearchVO);    	
	    	if(isDp != 0){
	    		selectVO.setDp(NullUtil.nullString(snAuth.get("dp")));         	
	        	mbrTypeIdVO = jnitcmsmbrService.selectDpJnitcmsmbr(selectVO);
	        	typeId = NullUtil.nullString(mbrTypeIdVO.getTypeId());
	    	}
	    	
	    	if(isDp > 0 && !dp.equals("")) {	    		
	    		if(typeId.equals("30031") || typeId.equals("30029") || typeId.equals("30028")){
	    			model.addAttribute("alert", "이미 가입된 사용자입니다.");
	    			return "jnit/util/alertCashBack";
	    		}
	    	}
		}else{			 
			JnitcmsmbrVO isUserVO = new JnitcmsmbrVO();
			isUserVO.setSearchKeyword(mbrLogin);
			isUserVO.setSearchKeyword1(email);
			isUserVO.setSearchKeyword2(mobile1+"-"+mobile2+"-"+mobile3);
			isUserVO.setSearchCondition("21");
			int isUser = jnitcmsmbrService.selectJnitcmsmbrListTotCnt(isUserVO);
			if(isUser > 0) {	    		
    			model.addAttribute("alert", "이미 가입된 사용자입니다.");
    			return "jnit/util/alertCashBack";
	    	}
		}
		
    	
    	if(typeId.equals("30013") || typeId.equals("30014") || typeId.equals("30015")){     //임시가입자 가입신청 30013(공인인증 비회원) / 30014(G-pin 비회원) / 30015(실명인증 비회원)
    		mbrVO.setMbrId(mbrTypeIdVO.getMbrId());
    		jnitcmsmbrService.updateTempmbr(mbrVO);    		
    		if(request.getSession().getAttribute("loginVO") != null){
    			request.getSession().setAttribute("loginVO", null);	
    		}    		    		
    	}else{        //일반 가입신청
    		mbrVO.setGrpConfirm("N");
    		id = jnitcmsmbrService.insertJnitcmsmbr(mbrVO);
    		mbrVO.setMbrId(id);
    	}
    	
    	if(typeId.equals("30031") || typeId.equals("30029") || typeId.equals("30028")){
    		if(NullUtil.nullString(id).equals("")) {        		
        		model.addAttribute("alert", "이미 사용중인 아이디입니다.");
        		return "jnit/util/alertCashBack";
        	}
    	}    	
    	jo.put("status", "ok");    	
    	jo.put("site", site);
    	jo.put("next", next);
    	
    	request.getSession().setAttribute("snAuth", null); //정상적으로 처리될시 공인인증 세션제거
    	model.addAttribute("result", jo.toJSONString());
    	model.addAttribute("request", request);

    	MbrUtil.insertMbrlog(request, mbrVO, mbrVO,"가입", site, null);
    	return "jnit/mbr/redirect";
    }
    
    @RequestMapping("/mbr/idcheck.do")
    public String mbrIdCheck(
    		@RequestParam("site") String site,
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	
    	model.addAttribute("site", site);
    	
    	JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    	String mbrLogin = NullUtil.nullString(request.getParameter("mbrLogin"));
    	mbrVO.setMbrLogin(mbrLogin);
    	
    	JSONObject jo = new JSONObject();
    	
    	if(mbrLogin.equals("")) {
    		jo.put("status", "error");
    		jo.put("message", "아이디를 입력하세요.");
    		model.addAttribute("result", jo.toJSONString());
    		return "jnit/mbr/result";    		
    	}
    	
    	if(jnitcmsmbrService.hasJnitcmsmbr(mbrVO) == true) {
    		jo.put("status", "error");
    		jo.put("message", "이미 사용중인 아이디입니다.");
    		model.addAttribute("result", jo.toJSONString());
    		return "jnit/mbr/result";
    	}
    	
    	if(mbrLogin.toLowerCase().equals("admin") || mbrLogin.toLowerCase().equals("test") || mbrLogin.toLowerCase().equals("테스트") || mbrLogin.toLowerCase().equals("guest")){
    		jo.put("status", "error");
    		jo.put("message", "사용할수 없는 아이디입니다.");
    		model.addAttribute("result", jo.toJSONString());
    		return "jnit/mbr/result";
    	}

    	jo.put("status", "ok");
    	jo.put("message", "사용 가능한 아이디입니다.");
    	model.addAttribute("result", jo.toJSONString());
    	return "jnit/mbr/result";
    }
    
    @RequestMapping("/mbr/searchidpw.do")
    public String mbrSearchIdpw(
    		@RequestParam("site") String site,
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	
    	model.addAttribute("site", site);
    	
    	return "jnit/mbr/search_idpw";
    }
    
    @RequestMapping("/mbr/searchidpwres.do")
    public String mbrSearchIdpwRes(
    		@RequestParam("site") String site,
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	
    	model.addAttribute("site", site);
    	
    	String mbrNm = NullUtil.nullString(request.getParameter("mbrNm"));
    	String email = NullUtil.nullString(request.getParameter("email"));
    	    	
    	JnitcmsmbrDefaultVO searchVO = new JnitcmsmbrDefaultVO();
    	searchVO.setSearchCondition("9");
    	searchVO.setFirstIndex(0);
    	searchVO.setRecordCountPerPage(1);
    	searchVO.setSchMbrNm(mbrNm);
    	searchVO.setSchEmail(email);
    	
    	List schResult = jnitcmsmbrService.selectJnitcmsmbrList(searchVO);
    	if(schResult.size() > 0) {
    		EgovMap mbrMap = (EgovMap)schResult.get(0);
    		model.addAttribute("success", "OK");
    		model.addAttribute("mbrMap", mbrMap);
    	}else {
    		model.addAttribute("success", "FAIL");
    	}

    	return "jnit/mbr/search_idpwres";
    }
    
    @RequestMapping("/mbr/isMbrSn.do")
    public String mbrIsSN(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {    	
    	String next = NullUtil.nullString(request.getParameter("next"));
    	String returnUrl = NullUtil.nullString(request.getParameter("returnUrl"));
    	String checkIn = NullUtil.nullString(request.getParameter("checkIn"));
    	String checkout = NullUtil.nullString(request.getParameter("checkout"));
    	JSONObject jsonObject = new JSONObject();
    	HashMap<String, String> snAuth = (HashMap)request.getSession().getAttribute("snAuth");    	
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);   	
    	    	
    	//로그인체크
    	if(checkout.equals("myPage")){ 
    		if(loginVO.getMbrId() == null ){
    			model.addAttribute("result", "FAIL6"); // 로그인을 해주시기 바랍니다.
    			jsonObject.put("message", "FAIL6");
    			jsonObject.put("returnUrl", returnUrl);
    	    	jsonObject.put("next", next);    	
    	    	model.addAttribute("result", jsonObject.toString());
    			if(checkIn.equals("")){
    	    		return "jnit/mbr/redirect";	
    	    	}else{
    	    		return "jnit/mbr/result";
    	    	}
    		}else{
    			model.addAttribute("result", "OK");
    			jsonObject.put("message", "OK");
    		}
		}    	
    	//인증체크
    	if( snAuth != null) {
    		JnitdbVO dbVO = new JnitdbVO();
        	dbVO.setQuery("SELECT COUNT(*) as cnt FROM JNITCMSMBR WHERE TYPE_ID!='30032' AND DP='"+NullUtil.nullString(snAuth.get("dp"))+"' AND ISDEL=0");
        	int isUser = jnitdbService.selectCnt(dbVO);
        	
	    	JnitcmsmbrDefaultVO searchVO = new JnitcmsmbrDefaultVO();
	    	searchVO.setSearchCondition("10");
	    	searchVO.setSearchKeyword((String)snAuth.get("dp"));
	    	searchVO.setSearchUseYn("Y");
	    	String signParam = NullUtil.nullString((String) snAuth.get("signParam"));
	    	if(signParam.equals("3") == false){
	    		if(!NullUtil.nullString(snAuth.get("bd").toString()).equals("")) { //snAuth.get("bd").toString()
		    		Date today = new Date();
			    	if(((today.getYear()+1900)-Integer.valueOf(snAuth.get("bd").toString().substring(0,4))) < limitSignupAge) {
			    		model.addAttribute("result", "FAIL0"); //만19세 이상 고객만 가입가능합니다.
			    		jsonObject.put("message", "FAIL0");
			    		return "jnit/mbr/result";
			    	}
		    	}
	    	}	    	
	    	if(isUser != 0 ) {    //jnitcmsmbrService.selectJnitcmsmbrListTotCnt(searchVO) > 0
	    		JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
	    		mbrVO.setDp(NullUtil.nullString(snAuth.get("dp")));
	    		JnitcmsmbrVO mbrTypeIdVO = jnitcmsmbrService.selectDpJnitcmsmbr(mbrVO);
	    		String typeId = NullUtil.nullString(mbrTypeIdVO.getTypeId());
	    		
	    		if(checkout.equals("myPage")){
	    			if(typeId.equals("30013") || typeId.equals("30014") || typeId.equals("30015")){
	    				model.addAttribute("result", "FAIL7");
			    		jsonObject.put("message", "FAIL7"); //비회원 로그인은 회원가입을 해주시기 바랍니다.
	    			}
	    		}else{	    			
	    			model.addAttribute("result", "FAIL1");
		    		jsonObject.put("message", "FAIL1"); //이미 가입된 사용자입니다.	    			
	    		}	    		
	    	}else{    			    			
				model.addAttribute("result", "OK");
				jsonObject.put("message", "OK");	    		
	    	}
    	}else {
    		if(checkout.equals("myPage") == false){
    			model.addAttribute("result", "FAIL2"); //실명인증 후 이용하세요.
           		jsonObject.put("message", "FAIL2");
    		}   			    		    		
    	}
    	jsonObject.put("returnUrl", returnUrl);
    	jsonObject.put("next", next);
    	String url = request.getRequestURL().toString();
    	if(StringUtil.isExistString(url, "local")) jsonObject.put("contextPath", url);
    	model.addAttribute("result", jsonObject.toString());
    	
    	if(checkIn.equals("")){
    		return "jnit/mbr/redirect";	
    	}else{
    		return "jnit/mbr/result";
    	}    	
    }
    
    @RequestMapping("/mbr/isMbr.do")
    public String mbrIs(
    		@RequestParam("mbrLogin") String mbrLogin,
    		@RequestParam("passwd") String passwd,
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	    	
    	HashMap snAuth = (HashMap)request.getSession().getAttribute("snAuth");
    	
    	JnitcmsmbrDefaultVO searchVO = new JnitcmsmbrDefaultVO();
    	searchVO.setSearchUseYn("Y");
    	searchVO.setSearchKeyword(mbrLogin);
    	if(snAuth == null ) {
	    	searchVO.setSearchCondition("11");
	    	if( jnitcmsmbrService.selectJnitcmsmbrListTotCnt(searchVO) > 0) {
	    		model.addAttribute("result", "FAIL1");
	    		return "jnit/mbr/result";
	    	}
	    	
	    	searchVO.setSearchCondition("12");
	    	if( jnitcmsmbrService.selectJnitcmsmbrListTotCnt(searchVO) > 0) {
	    		model.addAttribute("result", "FAIL2");
	    		return "jnit/mbr/result";
	    	}
	    	
	    	searchVO.setSearchCondition("13");
	    	if( jnitcmsmbrService.selectJnitcmsmbrListTotCnt(searchVO) > 0) {
	    		model.addAttribute("result", "FAIL3");
	    		return "jnit/mbr/result";
	    	}
	    	
	    	model.addAttribute("result", "OK1");
    	}else {
    		/*
	    	searchVO.setSearchCondition("14");
	    	searchVO.setSchMbrNm((String)snAuth.get("nm"));
	    	if( jnitcmsmbrService.selectJnitcmsmbrListTotCnt(searchVO) == 0) {
	    		model.addAttribute("result", "FAIL4");
	    		return "jnit/mbr/result";
	    	}else {
	    		JnitcmsmbrVO tmpMbrVO = new JnitcmsmbrVO();
    			tmpMbrVO.setSearchCondition("14");
    			tmpMbrVO.setSearchKeyword(mbrLogin);
	    		tmpMbrVO.setSchMbrNm(searchVO.getSchMbrNm());
	    		tmpMbrVO.setMbrLogin(mbrLogin);
	    		try {
	    			tmpMbrVO = jnitcmsmbrService.chkLogin(tmpMbrVO);
	    			tmpMbrVO.setPasswd(EgovFileScrty.encryptPassword(passwd));
	    			tmpMbrVO.setDp(snAuth.get("dp").toString());
	    			tmpMbrVO.setSn(snAuth.get("sn").toString());
	    			tmpMbrVO.setMbrNm(snAuth.get("nm").toString());
	    			jnitcmsmbrService.updateJnitcmsmbr(tmpMbrVO);
	    		}catch(Exception e) {
		    		model.addAttribute("result", "FAIL5");
		    		return "jnit/mbr/result";
	    		}
	    	}
	    	*/    		
    		
        	String dp = NullUtil.nullString( (String) snAuth.get("dp") );        	
        	JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
			mbrVO.setDp(dp);
			mbrVO = jnitcmsmbrService.selectDpJnitcmsmbr(mbrVO);			
			mbrVO.setPasswd(EgovFileScrty.encryptPassword(passwd));       	
			jnitcmsmbrService.updateJnitcmsmbr(mbrVO);
	    	request.getSession().removeAttribute("snAuth");
			model.addAttribute("result", "OK");
    	}
		
    	return "jnit/mbr/result";
    }
    
    /**
     * 
     * @param site
     * @param next
     * @param request
     * @param model
     * @return
     * @throws Exception
     * @{@link CmsManageSub2_1Controller #mbrDelete(JnitcmsmbrVO, HttpServletRequest, ModelMap)} //cms 회원탈퇴
     */
    @RequestMapping("/mbr/leave_out.do")
    public String mbrLeaveOut (
    		@RequestParam("site") String site,
    		@RequestParam("next") String next,
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	
    	JSONObject jo = new JSONObject();
    	String passwd = NullUtil.nullString(request.getParameter("passwd"));
    	HashMap snAuth = (HashMap)request.getSession().getAttribute("snAuth");
    	
    	JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	
    	if(!passwd.equals("")) {
	    	if(!mbrVO.getPasswd().equals(EgovFileScrty.encryptPassword(passwd))) {
	    		jo.put("status", "error");
	    		jo.put("message", "비밀번호가 일치하지 않습니다.");
	    		model.addAttribute("result", jo.toJSONString());
	    		return "jnit/mbr/result";
	    	}
    	}else{
    		jo.put("status", "error");
    		jo.put("message", "비밀번호를 입력해 주세요.");
    		model.addAttribute("result", jo.toJSONString());
    		return "jnit/mbr/result";
    	}
    	JnitcmsmbrVO typeVO = (JnitcmsmbrVO)request.getSession().getAttribute("loginVO");
    	String typeId = NullUtil.nullString(typeVO.getTypeId());    	
    	if(typeId.equals("30020")){
    		jo.put("status", "error");
    		jo.put("message", "관리자는 탈퇴할수 없습니다.");
    		model.addAttribute("result", jo.toJSONString());
    		return "jnit/mbr/result";
    	}    	
    	
        // 로그인 Lock 해제
    	try {
	    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)request.getSession().getAttribute("loginVO");
	        JnitcmsmbrsessVO mbrsessVO = new JnitcmsmbrsessVO();
	        mbrsessVO.setMbrId(loginVO.getMbrId());
	        mbrsessVO = jnitcmsmbrsessService.selectJnitcmsmbrsess(mbrsessVO);
	        mbrsessVO.setSessLock(BigDecimal.valueOf(0));
	    	jnitcmsmbrsessService.updateJnitcmsmbrsess(mbrsessVO);
    	} catch (NullPointerException e){
    		request.getSession().setAttribute("loginVO", null);
    		jo.put("status", "error");
    		jo.put("message", "ERROR 01");
    		return "jnit/mbr/result";
    	}catch(Exception e) {
    		request.getSession().setAttribute("loginVO", null);
    		jo.put("status", "error");
    		jo.put("message", "ERROR 01");
    		return "jnit/mbr/result";
    	}finally {
    		request.getSession().setAttribute("loginVO", null);
    		if(snAuth != null){
    			request.getSession().setAttribute("snAuth", null); //인증서정보가 남아 있을시 세션제거한다.
    		}
    	}
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	MbrUtil.insertMbrlog(request, mbrVO, loginVO,"탈퇴", site, null);    	
    	
    	//mbrVO.setOldId(mbrVO.getMbrLogin());    	    	
    	mbrVO.setMbrLogin(mbrVO.getMbrId());//MbrLogin으로 할 경우 한 사용자가 여러번 탈퇴할경우 제약조건 위배됨.
    	mbrVO.setOrgId(null);
    	mbrVO.setPosId(null);
    	mbrVO.setPasswd("#"+mbrVO.getMbrId());
    	//mbrVO.setMbrNm("#"+mbrVO.getMbrNm());
    	mbrVO.setMbrNm(mbrVO.getMbrId());
    	mbrVO.setTypeId("30016");//탈퇴회원
    	mbrVO.setTel("");
    	mbrVO.setMobile("");
    	mbrVO.setEmail("");
    	mbrVO.setHomepage("");
    	mbrVO.setPostcode("");
    	mbrVO.setAddress("");
    	mbrVO.setEmailRecv((byte)0);
    	mbrVO.setSmsRecv((byte)0);
    	mbrVO.setSn("");
    	mbrVO.setDp("");
    	
    	try {
    		//mbrVO.setUpdateCondition("2");
    		//jnitcmsmbrService.updateJnitcmsmbr(mbrVO);    		
    		jnitcmsmbrService.leaveJnitcmsmbr(mbrVO);
    		
    		//mbrVO.setIsdelYn("N");
    		//jnitcmsmbrService.deleteJnitcmsmbr(mbrVO);
    	} catch (NullPointerException e){
    		log.error(e.getMessage());
    		//request.getSession().setAttribute("loginVO", null);
    		jo.put("status", "error");
    		jo.put("message", "ERROR 02");
    		return "jnit/mbr/result";
    	}catch(Exception e) {
    		log.error(e.getMessage());
    		//request.getSession().setAttribute("loginVO", null);
    		jo.put("status", "error");
    		jo.put("message", "ERROR 02");
    		return "jnit/mbr/result";
    	}
    	
    	jo.put("status", "ok");
    	jo.put("message", "탈퇴요청이 정상적으로 처리되었습니다.");
    	jo.put("site", site);
    	jo.put("next", next);
    	
    	model.addAttribute("result", jo.toJSONString());
    	model.addAttribute("request", request);
    	
    	return "jnit/mbr/result";
    }
    
    @RequestMapping("/mbr/CheckType.do")
    public String CheckType(HttpServletRequest request, ModelMap model)throws Exception{
    	String type = NullUtil.nullString(request.getParameter("type"));
    	
    	String establishment1 = NullUtil.nullString(request.getParameter("establishment1"));
    	String establishment2 = NullUtil.nullString(request.getParameter("establishment2"));
    	String establishment3 = NullUtil.nullString(request.getParameter("establishment3"));
    	
    	String corporation1 = NullUtil.nullString(request.getParameter("corporation1"));
    	String corporation2 = NullUtil.nullString(request.getParameter("corporation2"));    	
    	
    	
    	String primaryKey1 = NullUtil.nullString(request.getParameter("primaryKey1"));
    	String primaryKey2 = NullUtil.nullString(request.getParameter("primaryKey2"));
    	String primaryKey3 = NullUtil.nullString(request.getParameter("primaryKey3"));
    	
    	String establishment  = "";
    	String corporation = "";
    	String primaryKey = "";
    	String status ="";
    	String Patten = "^[0-9]+$";
    	
    	JSONObject jsonObject = new JSONObject();    	
    	JnitcmsmbrDefaultVO searchVO = new JnitcmsmbrDefaultVO();
    	JnitcmsmbrVO typeVO = new JnitcmsmbrVO();
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);     	
    	
    	//유효성검사
    	if(type.equals("개인")){
    		
    		 if(MbrUtil.getPatten3(establishment1, establishment2, establishment3, Patten)){
    			 establishment = establishment1 + "-" + establishment2 + "-" + establishment3;
    			 if(!NullUtil.nullString(loginVO.getEstablishment()).equals(establishment)){ //회원정보와 다른값이 입력될시
    				 searchVO.setEstablishment(establishment);  //setEstablishment
    			 }
    		 }else{
    			 jsonObject.put("status", "error");
    			 jsonObject.put("message", "사업자 번호가  누락되었거나 숫자만 입력해주시기 바랍니다.");
    			 model.addAttribute("result", jsonObject.toJSONString());
    			 return "jnit/mbr/result";
    		 }
    		 
    	}else if(type.equals("영리")){
    		
    		if(MbrUtil.getPatten3(establishment1, establishment2, establishment3, Patten)){
	   			establishment = establishment1 + "-" + establishment2 + "-" + establishment3;
		   		if(!NullUtil.nullString(loginVO.getEstablishment()).equals(establishment)){ //회원정보와 다른값이 입력될시
		   			searchVO.setEstablishment(establishment);  //setEstablishment
		   		}
	   		}else{
	   			jsonObject.put("status", "error");
	   			jsonObject.put("message", "사업자 번호가  누락되었거나 숫자만 입력해주시기 바랍니다.");
	   			model.addAttribute("result", jsonObject.toJSONString());
	   			return "jnit/mbr/result";
	   		}
    		
    		if(MbrUtil.getPatten2(corporation1, corporation2, Patten)){
    			corporation = corporation1 + "-" + corporation2;
    			if(!NullUtil.nullString(loginVO.getCorporation()).equals(corporation)){ //회원정보와 다른값이 입력될시
    				searchVO.setCorporation(corporation); //setCorporation
       			}
    		}else{
    			jsonObject.put("status", "error");
	   			jsonObject.put("message", "법인등록번호가  누락되었거나 숫자만 입력해주시기 바랍니다.");
	   			model.addAttribute("result", jsonObject.toJSONString());
	   			return "jnit/mbr/result";
    		}
    		
    	}else if(type.equals("비영리")){    		
    		
    		if(MbrUtil.getPatten3(establishment1, establishment2, establishment3, Patten)){
	      		establishment = establishment1 + "-" + establishment2 + "-" + establishment3;
	      		if(!NullUtil.nullString(loginVO.getEstablishment()).equals(establishment)){ //회원정보와 다른값이 입력될시
	      			searchVO.setEstablishment(establishment);  //setEstablishment
	       		}
   	   		}else{
	   	   		jsonObject.put("status", "error");
	   	   		jsonObject.put("message", "사업자 번호가  누락되었거나 숫자만 입력해주시기 바랍니다.");
	   	   		model.addAttribute("result", jsonObject.toJSONString());
	   	   		return "jnit/mbr/result";
   	   		}
    		if(MbrUtil.getPatten2(corporation1, corporation2, Patten)){
    			corporation = corporation1 + "-" + corporation2;
    			if(!NullUtil.nullString(loginVO.getCorporation()).equals(corporation)){ //회원정보와 다른값이 입력될시
    				searchVO.setCorporation(corporation); //setCorporation
       			}
    		}else{
    			jsonObject.put("status", "error");
	   			jsonObject.put("message", "법인등록번호가  누락되었거나 숫자만 입력해주시기 바랍니다.");
	   			model.addAttribute("result", jsonObject.toJSONString());
	   			return "jnit/mbr/result";
    		}
       		if(MbrUtil.getPatten3(primaryKey1, primaryKey2, primaryKey3, Patten)){
       			primaryKey = primaryKey1 + "-" + primaryKey2 + "-" + primaryKey3;
       			if(!NullUtil.nullString(loginVO.getPrimaryKey()).equals(primaryKey)){ //회원정보와 다른값이 입력될시
       				searchVO.setSearchKeyword2(primaryKey); //setPrimaryKey
       			}
       		}else{
       			jsonObject.put("status", "error");
   	   			jsonObject.put("message", "고유번호가  누락되었거나 숫자만 입력해주시기 바랍니다.");
   	   			model.addAttribute("result", jsonObject.toJSONString());
   	   			return "jnit/mbr/result";
       		}
    	}else if(type.equals("공식")){    		
    		if(MbrUtil.getPatten3(primaryKey1, primaryKey2, primaryKey3, Patten)){
       			primaryKey = primaryKey1 + "-" + primaryKey2 + "-" + primaryKey3;
       			if(!NullUtil.nullString(loginVO.getPrimaryKey()).equals(primaryKey)){ //회원정보와 다른값이 입력될시
       				searchVO.setSearchKeyword2(primaryKey); //setPrimaryKey
       			}
       		}else{
       			jsonObject.put("status", "error");
   	   			jsonObject.put("message", "고유번호가  누락되었거나 숫자만 입력해주시기 바랍니다.");
   	   			model.addAttribute("result", jsonObject.toJSONString());
   	   			return "jnit/mbr/result";
       		}
    	}
    	int checkEstablishment = 0;
    	int checkCorporation = 0;
    	int checkPrimaryKey = 0;
		
    	//회원정보와 다른값이 입력될시 사업자번호, 법인등록번호,고유번호 중복검사 
    	if(!NullUtil.nullString(searchVO.getEstablishment()).equals("")){ 
    		searchVO.setSearchCondition("1");
    		checkEstablishment = jnitcmsmbrService.selectListTotCnt(searchVO); //사업자
    	}    	
    	if(!NullUtil.nullString(searchVO.getCorporation()).equals("")){
    		searchVO.setSearchCondition("2");
    		checkCorporation = jnitcmsmbrService.selectListTotCnt(searchVO); //법인등록번호
    	}
    	if(!NullUtil.nullString(searchVO.getPrimaryKey()).equals("")){
    		searchVO.setSearchCondition("3");
    		checkPrimaryKey = jnitcmsmbrService.selectListTotCnt(searchVO); // 고유번호
    	}
    	if(checkEstablishment > 0){    		
    		jsonObject.put("status", "error");
    		jsonObject.put("message", "입력하신 사업자번호는 이미 가입된 번호가 있습니다.");
    		model.addAttribute("result", jsonObject.toJSONString());
			return "jnit/mbr/result";
    	}
    	if(checkCorporation > 0){    		
    		jsonObject.put("status", "error");
    		jsonObject.put("message", "입력하신 법인등록번호는 이미 가입된 번호가 있습니다.");
    		model.addAttribute("result", jsonObject.toJSONString());
    		return "jnit/mbr/result";
    	}
    	if(checkPrimaryKey > 0){    		
    		jsonObject.put("status", "error");
    		jsonObject.put("message", "입력하신 고유번호는 이미 가입된 번호가 있습니다.");
    		model.addAttribute("result", jsonObject.toJSONString());
    		return "jnit/mbr/result";
    	}
    	
    	JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
		if(!establishment.equals("")){
			mbrVO.setEstablishment(establishment);
			typeVO = jnitcmsmbrService.selectDpJnitcmsmbr(mbrVO);
		}
		if(typeVO != null){
			String typeId = NullUtil.nullString(typeVO.getTypeId());
			
			if(typeId.equals("30031") || typeId.equals("30028") || typeId.equals("30029")){ //비회원 로그인 가입신청시 30031(공인인증) / 30028(실명인증) / 30029(G-pin 인증)
				jsonObject.put("status", "error");
	    		jsonObject.put("message", "이미 등록된 번호가 있습니다.");
	    		model.addAttribute("result", jsonObject.toJSONString());
	    		return "jnit/mbr/result";
			}else{
				jsonObject.put("status", "ok");
				jsonObject.put("message", "사용가능한 번호입니다.");
	    		model.addAttribute("result", jsonObject.toJSONString());
			}
		}
		
		
    	jsonObject.put("status", "ok");
		jsonObject.put("message", "사용가능한 번호입니다.");
		model.addAttribute("result", jsonObject.toJSONString());
		
    	return "jnit/mbr/result"; //return jsonObject.toJSONString;
    }
    @RequestMapping("/mbr/signup_groupSave.do")
    public String groupSave(HttpServletRequest request, ModelMap model)throws Exception{
    	String authType = NullUtil.nullString(request.getParameter("authType")); // 실명인증 / G-Pin / 공인인증 구분
    	
    	String site = NullUtil.nullString(request.getParameter("site"));
    	String next = NullUtil.nullString(request.getParameter("next"));    	
    	
    	String type = NullUtil.nullString(request.getParameter("groupType"));
    	String groupId = NullUtil.nullString(request.getParameter("groupId"));
    	
    	String groupNm = NullUtil.nullString(request.getParameter("groupNm"));
    	String groupTitle = NullUtil.nullString(request.getParameter("groupTitle"));
    	String groupPasswd = NullUtil.nullString(request.getParameter("groupPasswd"));
    	String groupPasswdconfrim = NullUtil.nullString(request.getParameter("groupPasswdConfrim"));
    	
    	String tel1 = NullUtil.nullString(request.getParameter("tel1"));
    	String tel2 = NullUtil.nullString(request.getParameter("tel2"));
    	String tel3 = NullUtil.nullString(request.getParameter("tel3"));
    	
    	String mobile1 = NullUtil.nullString(request.getParameter("mobile1"));
    	String mobile2 = NullUtil.nullString(request.getParameter("mobile2"));
    	String mobile3 = NullUtil.nullString(request.getParameter("mobile3"));
    	
    	String post = NullUtil.nullString(request.getParameter("post"));
    	//String post1 = NullUtil.nullString(request.getParameter("post1"));
    	//String post2 = NullUtil.nullString(request.getParameter("post2"));
    	String addr = NullUtil.nullString(request.getParameter("addr"));
    	//String addrDetail = NullUtil.nullString(request.getParameter("addrDetail"));
    	
    	//String addr2 = NullUtil.nullString(request.getParameter("addr2"));
    	//String addrDetail2 = NullUtil.nullString(request.getParameter("addrDetail2"));
    	
    	String email = NullUtil.nullString(request.getParameter("email"));
    	String homepage = NullUtil.nullString(request.getParameter("homepage"));
    	
    	int IDCheck = NullUtil.nullInt(request.getParameter("IDCheck"));
    	int emailRecv = NullUtil.nullInt(request.getParameter("emailRecv"));
    	int smsRecv = NullUtil.nullInt(request.getParameter("smsRecv"));
    	int typeCheck = NullUtil.nullInt(request.getParameter("typeCheck"));
    	
    	String establishment1 = NullUtil.nullString(request.getParameter("establishment1"));
    	String establishment2 = NullUtil.nullString(request.getParameter("establishment2"));
    	String establishment3 = NullUtil.nullString(request.getParameter("establishment3"));
    	
    	String corporation1 = NullUtil.nullString(request.getParameter("corporation1"));
    	String corporation2 = NullUtil.nullString(request.getParameter("corporation2"));    	
    	
    	
    	String primaryKey1 = NullUtil.nullString(request.getParameter("primaryKey1"));
    	String primaryKey2 = NullUtil.nullString(request.getParameter("primaryKey2"));
    	String primaryKey3 = NullUtil.nullString(request.getParameter("primaryKey3"));
    	
    	String mutual = NullUtil.nullString(request.getParameter("mutual"));					//상호
    	String corporateName = NullUtil.nullString(request.getParameter("corporateName"));		//법인명
    	String groupName = NullUtil.nullString(request.getParameter("groupName"));				//대표자명
    	
    	String businessAddr = NullUtil.nullString(request.getParameter("businessAddr"));		//사업장 주소
    	String businessAddrDetail = NullUtil.nullString(request.getParameter("businessAddrDetail"));		//사업장 상세주소
    	
    	String businessAddr2 = NullUtil.nullString(request.getParameter("businessAddr2"));		//사업장 주소
    	String businessAddrDetail2 = NullUtil.nullString(request.getParameter("businessAddrDetail2"));		//사업장 상세주소
    	
    	String groupKind = NullUtil.nullString(request.getParameter("groupKind"));				//대표종목    	
    	
    	
    	String businessPlace1 = NullUtil.nullString(request.getParameter("businessPlace1"));
    	String businessPlace2 = NullUtil.nullString(request.getParameter("businessPlace2"));
    	
    	String groupTel1 = NullUtil.nullString(request.getParameter("groupTel1"));
    	String groupTel2 = NullUtil.nullString(request.getParameter("groupTel2"));
    	String groupTel3 = NullUtil.nullString(request.getParameter("groupTel3"));
    	
    	String groupPax1 = NullUtil.nullString(request.getParameter("groupPax1"));
    	String groupPax2 = NullUtil.nullString(request.getParameter("groupPax2"));
    	String groupPax3 = NullUtil.nullString(request.getParameter("groupPax3"));
    	
    	String gradeNm = NullUtil.nullString(request.getParameter("gradeNm"));
    	
    	String portYn = NullUtil.nullString(request.getParameter("portYn"));    	
    	String establishment  = "";
    	String corporation = "";
    	String primaryKey = "";    	
    	
    	JnitcmsmbrDefaultVO searchVO = new JnitcmsmbrDefaultVO();
    	JnitcmsmbrVO jnitcmsmbrVO = new JnitcmsmbrVO();
    	JSONObject jsonObject = new JSONObject();
    	JnitcmsmbrVO typeVO = new JnitcmsmbrVO();
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request); // 회원가입은 loginVO = null 비회원 회원가입 loginVO != null
    	
    	if(request.getSession().getAttribute("snAuth") != null){
    		HashMap<String, String> snAuth = (HashMap)request.getSession().getAttribute("snAuth");
    		jnitcmsmbrVO.setDp(NullUtil.nullString(snAuth.get("dp")));
    	}    	
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	net.sf.json.JSONObject JSON = new net.sf.json.JSONObject();
    	
    	if(!"".equals(site)){
    		siteVO.setSitePath(site);
    		siteVO.setSelectCondition("1");
    		try {
    			siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
    			JSON = ConfigUtil.getProp(siteVO.getSiteId());
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
    	}
    	
    	//필수입력
    	if(!groupId.equals("")){
    		jnitcmsmbrVO.setMbrLogin(groupId);
    	}else{
    		model.addAttribute("alert", "아이디 입력이 누락되었습니다.");
    		return "jnit/util/alertCashBack";
    	}
    	
    	if(IDCheck == 0){
    		model.addAttribute("alert", "아이디 중복체크를 해주시기바랍니다.");
    		return "jnit/util/alertCashBack";
    	}    	
    	if(!groupNm.equals("")){
    		jnitcmsmbrVO.setMbrNm(groupNm);
    	}else{
    		model.addAttribute("alert", "단체이름 입력이 누락되었습니다.");
    		return "jnit/util/alertCashBack";
    	}    	
    	if(!groupPasswd.equals("") || !groupPasswdconfrim.equals("")){    		
    		if(!groupPasswd.equals(groupPasswdconfrim)){
        		model.addAttribute("alert", "비밀번호와 비밀번호 확인이 다릅니다.");
        		return "jnit/util/alertCashBack";
    		}else if(groupPasswd.length() < 10 || groupPasswdconfrim.length() < 10 || groupPasswd.length() > 16 || groupPasswdconfrim.length() > 16){
    			model.addAttribute("alert", "비밀번호 영문 ,숫자 10~16자 이내로 입력해주시기 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}else{
    			jnitcmsmbrVO.setPasswd(EgovFileScrty.encryptPassword(groupPasswd));
    		}    			
    	}else{
			model.addAttribute("alert", "패스워드 입력이 누락되었습니다.");
    		return "jnit/util/alertCashBack";
    	}    	
    	if(!type.equals("")){
    		jnitcmsmbrVO.setGroupType(type);    		
    	}else{
    		model.addAttribute("alert", "단체종류를 선택해주시기 바랍니다.");
    		return "jnit/util/alertCashBack";
    	}    	
    	//End 필수입력
    	
    	//유효성검사
    	String Patten = "^[0-9]+$";
    	String Patten2 = "^[a-zA-Z0-9ㄱ-ㅣ가-힣]+$";    	
    	String Patten3 = "^[a-zA-Z0-9ㄱ-ㅣ가-힣\\s\\-]+$";
    	String Patten4 = "^[a-zA-Z0-9ㄱ-ㅣ가-힣\\s\\-()]+$";
    	
    	if(!tel2.equals("") || !tel3.equals("")){	
    		if(MbrUtil.getPatten2(tel2, tel3, Patten)){
        		String tel = tel1 + "-" + tel2 + "-" + tel3;
        		jnitcmsmbrVO.setTel(tel);
        	}else{
        		model.addAttribute("alert", "전화번호 입력이 누락되었거나 숫자만을 써주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
        	}
    	}else if(Integer.parseInt(JSON.get("tel").toString()) == 2){
			if("".equals(tel2) || "".equals(tel3)){
				model.addAttribute("alert", "전화번호 입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}
		}
    	
    	if(!mobile2.equals("") || !mobile3.equals("")){
    		if(MbrUtil.getPatten2(mobile2, mobile3, Patten)){
        		String mobile = mobile1 + "-" + mobile2 + "-" + mobile3;
        		jnitcmsmbrVO.setMobile(mobile);
        	}else{
        		model.addAttribute("alert", "핸드폰 번호 입력이 누락되었거나 숫자만을 써주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
        	}
    	}else if(Integer.parseInt(JSON.get("phone").toString()) == 2){
			if("".equals(mobile2) || "".equals(mobile3)){
				model.addAttribute("alert", "핸드폰 입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}			
		}   	
    	
    	if(!post.equals("")){
    		if(MbrUtil.getPatten(post,Patten)){
        		jnitcmsmbrVO.setPostcode(post);
        	}else {
        		model.addAttribute("alert", "우편번호 입력이 누락되었거나 숫자만을 써주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
        	}
    	}else if(Integer.parseInt(JSON.get("post").toString()) == 2){
			if("".equals(post)){
				model.addAttribute("alert", "우편번호 입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}			
		}
    	
    	//주소
    	if(!addr.equals("")){   			
    		jnitcmsmbrVO.setAddress(addr);
    	}else if(Integer.parseInt(JSON.get("post").toString()) == 2){
    		if(!addr.equals("")){
    			model.addAttribute("alert", "주소 입력이 누락되었습니다.");
        		return "jnit/util/alertCashBack";
    		}
    	}
    	
    	if(!email.equals("")){          
    		if(MbrUtil.getPatten(email, "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[a-zA-Z]{2,4}$")){
        		jnitcmsmbrVO.setEmail(email);
        	}else{
        		model.addAttribute("alert",	"이메일 형식에 맞게 써주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
        	}
    	}else if(Integer.parseInt(JSON.get("email").toString()) == 2){
			if("".equals(email)){
				model.addAttribute("alert", "이메일입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}		
		}
    	if(Integer.parseInt(JSON.get("emailRecv").toString()) == 2){
    		if(emailRecv != 1){
    			model.addAttribute("alert", "메일수신동의를 선택해 주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
    		}
    	}
    	if(Integer.parseInt(JSON.get("smsRecv").toString()) == 2){
    		if(smsRecv != 1){
    			model.addAttribute("alert", "sms수신동의를 선택해 주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
    		}
    	}
    		
    	jnitcmsmbrVO.setEmailRecv((byte)emailRecv);    		
    	jnitcmsmbrVO.setSmsRecv((byte)smsRecv);
    	jnitcmsmbrVO.setGroupTitle(groupTitle);
    	
    	//필수입력   
    	if(type.equals("개인")){
    		
    		if(MbrUtil.getPatten3(establishment1, establishment2, establishment3, Patten)){
    			establishment = establishment1 + "-" + establishment2+"-"+establishment3;
    			if(!NullUtil.nullString(loginVO.getEstablishment()).equals(establishment)){ //회원정보와 다른값이 입력되면
    				searchVO.setEstablishment(establishment);  //setEstablishment 중복검사 
    			}    			 
    			jnitcmsmbrVO.setEstablishment(establishment);    			 
    		}else{
    			model.addAttribute("alert", "사업자번호가 누락되었거나 숫자만을 써주시기 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
    		
    	}else if(type.equals("영리")){
    		
    		if(MbrUtil.getPatten3(establishment1, establishment2, establishment3, Patten)){
		   		establishment = establishment1 + "-" + establishment2+"-"+establishment3;
		   		if(!NullUtil.nullString(loginVO.getEstablishment()).equals(establishment)){ //회원정보와 다른값이 입력되면
		   			searchVO.setEstablishment(establishment);  //setEstablishment 중복검사 
		   		}    			 
		   		jnitcmsmbrVO.setEstablishment(establishment);    			 
	   		}else{
		   		model.addAttribute("alert", "사업자번호가 누락되었거나 숫자만을 써주시기 바랍니다.");
		   		return "jnit/util/alertCashBack";
	   		}
    		
    		if(MbrUtil.getPatten2(corporation1, corporation2, Patten)){
    			corporation = corporation1 + "-" + corporation2;
    			if(!NullUtil.nullString(loginVO.getCorporation()).equals(corporation)){ //회원정보와 다른값이 입력되면
    				searchVO.setCorporation(corporation);  //setCorporation 중복검사
    			}				
				jnitcmsmbrVO.setCorporation(corporation);
    		}else{
    			model.addAttribute("alert", "법인등록번호가 누락되었거나 숫자만을 써주시기 바랍니다.");	   			
    			return "jnit/util/alertCashBack";
    		}
    		
    	}else if(type.equals("비영리")){
    		
    		if(MbrUtil.getPatten3(establishment1, establishment2, establishment3, Patten)){
		   		establishment = establishment1 + "-" + establishment2+"-"+establishment3;
		   		if(!NullUtil.nullString(loginVO.getEstablishment()).equals(establishment)){ //회원정보와 다른값이 입력되면
		   			searchVO.setEstablishment(establishment);  //setEstablishment 중복검사 
		   		}    			 
		   		jnitcmsmbrVO.setEstablishment(establishment);    			 
	   		}else{
		   		model.addAttribute("alert", "사업자번호가 누락되었거나 숫자만을 써주시기 바랍니다.");
		   		return "jnit/util/alertCashBack";
	   		}
    		
    		if(MbrUtil.getPatten2(corporation1, corporation2, Patten)){
    			corporation = corporation1 + "-" + corporation2;
    			if(!NullUtil.nullString(loginVO.getCorporation()).equals(corporation)){ //회원정보와 다른값이 입력되면
    				searchVO.setCorporation(corporation);  //setCorporation 중복검사
    			}				
				jnitcmsmbrVO.setCorporation(corporation);
    		}else{
    			model.addAttribute("alert", "법인등록번호가 누락되었거나 숫자만을 써주시기 바랍니다.");	   			
    			return "jnit/util/alertCashBack";
    		}
    		
       		if(MbrUtil.getPatten3(primaryKey1, primaryKey2, primaryKey3, Patten)){
       			primaryKey = primaryKey1 + "-" + primaryKey2 + "-" + primaryKey3;
       			if(!NullUtil.nullString(loginVO.getPrimaryKey()).equals(primaryKey)){ //회원정보와 다른값이 입력되면
       				searchVO.setPrimaryKey(primaryKey); //setPrimaryKey 중복검사
       			}       			
       			jnitcmsmbrVO.setPrimaryKey(primaryKey);
       		}else{
       			model.addAttribute("alert", "고유번호가 누락되었거나 숫자만을 써주시기 바랍니다.");
       			return "jnit/util/alertCashBack";
       		}
       		
    	}else if(type.equals("공식")){ 
    		
    		if(MbrUtil.getPatten3(primaryKey1, primaryKey2, primaryKey3, Patten)){
       			primaryKey = primaryKey1 + "-" + primaryKey2 + "-" + primaryKey3;
       			if(!NullUtil.nullString(loginVO.getPrimaryKey()).equals(primaryKey)){ //회원정보와 다른값이 입력되면
       				searchVO.setPrimaryKey(primaryKey); //setPrimaryKey 중복검사
       			}       			
       			jnitcmsmbrVO.setPrimaryKey(primaryKey);
       		}else{
       			model.addAttribute("alert", "고유번호가 누락되었거나 숫자만을 써주시기 바랍니다.");
       			return "jnit/util/alertCashBack";
       		}
    	}    	
    	//End 필수입력	
    	if(typeCheck ==0){
    		model.addAttribute("alert", "인증확인을 위해 중복체크를 해주시기 바랍니다.");
    		return "jnit/util/alertCashBack";
    	}    	
    	if(!mutual.equals("")){
    		if(MbrUtil.getPatten(mutual,Patten2)){
    			jnitcmsmbrVO.setMutual(mutual);
    		}else{
    			model.addAttribute("alert",	"상호는 한글과 영문/숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
    	}else if(Integer.parseInt(JSON.get("mutual").toString()) == 2){
			if("".equals(mutual)){
				model.addAttribute("alert", "상호이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}		
		}
    	
    	if(!corporateName.equals("")){
    		if(MbrUtil.getPatten(corporateName, Patten2)){
    			jnitcmsmbrVO.setcorporateName(corporateName);
    		}else{
    			model.addAttribute("alert",	"법인명(단체명)은 한글과 영문/숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
    	}else if(Integer.parseInt(JSON.get("corporateName").toString()) == 2){
			if("".equals(corporateName)){
				model.addAttribute("alert", "법인명(단체명)입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}		
		}
    	
    	
    	//사업장소재지
    	if(!businessPlace1.equals("") || !businessPlace2.equals("")){
    		if(MbrUtil.getPatten2(businessPlace1, businessPlace2, Patten)){
    			String businessPlace = businessPlace1 + "-"+ businessPlace2;
    			jnitcmsmbrVO.setBusinessPlace(businessPlace);
    		}else{
    			model.addAttribute("alert", "사업장 소재지가 누락되었거나 영문과 숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
    	}else if(Integer.parseInt(JSON.get("businessPlace").toString()) == 2){
			if(businessPlace1.equals("") && businessPlace2.equals("")){
				model.addAttribute("alert", "사업장 소재지 입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}
		}
    	
    	//사업장 구주소
    	if(!businessAddr.equals("")){
    		if(MbrUtil.getPatten(businessAddr, Patten4)){    			
    			if(businessAddrDetail.equals("")){ //상세주소가 null일때
    				jnitcmsmbrVO.setBusinessAddr(businessAddr);
    			}else{
    				if(MbrUtil.getPatten(businessAddrDetail, Patten4)){ 
    					businessAddr = businessAddr + "-" + businessAddrDetail;
        				jnitcmsmbrVO.setBusinessAddr(businessAddr);
    				}else{
    					model.addAttribute("alert", "사업장 구주소는 한글과 영문/숫자만을 써주시길 바랍니다.");
    	    			return "jnit/util/alertCashBack";
    				}    				
    			}    			    			
    		}else{
    			model.addAttribute("alert", "사업장 구주소는 한글과 영문/숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		} 		
    	}else if(Integer.parseInt(JSON.get("businessAddr").toString()) == 2){
			if("".equals(businessAddr)){
				model.addAttribute("alert", "사업장 구주소입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}		
		}
    	
    	//사업장 신주소
    	if(!businessAddr2.equals("")){
    		if(MbrUtil.getPatten(businessAddr2, Patten4)){    			
    			if(businessAddrDetail2.equals("")){ //상세주소가 null일때
    				jnitcmsmbrVO.setBusinessAddrNew(businessAddr2);
    			}else{
    				if(MbrUtil.getPatten(businessAddrDetail2, Patten4)){ 
    					businessAddr2 = businessAddr2 + "-" + businessAddrDetail2;
        				jnitcmsmbrVO.setBusinessAddrNew(businessAddr2);
    				}else{
    					model.addAttribute("alert", "사업장 상세주소는 한글과 영문/숫자만을 써주시길 바랍니다.");
    	    			return "jnit/util/alertCashBack";
    				}    				
    			}    			    			
    		}else{
    			model.addAttribute("alert", "사업장 상세주소는 한글과 영문/숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		} 		
    	}else if(Integer.parseInt(JSON.get("businessAddr").toString()) == 2){
			if("".equals(businessAddr2)){
				model.addAttribute("alert", "사업장 상세주소입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}		
		}
    	
    	if(!groupKind.equals("")){
    		if(MbrUtil.getPatten(groupKind, Patten3)){
    			jnitcmsmbrVO.setGroupKind(groupKind);
    		}else{
    			model.addAttribute("alert", "대표종목은 한글과 영문/숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}    		
    	}else if(Integer.parseInt(JSON.get("groupKind").toString()) == 2){
			if("".equals(groupKind)){
				model.addAttribute("alert", "대표종목입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}		
		}
    	
    	if(!groupTel2.equals("") || !groupTel3.equals("")){
    		if(MbrUtil.getPatten2(groupTel2, groupTel3, Patten)){
    			String groupTel = groupTel1 + "-" + groupTel2 + "-" + groupTel3;
    			jnitcmsmbrVO.setGroupTel(groupTel);
    		}else{
    			model.addAttribute("alert", "대표 전화번호가 누락되었거나 영문과 숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
    	}else if(Integer.parseInt(JSON.get("groupTel").toString()) == 2){
			if(groupTel2.equals("") && groupTel3.equals("")){
				model.addAttribute("alert", "대표 전화번호입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}		
		}
    	
    	if(!groupPax1.equals("") || !groupPax2.equals("")|| !groupPax2.equals("")){
    		if(MbrUtil.getPatten3(groupPax1, groupPax2, groupPax3, Patten)){
    			String groupPax = groupPax1 + "-" + groupPax2 + "-" + groupPax3;
    			jnitcmsmbrVO.setGroupPax(groupPax);
    		}else{
    			model.addAttribute("alert", "대표 팩스가 누락되었거나 영문과 숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
    	}else if(Integer.parseInt(JSON.get("groupPax").toString()) == 2){
			if(groupPax1.equals("") && groupPax2.equals("") && groupPax2.equals("")){
				model.addAttribute("alert", "대표 팩스입력이 누락되었습니다.");
				return "jnit/util/alertCashBack";
			}		
		}
    	jnitcmsmbrVO.setGrpConfirm("N");
    	jnitcmsmbrVO.setGradeNm(gradeNm);
    	// End 유효성검사
    	
    	
    	//회원정보와 다른값이 입력될시 사업자번호, 법인등록번호,고유번호 중복검사 
    	
    	int checkEstablishment = 0;
    	int checkCorporation = 0;
    	int checkPrimaryKey = 0;		
    	
    	if(!NullUtil.nullString(searchVO.getEstablishment()).equals("")){ 
    		searchVO.setSearchCondition("1");
    		checkEstablishment = jnitcmsmbrService.selectListTotCnt(searchVO); //사업자
    	}    	
    	if(!NullUtil.nullString(searchVO.getCorporation()).equals("")){
    		searchVO.setSearchCondition("2");
    		checkCorporation = jnitcmsmbrService.selectListTotCnt(searchVO); //법인등록번호
    	}
    	if(!NullUtil.nullString(searchVO.getPrimaryKey()).equals("")){
    		searchVO.setSearchCondition("3");
    		checkPrimaryKey = jnitcmsmbrService.selectListTotCnt(searchVO); // 고유번호
    	}
    	
    	//회원정보와 다른값이 입력될시
    	if(checkEstablishment > 0){
    		model.addAttribute("alert", "입력하신 사업자번호는 이미 가입된 번호가 있습니다.");
			return "jnit/util/alertCashBack";
    	}
    	if(checkCorporation > 0){
    		model.addAttribute("alert", "입력하신 법인등록번호는 이미 가입된 번호가 있습니다.");
			return "jnit/util/alertCashBack";
    	}
    	if(checkPrimaryKey > 0){
    		model.addAttribute("alert", "입력하신 고유번호는 이미 가입된 번호가 있습니다.");
			return "jnit/util/alertCashBack";
    	}
    	
    	int checkType = jnitcmsmbrService.selectJnitcmsmbrListTotCnt(searchVO);
    	if(checkType != 0){
    		JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    		if(!establishment.equals("")){
    			mbrVO.setEstablishment(establishment);
        		typeVO = jnitcmsmbrService.selectDpJnitcmsmbr(mbrVO);
    		}
    		if(typeVO != null){
    			String typeId = NullUtil.nullString(typeVO.getTypeId());
        		if(typeId.equals("30031") || typeId.equals("30028") || typeId.equals("30029")){ //비회원 로그인 가입신청시
        			model.addAttribute("alert", "이미 가입된 번호가 있습니다.");
        			return "jnit/util/alertCashBack";
        		} 		
    		}    		
    	}
    	//End 중복검사 	
    	
    	String id = "";
    	searchVO.setSearchCondition("20");    	
    	searchVO.setSearchKeyword(groupId);    	
    	int idcheck = jnitcmsmbrService.selectJnitcmsmbrListTotCnt(searchVO);
    	if(idcheck == 0){
    		
    		JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    		if(!establishment.equals("")){
    			mbrVO.setEstablishment(establishment);
    			try {
    				typeVO = jnitcmsmbrService.selectDpJnitcmsmbr(mbrVO);
    			} catch (NullPointerException e){
    				log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}        		        		
    		}
    		
    		if(typeVO != null){
	    		String typeId = NullUtil.nullString(typeVO.getTypeId());
	    		if(typeId.equals("30013") || typeId.equals("30014") || typeId.equals("30015")){ // 30013(공인인증 비회원) / 30014(G-pin 비회원) / 30015(실명인증 비회원)  로그인 가입신청시	    			
	    			jnitcmsmbrVO.setMbrId(typeVO.getMbrId());
	    			jnitcmsmbrVO.setTypeId("30006"); // 단체회원
	    			//jnitcmsmbrVO.setTypeId(authType); // 실명인증 / G-pin 인증 / 공인인증
	    			jnitcmsmbrService.updateTempmbr(jnitcmsmbrVO);    			
	    		}
    		}else{ //일반 가입신청시
    			jnitcmsmbrVO.setTypeId("30006"); // 단체회원 
    			//jnitcmsmbrVO.setTypeId(authType); // 실명인증 / G-pin 인증 / 공인인증
        		id = jnitcmsmbrService.insertJnitcmsmbr(jnitcmsmbrVO);
        		jnitcmsmbrVO.setMbrId(id);
    		}
    		 		    		    		    	
    	}else{
    		model.addAttribute("alert", "이미 가입된 아이디 입니다.");
    		return "jnit/util/alertCashBack";
    	}
    	
    	jsonObject.put("status", "ok");
		jsonObject.put("next", next);
		jsonObject.put("site", site);    	    	
    	model.addAttribute("result", jsonObject.toJSONString());
    	model.addAttribute("request", request);
    	
    	loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	MbrUtil.insertMbrlog(request, jnitcmsmbrVO, loginVO, "등록", site, null);
    	return "jnit/mbr/redirect";
    }
    
    @RequestMapping("/mbr/signup_groupModify.do")
    public String signup_groupModify(HttpServletRequest request,HttpServletResponse response, ModelMap model)throws Exception{    	
    	String site = NullUtil.nullString(request.getParameter("site"));
    	String next = NullUtil.nullString(request.getParameter("next"));    	
    	
    	String type = NullUtil.nullString(request.getParameter("groupType"));
    	
    	String groupPasswd = NullUtil.nullString(request.getParameter("groupPasswd"));
    	String groupPasswdconfrim = NullUtil.nullString(request.getParameter("groupPasswdConfrim"));
    	
    	String tel1 = NullUtil.nullString(request.getParameter("tel1"));
    	String tel2 = NullUtil.nullString(request.getParameter("tel2"));
    	String tel3 = NullUtil.nullString(request.getParameter("tel3"));
    	
    	String mobile1 = NullUtil.nullString(request.getParameter("mobile1"));
    	String mobile2 = NullUtil.nullString(request.getParameter("mobile2"));
    	String mobile3 = NullUtil.nullString(request.getParameter("mobile3"));
    	
    	String post = NullUtil.nullString(request.getParameter("post"));
    	//String post1 = NullUtil.nullString(request.getParameter("post1"));
    	//String post2 = NullUtil.nullString(request.getParameter("post2"));
    	String addr = NullUtil.nullString(request.getParameter("addr"));
    	//String addrDetail = NullUtil.nullString(request.getParameter("addrDetail"));
    	
    	//String addr2 = NullUtil.nullString(request.getParameter("addr2"));
    	//String addrDetail2 = NullUtil.nullString(request.getParameter("addrDetail2"));
    	
    	String email = NullUtil.nullString(request.getParameter("email"));
    	String homepage = NullUtil.nullString(request.getParameter("homepage"));    	
    	
    	int emailRecv = NullUtil.nullInt(request.getParameter("emailRecv"));
    	int smsRecv = NullUtil.nullInt(request.getParameter("smsRecv"));
    	int typeCheck = NullUtil.nullInt(request.getParameter("typeCheck"));
    	
    	String establishment1 = NullUtil.nullString(request.getParameter("establishment1"));
    	String establishment2 = NullUtil.nullString(request.getParameter("establishment2"));
    	String establishment3 = NullUtil.nullString(request.getParameter("establishment3"));
    	
    	String corporation1 = NullUtil.nullString(request.getParameter("corporation1"));
    	String corporation2 = NullUtil.nullString(request.getParameter("corporation2"));    	
    	
    	
    	String primaryKey1 = NullUtil.nullString(request.getParameter("primaryKey1"));
    	String primaryKey2 = NullUtil.nullString(request.getParameter("primaryKey2"));
    	String primaryKey3 = NullUtil.nullString(request.getParameter("primaryKey3"));
    	
    	String mutual = NullUtil.nullString(request.getParameter("mutual"));					//상호
    	String corporateName = NullUtil.nullString(request.getParameter("corporateName"));		//법인명
    	String groupName = NullUtil.nullString(request.getParameter("groupName"));				//대표자명
    	
    	String businessAddr = NullUtil.nullString(request.getParameter("businessAddr"));		//사업장 주소
    	String businessAddrDetail = NullUtil.nullString(request.getParameter("businessAddrDetail"));		//사업장 상세주소
    	
    	String businessAddr2 = NullUtil.nullString(request.getParameter("businessAddr2"));		//사업장 주소
    	String businessAddrDetail2 = NullUtil.nullString(request.getParameter("businessAddrDetail2"));		//사업장 상세주소
    	
    	String groupKind = NullUtil.nullString(request.getParameter("groupKind"));				//대표종목    	
    	
    	
    	String businessPlace1 = NullUtil.nullString(request.getParameter("businessPlace1"));
    	String businessPlace2 = NullUtil.nullString(request.getParameter("businessPlace2"));
    	
    	String groupTel1 = NullUtil.nullString(request.getParameter("groupTel1"));
    	String groupTel2 = NullUtil.nullString(request.getParameter("groupTel2"));
    	String groupTel3 = NullUtil.nullString(request.getParameter("groupTel3"));
    	
    	String groupPax1 = NullUtil.nullString(request.getParameter("groupPax1"));
    	String groupPax2 = NullUtil.nullString(request.getParameter("groupPax2"));
    	String groupPax3 = NullUtil.nullString(request.getParameter("groupPax3"));
    	
    	String groupTitle = NullUtil.nullString(request.getParameter("groupTitle"));
    	String groupNm = NullUtil.nullString(request.getParameter("groupNm"));
    	
    	String gradeNm = NullUtil.nullString(request.getParameter("gradeNm"));
    	
    	String establishment  = "";
    	String corporation = "";
    	String primaryKey = "";    	
    	
    	int settingLogin = 0;
    	
    	JnitcmsmbrVO jnitcmsmbrVO = new JnitcmsmbrVO();
    	JSONObject jsonObject = new JSONObject();
    	JnitcmsmbrDefaultVO searchVO = new JnitcmsmbrDefaultVO();
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);    	
    	
    	if(!groupPasswd.equals("") || !groupPasswdconfrim.equals("")){    		
    		if(!groupPasswd.equals(groupPasswdconfrim)){
        		model.addAttribute("alert", "비밀번호와 비밀번호 확인이 다릅니다.");
        		return "jnit/util/alertCashBack";
    		}else if(groupPasswd.length() < 10 || groupPasswdconfrim.length() < 10 || groupPasswd.length() > 16 || groupPasswdconfrim.length() > 16){
    			model.addAttribute("alert", "비밀번호는 영문, 숫자 10 ~ 16자 이내로 써주시기 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}else{
    			loginVO.setPasswd(EgovFileScrty.encryptPassword(groupPasswd));
    		}    			
    	}    	
    	if(!groupNm.equals("")){
    		loginVO.setGroupTitle(groupNm);
    	}else{
    		model.addAttribute("alert", "단체이름을 입력해주시기 바랍니다.");
			return "jnit/util/alertCashBack";
    	}
    	//유효성검사
    	String Patten = "^[0-9]+$";
    	String Patten2 = "^[a-zA-Z0-9ㄱ-ㅣ가-힣]+$";    	
    	String Patten3 = "^[a-zA-Z0-9ㄱ-ㅣ가-힣\\s]+$";
    	String Patten4 = "^[a-zA-Z0-9ㄱ-ㅣ가-힣\\s\\-]+$";
    	String Patten5 = "^[a-zA-Z0-9ㄱ-ㅣ가-힣\\s\\-()]+$";
    	if(!tel2.equals("") || !tel3.equals("")){
    		if(MbrUtil.getPatten2(tel2, tel3, Patten)){   			
        		String tel = tel1 + "-" + tel2 + "-" + tel3;
        		loginVO.setTel(tel);
        	}else{
        		model.addAttribute("alert", "전화번호 입력이 누락되었거나 숫자만을 써주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
        	}
    	}
    	
    	if(!mobile2.equals("") || !mobile3.equals("")){
    		if(MbrUtil.getPatten2(mobile2, mobile3, Patten)){
        		String mobile = mobile1 + "-" + mobile2 + "-" + mobile3;
        		loginVO.setMobile(mobile);
        	}else{
        		model.addAttribute("alert", "핸드폰 번호 입력이 누락되었거나 숫자만을 써주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
        	}
    	}else{
    		loginVO.setMobile(null);
    	}
    	
    	if(!post.equals("")){
    		if(MbrUtil.getPatten(post,Patten)){
        		loginVO.setPostcode(post);
        	}else {
        		model.addAttribute("alert", "우편번호 입력이 누락되었거나 숫자만을 써주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
        	}
    	}
    	
    	//주소
    	if(!addr.equals("")){
    		loginVO.setAddress(addr);
    	}
    	if(!email.equals("")){          
    		if(MbrUtil.getPatten(email, "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[a-zA-Z]{2,4}$")){
    			loginVO.setEmail(email);
        	}else{
        		model.addAttribute("alert",	"이메일 형식에 맞게 써주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
        	}
    	}else{
    		loginVO.setEmail(null);
    	}   	
    	
    	loginVO.setEmailRecv((byte)emailRecv);
    	loginVO.setSmsRecv((byte)smsRecv);
    	loginVO.setGroupTitle(groupTitle);   
    	
    	if(!type.equals("")){ 
    		loginVO.setGroupType(type);
    	}else{
    		model.addAttribute("alert", "단체종류를 선택해주시기 바랍니다.");
    		return "jnit/util/alertCashBack";
    	}
    	//필수입력   
    	if(type.equals("개인")){
    		
    		if(!establishment1.equals("") || !establishment2.equals("") || !establishment3.equals("")){
	    		if(MbrUtil.getPatten3(establishment1, establishment2, establishment3, Patten)){
		       		establishment = establishment1 + "-" + establishment2+"-"+establishment3;
		       		if(!NullUtil.nullString(loginVO.getEstablishment()).equals(establishment)){ //회원정보와 다른값이 입력되면
		       			searchVO.setEstablishment(establishment); //setEstablishment 중복검사
		       			settingLogin++;
		       		}		       		
		       		loginVO.setEstablishment(establishment);    			 
	       		}else{
	       			model.addAttribute("alert", "사업자번호가 누락되었거나 숫자만을 써주시기 바랍니다.");
	       			return "jnit/util/alertCashBack";
	       		}
    		} 
    		
    	}else if(type.equals("영리")){    
    		
    		if(!establishment1.equals("") || !establishment2.equals("") || !establishment3.equals("")){
	    		if(MbrUtil.getPatten3(establishment1, establishment2, establishment3, Patten)){
		       		establishment = establishment1 + "-" + establishment2+"-"+establishment3;
		       		if(!NullUtil.nullString(loginVO.getEstablishment()).equals(establishment)){  //회원정보와 다른값이 입력되면
		       			searchVO.setEstablishment(establishment); //setEstablishment 중복검사
		       			settingLogin++;
		       		}		       		
		       		loginVO.setEstablishment(establishment);    			 
	       		}else{
	       			model.addAttribute("alert", "사업자번호가 누락되었거나 숫자만을 써주시기 바랍니다.");
	       			return "jnit/util/alertCashBack";
	       		}
    		}
    		if(!corporation1.equals("") || !corporation2.equals("")){
    			if(MbrUtil.getPatten2(corporation1, corporation2, Patten)){
        			corporation = corporation1 + "-" + corporation2;
        			if(!NullUtil.nullString(loginVO.getCorporation()).equals(corporation)){ //회원정보와 다른값이 입력되면
        				searchVO.setCorporation(corporation);  //setcorporation 중복검사
        				settingLogin++;
        			}    				
        			loginVO.setCorporation(corporation);
        		}else{
        			model.addAttribute("alert", "법인등록번호가 누락되었거나 숫자만을 써주시기 바랍니다.");	   			
        			return "jnit/util/alertCashBack";
        		}
    		}   
    		
    	}else if(type.equals("비영리")){    	
    		
    		if(!establishment1.equals("") || !establishment2.equals("") || !establishment3.equals("")){
	    		if(MbrUtil.getPatten3(establishment1, establishment2, establishment3, Patten)){
		       		establishment = establishment1 + "-" + establishment2+"-"+establishment3;
		       		if(!NullUtil.nullString(loginVO.getEstablishment()).equals(establishment)){  //회원정보와 다른값이 입력되면
		       			searchVO.setEstablishment(establishment); //setEstablishment 중복검사
		       			settingLogin++;
		       		}		       		
		       		loginVO.setEstablishment(establishment);    			 
	       		}else{
	       			model.addAttribute("alert", "사업자번호가 누락되었거나 숫자만을 써주시기 바랍니다.");
	       			return "jnit/util/alertCashBack";
	       		}
    		}
    		if(!corporation1.equals("") || !corporation2.equals("")){
    			if(MbrUtil.getPatten2(corporation1, corporation2, Patten)){
        			corporation = corporation1 + "-" + corporation2;
        			if(!NullUtil.nullString(loginVO.getCorporation()).equals(corporation)){ //회원정보와 다른값이 입력되면
        				searchVO.setCorporation(corporation);  //setcorporation 중복검사
        				settingLogin++;
        			}    				
        			loginVO.setCorporation(corporation);
        		}else{
        			model.addAttribute("alert", "법인등록번호가 누락되었거나 숫자만을 써주시기 바랍니다.");	   			
        			return "jnit/util/alertCashBack";
        		}
    		}
    		if(!primaryKey1.equals("") || !primaryKey2.equals("") || !primaryKey3.equals("")){
    			if(MbrUtil.getPatten3(primaryKey1, primaryKey2, primaryKey3, Patten)){
           			primaryKey = primaryKey1 + "-" + primaryKey2 + "-" + primaryKey3;
           			if(!NullUtil.nullString(loginVO.getPrimaryKey()).equals(primaryKey)){ //회원정보와 다른값이 입력되면
           				searchVO.setPrimaryKey(primaryKey); //setPrimaryKey 중복검사
           				settingLogin++;
           			}           			
           			loginVO.setPrimaryKey(primaryKey);
           		}else{
           			model.addAttribute("alert", "고유번호가 누락되었거나 숫자만을 써주시기 바랍니다.");
           			return "jnit/util/alertCashBack";
           		}
    		}    
    		
    	}else if(type.equals("공식")){    	
    		
    		if(!primaryKey1.equals("") || !primaryKey2.equals("") || !primaryKey3.equals("")){
    			if(MbrUtil.getPatten3(primaryKey1, primaryKey2, primaryKey3, Patten)){ 
           			primaryKey = primaryKey1 + "-" + primaryKey2 + "-" + primaryKey3;
           			if(!NullUtil.nullString(loginVO.getPrimaryKey()).equals(primaryKey)){ //회원정보와 다른값이 입력되면
           				searchVO.setPrimaryKey(primaryKey); //setPrimaryKey 중복검사
           				settingLogin++;
           			}           			
           			loginVO.setPrimaryKey(primaryKey);
           		}else{
           			model.addAttribute("alert", "고유번호가 누락되었거나 숫자만을 써주시기 바랍니다.");
           			return "jnit/util/alertCashBack";
           		}
    		}
    		
    	}
    	
    	if(settingLogin  != 0){ //회원정보와 다른값이 입력되면
    		if(typeCheck ==0){ // 중복체크 확인요청 보냄.
        		model.addAttribute("alert", "인증확인을 위해 중복체크를 해주시기 바랍니다.");
        		return "jnit/util/alertCashBack";
        	}
    	}
    	
    	if(!mutual.equals("")){
    		if(MbrUtil.getPatten(mutual,Patten2)){
    			loginVO.setMutual(mutual);
    		}else{
    			model.addAttribute("alert",	"상호는 한글과 영문/숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
    	}
    	
    	if(!corporateName.equals("")){
    		if(MbrUtil.getPatten(corporateName, Patten2)){
    			loginVO.setcorporateName(corporateName);
    		}else{
    			model.addAttribute("alert",	"법인명은 한글과 영문/숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
    	}
    	if(!groupName.equals("")){
    		if(MbrUtil.getPatten(groupName, Patten2)){
    			loginVO.setGroupName(groupName);
    		}else{
    			model.addAttribute("alert",	"대표자명은 한글과 영문/숫자만을  써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
    	}
    	if(!businessPlace1.equals("") || !businessPlace2.equals("")){
    		if(MbrUtil.getPatten2(businessPlace1, businessPlace2, Patten)){
    			String businessPlace = businessPlace1 + "-"+ businessPlace2;
    			loginVO.setBusinessPlace(businessPlace);
    		}else{
    			model.addAttribute("alert", "사업장 소재지가 누락되었거나 영문과 숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
    	}    	
    	
    	//사업장 구주소
    	if(!businessAddr.equals("")){
    		if(MbrUtil.getPatten(businessAddr, Patten5)){    			
    			if(businessAddrDetail.equals("")){ //상세주소가 null일때
    				loginVO.setBusinessAddr(businessAddr);
    			}else{
    				if(MbrUtil.getPatten(businessAddrDetail, Patten5)){ 
    					businessAddr = businessAddr + "-" + businessAddrDetail;
    					loginVO.setBusinessAddr(businessAddr);
    				}else{
    					model.addAttribute("alert", "사업장 상세주소는 한글과 영문/숫자만을 써주시길 바랍니다.");
    	    			return "jnit/util/alertCashBack";
    				}    				
    			}    			    			
    		}else{
    			model.addAttribute("alert", "사업장 주소는 한글과 영문/숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		} 		
    	}
    	
    	//사업장 신주소
    	if(!businessAddr2.equals("")){
    		if(MbrUtil.getPatten(businessAddr2, Patten5)){    			
    			if(businessAddrDetail2.equals("")){ //상세주소가 null일때
    				loginVO.setBusinessAddrNew(businessAddr2);
    			}else{
    				if(MbrUtil.getPatten(businessAddrDetail2, Patten5)){ 
    					businessAddr2 = businessAddr2 + "-" + businessAddrDetail2;
    					loginVO.setBusinessAddrNew(businessAddr2);
    				}else{
    					model.addAttribute("alert", "사업장 상세주소는 한글과 영문/숫자만을 써주시길 바랍니다.");
    	    			return "jnit/util/alertCashBack";
    				}    				
    			}    			    			
    		}else{
    			model.addAttribute("alert", "사업장 주소는 한글과 영문/숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		} 		
    	}
    	
    	if(!groupKind.equals("")){
    		if(MbrUtil.getPatten(groupKind, Patten3)){
    			loginVO.setGroupKind(groupKind);
    		}else{
    			model.addAttribute("alert", "대표종목은 한글과 영문/숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}    		
    	}
    	
    	if(!groupTel2.equals("") || !groupTel3.equals("")){
    		if(MbrUtil.getPatten2(groupTel2, groupTel3, Patten)){
    			String groupTel = groupTel1 + "-" + groupTel2 + "-" + groupTel3;
    			loginVO.setGroupTel(groupTel);
    		}else{
    			model.addAttribute("alert", "대표 전화번호가 누락되었거나 영문과 숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
    	}
    	
    	if(!groupPax1.equals("") || !groupPax2.equals("")|| !groupPax2.equals("")){
    		if(MbrUtil.getPatten3(groupPax1, groupPax2, groupPax3, Patten)){
    			String groupPax = groupPax1 + "-" + groupPax2 + "-" + groupPax3;
    			loginVO.setGroupPax(groupPax);
    		}else{
    			model.addAttribute("alert", "대표 팩스가 누락되었거나 영문과 숫자만을 써주시길 바랍니다.");
    			return "jnit/util/alertCashBack";
    		}
    	}
    	loginVO.setGradeNm(gradeNm);
    	// End 유효성검사
    	
    	
    	int checkEstablishment = 0;
    	int checkCorporation = 0;
    	int checkPrimaryKey = 0;
		
    	//회원정보와 다른값이 입력될시 사업자번호, 법인등록번호,고유번호 중복검사 
    	if(!NullUtil.nullString(searchVO.getEstablishment()).equals("")){ 
    		searchVO.setSearchCondition("1");
    		checkEstablishment = jnitcmsmbrService.selectListTotCnt(searchVO); //사업자
    	}    	
    	if(!NullUtil.nullString(searchVO.getCorporation()).equals("")){
    		searchVO.setSearchCondition("2");
    		checkCorporation = jnitcmsmbrService.selectListTotCnt(searchVO); //법인등록번호
    	}
    	if(!NullUtil.nullString(searchVO.getPrimaryKey()).equals("")){
    		searchVO.setSearchCondition("3");
    		checkPrimaryKey = jnitcmsmbrService.selectListTotCnt(searchVO); // 고유번호
    	}
    	
    	//회원정보와 다른값이 입력될시
    	if(checkEstablishment > 0){
    		model.addAttribute("alert", "입력하신 사업자번호는 이미 가입된 번호가 있습니다.");
			return "jnit/util/alertCashBack";
    	}
    	if(checkCorporation > 0){
    		model.addAttribute("alert", "입력하신 법인등록번호는 이미 가입된 번호가 있습니다.");
			return "jnit/util/alertCashBack";
    	}
    	if(checkPrimaryKey > 0){
    		model.addAttribute("alert", "입력하신 고유번호는 이미 가입된 번호가 있습니다.");
			return "jnit/util/alertCashBack";
    	}
    	//End 중복검사
    	
    	//set Jnitmbr
    	loginVO.setMbrId(loginVO.getMbrId()); 
    	loginVO.setMbrNm(loginVO.getMbrNm());
    	loginVO.setTypeId(loginVO.getTypeId());		
    	loginVO.setOrgId(loginVO.getOrgId());
    	loginVO.setPosId(loginVO.getPosId());
    	loginVO.setMbrLogin(loginVO.getMbrLogin());
    	loginVO.setMbrPhoto(loginVO.getMbrPhoto());    	
		//end Jnitmbr
		
		jnitcmsmbrService.updateJnitcmsmbr(loginVO);	 // JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
		
    	jsonObject.put("status", "okModify");
		jsonObject.put("next", next);
		jsonObject.put("site", site);			
		
    	model.addAttribute("result", jsonObject.toJSONString());
    	model.addAttribute("request", request);
    	
    	MbrUtil.insertMbrlog(request, loginVO, loginVO, "수정", site, null);    	
    	return "jnit/mbr/redirect"; 
    }
    
    @RequestMapping("/login/dp/update.do")
    public String loginDP(HttpServletRequest request, ModelMap model)throws Exception{
    	
    	String mbrLogin = NullUtil.nullString(request.getParameter("mbrLogin"));    	
    	
    	JSONObject JSON = new JSONObject();
    	if(mbrLogin.equals("")){
    		JSON.put("status", "error");
    		JSON.put("message", "ERROR 01 : 아이디 값이 없습니다.");
    	}
    	
    	JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    	mbrVO.setMbrLogin(mbrLogin);
    	mbrVO.setSelectCondition("1");
    	try {
			mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
    	} catch (NullPointerException e){
    		JSON.put("status", "error");
    		JSON.put("message", "ERROR 02 : 로그인 정보가 없습니다.");
		} catch (Exception e) {
			JSON.put("status", "error");
    		JSON.put("message", "ERROR 02 : 로그인 정보가 없습니다.");
		}
    	
		if(mbrVO.getMbrId() != null){
			HashMap<String, String> snAuth = (HashMap)request.getSession().getAttribute("snAuth");
			JnitdbVO dbVO = new JnitdbVO();
        	dbVO.setQuery("SELECT COUNT(*) as cnt FROM JNITCMSMBR WHERE TYPE_ID!='30032' AND DP='"+NullUtil.nullString(snAuth.get("dp"))+"' AND ISDEL=0");
        	int isUser = jnitdbService.selectCnt(dbVO);
        	if(isUser == 0){
        		String dp = NullUtil.nullString( snAuth.get("dp") );
    	    	String sn = NullUtil.nullString( snAuth.get("sn") );	    	
    	    	
    	    	mbrVO.setDp(dp);
    	    	mbrVO.setUpdateCondition("3");
    	    	jnitcmsmbrService.updateJnitcmsmbr(mbrVO);
    	    	
    	    	//로그아웃.
    			request.getSession().setAttribute("loginVO", null);
    	    	
    	    	JSON.put("status", "success");
        		JSON.put("message", "정보가 갱신되었습니다.");
        		
        		JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
            	MbrUtil.insertMbrlog(request, mbrVO, loginVO,"수정", "", null);
        	}else{
        		JSON.put("status", "error");
        		JSON.put("message", "ERROR 03 : 고유식별번호가 이미 사용중입니다.");
        	}	    	
		}
		model.addAttribute("json", JSON.toJSONString());		
		model.addAttribute("request", request);
    	return "/jnit/util/json";
    }
}