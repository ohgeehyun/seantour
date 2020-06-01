package geocni.travel.route.web;

import java.util.List;

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
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
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
    
    @Resource(name="travelRouteGroupIdGnrService")    
    private EgovIdGnrService routeGroupIdGnrService;
    
    @SuppressWarnings("unused")
	@Autowired
    private DefaultBeanValidator beanValidator;

	private Log log = LogFactory.getLog(getClass());
	
	private String skinPath = "/travel/route/";

	@RequestMapping(value="list.do")
	public String routeList(
			 TravelRoute travelRoute
            ,SessionStatus status
			,Model model) throws Exception {
		
		travelRoute.setPageUnit(propertiesService.getInt("pageUnit"));
		travelRoute.setPageSize(propertiesService.getInt("pageSize"));

		model.addAllAttributes(routeService.selectTravelRouteListMap(travelRoute));
		status.setComplete();
		
        model.addAttribute("travelRoute", travelRoute);
		
		return skinPath + "list";
	}

    @RequestMapping(value="detail.do")
    public String destinationDetail(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
  			,TravelRoute travelRoute
            ,HttpServletRequest req
    		,ModelMap model) throws Exception {
    	
    	try{

			/*travelRoute = routeService.selectTravelRoute(travelRoute);
			if(!NullUtil.isEmpty(travelRoute.getRoutDescription())) {
		    	TravelDestination destination = new TravelDestination();
				String[] descList = travelRoute.getRoutDescription().split("[|]");
				
				List<TravelDestination> lst = new ArrayList<TravelDestination>();
				for(int i=0;descList.length > i ;i++){
					destination.setDestId(descList[i]);
					destination = destService.selectTravelDestination(destination);
					lst.add(destination);
				}
				travelRoute.setRoutePointList(lst);
			}
			model.addAttribute("travelRoute", travelRoute);*/

    		travelRoute.setPageUnit(1000);
    		travelRoute.setPageSize(propertiesService.getInt("pageSize"));

    		model.addAllAttributes(routeService.selectTravelRouteListMap(travelRoute));

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
    	
    	try{
	
			List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
			model.addAttribute("regionList", regionList);
	    	
	    	travelDestination.setDestRegion("강원");
	    	travelDestination.setDestCategory("관광지");
	    	List<?> destList = destService.selectTravelDestinationList(travelDestination);
			model.addAttribute("destList", destList);
	    	
			String groupId = routeGroupIdGnrService.getNextStringId();
			model.addAttribute("groupId", groupId);
			
	    	model.addAttribute("thumbPath", "https://www.seantour.com");
	    	model.addAttribute("absPath", "/geocni/travel");
	
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
    	return skinPath + "register";
    }

    @RequestMapping(value="insert.do", method=RequestMethod.POST)
    public String insertApplication(
    		 @ModelAttribute("travelRoute") TravelRoute travelRoute
            ,BindingResult bindingResult
            ,SessionStatus status
            ,HttpServletRequest req
    		,Model model) throws Exception {
    	
		try {
			
			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			travelRoute.setRoutRegMember(loginVO.getMbrId());
			
			routeService.insertTravelRoute(travelRoute);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/cms/travel/route/list.do";
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
			//TODO: 임시
			if(NullUtil.isEmpty(loginVO.getMbrId())) {
				travelRoute.setRoutRegMember("MBR_0000000001");
			}
			
			travelRoute = routeService.insertTravelRoute(travelRoute);

			JSON.put("status", "success");
			JSON.put("routGroup", travelRoute.getRoutGroup());
			JSON.put("routId", travelRoute.getRoutId());
			JSON.put("days", travelRoute.getRoutDays());
			JSON.put("title", travelRoute.getRoutTitle());
			JSON.put("description", travelRoute.getRoutDescription());
		
		} catch (NullPointerException e){
			JSON.put("status", "error");
		} catch (Exception e) {
			JSON.put("status", "error");
		}

		//return "";
		return JSON.toString();
    	
    }
    
    @RequestMapping(value="modify.do")
    public String modifyTravelRoute(
    		 @ModelAttribute("travelRoute") TravelRoute travelRoute
 			,TravelDestination travelDestination
            ,HttpServletRequest req
    		,ModelMap model) throws Exception {
    	
    	try{

    		List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
    		model.addAttribute("regionList", regionList);
        	
        	travelDestination.setDestRegion("강원");
        	travelDestination.setDestCategory("관광지");
        	List<?> destList = destService.selectTravelDestinationList(travelDestination);
    		model.addAttribute("destList", destList);
        	
        	
        	model.addAttribute("thumbPath", "https://www.seantour.com");
        	model.addAttribute("absPath", "/geocni/travel");
	    	
//			travelRoute = routeService.selectTravelRoute(travelRoute);
        	@SuppressWarnings("unchecked")
			List<TravelRoute> routeList = (List<TravelRoute>) routeService.selectTravelRouteList(travelRoute);
	        model.addAttribute("routeList", routeList);

    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
    	
    	return skinPath + "register";
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
			//TODO: 임시
			if(NullUtil.isEmpty(loginVO.getMbrId())) {
				travelRoute.setRoutRegMember("MBR_0000000002");
			}
			
			if(NullUtil.isEmpty(travelRoute.getRoutId()) || NullUtil.isEmpty(travelRoute.getRoutGroup())) {
				throw new NullPointerException();
			}
			
//			routeService.insertTravelRoute(travelRoute);
			routeService.updateTravelRoute(travelRoute);

			JSON.put("status", "success");
			JSON.put("routGroup", travelRoute.getRoutGroup());
			JSON.put("routId", travelRoute.getRoutId());
			JSON.put("days", travelRoute.getRoutDays());
			JSON.put("title", travelRoute.getRoutTitle());
			JSON.put("description", travelRoute.getRoutDescription());
		
		} catch (NullPointerException e){
			JSON.put("status", "error - There is no routId or routGroup");
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
    			if(NullUtil.isEmpty(travelRoute.getRoutGroup())) {
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
    	
    	model.addAttribute("absPath", "/geocni/travel");
    	model.addAttribute("status", status);
    	model.addAttribute("idx", idx);

    	return skinPath + "address";
    }

    
    
}
