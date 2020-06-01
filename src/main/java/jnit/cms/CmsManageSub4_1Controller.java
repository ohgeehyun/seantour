/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.cms.handler.CmsHandler;
import jnit.cms.mgmt.JnitcmsmgmtService;
import jnit.cms.mgmt.mgmtUtil;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplDefaultVO;
import jnit.cms.tpl.JnitcmstplService;
import jnit.cms.tpl.JnitcmstplVO;
import jnit.cms.tpl.tplUtil;
import jnit.cms.tplhist.JnitcmstplhistService;
import jnit.com.util.CmdUtil;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import jnit.util.PathUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;

//템플릿관리 > 메인템플릿

@Controller
@SessionAttributes(types=JnitcmstplVO.class)
public class CmsManageSub4_1Controller {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitcmstplService")
    private JnitcmstplService jnitcmstplService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name="jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;
    
    @Resource(name = "jnitcmsmgmtService")
    private JnitcmsmgmtService jnitcmsmgmtService;
    
    @Resource(name = "jnitcmstplhistService")
    private JnitcmstplhistService jnitcmstplhistService;
    
    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");
    
    @RequestMapping(value="/cms/sub4/preview.do")
    public String previewJnitcmstpl(
            @RequestParam("tplId") java.lang.String tplId ,
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO,
            HttpServletRequest request,
            Model model)
            throws Exception {
    	
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub4_msg-nosite";
		}
		
		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO sitevo = jnitcmssiteService.selectJnitcmssite(siteSearchVO);
		searchVO.setSitePath( sitevo.getSitePath() );
		
        JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();
        jnitcmstplVO.setTplId(tplId);        
        // 변수명은 CoC 에 따라 jnitcmstplVO
        
        JnitcmstplVO vo = selectJnitcmstpl(jnitcmstplVO, searchVO);
        //model.addAttribute("jnitcmstplVO", vo);
        //log.debug( "/_tpls/" + vo.getTplType() + "/" + vo.getTplId() + ".jsp" );
        
        model.addAttribute("tplFileS", "/" + sitevo.getSitePath() + "/_tpls/" + vo.getTplType() + "/" + vo.getTplId() + "_S.jsp");
        model.addAttribute("tplFileE", "/" + sitevo.getSitePath() + "/_tpls/" + vo.getTplType() + "/" + vo.getTplId() + "_E.jsp");
        
        if("true".equals(deDug)){
        	log.debug( "/" + sitevo.getSitePath() + "/_tpls/" + vo.getTplType() + "/" + vo.getTplId() + "_S.jsp" );
        	log.debug( "/" + sitevo.getSitePath() + "/_tpls/" + vo.getTplType() + "/" + vo.getTplId() + "_E.jsp" );
        }
        
        return "jnit/cms/sub4_preview";
    }
    
    @RequestMapping("/cms/sub4/0101view.do")
    public @ModelAttribute("jnitcmstplVO")
    JnitcmstplVO selectJnitcmstpl(
            JnitcmstplVO jnitcmstplVO,
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO) throws Exception {
		
        return jnitcmstplService.selectJnitcmstpl(jnitcmstplVO);
    }
    
    @RequestMapping(value="/cms/sub4/0101.do")
    public String updateJnitcmstplView(
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO,
            HttpServletRequest request,
            Model model)
            throws Exception {
    	AdminUtil.setMenuId("m04010100");
    	
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub4_msg-nosite";
		}
		
		searchVO.setSiteId( CmsHelper.getSessionSiteId(request) );
		searchVO.setTplType("A");
		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO vo = jnitcmssiteService.selectJnitcmssite(siteSearchVO);
		searchVO.setSitePath( vo.getSitePath() );
		
		JnitcmstplVO jnitcmstplVO = selectJnitcmstpltype(searchVO);
		
		// TPL File 저장
        String tplDir = PathUtil.getRealPath(request)
					+ "/" + vo.getSitePath();
        String tplFile = tplDir + "/index.jsp";
		if(jnitcmstplVO.getStaticType() == 1){//html이 적용된 페이지
			tplFile = tplDir + "index_ori.jsp";
			log.debug("*******************************jnitcmstplVO.getStaticType() : "+jnitcmstplVO.getStaticType());
		}
		CmsHandler cmsHdr = new CmsHandler(tplFile, "");
		cmsHdr.setContentHeader("<% \\/\\*<!\\-\\- \\[-CONTENT-\\] \\-\\->\\*\\/ %>");
        cmsHdr.setContentFooter("<% \\/\\*<!\\-\\- \\/\\[-CONTENT-\\] \\-\\->\\*\\/ %>");
        
        String siteId = CmsHelper.getSessionSiteId(request);
	    JnitcmssiteVO siteVO = new JnitcmssiteVO();
	    siteVO.setSiteId(siteId);
	    siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
        
        boolean loadRes = cmsHdr.loadContent();
	    if(loadRes == true) {
	        //cmsHdr.viewReport();
	        String reverseCntSrc = cmsHdr.getReverseContent();
	        
	        //File load 역치환
	        reverseCntSrc = tplUtil.replaceAllTpl(siteVO.getSitePath(), jnitcmstplVO, reverseCntSrc, "return");
		    
	        if(!reverseCntSrc.trim().equals(NullUtil.nullString(jnitcmstplVO.getTplSrc()).trim())) {
	        	jnitcmstplVO.setTplSrc(cmsHdr.getReverseContent());
	        	model.addAttribute("newFileCnt", "Y");
	        }else {
	        	model.addAttribute("newFileCnt", "N");
	        }
	        model.addAttribute("notFileCnt", "N");
		}else {
			model.addAttribute("notFileCnt", "Y");
		}
		    
	    //jnitcmstplVO.getTplSrc() 역치환
	    jnitcmstplVO.setTplSrc(tplUtil.replaceAllTpl(siteVO.getSitePath(), jnitcmstplVO, jnitcmstplVO.getTplSrc(), "return"));   
	    
	    String codeList = NullUtil.nullString(request.getParameter("codeList"));	    
	    if(!"".equals(codeList)) model.addAttribute("codeList", codeList);
	    
        // 변수명은 CoC 에 따라 jnitcmstplVO
        model.addAttribute("jnitcmstplVO", jnitcmstplVO);
        return "jnit/cms/sub4_1-1";
    }

    @RequestMapping("/cms/sub4/0101typeview.do")
    public @ModelAttribute("jnitcmstplVO")
    JnitcmstplVO selectJnitcmstpltype(
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO) throws Exception {
		
        return jnitcmstplService.selectJnitcmstpltype(searchVO);
    }

    @RequestMapping("/cms/sub4/0101up.do")
    public String updateJnitcmstpl(
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO,
	    @ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    ModelMap model,
	    SessionStatus status)
            throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub4_msg-nosite";
		}
		
		searchVO.setSiteId( CmsHelper.getSessionSiteId(request) );
		searchVO.setTplType("A");
		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO vo = jnitcmssiteService.selectJnitcmssite(siteSearchVO);
		searchVO.setSitePath( vo.getSitePath() );
		
		jnitcmstplVO.setSiteId(vo.getSiteId());
		jnitcmstplVO.setTplType(searchVO.getTplType());
		/*
		//필수값 무결성 검사
		HashMap<Integer, String> essentialMap = ConfigUtil.getEssentialCode(searchVO.getTplType());
		String codeList = "";
		
		for(int i=0; i<essentialMap.size(); i++){
			if(jnitcmstplVO.getTplSrc().indexOf(essentialMap.get(i)) == -1){
				codeList += " "+essentialMap.get(i);
			}
		}
		
		if(!"".equals(codeList)){
			model.addAttribute("alert", "필수 치환코드 : "+codeList+"가 누락되어 서버적용에 되지않았습니다.");
			model.addAttribute("path", "/cms/sub4/0101.do?codeList="+codeList);
			
			String recodeList = NullUtil.nullString(request.getParameter("codeList"));			
			if(!"".equals(recodeList)){
				if(!codeList.equals(recodeList)){					
					model.addAttribute("path", "/cms/sub4/0101.do?codeList="+recodeList);
				}
			}			
			return "/jnit/util/alertMove";
		}
		*/
        jnitcmstplService.updateJnitcmstpl(jnitcmstplVO);
        String siteId = CmsHelper.getSessionSiteId(request);
        
        //히스토리
        tplUtil.tplHistWrite(request, jnitcmstplVO, siteId);
       
        //파일 핸들링       
        JnitcmssiteVO siteVO = new JnitcmssiteVO();
        siteVO.setSiteId(siteId);
        siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
        
        mgmtUtil.writeFile("메인템플릿","2", "3",null);
        //End 파일 핸들링
        
        // TPL File 저장
        tplUtil.tplWrite(request, jnitcmstplVO, siteVO);
        status.setComplete();
        
        return "redirect:/cms/sub4/0101.do";
    }
    
    @RequestMapping("/cms/sub4/mainToHtml.do")
    public String jnitcmstplMainToHtml(
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO,
	    @ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    ModelMap model,
	    SessionStatus status)
            throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub4_msg-nosite";
		}
		
		searchVO.setSiteId( CmsHelper.getSessionSiteId(request) );
		searchVO.setTplType("A");
		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO vo = jnitcmssiteService.selectJnitcmssite(siteSearchVO);
		searchVO.setSitePath( vo.getSitePath() );
		
		jnitcmstplVO.setSiteId(vo.getSiteId());
		jnitcmstplVO.setTplType(searchVO.getTplType());
		//html 상태로 변경
		jnitcmstplVO.setStaticType(1);
        jnitcmstplService.updateJnitcmstpl(jnitcmstplVO);
        String siteId = CmsHelper.getSessionSiteId(request);
        
        //히스토리
        tplUtil.tplHistWrite(request, jnitcmstplVO, siteId);
       
        //파일 핸들링       
        JnitcmssiteVO siteVO = new JnitcmssiteVO();
        siteVO.setSiteId(siteId);
        siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
        
        mgmtUtil.writeFile("메인템플릿","2", "3",null);
        //End 파일 핸들링
        
        // TPL File 저장
        tplUtil.tplWrite(request, jnitcmstplVO, siteVO);

        /*
         * 기존의 index.jsp의 내용은 index_ori.jsp
         * index.jsp는 index.html로 리다이렉트 되게 변경
         * 
         */
        // index_ori.jsp 저장
        jnitcmstplVO.setTplType("A_html");
        tplUtil.tplWrite(request, jnitcmstplVO, siteVO);
        
        //html 생성
        makeStaticHtmlPage(jnitcmstplVO, siteVO, request);
        
        // index.jsp 를 redirect 로 변경
        Boolean islocal = StringUtil.isExistString(request.getRequestURL().toString(), "local") ? true : false;
		String domain = request.getRequestURL().toString().replace(request.getRequestURI().toString(), "");		
		String contextPath = islocal ? request.getSession().getServletContext().getContextPath() : "";
		String url = islocal ? domain+contextPath : domain;
        String tplDir = PathUtil.getRealPath(request) +siteVO.getSitePath();
        String tplFile = "";
        tplFile = tplDir + "/index.jsp";
        url=url+"/"+siteVO.getSitePath()+"/index.html";
        CmsHandler.writeFile(tplFile, "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%><% response.sendRedirect(\""+url+"\"); %>");
        tplUtil.tplWrite(request, jnitcmstplVO, siteVO);
        
        return "redirect:/cms/sub4/0101.do";
    }
    
    public void makeStaticHtmlPage(JnitcmstplVO jnitcmstplVO,JnitcmssiteVO siteVO,HttpServletRequest request) throws IOException{
    	
    	Boolean islocal = StringUtil.isExistString(request.getRequestURL().toString(), "local") ? true : false;
		String domain = request.getRequestURL().toString().replace(request.getRequestURI().toString(), "");		
		String contextPath = islocal ? request.getSession().getServletContext().getContextPath() : "";
		String url = islocal ? domain+contextPath : domain;
		StringBuffer sb = new StringBuffer();
        String html = "";
        String tplDir = PathUtil.getRealPath(request) +siteVO.getSitePath();
    	HttpURLConnection conn = null;
        InputStreamReader isr = null;
        BufferedReader br = null;
        log.debug(islocal);
        log.debug(domain);
        log.debug(contextPath);
        log.debug(url);
        try {
        	URL temp = new URL(url+"/"+siteVO.getSitePath()+"/index.jsp");
	        conn = (HttpURLConnection) temp.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setConnectTimeout(10000);
	        conn.setReadTimeout(15000);
	        isr = new InputStreamReader(conn.getInputStream(),"UTF-8");
	        br = new BufferedReader(isr);
	        
	        String line = "";
	        while ((line = br.readLine()) != null) {
	        	html += line + "\r\n";
			}
	        sb.append(html.trim());
			String htmlFileDir = tplDir+"/index.html";
        	File file = new File(htmlFileDir);
        	if(file.exists())file.deleteOnExit();
            CmsHandler.writeFile(htmlFileDir, sb.toString());
            JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, htmlFileDir);		//Filego 배포
        } catch (IOException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		} finally {
			isr.close();
			br.close();
			conn.disconnect();
		}
    }
}
