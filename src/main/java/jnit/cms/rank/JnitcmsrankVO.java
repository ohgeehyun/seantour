/**
 * @version 3.2.0.1
 */
package jnit.cms.rank;

/**
 * @Class Name : JnitcmsrankVO.java
 * @Description : Jnitcmsrank VO class
 * @Modification Information
 *
 * @author JNITCMSRANK
 * @since 2013.11.17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsrankVO extends JnitcmsrankDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** RANK_ID */
    private java.lang.String rankId;
    
    /** RANK_NAME */
    private java.lang.String rankName;
    
    /** CREATED */
    private java.sql.Date created;
    
    /** MODIFIED */
    private java.sql.Date modified;
    
    /** ISDEL */
    private int isdel;
    
    /** ORG_ID */
    private java.lang.String orgId;
    
    /** DB 연결 타입 */
    private java.lang.String connectType;
    
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
	 * @return the orgId
	 */
	public java.lang.String getOrgId() {
		return orgId;
	}

	/**
	 * @param orgId the orgId to set
	 */
	public void setOrgId(java.lang.String orgId) {
		this.orgId = orgId;
	}

	public java.lang.String getRankId() {
        return this.rankId;
    }
    
    public void setRankId(java.lang.String rankId) {
        this.rankId = rankId;
    }
    
    public java.lang.String getRankName() {
        return this.rankName;
    }
    
    public void setRankName(java.lang.String rankName) {
        this.rankName = rankName;
    }
    
    public java.sql.Date getCreated() {
        return this.created;
    }
    
    public void setCreated(java.sql.Date created) {
        this.created = created;
    }
    
    public java.sql.Date getModified() {
        return this.modified;
    }
    
    public void setModified(java.sql.Date modified) {
        this.modified = modified;
    }
    
    public int getIsdel() {
        return this.isdel;
    }
    
    public void setIsdel(int isdel) {
        this.isdel = isdel;
    }
    
}
