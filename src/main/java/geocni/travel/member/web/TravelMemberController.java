package geocni.travel.member.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;


import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.member.domain.TravelClipboard;
import geocni.travel.member.domain.TravelFameHistory;
import geocni.travel.member.domain.TravelFamePoint;
import geocni.travel.member.service.TravelMemberService;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.domain.TravelRoute;
import geocni.travel.route.service.TravelDestinationService;
import geocni.travel.route.service.TravelRouteService;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.mgov.module.JnitMgovUtil;
import net.sf.json.JSONObject;
import java.io.PrintWriter;


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
	
	private String skinPath = "travel/member/";
	
	@RequestMapping(value="mypage.do")
	public String mypage(
			 HttpServletRequest request 
			,HttpServletResponse response 
			,@ModelAttribute("jnitcmsmbrVO") JnitcmsmbrVO jnitcmsmbrVO
			,@ModelAttribute("recommHistory") TravelFameHistory recommHistory
			,TravelFamePoint famePoint
    		,HttpSession session
			,Model model) throws Exception{
		
		
		JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
		if(NullUtil.isEmpty(loginVO.getMbrId())) {
			//return WsNavUtil.alertAndRedirect(model, "회원전용 서비스 입니다.\\n로그인 후 이용해 주세요.", "/accounts/login/");
			 response.setContentType("text/html; charset=UTF-8");
			 PrintWriter out = response.getWriter();
	            out.println("<script>alert('회원전용 서비스 입니다.'); window.location.href='http://www.seantour.com/seantour_map/';</script>");
	            out.flush();
	          
			//return "../../index";
		}
		
		//나의명성점수
		famePoint.setFameUserId(loginVO.getMbrId());
		famePoint = memberService.selectTravelFamePoint(loginVO.getMbrId());
		model.addAttribute("famePoint", famePoint);
		
		//명성점수 내역
		recommHistory.setFameHisRecUser(loginVO.getMbrId());
		recommHistory.setPageUnit(propertiesService.getInt("pageUnit"));
		recommHistory.setPageSize(propertiesService.getInt("pageSize"));
		model.addAllAttributes(memberService.selectTravelFameHistoryListMap(recommHistory));
		
		return skinPath + "mypage";
	}	
	
	@RequestMapping(value="myroute.do")
	public String myRouteList(
//			@ModelAttribute("searchVO") TravelDefaultVO searchVO
//			,TravelRoute travelRoute
			 @ModelAttribute("travelRoute") TravelRoute travelRoute
			 ,HttpServletResponse response 
//			,@RequestParam(value="open", required=false)String open
			,SessionStatus status
			,Model model) throws Exception {
		
		JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
		if(NullUtil.isEmpty(loginVO.getMbrId())) {
			//return WsNavUtil.alertAndRedirect(model, "회원전용 서비스 입니다.\\n로그인 후 이용해 주세요.", "/accounts/login/");
			 response.setContentType("text/html; charset=UTF-8");
	            PrintWriter out = response.getWriter();
	            out.println("<script>alert('회원전용 서비스 입니다.'); window.location.href='http://www.seantour.com/seantour_map/';</script>");
	            out.flush();
			//return "redirect:/";
		}
		
		travelRoute.setRoutType("U");
//		travelRoute.setRoutOpen(open);
		travelRoute.setRoutRegMember(loginVO.getMbrId());
		travelRoute.setPageUnit(propertiesService.getInt("pageUnit"));
		travelRoute.setPageSize(propertiesService.getInt("pageSize"));
		
		model.addAllAttributes(routeService.selectTravelRouteListMap(travelRoute));
		status.setComplete();
		
//        model.addAttribute("travelRoute", travelRoute);
		
		return skinPath + "myroute";
	}
	
	 @RequestMapping(value="detail.do")
	    public String destinationDetail(
	    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
	  			,TravelRoute travelRoute
	            ,HttpServletRequest req
	            ,HttpServletResponse response 
	    		,ModelMap model) throws Exception {
		 
		 	JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			if(NullUtil.isEmpty(loginVO.getMbrId())) {
				//return WsNavUtil.alertAndRedirect(model, "회원전용 서비스 입니다.\\n로그인 후 이용해 주세요.", "/accounts/login/");
					response.setContentType("text/html; charset=UTF-8");
		            PrintWriter out = response.getWriter();
		            out.println("<script>alert('회원전용 서비스 입니다.'); window.location.href='http://www.seantour.com/seantour_map/';</script>");
		            out.flush(); 
				//return "redirect:/";
			}
		 
	    	
	    	try{

	    		if(NullUtil.isEmpty(travelRoute.getRoutId())) {
	    			throw new NullPointerException("조회 대상 정보가 없습니다");
	    		}

	    		routeService.updateTravelRouteHitCount(travelRoute.getRoutId());

	    		model.addAttribute("travelRoute", routeService.selectTravelRoute(travelRoute));

	    	} catch (NullPointerException e){
				log.error(e.getMessage());
	    	}catch(Exception e){
	    		log.error(e.getMessage());
	    	}
	    	
	    	return skinPath + "detail";
	    }
	
	
	
    @RequestMapping(value="updatemyroute.do", method=RequestMethod.POST)
    public String updateMyRoute(
     		 TravelRoute travelRoute
            ,HttpServletRequest req
    		,Model model) throws Exception {
    	
    		try {
    			
    			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
    			travelRoute.setRoutRegMember(loginVO.getMbrId());

    			if(NullUtil.isEmpty(loginVO.getMbrId())) {
    				throw new NullPointerException();
    			}
    			
    			if(NullUtil.isEmpty(travelRoute.getRoutId()) || NullUtil.isEmpty(travelRoute.getRoutId())) {
    				throw new NullPointerException();
    			}
    			
				routeService.updateTravelRouteOpenStatus(travelRoute);

    		} catch (NullPointerException e){
    			e.printStackTrace();
    		} catch (Exception e) {
				e.printStackTrace();
			}
			
    		return "redirect:/travel/member/myroute.do";
    }
    
	@RequestMapping(value="clipboard.do")
	public String clipboardList(
			 @ModelAttribute("searchVO") TravelDefaultVO searchVO
			,TravelClipboard travelClipboard
            ,SessionStatus status
			,Model model) throws Exception {
		
		JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
		if(NullUtil.isEmpty(loginVO.getMbrId())) {
			return "redirect:/";
		}

		travelClipboard.setPageUnit(propertiesService.getInt("pageUnit"));
		travelClipboard.setPageSize(propertiesService.getInt("pageSize"));

		travelClipboard.setClipUserId(loginVO.getMbrId());
		model.addAllAttributes(memberService.selectTravelClipboardListMap(travelClipboard));
		status.setComplete();
		
        model.addAttribute("travelClipboard", travelClipboard);
		
		return skinPath + "clipboard";
	}

	@ResponseBody
	@RequestMapping(value="retrieveClipDestinationList.do", produces="application/text;charset=utf8")
	public String retrieveClipDestinationList(
			TravelClipboard travelClipboard
            ,SessionStatus status
            ,HttpServletRequest req
			,Model model) throws Exception {
		
		String dest = null;
		try {
			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			if(NullUtil.isEmpty(loginVO.getMbrId())) {
				return "redirect:/travel/login.jsp";
			} else {
				travelClipboard.setClipUserId(loginVO.getMbrId());
			}
			travelClipboard.setPageUnit(6);
			travelClipboard.setPageSize(10);
			Map<String, Object> destList = memberService.selectTravelClipDestinationListMap(travelClipboard);

			status.setComplete();
			ObjectMapper mapper = new ObjectMapper();
			dest = mapper.writeValueAsString(destList);
		} catch (Exception e) {
			log.debug(e.getMessage());
		}
		
		return dest;
	}
    
	@ResponseBody
	@RequestMapping(value="clipboard/insertAsync.do", produces="application/text;charset=utf8", method=RequestMethod.POST)
    public String insertTravelReactionAsync(
			 TravelClipboard travelClipboard
            ,HttpServletRequest req
 			,Model model) throws Exception {
    	
		JSONObject JSON = new JSONObject();

		try {
			
			if(NullUtil.isEmpty(travelClipboard.getClipUserId()) 
					|| NullUtil.isEmpty(travelClipboard.getClipPageId())) {
				throw new NullPointerException("대상정보가 없습니다");
			}
			
			int clipCnt = memberService.selectTravelClipboardCnt(travelClipboard);
			if(clipCnt > 0) {
				
				memberService.deleteclipboard(travelClipboard);
				JSON.put("result", "클립보드에서 삭제하였습니다.");

			} else {
				
				TravelClipboard reaction = memberService.insertTravelClipboard(travelClipboard);
				if(reaction != null) {
					JSON.put("result", "클립보드에 추가하였습니다");
					
					TravelDestination desti = new TravelDestination();
					desti.setSearchCondition("2");
					desti.setDestId(travelClipboard.getClipPageId());
					destService.updateTravelDestinationStatPoint(desti);

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
}
