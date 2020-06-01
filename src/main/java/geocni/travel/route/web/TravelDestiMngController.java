package geocni.travel.route.web;

import java.io.File;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.common.files.domain.TravelFiles;
import geocni.travel.common.files.service.TravelFilesService;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.service.TravelDestinationService;
import geocni.travel.route.service.TravelRouteService;
import jnit.cms.AdminUtil;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.mgov.module.JnitMgovUtil;
import jnit.util.PathUtil;

@Controller
@SessionAttributes(types=TravelDestination.class)
@RequestMapping(value="/cms/travel/destination/")
public class TravelDestiMngController {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "travelRouteService")
    private TravelRouteService routeService;

    @Resource(name = "travelDestinationService")
    private TravelDestinationService destService;

    @Resource(name = "travelFilesService")
    private TravelFilesService travelFilesService;
    
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	@Resource(name="egovMessageSource")
    private EgovMessageSource msgSrc;
    
    @SuppressWarnings("unused")
	@Autowired
    private DefaultBeanValidator beanValidator;

    private long maxFileSize = 1024 * 1024 * 10;
	
	private String skinPath = "travel/destination/mng/";

	private @ModelAttribute("travelDestination") 
	TravelDestination selectTravelDestination(
			TravelDestination travelDestination) throws Exception {
		
		return travelDestination = destService.selectTravelDestination(travelDestination);
	}
	
	@RequestMapping(value="list.do")
	public String travelDestinationList(
			 @ModelAttribute("searchVO") TravelDefaultVO searchVO
			,TravelDestination travelDestination
            ,SessionStatus status
			,Model model) throws Exception {
		
		List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
		model.addAttribute("regionList", regionList);
		
		travelDestination.setPageUnit(propertiesService.getInt("pageUnit"));
		travelDestination.setPageSize(propertiesService.getInt("pageSize"));

		model.addAllAttributes(destService.selectTravelDestinationListMap(travelDestination));
		status.setComplete();

        model.addAttribute("travelDestination", travelDestination);
		
		return skinPath + "list";
	}

    @RequestMapping(value="register.do")
    public String registerTravelDestination(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
    		,TravelDestination travelDestination
            ,HttpServletRequest req
    		,ModelMap model) throws Exception {
    	
    	try{

    		String type = NullUtil.nullString(req.getParameter("type"));
	    	String grpId = NullUtil.nullString(req.getParameter("grpId"));

	    	//JSON
	    	model.addAllAttributes(AdminJSON(req, model));

			List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
			model.addAttribute("regionList", regionList);
			
			if(!model.containsAttribute("travelDestination")) {
				model.addAttribute("travelDestination", new TravelDestination());
			}

	        model.addAttribute("type", type);
	        model.addAttribute("grpId", grpId);

    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
    	
    	return skinPath + "register";
    }

    @RequestMapping(value="insert.do", method=RequestMethod.POST)
    public String insertTravelDestination(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
     		,@ModelAttribute("travelDestination") TravelDestination travelDestination
            ,BindingResult bindingResult
            ,SessionStatus status
            ,HttpServletRequest request
    		,Model model) throws Exception {
    	
		try {
			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			travelDestination.setDestWriter(loginVO.getMbrId());

			/******** 파일업로드 ********/
			String uploadDir = "/upload/travel/destination";
	    	String root = PathUtil.getRealPath(request);
	    	String fileDir = root + uploadDir;
			
        	HashMap<String, EgovFormBasedFileVo> files = null;
    		EgovFileUploadUtil.type = "noSubPath";
        	files = EgovFileUploadUtil.uploadFormFiles(request, fileDir, maxFileSize);
            /**** 멀티파일업로드 위해 코드 수정 ********
            if(files.get("upfile") != null){
            	EgovFormBasedFileVo vo = files.get("upfile");

            	String filePathUrl = uploadDir+"/"+vo.getPhysicalName();
            	travelDestination.setDestImgPath(filePathUrl);
            }***********************************************************/
            EgovFileUploadUtil.type = null;
			/******** 파일업로드 ********/
			
			destService.insertTravelDestination(travelDestination, files);

		} catch (Exception e) {
			e.printStackTrace();
		}
		status.setComplete();
		
		return "redirect:/cms/travel/destination/list.do";
    }

    @RequestMapping(value="modify.do")
    public String modifyTravelDestination(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
 			,TravelDestination travelDestination
            ,HttpServletRequest req
    		,ModelMap model) throws Exception {
    	
    	try{

    		String type = NullUtil.nullString(req.getParameter("type"));
	    	String grpId = NullUtil.nullString(req.getParameter("grpId"));

	    	//JSON
	    	model.addAllAttributes(AdminJSON(req, model));

			List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
			model.addAttribute("regionList", regionList);
			
			travelDestination = destService.selectTravelDestinationDetail(travelDestination);
	        model.addAttribute("travelDestination", travelDestination);

	        model.addAttribute("type", type);
	        model.addAttribute("grpId", grpId);

    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
    	
    	return skinPath + "register";
    }

    @RequestMapping(value="update.do", method=RequestMethod.POST)
    public String updateTravelDestination(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
      		,@ModelAttribute("travelDestination") TravelDestination travelDestination
            ,BindingResult bindingResult
            ,SessionStatus status
            ,HttpServletRequest request
    		,Model model) throws Exception {
    	
    		try {

    			/******** 파일업로드 ********/
    			String uploadDir = "/upload/travel/destination";
    	    	String root = PathUtil.getRealPath(request);
    	    	String fileDir = root + uploadDir;
    			
            	HashMap<String, EgovFormBasedFileVo> files = null;
        		EgovFileUploadUtil.type = "noSubPath";
        		files = EgovFileUploadUtil.uploadFormFiles(request, fileDir, maxFileSize);
                /**** 멀티파일업로드 위해 코드 수정 ********
                if(files.get("upfile") != null){
                	//원본파일 삭제
                	File file = new File(root + travelDestination.getDestImgPath());
                	if(file.exists()){
                		file.delete();
                	}

                	EgovFormBasedFileVo vo = files.get("upfile");
                	//상대경로
                	String filePathUrl = uploadDir+"/"+vo.getPhysicalName();
                	travelDestination.setDestImgPath(filePathUrl);
            	}***********************************************************/
        		List<TravelFiles> oldFileList = travelDestination.getTravelFileList();
            	if(!files.isEmpty()) {
        	    	List<TravelFiles> fileList = new ArrayList<>();
//        			String uploadDir = "/upload/travel/destination";
        	    	Iterator<String> keys = files.keySet().iterator();
        	    	int serialNo = oldFileList.size();
        	        while(keys.hasNext()) {
        	            String key = keys.next();
        	
        	            EgovFormBasedFileVo fileVo = files.get(key);
        	            String filePathUrl = uploadDir+"/"+fileVo.getPhysicalName();
        	            int idx = Integer.valueOf(key.split("_")[1]);
        	            
        	            TravelFiles travelFile = new TravelFiles();
        	            travelFile.setImgRefId(travelDestination.getDestId());
        	            travelFile.setImgFileNo(serialNo);
        	            travelFile.setImgFileName(fileVo.getFileName());
        	            travelFile.setImgFilePath(filePathUrl);
        	            travelFile.setImgFileSize(fileVo.getSize());
        	            travelFile.setImgFileExt(fileVo.getContentType());
        	            
        	            if(oldFileList.size() > idx) {
        	            	TravelFiles oldFile = oldFileList.get(idx);
        	            	//원본파일 삭제
        	            	File file = new File(root + oldFile.getImgFilePath());
        	            	if(file.exists()){
        	            		file.delete();
        	            	}
        	            	travelFile.setImgFileNo(idx);
        	            	travelFilesService.updateTravelFiles(travelFile);
        	            } else {
        	            	fileList.add(travelFile);
        	            }
        	        	serialNo++;
        	        }

        	        if(fileList.size() > 0) {
        	        	travelFilesService.insertTravelFiles(fileList);
        	        }
            	}
        		EgovFileUploadUtil.type = null;
    			/******** 파일업로드 ********/
    			
    			destService.updateTravelDestination(travelDestination);

			} catch (Exception e) {
				e.printStackTrace();
			}
			
    		status.setComplete();
    		
    		return "redirect:/cms/travel/destination/list.do";
    }
    
    @RequestMapping(value="delete.do", method=RequestMethod.POST)
    public String deleteTravelRoute(
    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
     		,TravelDestination travelDestination
            ,SessionStatus status
            ,HttpServletRequest request
    		,Model model) throws Exception {
    	
    		try {
    			//첨부파일 삭제
    			String realPath = PathUtil.getRealPath(request);
    			travelDestination = destService.selectTravelDestination(travelDestination);
    			if(travelDestination.getTravelFileList().size() > 0) {
    				travelFilesService.deleteTravelFilesPhysically(travelDestination.getTravelFileList(), realPath);
    			}
            	File file = new File(realPath + travelDestination.getDestImgPath());
            	if(file.exists()){
            		file.delete();
            	}
    			
    			destService.deleteTravelDestinationPhysically(travelDestination);

			} catch (Exception e) {
				e.printStackTrace();
			}
			
            status.setComplete();
    		return "redirect:/cms/travel/destination/list.do";
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

}
