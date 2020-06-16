package jnit.cms.mbr;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import jnit.util.PathUtil;
import net.sf.json.xml.XMLSerializer;

/**
 * @Class Name : CmsOauthService.java
 * @Description : OAuth 사용자 인증 처리를 한다
 * @Modification Information
 *
 * @author Dael at JNIT
 * @since 2012.07.28
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("cmsOauthService")
public class CmsOauthService extends AbstractServiceImpl {

	private Log log = LogFactory.getLog(getClass());
	
	public static final String FACEBOOK = "facebook";
	public static final String GOOGLE	= "google"; 
	public static final String TWITTER	= "twitter";
	public static final String NAVER = "naver";
	public static final String KAKAO = "kakao";

	String redirectUrl			= "/callback.do";
	
    String facebookOauthId		= "";
    String facebookOauthSecret	= "";
    String facebookOauthScope	= "user_about_me,user_birthday,user_photos,user_website,email";
    String facebookRequestUrl	= "https://www.facebook.com/dialog/oauth";
    String facebookTokenUrl		= "https://graph.facebook.com/oauth/access_token";
    String facebookDataUrl		= "https://graph.facebook.com/me";
    
    String googleOauthId		= "";
    String googleOauthSecret	= "";
    String googleOauthScope		= "https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email";
    String googleRequestUrl		= "https://accounts.google.com/o/oauth2/auth";
    String googleTokenUrl		= "https://accounts.google.com/o/oauth2/token";
    String googleDataUrl		= "https://www.googleapis.com/oauth2/v1/userinfo";
    
    String twitterOauthId		= "";
    String twitterOauthSecret	= "";
    String twitterOauthScope	= "";
    String twitterRequestUrl	= "https://api.twitter.com/oauth/request_token";
    String twitterTokenUrl		= "https://api.twitter.com/oauth/access_token";
    String twitterDataUrl		= "https://api.twitter.com/1/account/verify_credentials.json";

    String naverOauthId			= "";
    String naverOauthSecret		= "";
    String naverOauthScope		= "";
    String naverRequestUrl		= "https://nid.naver.com/oauth2.0/authorize";
    String naverTokenUrl		= "https://nid.naver.com/oauth2.0/token";
    String naverDataUrl			= "https://openapi.naver.com/v1/nid/getUserProfile.xml";
    
    String kakaoOauthId			= "";
    String kakaoOauthSecret		= "";
    String kakaoOauthScope		= "profile";
    String kakaoRequestUrl		= "https://kauth.kakao.com/oauth/authorize";
    String kakaoTokenUrl		= "https://kauth.kakao.com/oauth/token";
    String kakaoDataUrl			= "https://kapi.kakao.com/v2/user/me";
    
    /**
	 * Vender에 보낼 Request 정보를 가져옴.
	 * @param vender String,
     * @param request 
	 * @return HashMap
	 * @exception Exception
	 **/
    public HashMap<String,String> getVender(String vender, HttpServletRequest request) throws Exception {
    	
    	String snsloginPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/snsloginProp.prop";
		
		Properties snslogin = new Properties();
		File currentDefaultPropFile = new File(snsloginPath);
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
    	
    	HashMap<String,String> venderInfo = new HashMap<String,String>();
    	
		venderInfo.put("redirectUrl",	redirectUrl);

    	if( vender.equals(FACEBOOK) ){
    		venderInfo.put("oauthId",		snslogin.getProperty("facebookOauthId"));
    		venderInfo.put("oauthSecret",	snslogin.getProperty("facebookOauthSecret"));
    		venderInfo.put("oauthScope",	facebookOauthScope);
    		venderInfo.put("requestUrl",	facebookRequestUrl);
    		venderInfo.put("tokenUrl",		facebookTokenUrl);
    		venderInfo.put("dataUrl",		facebookDataUrl);
    	}
    	if( vender.equals(GOOGLE) ){
    		venderInfo.put("oauthId",		snslogin.getProperty("googleOauthId"));
    		venderInfo.put("oauthSecret",	snslogin.getProperty("googleOauthSecret"));
    		venderInfo.put("oauthScope",	googleOauthScope);
    		venderInfo.put("requestUrl",	googleRequestUrl);
    		venderInfo.put("tokenUrl",		googleTokenUrl);
    		venderInfo.put("dataUrl",		googleDataUrl);
    	}
    	if( vender.equals(TWITTER) ){
    		venderInfo.put("oauthId",		snslogin.getProperty("twitterOauthId"));
    		venderInfo.put("oauthSecret",	snslogin.getProperty("twitterOauthSecret"));
    		venderInfo.put("oauthScope",	twitterOauthScope);
    		venderInfo.put("requestUrl",	twitterRequestUrl);
    		venderInfo.put("tokenUrl",		twitterTokenUrl);
    		venderInfo.put("dataUrl",		twitterDataUrl);
    	}
    	if( vender.equals(NAVER) ){
    		venderInfo.put("oauthId",		snslogin.getProperty("naverOauthId"));
    		venderInfo.put("oauthSecret",	snslogin.getProperty("naverOauthSecret"));
    		venderInfo.put("oauthScope",	naverOauthScope);
    		venderInfo.put("requestUrl",	naverRequestUrl);
    		venderInfo.put("tokenUrl",		naverTokenUrl);
    		venderInfo.put("dataUrl",		naverDataUrl);
    	}
    	if( vender.equals(KAKAO) ){
    		venderInfo.put("oauthId",		snslogin.getProperty("kakaoOauthId"));
    		venderInfo.put("oauthSecret",	snslogin.getProperty("kakaoOauthSecret"));
    		venderInfo.put("oauthScope",	kakaoOauthScope);
    		venderInfo.put("requestUrl",	kakaoRequestUrl);
    		venderInfo.put("tokenUrl",		kakaoTokenUrl);
    		venderInfo.put("dataUrl",		kakaoDataUrl);
    	}
    	return venderInfo;
    }
    
    /**
	 * Access Token을 Vender에서 받아온다.
	 * @param vender String,
	 * @return String
	 * @exception Exception
	 **/
    public String getToken(String vender, String code, HttpServletRequest request) throws Exception {
    	 
    	code = code.trim();
    	
    	String parameter = "";
    	String token = "";

    	HashMap<String, String> venderInfo = this.getVender(vender, request);
		String oauthId			= venderInfo.get("oauthId");
		String oauthSecret		= venderInfo.get("oauthSecret");
		String oauthScope		= venderInfo.get("oauthScope");
		String tokenUrl			= venderInfo.get("tokenUrl");
	
		parameter = "redirect_uri=" + redirectUrl + "&client_id=" + oauthId + "&client_secret=" + oauthSecret + "&scope=" + oauthScope + "&code=" + code + "&grant_type=authorization_code";
		URL urlToken = new URL(tokenUrl);
    	URLConnection conn = urlToken.openConnection();
    	
    	conn.setDoOutput(true);
    	OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
    	wr.write(parameter);
    	wr.flush();
    	BufferedReader buff;
    	String read;
    	buff = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    	read = null;
    	String content ="";
    	while((read = buff.readLine()) != null){
    		content += read; 
    	}
    	log.debug("******acctoken content********");
	   	log.debug(content);
	   	log.debug("*********");
    	if(vender.equals(FACEBOOK) ){
    		String tmp1[] = content.split("=");
    		String tmp2[] = tmp1[1].split("&");
    		token		= tmp2[0];
    	}
    	
    	if(vender.equals(GOOGLE) ){
    		JSONObject result = (JSONObject) new JSONParser().parse(content);
        	token = (String)result.get("access_token");
    	}
    	
    	if(vender.equals(NAVER) || vender.equals(KAKAO)){
    		JSONObject result = (JSONObject) new JSONParser().parse(content);
        	token = (String)result.get("access_token");
        	String refreshToken =  (String)result.get("refresh_token");
        	token = token + "," + refreshToken;
    	}
    	
    	return token;
    }
    
    public HashMap<String,String> getUserData(String vender, String token, HttpServletRequest request) throws Exception{
    	token = token.trim();
    	
    	HashMap<String,String> userData = new HashMap<String,String>();
    	
    	HashMap<String, String> venderInfo = this.getVender(vender, request);
		String oauthId			= venderInfo.get("oauthId");
		String oauthSecret		= venderInfo.get("oauthSecret");
		@SuppressWarnings("unused")
		String oauthScope		= venderInfo.get("oauthScope");
		String dataUrl			= venderInfo.get("dataUrl");
    	
		String refreshToken = "";
		if(vender.equals(NAVER) || vender.equals(KAKAO)){//네이버는 acc 토큰과 refresh 토큰 2개가 있음
			String[] tokenList = token.split(",");
			token = tokenList[0];
			refreshToken = tokenList[1];
		}
		
		dataUrl = dataUrl + "?access_token=" + token;
    	URL urlData = new URL(dataUrl);
    	URLConnection conn = urlData.openConnection();
    	
    	conn.setRequestProperty("User-Agent", "curl/7.12.1 (i686-redhat-linux-gnu) libcurl/7.12.1 OpenSSL/0.9.7a zlib/1.2.1.2 libidn/0.5.6");
    	conn.setRequestProperty("Host", "openapi.naver.com");
    	conn.setRequestProperty("Pragma", "no-cache");
    	conn.setRequestProperty("Accept", "*/*");
    	conn.setRequestProperty("Authorization", "Bearer "+token);
    	
    	BufferedReader buff;
    	String read;
    	buff = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    	read = null;
    	String content ="";
    	while((read = buff.readLine()) != null){
    		content += read; 
    	}
    	if(vender.equals(NAVER)){
    	
    		try{
    			net.sf.json.JSONObject result = (net.sf.json.JSONObject) new XMLSerializer().read(content);
        		userData.put("id", (String)result.getJSONObject("response").get("id"));
            	userData.put("name", (String)result.getJSONObject("response").get("name"));
            	userData.put("email", (String)result.getJSONObject("response").get("email"));
            	userData.put("picture", (String)result.getJSONObject("response").get("profile_image"));
    		} catch (NullPointerException e){//토큰 만료 등 이슈 발생시 토큰을 다시 받는다.
    			dataUrl="https://nid.naver.com/oauth2.0/token?grant_type=refresh_token&client_id="+oauthId+"&client_secret="+oauthSecret+"&refresh_token="+refreshToken;
    			urlData = new URL(dataUrl);
    	    	conn = urlData.openConnection();
    	    	
    	    	buff = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    	    	read = null;
    	    	content ="";
    	    	while((read = buff.readLine()) != null){
    	    		content += read; 
    	    	}
    	    	JSONObject result = (JSONObject) new JSONParser().parse(content);
            	token = (String)result.get("access_token");//access_token을 다시 받음
            	
            	dataUrl = venderInfo.get("dataUrl") + "?access_token=" + token;
            	urlData = new URL(dataUrl);
            	conn = urlData.openConnection();
            	
            	buff = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            	read = null;
            	content ="";
            	while((read = buff.readLine()) != null){
            		content += read; 
            	}
    	    	net.sf.json.JSONObject naverResult = (net.sf.json.JSONObject) new XMLSerializer().read(content);
        		userData.put("id", (String)naverResult.getJSONObject("response").get("id"));
            	userData.put("name", (String)naverResult.getJSONObject("response").get("name"));
            	userData.put("email", (String)naverResult.getJSONObject("response").get("email"));
            	userData.put("picture", (String)naverResult.getJSONObject("response").get("profile_image"));
    		}catch(Exception e){//토큰 만료 등 이슈 발생시 토큰을 다시 받는다.
    			dataUrl="https://nid.naver.com/oauth2.0/token?grant_type=refresh_token&client_id="+oauthId+"&client_secret="+oauthSecret+"&refresh_token="+refreshToken;
    			urlData = new URL(dataUrl);
    	    	conn = urlData.openConnection();
    	    	
    	    	buff = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    	    	read = null;
    	    	content ="";
    	    	while((read = buff.readLine()) != null){
    	    		content += read; 
    	    	}
    	    	JSONObject result = (JSONObject) new JSONParser().parse(content);
            	token = (String)result.get("access_token");//access_token을 다시 받음
            	
            	dataUrl = venderInfo.get("dataUrl") + "?access_token=" + token;
            	urlData = new URL(dataUrl);
            	conn = urlData.openConnection();
            	
            	buff = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            	read = null;
            	content ="";
            	while((read = buff.readLine()) != null){
            		content += read; 
            	}
    	    	net.sf.json.JSONObject naverResult = (net.sf.json.JSONObject) new XMLSerializer().read(content);
        		userData.put("id", (String)naverResult.getJSONObject("response").get("id"));
            	userData.put("name", (String)naverResult.getJSONObject("response").get("name"));
            	userData.put("email", (String)naverResult.getJSONObject("response").get("email"));
            	userData.put("picture", (String)naverResult.getJSONObject("response").get("profile_image"));
    		}

    		
    	} else if(vender.equals(KAKAO)){
        	
    		try{
    			
    			ObjectMapper mapper = new ObjectMapper();
    			JsonNode userInfo = mapper.readTree(content);
    			String kakao_id = userInfo.path("id").asText();
    			JsonNode properties = userInfo.path("properties");
    	        JsonNode kakao_account = userInfo.path("kakao_account");
    	        String kakao_name = properties.path("nickname").asText();
    	        String kakao_email = kakao_account.path("email").asText();
    	        String kakao_picture = properties.path("profile_image").asText();
    	        
    			//userData.putAll(extractKakaoUserInfo(content));
    			userData.put("id", kakao_id);
    			userData.put("name", kakao_name);
    			userData.put("email", kakao_email);
    			userData.put("picture", kakao_picture);

    		} catch (NullPointerException e){//토큰 만료 등 이슈 발생시 토큰을 다시 받는다.
    			dataUrl="https://kauth.kakao.com/oauth/token?grant_type=refresh_token&client_id="+oauthId+"&client_secret="+oauthSecret+"&refresh_token="+refreshToken;
    			urlData = new URL(dataUrl);
    	    	conn = urlData.openConnection();
    	    	
    	    	buff = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    	    	read = null;
    	    	content ="";
    	    	while((read = buff.readLine()) != null){
    	    		content += read; 
    	    	}
    	    	JSONObject result = (JSONObject) new JSONParser().parse(content);
            	token = (String)result.get("access_token");//access_token을 다시 받음
            	
            	dataUrl = venderInfo.get("dataUrl") + "?access_token=" + token;
            	urlData = new URL(dataUrl);
            	conn = urlData.openConnection();
            	
            	buff = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            	read = null;
            	content ="";
            	while((read = buff.readLine()) != null){
            		content += read; 
            	}
    			//userData.putAll(extractKakaoUserInfo(content));
    			ObjectMapper mapper = new ObjectMapper();
    			JsonNode userInfo = mapper.readTree(content);
    			String kakao_id = userInfo.path("id").asText();
    			JsonNode properties = userInfo.path("properties");
    	        JsonNode kakao_account = userInfo.path("kakao_account");
    	        String kakao_name = properties.path("nickname").asText();
    	        String kakao_email = kakao_account.path("email").asText();
    	        String kakao_picture = properties.path("profile_image").asText();

    	        userData.put("id", kakao_id);
    			userData.put("name", kakao_name);
    			userData.put("email", kakao_email);
    			userData.put("picture", kakao_picture);
    	        
    		} catch(Exception e){//토큰 만료 등 이슈 발생시 토큰을 다시 받는다.
    			dataUrl="https://kauth.kakao.com/oauth/token?grant_type=refresh_token&client_id="+oauthId+"&client_secret="+oauthSecret+"&refresh_token="+refreshToken;
    			urlData = new URL(dataUrl);
    	    	conn = urlData.openConnection();
    	    	
    	    	buff = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    	    	read = null;
    	    	content ="";
    	    	while((read = buff.readLine()) != null){
    	    		content += read; 
    	    	}
    	    	JSONObject result = (JSONObject) new JSONParser().parse(content);
            	token = (String)result.get("access_token");//access_token을 다시 받음
            	
            	dataUrl = venderInfo.get("dataUrl") + "?access_token=" + token;
            	urlData = new URL(dataUrl);
            	conn = urlData.openConnection();
            	
            	buff = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            	read = null;
            	content ="";
            	while((read = buff.readLine()) != null){
            		content += read; 
            	}
    			//userData.putAll(extractKakaoUserInfo(content));
    			ObjectMapper mapper = new ObjectMapper();
    			JsonNode userInfo = mapper.readTree(content);
    			String kakao_id = userInfo.path("id").asText();
    			JsonNode properties = userInfo.path("properties");
    	        JsonNode kakao_account = userInfo.path("kakao_account");
    	        String kakao_name = properties.path("nickname").asText();
    	        String kakao_email = kakao_account.path("email").asText();
    	        String kakao_picture = properties.path("profile_image").asText();

    	        userData.put("id", kakao_id);
    			userData.put("name", kakao_name);
    			userData.put("email", kakao_email);
    			userData.put("picture", kakao_picture);
    		}
    	
    	} else {
     		JSONObject result = (JSONObject) new JSONParser().parse(content);
    		userData.put("id", (String)result.get("id"));
        	userData.put("name", (String)result.get("name"));
        	userData.put("email", (String)result.get("email"));
        	userData.put("picture", (String)result.get("picture"));
        	
    	}
    	
    	return userData;
    }

	public void setRedirectUrl(HttpServletRequest request, String callback) {
		// TODO Auto-generated method stub
		 
		StringBuffer callbackTempURL = request.getRequestURL();
		String tempUrl = callbackTempURL.toString().replace("210.179.121.231", "seantour.com");
		StringBuffer callbackURL = new StringBuffer(tempUrl);
        int index = callbackURL.lastIndexOf("/");
        callbackURL.replace(index, callbackURL.length(), "").append(callback);
        
        redirectUrl = callbackURL.toString();
	}
	
	// CSRF 방지를 위한 상태 토큰 생성 코드
	// 상태 토큰은 추후 검증을 위해 세션에 저장되어야 한다.
	

}
