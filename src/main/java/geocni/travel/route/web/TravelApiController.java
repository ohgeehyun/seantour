package geocni.travel.route.web;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import geocni.api.geo_destination;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.service.TravelApiService;
import geocni.travel.route.service.TravelReservationService;

@Controller
@RequestMapping(value = "/travel/api/")
public class TravelApiController {
	
	@SuppressWarnings("unused")
	@Autowired
	private DefaultBeanValidator beanValidator;

	
	@Resource(name = "travelApiService")
	private TravelApiService ApiService;

	@SuppressWarnings("unused")

	private Log log = LogFactory.getLog(getClass());
	
	private String skinPath = "travel/Api/";
	
	@RequestMapping(value="getdestination.do")
	@ResponseBody
	public JSONObject destinationApi() throws Exception{
	
		List<?> api = (List<?>) ApiService.selectTravelDestinationApi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("number"+ i , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="getroute.do")
	@ResponseBody
	public JSONObject routeApi() throws Exception{
	
		List<?> api = (List<?>) ApiService.selectTravelrouteApi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("number"+ i , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="getroutedaily.do")
	@ResponseBody
	public JSONObject routedailyApi() throws Exception{
	
		List<?> api = (List<?>) ApiService.selectTravelroutedailyApi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("number"+ i , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="getareacode.do")
	@ResponseBody
	public JSONObject areacodeApi() throws Exception{
	
		List<?> api = (List<?>) ApiService.selectTravelareacodeApi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("number"+ i , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="getcontent.do")
	@ResponseBody
	public JSONObject content() throws Exception{
	
		List<?> api = (List<?>) ApiService.selectTravelcontentApi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("number"+ i , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="getbanfilters.do")
	@ResponseBody
	public JSONObject banfilters() throws Exception{
	
		List<?> api = (List<?>) ApiService.selectTravelbanfiltersApi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("number"+ i , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="getfamehistory.do")
	@ResponseBody
	public JSONObject famehistory() throws Exception{
	
		List<?> api = (List<?>) ApiService.selectTravelfamehistoryApi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("number"+ i , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="getfamepoint.do")
	@ResponseBody
	public JSONObject famepoint() throws Exception{
	
		List<?> api = (List<?>) ApiService.selectTravelfamepointApi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("number"+ i , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="getimgfiles.do")
	@ResponseBody
	public JSONObject imgfiles() throws Exception{
	
		List<?> api = (List<?>) ApiService.selectTravelimgfilesApi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("number"+ i , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="getreaction.do")
	@ResponseBody
	public JSONObject reaction() throws Exception{
	
		List<?> api = (List<?>) ApiService.selectTravelreactionApi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("number"+ i , api.get(i));
		}
			
		return sObject;
	}

}
