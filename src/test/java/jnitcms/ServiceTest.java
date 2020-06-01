package jnitcms;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import geocni.travel.member.service.TravelMemberService;
import geocni.utils.CommonUtil;

public class ServiceTest {

	public static void main(String[] args) {

		/*HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
		JnitloginlogService jnitloginlogService  = (JnitloginlogService) wContext.getBean("jnitloginlogService");*/

		
        /*
         * getBean 예제
         * 
        //현재 요청중인 thread local의 HttpServletRequest 객체 가져오기
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        
        //HttpSession 객체 가져오기
        HttpSession session = request.getSession();
        
        //ServletContext 객체 가져오기
        ServletContext conext = session.getServletContext();
        
        //Spring Context 가져오기
        WebApplicationContext act = WebApplicationContextUtils.getWebApplicationContext(conext);
        
        //가져다 쓰기
        TravelMemberService memberService = (TravelMemberService) act.getBean("travelMemberService");
        */
		
		CommonUtil.upsertTravelFamePoint();

	}

}
