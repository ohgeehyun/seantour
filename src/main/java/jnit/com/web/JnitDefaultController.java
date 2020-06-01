/**
 * @version 3.2.0.1
 */
package jnit.com.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.com.service.JnitComService;
import net.sf.json.JSONObject;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;

/**
 * JNIT 기본 컨트롤러 클래스
 * @author JNIT
 * @since 2012.06.22
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2012.06.22  JNIT          최초 생성
 *
 * </pre>
 */

public class JnitDefaultController {
	protected final String ALERT = "msg";
	protected final String LOCATION_HREF = "locationHref"; //경고메세지 후 이동할 경로 
	protected final String LOCATION_REPLACE = "locationReplace";  //경고메세지 후 Replace시킬 경로
	protected final String LOCATION_BACK = "locationBack"; //경고메세지 후 뒤로가기.

	protected final String VIEW_COMMON_ALERT = "/jnit/gis/com/alert"; //기본 경고 페이지.
	protected final String VIEW_COMMON_ERROR = "/jnit/gis/com/error"; //기본 에러 페이지.
	
	@Resource(name="jnitComService")
	protected JnitComService jnitComService;

	/**
	 * 저장 완료 후 이동
	 * @param e
	 * @return
	 */
	protected String complete(ModelMap m,String msg, String retUrl){
		m.addAttribute(LOCATION_REPLACE, retUrl);
		m.addAttribute(ALERT, msg);
		return VIEW_COMMON_ALERT;
	}
	/**
	 * 기본 에러페이지(에러 발생시 전달)
	 * @param e
	 * @return
	 */
	protected String error(ModelMap m,Exception e){
		m.addAttribute("e", e);
		return VIEW_COMMON_ERROR;
	}/**
	 * 기본 경고 후 이동페이지(에러 발생시 전달)
	 * @param e
	 * @return
	 */
	protected String errorBack(ModelMap m,Exception e){
		m.addAttribute(LOCATION_BACK, "-1");
		m.addAttribute(ALERT, e.getMessage());
		return VIEW_COMMON_ALERT;
	}
	
	/**
	 * 로그인 정보 리턴.
	 * @return JnitcmsmbrVO
	 */
	protected JnitcmsmbrVO getLoginVO(HttpServletRequest request){
		return (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
	}
	/**
	 * 로그인한 아이디가져오기
	 * @return 아이디
	 */
	protected String getLoginId(HttpServletRequest request){
		String ret = "";
		JnitcmsmbrVO loginVO = getLoginVO(request);
		if(loginVO != null)ret = NullUtil.nullString(loginVO.getMbrId());
		//안가져와져서강제 셋팅
		//ret = "namdoad";
		return ret;
	}
	/**
	 * 로그인되었는지 체크
	 * @return true|false
	 */
	protected boolean isLoginned(HttpServletRequest request){
		boolean bl = false;
		if(!getLoginId(request).equals(""))bl = true;
		return bl;
	}
	
	/**
	 * 관리자인지 체크
	 * (아직 안만들어져서 강제 체크.)
	 * @return
	 */
	protected boolean isAdmin(HttpServletRequest request){
		boolean bl = false;
		JnitcmsmbrVO loginVO = getLoginVO(request);
		if(loginVO.getMbrId() != null) {
			bl = loginVO.getTypeVO().getTypeLv().equals("A");
		}
		return bl;
	}

	/**
	 * 비지니스 로직에러 발생(꽁통)
	 * @param msg
	 * @throws BizException
	 */
	protected void throwBizException(final String msgKey)throws EgovBizException{
		throwBizException(msgKey,null);
	}
	protected void throwBizException(final String msgKey,String[] args)throws EgovBizException{
		throw new EgovBizException(jnitComService.getMessage(msgKey,args));
	}


	/**
	 * json형태 View(성공,실패 응답)
	 * @param model
	 * @param isSuccess (true|false - 성공|실패)
	 * @param msg 메세지
	 * @return
	 */
	protected ModelAndView getResponseJsonView(ModelMap model,boolean isSuccess,String msg){
		JSONObject json = new JSONObject();
		
		json.put("isSuccess", isSuccess);
		json.put("msg", msg);
		
		model.addAttribute("json",json.toString());
		
		return new ModelAndView("jnit/util/json",model);
	}
}
