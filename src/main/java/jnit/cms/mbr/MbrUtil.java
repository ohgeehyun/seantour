/**
 * @version 3.2.0.1
 */
package jnit.cms.mbr;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import jnit.cms.mbrlog.JnitcmsmbrlogService;
import jnit.cms.mbrlog.JnitcmsmbrlogVO;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;



public class MbrUtil {
	
	public static Log log = LogFactory.getLog(MbrUtil.class);
	
	public static String propFile = "WEB-INF/config/jnit/defaultProp.prop";
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
	
	
	//PropertiesFile read static class	
    public static Properties defaultPropFile(Properties porp,String propPath)throws Exception{
    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	String propertiesPath = PathUtil.getRealPath(request)+propPath;
    	
		File currentDefaultPropFile = new File(propertiesPath);
		InputStreamReader isr = null;
		FileInputStream fis = null;
		if(currentDefaultPropFile.exists()){
			try {
				fis = new FileInputStream(currentDefaultPropFile);
				isr = new InputStreamReader(fis, "UTF-8");
				porp.load(isr);
			} catch (UnsupportedEncodingException e) {
				log.error(e.getMessage());
			} catch (FileNotFoundException e) {
				log.error(e.getMessage());
			}finally{
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}			
		}
		return porp ; //propPagth경로의 File을 읽은 후 파일을 리턴한다.
    }
    //End of PropertiesFile read
    
    //Boolean 실명인증 return
    public static Boolean siauth()throws Exception{
    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	Properties siauth = new Properties();
    	siauth = defaultPropFile(siauth, propFile);
    	
    	String siauthFile = siauth.getProperty("siauth", ""); 
    	
    	if(siauthFile.equals("0")){    		
    		return false; 
    	}else{    		
    		return true; 
    	} 	
    }
    //End of Boolean 실명인증
    
    //Boolean G-Pin return
    public static Boolean gpinauth()throws Exception{
    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	Properties gpinauth = new Properties();
    	gpinauth = defaultPropFile(gpinauth, propFile);
    	
    	String siauthFile = gpinauth.getProperty("gpinauth", "");
    	
    	if(siauthFile.equals("0")){    		
    		return false;
    	}else{    		
    		return true; 
    	} 	
    }
    //End of Boolean G-Pin
    
    //Boolean 공인인증서 return
    public static Boolean pkiauth()throws Exception{
    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	Properties pkiauth = new Properties();
    	pkiauth = defaultPropFile(pkiauth, propFile);
    	
    	String siauthFile = pkiauth.getProperty("pkiauth", "");
    	
    	if(siauthFile.equals("0")){    		
    		return false; 
    	}else{    		
    		return true; 
    	} 	
    }
    //End of Boolean 공인인증서
    
    //유효성검사 
    public static Boolean getPatten(String var1, String patten){
		if(!var1.equals("")){
    		Boolean bln_var1 = java.util.regex.Pattern.matches(patten, var1);
    		if(bln_var1){ //success
    			return true;
    		}else{
    			return false;
    		}
    	}
    	return true;
    }
    
    public static Boolean getPatten2(String var1, String var2, String patten){    	
		if(var1.equals("") && !var2.equals("")){				
			return false;
		}else if(!var1.equals("") && var2.equals("")){				
			return false;
		}else if(!var1.equals("") && !var2.equals("")){
			Boolean bln_var1 = java.util.regex.Pattern.matches(patten, var1);
			Boolean bln_var2 = java.util.regex.Pattern.matches(patten, var2);
			if(bln_var1 && bln_var2){       //success 
				return true;
			}else {					
				return false;
			}
		}
    	return true;
    }
    public static Boolean getPatten3(String var1, String var2, String var3, String patten){    	
		if(var1.equals("") && !var2.equals("") && !var3.equals("")){
			return false;
		}else if(!var1.equals("") && var2.equals("") && !var3.equals("")){
			return false;
		}else if(!var1.equals("") && !var2.equals("") && var3.equals("") ){
			return false;
		}else if(!var1.equals("") && var2.equals("") && var3.equals("") ){
			return false;
		}else if(var1.equals("") && var2.equals("") && !var3.equals("") ){
			return false;
		}else if(!var1.equals("") && !var2.equals("") && !var3.equals("") ){
			Boolean bln_var1 = java.util.regex.Pattern.matches(patten, var1);
			Boolean bln_var2 = java.util.regex.Pattern.matches(patten, var2);
			Boolean bln_var3 = java.util.regex.Pattern.matches(patten, var3);
			if(bln_var1 && bln_var2 && bln_var3){       //success 
				return true;
			}else {
				return false;
			}
		}
    	return true;
    }
    
    public static Boolean getPatten4(String var1, String var2, String var3){    	
		if(var1.equals("") && !var2.equals("") && !var3.equals("")){
			return false;
		}else if(!var1.equals("") && var2.equals("") && !var3.equals("")){
			return false;
		}else if(!var1.equals("") && !var2.equals("") && var3.equals("") ){
			return false;
		}else if(!var1.equals("") && var2.equals("") && var3.equals("") ){
			return false;
		}else if(var1.equals("") && var2.equals("") && !var3.equals("") ){
			return false;
		}
    	return true;
    }
    //End 유효성검사
    
    public static Boolean limitNm(String str)throws Exception{
    	str = NullUtil.nullString(str);
    	if(!"".equals(str)){
    		String[] limitNm = {"admin","test","테스트","guest"};
    		for(int i=0; i<limitNm.length; i++){
    			if(str.equals(limitNm[i])){
    				return true;
    			}
    		}
    	}
    	return false;
    }
    
    
    /**
     * 여분필드 ex01 값을 받아 제어한다.
     * @param request
     * @param propJSON - 해당 사이트 가입항목설정 프로퍼티 값
     * @param patten - 정규식
     * @param ex01Msg1 - 정규식에 대한 멘트
     * @param ex01Msg2 - 필수값에 대한 멘트
     * @return JSON
     * @throws Exception
     */
    public static JSONObject setEx01(HttpServletRequest request, JSONObject propJSON, String patten, String ex01Msg1)throws Exception{
    	JSONObject JSON = new JSONObject();
    	String ex01 = "";
    	try {
    		if("multiinput".equals(propJSON.get("ex01Type").toString())){
    			String ex01_1 = NullUtil.nullString(request.getParameter("ex01_1"));
    			String ex01_2 = NullUtil.nullString(request.getParameter("ex01_2"));
    			String ex01_3 = NullUtil.nullString(request.getParameter("ex01_3"));
    			
    			if(!"".equals(ex01_1) || !"".equals(ex01_2) || !"".equals(ex01_3)){    				
    				if(!MbrUtil.getPatten4(ex01_1, ex01_2, ex01_3)){
    					JSON.put("alert", ex01Msg1);
        			}else{
        				ex01 = ex01_1+"-"+ex01_2+"-"+ex01_3;
        			}  
    			}
    		}else if(request.getParameterValues("ex01") != null){
    			String[] ex01s = request.getParameterValues("ex01");
        		for(int i=0; i<ex01s.length; i++){        			
        			ex01 += ("".equals(ex01) ? "" : ",") +  ex01s[i];
        		}
    		}        	
    		if(Integer.parseInt(propJSON.get("ex01Add").toString()) == 2){
        		if("".equals(ex01)){
        			JSON.put("alert", ex01Msg1);
        		}
    		}
        	JSON.put("ex01", ex01);
    	} catch (IllegalArgumentException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			if("true".equals(deDug)) log.debug(e.getMessage());
		}
    	return JSON;
    }
    
    /**
     * 여분필드 ex02 값을 받아 제어한다.
     * @param request
     * @param propJSON - 해당 사이트 가입항목설정 프로퍼티 값
     * @param patten - 정규식
     * @param ex02Msg1 - 정규식에 대한 멘트
     * @param ex02Msg2 - 필수값에 대한 멘트
     * @return JSON
     * @throws Exception
     */
    public static JSONObject setEx02(HttpServletRequest request, JSONObject propJSON, String patten, String ex02Msg1)throws Exception{
    	JSONObject JSON = new JSONObject();
    	String ex02 = "";
    	try {
    		if("multiinput".equals(propJSON.get("ex02Type").toString())){
    			String ex02_1 = NullUtil.nullString(request.getParameter("ex02_1"));
    			String ex02_2 = NullUtil.nullString(request.getParameter("ex02_2"));
    			String ex02_3 = NullUtil.nullString(request.getParameter("ex02_3"));
    			
    			if(!"".equals(ex02_1) || !"".equals(ex02_2) || !"".equals(ex02_3)){    				
    				if(!MbrUtil.getPatten4(ex02_1, ex02_2, ex02_3)){
    					JSON.put("alert", ex02Msg1);
        			}else{
        				ex02 = ex02_1+"-"+ex02_2+"-"+ex02_3;
        			}  
    			}
    		}else if(request.getParameterValues("ex02") != null){
    			String[] ex02s = request.getParameterValues("ex02");
        		for(int i=0; i<ex02s.length; i++){        			
        			ex02 += ("".equals(ex02) ? "" : ",") +  ex02s[i];
        		}
    		}        	
    		if(Integer.parseInt(propJSON.get("ex02Add").toString()) == 2){
        		if("".equals(ex02)){
        			JSON.put("alert", ex02Msg1);
        		}
    		}
        	JSON.put("ex02", ex02);
    	} catch (IllegalArgumentException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			if("true".equals(deDug)) log.debug(e.getMessage());
		}
    	return JSON;
    }
    
    /**
     * 여분필드 ex03 값을 받아 제어한다.
     * @param request
     * @param propJSON - 해당 사이트 가입항목설정 프로퍼티 값
     * @param patten - 정규식
     * @param ex03Msg1 - 정규식에 대한 멘트
     * @param ex03Msg2 - 필수값에 대한 멘트
     * @return JSON
     * @throws Exception
     */
    public static JSONObject setEx03(HttpServletRequest request, JSONObject propJSON, String patten, String ex03Msg1)throws Exception{
    	JSONObject JSON = new JSONObject();
    	String ex03 = "";
    	try {
    		if("multiinput".equals(propJSON.get("ex03Type").toString())){
    			String ex03_1 = NullUtil.nullString(request.getParameter("ex03_1"));
    			String ex03_2 = NullUtil.nullString(request.getParameter("ex03_2"));
    			String ex03_3 = NullUtil.nullString(request.getParameter("ex03_3"));
    			
    			if(!"".equals(ex03_1) || !"".equals(ex03_2) || !"".equals(ex03_3)){    				
    				if(!MbrUtil.getPatten4(ex03_1, ex03_2, ex03_3)){
    					JSON.put("alert", ex03Msg1);
        			}else{
        				ex03 = ex03_1+"-"+ex03_2+"-"+ex03_3;
        			}  
    			}
    		}else if(request.getParameterValues("ex03") != null){
    			String[] ex03s = request.getParameterValues("ex03");
        		for(int i=0; i<ex03s.length; i++){        			
        			ex03 += ("".equals(ex03) ? "" : ",") +  ex03s[i];
        		}
    		}        	
    		if(Integer.parseInt(propJSON.get("ex03Add").toString()) == 2){
        		if("".equals(ex03)){
        			JSON.put("alert", ex03Msg1);
        		}
    		}
        	JSON.put("ex03", ex03);
    	} catch (IllegalArgumentException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			if("true".equals(deDug)) log.debug(e.getMessage());
		}
    	return JSON;
    }
    
    public static void insertMbrlog(HttpServletRequest request, JnitcmsmbrVO jnitcmsmbrVO,JnitcmsmbrVO loginVO, String content, String site, String typeNm)throws Exception{
    	HttpSession session = request.getSession();
    	ServletContext context = session.getServletContext();
    	WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
    	JnitcmsmbrlogService jnitcmsmbrlogService = (JnitcmsmbrlogService) wContext.getBean("jnitcmsmbrlogService");
    	
    	JnitcmsmbrlogVO mbrlogVO = new JnitcmsmbrlogVO();
    	mbrlogVO.setMbrId(jnitcmsmbrVO.getMbrId());
    	mbrlogVO.setMbrLogin(jnitcmsmbrVO.getMbrLogin());
    	mbrlogVO.setMbrNm(jnitcmsmbrVO.getMbrNm());
    	mbrlogVO.setMbrlogContent(content);
    	mbrlogVO.setMbrIp(request.getRemoteAddr());
    	mbrlogVO.setActMbrLogin(loginVO.getMbrLogin());
    	mbrlogVO.setMbrlogPath(site);
    	mbrlogVO.setMbrlogExt01(typeNm);
    	jnitcmsmbrlogService.insertJnitcmsmbrlog(mbrlogVO);
    }
}
