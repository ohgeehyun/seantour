/**
 * @version 3.2.0.1
 */
package jnit.board;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.com.cmm.service.EgovProperties;
import jnit.board.db.JnitboarddbService;
import jnit.board.db.JnitboarddbVO;
import jnit.board.file.JnitboardfileService;
import jnit.board.info.JnitboardinfoService;
import jnit.db.JnitdbService;
import jnit.util.PathUtil;

@Controller
public class JnitboardEmailController {
	
	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name = "jnitboardinfoService")
	private JnitboardinfoService infoService;

	@Resource(name = "jnitboarddbService")
	private JnitboarddbService jnitboarddbService;

	@Resource(name = "jnitboardfileService")
	private JnitboardfileService fileService;

	@Resource(name = "jnitdbService")
	private JnitdbService dbService;
	private static final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    public static final String SEPERATOR = File.separator;
    public static final String BOARD_LATEST_PATH = "board" + SEPERATOR + "_latest" + SEPERATOR;
    public static final String BOARD_UPLOAD_PATH = uploadDir + SEPERATOR + "board" + SEPERATOR;
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");
    /**
     * 메일보내기
     */
    @RequestMapping(value="/board/send_email.do")
    public String courseSendMail(
    		@RequestParam("boardId") String boardId ,
    		@RequestParam("cntId") String cntId,
    		@RequestParam("sname") String sname,
    		@RequestParam("semail") String semail,
    		@RequestParam("remail") String remail,
    		HttpServletRequest request, 
    		ModelMap model) throws Exception {
    	
    	JnitboarddbVO dbVO = new JnitboarddbVO();
		dbVO.setBoardId(boardId);
		dbVO.setId(Integer.parseInt(cntId));
		dbVO = jnitboarddbService.selectAnonymous(dbVO);
		
		//apimap에서 smtp주소 가져오기
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
		
    	HtmlEmail he = new HtmlEmail();
    	he.setCharset("UTF-8");
    	he.setHostName(
    			//EgovProperties.getProperty("Globals.SMTP.hostname").trim()
    			prop.getProperty("gsmtphost")
    	);
    	he.setAuthentication(
    			//EgovProperties.getProperty("Globals.SMTP.user").trim(),
    			//EgovProperties.getProperty("Globals.SMTP.password").trim()
    			prop.getProperty("gsmtpuser"),prop.getProperty("gsmtppass")
    	);
    	
    	he.setTLS(true);
    	he.setSmtpPort(
    		//Integer.parseInt( EgovProperties.getProperty("Globals.SMTP.port") )
    			Integer.parseInt(prop.getProperty("gsmtpport"))
    	);
    	
    	
    	if("true".equals(deDug)) log.debug(/*EgovProperties.getProperty("Globals.SMTP.hostname")*/prop.getProperty("gsmtpname")+ " " + sname+" "+semail);
    	he.setFrom(semail, sname, "UTF-8");
    	he.addTo(remail);
    	
    	he.setSubject(sname+"님께서 추천한 게시물입니다.");
    	
        // TPL File 로딩
        String tplDir = PathUtil.getRealPath(request);

        String tplFile = tplDir + "/WEB-INF/jsp/jnit/board/email_template.jsp";
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
        mailTemplate = mailTemplate.replaceAll("\\{\\-LINK\\-\\}", url + "/board/board.do?boardId="+boardId+"&mode=view&cntId=" + cntId);
        mailTemplate = mailTemplate.replaceAll("\\{\\-BOARD_TITLE\\-\\}", dbVO.getTitle());
        mailTemplate = mailTemplate.replaceAll("\\{\\-CONTENT\\-\\}", dbVO.getContent());
    	he.setHtmlMsg(mailTemplate);
    	try{
    		he.send();
    	}catch(EmailException e){
    		log.error(e.getMessage());
    	}
    	
        return "/jnit/board/email_ok";
    }
    
    
    
    
}