/**
 * @version 3.2.0.1
 */
package jnit.login.log;

/**
 * @Class Name : JnitloginlogVO.java
 * @Description : Jnitloginlog VO class
 * @Modification Information
 *
 * @author JNITLOGINLOG
 * @since 2013.07.30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitloginlogVO extends JnitloginlogDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** IP_ID */
    private java.lang.String ipId;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** IP_ADDR */
    private java.lang.String ipAddr;
    
    /** CREATED */
    private java.util.Date created;
    
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

	public java.lang.String getIpId() {
        return this.ipId;
    }
    
    public void setIpId(java.lang.String ipId) {
        this.ipId = ipId;
    }
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.lang.String getIpAddr() {
        return this.ipAddr;
    }
    
    public void setIpAddr(java.lang.String ipAddr) {
        this.ipAddr = ipAddr;
    }
    
    public java.util.Date getCreated() {
        return this.created;
    }
    
    public void setCreated(java.util.Date created) {
        this.created = created;
    }
    
}
