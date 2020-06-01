/**
 * @version 3.2.0.1
 */
package jnit.cms.disseminatehisotry;

/**
 * @Class Name : JnitcmsdisseminatehistoryVO.java
 * @Description : Jnitcmsdisseminatehistory VO class
 * @Modification Information
 *
 * @author JNITCMSDISSEMINATEHISTORY
 * @since 2013.11.20
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsdisseminatehistoryVO extends JnitcmsdisseminatehistoryDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** HISTORY_ID */
    private java.lang.String historyId;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** MENU_ID */
    private java.lang.String menuId;
    
    /** CNT_ID */
    private java.lang.String cntId;
    
    /** CONTENT_PATH */
    private java.lang.String contentPath;
    
    /** DISSEMINATE_TYPE */
    private java.lang.String disseminateType;
    
    /** DISSEMINATE_LINE */
    private java.lang.String disseminateLine;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** DISEMINATE_USERCONFIRM */
    private java.lang.String disseminateUserconfirm;
    
    /** DISSEMINATE_CONFIRM */
    private int disseminateConfirm;
    
    /** DISSEMINATE_DAY */
    private java.util.Date disseminateDay;
    
    /** DISSEMINATE_CREATED */
    private java.util.Date disseminateCreated;
    
    /** MBR_ID */
    private java.lang.String historyMemo;
    
    /** pageYn 사용여부 */
    private java.lang.String pageYn = "Y";
    
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
	 * @return the historyMemo
	 */
	public java.lang.String getHistoryMemo() {
		return historyMemo;
	}

	/**
	 * @param historyMemo the historyMemo to set
	 */
	public void setHistoryMemo(java.lang.String historyMemo) {
		this.historyMemo = historyMemo;
	}

	public java.lang.String getHistoryId() {
        return this.historyId;
    }
    
    public void setHistoryId(java.lang.String historyId) {
        this.historyId = historyId;
    }
    
    public java.lang.String getSiteId() {
        return this.siteId;
    }
    
    public void setSiteId(java.lang.String siteId) {
        this.siteId = siteId;
    }
    
    public java.lang.String getMenuId() {
        return this.menuId;
    }
    
    public void setMenuId(java.lang.String menuId) {
        this.menuId = menuId;
    }
    
    public java.lang.String getCntId() {
        return this.cntId;
    }
    
    public void setCntId(java.lang.String cntId) {
        this.cntId = cntId;
    }
    
    public java.lang.String getContentPath() {
        return this.contentPath;
    }
    
    public void setContentPath(java.lang.String contentPath) {
        this.contentPath = contentPath;
    }
    
    public java.lang.String getDisseminateType() {
        return this.disseminateType;
    }
    
    public void setDisseminateType(java.lang.String disseminateType) {
        this.disseminateType = disseminateType;
    }
    
    public java.lang.String getDisseminateLine() {
        return this.disseminateLine;
    }
    
    public void setDisseminateLine(java.lang.String disseminateLine) {
        this.disseminateLine = disseminateLine;
    }
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.lang.String getDiseminateUserconfirm() {
        return this.disseminateUserconfirm;
    }
    
    public void setDiseminateUserconfirm(java.lang.String diseminateUserconfirm) {
        this.disseminateUserconfirm = diseminateUserconfirm;
    }
    
    public int getDisseminateConfirm() {
        return this.disseminateConfirm;
    }
    
    public void setDisseminateConfirm(int disseminateConfirm) {
        this.disseminateConfirm = disseminateConfirm;
    }
    
    public java.util.Date getDisseminateDay() {
        return this.disseminateDay;
    }
    
    public void setDisseminateDay(java.util.Date disseminateDay) {
        this.disseminateDay = disseminateDay;
    }
    
    public java.util.Date getDisseminateCreated() {
        return this.disseminateCreated;
    }
    
    public void setDisseminateCreated(java.util.Date disseminateCreated) {
        this.disseminateCreated = disseminateCreated;
    }
    
}
