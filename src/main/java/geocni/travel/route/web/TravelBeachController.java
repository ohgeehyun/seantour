package geocni.travel.route.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.com.cmm.LoginVO;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.domain.TravelMain;

@Controller
@SessionAttributes(types=TravelMain.class)
@RequestMapping(value="/travel/beach/")
public class TravelBeachController {
	
	private String skinPath = "travel/beach/";	
	
	@RequestMapping(value = "busan.do")
	public String busanlist(LoginVO loginVO,@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status,
			@RequestParam(value = "excelPageno", required = false, defaultValue = "1") String excelPageno, Model model)throws Exception {
		
		
		
		return skinPath + "busan";
	}
	
	@RequestMapping(value = "gangwon.do")
	public String gangwonlist(LoginVO loginVO,@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status,
			@RequestParam(value = "excelPageno", required = false, defaultValue = "1") String excelPageno, Model model)throws Exception {
		
		
		
		return skinPath + "gangwon";
	}
	
	@RequestMapping(value = "gyeongnam.do")
	public String gyeongnamlist(LoginVO loginVO,@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status,
			@RequestParam(value = "excelPageno", required = false, defaultValue = "1") String excelPageno, Model model)throws Exception {
		
		
		
		return skinPath + "gyeongnam";
	}
	
	@RequestMapping(value = "gyeongbuk.do")
	public String gyeongbuklist(LoginVO loginVO,@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status,
			@RequestParam(value = "excelPageno", required = false, defaultValue = "1") String excelPageno, Model model)throws Exception {
		
		
		
		return skinPath + "gyeongbuk";
	}
	
	@RequestMapping(value = "ulsan.do")
	public String ulsanlist(LoginVO loginVO,@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status,
			@RequestParam(value = "excelPageno", required = false, defaultValue = "1") String excelPageno, Model model)throws Exception {
		
		
		
		return skinPath + "ulsan";
	}
	
	@RequestMapping(value = "incheon.do")
	public String incheonlist(LoginVO loginVO,@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status,
			@RequestParam(value = "excelPageno", required = false, defaultValue = "1") String excelPageno, Model model)throws Exception {
		
		
		
		return skinPath + "incheon";
	}
	
	@RequestMapping(value = "jeonnam.do")
	public String jeonnamlist(LoginVO loginVO,@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status,
			@RequestParam(value = "excelPageno", required = false, defaultValue = "1") String excelPageno, Model model)throws Exception {
		
		
		
		return skinPath + "jeonnam";
	}
	
	@RequestMapping(value = "jeonbuk.do")
	public String jeonbuklist(LoginVO loginVO,@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status,
			@RequestParam(value = "excelPageno", required = false, defaultValue = "1") String excelPageno, Model model)throws Exception {
		
		
		
		return skinPath + "jeonbuk";
	}
	
	@RequestMapping(value = "jeju.do")
	public String jejulist(LoginVO loginVO,@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status,
			@RequestParam(value = "excelPageno", required = false, defaultValue = "1") String excelPageno, Model model)throws Exception {
		
		
		
		return skinPath + "jeju";
	}
	
	@RequestMapping(value = "chungnam.do")
	public String chungnamlist(LoginVO loginVO,@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status,
			@RequestParam(value = "excelPageno", required = false, defaultValue = "1") String excelPageno, Model model)throws Exception {
		
		
		
		return skinPath + "chungnam";
	}
	
	
	
	

}
