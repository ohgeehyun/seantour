package jnit.cron;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import jnit.cms.disseminate.JnitcmsdisseminateService;

/**
 * 알리미 실행 크론
 *
 * @author
 *
 */
@Component
public class JnitCronDisseminate {

	@Resource(name = "jnitcmsdisseminateService")
    private JnitcmsdisseminateService jnitcmsdisseminateService;


	protected Log log = LogFactory.getLog(this.getClass());

	@Scheduled(cron = "${Globals.CRON.DISSEMINATE.TIMER}")
	public void excute() {
		try {
			if (!JnitCronUtil.isExcuteServer())return;
			jnitcmsdisseminateService.cronDisseminate();
		} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
}
