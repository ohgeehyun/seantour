/**
 * @version 3.2.0.1
 */
package jnit.cms.config;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.com.utl.fcc.service.NullUtil;
import jnit.cms.CmsManageSub2_1Controller;
import jnit.cms.CmsManageSub4_4Controller;
import jnit.cms.handler.CmsHandler;
import jnit.cms.tpl.tplUtil;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;
	
public class ConfigUtil {	
	
	public static Log log = LogFactory.getLog(ConfigUtil.class);
	
	/**
	 * 가입항목설정의 프로퍼티 값을 JSONObject 리턴한다.
	 * @param siteId
	 * @return JSONObject
	 * @throws Exception
	 * {@link CmsManageSub2_1Controller#mbrProperties},각 signupAdd.jsp,myPage.jsp
	 */
	public static JSONObject getProp(String siteId)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		
		Properties prop = new Properties();		
		InputStreamReader isr = null;
		FileInputStream fis = null;
		JSONObject jsonProp = new JSONObject();
		if(ConfigUtil.getSiteId(NullUtil.nullString(siteId))){			
			String propDir = PathUtil.getRealPath(request) + "WEB-INF/config/jnit/mbrInfo";
			String PropFileDir = propDir + "/mbrInfo_"+siteId+".prop";			
			
			File propFile = new File(PropFileDir);
			if(propFile.exists()){
				try {
					fis = new FileInputStream(propFile);
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
					Enumeration<Object> enumeration = prop.keys();
					while (enumeration.hasMoreElements()) {
						String key = (String) enumeration.nextElement();
						jsonProp.put(key, prop.get(key));
					}
			}else{
				//에러처리
				jsonProp.put("error", "파일이 없습니다.");			
			}
		}		
		return jsonProp;
	}
	
	/**
	 * 환경설정-일반설정의 원하는 프로퍼티값을 리턴한다.
	 * @param key - ROOT/WEB-INF/config/jnit/defaultProp.prop 프로퍼티의 키
	 * @return String -  키값
	 * @throws Exception
	 */
	public static String getDefaultProp(String key)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		
		Properties prop = new Properties();		
		InputStreamReader isr = null;
		FileInputStream fis = null;
    	//Boolean bln = false;
		String value="";			
		String propDir = PathUtil.getRealPath(request) + "WEB-INF/config/jnit/defaultProp.prop";
		
		File propFile = new File(propDir);
		if(propFile.exists()){
			try {
				fis = new FileInputStream(propFile);
				isr = new InputStreamReader(fis);
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
			try {
				value = prop.get(key).toString();
			} catch (NullPointerException e) {
				log.error(e.getMessage());
			}			
		}else{
			
		}
		if(value == null) value = "";
		return value;
	}
	
	public static Boolean getSiteId(String siteId)throws Exception{
		if(NullUtil.nullString(siteId).equals("")){ //siteId 값 체크  
			return false;  
		}
		return true;
	}
	
	/**
	 * E - 회원가입 항목입력 G-마이페이지 의 치환코드 무결성 검사를 실행한다.
	 * @param sitePath - 사이트경로
	 * @param fileName - 실제파일이름
	 * @param tplType - 타입
	 * @param siteId
	 * @return 하나라도 적용되지않은 치환코드
	 * @throws Exception
	 * {@link CmsManageSub4_4Controller#updateJnitcmstplView},각 signupAdd.jsp, myPage 에서 검사
	 */
	public static String getErrorCode(String sitePath,String fileName, String tplType, String siteId) throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String errorCodeList = "";
		Properties prop = ConfigUtil.mbrInfoProp(siteId);
	
		String root = PathUtil.getRealPath(request);
		String cofigFileDir = root+"/"+sitePath+"/mbr/"+fileName+".jsp";
				
		String fileStr = NullUtil.nullString(CmsHandler.readFile(cofigFileDir));
		
		 //치환코드 무결성 검사
        if(tplType.equals("E") || tplType.equals("G")){
            HashMap<String, String> propMap = ConfigUtil.mbrChangeCode(tplType);
            
            Iterator propKeyItor = propMap.keySet().iterator();
            String replaceKey = "";
            while (propKeyItor.hasNext()) {
    			String key = (String) propKeyItor.next();
    			replaceKey = key.replace("[", "").replace("]", "");
    			if( !prop.getProperty(replaceKey).equals("0")){  // 0 , 1, 2 판별
    	        	if(fileStr.indexOf(propMap.get(key)) == -1){ // 선택 or 필수일때 템플릿에 입력된 치환코드 무결성 검사
    	        		errorCodeList = errorCodeList + key;
    	        	}
    	        }
    		}
        }
        //end 치환코드 무결성 검사
		return errorCodeList;
	}
	
	/**
	 * 해당 사이트의 회원가입항목설정 프로퍼티 파일을 읽는다.
	 * @param sitePath - 사이트경로
	 * @param siteId	 
	 * @return Properties
	 * @throws Exception
	 * {@link ConfigUtil#getErrorCode}
	 * {@link CmsManageSub4_4Controller#updateJnitcmstpl}
	 */
	public static Properties mbrInfoProp(String siteId)throws Exception{
    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();	
    	String root = PathUtil.getRealPath(request);
		//Properties load
		String configPropDir = root+"/WEB-INF/config/jnit/mbrInfo/mbrInfo_"+siteId+".prop";		
		File configProp = new File(configPropDir);
		Properties prop = new Properties();
		InputStreamReader isr = null;
		FileInputStream fis = null;
		if(configProp.exists()){
			try {
				fis = new FileInputStream(configProp);
				isr = new InputStreamReader(fis, "UTF-8");
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
		}		
		//end Properties load
		return prop;
    }
	
	/**
	 * 마이페이지,가입항목설정의 필수 치환코드
	 * @param tplType - tpl타입
	 * @return HashMap<String, String>
	 * @throws Exception
	 * {@link ConfigUtil#changcode}
	 */
	public static HashMap<String, String> mbrChangeCode(String tplType)throws Exception{
    	HashMap<String, String> mbrChangeCode = new HashMap<String, String>();
    	// set Properties - 설정 치환코드
    	mbrChangeCode.put("[tel]", "<c:if test=\"${prop['tel'] != 0}\" ><c:if test=\"${prop['tel']  == 2}\"><c:set var=\"configTel\" value=\"${prop['tel'] == 2 ? 'required' : ''} \"/></c:if><select name=\"tel1\" id=\"tel1\" style=\"width: 70px;\"><option value=\"02\">02</option><option value=\"031\">031</option><option value=\"032\">032</option><option value=\"033\">033</option><option value=\"041\">041</option><option value=\"042\">042</option><option value=\"043\">043</option><option value=\"051\">051</option><option value=\"052\">052</option><option value=\"053\">053</option><option value=\"054\">054</option><option value=\"055\">055</option><option value=\"061\">061</option><option value=\"062\">062</option><option value=\"063\">063</option><option value=\"064\">064</option><option value=\"070\">070</option></select>- <label for=\"tel2\" style=\"display: none;\"></label><input type=\"text\" name=\"tel2\" id=\"tel2\" maxlength=\"4\" ${configTel} style=\"width:50px;\"/>- <label for=\"tel3\" style=\"display: none;\"></label><input type=\"text\" name=\"tel3\" id=\"tel3\" maxlength=\"4\" ${configTel} style=\"width:50px;\"/><c:if test=\"${prop['tel']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	mbrChangeCode.put("[phone]", "<c:if test=\"${prop['phone'] != 0}\" ><c:if test=\"${prop['phone'] == 2}\"><c:set var=\"configPhone\" value=\"${prop['phone'] == '2' ? 'required' : '' }\"/></c:if><select name=\"mobile1\" id=\"mobile1\" style=\"width:70px;\"><option value=\"010\">010</option><option value=\"011\">011</option><option value=\"016\">016</option><option value=\"017\">017</option><option value=\"018\">018</option><option value=\"019\">019</option></select>-<label for=\"mobile2\" style=\"display: none;\"></label><input type=\"text\" name=\"mobile2\" id=\"mobile2\" ${configPhone} maxlength=\"4\" style=\"width:50px\" />-<label for=\"mobile3\" style=\"display: none;\"></label><input type=\"text\" name=\"mobile3\" id=\"mobile3\" ${configPhone} maxlength=\"4\" style=\"width:50px\" /><c:if test=\"${prop['phone']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	
    	if(tplType.equals("E") ){ 
    		mbrChangeCode.put("[email]", "<c:if test=\"${prop['email'] != 0}\" ><c:if test=\"${prop['email'] == 2}\"><c:set var=\"configEmail\" value=\"${prop['email'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"email\" id=\"email\" class=\"input-xxlarge\" ${configEmail} /><c:if test=\"${prop['email']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}else if(tplType.equals("G")){
    		mbrChangeCode.put("[email]", "<c:if test=\"${prop['email'] != 0}\" ><c:if test=\"${prop['email'] == 2}\"><c:set var=\"configEmail\" value=\"${prop['email'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"email\" id=\"email\" class=\"input-xxlarge\" value=\"${loginVO.email}\" ${configEmail} /><c:if test=\"${prop['email']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}
    	
    	mbrChangeCode.put("[post]", "<c:if test=\"${prop['post'] != 0}\" ><c:if test=\"${prop['post'] == 2}\"><c:set var=\"configPost\" value=\"${prop['post'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"post\" id=\"post\" ${configPost} style=\"width: 50px;\" /><button class=\"btn btn-mini\" id=\"postFind\">주소찾기</button><c:if test=\"${prop['post']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	mbrChangeCode.put("[addr]", "<c:if test=\"${prop['addr'] != 0}\" ><c:if test=\"${prop['addr'] == 2}\"><c:set var=\"configAddr\" value=\"${prop['addr'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"addr\" id=\"addr\" class=\"input-xxlarge\" ${configAddr}/> <c:if test=\"${prop['addr']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	
    	if(tplType.equals("E")){
    		mbrChangeCode.put("[emailRecv]", "<c:if test=\"${prop['emailRecv'] != 0}\" ><c:if test=\"${prop['emailRecv'] == 2}\"><c:set var=\"configEmailRecv\" value=\"${prop['emailRecv'] == '2' ? 'required' : '' }\"/></c:if>동의함 <input type=\"checkbox\" name=\"emailRecv\" id=\"emailRecv\" ${configEmailRecv} value=\"1\" /><c:if test=\"${prop['emailRecv']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}else if(tplType.equals("G")){
    		mbrChangeCode.put("[emailRecv]", "<c:if test=\"${prop['emailRecv'] != 0}\" ><c:set var=\"anEamilRecv\" value=\"${loginVO.emailRecv == '1' ? 'checked' : ''}\" /><c:if test=\"${prop['emailRecv'] == 2}\"><c:set var=\"configEmailRecv\" value=\"${prop['emailRecv'] == '2' ? 'required' : '' }\"/></c:if>동의함 <input type=\"checkbox\" name=\"emailRecv\" id=\"emailRecv\" ${configEmailRecv} value=\"1\" ${anEamilRecv}  /><c:if test=\"${prop['emailRecv']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}
    	
    	if(tplType.equals("E")){
    		mbrChangeCode.put("[smsRecv]", "<c:if test=\"${prop['smsRecv'] != 0}\" ><c:if test=\"${prop['smsRecv'] == 2}\"><c:set var=\"configSmsRecv\" value=\"${prop['smsRecv'] == '2' ? 'required' : '' }\"/></c:if>동의함 <input type=\"checkbox\" name=\"smsRecv\" id=\"smsRecv\" ${configSmsRecv} value=\"1\"/><c:if test=\"${prop['smsRecv']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}else if(tplType.equals("G")){
    		mbrChangeCode.put("[smsRecv]", "<c:if test=\"${prop['smsRecv'] != 0}\" ><c:set var=\"anSmsRecv\" value=\"${loginVO.smsRecv == '1' ? 'checked' : ''}\" /><c:if test=\"${prop['smsRecv'] == 2}\"><c:set var=\"configSmsRecv\" value=\"${prop['smsRecv'] == '2' ? 'required' : '' }\"/></c:if>동의함 <input type=\"checkbox\" name=\"smsRecv\" id=\"smsRecv\" ${configSmsRecv} value=\"1\" ${anSmsRecv} /><c:if test=\"${prop['smsRecv']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");    		
    	}
    	
    	
    	mbrChangeCode.put("[personal]", "<c:if test=\"${prop['personal'] != 0}\"><input type=\"radio\" name=\"groupType\" id=\"groupType\" value=\"개인\" checked>개인사업자</c:if>");
    	mbrChangeCode.put("[profit]", "<c:if test=\"${prop['profit'] != 0}\"><input type=\"radio\" name=\"groupType\" id=\"groupType\" value=\"영리\">영리 법인</c:if>");
    	mbrChangeCode.put("[nonprofit]", "<c:if test=\"${prop['nonprofit'] != 0}\"><input type=\"radio\" name=\"groupType\" id=\"groupType\" value=\"비영리\">비영리 법인</c:if>");
    	mbrChangeCode.put("[organization]", "<c:if test=\"${prop['organization'] != 0}\"><input type=\"radio\" name=\"groupType\" id=\"groupType \" value=\"공식\">공식 단체</c:if>");
    	
    	if(tplType.equals("E")){
    		mbrChangeCode.put("[mutual]", "<c:if test=\"${prop['mutual'] != 0}\"><c:if test=\"${prop['mutual'] == 2}\"><c:set var=\"configMutual\" value=\"${prop['mutual'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"mutual\" id=\"mutual\" ${configMutual} /><c:if test=\"${prop['mutual']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}else if(tplType.equals("G")){
    		mbrChangeCode.put("[mutual]", "<c:if test=\"${prop['mutual'] != 0}\"><c:if test=\"${prop['mutual'] == 2}\"><c:set var=\"configMutual\" value=\"${prop['mutual'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"mutual\" id=\"mutual\" value=\"${loginVO.mutual}\" ${configMutual} /><c:if test=\"${prop['mutual']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}
    	
    	if(tplType.equals("E")){
    		mbrChangeCode.put("[corporateName]", "<c:if test=\"${prop['corporateName'] != 0}\"><c:if test=\"${prop['corporateName'] == 2}\"><c:set var=\"configCorporateNmae\" value=\"${prop['corporateName'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"corporateName\" id=\"corporateName\"  ${configCorporateNmae}/><c:if test=\"${prop['corporateName']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}else if(tplType.equals("G")){
    		mbrChangeCode.put("[corporateName]", "<c:if test=\"${prop['corporateName'] != 0}\"><c:if test=\"${prop['corporateName'] == 2}\"><c:set var=\"configCorporateNmae\" value=\"${prop['corporateName'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"corporateName\" id=\"corporateName\" value=\"${loginVO.corporateName}\"  ${configCorporateNmae}/><c:if test=\"${prop['corporateName']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}
    	
    	if(tplType.equals("E")){
    		mbrChangeCode.put("[groupName]", "<c:if test=\"${prop['groupName'] != 0}\"><c:if test=\"${prop['groupName'] == 2}\"><c:set var=\"configGroupNmae\" value=\"${prop['groupName'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"groupName\" id=\"groupName\" ${configGroupNmae} /><c:if test=\"${prop['groupName']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}else if(tplType.equals("G")){
    		mbrChangeCode.put("[groupName]", "<c:if test=\"${prop['groupName'] != 0}\"><c:if test=\"${prop['groupName'] == 2}\"><c:set var=\"configGroupNmae\" value=\"${prop['groupName'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"groupName\" id=\"groupName\" value=\"${loginVO.groupName}\" ${configGroupNmae} /><c:if test=\"${prop['groupName']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}
    	
    	mbrChangeCode.put("[businessPlace]", "<c:if test=\"${prop['businessPlace'] != 0}\"><c:if test=\"${prop['businessPlace'] == 2}\"><c:set var=\"configBusinessPlace\" value=\"${prop['businessPlace'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"businessPlace1\" id=\"businessPlace1\" ${configBusinessPlace} style=\"width:50px;\" />-<label for=\"businessPlace2\" style=\"display: none;\"></label><input type=\"text\" name=\"businessPlace2\" id=\"businessPlace2\" ${configBusinessPlace} style=\"width:50px;\"/><button class=\"btn btn-mini\" id=\"groupPostFind\">주소찾기</button><c:if test=\"${prop['businessPlace']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	mbrChangeCode.put("[businessAddr]", "<c:if test=\"${prop['businessAddr'] != 0}\"><c:if test=\"${prop['businessAddr'] == 2}\"><c:set var=\"configBusinessAddr\" value=\"${prop['businessAddr'] == '2' ? 'required' : '' }\"/></c:if> 구주소 <input type=\"text\" name=\"businessAddr\" id=\"businessAddr\" ${configBusinessAddr} /> 상세주소 <label for=\"businessAddrDetail\" style=\"display: none;\"></label><input type=\"text\" name=\"businessAddrDetail\" id=\"businessAddrDetail\" ${configBusinessAddr} /><br/> 신주소 <label for=\"businessAddr2\" style=\"display: none;\"></label><input type=\"text\" name=\"businessAddr2\" id=\"businessAddr2\" /> 상세주소 <label for=\"businessAddrDetail2\" style=\"display: none;\"></label><input type=\"text\" name=\"businessAddrDetail2\" id=\"businessAddrDetail2\" /><c:if test=\"${prop['businessAddr']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	
    	if(tplType.equals("E")){
    		mbrChangeCode.put("[groupKind]", "<c:if test=\"${prop['groupKind'] != 0}\"><c:if test=\"${prop['groupKind'] == 2}\"><c:set var=\"configGroupKind\" value=\"${prop['groupKind'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"groupKind\" id=\"groupKind\" ${configGroupKind}/><c:if test=\"${prop['groupKind']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}else if(tplType.equals("G")){
    		mbrChangeCode.put("[groupKind]", "<c:if test=\"${prop['groupKind'] != 0}\"><c:if test=\"${prop['groupKind'] == 2}\"><c:set var=\"configGroupKind\" value=\"${prop['groupKind'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"groupKind\" id=\"groupKind\" value=\"${loginVO.groupKind}\" ${configGroupKind}/><c:if test=\"${prop['groupKind']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}
    	
    	if(tplType.equals("E")){
    		mbrChangeCode.put("[groupTitle]", "<c:if test=\"${prop['groupTitle'] != 0}\"><c:if test=\"${prop['groupTitle'] == 2}\"><c:set var=\"configgroupTitle\" value=\"${prop['groupTitle'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"groupTitle\" id=\"groupTitle\" ${configgroupTitle} /><c:if test=\"${prop['groupTitle']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}else if(tplType.equals("G")){
    		mbrChangeCode.put("[groupTitle]", "<c:if test=\"${prop['groupTitle'] != 0}\"><c:if test=\"${prop['groupTitle'] == 2}\"><c:set var=\"configgroupTitle\" value=\"${prop['groupTitle'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"groupTitle\" id=\"groupTitle\" value=\"${loginVO.groupTitle}\" ${configgroupTitle} /><c:if test=\"${prop['groupTitle']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}
    	
    	if(tplType.equals("E")){
    		mbrChangeCode.put("[gradeNm]", "<c:if test=\"${prop['gradeNm'] != 0}\"><c:if test=\"${prop['gradeNm'] == 2}\"><c:set var=\"configgradeNm\" value=\"${prop['gradeNm'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"gradeNm\" id=\"gradeNm\" ${configgradeNm} /><c:if test=\"${prop['gradeNm']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}else if(tplType.equals("G")){
    		mbrChangeCode.put("[gradeNm]", "<c:if test=\"${prop['gradeNm'] != 0}\"><c:if test=\"${prop['gradeNm'] == 2}\"><c:set var=\"configgradeNm\" value=\"${prop['gradeNm'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"gradeNm\" id=\"gradeNm\" value=\"${loginVO.gradeNm}\" ${configgradeNm} /><c:if test=\"${prop['gradeNm']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	}
    	
    	mbrChangeCode.put("[groupTel]", "<c:if test=\"${prop['groupTel'] != 0}\"><c:if test=\"${prop['groupTel'] == 2}\"><c:set var=\"configGroupTel\" value=\"${prop['groupTel'] == '2' ? 'required' : '' }\"/></c:if><select name=\"groupTel1\" id=\"groupTel1\" style=\"width: 70px;\"><option value=\"02\">02</option><option value=\"032\">032</option><option value=\"033\">033</option><option value=\"041\">041</option><option value=\"042\">042</option><option value=\"043\">043</option><option value=\"051\">051</option><option value=\"052\">052</option><option value=\"053\">053</option><option value=\"054\">054</option><option value=\"055\">055</option><option value=\"061\">061</option><option value=\"062\">062</option><option value=\"063\">063</option><option value=\"064\">064</option><option value=\"070\">070</option></select>-<label for=\"groupTel2\" style=\"display: none;\"></label><input type=\"text\" name=\"groupTel2\" id=\"groupTel2\" ${configGroupTel} maxlength=\"4\" style=\"width:50px;\" />-<label for=\"groupTel3\" style=\"display: none;\"></label><input type=\"text\" name=\"groupTel3\" id=\"groupTel3\" ${configGroupTel} maxlength=\"4\" style=\"width:50px;\" /><c:if test=\"${prop['groupTel']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	mbrChangeCode.put("[groupPax]", "<c:if test=\"${prop['groupPax'] != 0}\"><c:if test=\"${prop['groupPax'] == 2}\"><c:set var=\"configGroupPax\" value=\"${prop['groupPax'] == '2' ? 'required' : '' }\"/></c:if><input type=\"text\" name=\"groupPax1\" id=\"groupPax1\" ${configGroupPax} style=\"width:50px;\" maxlength=\"4\" />-<label for=\"groupPax2\" style=\"display: none;\"></label><input type=\"text\" name=\"groupPax2\" id=\"groupPax2\" ${configGroupPax} style=\"width:50px;\" maxlength=\"4\" />-<label for=\"groupPax3\" style=\"display: none;\"></label><input type=\"text\" name=\"groupPax3\" id=\"groupPax3\" ${configGroupPax} style=\"width:50px;\" maxlength=\"4\" /><c:if test=\"${prop['groupPax']  == 2}\"><font color=\"red\"> * </font></c:if></c:if>");
    	
    	if(tplType.equals("E")){
    		mbrChangeCode.put("[ex01Add]", "<c:if test=\"${prop['ex01Add'] != 0}\"><c:if test=\"${prop['ex01Add'] == 2}\"><c:set var=\"configEx01Add\" value=\"${prop['ex01Add'] == '2' ? 'required' : '' }\"/></c:if><c:if test=\"${prop['ex01Type'] == 'text'}\"><input type=\"text\" name=\"ex01\" ${configEx01Add} /></c:if><c:if test=\"${prop['ex01Type'] == 'select'}\"><select id=\"ex01\" name=\"ex01\"></select></c:if><c:if test=\"${prop['ex01Type'] == 'checkbox'}\"><div id=\"ex01checkbox\"></div></c:if><c:if test=\"${prop['ex01Type'] == 'radio'}\"><div id=\"ex01radio\"></div></c:if><c:if test=\"${prop['ex01Type'] == 'multiinput'}\"><label for=\"ex01_1\" style=\"display: none;\"></label><input type=\"text\" id=\"ex01_1\" name=\"ex01_1\" style=\"width:50px;\" />- <label for=\"ex01_2\" style=\"display: none;\"></label><input type=\"text\" id=\"ex01_2\" name=\"ex01_2\" style=\"width:50px;\" />- <label for=\"ex01_3\" style=\"display: none;\"></label><input type=\"text\" id=\"ex01_3\" name=\"ex01_3\" style=\"width:50px;\"/></c:if></c:if>");
    	}else if(tplType.equals("G")){
    		mbrChangeCode.put("[ex01Add]", "<c:if test=\"${prop['ex01Add'] != 0}\"><c:if test=\"${prop['ex01Add'] == 2}\"><c:set var=\"configEx01Add\" value=\"${prop['ex01Add'] == '2' ? 'required' : '' }\"/></c:if><c:if test=\"${prop['ex01Type'] == 'text'}\"><input type=\"text\" name=\"ex01\" ${configEx01Add} value=\"${loginVO.ex01 }\" /></c:if><c:if test=\"${prop['ex01Type'] == 'select'}\"><select id=\"ex01\" name=\"ex01\"></select></c:if><c:if test=\"${prop['ex01Type'] == 'checkbox'}\"><div id=\"ex01checkbox\"></div></c:if><c:if test=\"${prop['ex01Type'] == 'radio'}\"><div id=\"ex01radio\"></div></c:if><c:if test=\"${prop['ex01Type'] == 'multiinput'}\"><label for=\"ex01_1\" style=\"display: none;\"></label><input type=\"text\" id=\"ex01_1\" name=\"ex01_1\" style=\"width:50px;\" />- <label for=\"ex01_2\" style=\"display: none;\"></label><input type=\"text\" id=\"ex01_2\" name=\"ex01_2\" style=\"width:50px;\" />- <label for=\"ex01_3\" style=\"display: none;\"></label><input type=\"text\" id=\"ex01_3\" name=\"ex01_3\" style=\"width:50px;\"/></c:if></c:if>");
    	}
    	
    	if(tplType.equals("E")){
    		mbrChangeCode.put("[ex02Add]", "<c:if test=\"${prop['ex02Add'] != 0}\"><c:if test=\"${prop['ex02Add'] == 2}\"><c:set var=\"configEx01Add\" value=\"${prop['ex02Add'] == '2' ? 'required' : '' }\"/></c:if><c:if test=\"${prop['ex02Type'] == 'text'}\"><input type=\"text\" name=\"ex02\" ${configEx01Add} /></c:if><c:if test=\"${prop['ex02Type'] == 'select'}\"><select id=\"ex02\" name=\"ex02\"></select></c:if><c:if test=\"${prop['ex02Type'] == 'checkbox'}\"><div id=\"ex02checkbox\"></div></c:if><c:if test=\"${prop['ex02Type'] == 'radio'}\"><div id=\"ex02radio\"></div></c:if><c:if test=\"${prop['ex02Type'] == 'multiinput'}\"><label for=\"ex02_1\" style=\"display: none;\"></label><input type=\"text\" id=\"ex02_1\" name=\"ex02_1\" style=\"width:50px;\" />- <label for=\"ex02_2\" style=\"display: none;\"></label><input type=\"text\" id=\"ex02_2\" name=\"ex02_2\" style=\"width:50px;\" />- <label for=\"ex02_3\" style=\"display: none;\"></label><input type=\"text\" id=\"ex02_3\" name=\"ex02_3\" style=\"width:50px;\"/></c:if></c:if>");
    	}else if(tplType.equals("G")){
    		mbrChangeCode.put("[ex02Add]", "<c:if test=\"${prop['ex02Add'] != 0}\"><c:if test=\"${prop['ex02Add'] == 2}\"><c:set var=\"configEx01Add\" value=\"${prop['ex02Add'] == '2' ? 'required' : '' }\"/></c:if><c:if test=\"${prop['ex02Type'] == 'text'}\"><input type=\"text\" name=\"ex02\" ${configEx01Add} value=\"${loginVO.ex02 }\" /></c:if><c:if test=\"${prop['ex02Type'] == 'select'}\"><select id=\"ex02\" name=\"ex02\"></select></c:if><c:if test=\"${prop['ex02Type'] == 'checkbox'}\"><div id=\"ex02checkbox\"></div></c:if><c:if test=\"${prop['ex02Type'] == 'radio'}\"><div id=\"ex02radio\"></div></c:if><c:if test=\"${prop['ex02Type'] == 'multiinput'}\"><label for=\"ex02_1\" style=\"display: none;\"></label><input type=\"text\" id=\"ex02_1\" name=\"ex02_1\" style=\"width:50px;\" />- <label for=\"ex02_2\" style=\"display: none;\"></label><input type=\"text\" id=\"ex02_2\" name=\"ex02_2\" style=\"width:50px;\" />- <label for=\"ex02_3\" style=\"display: none;\"></label><input type=\"text\" id=\"ex02_3\" name=\"ex02_3\" style=\"width:50px;\"/></c:if></c:if>");
    	}
    	
    	if(tplType.equals("E")){
    		mbrChangeCode.put("[ex03Add]", "<c:if test=\"${prop['ex03Add'] != 0}\"><c:if test=\"${prop['ex03Add'] == 2}\"><c:set var=\"configEx01Add\" value=\"${prop['ex03Add'] == '2' ? 'required' : '' }\"/></c:if><c:if test=\"${prop['ex03Type'] == 'text'}\"><input type=\"text\" name=\"ex03\" ${configEx01Add} /></c:if><c:if test=\"${prop['ex03Type'] == 'select'}\"><select id=\"ex03\" name=\"ex03\"></select></c:if><c:if test=\"${prop['ex03Type'] == 'checkbox'}\"><div id=\"ex03checkbox\"></div></c:if><c:if test=\"${prop['ex03Type'] == 'radio'}\"><div id=\"ex03radio\"></div></c:if><c:if test=\"${prop['ex03Type'] == 'multiinput'}\"><label for=\"ex03_1\" style=\"display: none;\"></label><input type=\"text\" id=\"ex03_1\" name=\"ex03_1\" style=\"width:50px;\" />- <label for=\"ex03_2\" style=\"display: none;\"></label><input type=\"text\" id=\"ex03_2\" name=\"ex03_2\" style=\"width:50px;\" />- <label for=\"ex03_3\" style=\"display: none;\"></label><input type=\"text\" id=\"ex03_3\" name=\"ex03_3\" style=\"width:50px;\"/></c:if></c:if>");
    	}else if(tplType.equals("G")){
    		mbrChangeCode.put("[ex03Add]", "<c:if test=\"${prop['ex03Add'] != 0}\"><c:if test=\"${prop['ex03Add'] == 2}\"><c:set var=\"configEx01Add\" value=\"${prop['ex03Add'] == '2' ? 'required' : '' }\"/></c:if><c:if test=\"${prop['ex03Type'] == 'text'}\"><input type=\"text\" name=\"ex03\" ${configEx01Add} value=\"${loginVO.ex03 }\" /></c:if><c:if test=\"${prop['ex03Type'] == 'select'}\"><select id=\"ex03\" name=\"ex03\"></select></c:if><c:if test=\"${prop['ex03Type'] == 'checkbox'}\"><div id=\"ex03checkbox\"></div></c:if><c:if test=\"${prop['ex03Type'] == 'radio'}\"><div id=\"ex03radio\"></div></c:if><c:if test=\"${prop['ex03Type'] == 'multiinput'}\"><label for=\"ex03_1\" style=\"display: none;\"></label><input type=\"text\" id=\"ex03_1\" name=\"ex03_1\" style=\"width:50px;\" />- <label for=\"ex03_2\" style=\"display: none;\"></label><input type=\"text\" id=\"ex03_2\" name=\"ex03_2\" style=\"width:50px;\" />- <label for=\"ex03_3\" style=\"display: none;\"></label><input type=\"text\" id=\"ex03_3\" name=\"ex03_3\" style=\"width:50px;\"/></c:if></c:if>");
    	}
    	//end Properties - 설정 치환코드    	
    	return mbrChangeCode;
    }
	
	/**
	 * 회원관련템플릿,로그인템플릿 관련 소스를 치환한다. 
	 * @param tplType - E = 회원가입항목입력,G = 마이페이지
	 * @param chageType - 치환타입 return 일경우 역치환
	 * @return HashMap<String , String>
	 * @throws Exception
	 * {@link tplUtil#replaceMbrTpl}
	 */
    public static HashMap changcode(String tplType, String chageType)throws Exception{
    	
    	HashMap<String , String> changeCode = new HashMap<String, String>();
    	changeCode = ConfigUtil.mbrChangeCode(tplType); //필수 치환코드   	
    	
    	//sign.jsp 속성 치환코드
    	if(tplType.equals("K")){
    		changeCode.put("[signFunction_1]", "signup.jsp");
    		changeCode.put("[signFunction_2]", "signupAdd.jsp?type=group");
    		changeCode.put("[signFunction_3]", "signupKid.jsp");
    	}
    	//end sign.jsp 속성 치환코드
    	
    	//signup.jsp 속성 치환코드
    	if(tplType.equals("D")){
    		changeCode.put("[signupFunction_1]", "<c:out value=\"${requestScope['javax.servlet.forward.request_uri']}\" />");
    		changeCode.put("[signupFunction_2]", "<c:out value=\"${requestScope['javax.servlet.forward.context_path']}\" />");
    		changeCode.put("[signupFunction_3]", "<%=siauth %>");
    		changeCode.put("[signupFunction_4]", "<%=gpinauth %>");
    		changeCode.put("[signupFunction_5]", "<%=pkiauth %>");
    		changeCode.put("[signupFunction_6]", "<c:url value=\"/resources/js/jquery.min.js\"/>");
    		changeCode.put("[signupFunction_7]", "<c:url value=\"/resources/js/jnit.member.js\"/>");
    		changeCode.put("[signupFunction_8]", "<c:url value=\"/total_login/common/js/auth_login.js\" />");
    		changeCode.put("[signupFunction_9]", "<c:url value=\"/total_login/common/js/search_idpw.js\" />");    		
    		changeCode.put("[signupFunction_10]", "<c:url value=\"/gpki/gpkisecureweb/var.js\" />");
    		changeCode.put("[signupFunction_11]", "<c:url value=\"/gpki/gpkisecureweb/install.js\" />");
    		changeCode.put("[signupFunction_12]", "<c:url value=\"/gpki/gpkisecureweb/object.js\" />");
    		changeCode.put("[signupFunction_13]", "<c:url value=\"/gpki/gpkisecureweb/GPKIFunc.js\" />");    		
    		changeCode.put("[signupFunction_14]", "${Jnit_sitePath }");
    		changeCode.put("[signupFunction_15]", "authSi()");
    		changeCode.put("[signupFunction_16]", "authGpin()");
    		changeCode.put("[signupFunction_17]", "checkConfirm()");
    		changeCode.put("[signupFunction_18]", "authSignReg()");
    		changeCode.put("[signupFunction_19]", "checkConfirm()");
    		changeCode.put("[signupFunction_20]", "authSignCom()");
    		changeCode.put("[signupFunction_21]", "checkConfirm()");
    		changeCode.put("[signupFunction_22]", "<%=retType %>");
    	}
    	//end signup.jsp 속성 치환코드    	
    	
    	//signupAdd.jsp 속성 치환코드
    	if(tplType.equals("E")){    		 
        	changeCode.put("[signupAddFunction_1]", "<c:url value=\"/humans.txt\" />");
        	changeCode.put("[signupAddFunction_2]", "<c:url value=\"/resources/css/bootstrap.css\" />");
        	changeCode.put("[signupAddFunction_3]", "<c:url value=\"/resources/js/jquery.min.js\"/>");
        	changeCode.put("[signupAddFunction_4]", "<c:url value=\"/resources/js/jnit.member.js\" />");
        	changeCode.put("[signupAddFunction_5]", "<c:url value=\"/resources/js/bootstrap.js\"/>");
        	changeCode.put("[signupAddFunction_6]", "<c:out value=\"${requestScope['javax.servlet.forward.request_uri']}\" />");
        	changeCode.put("[signupAddFunction_7]", "<c:out value=\"${requestScope['javax.servlet.forward.context_path']}\" />");
        	changeCode.put("[signupAddFunction_8]", "<%= type %>");
        	changeCode.put("[signupAddFunction_9]", "<%= error %>");
        	changeCode.put("[signupAddFunction_10]", "<%= prop %>");
        	changeCode.put("[signupAddFunction_11]", "${sessionScope.snAuth.authType }");
        	changeCode.put("[signupAddFunction_12]", "${sessionScope.snAuth.retType }");
        	changeCode.put("[signupAddFunction_13]", "${pageContext.request.contextPath }/mbr/signup_savembr.do");
        	changeCode.put("[signupAddFunction_14]", "${Jnit_sitePath }");
        	changeCode.put("[signupAddFunction_15]", "${authType }");
        	changeCode.put("[signupAddFunction_16]", "${retType }");
        	changeCode.put("[signupAddFunction_17]", "${sessionScope.snAuth.nm}");
        	changeCode.put("[signupAddFunction_18]", "<c:url value='/mbr/signup_groupSave.do' />");
        	changeCode.put("[signupAddFunction_19]", "<%= errorCode %>");        	
    	}
    	//end signup.jsp 속성 치환코드
    	
    	//signupSuccess.jsp 속성 치환코드
    	if(tplType.equals("F")){
    		changeCode.put("[signupSuccessFunction_1]", "<c:out value=\"${requestScope['javax.servlet.forward.request_uri']}\" />");
    		changeCode.put("[signupSuccessFunction_2]", "<c:out value=\"${requestScope['javax.servlet.forward.context_path']}\" />");
    	}
    	//end signupSuccess.jsp 속성 치환코드    	
    	
    	//myPage.jsp 속성 치환코드
    	if(tplType.equals("G")){    		
        	changeCode.put("[myPageFunction_1]", "<c:url value=\"/humans.txt\" />");        	
        	changeCode.put("[myPageFunction_2]", "<c:url value=\"/resources/css/bootstrap.css\" />");
        	changeCode.put("[myPageFunction_3]", "<c:url value=\"/resources/js/jquery.min.js\"/>");
        	changeCode.put("[myPageFunction_4]", "<c:url value=\"/resources/js/jnit.member.js\" />");
        	changeCode.put("[myPageFunction_5]", "<c:url value=\"/resources/js/bootstrap.js\"/>");
        	changeCode.put("[myPageFunction_6]", "<c:out value=\"${requestScope['javax.servlet.forward.request_uri']}\" />");
        	changeCode.put("[myPageFunction_7]", "<%= tabs %>");
        	changeCode.put("[myPageFunction_8]", "<%= tab %>");
        	changeCode.put("[myPageFunction_9]", "<%= scrapPageNavi %>");
        	changeCode.put("[myPageFunction_10]", "<%= scrapList %>");
        	changeCode.put("[myPageFunction_11]", "<%= loginlogPageNavi %>");
        	changeCode.put("[myPageFunction_12]", "<%= loginLogList %>");        	
        	changeCode.put("[myPageFunction_13]", "<%= error %>");
        	changeCode.put("[myPageFunction_14]", "<%= prop %>");
        	changeCode.put("[myPageFunction_15]", "<%= errorCode %>");
        	changeCode.put("[myPageFunction_16]", "${loginVO.mbrId}");
        	changeCode.put("[myPageFunction_17]", "${Jnit_sitePath }");
        	changeCode.put("[myPageFunction_18]", "${loginVO.mobile}");
        	changeCode.put("[myPageFunction_19]", "${loginVO.tel}");
        	changeCode.put("[myPageFunction_20]", "${loginVO.postcode}");
        	changeCode.put("[myPageFunction_21]", "${loginVO.address}");
        	changeCode.put("[myPageFunction_22]", "${loginVO.establishment}");
        	changeCode.put("[myPageFunction_23]", "${loginVO.corporation}");
        	changeCode.put("[myPageFunction_24]", "${loginVO.primaryKey}");
        	changeCode.put("[myPageFunction_25]", "${loginVO.businessAddr}");
        	changeCode.put("[myPageFunction_26]", "${loginVO.businessPlace}");
        	changeCode.put("[myPageFunction_27]", "${loginVO.groupTel}");
        	changeCode.put("[myPageFunction_28]", "${loginVO.groupPax}");
        	changeCode.put("[myPageFunction_29]", "${loginVO.mbrNm}");        	
        	changeCode.put("[myPageFunction_44]", "<%=scrapStartNum %>");
        	changeCode.put("[myPageFunction_45]", "<%=logStartNum%>");
        	changeCode.put("[myPageFunction_46]", "<%= DBType.getDbTypeString() %>");
        	
        		//스크랩
	        	changeCode.put("[myPageFunction_30]", "${scrapList}");
	        	changeCode.put("[myPageFunction_31]", "${result.scrapId}");
	        	changeCode.put("[myPageFunction_32]", "${status.count}");
	        	changeCode.put("[myPageFunction_33]", "${result.url}");
	        	changeCode.put("[myPageFunction_34]", "${result.title}");
	        	changeCode.put("[myPageFunction_35]", "javascript:delScrap('${result.scrapId}');");
	        	changeCode.put("[myPageFunction_36]", "${scrapPageNavi}");
	        	changeCode.put("[myPageFunction_42]", "${!empty scrapList }");
	        	changeCode.put("[myPageFunction_43]", "${empty scrapList }");
        		//end 스크랩
        		
        		//로그인 정보
	        	changeCode.put("[myPageFunction_37]", "${loginLogList}");
	        	changeCode.put("[myPageFunction_38]", "${resultLoginLog.ipAddr}");
	        	changeCode.put("[myPageFunction_39]", "${resultLoginLog.created}");
	        	changeCode.put("[myPageFunction_40]", "${loginlogPageNavi}");	        	
        		//end 로그인정보
	       //신주소 	
	       changeCode.put("[myPageFunction_41]", "${loginVO.businessAddrNew}"); 	
    	}
    	//end myPage.jsp 속성 치환코드
    	
    	
    	//memberCancel.jsp 속성 치환코드
    	if(tplType.equals("H")){
    		changeCode.put("[memberCancelFunction_1]", "<c:out value=\"${requestScope['javax.servlet.forward.request_uri']}\" />");
    		changeCode.put("[memberCancelFunction_2]", "<c:out value=\"${requestScope['javax.servlet.forward.context_path']}\" />");    		
    	}
    	//end memberCancel.jsp 속성 치환코드
    	//end 회원관련템플릿 
    	
    	//로그인 템플릿
    	//login.jsp 속성 치환코드
    	if(tplType.equals("C")){
    		changeCode.put("[loginFunction_1]", "<c:out value=\"${requestScope['javax.servlet.forward.request_uri']}\" />");
    		changeCode.put("[loginFunction_2]", "<c:out value=\"${requestScope['javax.servlet.forward.context_path']}\" />");
    		changeCode.put("[loginFunction_3]", "<%=message %>");
    		changeCode.put("[loginFunction_4]", "<%=siauth %>");
    		changeCode.put("[loginFunction_5]", "<%=gpinauth %>");
    		changeCode.put("[loginFunction_6]", "<%=pkiauth %>");
    		changeCode.put("[loginFunction_7]", "<c:url value=\"/resources/js/jquery.min.js\"/>");
    		changeCode.put("[loginFunction_8]", "/total_login/common/js/auth_login.js");
    		changeCode.put("[loginFunction_9]", "/total_login/common/js/search_idpw.js");
    		changeCode.put("[loginFunction_10]", "/gpki/gpkisecureweb/var.js");
    		changeCode.put("[loginFunction_11]", "/gpki/gpkisecureweb/install.js");
    		changeCode.put("[loginFunction_12]", "/gpki/gpkisecureweb/object.js");
    		changeCode.put("[loginFunction_13]", "/gpki/gpkisecureweb/GPKIFunc.js");
    		changeCode.put("[loginFunction_14]", "${Jnit_sitePath }");
    		changeCode.put("[loginFunction_15]", "authSi()");
    		changeCode.put("[loginFunction_16]", "authGpin()");
    		changeCode.put("[loginFunction_17]", "<%=challenge%>");
    		changeCode.put("[loginFunction_18]", "authSignReg()");
    		changeCode.put("[loginFunction_19]", "authSignCom()");
    		changeCode.put("[loginFunction_20]", "/uat/uia/actionLogout.do");
    		changeCode.put("[loginFunction_21]", "searchFind(3)");
    		changeCode.put("[loginFunction_22]", "<c:url value=\"/resources/js/jnit.member.js\"/>");
    		changeCode.put("[loginFunction_23]", "<c:url value=\"/resources/js/bootstrap.js\"/>");
    		changeCode.put("[loginFunction_24]", "/exeLogin.do");
    		changeCode.put("[loginFunction_25]", "<%= ConfigUtil.getDefaultProp(\\\"facebook\\\") %>");
    		changeCode.put("[loginFunction_26]", "<%= ConfigUtil.getDefaultProp(\\\"twitter\\\") %>");
    		changeCode.put("[loginFunction_27]", "<%= ConfigUtil.getDefaultProp(\\\"google\\\") %>");
    		
    		
    	}
    	//end login.jsp 속성 치환코드
    	
    	//idFind.jsp 속성 치환코드
    	if(tplType.equals("I")){
    		changeCode.put("[idFindFunction_1]", "/total_login/common/js/auth_login.js");
    		changeCode.put("[idFindFunction_2]", "/total_login/common/js/search_idpw.js");
    		changeCode.put("[idFindFunction_3]", "authSiIdfind()");
    		changeCode.put("[idFindFunction_4]", "authGpinIdfind()");
    		changeCode.put("[idFindFunction_5]", "authSiIdfind()");
    		changeCode.put("[idFindFunction_6]", "authSiIdfind()");
    		changeCode.put("[idFindFunction_7]", "<c:import url=\"/searchId.do\" />");
    		changeCode.put("[idFindFunction_8]", "<% if( session.getAttribute(\"snAuth\") != null ){ %>");
    		changeCode.put("[idFindFunction_9]", "<% } session.setAttribute(\"snAuth\", null); %>");    		
    		changeCode.put("[idFindFunction_10]", "<%=siauth %>");
    		changeCode.put("[idFindFunction_11]", "<%=gpinauth %>");
    		changeCode.put("[idFindFunction_12]", "<%=pkiauth %>");    		
    	}
    	//end idFind.jsp 속성 치환코드
    	
    	//pwFind.jsp 속성 치환코드
    	if(tplType.equals("J")){
    		changeCode.put("[pwFindFunction_1]", "/resources/js/jquery.min.js");
    		changeCode.put("[pwFindFunction_2]", "/resources/js/jquery.plugins/jquery.cookie.js");
    		changeCode.put("[pwFindFunction_3]", "/total_login/common/js/auth_login.js");
    		changeCode.put("[pwFindFunction_4]", "/resources/js/jquery.min.js");
    		changeCode.put("[pwFindFunction_5]", "/total_login/common/js/search_idpw.js");
    		changeCode.put("[pwFindFunction_6]", "authSiPwfind()");
    		changeCode.put("[pwFindFunction_7]", "authGpinPwfind()");
    		changeCode.put("[pwFindFunction_8]", "<% if( session.getAttribute(\"snAuth\") != null ){ %>");
    		changeCode.put("[pwFindFunction_9]", "checkPwChange()");
    		changeCode.put("[pwFindFunction_10]", "<% session.setAttribute(\"snAuth\", null); } %>");    		
    	}   	
    	//end pwFind.jsp 속성 치환코드
    	
    	//역치환
    	if("return".equals(chageType)){ 		
    		HashMap<String, String> returnMap = new HashMap<String, String>();    		
    		Iterator codeNmIterator = changeCode.entrySet().iterator();
    		
    		while(codeNmIterator.hasNext()){
				Entry item = (Entry) codeNmIterator.next();
				String key = (String) item.getKey();				
				returnMap.put(changeCode.get(key), key);
    		}    		
    		changeCode.clear();  		
    		changeCode = returnMap;
    	}
    	return changeCode;
    }
    
    /**
     * 치환될 key 값을 제어한다.
     * @param sitePath - 사이트경로
     * @param chageType - return 문자열 입력시 역치환 
     * @return
     * @throws Exception
     */
    public static HashMap getSiteChangeCode(String sitePath,String tplType ,String chageType)throws Exception{
    	HashMap<String, String> changeCodeNm = new HashMap<String, String>();    	
    	//공용    	
    	String cSet1 = "<% String[] Jnit_ServletPath = servletPath.split(\"/\"); String Jnit_sitePath = Jnit_ServletPath[1]; %><c:set var=\"Jnit_sitePath\" value=\"<%= Jnit_sitePath %>\" scope=\"request\"/>";
    	String cSet2 = "<%@ page import=\"egovframework.com.utl.fcc.service.StringUtil\"%><% String localYn = \"\"; if(StringUtil.isExistString(request.getRequestURL().toString(),\"local\")) localYn=\"Y\"; %><c:set var=\"localYn\" value=\"<%= localYn %>\" scope=\"request\" />";
    	changeCodeNm.put("{-CONFIG_SET-}", ""
    										+"<% /* cset_s */ %>"
    											+"<% String servletPath = request.getServletPath(); %>"
    											+cSet1 //Jnit_sitePath
    											+cSet2 //localYn   										
    										+"<% /* cset_e */ %>"
    										);    	
    	changeCodeNm.put("{-CONFIG_CSS-}", "<%@ include file=\"/"+sitePath+"/common/config/handing/cssHanding.jsp\" %>");  // /root/default/  1.index.jsp 2.tpl_/subTpl.jsp
    	changeCodeNm.put("{-CONFIG_JS-}", "<%@ include file=\"/"+sitePath+"/common/config/handing/jsHanding.jsp\" %>");
    	
    	changeCodeNm.put("{-STATE-}", "<%@ include file=\"/_common/stateCount.jsp\" %>");
		changeCodeNm.put("{-STATE_TOTAL-}", "${total}");
		changeCodeNm.put("{-STATE_TODAY-}", "${today}");
		changeCodeNm.put("{-STATE_YESTERDAY-}", "${yesterday}");
    	
    	
    	//치환 추가 가능
    	if("A".equals(tplType)){
    		
    	}else if("B".equals(tplType)){    		
    		changeCodeNm.put("{-PAGETITLE-}", "<%= CmsServletPathProperty.getProp(servletPath,\"pageTitle\") %>");
    		changeCodeNm.put("{-PAGEIMGTITLE-}", "<%= CmsServletPathProperty.getProp(servletPath,\"pageImgTitle\") %>");
    		changeCodeNm.put("{-PAGENAV-}", "<%= CmsServletPathProperty.getProp(servletPath,\"pageNav\") %>");
    		changeCodeNm.put("{-PAGELINKNAV-}", "<%= JnitcmsmenuController.getMenuJSON(\"pageLinkNav\") %>");
    		changeCodeNm.put("{-PAGENAVTITLE-}", "<%= JnitcmsmenuController.getMenuJSON(\"pageNavTitle\") %>");
    		changeCodeNm.put("{-SUBTITLE-}", "<%= CmsServletPathProperty.getProp(servletPath,\"subTitle\") %>");
    		/*changeCodeNm.put("{-PAGEROBOT-}", "<% String robotYn = CmsServletPathProperty.getProp(servletPath,\"robotYn\") if(robotYn.equals(\"1\")){ %> <meta name=\"robots\" content=\"noindex\" /> <% } %>");*/
    		
    		//CCL
    		changeCodeNm.put("{-CCL_LINK-}", "<%=CclUtil.getLink(CmsServletPathProperty.getProp(servletPath,\"pageCcl\"))%>");
    		changeCodeNm.put("{-CCL_GENERAL_IMG-}", "<%=CclUtil.getGeneralImg(CmsServletPathProperty.getProp(servletPath,\"pageCcl\"))%>");
    		changeCodeNm.put("{-CCL_ALT-}", "<%=CclUtil.getAlt(CmsServletPathProperty.getProp(servletPath,\"pageCcl\"))%>");
    		changeCodeNm.put("{-CCL_KEYWORD-}", "<%=CclUtil.getKeyword(CmsServletPathProperty.getProp(servletPath,\"pageCcl\"))%>");
    		changeCodeNm.put("{-CCL_TEXT-}", "<%=CclUtil.getText(CmsServletPathProperty.getProp(servletPath,\"pageCcl\"))%>");
    		
    		//mata
    		changeCodeNm.put("{-CONFIG_SEO-}","<%@ include file=\"/"+sitePath+"/common/config/handing/metaHanding.jsp\" %>");
    		
    	}else if("O".equals(tplType)){
    		String printServletPath = "<% String servletPath = request.getParameter(\"path\"); if(servletPath.lastIndexOf(\"index.jsp\") == -1){ servletPath += \"index.jsp\";	} %>";
    		changeCodeNm.put("{-CONFIG_SET_PRINT-}", ""
													+"<% /* cset_s */ %>"
														+printServletPath
														+cSet2 //localYn
													+"<% /* cset_e */ %>"
													);
    		changeCodeNm.put("{-CSS-}", "<link rel=\"stylesheet\" type=\"text/css\" href=\"/${Jnit_sitePath}/common/css/Jnit_print.css\" media=\"all\">");
    		changeCodeNm.put("{-PRINT_CONTENT-}", "<script type=\"text/javascript\">document.write($(\".content\", opener.document).html());</script>");
    		changeCodeNm.put("{-PAGETITLE-}", "<%= CmsServletPathProperty.getProp(servletPath,\"pageTitle\") %>");
    		changeCodeNm.put("{-PAGEIMGTITLE-}", "<%= CmsServletPathProperty.getProp(servletPath,\"pageImgTitle\") %>");
    		changeCodeNm.put("{-PAGENAV-}", "<%= CmsServletPathProperty.getProp(servletPath,\"pageNav\") %>");
    		changeCodeNm.put("{-PAGELINKNAV-}", "<%= CmsServletPathProperty.getProp(servletPath,\"pageLinkNav\") %>");
    		changeCodeNm.put("{-PAGENAVTITLE-}", "<%= CmsServletPathProperty.getProp(servletPath,\"pageNavTitle\") %>");
    	
    	}
    	//역치환
    	if("return".equals(chageType)){ 		
    		HashMap<String, String> returnMap = new HashMap<String, String>();    		
    		Iterator codeNmIterator = changeCodeNm.entrySet().iterator();
    		
    		while(codeNmIterator.hasNext()){
				Entry item = (Entry) codeNmIterator.next();
				String key = (String) item.getKey();				
				returnMap.put(changeCodeNm.get(key), key);
    		}    		
    		changeCodeNm.clear();  		
    		changeCodeNm = returnMap;
    	}    	
    	return changeCodeNm;
    }
    
    /**
     * 필수요소적인 것만 HashMap 제어 구분지어 갯수를 제어한다. 
     * @param type - 구분
     * @return
     * @throws Exception
     */
    public static HashMap getEssentialCode(String type)throws Exception{
    	HashMap<Integer, String> essentialMap = new HashMap<Integer, String>();
    	int i = 0;
    	
    	//추가기능 ex) essentialMap.put(i, "코드명"); i++;
    	if("A".equals(type)){ //메인템플릿
    		essentialMap.put(i, "{-CONFIG_CSS-}"); i++;
    		essentialMap.put(i, "{-CONFIG_JS-}"); i++;
    	}else if("B".equals(type)){ //서브템플릿    		
    		essentialMap.put(i, "{-CONFIG_CSS-}"); i++;
    		essentialMap.put(i, "{-CONFIG_JS-}"); i++;    		
    	}    	
    	return essentialMap;
    }   
    
    public static String returnGetSiteChangeCode(String str,String start, String end, int num)throws Exception{
    	str = NullUtil.nullString(str);
    	if(!"".equals(str)){
    		str = str.replace(str.substring(str.indexOf(start), str.indexOf(end)+num), "");    		
    	}
    	return str;
    }
}
