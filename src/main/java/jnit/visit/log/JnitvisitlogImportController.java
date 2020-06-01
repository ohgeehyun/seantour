/**
 * @version 3.2.0.1
 */
package jnit.visit.log;

import java.io.File;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.WebApplicationContext;

/**
 * @Class Name : JnitvisitlogController.java
 * @Description : Jnitvisitlog Controller class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.10.29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitvisitlogVO.class)
public class JnitvisitlogImportController {
	 
	private Log log = LogFactory.getLog(getClass());
	
	public static final String SEPERATOR = File.separator;
    
    /**
	 * Insert Data
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitlogDefaultVO
	 * @return "/jnit/tpl-temp/jnitvisitlog/JnitvisitlogList"
	 * @exception Exception
	 */
    public static Boolean insertLogDataFromJCMS(WebApplicationContext ctx, String site, String page, String mbrId, String ipaddr, String referer, String userAgent, String userAction)
            throws Exception {
    	/*
    	Calendar cal = Calendar.getInstance();
    	
    	String regexesPath = ctx.getServletContext().getRealPath("/") + SEPERATOR + "WEB-INF"+SEPERATOR+"config"+SEPERATOR+"jnit"+SEPERATOR+"regexes.yaml";
    	File regexesFile = new File(regexesPath);
    	InputStream regexesIs = new java.io.FileInputStream(regexesFile);
    	Parser uaParser = new Parser(regexesIs);
    	
    	regexesIs.close();
    	
    	Client c = uaParser.parse(userAgent);
    	String userOs = c.os.family + " " + NullUtil.nullString(c.os.major);
    	userOs = userOs.trim();
    	String browser = c.userAgent.family + " " + c.userAgent.major;
    	//로그인된 사용자이면 MBR_ID를 남기고 그렇지 않는 경우 IP Address를 남긴다.
    	String user = mbrId == null ? ipaddr : mbrId; 

    	JnitvisitlogVO jnitvisitlogVO = new JnitvisitlogVO();
    	jnitvisitlogVO.setWhenDatetime(cal.getTime());
    	jnitvisitlogVO.setWherDate("true");
    	jnitvisitlogVO.setSite(site);
    	jnitvisitlogVO.setIpaddr(ipaddr);
    	jnitvisitlogVO.setReferer(referer);
    	jnitvisitlogVO.setUserOs(userOs);
    	jnitvisitlogVO.setBrowser(browser);
    	jnitvisitlogVO.setUserAgent(userAgent);
    	jnitvisitlogVO.setUser(user);
    	jnitvisitlogVO.setPage(page);
    	jnitvisitlogVO.setUserAction(userAction);
    	
    	JnitvisitcountVO jnitvisitcountVO = new JnitvisitcountVO();
    	jnitvisitcountVO.setSite(site);
    	jnitvisitcountVO.setVdate(cal.getTime());
    	jnitvisitcountVO.setVhour(cal.get(Calendar.HOUR_OF_DAY));
    	jnitvisitcountVO.setUserOs(userOs);
    	jnitvisitcountVO.setBrowser(browser);
    	
    	
    	String logSses = userAgent + "|" + ipaddr + "|" + page;
        JnitvisitlogService jnitvisitlogService = (JnitvisitlogService)ctx.getBean("jnitvisitlogService");
        JnitvisitcountService jnitvisitcountService = (JnitvisitcountService)ctx.getBean("jnitvisitcountService");

    	try{
			jnitvisitlogService.insertJnitvisitlog(jnitvisitlogVO);
			jnitvisitcountVO.setSearchCondition("2");
			int count = jnitvisitcountService.selectJnitvisitcountListTotCnt(jnitvisitcountVO);
			if(count > 0){
				jnitvisitcountVO.setWhereSiteYn("N");
				jnitvisitcountVO.setWhereAllYn("Y");
				jnitvisitcountVO = jnitvisitcountService.selectJnitvisitcount(jnitvisitcountVO);
				jnitvisitcountVO.setHit(jnitvisitcountVO.getHit()+1);
				jnitvisitcountService.updateJnitvisitcount(jnitvisitcountVO);
			}else{
				jnitvisitcountService.insertJnitvisitcount(jnitvisitcountVO);
			}			
    	}catch(DuplicateKeyException e){
    		
    	}catch (Exception e) {
			log.error(e.getMessage());
		}
    	if(regexesIs != null) regexesIs.close();
    	*/
    	return true;
    	
    }

}
