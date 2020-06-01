/**
 * @version 3.2.0.1
 */
package jnit.cms.boardhist;

/**
 * @Class Name : JnitcmsboardhistVO.java
 * @Description : Jnitcmsboardhist VO class
 * @Modification Information
 *
 * @author JNITCMSBOARDHIST
 * @since 2014.08.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsboardhistVO extends JnitcmsboardhistDefaultVO{
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
    
    /** MGMT_ACT_IP */
    private java.lang.String mgmtActIp;
    
    /** CREATED */
    private java.util.Date created;
    
    /** BOARD_SKIN */
    private java.lang.String boardSkin;
    
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
    
    public java.lang.String getMgmtActIp() {
        return this.mgmtActIp;
    }
    
    public void setMgmtActIp(java.lang.String mgmtActIp) {
        this.mgmtActIp = mgmtActIp;
    }
}
