package jnit.cms.fileupload;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jnit.util.DownloadUtil;
import jnit.util.StringUtil;

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
@Controller
@RequestMapping("/cms/fileupload/")
public class AttachedFileController {
	private static final Logger LOGGER = LoggerFactory.getLogger(AttachedFileController.class);

	@Resource(name = "attachedFileService")
    private AttachedFileService attachedFileService;

	/**
	 * 특정 파일아이디의 오브젝트 검색
	 * <br>
	 * @public
	 * @param	HttpServletRequest request
	 * @param	HttpServletResponse response
	 * @return	ModelAndView
	 * @throws
	 */
	@RequestMapping(value = "list.do")
	public String list(@RequestParam(required=false) String fileId,
						Model model, HttpServletRequest request) throws Exception {
		
		try{
		} catch (NullPointerException e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}catch(Exception e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}

        return "/jnit/fileupload/upload";
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
	@RequestMapping(value = "deleteFile.do")
	public String deleteFile(@RequestParam(required=false) String fileId,
															Model model, HttpServletRequest request) throws Exception {
		AttachedFileVO attachedFileVO = new AttachedFileVO();
		
		try{
			if(fileId!=null && !StringUtil.equals(fileId, "")){
				attachedFileVO.setFileId(fileId);
				attachedFileService.deleteAttachedFile(attachedFileVO);
			}
		} catch (NullPointerException e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}catch(Exception e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}

        return "jsonView";
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
	@RequestMapping(value = "getAttachedFileInfo.do")
	public String getAttachedFileInfo(@RequestParam(required=false) String fileId,
															Model model, HttpServletRequest request) throws Exception {
		AttachedFileVO attachedFileVO = new AttachedFileVO();
		
		try{
			if(fileId!=null && !StringUtil.equals(fileId, "")){
				attachedFileVO.setSearchFileId(fileId);
				attachedFileVO = attachedFileService.getAttachedFile(attachedFileVO);
			}
		} catch (NullPointerException e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}catch(Exception e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}

		model.addAttribute("attachedFileVO", attachedFileVO);
        return "jsonView";
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
	@RequestMapping(value = "getAttachedFileInfoList.do")
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

		model.addAttribute("attachedFileVOList", attachedFileVOList);
		return "jsonView";
	}

	

	@RequestMapping(value = "fileDownload")
	public void fileDownload(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LoggerFactory.getLogger(AttachedFileController.class).debug("fileDownload start");

		String[] arrFileId = request.getParameterValues("fileId");
		if(arrFileId==null || arrFileId.length<=0){
			arrFileId = new String[1];
			arrFileId[0] = request.getParameter("fileId");
		}

		AttachedFileVO attachedFileVO = new AttachedFileVO();
		
		try{
			List<File> files = new ArrayList<File>();
			List<String> viewFileName = new ArrayList<String>();

			for(String fileId : arrFileId){
				if(fileId!=null && !StringUtil.equals(fileId, "")){
					attachedFileVO.setSearchFileId(fileId);
					attachedFileVO = attachedFileService.getAttachedFile(attachedFileVO);
				}

				File file = new File(attachedFileVO.getPhsicalDir()+attachedFileVO.getPhsicalFileName());
				files.add(file);
				viewFileName.add(attachedFileVO.getViewFileName());

				//Thread t = new Thread(new DownloadUtil(request, response, file, attachedFileVO.getViewFileName()));
				//t.start();

				DownloadUtil.download(request, response, file, attachedFileVO.getViewFileName());
				//LOGGER.debug("fileId : "+fileId);
			}

			//DownloadUtil.download(request, response, files, viewFileName);
		} catch (IOException e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}catch(Exception e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}
	}

	/**
	 * 파일 다운로드
	 * <br>
	 * @public
	 * @param	HttpServletRequest request
	 * @param	HttpServletResponse response
	 * @return	ModelAndView
	 * @throws
	 */
	@RequestMapping(value = "fileDownloadAjax")
	public String fileDownloadAjax(@RequestParam(required=false) String fileId,
									Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LoggerFactory.getLogger(AttachedFileController.class).debug("fileDownloadAjax start");

		AttachedFileVO attachedFileVO = new AttachedFileVO();
		
		try{
			if(fileId!=null && !StringUtil.equals(fileId, "")){
				attachedFileVO.setSearchFileId(fileId);
				attachedFileVO = attachedFileService.getAttachedFile(attachedFileVO);
			}

			File file = new File(attachedFileVO.getPhsicalDir()+attachedFileVO.getPhsicalFileName());

			DownloadUtil.download(request, response, file, attachedFileVO.getViewFileName());

			model.addAttribute("retStr", "success");
		} catch (IOException e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
			model.addAttribute("retStr", "fail");
		}catch(Exception e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
			model.addAttribute("retStr", "fail");
		}

		return "jsonView";
	}
}
