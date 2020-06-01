package jnit.cms.fileupload;

import jnit.util.StringUtil;

/**
 * @Class Name : AttachedFileVO.java
 * @Description : AttachedFile VO class
 * @Modification Information
 *
 * @author YDH
 * @since 2016-08-12
 * @version 1.0
 * @see
 *  Copyright (C)  All right reserved.
 */
public class AttachedFileVO {
    /** fileId */
    private int fileId = 0;
    
    /** phsicalDir */
    private String phsicalDir = "";
    
    /** viewFileName */
    private String viewFileName = "";
    
    /** phsicalFileName */
    private String phsicalFileName = "";

    /** useYn */
    private String useYn = "";

    /** fileSize */
    private long fileSize = 0L;

    /** isMain */
    private String isMain = "N";

    /** searchFileId */
    private String searchFileId = "";

    public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}
	public void setFileId(String fileId) throws Exception {
		this.fileId = StringUtil.toInt(fileId);
	}

	public String getPhsicalDir() {
		return phsicalDir;
	}

	public void setPhsicalDir(String phsicalDir) {
		this.phsicalDir = phsicalDir;
	}

	public String getViewFileName() {
		return viewFileName;
	}

	public void setViewFileName(String viewFileName) {
		this.viewFileName = viewFileName;
	}

	public String getPhsicalFileName() {
		return phsicalFileName;
	}

	public void setPhsicalFileName(String phsicalFileName) {
		this.phsicalFileName = phsicalFileName;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getSearchFileId() {
		return searchFileId;
	}

	public void setSearchFileId(String searchFileId) {
		this.searchFileId = searchFileId;
	}

	public String getIsMain() {
		return isMain;
	}

	public void setIsMain(String isMain) {
		this.isMain = isMain;
	}

	@Override
	public String toString() {
		return "AttachedFileVO [fileId=" + fileId + ", phsicalDir="
				+ phsicalDir + ", viewFileName=" + viewFileName
				+ ", phsicalFileName=" + phsicalFileName + ", useYn=" + useYn
				+ ", isMain=" + isMain + ", searchFileId=" + searchFileId + "]";
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	
	
}
