/**
 * @version 3.2.0.1
 */
package jnit.cms.site;

/**
 * @Class Name : JnitcmssiteVO.java
 * @Description : Jnitcmssite VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmssiteVO extends JnitcmssiteDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** SITE_NM */
    private java.lang.String siteNm;
    
    /** SITE_PATH */
    private java.lang.String sitePath;
    
    /** SITE_ORD */
    private int siteOrd;
    
    /** ADM_MBR_ID */
    private java.lang.String admMbrId;
    
    /** ACTIVE */
    private byte active;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private int isdel;
    
    /** selectCondition */
    private java.lang.String selectCondition = "0";
    
	
    /** LANG */
    private java.lang.String lang;

    
    /**
	 * @return the lang
	 */
	public java.lang.String getLang() {
		return lang;
	}

	/**
	 * @param lang the lang to set
	 */
	public void setLang(java.lang.String lang) {
		this.lang = lang;
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

	public java.lang.String getSiteId() {
        return this.siteId;
    }
    
    public void setSiteId(java.lang.String siteId) {
        this.siteId = siteId;
    }
    
    public java.lang.String getSiteNm() {
        return this.siteNm;
    }
    
    public void setSiteNm(java.lang.String siteNm) {
        this.siteNm = siteNm;
    }
    
    public java.lang.String getSitePath() {
        return this.sitePath;
    }
    
    public void setSitePath(java.lang.String sitePath) {
        this.sitePath = sitePath;
    }
    
    public byte getActive() {
        return (this.active == 0 ? 0 : this.active);
    }
    
    public void setActive(byte active) {
        this.active = active;
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
        return (this.isdel == 0 ? 0 : this.isdel);
    }
    
    public void setIsdel(int isdel) {
        this.isdel = isdel;
    }

	public void setSiteOrd(int siteOrd) {
		this.siteOrd = siteOrd;
	}

	public int getSiteOrd() {
		return siteOrd;
	}

	public void setAdmMbrId(java.lang.String admMbrId) {
		this.admMbrId = admMbrId;
	}

	public java.lang.String getAdmMbrId() {
		return admMbrId;
	}
    
}
