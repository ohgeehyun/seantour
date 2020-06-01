package geocni.travel.route.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.domain.TravelRoute;
import geocni.travel.route.service.TravelDestinationService;
import geocni.travel.route.service.TravelRouteService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.mgov.module.JnitMgovUtil;
import net.sf.json.JSONObject;

@Controller
//@SessionAttributes(types=TravelRoute.class)
@RequestMapping(value="/travel/route/")
public class TravelRouteController {

    @Resource(name = "travelRouteService")
    private TravelRouteService routeService;

    @Resource(name = "travelDestinationService")
    private TravelDestinationService destService;
    
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	@Resource(name="egovMessageSource")
    private EgovMessageSource msgSrc;
    
    @SuppressWarnings("unused")
	@Autowired
    private DefaultBeanValidator beanValidator;

	private Log log = LogFactory.getLog(getClass());
	
	private String skinPath = "travel/route/";

	@RequestMapping(value="list.do")
	public String routeList(
			 TravelRoute travelRoute
			,@RequestParam(value="open", required=false)String open
            ,SessionStatus status
			,Model model) throws Exception {
		
		if(open != null && "Y".equals(open)) {
			/*JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			if(NullUtil.isEmpty(loginVO.getMbrId())) {
				return "redirect:/travel/login.jsp";
			}
			travelRoute.setRoutRegMember(loginVO.getMbrId());*/
			
			travelRoute.setRoutType("U");
			travelRoute.setRoutOpen(open);
		} else {
			travelRoute.setRoutType("W");
		}

		//travelRoute.setPageUnit(propertiesService.getInt("pageUnit"));
		travelRoute.setPageUnit(9);
		travelRoute.setPageSize(propertiesService.getInt("pageSize"));

		model.addAllAttributes(routeService.selectTravelRouteListMap(travelRoute));
		status.setComplete();
		
        model.addAttribute("travelRoute", travelRoute);
        model.addAttribute("open", open);
		
		return skinPath + "list";
	}

	@RequestMapping(value="bestlatest.do")
	public String routeBestLatestList(
			 TravelRoute travelRoute
			,SessionStatus status
			,Model model) throws Exception {
		
		travelRoute.setRecordCountPerPage(travelRoute.getPageUnit());
		travelRoute.setRoutType("U");
//		travelRoute.setRoutType("W"); //데이터부족상황에서 임시 설정
		travelRoute.setRoutOpen("Y");
		
		List<?> resultList = routeService.selectTravelRouteBestList(travelRoute);
		model.addAttribute("resultList", resultList);
		status.setComplete();
		
//		model.addAttribute("travelRoute", travelRoute);
		
		return skinPath + "bestlatest";
	}
	
	@RequestMapping(value="latest.do")
	public String routeLatestList(
			 TravelRoute travelRoute
			,@RequestParam(value="titleLen",required=false, defaultValue="350")String titleLen
			,SessionStatus status
			,Model model) throws Exception {
		
		//travelRoute.setPageUnit(propertiesService.getInt("pageUnit"));
		travelRoute.setPageSize(propertiesService.getInt("pageSize"));
		travelRoute.setRoutType("W");
		
		model.addAllAttributes(routeService.selectTravelRouteListMap(travelRoute));
		status.setComplete();
		
		model.addAttribute("titleLen", titleLen);
//		model.addAttribute("travelRoute", travelRoute);
		
		return skinPath + "latest";
	}
	
    @RequestMapping(value="detail.do")
    public String destinationDetail(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
  			,TravelRoute travelRoute
            ,HttpServletRequest req
    		,ModelMap model) throws Exception {
    	
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

    @RequestMapping(value="register.do")
    public String registerTravelRoute(
    		 TravelRoute travelRoute
 			,TravelDestination travelDestination
            ,HttpServletRequest req
            ,SessionStatus status
    		,Model model) throws Exception {

    	String viewPath = skinPath + "register";
    	/*Device device = DeviceUtils.getCurrentDevice(req);
    	
    	if(device != null && (device.isMobile() || device.isTablet())) {
    		viewPath = skinPath + "register_mob";
    		travelDestination.setPageUnit(5);
    		travelDestination.setPageSize(5);

    	} else {*/
    		travelDestination.setPageUnit(6);
    		travelDestination.setPageSize(10);
    	/*}*/
    	
    	try{
	
			List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
			model.addAttribute("regionList", regionList);
	    	
			List<String> searchCatList = new ArrayList<>();
			searchCatList.add("관광지");
			searchCatList.add("숙박");
			searchCatList.add("체험");
			searchCatList.add("음식점");
			searchCatList.add("쇼핑");
			Map<?,?> catList = destService.selectTravelDestiCategoryList(searchCatList);
			model.addAttribute("catList", catList);
			
	    	travelDestination.setDestRegion("강원");
	    	travelDestination.setDestCategory("관광지");
			model.addAllAttributes(destService.selectTravelDestinationListMap(travelDestination));
	    	
//	    	model.addAttribute("thumbPath", "https://www.seantour.com");
	    	model.addAttribute("thumbPath", "");
//	    	model.addAttribute("absPath", "/geocni/travel");

			travelRoute.setRoutRegion(travelDestination.getDestRegion());
	        model.addAttribute("travelRoute", travelRoute);
	    	
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
    	
    	return viewPath;
    }

	@ResponseBody
	@RequestMapping(value="insertAsync.do", produces="application/text;charset=utf8", method=RequestMethod.POST)
    public String insertTravelRouteAsync(
    		 TravelRoute travelRoute
            ,HttpServletRequest req
 			,Model model) throws Exception {
    	
		JSONObject JSON = new JSONObject();
		try {
			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			travelRoute.setRoutRegMember(loginVO.getMbrId());

			if(NullUtil.isEmpty(loginVO.getMbrId())) {
				throw new NullPointerException();
			}
			
			travelRoute.setRoutType("U"); //일정 타입(''U''-사용자, ''W''-작가)
			travelRoute.setRoutOpen("N"); //공개 여부("Y"-공개, "N"-비공개)
			travelRoute = routeService.insertTravelRoute(travelRoute);

			JSON.put("status", "success");
			JSON.put("routId", travelRoute.getRoutId());
			JSON.put("title", travelRoute.getRoutTitle());

		} catch (NullPointerException e){
			JSON.put("status", "error");
			JSON.put("result", e.getMessage());
		} catch (Exception e) {
			JSON.put("status", "error");
		}

		//return "";
		return JSON.toString();
    	
    }
    
    @RequestMapping(value="insert.do", method=RequestMethod.POST)
    public String insertTravelRoute(
    		 @ModelAttribute("travelRoute") TravelRoute travelRoute
            ,BindingResult bindingResult
            ,SessionStatus status
            ,HttpServletRequest req
    		,Model model) throws Exception {
    	
		try {
			
			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			travelRoute.setRoutRegMember(loginVO.getMbrId());

			if(NullUtil.isEmpty(loginVO.getMbrId())) {
				throw new NullPointerException();
			}
			
			travelRoute.setRoutType("U"); //일정 타입(''U''-사용자, ''W''-작가)
			travelRoute.setRoutOpen("N"); //공개 여부("Y"-공개, "N"-비공개)
			travelRoute = routeService.insertTravelRoute(travelRoute);

		} catch (NullPointerException e){
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/cms/travel/route/list.do";
    }

    @RequestMapping(value="modify.do")
    public String modifyTravelRoute(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
    		,TravelRoute travelRoute
 			,TravelDestination travelDestination
            ,HttpServletRequest req
    		,ModelMap model) throws Exception {
    	
    	String viewPath = skinPath + "register";
    	/*Device device = DeviceUtils.getCurrentDevice(req);
    	
    	if(device != null && (device.isMobile() || device.isTablet())) {
    		viewPath = skinPath + "register_mob";
    		travelDestination.setPageUnit(5);
    		travelDestination.setPageSize(5);

    	} else {*/
    		travelDestination.setPageUnit(6);
    		travelDestination.setPageSize(10);
    	/*}*/
    	
    	try{

    		List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
    		model.addAttribute("regionList", regionList);
        	
        	travelDestination.setDestRegion("강원");
        	travelDestination.setDestCategory("관광지");
			model.addAllAttributes(destService.selectTravelDestinationListMap(travelDestination));
        	
//        	model.addAttribute("thumbPath", "https://www.seantour.com");
        	model.addAttribute("thumbPath", "");
//        	model.addAttribute("absPath", "/geocni/travel");

        	travelRoute = routeService.selectTravelRoute(travelRoute);

        	JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			travelRoute.setRoutRegMember(loginVO.getMbrId());

			if(NullUtil.isEmpty(loginVO.getMbrId())) {
				throw new NullPointerException();
			} else {
				if(!loginVO.getMbrId().equals(travelRoute.getRoutRegMember())) {
					return "redirect:/";
				} else {
					model.addAttribute("travelRoute", travelRoute);
				}
			}

    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
    	
    	return viewPath;
    }

	@ResponseBody
	@RequestMapping(value="updateAsync.do", produces="application/text;charset=utf8", method=RequestMethod.POST)
    public String updateTravelRouteAsync(
    		 TravelRoute travelRoute
            ,HttpServletRequest req
 			,Model model) throws Exception {
    	
		JSONObject JSON = new JSONObject();
		try {
			
			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			travelRoute.setRoutRegMember(loginVO.getMbrId());

			if(NullUtil.isEmpty(loginVO.getMbrId())) {
				throw new NullPointerException();
			}
			
			if(NullUtil.isEmpty(travelRoute.getRoutId()) 
					|| NullUtil.isEmpty(travelRoute.getRoutId())) {
				throw new NullPointerException();
			}
			
			TravelRoute route = new TravelRoute();
			route.setRoutId(travelRoute.getRoutId());
			route = routeService.selectTravelRoute(route);
			if(NullUtil.isEmpty(route.getRoutRegMember()) 
					|| !route.getRoutRegMember().equals(travelRoute.getRoutRegMember())) {
				throw new Exception();
			}
			
			travelRoute.setRoutType("U"); //일정 타입(''U''-사용자, ''W''-작가)
			travelRoute.setRoutOpen("N"); //공개 여부("Y"-공개, "N"-비공개)
			routeService.updateTravelRoute(travelRoute);

			JSON.put("status", "success");
			JSON.put("routId", travelRoute.getRoutId());
			JSON.put("title", travelRoute.getRoutTitle());
		
		} catch (NullPointerException e){
			JSON.put("status", "error");
			JSON.put("result", e.getMessage());
		} catch (Exception e) {
			JSON.put("status", "error");
		}

		//return "";
		return JSON.toString();
    	
    }
    
    @RequestMapping(value="update.do", method=RequestMethod.POST)
    public String updateTravelRoute(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
     		,@ModelAttribute("travelRoute") TravelRoute travelRoute
            ,BindingResult bindingResult
            ,SessionStatus status
            ,HttpServletRequest req
    		,Model model) throws Exception {
    	
    		try {

    			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
    			travelRoute.setRoutRegMember(loginVO.getMbrId());

    			if(NullUtil.isEmpty(loginVO.getMbrId())) {
    				throw new NullPointerException();
    			}
    			
    			if(NullUtil.isEmpty(travelRoute.getRoutId()) 
    					|| NullUtil.isEmpty(travelRoute.getRoutId())) {
    				throw new NullPointerException();
    			}
    			
    			TravelRoute route = new TravelRoute();
    			route.setRoutId(travelRoute.getRoutId());
    			route = routeService.selectTravelRoute(route);
    			if(NullUtil.isEmpty(route.getRoutRegMember()) 
    					|| !route.getRoutRegMember().equals(travelRoute.getRoutRegMember())) {
    				throw new Exception();
    			}
    			
    			travelRoute.setRoutType("U"); //일정 타입(''U''-사용자, ''W''-작가)
    			travelRoute.setRoutOpen("N"); //공개 여부("Y"-공개, "N"-비공개)

    			routeService.updateTravelRoute(travelRoute);

			} catch (Exception e) {
				e.printStackTrace();
			}
			
    		return "redirect:/travel/member/myroute.do";
    }
    
    @RequestMapping(value="delete.do", method=RequestMethod.POST)
    public String deleteTravelRoute(
    		 TravelRoute travelRoute
            ,SessionStatus status
            ,HttpServletRequest req
    		,Model model) throws Exception {
    	
    		try {
   				if(NullUtil.isEmpty(travelRoute.getRoutId())) {
    				return "redirect:/travel/member/myroute.do";
    			} else {
    				routeService.deleteTravelRoutePhysically(travelRoute);
    			}
    			
			} catch (Exception e) {
				e.printStackTrace();
			}
			
            status.setComplete();
    		return "redirect:/travel/member/myroute.do";
    }
    
    @RequestMapping(value="address.do")
    public String searchAddress(
    		 TravelRoute travelRoute
            ,HttpServletRequest req
            ,@RequestParam("status") String status
            ,@RequestParam("idx") String idx
    		,Model model) throws Exception {
    	
//    	model.addAttribute("absPath", "/geocni/travel");
    	model.addAttribute("status", status);
    	model.addAttribute("idx", idx);

    	return skinPath + "address";
    }

    @RequestMapping(value="searchpoint.do")
    public String searchPoint(
    		 HttpServletRequest req
    		,@RequestParam("status") String status
            ,@RequestParam("idx") String idx
    		,Model model) throws Exception {
    	
//    	model.addAttribute("absPath", "/geocni/travel");
    	model.addAttribute("status", status);
    	model.addAttribute("idx", idx);
    	
    	return skinPath + "searchPoint";
    }
    
}
