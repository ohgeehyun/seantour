/**
 * @version 3.2.0.1
 */
package jnit.cms.scripthist;

/**
 * @Class Name : JnitcmsscripthistVO.java
 * @Description : Jnitcmsscripthist VO class
 * @Modification Information
 *
 * @author JNITCMSSCRIPTHIST
 * @since 2014.04.18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsscripthistVO extends JnitcmsscripthistDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** MGMT_ID */
    private java.lang.String mgmtId;
    
    /** HIST_ID */
    private java.lang.String histId;
    
    /** CONTENT */
    private java.lang.String content;
    
    /** MGMT_ACT_ID */
    private java.lang.String mgmtActId;
    
    /** CREATED */
    private java.util.Date created;
    
    /** SITEID 사용여부 */
    private java.lang.String siteIdYn = "N";
    
    /** MGMTID 사용여부 */
    private java.lang.String mgmtIdYn = "N";
    
    /** MGMT_ACT_IP */
    private java.lang.String mgmtActIp;
    
    /**
	 * @return the mgmtActIp
	 */
	public java.lang.String getMgmtActIp() {
		return mgmtActIp;
	}

	/**
	 * @param mgmtActIp the mgmtActIp to set
	 */
	public void setMgmtActIp(java.lang.String mgmtActIp) {
		this.mgmtActIp = mgmtActIp;
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
	 * @return the mgmtIdYn
	 */
	public java.lang.String getMgmtIdYn() {
		return mgmtIdYn;
	}

	/**
	 * @param mgmtIdYn the mgmtIdYn to set
	 */
	public void setMgmtIdYn(java.lang.String mgmtIdYn) {
		this.mgmtIdYn = mgmtIdYn;
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
    
    public java.lang.String getHistId() {
        return this.histId;
    }
    
    public void setHistId(java.lang.String histId) {
        this.histId = histId;
    }
    
    public java.lang.String getMgmtActId() {
        return this.mgmtActId;
    }
    
    public void setMgmtActId(java.lang.String mgmtActId) {
        this.mgmtActId = mgmtActId;
    }    
}
