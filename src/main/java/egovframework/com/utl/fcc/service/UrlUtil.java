/**
 * @version 3.2.0.1
 */
package egovframework.com.utl.fcc.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;


public class UrlUtil {
	/**
	 * url인코딩
	 * @param url
	 * @return
	 */
	public static String encodeUrl(String url){
		String encUrl = "";
		try{
			encUrl = URLEncoder.encode(url,"utf-8");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return encUrl;
	}
	/**
	 * url디코딩
	 * @param url
	 * @return
	 */
	public static String decodeUrl(String url){
		String decUrl = "";
		try{
			decUrl = URLDecoder.decode(url,"utf-8");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return decUrl;
	}
	/**
	 * 현재 URL 가져오기.
	 * @param request
	 * @return
	 */
	public static String currentUrl(HttpServletRequest request){
		StringBuffer ret = new StringBuffer(request.getRequestURI());
		boolean bl = false;
		/*
		Enumeration names = request.getParameterNames();
		while(names.hasMoreElements()){
			if(!bl){
				ret.append("?");
				bl = true;
			}else{
				ret.append("&");
			}
			String paramName = (String)names.nextElement();
			String paramValue = request.getParameter(paramName);
			ret.append(paramName).append("=").append(paramValue);
		}
		*/
		if(request.getQueryString() != null){
			ret.append("?").append(request.getQueryString());
		}
		return ret.toString();
	}
	/**
	 * 현재 URL Encoding해서 가져오기.
	 * @param request
	 * @return
	 */
	public static String encodeCurrentUrl(HttpServletRequest request){
		return encodeUrl(currentUrl(request));
	}
	/**
	 * 현재 URL 전체(도메인,포트 등) 가져오기.
	 * @param request
	 * @return
	 */
	public static String currentAllUrl(HttpServletRequest request){
		StringBuffer ret = new StringBuffer();
		ret.append(currentContextUrl(request));
		ret.append(currentUrl(request));
		return ret.toString();
	}
	/**
	 * 컨텍스트 URL 가져오기.
	 * @param request
	 * @return
	 */
	public static String currentContextUrl(HttpServletRequest request){
		StringBuffer ret = new StringBuffer("http://");
		ret.append(request.getServerName());
		if(request.getServerPort() != 80)ret.append(":").append(request.getServerPort());
		if(!request.getContextPath().equals(""))ret.append(request.getContextPath());
		return ret.toString();
	}

	/**
	 * 파라메터 값들 중에서 해당 파라메터를 제외하고 모두 가져오기.
	 * @param request
	 * @param exceptParam
	 * @return
	 */
	public static String currentUrlExceptParameter(HttpServletRequest request,String exceptParam){
		StringBuffer ret = new StringBuffer();
		String q = NullUtil.nullString(request.getQueryString());
		int exIdx = q.indexOf(exceptParam);
		int nextIdx = -1;
		if(exIdx != -1){
			if(exIdx != 0)ret.append(q.substring(0, exIdx -1));
			for(int i = exIdx; i < q.length(); i++){
				if(q.charAt(i) == '&'){
					nextIdx = i;
					break;
				}
			}
			
			if(nextIdx != -1)ret.append(q.substring(nextIdx));
			if(exIdx == 0 && ret.length() > 0)ret.replace(0,1,"?");
			else ret.insert(0,'?');
		}else{
			if(!q.equals(""))ret.append("?").append(q);
		}
		return ret.toString();
	}
	
	/**
	 * URL 호출 후 전체 해당 내용 가져오기.
	 * @param strUrl 가져올 URL
	 * @return 내용(html)
	 */
	public static String getStringByUrl(String strUrl) throws Exception{
		StringBuilder result = new StringBuilder();
		URL url = null;   
		BufferedReader br = null;
		URLConnection urlcon = null;
		HttpURLConnection hurlc = null;
		try{
			url = new URL(strUrl);   
			urlcon = url.openConnection();
			hurlc = (HttpURLConnection)urlcon;
			urlcon.setConnectTimeout(3000);
			br = new BufferedReader(new InputStreamReader(hurlc.getInputStream()));
			String inputLine = null;
			result = new StringBuilder();   
			while((inputLine = br.readLine()) != null){
				result.append(inputLine);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			try{
				if(br != null)br.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result.toString();
	}
	/**
	 * 서브도메인인지 체크
	 * @param request
	 * @return
	 */
	public static boolean isSubDomain(String rootDomain, String domain){
		boolean bl = false;
		//String domain = request.getServerName();

		Pattern p = Pattern.compile("(.*)"+rootDomain);
		Matcher m = p.matcher(domain);
		if(m.find()){
			String subDomain = m.group(1);
			if(!subDomain.equals("www.")&&!subDomain.equals(""))bl = true;
		}
		
		return bl;
	}
}
