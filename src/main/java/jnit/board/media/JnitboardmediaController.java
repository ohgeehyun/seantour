package jnit.board.media;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ibm.icu.util.Calendar;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : JnitboardmediaController.java
 * @Description : Jnitboardmedia Controller class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.01.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitboardmediaVO.class)
public class JnitboardmediaController {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "JnitboardmediaService")
    private JnitboardmediaService JnitboardmediaService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

	/** 첨부파일 위치 지정 */
    private final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    public static final String debug = EgovProperties.getProperty("Globals.Debug");
    
    /** 첨부 최대 파일 크기 지정 */
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    
    public static final String SEPERATOR = File.separator;

    @RequestMapping("/board/media/addMedia.do")
    public String ajaxAddMedia(Model model,HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	try {
			Calendar cal = Calendar.getInstance();
			String dstNm = String.valueOf(cal.getTimeInMillis());
	        JnitboardmediaVO jnitboardmediaVO = new JnitboardmediaVO();
	        jnitboardmediaVO.setOrgNm(NullUtil.nullString(request.getParameter("orgNm")));
	        jnitboardmediaVO.setDstNm(dstNm);
	        jnitboardmediaVO.setJnitmediaId(Integer.valueOf(JnitboardmediaService.insertJnitboardmedia(jnitboardmediaVO)));
    	            
	        JSONObject jo = new JSONObject();
	        jo.put("jnitmediaId", jnitboardmediaVO.getJnitmediaId());
	        jo.put("orgNm", jnitboardmediaVO.getOrgNm());
	        jo.put("dstNm", jnitboardmediaVO.getDstNm());
	        model.addAttribute("json",jo.toJSONString());
    	} catch (IllegalArgumentException e){
			log.error(e.getMessage());
    	}catch(Exception e) {
    		log.error(e.getMessage());
    		//
    	}    	

        //resultJson
        return "/jnit/util/json";
    }
}
