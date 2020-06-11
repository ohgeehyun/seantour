package geocni.travel.common;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import geocni.travel.member.domain.TravelFameHistory;
import geocni.travel.member.service.TravelMemberService;
import geocni.travel.route.domain.TravelRoute;
import geocni.travel.route.service.TravelRouteService;

public class TravelFameManager implements Runnable {

	private HttpServletRequest request;
	private String targetId;
	private String rxnType = "RECO";
	
	private Log log = LogFactory.getLog(getClass());
	
	public TravelFameManager(String targetId, HttpServletRequest request) {
		this.targetId = targetId;
		this.request = request;
	}

	public TravelFameManager(String targetId, String rxnType , HttpServletRequest request) {
		this.targetId = targetId;
		this.rxnType = rxnType;
		this.request = request;
	}
	
	@Override
	public void run() {
		
		manageTravelFame();
		
	}

	public void manageTravelFame() {
		
		try {
			log.debug("Started TravelFameManager Thread=================================");

			//HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			HttpSession session = request.getSession();
			ServletContext context = session.getServletContext();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			TravelMemberService memberService = (TravelMemberService) wContext.getBean("travelMemberService");

			int hisPoint = 0;
			String hisRecUser = null;
			String histType = null;
			String hisItem = null;
			
			if(rxnType.equals("LOGIN")) {
				int cnt = memberService.selectTravelFameHistoryCntByUser(targetId);
				if(cnt > 0) {
					return;
				}
				
				hisRecUser = targetId;
				histType = "L";
				hisItem = "홈페이지 로그인 접속";
				hisPoint = 10;

			} else if(rxnType.equals("SHARE")) {
				hisRecUser = targetId;
				histType = "S";
				hisItem = "여행지 SNS에 공유함";
				hisPoint = 50;
			
			} else {
				TravelRouteService routeService = (TravelRouteService) wContext.getBean("travelRouteService");
				TravelRoute travelRoute = new TravelRoute();
//				travelRoute.setAdminMode(true);
				travelRoute.setRoutId(targetId);
//				@SuppressWarnings("unchecked")
//				List<TravelRoute> routeList = (List<TravelRoute>) routeService.selectTravelRouteList(travelRoute);
//				String hisRecUser = routeList.get(0).getRoutRegMember();
				TravelRoute route = routeService.selectTravelRoute(travelRoute);
				hisRecUser = route.getRoutRegMember();
				histType = "R";
				hisItem = "내가 만든 여행일정 추천 받음";
				hisPoint = 100;
			}
			
			TravelFameHistory fameHistory = new TravelFameHistory();
			fameHistory.setFameHisPoint(hisPoint);
			fameHistory.setFameHisType(histType);
			fameHistory.setFameHisItem(hisItem);
			fameHistory.setFameHisRecUser(hisRecUser);
			memberService.insertTravelFameHistory(fameHistory);
			log.debug("Finished insertTravelFameHistory at TravelFameManager Thread=================================");

		} catch (Exception e) {
			// TODO : Exception 을 더 세분화 할 필요가 있다
			log.debug("======= Failed to FamePoint update =======");
			log.debug(e.getMessage());
		}
	
	}
}
