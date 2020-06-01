/**
 * @version 3.2.0.1
 */
package jnit.board;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.net.util.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.com.utl.fcc.service.ThumbnailUtil;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import jnit.board.db.JnitboarddbService;
import jnit.board.file.JnitboardfileService;
import jnit.board.file.JnitboardfileVO;
import jnit.board.info.JnitboardinfoController;
import jnit.board.info.JnitboardinfoService;
import jnit.board.info.JnitboardinfoVO;
import jnit.cms.CmsHelper;
import jnit.cms.handler.CmsHandler;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.com.util.Punycode;
import jnit.db.JnitdbService;
import jnit.db.JnitdbVO;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;

@Controller
public class JnitboardFileController {
	
	private static Log log = LogFactory.getLog(JnitboardFileController.class);
	
	@Resource(name = "jnitboardinfoService")
	private JnitboardinfoService infoService;

	@Resource(name = "jnitboarddbService")
	private JnitboarddbService jnitboarddbService;

	@Resource(name = "jnitboardfileService")
	private JnitboardfileService fileService;

	@Resource(name = "jnitboardfileService")
    private JnitboardfileService jnitboardfileService;

	@Resource(name = "jnitboardinfoService")
	private JnitboardinfoService jnitboardinfoService;

	@Resource(name = "jnitdbService")
	private JnitdbService dbService;
	private static final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    public static final String SEPERATOR = File.separator;
    public static final String BOARD_LATEST_PATH = "board" + SEPERATOR + "_latest" + SEPERATOR;
    public static final String BOARD_UPLOAD_PATH = uploadDir + SEPERATOR + "board" + SEPERATOR;
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    public static final int BUFFER_SIZE = 8192;
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");

    /**
     * board_id : Board ID (Required)
     * fields : filed names for import (Seperator : , )(default : title,created)
     * count : Number for import articles
     * type : View Type
     * base_path : content page Base URL
     * wrap_class : view Wraper CSS Class
     * */
	@RequestMapping(value = "/board/file/{boardId}/{cntId}/{fileId}/{fileNm}")
	public void file(
			@PathVariable("boardId") String boardId,
			@PathVariable("cntId") int cntId,
			@PathVariable("fileId") String fileId,
			@PathVariable("fileNm") String fileNm,
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
	throws Exception {
		JSONObject JSON = new JSONObject();
		String mgmtId = "";
		String type = "";
		Boolean maxDimThumbnail = false;
		Boolean useThumb = false;
		int width = 0;
		int height = 0;
		int maxdim = 0;
		JnitboardinfoVO jnitboardinfoVO = new JnitboardinfoVO();
		jnitboardinfoVO = getJnitboardInfoVO(request, boardId);

		if(StringUtil.isExistString(fileNm, "thumb_")){
			maxdim = jnitboardinfoVO.getThumbMaxdim();
			type = "thumb_"+maxdim+"_";
			useThumb = true;
			maxDimThumbnail = true;
		}else if(StringUtil.isExistString(fileNm, "MGMT_")){
			mgmtId = fileNm.substring(0, 15);
			JSON = boardLatestJSON(request, mgmtId);
			width = JSON.getInt("thumbWidth");
			height = JSON.getInt("thumbHeight");
			type = mgmtId+"_"+width+"_"+height+"_";
			useThumb = true;
		}else if(StringUtil.isExistString(fileNm, "list_")){
			width = jnitboardinfoVO.getThumbWidth();
			height = jnitboardinfoVO.getThumbHeight();
			type="list_"+width+"_"+height+"_";
			useThumb = true;
		}
		if(!useThumb){
			if(!"".equals(NullUtil.nullString(request.getParameter("thumb")))){
				useThumb = true;
			}
		}



		JnitboardfileVO jnitboardfileVO = new JnitboardfileVO();
		jnitboardfileVO.setFileId(fileId);
		jnitboardfileVO.setBoardId(boardId);
		jnitboardfileVO.setBoardCntId(cntId);
		String realPath = PathUtil.getRealPath(request);
		try{
			jnitboardfileVO = jnitboardfileService.selectJnitboardfile(jnitboardfileVO);
		}catch(EgovBizException e){
			downloadFileExec(request, response, realPath, "images", "nofile.gif", "FileNotFound.gif");
			return;
		}

		JSONObject JSONCHECK = new JSONObject();
    	LocalVO localVO = new LocalVO();
    	JnitboardinfoVO boardInfoVO = new JnitboardinfoVO();
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);

    	if(!useThumb){
    		try {
        		boardInfoVO.setBoardId(jnitboardfileVO.getBoardId());
        		boardInfoVO = infoService.selectJnitboardinfo(boardInfoVO);
        		localVO.setBoardinfoVO(boardInfoVO);
        		localVO.setLoginVO(loginVO);
        		String[] adminLVs = localVO.getBoardinfoVO().getAdmList().toUpperCase().replaceAll("'", "").split(",");
        		String adminLV = "";
        		for (int i = 0; i < adminLVs.length; i++) {
        			if (!adminLVs[i].isEmpty()) {
        				adminLV = adminLV + "," + "'" + adminLVs[i].toString()+ "'";
        			}
        		}
        		adminLV = adminLV.replaceFirst(",", "");
        		//게시판 권한설정
        		localVO = boardAccess(request, model, localVO, adminLV);
    			if(!localVO.getPermFileDown()){
    				if(loginVO.getMbrId() == null && !"".equals(NullUtil.nullString(localVO.getBoardinfoVO().getPermFileDown()))){
            			JSON.put("message", "FIAL 2");
        			}else{
        				JSON.put("message", "FIAL 1");
        			}
        			model.addAttribute("json", JSONCHECK.toString());
        			return;
        		}
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
    	}
		String fileOnm = jnitboardfileVO.getFileOnm();
		String varUploadDir = BOARD_UPLOAD_PATH;
		String subPath = boardId  + SEPERATOR + jnitboardfileVO.getFilePath();
		String physical = jnitboardfileVO.getFileNm();
		String attachFilePath = varUploadDir + SEPERATOR + subPath + SEPERATOR + physical;
		java.io.File attachFile = new File(attachFilePath);
		if(useThumb){
			String thumbFilePath = varUploadDir + SEPERATOR + subPath + SEPERATOR +type+ physical;
			java.io.File thumbFile = new File(thumbFilePath);
			if(!thumbFile.exists()){
				try {
					if(maxDimThumbnail){
						ThumbnailUtil.createThumbnail(attachFilePath, thumbFile.getPath(), maxdim);
					}else{
						ThumbnailUtil.createThumbnail(attachFilePath, thumbFilePath, width, height);
					}
					thumbFile = new File(thumbFilePath);
				} catch (NullPointerException e){
					if("true".equals(deDug)) log.debug(e.getMessage());
					downloadFileExec(request, response, realPath, "images", "nofile.gif", "FileNotFound.gif");
					return;
				} catch (Exception e) {
					if("true".equals(deDug)) log.debug(e.getMessage());
					downloadFileExec(request, response, realPath, "images", "nofile.gif", "FileNotFound.gif");
					return;
				}
			}
			physical = type+physical;
		}

		if(!attachFile.exists()){
			varUploadDir = realPath;
			subPath = "images";
			physical = "nofile.gif";
		}

		String escape = "";
		if(SEPERATOR.equals("\\")) escape = "\\";
    	if(subPath.replaceAll(boardId  + escape + SEPERATOR, "").substring(0, 6).equals("../old")){
    		subPath = subPath.replaceAll(boardId  + escape + SEPERATOR + "\\.\\./", "");
    	}

		downloadFileExec(request, response, varUploadDir, subPath, physical, fileOnm);

	}

	@RequestMapping(value = "/board/fileCodeView.do")
	public void file(
			@RequestParam("code") String code,
			@RequestParam("type") String type,
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
	throws Exception {
		JSONObject JSON = new JSONObject();
		String mgmtId = "";
		Boolean maxDimThumbnail = false;
		Boolean useThumb = false;
		int width = 0;
		int height = 0;
		int maxdim = 0;

		JnitboardfileVO jnitboardfileVO = new JnitboardfileVO();
		String realPath = PathUtil.getRealPath(request);
		try{
			jnitboardfileVO = jnitboardfileService.decrypt(code);
		} catch (NullPointerException e){
			downloadFileExec(request, response, realPath, "images", "nofile.gif", "FileNotFound.gif");
			return;
		}catch(EgovBizException e){
			downloadFileExec(request, response, realPath, "images", "nofile.gif", "FileNotFound.gif");
			return;
		}

		JnitboardinfoVO jnitboardinfoVO = new JnitboardinfoVO();
		jnitboardinfoVO = JnitboardinfoController.getBoardInfoVO(request, jnitboardfileVO.getBoardId());
		width = jnitboardinfoVO.getThumbWidth();
		height = jnitboardinfoVO.getThumbHeight();
		maxdim = jnitboardinfoVO.getThumbMaxdim();

		if(StringUtil.isExistString(type, "thumb")){
			type = "thumb_"+maxdim+"_";
			useThumb = true;
			maxDimThumbnail = true;
		}else if(StringUtil.isExistString(type, "MGMT")){
			mgmtId = type.substring(0, 15);
			JSON = boardLatestJSON(request, mgmtId);
			width = JSON.getInt("thumbWidth");
			height = JSON.getInt("thumbHeight");
			type = mgmtId+"_"+width+"_"+height+"_";
			useThumb = true;
		}else if(StringUtil.isExistString(type, "list")){
			type="list_"+width+"_"+height+"_";
			useThumb = true;
		}
		if(!useThumb){
			if(!"".equals(NullUtil.nullString(request.getParameter("thumb")))){
				useThumb = true;
			}
		}
		String fileOnm = jnitboardfileVO.getFileOnm();
		String varUploadDir = BOARD_UPLOAD_PATH;
		String subPath = jnitboardfileVO.getBoardId()  + SEPERATOR + jnitboardfileVO.getFilePath();
		String physical = jnitboardfileVO.getFileNm();
		String attachFilePath = varUploadDir + subPath + SEPERATOR + physical;
		java.io.File attachFile = new File(attachFilePath);

		if(useThumb){
			String thumbFilePath = varUploadDir + subPath + SEPERATOR +type+ physical;
			java.io.File thumbFile = new File(thumbFilePath);
			if(!thumbFile.exists()){
				try {
					if(maxDimThumbnail){
						ThumbnailUtil.createThumbnail(attachFilePath, thumbFile.getPath(), maxdim);
					}else{
						ThumbnailUtil.createThumbnail(attachFilePath, thumbFilePath, width, height);
					}
					thumbFile = new File(thumbFilePath);
				} catch (NullPointerException e){
					if("true".equals(deDug)) log.debug(e.getMessage());
					downloadFileExec(request, response, realPath, "images", "nofile.gif", "FileNotFound.gif");
					return;
				} catch (Exception e) {
					if("true".equals(deDug)) log.debug(e.getMessage());
					downloadFileExec(request, response, realPath, "images", "nofile.gif", "FileNotFound.gif");
					return;
				}
			}
			physical = type+physical;
		}

		if(!attachFile.exists()){
			varUploadDir = realPath;
			subPath = "images";
			physical = "nofile.gif";
		}
		downloadFileExec(request, response, varUploadDir, subPath, physical, fileOnm);

	}

	public static String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        } else if(header.indexOf("rv:11.0") > -1){
        	return "IE11";
        }
        return "Firefox";
    }

	public static String getDisposition(String filename, String browser)throws Exception {
        String encodedFilename = null;
        if (browser.equals("MSIE")) {
        	/*
            encodedFilename = URLEncoder.encode(filename, "UTF-8")
                    .replaceAll("\\+", "%20");
            */
        	filename = filename.replaceAll("\r", "").replaceAll("\n", "");

        	filename =  java.net.URLDecoder.decode(filename, "8859_1");
        	filename =  java.net.URLEncoder.encode(filename, "UTF-8");

        	encodedFilename = filename.replaceAll("\\+", " ");


        } else if (browser.equals("Firefox")) {
            encodedFilename =
         "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.equals("Opera")) {
            encodedFilename =
         "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.equals("Chrome")) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < filename.length(); i++) {
                char c = filename.charAt(i);
                if (c > '~') {
                    sb.append(URLEncoder.encode("" + c, "UTF-8"));
                } else {
                    sb.append(c);
                }
            }
            encodedFilename = sb.toString();
        } else if (browser.equals("IE11")) {
        	filename = filename.replaceAll("\r", "").replaceAll("\n", "");

        	filename =  java.net.URLEncoder.encode(filename, "utf-8");

        	encodedFilename = filename.replaceAll("\\+", " ");
        }else {
            //throw new RuntimeException("Not supported browser");
        	//else가 들어와도 ie 처럼 처리
        	filename = filename.replaceAll("\r", "").replaceAll("\n", "");

        	filename =  java.net.URLDecoder.decode(filename, "8859_1");
        	filename =  java.net.URLEncoder.encode(filename, "UTF-8");

        	encodedFilename = filename.replaceAll("\\+", " ");
        }
        return encodedFilename;
    }


    public static void downloadFileExec(HttpServletRequest request, HttpServletResponse response, String where, String serverSubPath, String physicalName, String original) throws Exception {
    	String downFileName = where + SEPERATOR + serverSubPath + SEPERATOR + EgovWebUtil.filePathBlackList(physicalName);
    	File file = new File(EgovWebUtil.filePathBlackList(downFileName));

    	String mimeType = "application/octet-stream";

    	if (!file.exists()) {
    	    throw new FileNotFoundException(downFileName);
    	}

    	if (!file.isFile()) {
    	    throw new FileNotFoundException(downFileName);
    	}

    	byte[] b = new byte[BUFFER_SIZE];

    	String browser = getBrowser(request);
    	String encodeFileName = getDisposition(original, browser);

    	response.setContentType(mimeType+";");
    	response.setHeader("Content-Disposition", "attachment; filename=" + encodeFileName + ";");
    	response.setHeader("Content-Transfer-Encoding", "binary");
    	response.setHeader("Pragma", "no-cache");
    	response.setHeader("Expires", "0");

    	BufferedInputStream fin = null;
    	BufferedOutputStream outs = null;

    	try {
    	    fin = new BufferedInputStream(new FileInputStream(file));
    	    outs = new BufferedOutputStream(response.getOutputStream());

    	    int read = 0;

    	    while ((read = fin.read(b)) != -1) {
	    		outs.write(b, 0, read);
    	    }
    	} catch (FileNotFoundException e){
			log.error(e.getMessage());
    	} catch (Exception e) {
			log.error(e.getMessage());
		} finally {
    	    if (outs != null) {
    	    	outs.close();
    	    }

    	    if (fin != null) {
    	    	fin.close();
    	    }
    	}
    }

    @RequestMapping(value = "/board/manage/file/migrate.do")
	public String migrate(
			HttpServletRequest request,
			ModelMap model) throws Exception{

    	JnitboardfileVO searchVO = new JnitboardfileVO();
    	searchVO.setSearchCondition("3");
    	searchVO.setFirstIndex(0);
    	searchVO.setRecordCountPerPage(100000);
    	List resultList = jnitboardfileService.selectJnitboardfileList(searchVO);

    	Iterator itr = resultList.iterator();
    	while(itr.hasNext()){
    		EgovMap fileMap = (EgovMap) itr.next();
	    	JnitboardfileVO fileVO = new JnitboardfileVO();

	    	fileVO.setFileId((String)fileMap.get("fileId"));
	    	fileVO.setBoardId((String)fileMap.get("boardId"));
	    	fileVO.setBoardCntId((Integer)fileMap.get("boardCntId"));
	    	fileVO.setFileUrl((String)fileMap.get("fileUrl"));
	    	fileVO.setFilePath((String)fileMap.get("filePath"));
	    	fileVO.setFileNm((String)fileMap.get("fileNm"));
	    	fileVO.setFileOnm((String)fileMap.get("fileOnm"));
	    	fileVO.setIsmain((Integer)fileMap.get("ismain"));
	    	fileVO.setExt01((String)fileMap.get("ext01"));
	    	fileVO.setExt02((String)fileMap.get("ext02"));
	    	fileVO.setIsdel((Integer)fileMap.get("isdel"));

	    	String fileExp = "";
	    	try{
		    	String fileDot[] = fileVO.getFileOnm().split("\\.");
		    	fileExp = "."+fileDot[fileDot.length-1];
	    	} catch (NullPointerException e){
	    		fileExp = "";
	    	}catch(Exception e){
	    		fileExp = "";
	    	}
	    	//String fileNm = new BASE64Encoder().encode(fileVO.getFileOnm().getBytes());
	    	String fileNm = new String(new Base64(true).encode(fileVO.getFileOnm().getBytes()));
			String fileUrl = "/board/file/" + fileVO.getBoardId() + "/" + String.valueOf(fileVO.getBoardCntId()) + "/" + fileVO.getFileId() + "/" + fileNm + fileExp;

			fileVO.setFileUrl(fileUrl);
			fileService.updateJnitboardfile(fileVO);
    	}
    	model.addAttribute("json","success");
		return "/jnit/util/json";
	}
    @RequestMapping(value = "/board/manage/file/migrate2.do")
	public String migrate2(
			HttpServletRequest request,
			ModelMap model) throws Exception{

    	String searchCondition = NullUtil.nullString(request.getParameter("searchCondition"));
    	List searchConditionList = new ArrayList();
    	boolean searchConditionChk = false;
    	int listMaxSize = 120;							//SQL MAP에서 searchCondition을 추가하고 MAXSIZE를 변경 해주세요
    	for(int i=101; i<=listMaxSize; i++){
    		searchConditionList.add(String.valueOf(i));
    	}

    	searchConditionChk = StringUtil.isExistInList(searchConditionList, searchCondition);

    	if(searchCondition.equals("")){
    		model.addAttribute("json","searchCondition Is Null");
    		return "/jnit/util/json";
    	}else if(!searchConditionChk){
    		model.addAttribute("json","searchCondition 101~120");
    		return "/jnit/util/json";
    	}

    	JnitboardfileVO searchVO = new JnitboardfileVO();
    	searchVO.setSearchCondition(searchCondition);
    	searchVO.setFirstIndex(0);
    	searchVO.setRecordCountPerPage(100000);
    	List resultList = jnitboardfileService.selectJnitboardfileList(searchVO);
	    int size = resultList.size();
    	Iterator itr = resultList.iterator();
    	while(itr.hasNext()){
    		EgovMap fileMap = (EgovMap) itr.next();
	    	JnitboardfileVO fileVO = new JnitboardfileVO();

	    	fileVO.setFileId((String)fileMap.get("fileId"));
	    	fileVO.setBoardId((String)fileMap.get("boardId"));
	    	fileVO.setBoardCntId((Integer)fileMap.get("boardCntId"));
	    	fileVO.setFileUrl((String)fileMap.get("fileUrl"));
	    	fileVO.setFilePath((String)fileMap.get("filePath"));
	    	fileVO.setFileNm((String)fileMap.get("fileNm"));
	    	fileVO.setFileOnm((String)fileMap.get("fileOnm"));
	    	fileVO.setIsmain((Integer)fileMap.get("ismain"));
	    	fileVO.setExt01((String)fileMap.get("ext01"));
	    	fileVO.setExt02((String)fileMap.get("ext02"));
	    	fileVO.setIsdel((Integer)fileMap.get("isdel"));

	    	String fileExp = "";
	    	try{
		    	String fileDot[] = fileVO.getFileOnm().split("\\.");
		    	fileExp = "."+fileDot[fileDot.length-1];
	    	} catch (NullPointerException e){
	    		fileExp = "";
	    	}catch(Exception e){
	    		fileExp = "";
	    	}
	    	//String fileNm = new BASE64Encoder().encode(fileVO.getFileOnm().getBytes());
	    	String fileNm = new String(new Base64(true).encode(fileVO.getFileOnm().getBytes()));
			String fileUrl = "/board/file/" + fileVO.getBoardId() + "/" + String.valueOf(fileVO.getBoardCntId()) + "/" + fileVO.getFileId() + "/" + fileNm + fileExp;

			fileVO.setFileUrl(fileUrl);
			fileService.updateJnitboardfile(fileVO);
    	}
    	//String fileNm = new String(new Base64(true).encode("DSC00746.jpg".getBytes()));
    	model.addAttribute("json","count : " + size + " success");
		return "/jnit/util/json";
	}

    @RequestMapping("/board/manage/file/migrate3.do")
    public String migrateFileNmChange(HttpServletRequest request,ModelMap model) throws Exception{

    	String searchCondition = NullUtil.nullString(request.getParameter("searchCondition"));
    	List searchConditionList = new ArrayList();
    	boolean searchConditionChk = false;
    	int listMaxSize = 120;							//SQL MAP에서 searchCondition을 추가하고 MAXSIZE를 변경 해주세요
    	for(int i=101; i<=listMaxSize; i++){
    		searchConditionList.add(String.valueOf(i));
    	}

    	searchConditionChk = StringUtil.isExistInList(searchConditionList, searchCondition);

    	if(searchCondition.equals("")){
    		model.addAttribute("json","searchCondition Is Null");
    		return "/jnit/util/json";
    	}else if(!searchConditionChk){
    		model.addAttribute("json","searchCondition 101~120");
    		return "/jnit/util/json";
    	}

    	String[] fileNmSplit = null;

    	String regex = ".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*";
    	String getFileNm = "";
		String fileNm = "";
		String extensionNm = "";
		String fileFullPath = "";
		String encode = "";

		boolean strChk = true;

    	JnitboardfileVO searchVO = new JnitboardfileVO();
    	searchVO.setSearchCondition(searchCondition);
    	searchVO.setFirstIndex(0);
    	searchVO.setRecordCountPerPage(100000);
    	List resultList = jnitboardfileService.selectJnitboardfileList(searchVO);
    	int size = resultList.size();
    	Iterator itr = resultList.iterator();
    	while(itr.hasNext()){
    		EgovMap fileMap = (EgovMap) itr.next();
	    	JnitboardfileVO fileVO = new JnitboardfileVO();

	    	getFileNm = fileMap.get("fileNm").toString();
	    	fileNmSplit = getFileNm.split("\\.");

	    	fileNm = fileNmSplit[0];
	    	extensionNm = fileNmSplit[1];

	    	if(fileNm.indexOf("^") != -1){
				fileNm= fileNm.replace("^", "Q");
				strChk = false;
			}
			if(fileNm.indexOf("#") != -1){
				fileNm= fileNm.replace("#", "W");
				strChk = false;
			}
			if(fileNm.indexOf(";") != -1){
				fileNm= fileNm.replace(";", "E");
				strChk = false;
			}
			if(fileNm.indexOf("%") != -1){
				fileNm= fileNm.replace("%", "R");
				strChk = false;
			}
			if(fileNm.indexOf("&") != -1){
				fileNm= fileNm.replace("&", "T");
				strChk = false;
			}
			if(fileNm.indexOf("|") != -1){
				fileNm= fileNm.replace("|", "Y");
				strChk = false;
			}
			if(fileNm.indexOf("\\\\") != -1){
				fileNm= fileNm.replace("\\\\", "U");
				strChk = false;
			}
			if(fileNm.indexOf("/") != -1){
				fileNm= fileNm.replace("/", "I");
				strChk = false;
			}

	    	if(!fileNm.matches(regex)){
	    		if("true".equals(deDug)) log.debug("Already Completed : " + fileNm + " (" + strChk + ")");

	    		fileVO.setFileId((String)fileMap.get("fileId"));
		    	fileVO.setBoardId((String)fileMap.get("boardId"));
		    	fileVO.setBoardCntId((Integer)fileMap.get("boardCntId"));
		    	fileVO.setFileUrl((String)fileMap.get("fileUrl"));
		    	fileVO.setFilePath((String)fileMap.get("filePath"));
		    	fileVO.setFileNm(getFileNm);
		    	fileVO.setFileOnm((String)fileMap.get("fileOnm"));
		    	fileVO.setIsmain((Integer)fileMap.get("ismain"));
		    	fileVO.setExt01((String)fileMap.get("ext01"));
		    	fileVO.setExt02((String)fileMap.get("ext02"));
		    	fileVO.setIsdel((Integer)fileMap.get("isdel"));
		    	fileService.updateJnitboardfile(fileVO);

	    		if(!strChk){
	    			encode = Punycode.encode(fileNm);
	    	    	fileFullPath = encode + "." + extensionNm;
	    	    	fileFullPath = fileFullPath.replace(" ", "");

	    	    	fileVO.setFileId((String)fileMap.get("fileId"));
	    	    	fileVO.setBoardId((String)fileMap.get("boardId"));
	    	    	fileVO.setBoardCntId((Integer)fileMap.get("boardCntId"));
	    	    	fileVO.setFileUrl((String)fileMap.get("fileUrl"));
	    	    	fileVO.setFilePath((String)fileMap.get("filePath"));
	    	    	fileVO.setFileNm(fileFullPath);
	    	    	fileVO.setFileOnm((String)fileMap.get("fileOnm"));
	    	    	fileVO.setIsmain((Integer)fileMap.get("ismain"));
	    	    	fileVO.setExt01((String)fileMap.get("ext01"));
	    	    	fileVO.setExt02((String)fileMap.get("ext02"));
	    	    	fileVO.setIsdel((Integer)fileMap.get("isdel"));
	    	    	fileService.updateJnitboardfile(fileVO);

	    	    	if("true".equals(deDug)) log.debug("File Name Not Korean And Regular Expression Exception : " + fileNm);
	    		}

	    		continue;
	    	}

	    	encode = Punycode.encode(fileNm);
	    	fileFullPath = encode + "." + extensionNm;
	    	fileFullPath = fileFullPath.replace(" ", "");

	    	fileVO.setFileId((String)fileMap.get("fileId"));
	    	fileVO.setBoardId((String)fileMap.get("boardId"));
	    	fileVO.setBoardCntId((Integer)fileMap.get("boardCntId"));
	    	fileVO.setFileUrl((String)fileMap.get("fileUrl"));
	    	fileVO.setFilePath((String)fileMap.get("filePath"));
	    	fileVO.setFileNm(fileFullPath);
	    	fileVO.setFileOnm((String)fileMap.get("fileOnm"));
	    	fileVO.setIsmain((Integer)fileMap.get("ismain"));
	    	fileVO.setExt01((String)fileMap.get("ext01"));
	    	fileVO.setExt02((String)fileMap.get("ext02"));
	    	fileVO.setIsdel((Integer)fileMap.get("isdel"));

	    	fileService.updateJnitboardfile(fileVO);
	    	if("true".equals(deDug)) log.debug("Complete Change File : " + fileNm);
    	}

    	model.addAttribute("json","count : " + size + " success");
		return "/jnit/util/json";
    }

    private JSONObject boardLatestJSON(HttpServletRequest request, String mgmtId)throws Exception{
    	JSONObject JSON = new JSONObject();
    	if(!"".equals(mgmtId)){
    		String root = PathUtil.getRealPath(request);
    		String baordLatestJSON = root+"board/_mgmt/"+mgmtId+".json";
    		try {
    			JSON = JSON.fromObject(CmsHandler.readFile(baordLatestJSON));
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
    	}
    	return JSON;
    }

    private JnitboardinfoVO getJnitboardInfoVO(HttpServletRequest request, String boardId)throws Exception{
    	JnitboardinfoVO jnitboardinfoVO = new JnitboardinfoVO();
    	JSONObject JSON = new JSONObject();

    	if(!"".equals(boardId)){
    		String root = PathUtil.getRealPath(request);
    		String boardInfoJSON = root+"board/_info/"+boardId+".json";
    		try {
				jnitboardinfoVO = (JnitboardinfoVO) JSON.toBean(JSON.fromObject(CmsHandler.readFile(boardInfoJSON)), JnitboardinfoVO.class);
			}catch (FileNotFoundException e) {
				jnitboardinfoVO.setBoardId(boardId);
				jnitboardinfoVO = jnitboardinfoService.selectJnitboardinfo(jnitboardinfoVO);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
    	}
    	return jnitboardinfoVO;
    }
    /**
	 * 게시판 권한 설정
	 * @param request
	 * @param model
	 * @param localVO
	 * @return modelAttribute
	 * @throws Exception
	 * {@link JnitboardController#board}
	 * {@link JnitboardController#boardAjaxCmt}
	 */
	public LocalVO boardAccess(HttpServletRequest request
			, ModelMap model
			, LocalVO localVO
			, String adminLV )throws Exception{
		localVO.setLoginVO((JnitcmsmbrVO)CmsHelper.getAuthMbr(request));

		HashMap<String, String> lvResult = null;
		JnitdbVO dbVO = new JnitdbVO();
		if(localVO.getLoginVO().getMbrId() != null){
			dbVO.setQuery("SELECT b.TYPE_LV as MBR_LV FROM JNITCMSMBR a, JNITCMSMBRTYPE b WHERE a.ISDEL=0 AND a.MBR_ID='"
					+ localVO.getLoginVO().getMbrId() + "' AND b.TYPE_ID=a.TYPE_ID");
			try {
				lvResult = (HashMap<String, String>) dbService.select(dbVO);
			} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		if (lvResult != null) {
			if ((int) lvResult.get("MBR_LV").toCharArray()[0] > (int) localVO.getBoardinfoVO().getPermList().toCharArray()[0]) {
				localVO.setPermList(false);
			} else {
				localVO.setPermList(true);
			}

			if ((int) lvResult.get("MBR_LV").toCharArray()[0] > (int) localVO.getBoardinfoVO().getPermView().toCharArray()[0]) {
				localVO.setPermView(false);
			} else {
				localVO.setPermView(true);
			}

			if ((int) lvResult.get("MBR_LV").toCharArray()[0] > (int) localVO.getBoardinfoVO().getPermWrite().toCharArray()[0]) {
				localVO.setPermWrite(false);
			} else {
				localVO.setPermWrite(true);
			}

			if ((int) lvResult.get("MBR_LV").toCharArray()[0] > (int) localVO.getBoardinfoVO().getPermReply().toCharArray()[0]) {
				localVO.setPermReply(false);
			} else {
				localVO.setPermReply(true);
			}

			if ((int) lvResult.get("MBR_LV").toCharArray()[0] > (int) localVO.getBoardinfoVO().getPermCmt().toCharArray()[0]) {
				localVO.setPermCmt(false);
			} else {
				localVO.setPermCmt(true);
			}
			try {
				if(localVO.getBoardinfoVO().getPermFileDown() != null){
					if ((int) lvResult.get("MBR_LV").toCharArray()[0] > (int)localVO.getBoardinfoVO().getPermFileDown().toCharArray()[0]) {
						localVO.setPermFileDown(false);
					} else {
						localVO.setPermFileDown(true);
					}
				}
			} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		} else {
			if (localVO.getBoardinfoVO().getAnonPermList() == 1) {
				localVO.setPermList(true);
			}
			if (localVO.getBoardinfoVO().getAnonPermView() == 1) {
				localVO.setPermView(true);
			}
			if (localVO.getBoardinfoVO().getAnonPermWrite() == 1) {
				localVO.setPermWrite(true);
			}
			if(!"".equals(NullUtil.nullString(localVO.getBoardinfoVO().getPermFileDown()))){
				localVO.setPermFileDown(false);
			}
		}
		String permListType[] = NullUtil.nullString(localVO.getBoardinfoVO().getPermListType()).split(",");
		if(StringUtil.isExistArray(permListType, localVO.getLoginVO().getTypeId())){
			localVO.setPermList(true);
		}
		String permViewType[] = NullUtil.nullString(localVO.getBoardinfoVO().getPermViewType()).split(",");
		if(StringUtil.isExistArray(permViewType, localVO.getLoginVO().getTypeId())){
			localVO.setPermView(true);
		}
		String permWriteType[] = NullUtil.nullString(localVO.getBoardinfoVO().getPermWriteType()).split(",");
		if(StringUtil.isExistArray(permWriteType, localVO.getLoginVO().getTypeId())){
			localVO.setPermWrite(true);
		}
		String permReplyType[] = NullUtil.nullString(localVO.getBoardinfoVO().getPermReplyType()).split(",");
		if(StringUtil.isExistArray(permReplyType, localVO.getLoginVO().getTypeId())){
			localVO.setPermReply(true);
		}

		String permCmtType[] = NullUtil.nullString(localVO.getBoardinfoVO().getPermCmtType()).split(",");
		if(StringUtil.isExistArray(permCmtType, localVO.getLoginVO().getTypeId())){
			localVO.setPermCmt(true);
		}
		if(!"".equals(NullUtil.nullString(localVO.getBoardinfoVO().getPermFileDownType()))){
			String permFileDownType[] = NullUtil.nullString(localVO.getBoardinfoVO().getPermFileDownType()).split(",");
			if(!StringUtil.isExistArray(permFileDownType, localVO.getLoginVO().getTypeId())){
				localVO.setPermFileDown(false);
			}
		}
		// 관리자 권한
		dbVO.setQuery("SELECT COUNT(*) FROM JNITCMSMBRTYPE WHERE TYPE_LV IN ("+adminLV+") AND TYPE_ID='"+localVO.getLoginVO().getTypeId()+"'");

		if(dbService.selectCnt(dbVO) != 0) {
			localVO.setIsAdmin(true);
		}
		String[] admExt = NullUtil.nullString(localVO.getBoardinfoVO().getAdmExt()).split(",");
		if(StringUtil.isExistArray(admExt,localVO.getLoginVO().getMbrId())){
			localVO.setIsAdmin(true);
			localVO.setPermList(true);
			localVO.setPermView(true);
			localVO.setPermWrite(true);
			localVO.setPermReply(true);
			localVO.setPermCmt(true);
			localVO.setPermFileDown(true);
		}

		return localVO;
	}

}