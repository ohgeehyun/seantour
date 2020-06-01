package jnit.util;

import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovWebUtil;

/**
 * @Class Name : FileUploadUtil.java
 * @Description : FileUploadUtil class
 * @Modification Information
 *
 * @author YDH
 * @since 2016-08-12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

public class FileUploadUtil extends EgovFileUploadUtil {
    @SuppressWarnings("rawtypes")
	public static List<EgovFormBasedFileVo> uploadMainFiles(HttpServletRequest request, String where, long maxFileSize) throws Exception {
    	List<EgovFormBasedFileVo> list = new ArrayList<EgovFormBasedFileVo>();

    	MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest)request;
    	Iterator fileIter = mptRequest.getFileNames();

    	while (fileIter.hasNext()) {
    		String key = (String)fileIter.next();
    		MultipartFile mFile = mptRequest.getFile(key);
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
            	//saveFile(mFile.getInputStream(), new File(EgovWebUtil.filePathBlackList(where+SEPERATOR+vo.getServerSubPath()+SEPERATOR+"list_"+vo.getPhysicalName())));            
            	saveFile(mFile.getInputStream(), new File(EgovWebUtil.filePathBlackList(where+SEPERATOR+vo.getServerSubPath()+SEPERATOR+vo.getPhysicalName())));
            	list.add(vo);
            }
    	}

    	return list;
    }
}
