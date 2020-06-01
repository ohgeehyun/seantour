/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrpackage;

/**
 * @Class Name : JnitcmsmbrpackageVO.java
 * @Description : Jnitcmsmbrpackage VO class
 * @Modification Information
 *
 * @author JNITCMSMBRPACKAGE
 * @since 2014.05.27
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmbrpackageVO extends JnitcmsmbrpackageDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** PACK_ID */
    private java.lang.String packId;
    
    /** PACKAGE_NM */
    private java.lang.String packageNm;
    
    /** MBR_ACCESS */
    private java.lang.String mbrAccess;
    
    /** MBR_ALLOW */
    private java.lang.String mbrDeny;
    
    /** ORG_ACCESS */
    private java.lang.String orgAccess;
    
    /** ALLOW_ORG */
    private java.lang.String orgDeny;
    
    /** POS_ACCESS */
    private java.lang.String posAccess;
    
    /** POS_ALLOW */
    private java.lang.String posDeny;
    
    /** TYPE_ACCESS */
    private java.lang.String typeAccess;
    
    /** TYPE_ALLOW */
    private java.lang.String typeDeny;
    
    /** QUERY */
    private java.lang.String query;
    
    /** COMMENT */
    private java.lang.String comment;
    
    /** ISDEL */
    private java.math.BigDecimal isdel;
    
    public java.lang.String getPackId() {
        return this.packId;
    }
    
    public void setPackId(java.lang.String packId) {
        this.packId = packId;
    }
    
    public java.lang.String getPackageNm() {
        return this.packageNm;
    }
    
    public void setPackageNm(java.lang.String packageNm) {
        this.packageNm = packageNm;
    }
    
    public java.lang.String getMbrAccess() {
        return this.mbrAccess;
    }
    
    public void setMbrAccess(java.lang.String mbrAccess) {
        this.mbrAccess = mbrAccess;
    }
    
    public java.lang.String getMbrDeny() {
        return this.mbrDeny;
    }
    
    public void setMbrDeny(java.lang.String mbrDeny) {
        this.mbrDeny = mbrDeny;
    }
    
    public java.lang.String getOrgAccess() {
        return this.orgAccess;
    }
    
    public void setOrgAccess(java.lang.String orgAccess) {
        this.orgAccess = orgAccess;
    }
    
    public java.lang.String getOrgDeny() {
		return orgDeny;
	}

	public void setOrgDeny(java.lang.String orgDeny) {
		this.orgDeny = orgDeny;
	}

	public java.lang.String getPosAccess() {
        return this.posAccess;
    }
    
    public void setPosAccess(java.lang.String posAccess) {
        this.posAccess = posAccess;
    }
    
    public java.lang.String getPosDeny() {
        return this.posDeny;
    }
    
    public void setPosDeny(java.lang.String posDeny) {
        this.posDeny = posDeny;
    }
    
    public java.lang.String getTypeAccess() {
        return this.typeAccess;
    }
    
    public void setTypeAccess(java.lang.String typeAccess) {
        this.typeAccess = typeAccess;
    }
    
    public java.lang.String getTypeDeny() {
        return this.typeDeny;
    }
    
    public void setTypeDeny(java.lang.String typeDeny) {
        this.typeDeny = typeDeny;
    }
    
    public java.lang.String getQuery() {
        return this.query;
    }
    
    public void setQuery(java.lang.String query) {
        this.query = query;
    }
    
    public java.lang.String getComment() {
		return comment;
	}

	public void setComment(java.lang.String comment) {
		this.comment = comment;
	}

	public java.math.BigDecimal getIsdel() {
        return this.isdel;
    }
    
    public void setIsdel(java.math.BigDecimal isdel) {
        this.isdel = isdel;
    }
    
}
