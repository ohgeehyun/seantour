/**
 * @version 3.2.0.1
 */
package jnit.board;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;

public class BoardSession {
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
	
	public static void initBoardSession(){
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String jsessionId = NullUtil.nullString(request.getSession().getId());
		request.getSession().setAttribute(jsessionId+"BoardSession", null);
		
	}
	
	public static void setBoardSession(){
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();

		String jsessionId = NullUtil.nullString(request.getSession().getId());
		String boardId = NullUtil.nullString(request.getParameter("boardId"));
		String useSkeleton = NullUtil.nullString(request.getParameter("useSkeleton"));
		String fixedCategory = NullUtil.nullString(request.getParameter("fixedCategory"));
		String customSkin = NullUtil.nullString(request.getParameter("customSkin"));
		String customCss = NullUtil.nullString(request.getParameter("customCss"));
		
		JnitBoardSessionVO boardSessionVO = new JnitBoardSessionVO();
		boardSessionVO.setBoardId(boardId);
		boardSessionVO.setUseSkeleton(useSkeleton);
		boardSessionVO.setFixedCategory(fixedCategory);
		boardSessionVO.setCustomSkin(customSkin);
		boardSessionVO.setCustomCss(customCss);
		
		request.getSession().setAttribute(jsessionId+"BoardSession", boardSessionVO);
		
	}
	
	public static JnitBoardSessionVO getBoardSession(HttpServletRequest request){
		
		String jsessionId = NullUtil.nullString(request.getSession().getId());
		JnitBoardSessionVO resultVO = (JnitBoardSessionVO)request.getSession().getAttribute(jsessionId+"BoardSession");
		
		if(resultVO == null){
			if("true".equals(deDug)) System.out.println("BoardSession Not Data");
		}
		
		return resultVO;
		
	}

}
