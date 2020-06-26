package geocni.travel.route.web;

import java.util.List;
import java.sql.SQLException;
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
//@SessionAttributes(types=TravelRoute.class)
@RequestMapping(value="/travel/reservation")
public class TravelReservationController {

	@SuppressWarnings("unused")
		@Autowired
	    private DefaultBeanValidator beanValidator;

		private Log log = LogFactory.getLog(getClass());
		
		private String skinPath = "travel/reservation/";
		
		
		@RequestMapping(value="area.do")
		public String reservationArea(
				 TravelRoute travelRoute
				,SessionStatus status
				,Model model) throws Exception {
			
		
			
			return skinPath + "area";
		}
		
		
		@RequestMapping(value="reserv_view.do")
		public String reservationView(
				 TravelRoute travelRoute
				,SessionStatus status
				,Model model) throws Exception {
			
		
			
			return skinPath + "reserv_view";
		}
		
		@RequestMapping(value="reserv_write.do")
		public String reservationWrite(
				 TravelRoute travelRoute
				,SessionStatus status
				,Model model) throws Exception {
			
		
			
			return skinPath + "reserv_write";
		}
		
		@RequestMapping(value="example.do")
		public String reservationexample(
				Model model) throws Exception {
			
		
			
			return skinPath + "example";
		}
		
		@RequestMapping(value="intro.do")
		public String reservationintro(
				Model model) throws Exception {
			
		
			
			return skinPath + "intro";
		}

}

