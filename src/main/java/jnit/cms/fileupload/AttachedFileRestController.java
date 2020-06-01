package jnit.cms.fileupload;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import jnit.util.FileUploadUtil;
import jnit.util.MessageUtil;
import jnit.util.StringUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;

/**
 * @Class Name : AttachedFileController.java
 * @Description : AttachedFile Controller class
 * @Modification Information
 *
 * @author YDH
 * @since 2016-08-12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@RestController
@RequestMapping("/cms/attachedFile/")
public class AttachedFileRestController {
	private static final Logger LOGGER = LoggerFactory.getLogger(AttachedFileRestController.class);

	@Resource(name = "attachedFileService")
    private AttachedFileService attachedFileService;

	@RequestMapping(value="attachFileUpload.do", produces="text/html")
	@ResponseBody
	public String attachFileUpload(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOGGER.debug("attachFileUpload start");

		String retStr = "{\"code\":\"2\", \"msg\":\"file upload fail.\"}";

		try{
			List<EgovFormBasedFileVo> uploadFileList = FileUploadUtil.uploadFiles(request,
																			MessageUtil.getMessage("Globals.upload.dir"),
																			5000*1000000);
	
			if(uploadFileList!=null && uploadFileList.size()>0){
				String attachedFileId = "";
				AttachedFileVO vo = null;
				for(EgovFormBasedFileVo egovFormBasedFileVo : uploadFileList){
					vo = new AttachedFileVO();
					vo.setPhsicalDir(MessageUtil.getMessage("Globals.upload.dir")+"/"+egovFormBasedFileVo.getServerSubPath()+"/");
					vo.setViewFileName(egovFormBasedFileVo.getFileName());
					vo.setPhsicalFileName(egovFormBasedFileVo.getPhysicalName());
					vo.setFileSize(egovFormBasedFileVo.getSize());

					attachedFileService.insertAttachedFile(vo);
					attachedFileId = StringUtil.toString(vo.getFileId());
				}
				retStr = "{\"code\":\"1\", \"fileId\":\""+attachedFileId+"\", \"src\":\""+vo.getPhsicalFileName()+"\", \"fileName\":\""+vo.getViewFileName()+"\"}";
			}else{
				retStr = "{\"code\":\"2\", \"msg\":\"file does not uploaded.\"}";
			}
		} catch (NullPointerException e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}catch(Exception e){
			LOGGER.error(StringUtil.getlogText("attachFileUpload error", e));
			retStr = "{\"code\":\"2\", \"msg\":\"file upload fail.\"}";
		}

		return retStr;
	}

	/**
	 * 특정 파일아이디의 오브젝트 검색
	 * <br>
	 * @public
	 * @param	HttpServletRequest request
	 * @param	HttpServletResponse response
	 * @return	ModelAndView
	 * @throws
	 */
	@RequestMapping(value = "getAttachedFileInfo.do", produces="text/html")
	@ResponseBody
	public String getAttachedFileInfo(@RequestParam(required=false) String fileId,
															Model model, HttpServletRequest request) throws Exception {
		AttachedFileVO attachedFileVO = new AttachedFileVO();
		
		try{
			if(fileId!=null && !StringUtil.equals(fileId, "")){
				attachedFileVO.setSearchFileId(fileId);
				attachedFileVO = attachedFileService.getAttachedFile(attachedFileVO);
				if(attachedFileVO!=null){
					attachedFileVO.setPhsicalFileName(attachedFileVO.getPhsicalFileName());
				}
			}
		} catch (NullPointerException e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}catch(Exception e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}

		com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
		return mapper.writeValueAsString(attachedFileVO);
	}

	/**
	 * 특정 파일아이디의 오브젝트 검색
	 * <br>
	 * @public
	 * @param	HttpServletRequest request
	 * @param	HttpServletResponse response
	 * @return	ModelAndView
	 * @throws
	 */
	@RequestMapping(value = "getAttachedFileInfoList.do", produces="text/html")
	@ResponseBody
	public String getAttachedFileInfoList(@RequestParam(required=false) String fileId,
															Model model, HttpServletRequest request) throws Exception {
		List<AttachedFileVO> attachedFileVOList = null;
		AttachedFileVO attachedFileVO = new AttachedFileVO();

		try{
			if(fileId!=null && !StringUtil.equals(fileId, "")){
				attachedFileVO.setSearchFileId(fileId);
				attachedFileVOList = attachedFileService.getAttachedFileList(attachedFileVO);
			}
		} catch (NullPointerException e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}catch(Exception e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}

		com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
		return mapper.writeValueAsString(attachedFileVOList);
	}
}
