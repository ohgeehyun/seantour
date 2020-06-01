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
import org.springframework.web.bind.annotation.SessionAttributes;
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
import jnit.cms.AdminUtil;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.mgov.module.JnitMgovUtil;

@Controller
@SessionAttributes(types=TravelRoute.class)
@RequestMapping(value="/cms/travel/route/")
public class TravelRouteMngController {

	private Log log = LogFactory.getLog(getClass());
	
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

	private String skinPath = "/travel/route/mng/";

	@RequestMapping(value="list.do")
	public String routeList(
			 @ModelAttribute("searchVO") TravelDefaultVO searchVO
			,TravelRoute travelRoute
			,TravelDestination travelDestination
            ,SessionStatus status
			,Model model) throws Exception {
		
		List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
		model.addAttribute("regionList", regionList);
		
		travelRoute.setPageUnit(propertiesService.getInt("pageUnit"));
		travelRoute.setPageSize(propertiesService.getInt("pageSize"));
		travelRoute.setAdminMode(true);
		
		model.addAllAttributes(routeService.selectTravelRouteListMap(travelRoute));
		status.setComplete();
		
        model.addAttribute("travelRoute", travelRoute);
		
		return skinPath + "list";
	}

    @RequestMapping(value="register.do")
    public String registerTravelRoute(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
 			,TravelDestination travelDestination
            ,HttpServletRequest req
    		,ModelMap model) throws Exception {
    	
    	try{

    		String type = NullUtil.nullString(req.getParameter("type"));
	    	String grpId = NullUtil.nullString(req.getParameter("grpId"));

	    	//JSON
	    	model.addAllAttributes(AdminJSON(req, model));

			List<?> groupList = routeService.selectTravelRouteGroupList();
			model.addAttribute("groupList", groupList);
	    	
			List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
			model.addAttribute("regionList", regionList);
			
	    	travelDestination.setDestRegion("강원");
	    	travelDestination.setDestCategory("관광지");
	    	travelDestination.setRecordCountPerPage(1000);
	    	List<?> destList = destService.selectTravelDestinationList(travelDestination);
			model.addAttribute("destList", destList);
	    	
	        model.addAttribute("travelRoute", new TravelRoute());

	        model.addAttribute("type", type);
	        model.addAttribute("grpId", grpId);

    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
    	
		/*
		List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
		model.addAttribute("regionList", regionList);
    	
    	travelDestination.setDestRegion("강원");
    	travelDestination.setDestCategory("관광지");
    	List<?> destList = destService.selectTravelDestinationList(travelDestination);
		model.addAttribute("destList", destList);
    	
    	model.addAttribute("thumbPath", "https://www.seantour.com");
    	model.addAttribute("absPath", "/geocni/travel");
    	*/

    	return skinPath + "register";
    }

    @RequestMapping(value="insert.do")
    public String insertTravelRoute(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
     		,@ModelAttribute("travelRoute") TravelRoute travelRoute
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
			
    		//return skinPath + "result";
    		return "redirect:/cms/travel/route/list.do";
    }
    
    @RequestMapping(value="modify.do")
    public String modifyTravelRoute(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
 			,TravelDestination travelDestination
 			,TravelRoute travelRoute
            ,HttpServletRequest req
    		,ModelMap model) throws Exception {
    	
    	try{

    		String type = NullUtil.nullString(req.getParameter("type"));
	    	String grpId = NullUtil.nullString(req.getParameter("grpId"));

	    	//JSON
	    	model.addAllAttributes(AdminJSON(req, model));

			List<?> groupList = routeService.selectTravelRouteGroupList();
			model.addAttribute("groupList", groupList);
	    	
			List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
			model.addAttribute("regionList", regionList);
			
	    	travelDestination.setDestRegion("강원");
	    	travelDestination.setDestCategory("관광지");
	    	travelDestination.setRecordCountPerPage(1000);
	    	List<?> destList = destService.selectTravelDestinationList(travelDestination);
			model.addAttribute("destList", destList);
	    	
			travelRoute = routeService.selectTravelRoute(travelRoute);
	        model.addAttribute("travelRoute", travelRoute);

	        model.addAttribute("type", type);
	        model.addAttribute("grpId", grpId);

    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
    	
    	return skinPath + "register";
    }

    @RequestMapping(value="update.do")
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
			
    		return "redirect:/cms/travel/route/list.do";
    }
    
    @RequestMapping(value="delete.do", method=RequestMethod.POST)
    public String deleteTravelRoute(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
     		,TravelRoute travelRoute
            ,SessionStatus status
            ,HttpServletRequest req
    		,Model model) throws Exception {
    	
    		try {

				routeService.deleteTravelRoutePhysically(travelRoute);

			} catch (Exception e) {
				e.printStackTrace();
			}
			
            status.setComplete();
    		return "redirect:/cms/travel/route/list.do";
    }
    
    /*@RequestMapping(value="address.do")
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
    }*/

    @RequestMapping(value="searchPoi.do")
    public String searchPOI(
    		TravelRoute travelRoute
    		,HttpServletRequest req
    		,@RequestParam("status") String status
    		,Model model) throws Exception {
    	
    	model.addAttribute("absPath", "/geocni/travel");
    	model.addAttribute("status", status);
    	
    	return skinPath + "searchPoi";
    }
    
    
    /**
     * AdminUtil을 제어한다.
     * @param request
     * @param model
     * @return model
     * @throws Exception
     */
    public static ModelMap AdminJSON(HttpServletRequest request, ModelMap model)throws Exception{
    	String type = NullUtil.nullString(request.getParameter("type"));
    	if(type.equals("banner")){
    		AdminUtil.setMenuId("m06020100");
    	}else if(type.equals("allim")){
    		AdminUtil.setMenuId("m06030100");
    	}else if(type.equals("popup")){
    		AdminUtil.setMenuId("m06040100");
    	}
    	return model;
    }

}
