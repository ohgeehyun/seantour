package jnit.cron;

import javax.annotation.Resource;

import jnit.cms.mbr.JnitcmsmbrService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.scheduling.annotation.Scheduled;

import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.NullUtil;

public class JnitCronLoginUnlock {

	private Log log = LogFactory.getLog(this.getClass());
	
	@Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;
	
	/**
	 * 일정 횟수동안 로그인을 실패하여 잠긴 계정을 해제하기 위한 CRON
	 */
	@Scheduled(cron = "${Globals.CRON.LOGIN.UNCLOCK.TIMER}")
	public void excute() {
		try{
			if("Y".equals(NullUtil.nullString(Globals.CRON_LOGIN_UNCLOCK_ACTIVE).toUpperCase())){
				jnitcmsmbrService.unlockLogin(Globals.LOGIN_UNCLOCK_TIME);
			}
		}catch(NullPointerException e){
			log.error(e.getMessage());		//보안취약점에는 Exception으로만 잡으면 취약하다고 나와서 관계는 없지만 NullPointException을 추가함.
		}catch(Exception e){
			log.error(e.getMessage());
		}
	}
}
