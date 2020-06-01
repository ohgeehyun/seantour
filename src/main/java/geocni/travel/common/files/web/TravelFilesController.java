package geocni.travel.common.files.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import geocni.travel.common.files.service.TravelFilesService;
import geocni.travel.member.domain.TravelClipboard;
import geocni.travel.member.domain.TravelFameHistory;
import geocni.travel.member.domain.TravelFamePoint;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.domain.TravelRoute;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.mgov.module.JnitMgovUtil;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/travel/files/")
//@SessionAttributes(types=TravelMember.class)
public class TravelFilesController {

	@Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;

    @Resource(name = "travelFilesService")
    private TravelFilesService travelFilesService;
	
    @Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@SuppressWarnings("unused")
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	@Resource(name = "egovMessageSource")
	EgovMessageSource msgSrc;

	private Log log = LogFactory.getLog(getClass());
	
	/*@ResponseBody
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
