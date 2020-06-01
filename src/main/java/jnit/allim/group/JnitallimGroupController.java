/**
 * @version 3.2.0.1
 */
package jnit.allim.group;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.allim.item.JnitallimItemService;
import jnit.cms.AdminUtil;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : JnitallimGroupController.java
 * @Description : JnitallimGroup Controller class
 * @Modification Information
 *
 * @author JNITALLIM_GROUP
 * @since 2012.04.24
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitallimGroupVO.class)
public class JnitallimGroupController {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitallimGroupService")
    private JnitallimGroupService jnitallimGroupService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name = "jnitallimItemService")
    private JnitallimItemService jnitallimItemService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * jnitallim_group 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitallimGroupDefaultVO
	 * @return "/jnit/tpl-temp/jnitallimGroup/JnitallimGroupList"
	 * @exception Exception
	 */

    @RequestMapping(value="/cms/allim/groupList.do")
    public String selectJnitallimGroupList(@ModelAttribute("searchVO") JnitallimGroupDefaultVO searchVO,
    		ModelMap model, HttpServletRequest request)
            throws Exception {

    	String type = NullUtil.nullString(request.getParameter("type"));
    	String grpId = NullUtil.nullString(request.getParameter("grpId"));

    	//JSON
    	model.addAllAttributes(AdminJSON(request, model));

    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(200); //page row 200개 고정
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVO.setSearchCondition("2");
		searchVO.setSearchKeyword(type);

        List jnitallimGroupList = jnitallimGroupService.selectJnitallimGroupList(searchVO);
        model.addAttribute("resultList", jnitallimGroupList);

        int totCnt = jnitallimGroupService.selectJnitallimGroupListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("type", type);
        if(!grpId.equals("")){
        	model.addAttribute("grpId", grpId);
        }

        return "/jnit/allim/group/groupList";
    }

    @RequestMapping("/cms/allim/groupAdd.do")
    public String addJnitallimGroupView(
            @ModelAttribute("searchVO") JnitallimGroupDefaultVO searchVO, ModelMap model, HttpServletRequest request)
            throws Exception {

    	try{

    		String type = NullUtil.nullString(request.getParameter("type"));
	    	String grpId = NullUtil.nullString(request.getParameter("grpId"));

	    	//JSON
	    	model.addAllAttributes(AdminJSON(request, model));
	    	//FileList
	    	ArrayList skinList = jnitallimItemService.allimFileNameList(request,type, null);
	    	model.addAttribute("skinList", skinList);
	        //model.addAttribute("nid",  jnitallimGroupService.getLastIdJnitallimGroup());
	        model.addAttribute("jnitallimGroupVO", new JnitallimGroupVO());
	        model.addAttribute("type", type);
	        model.addAttribute("grpId", grpId);
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}

        return "/jnit/allim/group/groupRegister";
    }

    @RequestMapping("/cms/allim/groupAddProc.do")
    public String addJnitallimGroup(
            @ModelAttribute("searchVO") JnitallimGroupDefaultVO searchVO,
	    @ModelAttribute("jnitallimGroupVO") JnitallimGroupVO jnitallimGroupVO,
	    BindingResult bindingResult, HttpServletRequest request, Model model,
	    SessionStatus status)
            throws Exception {

    	String type = NullUtil.nullString(jnitallimGroupVO.getGroupType());
    	String grpId = NullUtil.nullString(request.getParameter("grpId"));
    	String groupCategory = NullUtil.nullString(request.getParameter("groupCategory"));
    	String division = "group";
    	
    	/* 배너 등록시 groupChangeTime null 오류로 인해 소스 수정 */
    	String groupChangeTime = NullUtil.nullString(jnitallimGroupVO.getGroupChangeTime());
    	if("".equals(groupChangeTime)) jnitallimGroupVO.setGroupChangeTime("0");

  	 /*beanValidator.validate(jnitallimGroupVO, bindingResult); //validation 수행
	 if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
		return "/jnit/tpl-temp/jnitallimGroup/JnitallimGroupRegister";
	 }*/
    	jnitallimGroupVO.setGroupCategory(groupCategory);
        jnitallimGroupService.insertJnitallimGroup(jnitallimGroupVO);
        status.setComplete();
        model.addAttribute("type", type);
        model.addAttribute("division", division);
        model.addAttribute("grpId", grpId);

        return "/jnit/allim/redirect";
    }

    @RequestMapping("/cms/allim/groupEdit.do")
    public String updateJnitallimGroupView(@ModelAttribute("searchVO") JnitallimGroupDefaultVO searchVO
    		, ModelMap model
    		, HttpServletRequest request) throws Exception {

    	String grpId = NullUtil.nullString(request.getParameter("grpId"));
    	String type = NullUtil.nullString(request.getParameter("type"));

    	//JSON
    	model.addAllAttributes(AdminJSON(request, model));

        JnitallimGroupVO jnitallimGroupVO = new JnitallimGroupVO();
        jnitallimGroupVO.setGroupId(grpId);
        JnitallimGroupVO getGroupVO = jnitallimGroupService.selectJnitallimGroup(jnitallimGroupVO);

        //FileList
    	ArrayList skinList = jnitallimItemService.allimFileNameList(request,type,null);
    	model.addAttribute("skinList", skinList);
        model.addAttribute(selectJnitallimGroup(jnitallimGroupVO, searchVO));
        model.addAttribute("type", type);
        model.addAttribute("grpId", grpId);
        model.addAttribute("groupCategory", getGroupVO.getGroupCategory());

        return "/jnit/allim/group/groupRegister";
    }

    @RequestMapping("/jnitallimGroup/selectJnitallimGroup.do")
    public @ModelAttribute("jnitallimGroupVO")
    JnitallimGroupVO selectJnitallimGroup(
            JnitallimGroupVO jnitallimGroupVO,
            @ModelAttribute("searchVO") JnitallimGroupDefaultVO searchVO) throws Exception {
        return jnitallimGroupService.selectJnitallimGroup(jnitallimGroupVO);
    }

    @RequestMapping("/cms/allim/groupEditProc.do")
    public String updateJnitallimGroup(
            @ModelAttribute("searchVO") JnitallimGroupDefaultVO searchVO,
	    @ModelAttribute("jnitallimGroupVO") JnitallimGroupVO jnitallimGroupVO,
	    BindingResult bindingResult, Model model, HttpServletRequest request,
	    SessionStatus status)
            throws Exception {

  	 /*beanValidator.validate(jnitallimGroupVO, bindingResult); //validation 수행
	 if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
		return "/jnit/tpl-temp/jnitallimGroup/JnitallimGroupRegister";
	 }*/

    	String type = NullUtil.nullString(jnitallimGroupVO.getGroupType());
    	String division = "group";
    	String grpId = NullUtil.nullString(request.getParameter("grpId"));
    	String groupCategory = NullUtil.nullString(request.getParameter("groupCategory"));

    	jnitallimGroupVO.setGroupCategory(groupCategory);
        jnitallimGroupService.updateJnitallimGroup(jnitallimGroupVO);
        status.setComplete();

        model.addAttribute("type", type);
        model.addAttribute("division", division);
        if(!grpId.equals("")){
        	model.addAttribute("grpId", grpId);
        }

        //allimUtil.makeAllimHtml(request, type, groupCategory, grpId);
        jnitallimItemService.makeAllimJSP(request, grpId, groupCategory, type);
        return "/jnit/allim/redirect";
    }

    @RequestMapping("/cms/allim/groupDeleteProc.do")
    public String deleteJnitallimGroup(
    		@ModelAttribute("searchVO") JnitallimGroupDefaultVO searchVO
            , JnitallimGroupVO jnitallimGroupVO
            , SessionStatus status
            , HttpServletRequest request,
            ModelMap model) throws Exception {

        jnitallimGroupService.deleteJnitallimGroup(jnitallimGroupVO);

        status.setComplete();
        return "redirect:/cms/allim/groupList.do?type="+jnitallimGroupVO.getGroupType();
    }

    @RequestMapping("/jnitallimGroup/ajaxGroup.do")
    public String ajaxGroup(
            JnitallimGroupVO jnitallimGroupVO,
            @ModelAttribute("searchVO") JnitallimGroupDefaultVO searchVO, SessionStatus status, HttpServletRequest request,
            Model model)
            throws Exception {
    	AdminUtil.setMenuId("m06030000");
    	int timerDelay = Integer.parseInt(request.getParameter("timerDelay"));
    	int appendDelay = timerDelay - 500;
    	model.addAttribute("appendDelay", appendDelay);
        return "/jnit/allim/group/ajaxGroup";
    }

    @RequestMapping("/cms/allim/groupCopy.do")
    public String groupCopy(HttpServletRequest request, ModelMap model)throws Exception{
    	String groupId = NullUtil.nullString(request.getParameter("groupId"));
    	String groupTitleCopy = NullUtil.nullString(request.getParameter("groupTitleCopy"));
    	String groupCategory = NullUtil.nullString(request.getParameter("groupCategory"));
    	String type = NullUtil.nullString(request.getParameter("type"));

    	JnitallimGroupVO groupVO = new JnitallimGroupVO();
    	groupVO.setGroupId(groupId);
    	JnitallimGroupVO groupCopyVO = jnitallimGroupService.selectJnitallimGroup(groupVO);

    	groupCopyVO.setGroupNm(groupTitleCopy);
    	groupCopyVO.setGroupCategory(groupCategory);
    	jnitallimGroupService.insertJnitallimGroup(groupCopyVO);

    	model.addAttribute("alert", "정상처리되었습니다.");
    	model.addAttribute("path", "/cms/allim/groupList.do?type="+type);

    	return "jnit/util/alertMove";
    }

    @RequestMapping("/cms/allim/ajax/skin.do")
    public String allimAjaxSkin(HttpServletRequest request, ModelMap model)throws Exception{
    	String skinNm = NullUtil.nullString(request.getParameter("skinNm"));
    	if(request.getParameter("addSkinNm") != null) skinNm = NullUtil.nullString(request.getParameter("addSkinNm")); //디자인페이지
    	String skinType = NullUtil.nullString(request.getParameter("skinType"));
    	String type = NullUtil.nullString(request.getParameter("type"));
    	String root = PathUtil.getRealPath(request);
    	String allimDir = root + "WEB-INF/jsp/jnit/allim";

    	ArrayList allimFileList = jnitallimItemService.allimFileNameList(request, type, null);
    	int isFile = (allimFileList.size()+1);

    	JSONObject JSON = new JSONObject();

    	//default code 생성
    	String defaultFileDir = allimDir+"/default/"+type+"/"+skinType+"_code.jsp";
    	String skinFileDir = allimDir+"/default/"+type+"/"+skinNm+"_code.jsp";
    	JSON = jnitallimItemService.allimFileMake(request, skinFileDir, defaultFileDir, isFile);
    	if("error".equals(JSON.get("status"))){
    		model.addAttribute("json", JSON.toString());
    		return "/jnit/util/json";
    	}

    	//default 생성
		String defaultFileOriginDir = allimDir+"/default/"+type+"/"+skinType+".jsp";
    	String skinFileOriginDir = allimDir+"/default/"+type+"/"+skinNm+".jsp";
    	JSON = jnitallimItemService.allimFileMake(request, skinFileOriginDir, defaultFileOriginDir, isFile);
    	if("error".equals(JSON.get("status"))){
    		model.addAttribute("json", JSON.toString());
    		return "/jnit/util/json";
    	}

    	//skin code 생성
		String useSkinCodeDir = allimDir+"/skin/"+type+"/"+skinNm+"_code.jsp";
		JSON = jnitallimItemService.allimFileMake(request, useSkinCodeDir, defaultFileDir, isFile);
		if("error".equals(JSON.get("status"))){
    		model.addAttribute("json", JSON.toString());
    		return "/jnit/util/json";
    	}

    	//skin 생성
		String useSkinDir = allimDir+"/skin/"+type+"/"+skinNm+".jsp";
		JSON = jnitallimItemService.allimFileMake(request, useSkinDir, defaultFileOriginDir, isFile);
		if("error".equals(JSON.get("status"))){
    		model.addAttribute("json", JSON.toString());
    		return "/jnit/util/json";
    	}

		if("banner".equals(type)){

			//default code 생성
			String defaultBannerMoreCodeFileDir = allimDir+"/default/"+type+"/bannerMore_code.jsp";
			String defultBannerMoreCodeDir = allimDir+"/default/"+type+"/"+skinNm+"_bannerMore_code.jsp";
			JSON = jnitallimItemService.allimFileMake(request, defultBannerMoreCodeDir, defaultBannerMoreCodeFileDir, isFile);
			if("error".equals(JSON.get("status"))){
	    		model.addAttribute("json", JSON.toString());
	    		return "/jnit/util/json";
	    	}

	    	//default 생성
			String defaultBannerMoreFileDir = allimDir+"/default/"+type+"/bannerMore.jsp";
			String defultBannerMoreDir = allimDir+"/default/"+type+"/"+skinNm+"_bannerMore.jsp";
			JSON = jnitallimItemService.allimFileMake(request, defultBannerMoreDir, defaultBannerMoreFileDir, isFile);
			if("error".equals(JSON.get("status"))){
	    		model.addAttribute("json", JSON.toString());
	    		return "/jnit/util/json";
	    	}
	    	//skin code 생성
	    	String useBannerMoreCodeDir = allimDir+"/skin/"+type+"/"+skinNm+"_bannerMore_code.jsp";
			JSON = jnitallimItemService.allimFileMake(request, useBannerMoreCodeDir, defaultBannerMoreCodeFileDir, isFile);
			if("error".equals(JSON.get("status"))){
	    		model.addAttribute("json", JSON.toString());
	    		return "/jnit/util/json";
	    	}

	    	//skin 생성
			String useBannerMoreDir = allimDir+"/skin/"+type+"/"+skinNm+"_bannerMore.jsp";
			JSON = jnitallimItemService.allimFileMake(request, useBannerMoreDir, defaultBannerMoreFileDir, isFile);
			if("error".equals(JSON.get("status"))){
	    		model.addAttribute("json", JSON.toString());
	    		return "/jnit/util/json";
	    	}
		}

		//allimJSON
		//allimUtil.allimJSON(request, skinNm, skinType, type);
    	model.addAttribute("json", JSON.toString());
    	return "/jnit/util/json";
    }

    /**
     * AdminUtil을 제어한다.
     * @param request
     * @param model
     * @return model
     * @throws Exception
     */
    public static ModelMap AdminJSON(HttpServletRequest request, ModelMap model)throws Exception{
    	String type = NullUtil.nullString(request.getParameter("type"));
    	if(type.equals("banner")){
    		AdminUtil.setMenuId("m06020100");
    	}else if(type.equals("allim")){
    		AdminUtil.setMenuId("m06030100");
    	}else if(type.equals("popup")){
    		AdminUtil.setMenuId("m06040100");
    	}
    	return model;
    }

    private void skinFileDelete(String dir)throws Exception{
    	dir = NullUtil.nullString(dir);
    	if(!"".equals(dir)){
    		File file = new File(dir);
    		if(file.exists()){
    			file.delete();
    			JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, file);		//Filego 배포
    		}
    		
    	}
    }
}