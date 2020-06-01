/**
 * @version 3.2.0.1
 */
package jnit.cms.mbr;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.com.cmm.service.EgovProperties;
import jnit.util.PathUtil;

@Controller
public class JnitpwEmailController {

	private Log log = LogFactory.getLog(getClass());
	
	private static final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    public static final String SEPERATOR = File.separator;
    public static final String BOARD_LATEST_PATH = "board" + SEPERATOR + "_latest" + SEPERATOR;
    public static final String BOARD_UPLOAD_PATH = uploadDir + SEPERATOR + "board" + SEPERATOR;
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");
    /**
     * 메일보내기
     */
    @RequestMapping(value="/mail.do")
    public String courseSendMail(
    		HttpServletRequest request, 
    		ModelMap model) throws Exception {

    	HttpServletRequest request1 = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();

    	Properties prop = new Properties();
    	String apiKeyPath = request1.getSession().getServletContext().getRealPath("/")+"WEB-INF/config/jnit/apiKey"+".prop";
    	
    	InputStreamReader isr = null;
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(apiKeyPath);
			isr = new InputStreamReader(fis,"UTF-8");
			try {
				prop.load(isr);
			} catch (IOException e) {
				log.error(e.getMessage());
			}
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
    	
    	String sname = "LTSKOREA";
    	String semail = "starpow1234@naver.com";
    	String remail = "starpow1234@naver.com";
    	
    	int size = 7;
    	
    	String psw = temporaryPassword(size)+"!@7";
    	
    	HtmlEmail he = new HtmlEmail();
    	he.setCharset("UTF-8");
    	
    	he.setHostName(
    			/*EgovProperties.getProperty("Globals.SMTP.hostname").trim()*/
    			prop.getProperty("gsmtphost")
    	);
    	he.setAuthentication(
    			/*EgovProperties.getProperty("Globals.SMTP.user").trim(),
    			EgovProperties.getProperty("Globals.SMTP.password").trim()*/
    			prop.getProperty("gsmtpuser"),prop.getProperty("gsmtppass")
    	);
    	he.setTLS(true);
    	he.setSmtpPort(587);
    	
    	
    	if("true".equals(deDug)) log.debug(/*EgovProperties.getProperty("Globals.SMTP.hostname")*/prop.getProperty("gsmtphost")+ " " + sname+" "+semail);
    	he.setFrom(semail, sname, "UTF-8");
    	he.addTo(remail);
    	
    	he.setSubject(sname+"님의 임시 비밀번호입니다.");
    	
        // TPL File 로딩
        String tplDir = PathUtil.getRealPath(request);

        String tplFile = tplDir + "/WEB-INF/jsp/jnit/cms/email/pw_email_template.jsp";
        BufferedReader in = new BufferedReader(new InputStreamReader(new FileInputStream(new File(tplFile)), "UTF-8"));

        String readLineStr = "";
        String mailTemplate = "";
        while((readLineStr = in.readLine()) != null) {
        	mailTemplate += readLineStr;
        }
        in.close();
        
        mailTemplate = mailTemplate.replaceAll("\\{\\-NAME\\-\\}", sname);
        
        Date dt = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
      
        String url = request.getRequestURL().toString();
		url = url.substring(0,url.indexOf("/", 8));
        mailTemplate = mailTemplate.replaceAll("\\{\\-DATE\\-\\}", sdf.format(dt).toString());
        mailTemplate = mailTemplate.replaceAll("\\{\\-PSW\\-\\}", psw);
    	he.setHtmlMsg(mailTemplate);
    	try{
    		he.send();
    	}catch(EmailException e){
    		log.error(e.getMessage());
    	}
    	
        return "/jnit/cms/email/email_ok";
    	
    }
    
	public static String temporaryPassword(int size) {
		StringBuffer buffer = new StringBuffer();
		Random random = new Random();

		String chars[] = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9"
				.split(",");

		for (int i = 0; i < size; i++) {
			buffer.append(chars[random.nextInt(chars.length)]);
		}
		return buffer.toString();
	}
	
}