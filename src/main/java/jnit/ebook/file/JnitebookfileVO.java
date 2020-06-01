/**
 * @version 3.2.0.1
 */
package jnit.ebook.file;

/**
 * @Class Name : JnitebookfileVO.java
 * @Description : Jnitebookfile VO class
 * @Modification Information
 *
 * @author JNITEBOOKFILE
 * @since 2014.02.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitebookfileVO extends JnitebookfileDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** EBOOK_FILE_ID */
    private java.lang.String ebookFileId;
    
    /** FILE_ID */
    private java.lang.String fileId;
    
    /** FILE_PID */
    private java.lang.String filePid;
    
    /** FILE_PATH */
    private java.lang.String filePath;
    
    /** FILE_NM */
    private java.lang.String fileNm;
    
    /** FILE_ORIGIN */
    private java.lang.String filePath2;   
    
    /** FILE_URL */
    private java.lang.String fileNm2;
    
    /** FILE_NUM */
    private int fileNum;
    
    /** ISDEL */
    private int isdel;
    
    /** isdelYn 사용여부 */
    private java.lang.String isdelYn = "Y";
    
    /** pageYn 사용여부 */
    private java.lang.String pageYn = "Y";
    
    /** updateAllYn 사용여부 */
    private java.lang.String updateAllYn = "Y";
    
    /** ebookFileIdYn 사용여부*/
    private java.lang.String ebookFileIdYn = "Y";
    
    /** fileIdYn 사용여부 */
    private java.lang.String fileIdYn = "Y";   
    
    /** updateCondition */
    private java.lang.String updateCondition = "0";
    
    /** selectCondition */
    private java.lang.String selectCondition;
    
    /** orderbyCondition */
    private java.lang.String orderbyCondition = "0";
    
    /** orderbyFileId */
    private java.lang.String orderbyFileId = "Y";
    
    /** FILE_CLASS */
    private java.lang.String fileClass;
    
    /** HTML_FILE */
    private java.lang.String htmlFile;
    
    /** BACKGROUND_FILE */
    private java.lang.String backgroundFile;
    
    /** DISABLE_EMBOSSING */
    private java.lang.String disableEmbossing;
    
    /** TRANSPARENT_PAGE */
    private java.lang.String transparentPage;
    
    /** PAGE_NUMBER */
    private java.lang.String pageNumber;
    
    /** PAGE_NAME */
    private java.lang.String pageName;
    
    /** PAGE_LABEL */
    private java.lang.String pageLabel;
    
    /** DATA */
    private java.lang.String data;
    
    /** THUMBNAIL_IMAGE */
    private java.lang.String thumbnailImage;
    
    /** UPLOAD_FILE */
    private java.lang.String uploadFile;
    
    /** DATA_UNLOAD */
    private java.lang.String dataUnload;
    
    /** FILE_TYPE */
    private java.lang.String fileType;
    
    /** FILE_HTML_PATH */
    private java.lang.String fileHtmlPath;
    
    /* FILE_HTML_NM */
    private java.lang.String fileHtmlNm;

	/**
	 * @return the fileHtmlPath
	 */
	public java.lang.String getFileHtmlPath() {
		return fileHtmlPath;
	}

	/**
	 * @return the fileHtmlNm
	 */
	public java.lang.String getFileHtmlNm() {
		return fileHtmlNm;
	}

	/**
	 * @param fileHtmlPath the fileHtmlPath to set
	 */
	public void setFileHtmlPath(java.lang.String fileHtmlPath) {
		this.fileHtmlPath = fileHtmlPath;
	}

	/**
	 * @param fileHtmlNm the fileHtmlNm to set
	 */
	public void setFileHtmlNm(java.lang.String fileHtmlNm) {
		this.fileHtmlNm = fileHtmlNm;
	}

	/**
	 * @return the fileType
	 */
	public java.lang.String getFileType() {
		return fileType;
	}

	/**
	 * @param fileType the fileType to set
	 */
	public void setFileType(java.lang.String fileType) {
		this.fileType = fileType;
	}

	/**
	 * @return the dataUnload
	 */
	public java.lang.String getDataUnload() {
		return dataUnload;
	}

	/**
	 * @param dataUnload the dataUnload to set
	 */
	public void setDataUnload(java.lang.String dataUnload) {
		this.dataUnload = dataUnload;
	}

	/**
	 * @return the filePid
	 */
	public java.lang.String getFilePid() {
		return filePid;
	}

	/**
	 * @return the uploadFile
	 */
	public java.lang.String getUploadFile() {
		return uploadFile;
	}

	/**
	 * @param filePid the filePid to set
	 */
	public void setFilePid(java.lang.String filePid) {
		this.filePid = filePid;
	}

	/**
	 * @param uploadFile the uploadFile to set
	 */
	public void setUploadFile(java.lang.String uploadFile) {
		this.uploadFile = uploadFile;
	}

	/** CONTENT */
    private java.lang.String content;
    
    /**
	 * @return the filePath2
	 */
	public java.lang.String getFilePath2() {
		return filePath2;
	}

	/**
	 * @return the fileNm2
	 */
	public java.lang.String getFileNm2() {
		return fileNm2;
	}

	/**
	 * @param filePath2 the filePath2 to set
	 */
	public void setFilePath2(java.lang.String filePath2) {
		this.filePath2 = filePath2;
	}

	/**
	 * @param fileNm2 the fileNm2 to set
	 */
	public void setFileNm2(java.lang.String fileNm2) {
		this.fileNm2 = fileNm2;
	}

	/**
	 * @return the pageLabel
	 */
	public java.lang.String getPageLabel() {
		return pageLabel;
	}

	/**
	 * @param pageLabel the pageLabel to set
	 */
	public void setPageLabel(java.lang.String pageLabel) {
		this.pageLabel = pageLabel;
	}

	/**
	 * @return the content
	 */
	public java.lang.String getContent() {
		return content;
	}

	/**
	 * @param content the content to set
	 */
	public void setContent(java.lang.String content) {
		this.content = content;
	}

	/**
	 * @return the fileClass
	 */
	public java.lang.String getFileClass() {
		return fileClass;
	}

	/**
	 * @param fileClass the fileClass to set
	 */
	public void setFileClass(java.lang.String fileClass) {
		this.fileClass = fileClass;
	}

	/**
	 * @return the htmlFile
	 */
	public java.lang.String getHtmlFile() {
		return htmlFile;
	}

	/**
	 * @return the backgroundFile
	 */
	public java.lang.String getBackgroundFile() {
		return backgroundFile;
	}

	/**
	 * @return the disableEmbossing
	 */
	public java.lang.String getDisableEmbossing() {
		return disableEmbossing;
	}

	/**
	 * @return the transparentPage
	 */
	public java.lang.String getTransparentPage() {
		return transparentPage;
	}

	/**
	 * @return the pageNumber
	 */
	public java.lang.String getPageNumber() {
		return pageNumber;
	}

	/**
	 * @return the pageName
	 */
	public java.lang.String getPageName() {
		return pageName;
	}

	/**
	 * @return the data
	 */
	public java.lang.String getData() {
		return data;
	}

	/**
	 * @return the thumbnailImage
	 */
	public java.lang.String getThumbnailImage() {
		return thumbnailImage;
	}

	/**
	 * @param htmlFile the htmlFile to set
	 */
	public void setHtmlFile(java.lang.String htmlFile) {
		this.htmlFile = htmlFile;
	}

	/**
	 * @param backgroundFile the backgroundFile to set
	 */
	public void setBackgroundFile(java.lang.String backgroundFile) {
		this.backgroundFile = backgroundFile;
	}

	/**
	 * @param disableEmbossing the disableEmbossing to set
	 */
	public void setDisableEmbossing(java.lang.String disableEmbossing) {
		this.disableEmbossing = disableEmbossing;
	}

	/**
	 * @param transparentPage the transparentPage to set
	 */
	public void setTransparentPage(java.lang.String transparentPage) {
		this.transparentPage = transparentPage;
	}

	/**
	 * @param pageNumber the pageNumber to set
	 */
	public void setPageNumber(java.lang.String pageNumber) {
		this.pageNumber = pageNumber;
	}

	/**
	 * @param pageName the pageName to set
	 */
	public void setPageName(java.lang.String pageName) {
		this.pageName = pageName;
	}

	/**
	 * @param data the data to set
	 */
	public void setData(java.lang.String data) {
		this.data = data;
	}

	/**
	 * @param thumbnailImage the thumbnailImage to set
	 */
	public void setThumbnailImage(java.lang.String thumbnailImage) {
		this.thumbnailImage = thumbnailImage;
	}
	

	/**
	 * @return the orderbyCondition
	 */
	public java.lang.String getOrderbyCondition() {
		return orderbyCondition;
	}

	/**
	 * @param orderbyCondition the orderbyCondition to set
	 */
	public void setOrderbyCondition(java.lang.String orderbyCondition) {
		this.orderbyCondition = orderbyCondition;
	}

	/**
	 * @return the orderbyFileId
	 */
	public java.lang.String getOrderbyFileId() {
		return orderbyFileId;
	}

	/**
	 * @param orderbyFileId the orderbyFileId to set
	 */
	public void setOrderbyFileId(java.lang.String orderbyFileId) {
		this.orderbyFileId = orderbyFileId;
	}

	/**
	 * @return the ebookFileIdYn
	 */
	public java.lang.String getEbookFileIdYn() {
		return ebookFileIdYn;
	}

	/**
	 * @param ebookFileIdYn the ebookFileIdYn to set
	 */
	public void setEbookFileIdYn(java.lang.String ebookFileIdYn) {
		this.ebookFileIdYn = ebookFileIdYn;
	}

	/**
	 * @return the fileIdYn
	 */
	public java.lang.String getFileIdYn() {
		return fileIdYn;
	}

	/**
	 * @param fileIdYn the fileIdYn to set
	 */
	public void setFileIdYn(java.lang.String fileIdYn) {
		this.fileIdYn = fileIdYn;
	}

	/**
	 * @return the selectCondition
	 */
	public java.lang.String getSelectCondition() {
		return selectCondition;
	}

	/**
	 * @param selectCondition the selectCondition to set
	 */
	public void setSelectCondition(java.lang.String selectCondition) {
		this.selectCondition = selectCondition;
	}

	/**
	 * @return the updateAllYn
	 */
	public java.lang.String getUpdateAllYn() {
		return updateAllYn;
	}

	/**
	 * @param updateAllYn the updateAllYn to set
	 */
	public void setUpdateAllYn(java.lang.String updateAllYn) {
		this.updateAllYn = updateAllYn;
	}

	/**
	 * @return the updateCondition
	 */
	public java.lang.String getUpdateCondition() {
		return updateCondition;
	}

	/**
	 * @param updateCondition the updateCondition to set
	 */
	public void setUpdateCondition(java.lang.String updateCondition) {
		this.updateCondition = updateCondition;
	}

	/**
	 * @return the isdelYn
	 */
	public java.lang.String getIsdelYn() {
		return isdelYn;
	}

	/**
	 * @param isdelYn the isdelYn to set
	 */
	public void setIsdelYn(java.lang.String isdelYn) {
		this.isdelYn = isdelYn;
	}

	/**
	 * @return the pageYn
	 */
	public java.lang.String getPageYn() {
		return pageYn;
	}

	/**
	 * @param pageYn the pageYn to set
	 */
	public void setPageYn(java.lang.String pageYn) {
		this.pageYn = pageYn;
	}

	/**
	 * @return the fileNum
	 */
	public int getFileNum() {
		return fileNum;
	}

	/**
	 * @param fileNum the fileNum to set
	 */
	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}

	/**
	 * @return the isdel
	 */
	public int getIsdel() {
		return isdel;
	}

	/**
	 * @param isdel the isdel to set
	 */
	public void setIsdel(int isdel) {
		this.isdel = isdel;
	}

	public java.lang.String getEbookFileId() {
        return this.ebookFileId;
    }
    
    public void setEbookFileId(java.lang.String ebookFileId) {
        this.ebookFileId = ebookFileId;
    }
    
    public java.lang.String getFileId() {
        return this.fileId;
    }
    
    public void setFileId(java.lang.String fileId) {
        this.fileId = fileId;
    }
    
    public java.lang.String getFilePath() {
        return this.filePath;
    }
    
    public void setFilePath(java.lang.String filePath) {
        this.filePath = filePath;
    }
    
    public java.lang.String getFileNm() {
        return this.fileNm;
    }
    
    public void setFileNm(java.lang.String fileNm) {
        this.fileNm = fileNm;
    }
}
