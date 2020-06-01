/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmt;

/**
 * @Class Name : JnitcmsmgmtVO.java
 * @Description : Jnitcmsmgmt VO class
 * @Modification Information
 *
 * @author JNITCMSMGMT
 * @since 2014.04.16
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmgmtVO extends JnitcmsmgmtDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** MGMT_ID */
    private java.lang.String mgmtId;
    
    /** MGMT_NM */
    private java.lang.String mgmtNm;
    
    /** MGMT_TYPE */
    private java.lang.String mgmtType;
    
    /** MGMT_SCRIPT_TYPE */
    private java.lang.String mgmtScriptType;
    
    /** MGMT_CONTENT */
    private java.lang.String mgmtContent;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** MGMT_ACT_ID */
    private java.lang.String mgmtActId;
    
    /** MGMT_HEARDER_YN */
    private int mgmtHearderYn;
    
    /** ISDEL */
    private int isdel;
    
    /** MGMT_FILE_NM */
    private java.lang.String mgmtFileNm;
    
    /** MGMT_FILE_ORIGIN */
    private java.lang.String mgmtFileOrigin;
    
    /** MGMT_FILE_PATH */
    private java.lang.String mgmtFilePath;
    
    /** MGMT_FILE_URL */
    private java.lang.String mgmtFileUrl;
    
    /** MGMT_DOWNLOAD_COUNT */
    private int mgmtDownloadCount;
    
    /** MGMT_INSERT_PATH */
    private java.lang.String mgmtInsertPath;
    
    /** MGMT_FILE_PATH_URL */
    private java.lang.String mgmtFilePathUrl;
    
    /** isdelYn */
    private java.lang.String isdelYn = "Y";
    
    /** pageYn */
    private java.lang.String pageYn = "Y";
    
    /** updateCondition */
    private java.lang.String updateCondition = "0";
    
    /** MGMT_SORT */
    private int mgmtSort;
    
    /** selectCondition */
    private java.lang.String selectCondition = "0";
    
    /** BOARD_ID */
    private java.lang.String boardId;
    
    /**	BOARD_COUNT */
    private java.lang.String boardCount;
    
    /** BOARD_TYPE */
    private java.lang.String boardSkin;
    
    /** THUMB_WIDTH */
    private int thumbWidth = 300;
    
    /** THUMB_HEIGTH */
    private int thumbHeight = 200;

	/**
	 * @return the thumbWidth
	 */
	public int getThumbWidth() {
		return thumbWidth;
	}

	/**
	 * @return the thumbHeight
	 */
	public int getThumbHeight() {
		return thumbHeight;
	}

	/**
	 * @param thumbWidth the thumbWidth to set
	 */
	public void setThumbWidth(int thumbWidth) {
		this.thumbWidth = thumbWidth;
	}

	/**
	 * @param thumbHeight the thumbHeight to set
	 */
	public void setThumbHeight(int thumbHeight) {
		this.thumbHeight = thumbHeight;
	}	

	/**
	 * @return the boardSkin
	 */
	public java.lang.String getBoardSkin() {
		return boardSkin;
	}

	/**
	 * @param boardSkin the boardSkin to set
	 */
	public void setBoardSkin(java.lang.String boardSkin) {
		this.boardSkin = boardSkin;
	}

	/**
	 * @return the boardId
	 */
	public java.lang.String getBoardId() {
		return boardId;
	}

	/**
	 * @return the boardCount
	 */
	public java.lang.String getBoardCount() {
		return boardCount;
	}

	/**
	 * @param boardId the boardId to set
	 */
	public void setBoardId(java.lang.String boardId) {
		this.boardId = boardId;
	}

	/**
	 * @param boardCount the boardCount to set
	 */
	public void setBoardCount(java.lang.String boardCount) {
		this.boardCount = boardCount;
	}	

	/** BOARD_
    
    /**
	 * @return the mgmtInsertPath
	 */
	public java.lang.String getMgmtInsertPath() {
		return mgmtInsertPath;
	}

	/**
	 * @param mgmtInsertPath the mgmtInsertPath to set
	 */
	public void setMgmtInsertPath(java.lang.String mgmtInsertPath) {
		this.mgmtInsertPath = mgmtInsertPath;
	}

	/**
	 * @return the mgmtDownloadCount
	 */
	public int getMgmtDownloadCount() {
		return mgmtDownloadCount;
	}

	/**
	 * @param mgmtDownloadCount the mgmtDownloadCount to set
	 */
	public void setMgmtDownloadCount(int mgmtDownloadCount) {
		this.mgmtDownloadCount = mgmtDownloadCount;
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
	 * @return the mgmtSort
	 */
	public int getMgmtSort() {
		return mgmtSort;
	}

	/**
	 * @param mgmtSort the mgmtSort to set
	 */
	public void setMgmtSort(int mgmtSort) {
		this.mgmtSort = mgmtSort;
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
	 * @return the mgmtFilePathUrl
	 */
	public java.lang.String getMgmtFilePathUrl() {
		return mgmtFilePathUrl;
	}

	/**
	 * @param mgmtFilePathUrl the mgmtFilePathUrl to set
	 */
	public void setMgmtFilePathUrl(java.lang.String mgmtFilePathUrl) {
		this.mgmtFilePathUrl = mgmtFilePathUrl;
	}

	/**
	 * @return the mgmtContent
	 */
	public java.lang.String getMgmtContent() {
		return mgmtContent;
	}

	/**
	 * @param mgmtContent the mgmtContent to set
	 */
	public void setMgmtContent(java.lang.String mgmtContent) {
		this.mgmtContent = mgmtContent;
	}

	/**
	 * @return the mgmtNm
	 */
	public java.lang.String getMgmtNm() {
		return mgmtNm;
	}

	/**
	 * @param mgmtNm the mgmtNm to set
	 */
	public void setMgmtNm(java.lang.String mgmtNm) {
		this.mgmtNm = mgmtNm;
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
	 * @return the created
	 */
	public java.util.Date getCreated() {
		return created;
	}

	/**
	 * @param created the created to set
	 */
	public void setCreated(java.util.Date created) {
		this.created = created;
	}

	/**
	 * @return the modified
	 */
	public java.util.Date getModified() {
		return modified;
	}

	/**
	 * @param modified the modified to set
	 */
	public void setModified(java.util.Date modified) {
		this.modified = modified;
	}

	/**
	 * @return the mgmtHearderYn
	 */
	public int getMgmtHearderYn() {
		return mgmtHearderYn;
	}

	/**
	 * @param mgmtHearderYn the mgmtHearderYn to set
	 */
	public void setMgmtHearderYn(int mgmtHearderYn) {
		this.mgmtHearderYn = mgmtHearderYn;
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

	public java.lang.String getSiteId() {
        return this.siteId;
    }
    
    public void setSiteId(java.lang.String siteId) {
        this.siteId = siteId;
    }
    
    public java.lang.String getMgmtId() {
        return this.mgmtId;
    }
    
    public void setMgmtId(java.lang.String mgmtId) {
        this.mgmtId = mgmtId;
    }
    
    public java.lang.String getMgmtType() {
        return this.mgmtType;
    }
    
    public void setMgmtType(java.lang.String mgmtType) {
        this.mgmtType = mgmtType;
    }
    
    public java.lang.String getMgmtScriptType() {
        return this.mgmtScriptType;
    }
    
    public void setMgmtScriptType(java.lang.String mgmtScriptType) {
        this.mgmtScriptType = mgmtScriptType;
    }
    
    public java.lang.String getMgmtActId() {
        return this.mgmtActId;
    }
    
    public void setMgmtActId(java.lang.String mgmtActId) {
        this.mgmtActId = mgmtActId;
    }  
    
    public java.lang.String getMgmtFileNm() {
        return this.mgmtFileNm;
    }
    
    public void setMgmtFileNm(java.lang.String mgmtFileNm) {
        this.mgmtFileNm = mgmtFileNm;
    }
    
    public java.lang.String getMgmtFileOrigin() {
        return this.mgmtFileOrigin;
    }
    
    public void setMgmtFileOrigin(java.lang.String mgmtFileOrigin) {
        this.mgmtFileOrigin = mgmtFileOrigin;
    }
    
    public java.lang.String getMgmtFilePath() {
        return this.mgmtFilePath;
    }
    
    public void setMgmtFilePath(java.lang.String mgmtFilePath) {
        this.mgmtFilePath = mgmtFilePath;
    }
    
    public java.lang.String getMgmtFileUrl() {
        return this.mgmtFileUrl;
    }
    
    public void setMgmtFileUrl(java.lang.String mgmtFileUrl) {
        this.mgmtFileUrl = mgmtFileUrl;
    }
}
