/**
 * @version 3.2.0.1
 */
package jnit.cms.tpl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import jnit.cms.AdminUtil;
import jnit.cms.CmsHelper;
import jnit.cms.cnt.JnitcmscntService;
import jnit.cms.cnt.JnitcmscntVO;
import jnit.cms.handler.CmsHandler;
import jnit.cms.mgmt.mgmtUtil;
import jnit.cms.site.JnitcmssiteVO;
import jnit.util.PathUtil;

@Controller
public class JnitCmsTplController {

	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name="jnitcmscntService")
	private JnitcmscntService jnitcmscntService;
	
	@Resource(name = "jnitcmstplService")
    private JnitcmstplService jnitcmstplService;
	
	private static final String SEPARATOR = File.separator;
	
	private final static String deDug = EgovProperties.getPathProperty("Globals.Debug");
	
	
	@RequestMapping("/cms/tpl/pageView.do")
	public String PrintTplPageView(HttpServletRequest request, Model model
			,@ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO
			,BindingResult bindingResult) throws Exception{
		
		AdminUtil.setMenuId("m02010500");
		
		JnitcmssiteVO siteVO = AdminUtil.getSiteVO(request);
		if(siteVO == null){
			return "jnit/cms/sub4_msg-nosite";
		}
		
		String root = PathUtil.getRealPath(request);
		String siteId = NullUtil.nullString(siteVO.getSiteId());
		String sitePath = NullUtil.nullString(siteVO.getSitePath());
		
		searchVO.setSiteId(siteId);
		searchVO.setSitePath(sitePath);
		searchVO.setTplType("O");
		JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();
		try {
			jnitcmstplVO = jnitcmstplService.selectJnitcmstpltype(searchVO);
		} catch (NullPointerException e){
			log.error(e.getMessage());
			String tplFile = root + "default/print.jsp";
			tplUtil.makeTplVO(request, jnitcmstplVO, siteVO, tplFile, null, "O", "프린트템플릿");			
			jnitcmstplVO = jnitcmstplService.selectJnitcmstpltype(searchVO);
		} catch (Exception e) {
			log.error(e.getMessage());
			String tplFile = root + "default/print.jsp";
			tplUtil.makeTplVO(request, jnitcmstplVO, siteVO, tplFile, null, "O", "프린트템플릿");			
			jnitcmstplVO = jnitcmstplService.selectJnitcmstpltype(searchVO);
		}
		
		// TPL File 저장
        String tplDir = PathUtil.getRealPath(request) + sitePath;
        String tplFile = tplDir + SEPARATOR + "print.jsp";
		
		CmsHandler cmsHdr = new CmsHandler(tplFile, "");
		cmsHdr.setContentHeader("<% \\/\\*<!\\-\\- \\[-CONTENT-\\] \\-\\->\\*\\/ %>");
        cmsHdr.setContentFooter("<% \\/\\*<!\\-\\- \\/\\[-CONTENT-\\] \\-\\->\\*\\/ %>");
        
        boolean loadRes = cmsHdr.loadContent();
	    if(loadRes == true) {
	        //cmsHdr.viewReport();
	        String reverseCntSrc = cmsHdr.getReverseContent();
	        
	        //File load 역치환
	        //2014-07-31 by.나성재 수정	       
	        reverseCntSrc = tplUtil.replaceAllTpl(sitePath, jnitcmstplVO, reverseCntSrc, "return");
	        
	        if(!reverseCntSrc.equals(NullUtil.nullString(jnitcmstplVO.getTplSrc()))) {
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
	    //2014-07-31 by.나성재 수정
        jnitcmstplVO.setTplSrc(tplUtil.replaceAllTpl(sitePath, jnitcmstplVO, jnitcmstplVO.getTplSrc(), "return"));
        // 변수명은 CoC 에 따라 jnitcmstplVO
        model.addAttribute("jnitcmstplVO", jnitcmstplVO);
		
        return "jnit/cms/tpl/print_tpl";
	}
	
	
	@RequestMapping("/cms/tpl/pageUp.do")
    public String updateJnitcmstpl(HttpServletRequest request, Model model
    		, @ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO
    		, @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO
    		, BindingResult bindingResult) throws Exception {

		JnitcmssiteVO siteVO = AdminUtil.getSiteVO(request);
		
		if(siteVO == null){
			return "jnit/cms/sub4_msg-nosite";
		}
		
		searchVO.setSiteId( CmsHelper.getSessionSiteId(request) );
		searchVO.setTplType("O");
		
		jnitcmstplVO.setSiteId(jnitcmstplVO.getSiteId());
		jnitcmstplVO.setTplType(searchVO.getTplType());		
		jnitcmstplVO.setTplSrc(NullUtil.nullString(jnitcmstplVO.getTplSrc()).replace("{-SITEPATH-}", siteVO.getSitePath()));
		
        jnitcmstplService.updateJnitcmstpl(jnitcmstplVO);
        
        //히스토리
        tplUtil.tplHistWrite(request, jnitcmstplVO, jnitcmstplVO.getSiteId());
       
        //파일 핸들링
        mgmtUtil.writeFile("프린트템플릿","2", "3",null);
        
        // TPL File 저장
        tplUtil.tplWrite(request, jnitcmstplVO, siteVO);
        
        return "redirect:/cms/tpl/pageView.do";
    }
	
	@RequestMapping("/print/output.do")
	public String PrintOutput(HttpServletRequest request, Model model) throws Exception{
		String path = NullUtil.nullString(request.getParameter("path"));		
		String site = path.split("/")[1];
		String realPath = NullUtil.nullString(PathUtil.getRealPath(request));
		String baseUrl = realPath + SEPARATOR + site + SEPARATOR + "print.jsp";
		
		if(path.lastIndexOf("index.jsp") == -1){
			path = path+"index.jsp";
		}
		String confUrl = realPath + path + ".prop";
		String makePath = realPath + "WEB-INF/jsp/jnit/print";
		String makeFilePath = makePath + SEPARATOR + "index.jsp";
		FileInputStream fis = null;
		Properties prop = new Properties();		
		try {
			fis = new FileInputStream(new File(confUrl));
			prop.load(fis);
		} catch (IOException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		} finally {
			if(fis != null){
				fis.close();
			}
		}		
		String cntId = (String) prop.getProperty("cntId");

		JnitcmscntVO vo = new JnitcmscntVO();
		vo.setSearchCondition("1");
		vo.setCntId(cntId);
		
		JnitcmscntVO result = jnitcmscntService.selectJnitcmscnt(vo);
		String src = result.getCntSrc();
		
		String code = CmsHandler.readFile(baseUrl);
		
		JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();
		jnitcmstplVO.setTplType("O");
		jnitcmstplVO.setTplSrc(code);
		
		code = tplUtil.replaceAllTpl(site, jnitcmstplVO, code, null);
		code = code.replace("{-BODY-}", src);		
		code = replaceCodeProp(code, prop);
		File makePathDir = new File(makePath);
		if(!makePathDir.exists()){
			makePathDir.mkdir();
		}
		
		CmsHandler.writeFile(makeFilePath, code);		
		
		model.addAttribute("Jnit_sitePath", site);
		model.addAttribute("code", code);
		return "/jnit/print/index";
	}
	
	/**
	 * 해당 컨텐츠의 프로퍼티 파일 값을 치환한다.
	 * @param code - 소스
	 * @param prop - 컨텐츠 프로퍼티
	 * @return 치환된 code
	 * @throws Exception
	 */
	private String replaceCodeProp(String code, Properties prop)throws Exception{
		code = NullUtil.nullString(code);
		if(!"".equals(code)){
			try {
				code = code.replace("{-PAGETITLE-}", prop.getProperty("pageTitle"));
			} catch (NullPointerException e){
				if("true".equals(deDug)) log.debug(e.getMessage());
			} catch (Exception e) {
				if("true".equals(deDug)) log.debug(e.getMessage());
			}
			try {
				code = code.replace("{-PAGELINKNAV-}", prop.getProperty("pageLinkNav"));
			} catch (NullPointerException e){
				if("true".equals(deDug)) log.debug(e.getMessage());
			} catch (Exception e) {
				if("true".equals(deDug)) log.debug(e.getMessage());
			}
		}
		return code;
	}
}
