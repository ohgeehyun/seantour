package geocni.travel.common.banfilter.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import geocni.travel.common.banfilter.domain.TravelBanFilters;
import geocni.travel.common.banfilter.service.TravelBanFilterService;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.mgov.module.JnitMgovUtil;

@Controller
@SessionAttributes(types=TravelBanFilters.class)
public class TravelBanFilterController {

	@Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;

    @Resource(name = "travelBanFilterService")
    private TravelBanFilterService banFilterService;
	
    @Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@SuppressWarnings("unused")
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	@Resource(name = "egovMessageSource")
	EgovMessageSource msgSrc;

	private Log log = LogFactory.getLog(getClass());
	
	@RequestMapping(value="/cms/travel/banfilter/list.do")
	public String routeList(
			 TravelBanFilters banFilters
            ,SessionStatus status
			,Model model) throws Exception {
		
		//banFilters.setPageUnit(propertiesService.getInt("pageUnit"));
		banFilters.setPageUnit(20);
		banFilters.setPageSize(propertiesService.getInt("pageSize"));
		
		model.addAllAttributes(banFilterService.selectTravelBanFilterListMap(banFilters));
		status.setComplete();
		
        model.addAttribute("banFilters", new TravelBanFilters());
		
		return "travel/banfilter/mng/list";
	}

    @RequestMapping(value="/cms/travel/banfilter/insert.do")
    public String insertTravelRoute(
    		 @RequestParam(value="wordList") String wordList 
            ,HttpServletRequest req
    		,Model model) throws Exception {
    	
    		try {
    			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
    			if(NullUtil.isEmpty(loginVO.getMbrId())) {
    				throw new NullPointerException();
    			}
    			TravelBanFilters filters = new TravelBanFilters();
    			filters.setBanWordList(wordList);

    			banFilterService.upsertTravelBanFilter(filters.getBanWordList());

    		} catch (NullPointerException e){
    			log.debug(e.getMessage());
			} catch (Exception e) {
				log.debug(e.getMessage());
			}
			
    		//return skinPath + "result";
    		return "redirect:/cms/travel/banfilter/list.do";
    }
    
    @RequestMapping(value="/cms/travel/banfilter/delete.do", method=RequestMethod.POST)
    public String deleteTravelRoute(
    		 @RequestParam(value="delWord") String delWord 
            ,HttpServletRequest req
    		,Model model) throws Exception {
    	
    		try {
    			
    			banFilterService.deleteTravelBanFilterPhysically(delWord);

			} catch (NullPointerException e) {
				log.debug(e.getMessage());
			} catch (SQLException e)
    		{
				log.debug(e.getMessage());
    		}
			
    		return "redirect:/cms/travel/banfilter/list.do";
    }
    

	@ResponseBody
	@RequestMapping(value="/travel/banfilter/validation.do", produces="application/text;charset=utf8")
	public String validateSentence(
			 @RequestParam(value="wordList") String wordList 
            ,HttpServletRequest req
			,Model model) throws Exception {
		
		try {

			int cnt = banFilterService.selectTravelBanFilterIncludeCnt(wordList);
			if(cnt == 0) {
//				return "valid";
				return Boolean.TRUE.toString();
			}
			
		} catch (NullPointerException e) {
			log.debug(e.getMessage());
		} catch(SQLException e) {
			log.debug(e.getMessage());
		}
		
		return Boolean.FALSE.toString();
	}
    
	/*@ResponseBody
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
				JSON.put("result", "이미 클립보드에 추가하셨습니다");

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
    	
    }*/
}
