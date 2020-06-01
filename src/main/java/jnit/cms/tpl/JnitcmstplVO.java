/**
 * @version 3.2.0.1
 */
package jnit.cms.tpl;

/**
 * @Class Name : JnitcmstplVO.java
 * @Description : Jnitcmstpl VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmstplVO extends JnitcmstplDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** TPL_ID */
    private java.lang.String tplId;
    
    /** TPL_TYPE */
    private java.lang.String tplType;
    
    /** TPL_NM */
    private java.lang.String tplNm;
    
    /** TPL_DESC */
    private java.lang.String tplDesc;
    
    /** TPL_SRC */
    private java.lang.String tplSrc;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private int isdel;
    
    private int staticType;
    
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
    
    public java.lang.String getTplType() {
        return this.tplType;
    }
    
    public void setTplType(java.lang.String tplType) {
        this.tplType = tplType;
    }
    
    public java.lang.String getTplNm() {
        return this.tplNm;
    }
    
    public void setTplNm(java.lang.String tplNm) {
        this.tplNm = tplNm;
    }
    
    public java.lang.String getTplDesc() {
        return this.tplDesc;
    }
    
    public void setTplDesc(java.lang.String tplDesc) {
        this.tplDesc = tplDesc;
    }
    
    public java.lang.String getTplSrc() {
        return this.tplSrc;
    }
    
    public void setTplSrc(java.lang.String tplSrc) {
        this.tplSrc = tplSrc;
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

	public int getStaticType() {
		return staticType;
	}

	public void setStaticType(int staticType) {
		this.staticType = staticType;
	}
    
    
    
}
