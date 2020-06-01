/**
 * @version 3.2.0.1
 */
package jnit.site.state;

import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import jnit.cms.config.ConfigUtil;

public class JnitSiteStateUtil {

	public static Log log = LogFactory.getLog(JnitSiteStateUtil.class);
	
	private final static boolean DEBUG = "true".equals(EgovProperties.getProperty("Globals.Debug")) ? true : false;

	public static void siteStateCount(String sitePath) throws Exception{
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
		
		JnitSiteStateService jnitSiteStateService = (JnitSiteStateService) wContext.getBean("jnitSiteStateService");
		
		sitePath = NullUtil.nullString(sitePath);
		String ipCheck = NullUtil.nullString(ConfigUtil.getDefaultProp("state"));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(Calendar.getInstance().getTime());
		String remoteIp = request.getRemoteAddr();
		
		if(sitePath.equals("")){
			log.debug("Err. sitePath Is Null");
		}
		
		//날짜 추가
		CaseInsensitiveMap stateCountCiMap = new CaseInsensitiveMap();
		stateCountCiMap.put("whenDate", today);

		int stateTableCount = jnitSiteStateService.selectState_Date(stateCountCiMap);	//state테이블 카운트 전용 셀렉트 where = today
		
		if(DEBUG){
			log.debug("stateTableCount: " + stateTableCount);
		}
		
		if(stateTableCount == 0){
			
			CaseInsensitiveMap ipCiMap = new CaseInsensitiveMap();
			CaseInsensitiveMap stateCiMap = new CaseInsensitiveMap();
			stateCiMap.put("whenDate", today);
				
			jnitSiteStateService.insertState(stateCiMap);		//state 테이블에 날짜 추가
			jnitSiteStateService.deleteIp(ipCiMap);				//ip 테이블에 이전 날의 데이터 모두 삭제
		}
		
		if(ipCheck.equals("Y")){					//IP 체크 옵션 사용할때
			
			if(DEBUG){
				log.debug("today : " + today);
				log.debug("remoteIp : " + remoteIp);
			}
			
			CaseInsensitiveMap ipCountCiMap = new CaseInsensitiveMap();
				ipCountCiMap.put("ip", remoteIp);
				ipCountCiMap.put("sitePath", sitePath);
			
			int ipTableCount = 0;
			
			try{
				ipTableCount = jnitSiteStateService.selectIp_Ip(ipCountCiMap);		//ip테이블 중복 체크
			}catch(NullPointerException e){
				log.error(e.getMessage());
				ipTableCount = 0;
			}
			
			if(DEBUG){
				log.debug("ipTableCount : " + ipTableCount);
			}
			
			if(ipTableCount == 0){				//IP가 중복되지 않으면
				
				CaseInsensitiveMap ciMap = new CaseInsensitiveMap();
				ciMap.put("sitePath", sitePath);
				ciMap.put("whenDate", today);
				ciMap.put("ip", remoteIp);
				
				jnitSiteStateService.updateState(ciMap);
				jnitSiteStateService.insertIp(ciMap);
				//update ( +1 )
				//ipInsert
				
			}
			
		}else{									//IP 체크 옵션 사용 안할때
			
			CaseInsensitiveMap ciMap = new CaseInsensitiveMap();
			ciMap.put("sitePath", sitePath);
			ciMap.put("whenDate", today);
			ciMap.put("ip", remoteIp);
			
			jnitSiteStateService.updateState(ciMap);				//사이트 카운트 +1
		}
	}
	
	public static HashMap<String, String> getTotalSiteCount(String sitePath){
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
		
		JnitSiteStateService jnitSiteStateService = (JnitSiteStateService) wContext.getBean("jnitSiteStateService");

		HashMap<String, String> resultMap = new HashMap<String, String>();
		
		CaseInsensitiveMap ciMap = new CaseInsensitiveMap();
			ciMap.put("sitePath", sitePath);
		
		try{
			
			CaseInsensitiveMap resultCiMap = jnitSiteStateService.selectTotal(ciMap);
			
			Iterator<String> itr = resultCiMap.keySet().iterator();
			while(itr.hasNext()){
				String key = itr.next().toString();
				String value = resultCiMap.get(key).toString();
				resultMap.put(key, value);
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			resultMap = new HashMap<String, String>();
		}catch(Exception e){
			log.error(e.getMessage());
			resultMap = new HashMap<String, String>();
		}
		
		return resultMap;
	}
}
