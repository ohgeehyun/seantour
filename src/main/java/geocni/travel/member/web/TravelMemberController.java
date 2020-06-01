package geocni.travel.member.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.member.domain.TravelClipboard;
import geocni.travel.member.domain.TravelFameHistory;
import geocni.travel.member.domain.TravelFamePoint;
import geocni.travel.member.service.TravelMemberService;
import geocni.travel.route.domain.TravelRoute;
import geocni.travel.route.service.TravelRouteService;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.mgov.module.JnitMgovUtil;

@Controller
@RequestMapping("/travel/member/")
//@SessionAttributes(types=TravelMember.class)
public class TravelMemberController {

	@Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;

    @Resource(name = "travelMemberService")
    private TravelMemberService memberService;
	
    @Resource(name = "travelRouteService")
    private TravelRouteService routeService;

    @Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@SuppressWarnings("unused")
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	@Resource(name = "egovMessageSource")
	EgovMessageSource msgSrc;

	private String skinPath = "travel/member/";
	
	@RequestMapping(value="mypage.do")
	public String mypage(
			 HttpServletRequest request
			,@ModelAttribute("jnitcmsmbrVO") JnitcmsmbrVO jnitcmsmbrVO
			,@ModelAttribute("recommHistory") TravelFameHistory recommHistory
			,TravelFamePoint famePoint
    		,HttpSession session
			,Model model) throws Exception{
		
		JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
		if(NullUtil.isEmpty(loginVO.getMbrId())) {
			//return WsNavUtil.alertAndRedirect(model, "회원전용 서비스 입니다.\\n로그인 후 이용해 주세요.", "/accounts/login/");
			return "redirect:/";
		}
		
		//나의명성점수
		//famePoint.setFameUserId(loginVO.getMbrId());
		famePoint = memberService.selectTravelFamePoint(loginVO.getMbrId());
		model.addAttribute("famePoint", famePoint);
		
		//명성점수 내역
		recommHistory.setPageUnit(propertiesService.getInt("pageUnit"));
		recommHistory.setPageSize(propertiesService.getInt("pageSize"));
		model.addAllAttributes(memberService.selectTravelFameHistoryListMap(recommHistory));
		
		return skinPath + "mypage";
	}	
	
	@RequestMapping(value="clipboard.do")
	public String clipboardList(
			 @ModelAttribute("searchVO") TravelDefaultVO searchVO
			,TravelClipboard travelClipboard
            ,SessionStatus status
			,Model model) throws Exception {
		
		travelClipboard.setPageUnit(propertiesService.getInt("pageUnit"));
		travelClipboard.setPageSize(propertiesService.getInt("pageSize"));

		model.addAllAttributes(memberService.selectTravelClipboardListMap(travelClipboard));
		status.setComplete();
		
        model.addAttribute("travelClipboard", travelClipboard);
		
		return skinPath + "clipboard";
	}

	@RequestMapping(value="myroute.do")
	public String myRouteList(
//			@ModelAttribute("searchVO") TravelDefaultVO searchVO
//			,TravelRoute travelRoute
			 @ModelAttribute("travelRoute") TravelRoute travelRoute
			,SessionStatus status
			,Model model) throws Exception {
		
		JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
		if(NullUtil.isEmpty(loginVO.getMbrId())) {
			//return WsNavUtil.alertAndRedirect(model, "회원전용 서비스 입니다.\\n로그인 후 이용해 주세요.", "/accounts/login/");
			return "redirect:/";
		}
		
		travelRoute.setRoutRegMember(loginVO.getMbrId());
		travelRoute.setPageUnit(propertiesService.getInt("pageUnit"));
		travelRoute.setPageSize(propertiesService.getInt("pageSize"));
		
		model.addAllAttributes(routeService.selectTravelRouteListMap(travelRoute));
		status.setComplete();
		
//        model.addAttribute("travelRoute", travelRoute);
		
		return skinPath + "myroute";
	}
	
}
