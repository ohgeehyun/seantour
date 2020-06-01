/**
 * @version 3.2.0.1
 */
package jnit.cms.disseminate;

/**
 * @Class Name : JnitcmsdisseminateVO.java
 * @Description : Jnitcmsdisseminate VO class
 * @Modification Information
 *
 * @author JNITCMSDISSEMINATE
 * @since 2013.11.05
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsdisseminateVO extends JnitcmsdisseminateDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** DISSEMINATE_ID */
    private java.lang.String disseminateId;
    
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
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** DISSEMINATE_CONFIRM */
    private int disseminateConfirm;
    
    /** DISSEMINATE_MEMO */
    private java.lang.String disseminateMemo;
    
    /** CONTENT_CONFIRM */
    private int contentConfirm;
    
    /** DISSEMINATE_DAY */
    private java.util.Date disseminateDay;
    
    /** DISSEMINATE_HISTORY_ID */
    private java.lang.String disseminateHistoryId;
    
    /** DISSEMINATE_NAME */
    private java.lang.String disseminateName;
    
    /** DISSEMINATE_NUM */
    private java.lang.String disseminateNum;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private int isdel;
    
    /** DISSEMINATE_STAND */
    private int disseminateStand;
    
    /** MBR_NM*/
    private java.lang.String mbrNm;
    
    /** update Stand 사용여부 */
    private java.lang.String isStand;
    
    /** update Num 사용여부 */
    private java.lang.String isNum;
    
    /** update disseminateId 사용여부 */
    private java.lang.String disseminateIdYn = "Y";
    
    /** update cntId 사용여부 */
    private java.lang.String cntIdYn = "N";
    
    /** 페이지 네비 사용여부 */
    private java.lang.String pageYn ="Y";
    
    /** isdelYn 사용여부 */
    private java.lang.String isdelYn = "Y";
    
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
	 * @return the cntIdYn
	 */
	public java.lang.String getCntIdYn() {
		return cntIdYn;
	}

	/**
	 * @param cntIdYn the cntIdYn to set
	 */
	public void setCntIdYn(java.lang.String cntIdYn) {
		this.cntIdYn = cntIdYn;
	}

	/**
	 * @return the disseminateIdYn
	 */
	public java.lang.String getDisseminateIdYn() {
		return disseminateIdYn;
	}

	/**
	 * @param disseminateIdYn the disseminateIdYn to set
	 */
	public void setDisseminateIdYn(java.lang.String disseminateIdYn) {
		this.disseminateIdYn = disseminateIdYn;
	}

	/**
	 * @return the isNum
	 */
	public java.lang.String getIsNum() {
		return isNum;
	}

	/**
	 * @param isNum the isNum to set
	 */
	public void setIsNum(java.lang.String isNum) {
		this.isNum = isNum;
	}

	/**
	 * @return the isStand
	 */
	public java.lang.String getIsStand() {
		return isStand;
	}

	/**
	 * @param isStand the isStand to set
	 */
	public void setIsStand(java.lang.String isStand) {
		this.isStand = isStand;
	}

	/**
	 * @return the mbrNm
	 */
	public java.lang.String getMbrNm() {
		return mbrNm;
	}

	/**
	 * @param mbrNm the mbrNm to set
	 */
	public void setMbrNm(java.lang.String mbrNm) {
		this.mbrNm = mbrNm;
	}

	/**
	 * @return the disseminateStand
	 */
	public int getDisseminateStand() {
		return disseminateStand;
	}

	/**
	 * @param disseminateStand the disseminateStand to set
	 */
	public void setDisseminateStand(int disseminateStand) {
		this.disseminateStand = disseminateStand;
	}

	public java.lang.String getDisseminateId() {
        return this.disseminateId;
    }
    
    public void setDisseminateId(java.lang.String disseminateId) {
        this.disseminateId = disseminateId;
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
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public int getDisseminateConfirm() {
        return this.disseminateConfirm;
    }
    
    public void setDisseminateConfirm(int disseminateConfirm) {
        this.disseminateConfirm = disseminateConfirm;
    }
    
    public java.lang.String getDisseminateMemo() {
        return this.disseminateMemo;
    }
    
    public void setDisseminateMemo(java.lang.String disseminateMemo) {
        this.disseminateMemo = disseminateMemo;
    }
    
    public int getContentConfirm() {
        return this.contentConfirm;
    }
    
    public void setContentConfirm(int contentConfirm) {
        this.contentConfirm = contentConfirm;
    }
    
    public java.util.Date getDisseminateDay() {
        return this.disseminateDay;
    }
    
    public void setDisseminateDay(java.util.Date disseminateDay) {
        this.disseminateDay = disseminateDay;
    }
    
    public java.lang.String getDisseminateHistoryId() {
        return this.disseminateHistoryId;
    }
    
    public void setDisseminateHistoryId(java.lang.String disseminateHistoryId) {
        this.disseminateHistoryId = disseminateHistoryId;
    }
    
    public String getDisseminateName() {
        return this.disseminateName;
    }
    
    public void setDisseminateName(String disseminateName) {
        this.disseminateName = disseminateName;
    }
    
    public java.lang.String getDisseminateNum() {
        return this.disseminateNum;
    }
    
    public void setDisseminateNum(java.lang.String disseminateNum) {
        this.disseminateNum = disseminateNum;
    }
    
    public java.util.Date getCreated() {
        return this.created;
    }
    
    public void setCreated(java.util.Date created) {
        this.created = created;
    }
    
    public java.util.Date getModified() {
        return this.modified;
    }
    
    public void setModified(java.util.Date modified) {
        this.modified = modified;
    }
    
    public int getIsdel() {
        return this.isdel;
    }
    
    public void setIsdel(int isdel) {
        this.isdel = isdel;
    }
    
}
