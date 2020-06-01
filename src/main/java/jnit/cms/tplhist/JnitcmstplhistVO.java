/**
 * @version 3.2.0.1
 */
package jnit.cms.tplhist;

/**
 * @Class Name : JnitcmstplhistVO.java
 * @Description : Jnitcmstplhist VO class
 * @Modification Information
 *
 * @author JNITCMSTPLHIST
 * @since 2014.05.02
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmstplhistVO extends JnitcmstplhistDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** TPL_ID */
    private java.lang.String tplId;
    
    /** HIST_ID */
    private java.lang.String histId;
    
    /** TPL_TYPE */
    private java.lang.String tplType;
    
    /** TPL_DESC */
    private java.lang.String tplDesc;
    
    /** TPL_SRC */
    private java.lang.String tplSrc;
    
    /** ACT_MBR */
    private java.lang.String actMbr;
    
    /** CREATED */
    private java.util.Date created;
    
    /** SITE_ID 사용여부 */
    private java.lang.String siteIdYn = "Y";
    
    /** TPL_ID 사용여부 */
    private java.lang.String tplIdYn = "Y";
    
    /** ACT_IP */
    private java.lang.String actIp;
    
    /**
	 * @return the actIp
	 */
	public java.lang.String getActIp() {
		return actIp;
	}

	/**
	 * @param actIp the actIp to set
	 */
	public void setActIp(java.lang.String actIp) {
		this.actIp = actIp;
	}

	/**
	 * @return the siteIdYn
	 */
	public java.lang.String getSiteIdYn() {
		return siteIdYn;
	}

	/**
	 * @param siteIdYn the siteIdYn to set
	 */
	public void setSiteIdYn(java.lang.String siteIdYn) {
		this.siteIdYn = siteIdYn;
	}

	/**
	 * @return the tplIdYn
	 */
	public java.lang.String getTplIdYn() {
		return tplIdYn;
	}

	/**
	 * @param tplIdYn the tplIdYn to set
	 */
	public void setTplIdYn(java.lang.String tplIdYn) {
		this.tplIdYn = tplIdYn;
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
	 * @return the tplSrc
	 */
	public java.lang.String getTplSrc() {
		return tplSrc;
	}

	/**
	 * @param tplSrc the tplSrc to set
	 */
	public void setTplSrc(java.lang.String tplSrc) {
		this.tplSrc = tplSrc;
	}

	public java.lang.String getSiteId() {
        return this.siteId;
    }
    
    public void setSiteId(java.lang.String siteId) {
        this.siteId = siteId;
    }
    
    public java.lang.String getTplId() {
        return this.tplId;
    }
    
    public void setTplId(java.lang.String tplId) {
        this.tplId = tplId;
    }
    
    public java.lang.String getHistId() {
        return this.histId;
    }
    
    public void setHistId(java.lang.String histId) {
        this.histId = histId;
    }
    
    public java.lang.String getTplType() {
        return this.tplType;
    }
    
    public void setTplType(java.lang.String tplType) {
        this.tplType = tplType;
    }
    
    public java.lang.String getTplDesc() {
        return this.tplDesc;
    }
    
    public void setTplDesc(java.lang.String tplDesc) {
        this.tplDesc = tplDesc;
    }  
    
    public java.lang.String getActMbr() {
        return this.actMbr;
    }
    
    public void setActMbr(java.lang.String actMbr) {
        this.actMbr = actMbr;
    }
}
