/**
 * @version 3.2.0.1
 */
package egovframework.com.cmm.interceptor;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.com.utl.fcc.service.NullUtil;

/**
 * 인증여부 체크 인터셉터
 * @author 공통서비스 개발팀 서준식
 * @since 2011.07.01
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성 
 *  2011.09.07  서준식          인증이 필요없는 URL을 패스하는 로직 추가
 *  </pre>
 */


public class AuthenticInterceptor extends HandlerInterceptorAdapter {
	
	private Set<String> permittedURL;
	
	private Set<String> adminURL;
	
	private String userLoginURL;
	private String adminLoginURL;
	private String macAddress="";
	private String [] whiteIp = {""};			

	boolean useMacAddress = false;
	boolean useIp = false;
	
	public void setPermittedURL(Set<String> permittedURL) {
		this.permittedURL = permittedURL;
	}
	
	public void setAdminURL(Set<String> adminURL) {
		this.adminURL = adminURL;
	}

	public void setUserLoginURL(String userLoginURL) {
		this.userLoginURL = userLoginURL;
	}
	
	public void setAdminLoginURL(String adminLoginURL) {
		this.adminLoginURL = adminLoginURL;
	}
	
	/**
	 * 세션에 계정정보(LoginVO)가 있는지 여부로 인증 여부를 체크한다.
	 * 계정정보(LoginVO)가 없다면, 로그인 페이지로 이동한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {	
		ModelMap model = new ModelMap();
		String requestURI = request.getRequestURI(); //요청 URI
		boolean isPermittedURL = false; 
		boolean isAdminURL = false; 
		
		JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
		if(!NullUtil.nullString(loginVO.getMbrLogin()).equals("")){
			return true;
		}else{
			
			for(Iterator<String> it = this.permittedURL.iterator(); it.hasNext();){
				String urlPattern = request.getContextPath() + (String) it.next();

				if(Pattern.matches(urlPattern, requestURI)){// 정규표현식을 이용해서 요청 URI가 허용된 URL에 맞는지 점검함.
					isPermittedURL = true;
				}
			}
			
			if(!isPermittedURL){

				for(Iterator<String> it = this.adminURL.iterator(); it.hasNext();){
					String urlPattern = request.getContextPath() + (String) it.next();
					
					requestURI = requestURI.replace("//", "/");
					/*
					if(requestURI.indexOf(urlPattern) == 0){ // 요청 URI가 등록된 URL로 시작하는지 점검함.
						isAdminURL = true;
					}
					*/
					if(requestURI.contains("cms")){
						isAdminURL = true;
					}
					
				}
				
				ModelAndView modelAndView;
				if(isAdminURL) {
					if(ipLicense(request, response, model)){
						/*
						modelAndView = new ModelAndView("redirect:"+this.adminLoginURL);
						throw new ModelAndViewDefiningException(modelAndView);
						*/
						return true;
					}else{
						modelAndView = new ModelAndView("/jnit/util/alertMove",model);
						throw new ModelAndViewDefiningException(modelAndView);
					}
				}else{
					return true;
				}
			}else{
				return true;
			}
		}
	}
	private boolean ipLicense(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws IOException{
		if(!ipCheck() && useIp){
			model.addAttribute("alert","정식 라이센스 CMS가 아닙니다. 라이센스 문의 070-4212-4155로 문의 하시기 바랍니다.");
			model.addAttribute("path","http://www.ltskorea.co.kr/");
			
			return false;
		}
		if(!NullUtil.nullString(getMacAddress()).equals(macAddress) && useMacAddress){
			model.addAttribute("alert","개발자용 정식 라이센스 CMS가 아닙니다. 라이센스 문의 070-4212-4155로 문의 하시기 바랍니다.");
			model.addAttribute("path","http://www.ltskorea.co.kr/");
			
			return false;
		}
		return true;
	}
	
	public final static String getMacAddress() throws IOException {
        String os = System.getProperty("os.name");

        if (os.startsWith("Windows")) {
            return ParseMacAddress(windowsRunIpConfigCommand());
        } else if (os.startsWith("Linux")) {
            return ParseMacAddress(linuxRunIfConfigCommand());
        } else {
            throw new IOException("unknown operating system: " + os);
        }

    }
	private final static String windowsRunIpConfigCommand() throws IOException {
        Process p = Runtime.getRuntime().exec("ipconfig /all");
        InputStream stdoutStream = new BufferedInputStream(p.getInputStream());

        StringBuffer buffer = new StringBuffer();
        for (;;) {
            int c = stdoutStream.read();
            if (c == -1)
                break;
            buffer.append((char) c);
        }
        String outputText = buffer.toString();

        stdoutStream.close();

        return outputText;
    }
	private final static String linuxRunIfConfigCommand() throws IOException {
        Process p = Runtime.getRuntime().exec("ifconfig");
        InputStream stdoutStream = new BufferedInputStream(p.getInputStream());

        StringBuffer buffer = new StringBuffer();
        for (;;) {
            int c = stdoutStream.read();
            if (c == -1)
                break;
            buffer.append((char) c);
        }
        String outputText = buffer.toString();

        stdoutStream.close();

        return outputText;
    }

	public static String ParseMacAddress(String text) {
        String result = null;
        String[] list = text.split("\\p{XDigit}{2}(-\\p{XDigit}{2}){5}");
        int index = 0;
        for (String str : list) {
            if (str.length() < text.length()) {
                index = str.length();
                result = text.substring(index, index + 17);
                if (!result.equals("00-00-00-00-00-00")) {
                    break;
                }
                text = text.substring(index + 17);

            }
        }
        return result;
    }
	private String getIp(){
		String myIp = "";
		try {
			
	
			boolean isLoopBack = true;
			Enumeration<NetworkInterface> en;		
			en = NetworkInterface.getNetworkInterfaces();
	
				while(en.hasMoreElements()) {
				NetworkInterface ni = en.nextElement();
				if (ni.isLoopback())
					continue;
	
				Enumeration<InetAddress> inetAddresses = ni.getInetAddresses();
				while(inetAddresses.hasMoreElements()) { 
					InetAddress ia = inetAddresses.nextElement();
					if (ia.getHostAddress() != null && ia.getHostAddress().indexOf(".") != -1) {
						myIp = ia.getHostAddress();
						isLoopBack = false;
						break;
					}
				}
				if (!isLoopBack)
					break;
			}
			
		} catch (SocketException e) {
			e.printStackTrace();
		}
		return myIp;
	
	}
	private boolean ipCheck(){
		for(int i = 0; i<whiteIp.length; i++){
			if(whiteIp[i].contains(getIp())){
				//System.out.println(whiteIp[i] +"?=?"+getIp());
				return true;/*허용리스트에 포함되어 있다면 true*/
			}
		}
		
		return false;
	}
}
