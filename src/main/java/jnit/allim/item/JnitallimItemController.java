/**
 * @version 3.2.0.1
 */
package jnit.allim.item;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ibm.icu.text.DateFormat;
import com.ibm.icu.text.SimpleDateFormat;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.allim.group.JnitallimGroupController;
import jnit.allim.group.JnitallimGroupDefaultVO;
import jnit.allim.group.JnitallimGroupService;
import jnit.allim.group.JnitallimGroupVO;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;
/**
 * @Class Name : JnitallimItemController.java
 * @Description : JnitallimItem Controller class
 * @Modification Information
 *
 * @author JNITALLIMITEM
 * @since 2012.04.24
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitallimItemVO.class)
public class JnitallimItemController {

	private Log log = LogFactory.getLog(getClass());
	
	 /** 첨부파일 위치 지정 */
    private String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");

    /** 첨부 최대 파일 크기 지정 */
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)

    public static final String SEPERATOR = File.separator;

    /** ID Generation */
    @Resource(name="jnitALLIM_ITEM_IdGnrService")
    private EgovIdGnrService egovIdGnrService;

    @Resource(name = "jnitallimItemService")
    private JnitallimItemService jnitallimItemService;

    /*group service*/
    @Resource(name = "jnitallimGroupService")
    private JnitallimGroupService jnitallimGroupService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * jnitallim_item 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitallimItemDefaultVO
	 * @return "/jnit/tpl-temp/jnitallimItem/JnitallimItemList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/allim/itemList.do")
    public String selectJnitallimItemList(@ModelAttribute("searchVO") JnitallimItemDefaultVO searchVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

    	/* banner = 배너
    	 * allim = 알리미
    	 * popup = 팝업
    	 */

    	String type = NullUtil.nullString(request.getParameter("type"));
    	String groupId = "";//그룹 리스트에서 groupId를 눌렀을때 or 입력/수정 후 Redirect 타고 옴(request->Redirect타고옴)

    	//JSON
    	model.addAllAttributes(JnitallimGroupController.AdminJSON(request, model));

    	if(NullUtil.nullString(request.getParameter("grpId")).equals("")){
    		groupId = NullUtil.nullString(searchVO.getSearchKeyword());
    	}else{
    		groupId = NullUtil.nullString(request.getParameter("grpId"));
    	}
    	if(groupId.equals("")){
    		/* ITEM 전체 리스트 조회 */
    		searchVO.setSearchCondition("2");
    		searchVO.setSearchKeyword(type);
    	}else{
    		/* ITEM 상세 리스트 조회 */
    		searchVO.setSearchCondition("3");
    		searchVO.setSearchKeyword(groupId);
    	}

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

        List jnitallimItemList = jnitallimItemService.selectJnitallimItemList(searchVO);
        model.addAttribute("resultList", jnitallimItemList);

        if(groupId.equals("") == false){
	        JnitallimGroupDefaultVO defaultVO = new JnitallimGroupDefaultVO();
			    defaultVO.setSearchCondition("4");
			    defaultVO.setSearchKeyword(groupId);

			List expireList = jnitallimGroupService.selectGroupList(defaultVO);
			HashMap<String, Boolean> expire = new HashMap<String, Boolean>();
				for(int i=0; i<expireList.size(); i++){
					expire.put(expireList.get(i).toString().split(",")[19].trim().replace("itemId=", ""), true);
				}
			model.addAttribute("expire", expire);
        }
        int totCnt = jnitallimItemService.selectJnitallimItemListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);

        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("groupId", groupId);
        model.addAttribute("type", type);

        return "/jnit/allim/item/itemList";
    }

    /**
     * 등록폼
     * @param searchVO
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/cms/allim/itemAdd.do")
    public String addJnitallimItemView(
            @ModelAttribute("searchVO") JnitallimItemDefaultVO searchVO, ModelMap model, HttpServletRequest request)
            throws Exception {

    	String type = NullUtil.nullString(request.getParameter("type"));
    	String grpId = NullUtil.nullString(request.getParameter("grpId"));

    	//JSON
    	model.addAllAttributes(JnitallimGroupController.AdminJSON(request, model));

    	JnitallimGroupDefaultVO defaultVO = new JnitallimGroupDefaultVO();
    		defaultVO.setSearchCondition("2");
    		defaultVO.setSearchKeyword(type);
    		defaultVO.setPageYn("N");
    	List groupList = jnitallimGroupService.selectJnitallimGroupList(defaultVO);

    	String ItemNextId = jnitallimItemService.getLastIdJnitallimItem();

    	JnitallimGroupVO groupVO = new JnitallimGroupVO();
    	groupVO.setGroupId(grpId);
    	JnitallimGroupVO getGroupVO = jnitallimGroupService.selectJnitallimGroup(groupVO);

    	model.addAttribute("groupCategory", getGroupVO.getGroupCategory());
		model.addAttribute("ItemNextId", ItemNextId);
        model.addAttribute("nid",  jnitallimItemService.getLastIdJnitallimItem());
        model.addAttribute("jnitallimItemVO", new JnitallimItemVO());
        model.addAttribute("type", type);
        model.addAttribute("groupList", groupList);
        model.addAttribute("grpId", grpId);
        return "/jnit/allim/item/itemRegister";
    }

    /**
     * 등록
     * @param searchVO
     * @param jnitallimItemVO
     * @param bindingResult
     * @param status
     * @return
     * @throws Exception
     */
    @RequestMapping("/cms/allim/itemAddProc.do")
    public String addJnitallimItem(
            @ModelAttribute("searchVO") JnitallimItemDefaultVO searchVO,
	    @ModelAttribute("jnitallimItemVO") JnitallimItemVO jnitallimItemVO,
	    BindingResult bindingResult, Model model,
	    HttpServletRequest request,
	    SessionStatus status)
            throws Exception {

    	String type = NullUtil.nullString(jnitallimItemVO.getItemType());
    	String grpId = NullUtil.nullString(request.getParameter("grpId"));

    	String startDate = NullUtil.nullString(request.getParameter("itemStartdate"));
    	String endDate = NullUtil.nullString(request.getParameter("itemEnddate"));
    	String groupCategory = NullUtil.nullString(request.getParameter("groupCategory"));
    	String itemIconTitle = "";
    	String itemIconComent = "";

    	String htmlCodeYn = NullUtil.nullString(request.getParameter("htmlCodeYn"));
    	if(htmlCodeYn.equals("0")){
    		jnitallimItemVO.setItemHtmlcode(null);
    	}

    	if(groupCategory.equals("icon")){
    		itemIconTitle = NullUtil.nullString(request.getParameter("itemIconTitle"));
    		itemIconComent = NullUtil.nullString(request.getParameter("itemIconComent"));
    	}

    	Date start = null ;
    	Date end = null ;

    	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH");//HH:mm

    	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

    	//startDate Null일때
    	if("".equals(startDate)){
    		String startDefault = "2013-01-01 00:00:00";
    		jnitallimItemVO.setItemStartdate(format.parse(startDefault));
    	}else{
    		start = (Date)dateFormat.parse(startDate);
    		jnitallimItemVO.setItemStartdate(start);
    	}

    	//endDate Null일때
    	if("".equals(endDate)){
    		String endDefault = "2100-12-31 00:00:00";
    		jnitallimItemVO.setItemEnddate(format.parse(endDefault));
    	}else{
    		end = (Date)dateFormat.parse(endDate);
    		jnitallimItemVO.setItemEnddate(end);
    	}

    	uploadDir = getUploadDir(request);
    	HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFormFiles(request, uploadDir, maxFileSize);

    	List sortVO = jnitallimItemService.selectSortMax(searchVO);
    	Iterator sortList = (Iterator) sortVO.iterator();
    	while(sortList.hasNext()){
    		EgovMap sortlist = (EgovMap) sortList.next();
    		if(sortlist.get("itemSort") == null){
    			jnitallimItemVO.setItemSort(0);
    		}else{
    			int sort = Integer.parseInt(sortlist.get("itemSort").toString())+1;
    			jnitallimItemVO.setItemSort(sort);
    		}
    	}

    	if(list.get("upfile") != null){
			EgovFormBasedFileVo vo = list.get("upfile");
 			String imgFileUrl = "/cms/getFile.do?"
    	    + "path=" + vo.getServerSubPath()
    	    + "&file=" + vo.getPhysicalName()
    	    + "&orgname=" + vo.getFileName();
 			String itemUrlPath = "/upload/"+vo.getServerSubPath()+"/"+vo.getPhysicalName();
 			jnitallimItemVO.setItemUrl(imgFileUrl);
 			jnitallimItemVO.setItemOrigin(vo.getFileName());
 			jnitallimItemVO.setItemUrlPath(itemUrlPath);
		}
    	jnitallimItemVO.setItemSort(0);

    	if(!itemIconTitle.equals("") || !itemIconComent.equals("")){
    		jnitallimItemVO.setItemExt01(itemIconTitle);
    		jnitallimItemVO.setItemExt02(itemIconComent);
    	}
        jnitallimItemService.insertJnitallimItem(jnitallimItemVO);

        //allimUtil.makeAllimHtml(request, type, groupCategory, grpId);
        jnitallimItemService.makeAllimJSP(request, grpId, groupCategory, type);
        status.setComplete();

        model.addAttribute("type", type);
        model.addAttribute("grpId", grpId);

        return "/jnit/allim/redirect";
    }

    /**
     * 수정폼
     * @param itemId
     * @param searchVO
     * @param model
     * @param reuqest
     * @return
     * @throws Exception
     */
    @RequestMapping("/cms/allim/itemEdit.do")
    public String updateJnitallimItemView(
            @RequestParam("itemId") java.lang.String itemId ,
            @ModelAttribute("searchVO") JnitallimItemDefaultVO searchVO, ModelMap model, HttpServletRequest reuqest, HttpServletRequest request)
            throws Exception {

    	String type = NullUtil.nullString(reuqest.getParameter("type"));
    	String grpId = NullUtil.nullString(request.getParameter("grpId"));

    	//JSON
    	model.addAllAttributes(JnitallimGroupController.AdminJSON(request, model));

        JnitallimItemVO jnitallimItemVO = new JnitallimItemVO();
        jnitallimItemVO.setItemId(itemId);
        // 변수명은 CoC 에 따라 jnitallimItemVO
        JnitallimGroupDefaultVO defaultVO = new JnitallimGroupDefaultVO();
	        defaultVO.setSearchCondition("2");
			defaultVO.setSearchKeyword(type);
        	defaultVO.setPageYn("N");
        List groupList = jnitallimGroupService.selectJnitallimGroupList(defaultVO);

        JnitallimItemDefaultVO searchId = new JnitallimItemDefaultVO();
        searchId.setSearchCondition("0");
        searchId.setSearchKeyword(itemId);
        JnitallimItemVO imgUrl = jnitallimItemService.selectJnitallimItem(jnitallimItemVO);
        String resultImgUrl = imgUrl.getItemUrl();

        JnitallimItemVO  itemVO = new JnitallimItemVO();
        itemVO.setItemId(itemId);
        JnitallimItemVO getItemVO = jnitallimItemService.selectJnitallimItem(itemVO);
        String ItemHtmlcodeYn = "";
        if(getItemVO.getItemHtmlcode() == null){
        	ItemHtmlcodeYn = "N";
        }else{
        	ItemHtmlcodeYn ="Y";
        }
        JnitallimGroupVO  groupVO = new JnitallimGroupVO();
        groupVO.setGroupId(grpId);
        groupVO = jnitallimGroupService.selectJnitallimGroup(groupVO);

        model.addAttribute("height", groupVO.getGroupHeight());
        model.addAttribute("ItemNextId", itemId);
        model.addAttribute("ItemHtmlcodeYn", ItemHtmlcodeYn);
        model.addAttribute("groupCategory", groupVO.getGroupCategory());
        model.addAttribute("itemIconTitle", getItemVO.getItemExt01());
        model.addAttribute("itemIconComent", getItemVO.getItemExt02());
        model.addAttribute("resultImgUrl", resultImgUrl);
        model.addAttribute(selectJnitallimItem(jnitallimItemVO, searchVO));
        model.addAttribute("resultList", selectJnitallimItem(jnitallimItemVO, searchVO));//수정부분에서 ITEM_MODE 체크박스 선택하기 위해서 model에서 key값 명시
        model.addAttribute("type", type);
        model.addAttribute("groupList", groupList);
        model.addAttribute("grpId", grpId);
        return "/jnit/allim/item/itemRegister";
    }

    @RequestMapping("/jnitallimItem/selectJnitallimItem.do")
    public @ModelAttribute("jnitallimItemVO")
    JnitallimItemVO selectJnitallimItem(
            JnitallimItemVO jnitallimItemVO,
            @ModelAttribute("searchVO") JnitallimItemDefaultVO searchVO) throws Exception {

    	JnitallimItemVO result = jnitallimItemService.selectJnitallimItem(jnitallimItemVO);
        return jnitallimItemService.selectJnitallimItem(jnitallimItemVO);
    }

    /***
     * 수정
     * @param searchVO
     * @param jnitallimItemVO
     * @param bindingResult
     * @param status
     * @return
     * @throws Exception
     */
    @RequestMapping("/cms/allim/itemEditProc.do")
    public String updateJnitallimItem(
            @ModelAttribute("searchVO") JnitallimItemDefaultVO searchVO,
	    @ModelAttribute("jnitallimItemVO") JnitallimItemVO jnitallimItemVO,
	    BindingResult bindingResult,Model model,
	    HttpServletRequest request,
	    SessionStatus status)
            throws Exception {

    	String startDate = NullUtil.nullString(request.getParameter("itemStartdate"));
    	String endDate = NullUtil.nullString(request.getParameter("itemEnddate"));
    	String groupCategory = NullUtil.nullString(request.getParameter("groupCategory"));
    	String itemIconTitle = NullUtil.nullString(request.getParameter("itemIconTitle"));
    	String itemIconComent = NullUtil.nullString(request.getParameter("itemIconComent"));
    	Date start = null ;
    	Date end = null ;
  	 /*beanValidator.validate(jnitallimItemVO, bindingResult); //validation 수행
	 if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
		return "/jnit/tpl-temp/jnitallimItem/JnitallimItemRegister";
	 }*/

    	String type = NullUtil.nullString(jnitallimItemVO.getItemType());
    	String grpId = NullUtil.nullString(request.getParameter("grpId"));

    	String htmlCodeYn = NullUtil.nullString(request.getParameter("htmlCodeYn"));
    	if(htmlCodeYn.equals("0")){
    		jnitallimItemVO.setItemHtmlcode(null);
    	}

    	if(type.equals("banner") == false){
    		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH");//HH:mm
    		start = (Date)dateFormat.parse(startDate);
    		end = (Date)dateFormat.parse(endDate);

    		jnitallimItemVO.setItemStartdate(start);
    		jnitallimItemVO.setItemEnddate(end);
    	}

    	uploadDir = getUploadDir(request);
    	HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFormFiles(request, uploadDir, maxFileSize);

    	//추가
    	if(list.get("upfile") != null){
			EgovFormBasedFileVo vo = list.get("upfile");
 			String imgFileUrl = "/cms/getFile.do?"
    	    + "path=" + vo.getServerSubPath()
    	    + "&file=" + vo.getPhysicalName()
    	    + "&orgname=" + vo.getFileName();
 			String itemUrlPath = "/upload/"+vo.getServerSubPath()+"/"+vo.getPhysicalName();

 			jnitallimItemVO.setItemUrl(imgFileUrl);
 			jnitallimItemVO.setItemOrigin(vo.getFileName());
 			jnitallimItemVO.setItemUrlPath(itemUrlPath);
		}
    	if(groupCategory.equals("icon")){
    		jnitallimItemVO.setItemExt01(itemIconTitle);
    		jnitallimItemVO.setItemExt02(itemIconComent);
    	}
        jnitallimItemService.updateJnitallimItem(jnitallimItemVO);

        //allimUtil.makeAllimHtml(request, type, groupCategory, grpId);
        jnitallimItemService.makeAllimJSP(request, grpId, groupCategory, type);
        status.setComplete();

        model.addAttribute("type", type);
        model.addAttribute("grpId", grpId);

        return "/jnit/allim/redirect";
    }

    /**
     * 삭제
     * @param jnitallimItemVO
     * @param searchVO
     * @param status
     * @return
     * @throws Exception
     */
    @RequestMapping("/cms/allim/itemDeleteProc.do")
    public String deleteJnitallimItem(
            JnitallimItemVO jnitallimItemVO,
            @ModelAttribute("searchVO") JnitallimItemDefaultVO searchVO, SessionStatus status, HttpServletRequest request, Model model)
            throws Exception {

    	String type = NullUtil.nullString(request.getParameter("type"));
    	String grpId = NullUtil.nullString(request.getParameter("grpId"));

    	String groupCategory = NullUtil.nullString(request.getParameter("groupCategory"));
    	String itemIconTitle = NullUtil.nullString(request.getParameter("itemIconTitle"));
    	String itemIconComent = NullUtil.nullString(request.getParameter("itemIconComent"));


        jnitallimItemService.deleteJnitallimItem(jnitallimItemVO);


        if(groupCategory.equals("icon")){
    		jnitallimItemVO.setItemExt01(itemIconTitle);
    		jnitallimItemVO.setItemExt02(itemIconComent);
    	}
      //  allimUtil.makeAllimHtml(request, type, groupCategory, grpId);
        jnitallimItemService.makeAllimJSP(request, grpId, groupCategory, type);
        model.addAttribute("type", type);
        if(!grpId.equals("")){
        	model.addAttribute("grpId", grpId);
        }
        status.setComplete();

        return "/jnit/allim/redirect";
    }

    /*정렬 순서*/
    @RequestMapping(value="/cms/allim/sortChange.do")
	public String sortChange(HttpServletRequest request, Model model) throws Exception{

		String type = NullUtil.nullString(request.getParameter("type"));
		String groupId = NullUtil.nullString(request.getParameter("grpId"));

		JnitallimItemVO itemVO = new JnitallimItemVO();

		String[] grpId = request.getParameterValues("itemList01[]");
		for(int i=0; i<grpId.length; i++){

			if(grpId[i].replace("itemList01[]=", "") != ""){
				itemVO.setItemId(grpId[i]);
				itemVO.setItemSort(i);
				jnitallimItemService.updateSort(itemVO);
			}
		}

		JnitallimGroupVO groupVO = new JnitallimGroupVO();
		groupVO.setGroupId(groupId);
		try {
			groupVO = jnitallimGroupService.selectJnitallimGroup(groupVO);
//			allimUtil.makeAllimHtml(request, type, groupVO.getGroupCategory(), groupId);
			jnitallimItemService.makeAllimJSP(request, groupId, groupVO.getGroupCategory(), type);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		model.addAttribute("type", type);
		model.addAttribute("grpId", groupId);

		return "";
	}

    @RequestMapping(value="/cms/allim/sortActive.do")
	public String Active(HttpServletRequest request, ModelMap model,
			@ModelAttribute("searchVO") JnitallimItemDefaultVO searchVO) throws Exception{

    	int active = Integer.parseInt(request.getParameter("active"));
    	String type = NullUtil.nullString(request.getParameter("type"));
    	String grpId = NullUtil.nullString(request.getParameter("grpId"));

    	//JSON
    	model.addAllAttributes(JnitallimGroupController.AdminJSON(request, model));

    	if(active == 0){
    		searchVO.setSearchCondition("4");
    		searchVO.setSearchKeyword(grpId);
    	}else if(active == 1){
    		searchVO.setSearchCondition("5");
    		searchVO.setSearchKeyword(grpId);
    	}else{
    		searchVO.setSearchCondition("3");
    		searchVO.setSearchKeyword(grpId);
    	}

    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(100);
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		int totCnt = jnitallimItemService.selectJnitallimItemListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);

    	List resultList = jnitallimItemService.selectJnitallimItemList(searchVO);
    	model.addAttribute("resultList", resultList);

    	JnitallimGroupDefaultVO defaultVO = new JnitallimGroupDefaultVO();
	    defaultVO.setSearchCondition("4");

		List expireList = jnitallimGroupService.selectGroupList(defaultVO);
		HashMap<String, Boolean> expire = new HashMap<String, Boolean>();
			for(int i=0; i<expireList.size(); i++){
				expire.put(expireList.get(i).toString().split(",")[19].trim().replace("itemId=", ""), true);
			}

    	model.addAttribute("paginationInfo", paginationInfo);
    	model.addAttribute("groupId", grpId);
    	model.addAttribute("type", type);
    	model.addAttribute("active", active);
    	model.addAttribute("expire", expire);

    	return "/jnit/allim/item/itemList";
    }

    @RequestMapping("/cms/allim/popup/ajax.do")
    public String popupAjax(HttpServletRequest request, ModelMap model)throws Exception{
    	String root = PathUtil.getRealPath(request);
    	String groupId = NullUtil.nullString(request.getParameter("groupId"));

    	JnitallimGroupVO groupVO = new JnitallimGroupVO();
    	groupVO.setGroupId(groupId);
    	groupVO = jnitallimGroupService.selectJnitallimGroup(groupVO);
    	String groupType = groupVO.getGroupType();
    	JSONObject json = new JSONObject();
    	/*
    	String allimJSONDir = root+"WEB-INF/jsp/jnit/allim/default/"+groupType+"/"+groupType+"JSON.json";
    	File allimFile = new File(allimJSONDir);

    	if(allimFile.exists()){
    		String allimJSON = CmsHandler.readFile(allimJSONDir);
    		json = JSONObject.fromObject(allimJSON);
    		json.put("category", json.get(groupVO.getGroupCategory()).toString());
    	}else{

    	}
    	*/
    	json.put("category", groupVO.getGroupCategory());
    	json.put("height", groupVO.getGroupHeight());
    	json.put("width", groupVO.getGroupWidth());
    	model.addAttribute("json", json.toString());
    	return "/jnit/util/json";
    }

    private String getUploadDir(HttpServletRequest request)throws Exception{
    	Boolean islocal = StringUtil.isExistString(request.getRequestURL().toString(), "local");
    	String root = PathUtil.getRealPath(request);
    	if(islocal){
    		uploadDir = root+"upload";
    		File upload = new File(uploadDir);
    		if(!upload.exists()) upload.mkdirs();
    	}
    	return uploadDir;
    }
}
