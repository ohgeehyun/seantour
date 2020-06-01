package geocni.utils;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import geocni.travel.member.domain.TravelFamePoint;
import geocni.travel.member.service.TravelMemberService;

public class CommonUtil {

	public static Log log = LogFactory.getLog(CommonUtil.class);

	public static void upsertTravelFamePoint() {

		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
        WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(((HttpServletRequest) request).getSession().getServletContext());
        
        TravelMemberService memberService = (TravelMemberService) context.getBean("travelMemberService");
        try {
			TravelFamePoint famePoint = memberService.selectTravelFamePoint("MBR_0000000002");
			log.debug(famePoint.getFameUserNm().toString());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
}
