package geocni.travel.member.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import geocni.travel.common.TravelFameManager;
import geocni.travel.member.domain.TravelFamePoint;
import geocni.travel.member.domain.TravelReaction;
import geocni.travel.member.service.TravelMemberService;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.service.TravelDestinationService;
import geocni.travel.route.service.TravelRouteService;
import jnit.cms.mbr.JnitcmsmbrService;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/travel/")
//@SessionAttributes(types=TravelFameController.class)
public class TravelFameController {

	@Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;

    @Resource(name = "travelMemberService")
    private TravelMemberService memberService;
	
    @Resource(name = "travelRouteService")
    private TravelRouteService routeService;

    @Resource(name = "travelDestinationService")
    private TravelDestinationService destService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@SuppressWarnings("unused")
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	@Resource(name = "egovMessageSource")
	EgovMessageSource msgSrc;

	private Log log = LogFactory.getLog(getClass());
	
	private String skinPath = "travel/fame/";
	
	@RequestMapping(value="fame/ranking.do")
	public String rankingList(
			 HttpServletRequest request
			,@ModelAttribute("famePoint") TravelFamePoint famePoint
    		,HttpSession session
			,Model model) throws Exception{
		
		
		//CommonUtil.upsertTravelFamePoint();
		
		//명성 랭킹 목록
		famePoint.setPageUnit(propertiesService.getInt("pageUnit"));
		famePoint.setPageSize(propertiesService.getInt("pageSize"));
		model.addAllAttributes(memberService.selectTravelFamePointListMap(famePoint));
		
		return skinPath + "ranking";
	}	
	
	@ResponseBody
	@RequestMapping(value="reco/insertAsync.do", produces="application/text;charset=utf8", method=RequestMethod.POST)
    public String insertTravelReactionAsync(
    		 TravelReaction travelReaction
            ,HttpServletRequest req
 			,Model model) throws Exception {
    	
		JSONObject JSON = new JSONObject();
		try {
			String msg = "추천";
			if(!NullUtil.isEmpty(travelReaction.getRxnType()) 
					&& "LIKE".equals(travelReaction.getRxnType())) {
				msg = "공감";
			}
			
			if("".equals(travelReaction.getRxnTargetId())) {
				throw new NullPointerException(msg+"대상정보가 없습니다");
			}
			
			int rxnCnt = memberService.selectTravelReactionCnt(travelReaction);
			if(rxnCnt > 0) {
				memberService.deleteLike(travelReaction);
				
				JSON.put("result", "공감을 취소하였습니다.");

			} else {
				
				TravelReaction reaction = memberService.insertTravelReaction(travelReaction);
				
				//추천일 경우 명성 히스토리 업데이트
				if("RECO".equals(travelReaction.getRxnType()) 
						&& !NullUtil.isEmpty(travelReaction.getRxnUserId())) {
					
					TravelFameManager fameManager = new TravelFameManager(travelReaction.getRxnTargetId(), req);
					Thread thread = new Thread(fameManager);
					thread.start();
					
				}
				//공감의 경우 여행지 공감포인트 업데이트
				if("LIKE".equals(travelReaction.getRxnType())) {
					TravelDestination desti = new TravelDestination();
					desti.setSearchCondition("1");
					desti.setDestId(travelReaction.getRxnTargetId());
					destService.updateTravelDestinationStatPoint(desti);
				}

				if(reaction != null) {
					JSON.put("result", msg+"하였습니다");
				}
			}
			
			JSON.put("status", "success");
		
		} catch (NullPointerException e){
			JSON.put("status", "error");
			JSON.put("result", e.getMessage());
		} catch (Exception e) {
			JSON.put("status", "error");
		}

		return JSON.toString();
    }

	@ResponseBody
    @RequestMapping(value="fame/kakao/callback.do")
    public String insertTravelReactionBySharing(
    		 TravelReaction travelReaction
            ,HttpServletRequest req
    		,Model model) throws Exception {
    	
		try {
			log.debug("Entered in callback=================================");
		    if(!NullUtil.isEmpty(travelReaction.getRxnUserId()) 
		    		&& !NullUtil.isEmpty(travelReaction.getRxnTargetId())) {
		        
		    	travelReaction.setRxnType("SHARE");
				log.debug("Entered in insertTravelReaction=================================");
		    	@SuppressWarnings("unused")
		    	TravelReaction reaction = memberService.insertTravelReaction(travelReaction);
				log.debug("Finished insertTravelReaction=================================");
		    	
		    	//공유 결과에 따른 명성 히스토리 업데이트
	    		TravelFameManager fameManager = new TravelFameManager(travelReaction.getRxnUserId(), travelReaction.getRxnType(), req);
	    		Thread thread = new Thread(fameManager);
	    		thread.start();
		    }

		} catch (NullPointerException e) {
			/*e.printStackTrace();*/
			log.error(e.getMessage());
		}

		return "Thank you";
    }

	@RequestMapping(value="insert.do", method=RequestMethod.POST)
	public String insertTravelReaction(
			 TravelReaction travelReaction
			,BindingResult bindingResult
			,SessionStatus status
			,HttpServletRequest req
			,Model model) throws Exception {
		
		try {
			
			@SuppressWarnings("unused")
			TravelReaction reaction = memberService.insertTravelReaction(travelReaction);
			
		} catch (NullPointerException e) {
			log.debug(e);
		}catch (SQLException e) {
			log.debug(e);
		}
		
		return skinPath + "result";
	}
	
}
