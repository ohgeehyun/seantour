/**
 * @version 3.2.0.1
 */
package jnit.cms.cnt;

/**
 * @Class Name : JnitcmscntVO.java
 * @Description : Jnitcmscnt VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmscntVO extends JnitcmscntDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** MENU_ID */
    private java.lang.String menuId;
    
    /** SEARCH MENU_ID */
    private java.lang.String searchMenuId;
    
    /** CNT_ID */
    private java.lang.String cntId;
    
    /** ISMAIN */
    private byte ismain;
    
    /** CNT_DESC */
    private java.lang.String cntDesc;
    
    /** CNT_SRC */
    private java.lang.String cntSrc;
    
    /** TPL_ID */
    private java.lang.String tplId;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private byte isdel;
    
    /** CNT_WEB_STANDARD */
    private int cntWebStandard;
    
    /** CNT_WEB_STANDARD */
    private int cntWebStandardCss;
    
    /** CNT_WEB_Access */
    private int cntWebAccess;
    
    /** updateCondition */
    private java.lang.String updateCondition = "0";
    
    /** pageYn */
    private java.lang.String pageYn = "Y";
    
    /** isdelYn */
    private java.lang.String isdelYn = "Y";
    
    /** selectCondition */
    private java.lang.String selectCondition = "0";
    
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
	 * @return the cntWebStandard
	 */
	public int getCntWebStandard() {
		return cntWebStandard;
	}

	/**
	 * @param cntWebStandard the cntWebStandard to set
	 */
	public void setCntWebStandard(int cntWebStandard) {
		this.cntWebStandard = cntWebStandard;
	}

	/**
	 * @return the cntWebStandardCss
	 */
	public int getCntWebStandardCss() {
		return cntWebStandardCss;
	}

	/**
	 * @param cntWebStandardCss the cntWebStandardCss to set
	 */
	public void setCntWebStandardCss(int cntWebStandardCss) {
		this.cntWebStandardCss = cntWebStandardCss;
	}

	/**
	 * @return the cntWebAccess
	 */
	public int getCntWebAccess() {
		return cntWebAccess;
	}

	/**
	 * @param cntWebAccess the cntWebAccess to set
	 */
	public void setCntWebAccess(int cntWebAccess) {
		this.cntWebAccess = cntWebAccess;
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
    
    public java.lang.String getSearchMenuId() {
		return searchMenuId;
	}

	public void setSearchMenuId(java.lang.String searchMenuId) {
		this.searchMenuId = searchMenuId;
	}

	public java.lang.String getCntId() {
        return this.cntId;
    }
    
    public void setCntId(java.lang.String cntId) {
        this.cntId = cntId;
    }
    
    public byte getIsmain() {
        return this.ismain;
    }
    
    public void setIsmain(byte ismain) {
        this.ismain = ismain;
    }
    
    public java.lang.String getCntDesc() {
        return this.cntDesc;
    }
    
    public void setCntDesc(java.lang.String cntDesc) {
        this.cntDesc = cntDesc;
    }
    
    public java.lang.String getCntSrc() {
        return this.cntSrc;
    }
    
    public void setCntSrc(java.lang.String cntSrc) {
        this.cntSrc = cntSrc;
    }
    
    public java.lang.String getTplId() {
        return this.tplId;
    }
    
    public void setTplId(java.lang.String tplId) {
        this.tplId = tplId;
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
    
    public byte getIsdel() {
        return this.isdel;
    }
    
    public void setIsdel(byte isdel) {
        this.isdel = isdel;
    }
    
}
