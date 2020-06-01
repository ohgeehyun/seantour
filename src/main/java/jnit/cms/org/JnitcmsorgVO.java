/**
 * @version 3.2.0.1
 */
package jnit.cms.org;

/**
 * @Class Name : JnitcmsorgVO.java
 * @Description : Jnitcmsorg VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsorgVO extends JnitcmsorgDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** ORG_ID */
    private java.lang.String orgId;
    
    /** ORG_NM */
    private java.lang.String orgNm;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private byte isdel;
    
    /** ORG_Deth */
    private java.lang.String orgDeth;
    
    /** ORG_RANK_ODR */
    private int orgRankOdr;
    
    /** DB 연결 타입 */
    private java.lang.String connectType;
    
    /** ORG_TEL */
    private java.lang.String orgTel;
    
    /**
	 * @return the orgRankOdr
	 */
	public int getOrgRankOdr() {
		return orgRankOdr;
	}

	/**
	 * @param orgRankOdr the orgRankOdr to set
	 */
	public void setOrgRankOdr(int orgRankOdr) {
		this.orgRankOdr = orgRankOdr;
	}

	/**
	 * @return the orgTel
	 */
	public java.lang.String getOrgTel() {
		return orgTel;
	}

	/**
	 * @param orgTel the orgTel to set
	 */
	public void setOrgTel(java.lang.String orgTel) {
		this.orgTel = orgTel;
	}

	/**
	 * @return the connectType
	 */
	public java.lang.String getConnectType() {
		return connectType;
	}

	/**
	 * @param connectType the connectType to set
	 */
	public void setConnectType(java.lang.String connectType) {
		this.connectType = connectType;
	}

	/**
	 * @return the orgDeth
	 */
	public java.lang.String getOrgDeth() {
		return orgDeth;
	}

	/**
	 * @param orgDeth the orgDeth to set
	 */
	public void setOrgDeth(java.lang.String orgDeth) {
		this.orgDeth = orgDeth;
	}

	public java.lang.String getOrgId() {
        return this.orgId;
    }
    
    public void setOrgId(java.lang.String orgId) {
        this.orgId = orgId;
    }
    
    public java.lang.String getOrgNm() {
        return this.orgNm;
    }
    
    public void setOrgNm(java.lang.String orgNm) {
        this.orgNm = orgNm;
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
        return (this.isdel == 0 ? 0 : this.isdel);
    }
    
    public void setIsdel(byte isdel) {
        this.isdel = isdel;
    }
    
}
