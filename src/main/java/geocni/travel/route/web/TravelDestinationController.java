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
import egovframework.rte.fdl.property.EgovPropertyService;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.service.TravelDestinationService;

@Controller
@SessionAttributes(types=TravelDestination.class)
@RequestMapping(value="/travel/destination/")
public class TravelDestinationController {

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
	
	private String skinPath = "/travel/destination/";

	@RequestMapping(value="list.do")
	public String destinationList(
			 @ModelAttribute("searchVO") TravelDefaultVO searchVO
			,TravelDestination travelDestination
            ,SessionStatus status
			,Model model) throws Exception {
		
		List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
		model.addAttribute("regionList", regionList);
		
		//travelDestination.setPageUnit(propertiesService.getInt("pageUnit"));
		travelDestination.setPageUnit(8);
		travelDestination.setPageSize(propertiesService.getInt("pageSize"));

		model.addAllAttributes(destService.selectTravelDestinationListMap(travelDestination));
		status.setComplete();
		
        model.addAttribute("travelDestination", travelDestination);
		
		return skinPath + "list";
	}

    @RequestMapping(value="detail.do")
    public String destinationDetail(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
 			,TravelDestination travelDestination
            ,HttpServletRequest req
    		,ModelMap model) throws Exception {
    	
    	try{

			travelDestination = destService.selectTravelDestination(travelDestination);
	        model.addAttribute("travelDestination", travelDestination);

    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
    	
    	return skinPath + "detail";
    }

    @RequestMapping(value="register.do")
    public String registerMemberInfo(
    		 TravelDestination travelDestination
            ,HttpServletRequest req
            ,SessionStatus status
    		,Model model) throws Exception {
    	
    	model.addAttribute("absPath", "/geocni/travel");

    	return skinPath + "register";
    }

    @RequestMapping(value="insert.do", method=RequestMethod.POST)
    public String insertApplication(
    		 @ModelAttribute("travelDestination") TravelDestination travelDestination
            ,BindingResult bindingResult
            ,SessionStatus status
            ,HttpServletRequest req
    		,Model model) throws Exception {
    	
    		try {
    			
    			@SuppressWarnings("unused")
				String routId = destService.insertTravelDestination(travelDestination);

			} catch (Exception e) {
				e.printStackTrace();
			}

    		return skinPath + "result";
    }

	@ResponseBody
	@RequestMapping(value="retrieveDestinationList.do", produces="application/text;charset=utf8")
	public String retrieveDestinationList(
			 TravelDestination travelDestination
            ,HttpServletRequest req
			,Model model) throws Exception {
		
		travelDestination.setRecordCountPerPage(100);
    	List<?> destList = destService.selectTravelDestinationList(travelDestination);

		//com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
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
	
}
