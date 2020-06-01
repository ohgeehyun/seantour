package jnit.board.file;

import java.io.File;
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

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import jnit.cms.fileupload.AttachedFileService;
import jnit.cms.fileupload.AttachedFileVO;
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
@RequestMapping("/board/fileupload/")
public class AttachedFileBoardController {
	private static final Logger LOGGER = LoggerFactory.getLogger(AttachedFileBoardController.class);
	public static final String SEPERATOR = File.separator;
	private static final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
	public static final String BOARD_UPLOAD_PATH = uploadDir + SEPERATOR + "board" + SEPERATOR;
	@Resource(name = "attachedFileService")
    private AttachedFileService attachedFileService;
	
	@Resource(name = "jnitboardfileService")
	private JnitboardfileService fileService;
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

        return "/jnit/board/fileupload/upload";
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
		JnitboardfileVO fileVO = new JnitboardfileVO();
		
		try{
			if(fileId!=null && !StringUtil.equals(fileId, "")){
				fileVO.setFileId(fileId);
				fileService.deleteJnitboardfile(fileVO);
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
		JnitboardfileVO fileVO = new JnitboardfileVO();
		try{
			if(fileId!=null && !StringUtil.equals(fileId, "")){
				fileVO.setFileId(fileId);
				fileVO = fileService.selectJnitboardfile(fileVO);
				
			}
		} catch (NullPointerException e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}catch(Exception e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}
		System.out.println(fileVO);
		model.addAttribute("fileVO", fileVO);
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
	public String getAttachedFileInfoList(@RequestParam(required=false) String boardId,String cntId,
															Model model, HttpServletRequest request) throws Exception {
		//List<AttachedFileVO> attachedFileVOList = null;
		//AttachedFileVO attachedFileVO = new AttachedFileVO();
		List fileList = null;
		System.out.println(boardId);
		System.out.println(cntId);
		try{
			if(cntId!=null && !NullUtil.nullString(cntId).equals("") && !cntId.equals("new")){
				//attachedFileVO.setSearchFileId(fileId);
				//attachedFileVOList = attachedFileService.getAttachedFileList(attachedFileVO);
				JnitboardfileVO fileVO = new JnitboardfileVO();
				fileVO.setBoardId(boardId);
				fileVO.setBoardCntId(Integer.parseInt(cntId));
				/*if(localVO.getBoardinfoVO().getBoardType().contains("gallery")
					|| localVO.getBoardinfoVO().getBoardType().contains("movie")
					|| localVO.getBoardinfoVO().getBoardType().contains("movieLink")
					|| localVO.getBoardinfoVO().getBoardType().contains("thumbnail")){
					fileVO.setMainFileYn("N");				
				}*/
				fileVO.setMainFileYn("N");
				fileVO.setBoardIdYn("Y");
				fileVO.setBoardCntIdYn("Y");
				fileList = fileService.selectJnitboardfileList(fileVO);
				
				
			}
		} catch (NullPointerException e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}catch(Exception e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}

		model.addAttribute("fileList", fileList);
		return "jsonView";
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
	
	@RequestMapping(value = "fileDownload")
	public void fileDownload(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LoggerFactory.getLogger(AttachedFileBoardController.class).debug("fileDownload start");

		String fileId = NullUtil.nullString(request.getParameter("fileId"));
		JnitboardfileVO fileVO = new JnitboardfileVO();
		
		try{
			fileVO.setFileId(fileId);
			fileVO = fileService.selectJnitboardfile(fileVO);
			String varUploadDir = BOARD_UPLOAD_PATH;
			String subPath = fileVO.getBoardId()  + SEPERATOR + fileVO.getFilePath();
			String physical = fileVO.getFileNm();
			
			jnit.board.JnitboardFileController.downloadFileExec(request, response, varUploadDir, subPath, physical, fileVO.getFileOnm());
		} catch (NullPointerException e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}catch(Exception e){
			LOGGER.error(StringUtil.getlogText("getAttachedFileInfo error", e));
		}
	}
}
