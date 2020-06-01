/**
 * @version 3.2.0.1
 */
package egovframework.com.utl.fcc.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import jnit.ebook.JnitebookVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
/**
 * @Class Name  : EgovFileUploadUtil.java
 * @Description : Spring 기반 File Upload 유틸리티
 * @Modification Information
 *
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2009.08.26       한성곤                  최초 생성
 *
 * @author 공통컴포넌트 개발팀 한성곤
 * @since 2009.08.26
 * @version 1.0
 * @see
 */

public class EgovFileUploadUtil extends EgovFormBasedFileUtil {
	
	public static Log log = LogFactory.getLog(EgovFileUploadUtil.class);
	
	public static String type;
	public static String orginFileNm;
	//public static final String [] whiteFile = {"bmp,jpg,gif,png,jpeg,mp3,ogg,wma,wav,mpeg,wmv,mp4,swf,txt,hwp,doc,docx,ppt,pdf,pptx,xml,zip,rar,alz,egg,7z,xls,xlsx,avi,p12"};			
	public static final String [] whiteFile = {EgovProperties.getProperty("Globals.FILE.EXT")};			

    /**
     * 파일을 Upload 처리한다.
     *
     * @param request
     * @param where
     * @param maxFileSize
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public static List<EgovFormBasedFileVo> uploadFiles(HttpServletRequest request, String where, long maxFileSize) throws Exception {
	List<EgovFormBasedFileVo> list = new ArrayList<EgovFormBasedFileVo>();

	MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest)request;
	Iterator fileIter = mptRequest.getFileNames();

	while (fileIter.hasNext()) {
	    MultipartFile mFile = mptRequest.getFile((String)fileIter.next());

	    EgovFormBasedFileVo vo = new EgovFormBasedFileVo();

	    String tmp = mFile.getOriginalFilename();

            if (tmp.lastIndexOf("\\") >= 0) {
        	tmp = tmp.substring(tmp.lastIndexOf("\\") + 1);
            }

            vo.setFileName(tmp);
            vo.setContentType(mFile.getContentType());
            vo.setServerSubPath(getTodayString());
            vo.setPhysicalName(getPhysicalFileName());
            vo.setSize(mFile.getSize());

            if (tmp.lastIndexOf(".") >= 0) {
       	 	vo.setPhysicalName(vo.getPhysicalName() + tmp.substring(tmp.lastIndexOf(".")));
            }

            if (mFile.getSize() > 0) {
            	saveFile(mFile.getInputStream(), new File(EgovWebUtil.filePathBlackList(where+SEPERATOR+vo.getServerSubPath()+SEPERATOR+vo.getPhysicalName())));
        	list.add(vo);
            }
	}

	return list;
    }
    
    
    /**
     * 파일을 Upload 처리 후 Form filename Map을 생성하여 리턴한다.
     *
     * @param request
     * @param where
     * @param maxFileSize
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public static HashMap<String, EgovFormBasedFileVo> uploadFormFiles(HttpServletRequest request, String where, long maxFileSize) throws Exception {
	HashMap<String, EgovFormBasedFileVo> list = new LinkedHashMap<String, EgovFormBasedFileVo>();
	MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest)request;

	final Map<String, MultipartFile> files = mptRequest.getFileMap();
	Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	while (itr.hasNext()) {
		Entry<String, MultipartFile> entry = itr.next();
	    MultipartFile mFile = entry.getValue(); // mptRequest.getFile((String)fileIter.next());

	    EgovFormBasedFileVo vo = new EgovFormBasedFileVo();

	    String tmp = mFile.getOriginalFilename();
            if (tmp.lastIndexOf("\\") >= 0) {
        	tmp = tmp.substring(tmp.lastIndexOf("\\") + 1);
            }
            vo.setFileName(tmp);
            vo.setContentType(mFile.getContentType());
            vo.setServerSubPath(getTodayString());
            Calendar cal = Calendar.getInstance();
        	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS");
            vo.setPhysicalName(dayTime.format(cal.getTime())+(int)(Math.random()*100));
            vo.setPhysicalName(("".equals(NullUtil.nullString(orginFileNm))) ? vo.getPhysicalName() : orginFileNm);
            vo.setSize(mFile.getSize());
            
            boolean fileExtension = false;
			try{
				String [] splitFileName = tmp.split("\\.");
				String fileExp = splitFileName[splitFileName.length-1];
				
				for(int i = 0; i<whiteFile.length; i++){
					if(whiteFile[i].contains(fileExp.toLowerCase())){
						fileExtension = true;/*허용리스트에 포함되어 있다면 true*/
					}
				}
				if(tmp.lastIndexOf(".") >= 0) {
		       	 	vo.setPhysicalName(vo.getPhysicalName() + tmp.substring(tmp.lastIndexOf(".")));
		        }
				if(fileExtension){
			        if (mFile.getSize() > 0) {
			            saveFile(mFile.getInputStream(), new File(EgovWebUtil.filePathBlackList(where+SEPERATOR+("noSubPath".equals(type) ? "" : vo.getServerSubPath()+SEPERATOR )+vo.getPhysicalName())));
			        	list.put(entry.getKey(), vo);
			        }
				}else{
					//허용되지 않은 파일을 업로드 했을때 오류 유도(사용자 페이지에서 확장자 체크하는 스크립트를 변조해서 들어왔을때 발생)
					list.put("isError", vo);
					throw new Exception("Not access upload");
				}
			}catch(IOException e){
				log.error(e.getMessage());
			}catch(Exception e){
				log.error(e.getMessage());
			}
	}
	return list;
    }
    
    /**
     * 파일을 Upload 처리 후 Form filename Map을 생성하여 리턴한다.
     * 
     *
     * @param request
     * @param where
     * @param maxFileSize
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public static HashMap<String, EgovFormBasedFileVo> uploadEbookFiles(HttpServletRequest request, String where, long maxFileSize, JnitebookVO jnitebookVO) throws Exception {
	HashMap<String, EgovFormBasedFileVo> list = new HashMap<String, EgovFormBasedFileVo>();	
	
	MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest)request;

	final Map<String, MultipartFile> files = mptRequest.getFileMap();
	Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();	
	int j=0;	
	int b_img = 0;	
	
	for (int i=0; i<files.size(); i++) {
		Entry<String, MultipartFile> entry = itr.next();
	    MultipartFile mFile = entry.getValue(); // mptRequest.getFile((String)fileIter.next());
	   
	    EgovFormBasedFileVo vo = new EgovFormBasedFileVo();

	    String tmp = mFile.getOriginalFilename();
	    
	    String[] fileDot = mFile.getOriginalFilename().split("\\.");
	    String fileDots = fileDot[fileDot.length-1];
	   
    	if (tmp.lastIndexOf("\\") >= 0) {
    		tmp = tmp.substring(tmp.lastIndexOf("\\") + 1);
        }

        vo.setFileName(tmp);
        vo.setContentType(mFile.getContentType());
        
        if(!mFile.isEmpty()){       		        		
        	vo.setPhysicalName(getPhysicalFileName()+"."+fileDots);        	
    	}        
        
        if(entry.getKey().indexOf("upbackgroundFile") > -1){
        	vo.setServerSubPath("backgroundFile");
        }
        if(entry.getKey().indexOf("upthumbnailFile") > -1){
        	vo.setServerSubPath("thumbnailFile");
        }
        if(entry.getKey().indexOf("uploadFile") > -1){
        	vo.setServerSubPath("uploadFile");
        }
        if(entry.getKey().indexOf("upHtmlFile") > -1){
        	vo.setServerSubPath("htmlFile");
        }
        vo.setSize(mFile.getSize());
        String[] fileDotList = {"bmp","jpeg","gif","png","jpg"};
        boolean fileExtension = false;
		   
	    for(int k = 0; k<fileDotList.length; k++){
			if(fileDotList[k].contains(fileDots.toLowerCase())){
				fileExtension = true;/*허용리스트에 포함되어 있다면 true*/
			}
		}
        String origin = fileExtension ? "/origin" : "";
        
        String uploadDir = where+SEPERATOR+vo.getServerSubPath()+origin+SEPERATOR+vo.getPhysicalName();
        
        if (mFile.getSize() > 0) {        	
        	saveFile(mFile.getInputStream(), new File(EgovWebUtil.filePathBlackList(uploadDir)));
        	
        	//ebook/{ebook_id}/img img Thumb
        	
    		if(fileExtension){ //이미지를 다시 가져와서 다시 썸네일로 파일생성
    			String FilePath = where+SEPERATOR+vo.getServerSubPath()+SEPERATOR + vo.getPhysicalName();
	        	java.io.File file = new File(FilePath);
	        	int width = NullUtil.nullInt(Integer.toString(jnitebookVO.getPageWidth()));
	        	int height = NullUtil.nullInt(Integer.toString(jnitebookVO.getPageHeight()));
	        	ThumbnailUtil.createThumbnail(uploadDir, file.getPath(), width, height);
	        	
	        	String MoFilePath = where+SEPERATOR+"mobile"+SEPERATOR + vo.getPhysicalName();
	        	
	        	java.io.File MoFile = new File(MoFilePath);
	        	if (! MoFile.getParentFile().exists()) {
	        		MoFile.getParentFile().mkdirs();
	        	}
	        	//int MoWidth = NullUtil.nullInt(Integer.toString(jnitebookVO.getPageWidth()));
	        	//int MoHeight = NullUtil.nullInt(Integer.toString(jnitebookVO.getPageHeight()));
	        	ThumbnailUtil.createThumbnail(uploadDir, MoFile.getPath(), 450, 637);
	        	
	        	if("backgroundFile".equals(vo.getServerSubPath())){
	        		saveFile(mFile.getInputStream(), new File(EgovWebUtil.filePathBlackList(where+SEPERATOR+"thumbnailFile"+origin+SEPERATOR+vo.getPhysicalName())));
	        		String thumbFilePath = where+SEPERATOR+"thumbnailFile"+SEPERATOR + vo.getPhysicalName();
		        	java.io.File thumbFile = new File(thumbFilePath);
		        	width = NullUtil.nullInt(Integer.toString(jnitebookVO.getThumbWidth()));
		        	height = NullUtil.nullInt(Integer.toString(jnitebookVO.getThumbHeight()));
		        	ThumbnailUtil.createThumbnail(uploadDir, thumbFile.getPath(), width, height);
	        	}
    		}
        	list.put(entry.getKey(), vo);
        }
	}
	
	return list;
    }
    
    /**
     * 파일을 Upload 처리 후 Form filename Map을 생성하여 리턴한다.
     * 
     *
     * @param request
     * @param where
     * @param maxFileSize
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public static HashMap<String, EgovFormBasedFileVo> uploadFileName(HttpServletRequest request, String inputFileName, String where, long maxFileSize, JnitebookVO jnitebookVO) throws Exception {
    	HashMap<String, EgovFormBasedFileVo> list = new HashMap<String, EgovFormBasedFileVo>();
	try {		
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest)request;

		final Map<String, MultipartFile> files = mptRequest.getFileMap();
	   
	    EgovFormBasedFileVo vo = new EgovFormBasedFileVo();
	    
	    String tmp = files.get(inputFileName).getOriginalFilename();
	    
	    String[] fileDotList = {"bmp","jpeg","gif","png","jpg"};
	    String[] fileDot = files.get(inputFileName).getOriginalFilename().split("\\.");
	    String fileDots = fileDot[fileDot.length-1];
	    boolean fileExtension = false;
		   
	    for(int i = 0; i<fileDotList.length; i++){
			if(fileDotList[i].contains(fileDots.toLowerCase())){
				fileExtension = true;/*허용리스트에 포함되어 있다면 true*/
			}
		}
	   
		if (tmp.lastIndexOf("\\") >= 0) {
			tmp = tmp.substring(tmp.lastIndexOf("\\") + 1);
	    }

	    vo.setFileName(tmp);
	    vo.setContentType(files.get(inputFileName).getContentType());
	    
	    if(!files.get(inputFileName).isEmpty()){       		        		
	    	vo.setPhysicalName(getPhysicalFileName()+"."+fileDots);        	
		}        
	    
	    if(files.get(inputFileName).getName().indexOf("upbackgroundFile") > -1){
	    	vo.setServerSubPath("backgroundFile");
	    }
	    if(files.get(inputFileName).getName().indexOf("upthumbnailFile") > -1){
	    	vo.setServerSubPath("thumbnailFile");
	    }
	    if(files.get(inputFileName).getName().indexOf("uploadFile") > -1){
	    	vo.setServerSubPath("uploadFile");
	    }
	    if(files.get(inputFileName).getName().indexOf("upHtmlFile") > -1){
	    	vo.setServerSubPath("htmlFile");
	    }
	    vo.setSize(files.get(inputFileName).getSize());
	    if(vo.getSize() > maxFileSize){
	    	list.put("maxSizeError", vo);
	        return list;
	    }
	    
	    //String origin = StringUtil.isExistArray(fileDotList, fileDots) ? "/origin" : "";
	    String origin = "";
	    if(fileExtension){
	    	origin = "/origin";
	    }
	    String thumbnail = "";
	    String uploadDir = where+SEPERATOR+vo.getServerSubPath()+origin+SEPERATOR+vo.getPhysicalName();
	    
	    if (files.get(inputFileName).getSize() > 0) {        	
	    	saveFile(files.get(inputFileName).getInputStream(), new File(EgovWebUtil.filePathBlackList(uploadDir)));
	    	
	    	//ebook/{ebook_id}/img img Thumb
	    	
			if(fileExtension){ //이미지를 다시 가져와서 다시 썸네일로 파일생성
				String FilePath = where+SEPERATOR+vo.getServerSubPath()+SEPERATOR + vo.getPhysicalName();
	        	java.io.File file = new File(FilePath);
	        	int width = NullUtil.nullInt(Integer.toString(jnitebookVO.getPageWidth()));
	        	int height = NullUtil.nullInt(Integer.toString(jnitebookVO.getPageHeight()));
	        	thumbnail = ThumbnailUtil.createThumbnail(uploadDir, file.getPath(), width, height);
	        	
	        	String MoFilePath = where+SEPERATOR+"mobile"+SEPERATOR + vo.getPhysicalName();
	        	
	        	java.io.File MoFile = new File(MoFilePath);
	        	if (! MoFile.getParentFile().exists()) {
	        		MoFile.getParentFile().mkdirs();
	        	}
	        	//int MoWidth = NullUtil.nullInt(Integer.toString(jnitebookVO.getPageWidth()));
	        	//int MoHeight = NullUtil.nullInt(Integer.toString(jnitebookVO.getPageHeight()));
	        	thumbnail = ThumbnailUtil.createThumbnail(uploadDir, MoFile.getPath(), 450, 637);
	        	
	        	if("backgroundFile".equals(vo.getServerSubPath())){
	        		saveFile(files.get(inputFileName).getInputStream(), new File(EgovWebUtil.filePathBlackList(where+SEPERATOR+"thumbnailFile"+origin+SEPERATOR+vo.getPhysicalName())));
	        		String thumbFilePath = where+SEPERATOR+"thumbnailFile"+SEPERATOR + vo.getPhysicalName();
		        	java.io.File thumbFile = new File(thumbFilePath);
		        	width = NullUtil.nullInt(Integer.toString(jnitebookVO.getThumbWidth()));
		        	height = NullUtil.nullInt(Integer.toString(jnitebookVO.getThumbHeight()));
		        	thumbnail = ThumbnailUtil.createThumbnail(uploadDir, thumbFile.getPath(), width, height);
	        	}
			}
			if(!"".equals(thumbnail)) list.put(thumbnail, vo);
	    	list.put(files.get(inputFileName).getName(), vo);
	    }
	} catch (Exception e) {
		
	}
	return list;
    }    
}
