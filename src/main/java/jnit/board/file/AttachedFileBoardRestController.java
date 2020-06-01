package jnit.board.file;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
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

import jnit.board.info.JnitboardinfoService;
import jnit.board.info.JnitboardinfoVO;
import jnit.cms.fileupload.AttachedFileService;
import jnit.cms.fileupload.AttachedFileVO;
import jnit.util.FileUploadUtil;
import jnit.util.MessageUtil;
import jnit.util.StringUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;

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
@RequestMapping("/board/attachedFile/")
public class AttachedFileBoardRestController {
	private static final Logger LOGGER = LoggerFactory.getLogger(AttachedFileBoardRestController.class);
	private static final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
	public static final String SEPERATOR = File.separator;
    public static final String BOARD_INFO_PATH = "board" + SEPERATOR + "_info" + SEPERATOR;
    public static final String BOARD_UPLOAD_PATH = uploadDir + SEPERATOR + "board" + SEPERATOR;
    
    @Resource(name = "jnitboardinfoService")
	private JnitboardinfoService infoService;
    
	@Resource(name = "attachedFileService")
    private AttachedFileService attachedFileService;

	@Resource(name = "jnitboardfileService")
	private JnitboardfileService fileService;
	
	@RequestMapping(value="attachFileUpload.do", produces="text/html")
	@ResponseBody
	public String attachFileUpload(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOGGER.debug("attachFileUpload start");

		String retStr = "{\"code\":\"2\", \"msg\":\""+URLEncoder.encode("해당 파일은 업로드 하실 수 없습니다" , "UTF-8")+"\"}";
		JnitboardfileVO fileVO = new JnitboardfileVO();
		try{
			String boardId = NullUtil.nullString(request.getParameter("boardId"));
			int cntId = NullUtil.nullInt(request.getParameter("cntId"));
			String upPath = BOARD_UPLOAD_PATH+SEPERATOR+boardId;
			JnitboardinfoVO jnitboardinfoVO = new JnitboardinfoVO();
			jnitboardinfoVO.setBoardId(boardId);
			jnitboardinfoVO = infoService.selectJnitboardinfo(jnitboardinfoVO);
			
			HashMap<String, EgovFormBasedFileVo> fileList = EgovFileUploadUtil.uploadFormFiles(request, upPath, jnitboardinfoVO.getFileLimitSize()*1000000);//MB
			Iterator fileItr = fileList.keySet().iterator();
			
			int sortKey = 1;
			while(fileItr.hasNext()){
				String key = (String)fileItr.next();
				EgovFormBasedFileVo item = (EgovFormBasedFileVo)fileList.get(key);
				fileVO = new JnitboardfileVO();
				fileVO.setBoardId(boardId);
				fileVO.setBoardCntId(cntId);
				fileVO.setFileNm(item.getPhysicalName());
				fileVO.setFileOnm(item.getFileName());
				fileVO.setFilePath(item.getServerSubPath());
				fileVO.setFileSize(item.getSize());
				String attachedFileId = fileService.insertJnitboardfile(fileVO);
				
				retStr = "{\"code\":\"1\", \"fileId\":\""+attachedFileId+"\", \"src\":\""+item.getPhysicalName()+"\", \"fileName\":\""+item.getFileName()+"\", \"fileSize\":\""+item.getSize()+"\"}";
				
			}
			fileList = null;
		} catch (NullPointerException e){
			LOGGER.error(StringUtil.getlogText("attachFileUpload error", e));
			retStr = "{\"code\":\"2\", \"msg\":\""+URLEncoder.encode("해당 파일은 업로드 하실 수 없습니다" , "UTF-8")+"\"}";
		}catch(Exception e){
			LOGGER.error(StringUtil.getlogText("attachFileUpload error", e));
			retStr = "{\"code\":\"2\", \"msg\":\""+URLEncoder.encode("해당 파일은 업로드 하실 수 없습니다" , "UTF-8")+"\"}";
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
		//AttachedFileVO attachedFileVO = new AttachedFileVO();
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

		com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
		return mapper.writeValueAsString(fileVO);
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
	public String getAttachedFileInfoList(@RequestParam(required=false) String boardId,String cntId,
															Model model, HttpServletRequest request) throws Exception {
		List fileList = null;
		System.out.println(boardId);
		System.out.println(cntId);
		try{
			if(cntId!=null && !NullUtil.nullString(cntId).equals("")){
				JnitboardfileVO fileVO = new JnitboardfileVO();
				fileVO.setBoardId(boardId);
				fileVO.setBoardCntId(Integer.parseInt(cntId));
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

		com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
		return mapper.writeValueAsString(fileList);
	}
}
