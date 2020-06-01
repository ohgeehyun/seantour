/**
 * @version 3.2.0.1
 */
package jnit.cms.config;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.AdminUtil;
import jnit.cms.CmsHelper;
import jnit.cms.handler.CmsHandler;
import jnit.cms.site.JnitcmssiteDefaultVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;

@Controller
public class CmsConfigController {
	
	public static Log log = LogFactory.getLog(CmsConfigController.class);
	
	private final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
	
	@Resource(name = "jnitcmssiteService")
	private JnitcmssiteService jnitcmssiteService;
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
	//기본설정
    @RequestMapping("/cms/config/default.do")
    public String getDefConfig(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	AdminUtil.setMenuId("m01010100");
		String debug = EgovProperties.getProperty("Globals.Debug");

		File currentPropFile = new File( EgovProperties.GLOBALS_PROPERTIES_FILE );
		if(debug.equals("true")) log.debug(currentPropFile.getPath());
		if(currentPropFile.exists()) {
			if(debug.equals("true")) log.debug("use props.");
			
			Properties cProps = new Properties();
			InputStreamReader isr = null;
			FileInputStream fis = null;
			try {
				fis = new FileInputStream(currentPropFile);
				isr = new InputStreamReader(fis, "UTF-8");
				cProps.load(isr);				
			} catch (FileNotFoundException e) {
				if(debug.equals("true")) log.error(e.getMessage());
			} catch (IOException e) {
				if(debug.equals("true")) log.error(e.getMessage());
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
			
			model.addAttribute("props", cProps);
		}
		
		model.addAttribute("defaultProp", getCmsDefaultProp(request));	
		return "jnit/cms/config/default";
    }    
    //기본설정 저장
    @RequestMapping("/cms/config/defaultSave.do")
    public String defaultSaveConfig(@ModelAttribute("JnitDefaultInfoVO") JnitDefaultInfoVO jnitDefaultInfoVO,
    		HttpServletRequest request, ModelMap model) throws IOException {
    	
    	String defaultDir = PathUtil.getRealPath(request)+"WEB-INF/config/jnit";
    	String defaultPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/defaultProp.prop";
		
    	File file = new File(defaultDir);
    	if(!file.exists()){
    		file.mkdir();
    	}
		Properties props = new Properties();
		JSONObject JSON = new JSONObject().fromObject(jnitDefaultInfoVO);
		Iterator itr = JSON.keys();
		while (itr.hasNext()) {
			String key = (String) itr.next();
			props.put(key, JSON.get(key));
		}
		try{
			FileOutputStream fos = new FileOutputStream(defaultPath);
			props.store(fos, "(by Jnitcms 3.5)");
			if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
			JnitFilegoUtil.transferFile(JnitFilegoFileType.CONFIG, defaultPath);		//Filego 배포
		}catch(IOException e){
			log.error(e.getMessage());
		}
		model.addAttribute("alert","저장되었습니다.");
		model.addAttribute("path",request.getHeader("referer"));
		return "jnit/util/alertMove";
		//return "redirect:"+request.getHeader("referer");
    }
    
    @RequestMapping("/cms/config/analytics.do")
    public String getAnalyticsConfig(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	AdminUtil.setMenuId("m01010400");
		String debug = EgovProperties.getProperty("Globals.Debug");
		String analyticsPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/analyticsProp.prop";
		
		Properties analytics = new Properties();
		File currentDefaultPropFile = new File(analyticsPath);
		InputStreamReader isr = null;
		FileInputStream fis = null;
		if(currentDefaultPropFile.exists()){
			try {
				fis = new FileInputStream(currentDefaultPropFile);
				isr = new InputStreamReader(fis, "UTF-8");
				analytics.load(isr);
			} catch (UnsupportedEncodingException e) {
				log.error(e.getMessage());
			} catch (FileNotFoundException e) {
				log.error(e.getMessage());
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
			
		}
		model.addAttribute("analytics", analytics);
		return "jnit/cms/config/analytics";
    }    
    
    
  //통계설정 저장
    @RequestMapping("/cms/config/analyticsSave.do")
    public String analyticsSaveConfig(HttpServletRequest request, ModelMap model) throws IOException {
    	
    	String defaultDir = PathUtil.getRealPath(request)+"WEB-INF/config/jnit";
    	String defaultPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/analyticsProp.prop";
		
    	File file = new File(defaultDir);
    	if(!file.exists()){
    		file.mkdir();
    	}
			String apiEmail = NullUtil.nullString(request.getParameter("apiEmail"));
			String applicationName = NullUtil.nullString(request.getParameter("applicationName"));
			String viewId = NullUtil.nullString(request.getParameter("viewId"));
			
			Properties props = new Properties();		
			
				if(!apiEmail.equals("")){
					props.setProperty("apiEmail", apiEmail);
				}
				if(!applicationName.equals("")){
					props.setProperty("applicationName", applicationName);
				}
				if(!viewId.equals("")){
					props.setProperty("viewId", viewId);
				}
				try{
					Properties props_old = new Properties();		
					props_old.load(new FileInputStream(defaultPath));
					props.setProperty("analyticsKeyFile", NullUtil.nullString(props_old.getProperty("analyticsKeyFile")));
				} catch (IOException e){
					log.error(e.getMessage());
				}catch (Exception e) {
					//log.error(e.getMessage());
					log.debug("기존 Properties 로드 에러");
				}
				
					
				try{
						HashMap<String, EgovFormBasedFileVo> fileList = EgovFileUploadUtil.uploadFormFiles(request, uploadDir, 1024 * 1024 * 10);	
						Iterator fileItr = fileList.keySet().iterator();
						
						while(fileItr.hasNext()){
							String key = (String)fileItr.next();		
							EgovFormBasedFileVo item = (EgovFormBasedFileVo)fileList.get(key);
							Calendar cal = Calendar.getInstance();
					        SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
							props.setProperty("analyticsKeyFile", dayTime.format(cal.getTime())+"/"+item.getPhysicalName());				
						}
						
				} catch (NullPointerException e){
					log.error(e.getMessage());
				}catch (Exception e) {
					log.error(e.getMessage());
				}
				
			try{	
				FileOutputStream fos = new FileOutputStream(defaultPath);
				props.store(fos, "(by Jnitcms 3.5)");
				JnitFilegoUtil.transferFile(JnitFilegoFileType.CONFIG, defaultPath);		//Filego 배포
				if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
			}catch(IOException e){
				log.error(e.getMessage());
			}
    	return "redirect:"+request.getHeader("referer");
    }
    
    @RequestMapping("/cms/config/snslogin.do")
    public String getsnsloginConfig(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	AdminUtil.setMenuId("m01010500");
		String debug = EgovProperties.getProperty("Globals.Debug");
		String analyticsPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/snsloginProp.prop";
		
		Properties snslogin = new Properties();
		File currentDefaultPropFile = new File(analyticsPath);
		InputStreamReader isr = null;
		FileInputStream fis = null;
		if(currentDefaultPropFile.exists()){
			try {
				fis = new FileInputStream(currentDefaultPropFile);
				isr = new InputStreamReader(fis, "UTF-8");
				snslogin.load(isr);
			} catch (UnsupportedEncodingException e) {
				log.error(e.getMessage());
			} catch (FileNotFoundException e) {
				log.error(e.getMessage());
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
			
		}
		model.addAttribute("snslogin", snslogin);
		return "jnit/cms/config/snslogin";
    }    
    
    
  //통계설정 저장
    @RequestMapping("/cms/config/snsloginSave.do")
    public String snsloginSaveConfig(HttpServletRequest request, ModelMap model) throws IOException {
    	
    	String defaultDir = PathUtil.getRealPath(request)+"WEB-INF/config/jnit";
    	String defaultPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/snsloginProp.prop";
		
    	File file = new File(defaultDir);
    	if(!file.exists()){
    		file.mkdir();
    	}
			String facebookOauthId = NullUtil.nullString(request.getParameter("facebookOauthId"));
			String facebookOauthSecret = NullUtil.nullString(request.getParameter("facebookOauthSecret"));
			String googleOauthId = NullUtil.nullString(request.getParameter("googleOauthId"));
			String googleOauthSecret = NullUtil.nullString(request.getParameter("googleOauthSecret"));
			String twitterOauthId = NullUtil.nullString(request.getParameter("twitterOauthId"));
			String twitterOauthSecret = NullUtil.nullString(request.getParameter("twitterOauthSecret"));
			String naverOauthId = NullUtil.nullString(request.getParameter("naverOauthId"));
			String naverOauthSecret = NullUtil.nullString(request.getParameter("naverOauthSecret"));
			String kakaoOauthId = NullUtil.nullString(request.getParameter("kakaoOauthId"));
			String kakaoOauthSecret = NullUtil.nullString(request.getParameter("kakaoOauthSecret"));
			
			
			Properties props = new Properties();		
			
			if(!facebookOauthId.equals("")){
				props.setProperty("facebookOauthId", facebookOauthId);
			}
			if(!facebookOauthSecret.equals("")){
				props.setProperty("facebookOauthSecret", facebookOauthSecret);
			}
			if(!googleOauthId.equals("")){
				props.setProperty("googleOauthId", googleOauthId);
			}
			if(!googleOauthSecret.equals("")){
				props.setProperty("googleOauthSecret", googleOauthSecret);
			}
			if(!twitterOauthId.equals("")){
				props.setProperty("twitterOauthId", twitterOauthId);
			}
			if(!twitterOauthSecret.equals("")){
				props.setProperty("twitterOauthSecret", twitterOauthSecret);
			}
			if(!naverOauthId.equals("")){
				props.setProperty("naverOauthId", naverOauthId);
			}
			if(!naverOauthSecret.equals("")){
				props.setProperty("naverOauthSecret", naverOauthSecret);
			}
			if(!kakaoOauthId.equals("")){
				props.setProperty("kakaoOauthId", kakaoOauthId);
			}
			if(!naverOauthSecret.equals("")){
				props.setProperty("kakaoOauthSecret", kakaoOauthSecret);
			}
				
			FileOutputStream fos = new FileOutputStream(defaultPath);
			props.store(fos, "(by Jnitcms 3.5)");
			if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
			JnitFilegoUtil.transferFile(JnitFilegoFileType.CONFIG, defaultPath);		//Filego 배포
    	return "redirect:"+request.getHeader("referer");
    }
    
    //보안설정 List
    @RequestMapping("/cms/config/secure.do")
    public String getSecConfig(HttpServletRequest request, ModelMap model) throws IOException {
    	AdminUtil.setMenuId("m01020000");
		String debug = EgovProperties.getProperty("Globals.Debug");

		File currentPropFile = new File( EgovProperties.GLOBALS_PROPERTIES_FILE );
		if(debug.equals("true")) log.debug(currentPropFile.getPath());
		if(currentPropFile.exists()) {
			if(debug.equals("true")) log.debug("use props.");
			InputStreamReader isr = null;
			FileInputStream fis = null;
			Properties cProps = new Properties();
			try {
				fis = new FileInputStream(currentPropFile);
				isr = new InputStreamReader(fis, "UTF-8");
				cProps.load(isr);
			} catch (FileNotFoundException e) {
				if(debug.equals("true")) log.error(e.getMessage());
			} catch (IOException e) {
				if(debug.equals("true")) log.error(e.getMessage());
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
			
			model.addAttribute("props", cProps);
		}
		
		String securePath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/secureProp.prop";
		Properties secureProp = new Properties();
		File currentSecurePropFile = new File(securePath);
		InputStreamReader isr = null;
		FileInputStream fis = null;
		String[] ipList = null; 
		
		if(currentSecurePropFile.exists()){
			try {
				fis = new FileInputStream(currentSecurePropFile);
				isr = new InputStreamReader(fis, "UTF-8");
				secureProp.load(isr);
			} catch (UnsupportedEncodingException e) {
				log.error(e.getMessage());
			} catch (FileNotFoundException e) {
				log.error(e.getMessage());
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}			
			try{
				String ips = secureProp.getProperty("ipList");
				String[] ipArr = ips.split("//");
				if(!NullUtil.nullString(ipArr[0]).equals("")){
					ipList = new String[ipArr.length];
					for(int i=0; i<ipArr.length; i++){
						ipList[i] = ipArr[i];
					}
				}
			} catch (NullPointerException e){
				log.error(e.getMessage());
			}catch(Exception e){
				log.error(e.getMessage());
			}
			model.addAttribute("secureProp", secureProp);
			model.addAttribute("ipList", ipList);
		}
		
		model.addAttribute("myIP", request.getRemoteAddr());
		return "jnit/cms/config/secure";
    }
    
    //보안설정 저장
    @RequestMapping("/cms/config/secureSave.do")
    public String secureSaveConfig(HttpServletRequest request, ModelMap model) throws IOException {
    	
    	String secureDir = PathUtil.getRealPath(request)+"WEB-INF/config/jnit";;
    	String securePath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/secureProp.prop";
		
		Properties props = new Properties();		//값이 없으면 Default값 = 1(사용함)
    	File file = new File(secureDir);
    	
    	if(!file.exists()){
    		file.mkdir();
    	}
    	
		String secpw = NullUtil.nullString(request.getParameter("secpw"));
		String sec = NullUtil.nullString(request.getParameter("sec"));
		String ipFilterType = NullUtil.nullString(request.getParameter("ipFilterType"));
		String ipArr[] = request.getParameterValues("iplist");
		String ipList = "";
		
		if(!secpw.equals("")){
			props.setProperty("secpw", secpw);
		}else{
			props.setProperty("secpw", "2");
		}
		if(!sec.equals("")){
			props.setProperty("sec", sec);
		}else{
			props.setProperty("sec", "1");
		}
		if(!ipFilterType.equals("")){
			props.setProperty("ipFilterType", ipFilterType);
		}else{
			props.setProperty("ipFilterType", "1");
		}
		
		try{
			if(!NullUtil.nullString(ipArr[0]).equals("")){
				if(ipArr.length > 1){
					for(int i=0; i<ipArr.length; i++){
						ipList += "//"+ipArr[i];
					}
				}else{
					ipList = ipArr[0];
				}
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
		}catch(Exception e){
			log.error(e.getMessage());
		}
		props.setProperty("ipList", ipList.replaceFirst("//", ""));
		FileOutputStream fos = new FileOutputStream(securePath);
		props.store(fos, "(by Jnitcms 3.5)");
		if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
		JnitFilegoUtil.transferFile(JnitFilegoFileType.CONFIG, securePath);		//Filego 배포
    	return "redirect:"+request.getHeader("referer");
    }
    
    //smsList
    @RequestMapping("/cms/config/sms.do")
    public String getSmsConfig(HttpServletRequest request, ModelMap model) throws IOException {
    	AdminUtil.setMenuId("m06060100");
		String debug = EgovProperties.getProperty("Globals.Debug");

		File currentPropFile = new File( EgovProperties.GLOBALS_PROPERTIES_FILE );
		if(debug.equals("true")) log.debug(currentPropFile.getPath());
		if(currentPropFile.exists()) {
			if(debug.equals("true")) log.debug("use props.");
			InputStreamReader isr = null;
			FileInputStream fis = null;
			Properties cProps = new Properties();
			try {
				fis = new FileInputStream(currentPropFile);
				isr = new InputStreamReader(fis, "UTF-8");
				cProps.load(isr);
			} catch (FileNotFoundException e) {
				if(debug.equals("true")) log.error(e.getMessage());
			} catch (IOException e) {
				if(debug.equals("true")) log.error(e.getMessage());
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
			
			model.addAttribute("props", cProps);
		}
		String smsPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/smsProp.prop";
		Properties smsProp = new Properties();
		File currentSmsPropFile = new File(smsPath);
		InputStreamReader isr = null;
		FileInputStream fis = null;
		if(currentSmsPropFile.exists()){
			try {
				fis = new FileInputStream(currentSmsPropFile);
				isr = new InputStreamReader(fis, "UTF-8");
				smsProp.load(isr);
			} catch (FileNotFoundException e) {
				log.error(e.getMessage());
			} catch (UnsupportedEncodingException e) {
				log.error(e.getMessage());
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
			model.addAttribute("smsProp", smsProp);
		}
		
		return "jnit/cms/config/sms";
    }
    
    //SMS설정 저장
    @RequestMapping("/cms/config/smsSave.do")
    public String smsSaveConfig(HttpServletRequest request, ModelMap model) throws IOException {
    	
    	String smsDir = PathUtil.getRealPath(request)+"WEB-INF/config/jnit";
    	String smsPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/smsProp.prop";

    	String smsId = NullUtil.nullString(request.getParameter("smsId"));				//SMS ID
		String smsPw = NullUtil.nullString(request.getParameter("smsPw"));				//SMS 패스워드
		String smsType = NullUtil.nullString(request.getParameter("smsType"));				//SMS 사용할 유형 		( MGOV, LTS 등 ... )
		String memberTypeUse = NullUtil.nullString(request.getParameter("memberTypeUse"));		//회원 유형 사용 여부 		( 사용 : Y, 비사용 : Y가 아닌 나머지값 )
		String mbrCheck = NullUtil.nullString(request.getParameter("mbrCheck"));				//회원조회 기능 사용 여부 ( 사용 : Y, 비사용 : N )
		String memberType = NullUtil.nullString(request.getParameter("memberType"));			//회원 유형				( EX : 30020, 30021 )
		String loginMemberUse = NullUtil.nullString(request.getParameter("loginMemberUse"));		//로그인 회원 사용 여부 	( 사용 : Y, 비사용 : Y가 아닌 나머지값 )
		String smsMaxCount = NullUtil.nullString(request.getParameter("smsMaxCount"));			//SMS 분할 전송시 최대 분할 갯수
		
		String defaultTel0 = NullUtil.nullString(request.getParameter("defaultTel0"));			//보내는 사람의 기본으로 지정한 번호0
		String defaultTel1 = NullUtil.nullString(request.getParameter("defaultTel1"));			//보내는 사람의 기본으로 지정한 번호1
		String defaultTel2 = NullUtil.nullString(request.getParameter("defaultTel2"));			//보내는 사람의 기본으로 지정한 번호2
		String defaultTel3 = NullUtil.nullString(request.getParameter("defaultTel3"));			//보내는 사람의 기본으로 지정한 번호3
		String defaultTel4 = NullUtil.nullString(request.getParameter("defaultTel4"));			//보내는 사람의 기본으로 지정한 번호4
		String defaultTel5 = NullUtil.nullString(request.getParameter("defaultTel5"));			//보내는 사람의 기본으로 지정한 번호5
		String defaultTel6 = NullUtil.nullString(request.getParameter("defaultTel6"));			//보내는 사람의 기본으로 지정한 번호6
		String defaultTel7 = NullUtil.nullString(request.getParameter("defaultTel7"));			//보내는 사람의 기본으로 지정한 번호7
		String defaultTel8 = NullUtil.nullString(request.getParameter("defaultTel8"));			//보내는 사람의 기본으로 지정한 번호8
		String defaultTel9 = NullUtil.nullString(request.getParameter("defaultTel9"));			//보내는 사람의 기본으로 지정한 번호9
		
		String defaultNm0 = NullUtil.nullString(request.getParameter("defaultNm0"));			//보내는 사람의 기본으로 지정한 이름0
		String defaultNm1 = NullUtil.nullString(request.getParameter("defaultNm1"));			//보내는 사람의 기본으로 지정한 이름1
		String defaultNm2 = NullUtil.nullString(request.getParameter("defaultNm2"));			//보내는 사람의 기본으로 지정한 이름2
		String defaultNm3 = NullUtil.nullString(request.getParameter("defaultNm3"));			//보내는 사람의 기본으로 지정한 이름3
		String defaultNm4 = NullUtil.nullString(request.getParameter("defaultNm4"));			//보내는 사람의 기본으로 지정한 이름4
		String defaultNm5 = NullUtil.nullString(request.getParameter("defaultNm5"));			//보내는 사람의 기본으로 지정한 이름5
		String defaultNm6 = NullUtil.nullString(request.getParameter("defaultNm6"));			//보내는 사람의 기본으로 지정한 이름6
		String defaultNm7 = NullUtil.nullString(request.getParameter("defaultNm7"));			//보내는 사람의 기본으로 지정한 이름7
		String defaultNm8 = NullUtil.nullString(request.getParameter("defaultNm8"));			//보내는 사람의 기본으로 지정한 이름8
		String defaultNm9 = NullUtil.nullString(request.getParameter("defaultNm9"));			//보내는 사람의 기본으로 지정한 이름9
		
		String defaultFromNm0 = NullUtil.nullString(request.getParameter("defaultFromNm0"));		//받는 사람의 기본으로 지정한 이름0
		String defaultFromNm1 = NullUtil.nullString(request.getParameter("defaultFromNm1"));		//받는 사람의 기본으로 지정한 이름1
		String defaultFromNm2 = NullUtil.nullString(request.getParameter("defaultFromNm2"));		//받는 사람의 기본으로 지정한 이름2
    	
		Properties props = new Properties();
    	File file = new File(smsDir);
    	
    	if(!file.exists()){
    		file.mkdir();
    	}
    	
    	props.setProperty("smsId", smsId);
    	props.setProperty("smsPw", smsPw);
    	props.setProperty("smsType", smsType);
    	props.setProperty("memberTypeUse", memberTypeUse);
    	props.setProperty("memberType", memberType);
    	props.setProperty("loginMemberUse", loginMemberUse);
    	props.setProperty("mbrCheck", mbrCheck);
    	props.setProperty("smsMaxCount", smsMaxCount);
    	props.setProperty("defaultTel0", defaultTel0);
    	props.setProperty("defaultTel1", defaultTel1);
    	props.setProperty("defaultTel2", defaultTel2);
    	props.setProperty("defaultTel3", defaultTel3);
    	props.setProperty("defaultTel4", defaultTel4);
    	props.setProperty("defaultTel5", defaultTel5);
    	props.setProperty("defaultTel6", defaultTel6);
    	props.setProperty("defaultTel7", defaultTel7);
    	props.setProperty("defaultTel8", defaultTel8);
    	props.setProperty("defaultTel9", defaultTel9);
    	
    	props.setProperty("defaultNm0", defaultNm0);
    	props.setProperty("defaultNm1", defaultNm1);
    	props.setProperty("defaultNm2", defaultNm2);
    	props.setProperty("defaultNm3", defaultNm3);
    	props.setProperty("defaultNm4", defaultNm4);
    	props.setProperty("defaultNm5", defaultNm5);
    	props.setProperty("defaultNm6", defaultNm6);
    	props.setProperty("defaultNm7", defaultNm7);
    	props.setProperty("defaultNm8", defaultNm8);
    	props.setProperty("defaultNm9", defaultNm9);
    	
    	props.setProperty("defaultFromNm0", defaultFromNm0);
    	props.setProperty("defaultFromNm1", defaultFromNm1);
    	props.setProperty("defaultFromNm2", defaultFromNm2);
    	
    	FileOutputStream fos = new FileOutputStream(smsPath);
    	props.store(fos, "(by Jnitcms 3.5)");
    	if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
    	JnitFilegoUtil.transferFile(JnitFilegoFileType.CONFIG, smsPath);		//Filego 배포
    	return "redirect:"+request.getHeader("referer");
    }
    
    //apiKey 관리
    @RequestMapping("/cms/config/apiKey.do")
    public String apiKey(HttpServletRequest request, Model model) throws IOException{
    	AdminUtil.setMenuId("m01010200");
    	
    	String apiKeyPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/apiKey" + ".prop";
    	Properties prop = new Properties();
    	File propFile = new File(apiKeyPath);
    	InputStreamReader isr = null;
    	FileInputStream fis = null;
    	if(propFile.exists()){
    		try {
    			fis = new FileInputStream(propFile);
				isr = new InputStreamReader(fis, "UTF-8");
				try {
					prop.load(isr);
				} catch (IOException e) {
					log.error(e.getMessage());
				}
			} catch (UnsupportedEncodingException e) {
				log.error(e.getMessage());
			} catch (FileNotFoundException e) {
				log.error(e.getMessage());
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
			
			model.addAttribute("mapApi",prop);
    	}
    	
    	return "/jnit/cms/config/apiKey";
    }
    
  //apiKey 저장
    @RequestMapping("/cms/config/apiKeySave.do")
    public String apiKeySave(HttpServletRequest request, Model model){
    	
    	AdminUtil.setMenuId("m01010200");
    	
    	String addrKey = NullUtil.nullString(request.getParameter("addrKey"));
    	
    	String daumKey = NullUtil.nullString(request.getParameter("daumMapKey"));
    	String daumUrl = NullUtil.nullString(request.getParameter("daumMapUrl"));
    	String naverKey = NullUtil.nullString(request.getParameter("naverMapKey"));
    	String naverUrl = NullUtil.nullString(request.getParameter("naverMapUrl"));
    	String googleKey = NullUtil.nullString(request.getParameter("googleMapKey"));
    	String googleUrl = NullUtil.nullString(request.getParameter("googleMapUrl"));
    	
    	String gsmtpport = NullUtil.nullString(request.getParameter("gsmtpport"));
    	String gsmtphost = NullUtil.nullString(request.getParameter("gsmtphost"));
    	String gsmtpname = NullUtil.nullString(request.getParameter("gsmtpname"));
    	String gsmtpuser = NullUtil.nullString(request.getParameter("gsmtpuser"));
    	String gsmtppass = NullUtil.nullString(request.getParameter("gsmtppass"));
    	
    	String apiKeyPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/apiKey" + ".prop";
    	
    	Properties prop = new Properties();
    	File propFile = new File(apiKeyPath);
    	
    	prop.put("addrKey", addrKey);
    	
		prop.put("daumKey", daumKey);
		prop.put("daumUrl", daumUrl);
	    prop.put("naverKey", naverKey);
	    prop.put("naverUrl", naverUrl);
		prop.put("googleKey", googleKey);
		prop.put("googleUrl", googleUrl);
		
		prop.put("gsmtpport", gsmtpport);
		prop.put("gsmtphost", gsmtphost);
		prop.put("gsmtpname", gsmtpname);
		prop.put("gsmtpuser", gsmtpuser);
		prop.put("gsmtppass", gsmtppass);
		
		try {
			FileOutputStream fos = new FileOutputStream(propFile);
			try {
				prop.store(fos, "(by Jnitcms 3.5) MAP API KEY");
			} catch (IOException e1) {
			}
			if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
			JnitFilegoUtil.transferFile(JnitFilegoFileType.CONFIG, propFile);		//Filego 배포
		} catch (FileNotFoundException e) {
			log.error(e.getMessage());
		}
    	
    	return "redirect:"+request.getHeader("referer");
    }
    
    //가입항목 설정 list
    @RequestMapping("/cms/config/item.do")
    public String itemLsit(HttpServletRequest request, Model model)throws Exception{
    	
    	AdminUtil.setMenuId("m01010300");
    	
    	if(CmsHelper.getSessionSiteId(request).equals("")){
    		model.addAttribute("message", "지정된 사이트가 없습니다.");
    		return "jnit/cms/config/item_msg_nosite";
    	}
    	JnitmbrInfoVO jnitmbrInfoVO = new JnitmbrInfoVO();
    	String sitePropDir = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/mbrInfo"; 
    	String sitePropFile = sitePropDir+"/mbrInfo_"+CmsHelper.getSessionSiteId(request)+".prop";
    	Properties prop = new Properties();
    	File siteProp = new File(sitePropFile);
    	InputStreamReader isr = null;
    	FileInputStream fis = null;
    	if(siteProp.exists()){    		
    		try {
    			fis = new FileInputStream(siteProp);
    			isr = new InputStreamReader(fis,"UTF-8");
    			prop.load(isr);
    		} catch (IOException e){
    			log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
			
			JSONObject JSON = new JSONObject().fromObject(prop);
			jnitmbrInfoVO = (JnitmbrInfoVO) JSON.toBean(JSON, JnitmbrInfoVO.class);
			
			model.addAttribute("resultProp", prop);
    	}else{
    		model.addAttribute("message", "파일이 존재 하지 않습니다.");    		
    	}
    	model.addAttribute("jnitmbrInfoVO", jnitmbrInfoVO);
    	return "jnit/cms/config/item";
    }
    
    //가입항목 저장
    @RequestMapping("/cms/config/itemSave.do")
    public String itemSave(@ModelAttribute("jnitmbrInfoVO") JnitmbrInfoVO jnitmbrInfoVO,HttpServletRequest request, Model model)throws Exception{
    	
    	AdminUtil.setMenuId("m01010000");
    	if(CmsHelper.getSessionSiteId(request).equals("")){
    		model.addAttribute("message", "지정된 사이트가 없습니다.");
    		return "jnit/cms/config/item_msg_nosite";
    	}
    	
    	String companyAddr = NullUtil.nullString(request.getParameter("companyAddr"));
    	String configDir = PathUtil.getRealPath(request);
    	String mbrInfoDir = configDir + "WEB-INF/config/jnit/mbrInfo";
    	String StieFlie = mbrInfoDir + "/mbrInfo_"+CmsHelper.getSessionSiteId(request)+".prop";
    	
    	File mbrInfoFile = new File(mbrInfoDir);
    	if(!mbrInfoFile.exists()){ //저장시 존재하지않으면 디렉토리 생성해준다
    		mbrInfoFile.mkdirs();
    	}
    	
        Properties prope = new Properties();
        JSONObject JSON = new JSONObject().fromObject(jnitmbrInfoVO);
    	Iterator itr = JSON.keySet().iterator();
    	while (itr.hasNext()) {
			String key = (String) itr.next();
			prope.setProperty(key, JSON.get(key).toString());
		}
        
    	try {
			FileOutputStream fos = new FileOutputStream(StieFlie);
			prope.store(fos, "(by Jnitcms 3.5)");
			if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
			JnitFilegoUtil.transferFile(JnitFilegoFileType.CONFIG, StieFlie);		//Filego 배포
    	} catch (IOException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
    	return  "redirect:"+request.getHeader("referer");
    }
    
    @RequestMapping("/cms/config/ajax/site.do")
    public String ajaxSite(@ModelAttribute("searchVO") JnitcmssiteDefaultVO searchVO 
    		,HttpServletRequest request, ModelMap model)throws Exception{
    	 
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(5);
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());		
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit()); 
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List resultList = jnitcmssiteService.selectJnitcmssiteList(searchVO);
		
		int totCnt = jnitcmssiteService.selectJnitcmssiteListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
    	return "jnit/cms/config/site";
    }
    
    @RequestMapping("/cms/config/mgmt/file/list.do")
	public String mgmtDefaultFileList(HttpServletRequest request, ModelMap model)throws Exception{
    	//JSON
    	AdminJSON(request);
    	
		String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));		
		String root = PathUtil.getRealPath(request);
		
		String defaultDir = root + "default/common/"+mgmtType;
		String defaultFileDir = root+"/WEB-INF/jsp/jnit/cms/mgmt/default/"+mgmtType+"/default.json";
		
		File jsonFile = new File(defaultFileDir);
		File file = new File(defaultDir);
		
		FilenameFilter filenameFilter = new FilenameFilter() {
			public boolean accept(File dir, String name) {
				if(!".svn".equals(name)){
					return true;
				}else{
					return false;
				}
			}
		};
		String[] filenames = file.list(filenameFilter);
		
		JSONObject JSON = new JSONObject();		
		if(jsonFile.exists()){
			JSON = new JSONObject().fromObject(CmsHandler.readFile(defaultFileDir));
			String msg2 = "";
			for(int i=0; i<filenames.length; i++){
				int num = JSON.size();				
				String filename = filenames[i].substring(0,filenames[i].lastIndexOf("."));
				if(JSON.get(filename) == null){										
					JSON.put(filename, num);
					msg2 += (!"".equals(msg2) ? ", " : "")+filename+"["+num+"]";
				}
			}
			
			String msg = ""; 
			JSONObject JSON2 = new JSONObject();		
			Iterator itr = JSON.keySet().iterator();
			while (itr.hasNext()) {
				String key = (String) itr.next();
				String fileExistsDir = defaultDir+"/"+key+"."+mgmtType;
				File fileExists = new File(fileExistsDir);
				
				if(fileExists.exists()){
					JSON2.put(key, JSON.get(key));
				}else{
					msg += (!"".equals(msg) ? "," : "")+key;
				}
			}
			JSON.clear();
			JSON = JSON2;
			
			if(!"".equals(msg2)) model.addAttribute("msg2", msg2);
			if(!"".equals(msg)) model.addAttribute("msg", msg);			
		}else{
			if(file.exists()){
				for(int i=0; i<filenames.length; i++){
					String filename = filenames[i].substring(0,filenames[i].lastIndexOf("."));
					JSON.put(filename, i);
				}
			}
		}
		
		File defaultFile = new File(root+"/WEB-INF/jsp/jnit/cms/mgmt/default/"+mgmtType);
		if(!defaultFile.exists()) defaultFile.mkdirs();
		CmsHandler.writeFile(defaultFileDir, JSON.toString());
		
		model.addAttribute("resultList", JSON.keySet());
		model.addAttribute("JSONn", JSON);
		model.addAttribute("size", JSON.size());
		model.addAttribute("mgmtType", mgmtType);
		
		return "/jnit/cms/config/mgmtFile";
	}
	
	@RequestMapping("/cms/config/mgmt/file/save.do")
	public String mgmtDefaultFileSave(HttpServletRequest request, ModelMap model)throws Exception{
		
		String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));
		int size = NullUtil.nullInt(request.getParameter("size"));
		
		String root = PathUtil.getRealPath(request);
		String defaultFileDir = root+"/WEB-INF/jsp/jnit/cms/mgmt/default/"+mgmtType+"/default.json";
		
		JSONObject JSON = new JSONObject();		
		if(size != 0){
			for(int i=0; i<size; i++){
				String num = String.valueOf(i+1);
				String filename = request.getParameter("filename"+num);
				int sort = NullUtil.nullInt(request.getParameter("sort"+num));
							
				JSON.put(filename, sort);
			}			
		}
		
		File file = new File(root+"/WEB-INF/jsp/jnit/cms/mgmt/default/"+mgmtType);
		if(!file.exists()){
			file.mkdirs();
		}
		
		CmsHandler.writeFile(defaultFileDir, JSON.toString());
		JnitFilegoUtil.transferFile(JnitFilegoFileType.CONFIG, defaultFileDir);		//Filego 배포
		
		model.addAttribute("alert", "저장되었습니다.");
		model.addAttribute("path", "/cms/config/mgmt/file/list.do?mgmtType="+mgmtType);
		return "/jnit/util/alertMove";
	}
	
	private void AdminJSON(HttpServletRequest request)throws Exception{
		String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));
		if("css".equals(mgmtType)){
			AdminUtil.setMenuId("m02050000");
		}else if("js".equals(mgmtType)){
			AdminUtil.setMenuId("m02060000");
		}
	}
	
	public static Properties getCmsDefaultProp(HttpServletRequest request){
		
		String defaultPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/defaultProp.prop";
		Properties defaultProp = new Properties();
		File currentDefaultPropFile = new File(defaultPath);
		InputStreamReader isr = null;
		FileInputStream fis = null;
		if(currentDefaultPropFile.exists()){
			try {
				fis = new FileInputStream(currentDefaultPropFile);
				isr = new InputStreamReader(fis, "UTF-8");
				defaultProp.load(isr);
			} catch (UnsupportedEncodingException e) {
				defaultProp = new Properties();
				log.error(e.getMessage());
			} catch (FileNotFoundException e) {
				defaultProp = new Properties();
				log.error(e.getMessage());
			} catch (IOException e) {
				defaultProp = new Properties();
				log.error(e.getMessage());
			} finally {
				if(isr != null){
					try {
						isr.close();
					} catch (IOException e) {
						defaultProp = new Properties();
						log.error(e.getMessage());
					}
				}
				if(fis != null){
					try {
						fis.close();
					} catch (IOException e) {
						defaultProp = new Properties();
						log.error(e.getMessage());
					}
				}
			}			
		}
		
		return defaultProp;
	}
}