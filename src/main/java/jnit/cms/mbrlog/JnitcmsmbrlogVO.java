/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrlog;

/**
 * @Class Name : JnitcmsmbrlogVO.java
 * @Description : Jnitcmsmbrlog VO class
 * @Modification Information
 *
 * @author JNITCMSMBRLOG
 * @since 2014.03.09
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmbrlogVO extends JnitcmsmbrlogDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** MBRLOG_ID */
    private java.lang.String mbrlogId;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** MBRLOG_CONTENT */
    private java.lang.String mbrlogContent;
    
    /** MBRLOG_STATUS */
    private int mbrlogStatus;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MBR_NM */
    private java.lang.String mbrNm;
    
    /** MBR_LOGIN */
    private java.lang.String mbrLogin;
    
    /** MBR_IP */
    private java.lang.String mbrIp;
    
    /** ACT_MBR_ID */
    private java.lang.String actMbrLogin;
    
    /** MBRLOG_PATH */
    private java.lang.String mbrlogPath;
    
    /** MBRLOG_EXT01 */
    private java.lang.String mbrlogExt01;

	/**
	 * @return the mbrlogExt01
	 */
	public java.lang.String getMbrlogExt01() {
		return mbrlogExt01;
	}

	/**
	 * @param mbrlogExt01 the mbrlogExt01 to set
	 */
	public void setMbrlogExt01(java.lang.String mbrlogExt01) {
		this.mbrlogExt01 = mbrlogExt01;
	}

	/**
	 * @return the actMbrLogin
	 */
	public java.lang.String getActMbrLogin() {
		return actMbrLogin;
	}

	/**
	 * @param actMbrLogin the actMbrLogin to set
	 */
	public void setActMbrLogin(java.lang.String actMbrLogin) {
		this.actMbrLogin = actMbrLogin;
	}

	/**
	 * @return the mbrlogPath
	 */
	public java.lang.String getMbrlogPath() {
		return mbrlogPath;
	}

	/**
	 * @param mbrlogPath the mbrlogPath to set
	 */
	public void setMbrlogPath(java.lang.String mbrlogPath) {
		this.mbrlogPath = mbrlogPath;
	}

	/**
	 * @return the mbrIp
	 */
	public java.lang.String getMbrIp() {
		return mbrIp;
	}

	/**
	 * @param mbrIp the mbrIp to set
	 */
	public void setMbrIp(java.lang.String mbrIp) {
		this.mbrIp = mbrIp;
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
	 * @return the mbrLogin
	 */
	public java.lang.String getMbrLogin() {
		return mbrLogin;
	}

	/**
	 * @param mbrLogin the mbrLogin to set
	 */
	public void setMbrLogin(java.lang.String mbrLogin) {
		this.mbrLogin = mbrLogin;
	}

	/** pageYn */
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
	 * @return the mbrlogStatus
	 */
	public int getMbrlogStatus() {
		return mbrlogStatus;
	}

	/**
	 * @param mbrlogStatus the mbrlogStatus to set
	 */
	public void setMbrlogStatus(int mbrlogStatus) {
		this.mbrlogStatus = mbrlogStatus;
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

	public java.lang.String getMbrlogId() {
        return this.mbrlogId;
    }
    
    public void setMbrlogId(java.lang.String mbrlogId) {
        this.mbrlogId = mbrlogId;
    }
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.lang.String getMbrlogContent() {
        return this.mbrlogContent;
    }
    
    public void setMbrlogContent(java.lang.String mbrlogContent) {
        this.mbrlogContent = mbrlogContent;
    }    
}
