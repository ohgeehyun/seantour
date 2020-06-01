package jnit.cron;

import java.net.InetAddress;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.com.cmm.service.Globals;

/**
 * CRON UTIL
 * 
 * @author 김문기
 * 
 */
public class JnitCronUtil {

	public static Log log = LogFactory.getLog(JnitCronUtil.class);
	
	/**
	 * CRON이 실행될 서버 체크
	 * 
	 * @return
	 */
	public static boolean isExcuteServer() {
		boolean ret = false;
		try {
			String currentIp = InetAddress.getLocalHost().getHostAddress();
			// 실행할 서버 IP - 전체 서버가 아닌 한 곳에서만 실행해야 될 때(2중화 등)
			String serverIp = Globals.CRON_EXCUTE_SERVER_IP;
			if (serverIp.indexOf(currentIp) >= 0) {
				ret = true;
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return ret;
	}
}
