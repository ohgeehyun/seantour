/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.property.EgovPropertyService;
import jnit.cms.config.ConfigUtil;
import jnit.cms.handler.CmsHandler;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplDefaultVO;
import jnit.cms.tpl.JnitcmstplService;
import jnit.cms.tpl.JnitcmstplVO;
import jnit.cms.tpl.tplUtil;
import jnit.util.PathUtil;

//템플릿관리 > 메인템플릿

@Controller
@SessionAttributes(types=JnitcmstplVO.class)
public class CmsManageSub4_4Controller {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitcmstplService")
    private JnitcmstplService jnitcmstplService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name="jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;
    
    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;
        
    @RequestMapping("/cms/sub4/0104view.do")
    public @ModelAttribute("jnitcmstplVO")
    JnitcmstplVO selectJnitcmstpl(
            JnitcmstplVO jnitcmstplVO,
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO) throws Exception {
		
        return jnitcmstplService.selectJnitcmstpl(jnitcmstplVO);
    }
    
    @RequestMapping(value="/cms/sub4/0104.do")
    public String updateJnitcmstplView(
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO,
            HttpServletRequest request,
            ModelMap model)
            throws Exception {
    	
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub4_msg-nosite";
		}
		String tplType = NullUtil.nullString(request.getParameter("tplType"));
		//JSON
		model.addAllAttributes(AdminJson(request, model));
		
		String root = PathUtil.getRealPath(request);
		String siteId = CmsHelper.getSessionSiteId(request);
		JnitcmssiteVO siteVO = new JnitcmssiteVO();
		siteVO.setSiteId(siteId);
		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
		
		//sub TPL list
		JnitcmstplVO selectcmstplVO = new JnitcmstplVO();
		selectcmstplVO.setSiteId(siteId);
		selectcmstplVO.setTplType(tplType);
		JnitcmstplVO tplDescVO = null;
		try {
			tplDescVO = jnitcmstplService.selectJnitcmstpltype(selectcmstplVO);
		} catch (EgovBizException e) {
			log.error(e.getMessage());
			String mbrTplDir = root + "/default/mbr/_tpl";
			JnitcmstplVO tplVO = new JnitcmstplVO();
			tplVO.setSiteId(siteId);
			tplVO.setTplType("B");
			tplVO.setSelectCondition("2");
			try {
				tplVO = jnitcmstplService.selectJnitcmstpl(tplVO);
			} catch (NullPointerException e2){
				log.error(e2.getMessage());
			} catch (Exception e2) {
				log.error(e2.getMessage());
			}			
			if("K".equals(tplType)){
				tplDescVO = tplUtil.makeTplVO(request, tplVO, siteVO, mbrTplDir+"/sign.jsp", tplVO.getTplId(),"K", "회원양식절차");
			}else if("D".equals(tplType)){
				tplDescVO = tplUtil.makeTplVO(request, tplVO, siteVO, mbrTplDir+"/signup.jsp", tplVO.getTplId(), "D", "회원약관동의");
			}else if("E".equals(tplType)){
				tplDescVO = tplUtil.makeTplVO(request, tplVO, siteVO, mbrTplDir+"/signupAdd.jsp", tplVO.getTplId(), "E", "회원가입항목입력");
			}else if("F".equals(tplType)){
				tplDescVO = tplUtil.makeTplVO(request, tplVO, siteVO, mbrTplDir+"/signupSuccess.jsp", tplVO.getTplId(), "F", "회원가입완료");
			}else if("G".equals(tplType)){
				tplDescVO = tplUtil.makeTplVO(request, tplVO, siteVO, mbrTplDir+"/myPage.jsp", tplVO.getTplId(), "G", "마이페이지");
			}else if("H".equals(tplType)){
				tplDescVO = tplUtil.makeTplVO(request, tplVO, siteVO, mbrTplDir+"/memberCancel.jsp", tplVO.getTplId(), "H", "회원탈퇴");
			}else if("I".equals(tplType)){
				tplDescVO = tplUtil.makeTplVO(request, tplVO, siteVO, mbrTplDir+"/idFind.jsp", tplVO.getTplId(), "I", "아이디찾기");
			}else if("J".equals(tplType)){
				tplDescVO = tplUtil.makeTplVO(request, tplVO, siteVO, mbrTplDir+"/pwFind.jsp", tplVO.getTplId(), "J", "패스워드찾기");
			}else if("M".equals(tplType)){
				tplDescVO = tplUtil.makeTplVO(request, tplVO, siteVO, mbrTplDir+"/noSetpIdFind.jsp", tplVO.getTplId(), "M", "아이디 찾기");
			}else if("N".equals(tplType)){
				tplDescVO = tplUtil.makeTplVO(request, tplVO, siteVO, mbrTplDir+"/noSetpPwFind.jsp", tplVO.getTplId(),"N", "패스워드찾기");
			}else if("C".equals(tplType)){
				tplDescVO = tplUtil.makeTplVO(request, tplVO, siteVO, root + "/default/login.jsp", tplVO.getTplId(),"C", "로그인템플릿");
			}else if("M1".equals(tplType)){
				tplDescVO = tplUtil.makeTplVO(request, tplVO, siteVO, mbrTplDir+"/noSetpIdResult.jsp", tplVO.getTplId(), "M1", "아이디 찾기 결과"); // 비인증 아이디 찾기
			}else if("N1".equals(tplType)){
				tplDescVO = tplUtil.makeTplVO(request, tplVO, siteVO, mbrTplDir+"/noSetpPwResult.jsp", tplVO.getTplId(), "N1", "패스워드 찾기 결과"); // 비인증 패스워드 찾기
			}			
		}		
		String tplDesc = NullUtil.nullString(tplDescVO.getTplDesc());
		if(tplDesc.equals("") == false){
			model.addAttribute("tplDesc", tplDesc);
		}
		searchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		searchVO.setTplType("B");
		searchVO.setPageYn("N");
		List subTplList = jnitcmstplService.selectJnitcmstplList(searchVO);
		model.addAttribute("subTplList", subTplList);
		//end sub TPL list
		
		//jnitcmstpl
		searchVO.setSiteId( CmsHelper.getSessionSiteId(request) );
		searchVO.setTplType(tplType);	
		searchVO.setSitePath( siteVO.getSitePath() );
		
		JnitcmstplVO jnitcmstplVO = selectJnitcmstpltype(searchVO);		
		
		// TPL File 저장
        String tplDir = root + siteVO.getSitePath()+"/mbr";
        String tplFile = "";
        String tplTypePath = "";
        if(tplType.equals("D")){
        	tplFile = tplDir + "/signup.jsp";
        	tplTypePath = "/mbr/signup.jsp";
        }else if(tplType.equals("E")){
        	tplFile = tplDir + "/signupAdd.jsp";
        	tplTypePath = "/mbr/signupAdd.jsp";
        }else if(tplType.equals("F")){
        	tplFile = tplDir + "/signupSuccess.jsp";
        	tplTypePath = "/mbr/signupSuccess.jsp";
        }else if(tplType.equals("G")){
        	tplFile = tplDir + "/myPage.jsp";
        	tplTypePath = "/mbr/myPage.jsp";
        }else if(tplType.equals("H")){
        	tplFile = tplDir + "/memberCancel.jsp";
        	tplTypePath = "/mbr/memberCancel.jsp";
        }else if(tplType.equals("K")){
        	tplFile = tplDir + "/sign.jsp";
        	tplTypePath = "/mbr/sign.jsp";
        }else if(tplType.equals("C")){
        	tplFile = root + siteVO.getSitePath() + "/login.jsp";
        	tplTypePath = "/login.jsp";
        }else if(tplType.equals("I")){
        	tplFile = tplDir + "/idFind.jsp";
        	tplTypePath = "/mbr/idFind.jsp";
        }else if(tplType.equals("J")){
        	tplFile = tplDir + "/pwFind.jsp";
        	tplTypePath = "/mbr/pwFind.jsp";
        }else if(tplType.equals("M")){
        	tplFile = tplDir + "/noSetpIdFind.jsp";
        	tplTypePath = "/mbr/noSetpIdFind.jsp";
        }else if(tplType.equals("N")){
        	tplFile = tplDir + "/noSetpPwFind.jsp";
        	tplTypePath = "/mbr/noSetpPwFind.jsp";
        }else if(tplType.equals("M1")){
        	tplFile = tplDir + "/noSetpIdResult.jsp";
        	tplTypePath = "/mbr/noSetpIdResult.jsp";
        }else if(tplType.equals("N1")){
        	tplFile = tplDir + "/noSetpPwResult.jsp";
        	tplTypePath = "/mbr/noSetpPwResult.jsp";
        }
		model.addAttribute("tplTypePath", tplTypePath);
		
		CmsHandler cmsHdr = new CmsHandler(tplFile, "");
		cmsHdr.setContentHeader("<% \\/\\*<!\\-\\- \\[-CONTENT-\\] \\-\\->\\*\\/ %>");
        cmsHdr.setContentFooter("<% \\/\\*<!\\-\\- \\/\\[-CONTENT-\\] \\-\\->\\*\\/ %>");
        
        boolean loadRes = cmsHdr.loadContent();
	    if(loadRes == true) {
	        //cmsHdr.viewReport();
	        String reverseCntSrc = cmsHdr.getReverseContent();
	        
	        if(!reverseCntSrc.trim().equals(NullUtil.nullString(jnitcmstplVO.getTplSrc()).trim())) {
	        	jnitcmstplVO.setTplSrc(cmsHdr.getReverseContent());
	        	model.addAttribute("newFileCnt", "Y");
	            //치환코드 무결성 검사
	        	
	            if(tplType.equals("E") || tplType.equals("G")){
	            	String fileName = "";
	            	if(tplType.equals("E")){
	            		fileName = "signupAdd";
	            	}else {
	            		fileName = "myPage";
	            	}	            	
	            	String errorCodeList = ConfigUtil.getErrorCode(siteVO.getSitePath(), fileName, tplType, siteId);	            	
	                model.addAttribute("errorCodeList", errorCodeList);
	            }
	            //end 치환코드 무결성 검사
	        }else {
	        	model.addAttribute("newFileCnt", "N");
	        }
	        model.addAttribute("notFileCnt", "N");
		}else {
			model.addAttribute("notFileCnt", "Y");
		}	    
	    //역치환
	    jnitcmstplVO.setTplSrc(tplUtil.replaceMbrTpl(jnitcmstplVO, jnitcmstplVO.getTplSrc(), "return"));    
	    
        // 변수명은 CoC 에 따라 jnitcmstplVO
        model.addAttribute("jnitcmstplVO", jnitcmstplVO);
        
        return "jnit/cms/sub4_1-4";
    }

    @RequestMapping("/cms/sub4/0104typeview.do")
    public @ModelAttribute("jnitcmstplVO")
    JnitcmstplVO selectJnitcmstpltype(
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO) throws Exception {
		
        return jnitcmstplService.selectJnitcmstpltype(searchVO);
    }

    @RequestMapping("/cms/sub4/0104up.do")
    public String updateJnitcmstpl(
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO,
	    @ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    SessionStatus status,
	    ModelMap model)
            throws Exception {

    	String tplType = NullUtil.nullString(request.getParameter("tplType"));    	
    	
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub4_msg-nosite";
		}
		// beanValidator.validate(jnitcmstplVO, bindingResult); //validation 수행
		// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
		//	return "/jnit/tpl-temp/jnitcmstpl/JnitcmstplRegister";
		// }
		
		String siteId = CmsHelper.getSessionSiteId(request);
        JnitcmssiteVO siteVO = new JnitcmssiteVO();
        siteVO.setSiteId(siteId);
        siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
        
		jnitcmstplVO.setSiteId(siteId);
		jnitcmstplVO.setTplType(tplType);
		
		jnitcmstplVO.setTplSrc(NullUtil.nullString(jnitcmstplVO.getTplSrc()).replace("{-SITEPATH-}", siteVO.getSitePath()));
        //치환코드 역치환
        jnitcmstplVO.setTplSrc(tplUtil.replaceMbrTpl(jnitcmstplVO, jnitcmstplVO.getTplSrc(), "return"));
        
        //치환코드 무결성 검사
        if(tplType.equals("E") || tplType.equals("G")){        	
    		//Properties load    
    		Properties prop = ConfigUtil.mbrInfoProp(siteVO.getSiteId());
            //end Properties load
    		
        	HashMap<String, String> propKeyMap = new HashMap<String, String>();
            propKeyMap.put("[tel]", "전화번호");
            propKeyMap.put("[phone]", "핸드폰");
            propKeyMap.put("[email]", "이메일");
            propKeyMap.put("[post]", "우편번호");
            propKeyMap.put("[addr]", "주소");
            propKeyMap.put("[emailRecv]", "메일수신동의");
            propKeyMap.put("[smsRecv]", "SMS 수신동의");
            propKeyMap.put("[personal]", "개인 사업자");
            propKeyMap.put("[profit]", "영리 법인");
            propKeyMap.put("[nonprofit]", "비영리 법인");
            propKeyMap.put("[organization]", "공식단체");
            propKeyMap.put("[mutual]", "상호");
            propKeyMap.put("[corporateName]", "법인명");
            propKeyMap.put("[groupName]", "대표자명");
            propKeyMap.put("[businessPlace]", "사업장 소재지");
            propKeyMap.put("[businessAddr]", "사업장 주소");
            propKeyMap.put("[groupKind]", "대표 종목");
            propKeyMap.put("[groupTel]", "대표 전화번호");
            propKeyMap.put("[groupPax]", "대표 팩스");
            propKeyMap.put("[groupTitle]", "회사명");
            propKeyMap.put("[gradeNm]", "직책");
            propKeyMap.put("[ex01Add]", prop.getProperty("ex01"));
            propKeyMap.put("[ex02Add]", prop.getProperty("ex02"));
            propKeyMap.put("[ex03Add]", prop.getProperty("ex03"));
           
            /*
            Iterator propKeyItor = propKeyMap.keySet().iterator();
            String replaceKey = "";
            while (propKeyItor.hasNext()) {
    			String key = (String) propKeyItor.next();
    			replaceKey = key.replace("[", "").replace("]", "");
    			try{
    				if( !prop.getProperty(replaceKey).equals("0")){  // 0 , 1, 2 판별
        	        	if(jnitcmstplVO.getTplSrc().indexOf(key) == -1){ // 선택 or 필수일때 템플릿에 입력된 치환코드 무결성 검사	        		
        	        		model.addAttribute("alert", propKeyMap.get(key)+" 코드가 빠져있습니다.  = "+ key + " 를 입력해주시기 바랍니다.");
        	        		return "jnit/util/alertBack";
        	        	}
        	        }
    			}catch(NullPointerException e){
    				//파일이 없음
    			}
    			
    		}
            */
        }                
        //end 치환코드 무결성 검사
        
        //원본소스 치환
        jnitcmstplVO.setTplSrc(tplUtil.replaceMbrTpl(jnitcmstplVO, jnitcmstplVO.getTplSrc(), null));
        
		String subTpl = NullUtil.nullString(request.getParameter("subTplList"));       
		jnitcmstplVO.setTplDesc(subTpl);
        jnitcmstplService.updateJnitcmstpl(jnitcmstplVO);
        
        //히스토리
        tplUtil.tplHistWrite(request, jnitcmstplVO, siteId);
        
        // SUB TPL File 저장
        try {
        	JnitcmstplVO subTplVO = new JnitcmstplVO();
            subTplVO.setTplId(subTpl);        
            subTplVO = jnitcmstplService.selectJnitcmstpl(subTplVO);        
            tplUtil.tplWrite(request, subTplVO, siteVO); //경로 subtpl 없을시 저장에러 DB 복구후 파일관리 한다.
        } catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
        //End of SUB File
        
        //tpl File 저장
        tplUtil.tplWrite(request, jnitcmstplVO, siteVO);
		
        status.setComplete();
        return "redirect:/cms/sub4/0104.do?tplType="+tplType;
    }
    
    private static ModelMap AdminJson(HttpServletRequest request, ModelMap model)throws Exception{
    	String tplType = NullUtil.nullString(request.getParameter("tplType"));
    	
    	if(tplType.equals("C")){			// 로그인
    		AdminUtil.setMenuId("m04010301");
    	}else if(tplType.equals("I")){		//아이디 찾기
    		AdminUtil.setMenuId("m04010302");
    	}else if(tplType.equals("J")){		//패스워드 찾기
    		AdminUtil.setMenuId("m04010303");
    	}else if(tplType.equals("K")){		//회원양식절차
    		AdminUtil.setMenuId("m04010401");
    	}else if(tplType.equals("D")){		//회원약관동의
    		AdminUtil.setMenuId("m04010402");
    	}else if(tplType.equals("E")){		//회원가입항목입력
    		AdminUtil.setMenuId("m04010403");
    	}else if(tplType.equals("F")){		//회원가입완료
    		AdminUtil.setMenuId("m04010404");
    	}else if(tplType.equals("G")){		//마이페이지
    		AdminUtil.setMenuId("m04010405");
    	}else if(tplType.equals("H")){		//회원탈퇴
    		AdminUtil.setMenuId("m04010406");
    	}else if(tplType.equals("M")){		//비인증 아이디찾기
    		AdminUtil.setMenuId("m04010304");
    	}else if(tplType.equals("M1")){		//비인증 아이디찾기 결과
    		AdminUtil.setMenuId("m04010305");
    	}else if(tplType.equals("N")){		//비인증 패스워드찾기
    		AdminUtil.setMenuId("m04010306");
    	}else if(tplType.equals("N1")){		//비인증 패스워드찾기 결과
    		AdminUtil.setMenuId("m04010307");
    	}
		
    	return model;
    }   
}
