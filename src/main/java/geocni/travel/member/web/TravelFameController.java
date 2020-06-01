package geocni.travel.member.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import geocni.travel.member.domain.TravelFamePoint;
import geocni.travel.member.service.TravelMemberService;
import jnit.cms.mbr.JnitcmsmbrService;

@Controller
@RequestMapping("/travel/fame/")
//@SessionAttributes(types=TravelFameController.class)
public class TravelFameController {

	@Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;

    @Resource(name = "travelMemberService")
    private TravelMemberService memberService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@SuppressWarnings("unused")
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	@Resource(name = "egovMessageSource")
	EgovMessageSource msgSrc;

	private String skinPath = "travel/fame/";
	
	@RequestMapping(value="ranking.do")
	public String rankingList(
			 HttpServletRequest request
			,@ModelAttribute("famePoint") TravelFamePoint famePoint
    		,HttpSession session
			,Model model) throws Exception{
		
		
		//CommonUtil.upsertTravelFamePoint();
		
		//명성 랭킹 목록
		famePoint.setPageUnit(propertiesService.getInt("pageUnit"));
		famePoint.setPageSize(propertiesService.getInt("pageSize"));
		model.addAllAttributes(memberService.selectTravelFamePointListMap(famePoint));
		
		return skinPath + "ranking";
	}	
	
}
