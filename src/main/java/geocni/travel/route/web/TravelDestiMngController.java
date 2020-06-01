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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.service.TravelDestinationService;
import geocni.travel.route.service.TravelRouteService;
import jnit.cms.AdminUtil;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.mgov.module.JnitMgovUtil;

@Controller
@SessionAttributes(types=TravelDestination.class)
@RequestMapping(value="/cms/travel/destination/")
public class TravelDestiMngController {

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

	private String skinPath = "/travel/destination/mng/";

	@RequestMapping(value="list.do")
	public String travelDestinationList(
			 @ModelAttribute("searchVO") TravelDefaultVO searchVO
			,TravelDestination travelDestination
            ,SessionStatus status
			,Model model) throws Exception {
		
		List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
		model.addAttribute("regionList", regionList);
		
		travelDestination.setPageUnit(propertiesService.getInt("pageUnit"));
		travelDestination.setPageSize(propertiesService.getInt("pageSize"));

		model.addAllAttributes(destService.selectTravelDestinationListMap(travelDestination));
		status.setComplete();

        model.addAttribute("travelDestination", travelDestination);
		
		return skinPath + "list";
	}

    @RequestMapping(value="register.do")
    public String registerTravelDestination(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
    		,TravelDestination travelDestination
            ,HttpServletRequest req
    		,ModelMap model) throws Exception {
    	
    	try{

    		String type = NullUtil.nullString(req.getParameter("type"));
	    	String grpId = NullUtil.nullString(req.getParameter("grpId"));

	    	//JSON
	    	model.addAllAttributes(AdminJSON(req, model));

			List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
			model.addAttribute("regionList", regionList);
			
	        model.addAttribute("travelDestination", travelDestination);

	        model.addAttribute("type", type);
	        model.addAttribute("grpId", grpId);

    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
    	
    	return skinPath + "register";
    }

    @RequestMapping(value="insert.do", method=RequestMethod.POST)
    public String insertTravelDestination(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
     		,@ModelAttribute("travelDestination") TravelDestination travelDestination
            ,BindingResult bindingResult
            ,SessionStatus status
            ,HttpServletRequest req
    		,Model model) throws Exception {
    	
		try {
			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			travelDestination.setDestWriter(loginVO.getMbrId());
			
			@SuppressWarnings("unused")
			String routId = destService.insertTravelDestination(travelDestination);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/cms/travel/destination/list.do";
    }

    @RequestMapping(value="modify.do")
    public String modifyTravelRoute(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
 			,TravelDestination travelDestination
            ,HttpServletRequest req
    		,ModelMap model) throws Exception {
    	
    	try{

    		String type = NullUtil.nullString(req.getParameter("type"));
	    	String grpId = NullUtil.nullString(req.getParameter("grpId"));

	    	//JSON
	    	model.addAllAttributes(AdminJSON(req, model));

			List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
			model.addAttribute("regionList", regionList);
			
			travelDestination = destService.selectTravelDestination(travelDestination);
	        model.addAttribute("travelDestination", travelDestination);

	        model.addAttribute("type", type);
	        model.addAttribute("grpId", grpId);

    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
    	
    	return skinPath + "register";
    }

    @RequestMapping(value="update.do", method=RequestMethod.POST)
    public String updateTravelRoute(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
      		,@ModelAttribute("travelDestination") TravelDestination travelDestination
            ,BindingResult bindingResult
            ,SessionStatus status
            ,HttpServletRequest req
    		,Model model) throws Exception {
    	
    		try {

    			destService.updateTravelDestination(travelDestination);

			} catch (Exception e) {
				e.printStackTrace();
			}
			
    		return "redirect:/cms/travel/destination/list.do";
    }
    
    @RequestMapping(value="delete.do", method=RequestMethod.POST)
    public String deleteTravelRoute(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
     		,TravelDestination travelDestination
            ,SessionStatus status
            ,HttpServletRequest req
    		,Model model) throws Exception {
    	
    		try {

    			destService.deleteTravelDestinationPhysically(travelDestination);

			} catch (Exception e) {
				e.printStackTrace();
			}
			
            status.setComplete();
    		return "redirect:/cms/travel/destination/list.do";
    }
    
	@ResponseBody
	@RequestMapping(value="retrieveDestinationList.do", produces="application/text;charset=utf8")
	public String retrieveDestinationList(
			 TravelDestination travelDestination
            ,HttpServletRequest req
			,Model model) throws Exception {
		
		travelDestination.setRecordCountPerPage(1000);
    	List<?> destList = destService.selectTravelDestinationList(travelDestination);

		ObjectMapper mapper = new ObjectMapper();
		String dest = mapper.writeValueAsString(destList);
		return dest;
		
	}
    
	@ResponseBody
	@RequestMapping(value="retrieveDestinationDetail.do", produces="application/text;charset=utf8")
	//public Map<String,Object> retrieveDestinationDetail(
	public String retrieveDestinationDetail(
			TravelDestination travelDestination
			,HttpServletRequest req
			,Model model) throws Exception {
		
		//Map<String,Object> rtMap = new HashMap<String, Object>();
		/*TravelDestination detail = destinationService.selectTravelDestination(travelDestination);
		rtMap.put("detail", detail);
    	return rtMap;*/
		
		TravelDestination detail = destService.selectTravelDestination(travelDestination);
		ObjectMapper mapper = new ObjectMapper();
		String dest = mapper.writeValueAsString(detail);
		return dest;
		
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
