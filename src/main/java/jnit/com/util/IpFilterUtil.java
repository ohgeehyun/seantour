/**
 * @version 3.2.0.1
 */
package jnit.com.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import jnit.util.PathUtil;


/**
 * JNITCMS IP Filter Class 
 * @version : 1.0
 * @author  : Dael (dael@daelity.com)
 */
public class IpFilterUtil{

	public static Log log = LogFactory.getLog(IpFilterUtil.class);
	
	public static String FILTER_TYPE_NO = "no";
	public static String FILTER_TYPE_BLACKLIST = "blackList";
	public static String FILTER_TYPE_WHITELIST = "whiteList";
	
	public static final String SEPERATOR = File.separator;

	public static Boolean isPass() throws IOException{
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String securePath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/secureProp.prop";
		Properties secureProp = new Properties();
		File securePropFile = new File(securePath);
		InputStreamReader isr = null;
		FileInputStream fis = null;
		if(!securePropFile.exists()){
			return true;
		}
		try {
			fis = new FileInputStream(securePropFile);
			isr = new InputStreamReader(fis, "UTF-8");
			secureProp.load(isr);
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
		
		
		String ipFilterType = "";
		String ipListStr = secureProp.getProperty("ipList");
		
		ipFilterType = (String) secureProp.get("ipFilterType");
		
		if(FILTER_TYPE_NO.equals(ipFilterType) || "".equals(ipFilterType)){
			return true;
		}
		
	
		List<String> filterList = new ArrayList<String>();
		int bandCnt = 0;
		filterList.addAll(Arrays.asList(ipListStr.split("//")));
		
		Iterator filterItr = filterList.iterator();
		while(filterItr.hasNext()){
			String addr = (String)filterItr.next();
			String[] addrBand = addr.split("\\.");
			List<String> bandList = Arrays.asList(addrBand);
			int tmpBandCnt = bandList.indexOf("*");
			bandCnt = (bandCnt < tmpBandCnt) ? tmpBandCnt : bandCnt; 
		}
		String remoteAddr = request.getRemoteAddr();
		
		Boolean filterMatch = false;
		Boolean filterBand = false;
		
		

		if(filterList.indexOf(remoteAddr) > -1){
			filterMatch = true;
		}
		if(bandCnt > -1){
			Iterator<String> whiteItr = filterList.iterator();
			while(whiteItr.hasNext()){
				String crtAddr = (String)whiteItr.next();
				int idx = crtAddr.indexOf(".*");
				if(idx > -1){
					String compareAddr = crtAddr.substring(0,idx);
					if(remoteAddr.indexOf(compareAddr) > -1 ){
						filterBand = true;
					}
				}
			}
		}
		
		if(FILTER_TYPE_WHITELIST.equals(ipFilterType)){
			if(filterMatch == false && filterBand == false){
				return false;
			}
		}
		if(FILTER_TYPE_BLACKLIST.equals(ipFilterType)){
			if(filterMatch == true || filterBand == true){
				return false;
			}
		}

		return true;
	}

}