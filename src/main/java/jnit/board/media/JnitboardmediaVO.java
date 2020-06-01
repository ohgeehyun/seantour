package jnit.board.media;

import java.util.Date;

/**
 * @Class Name : JnitboardmediaVO.java
 * @Description : Jnitboardmedia VO class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.01.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitboardmediaVO extends JnitboardmediaDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** BOARD_JNITMEDIA_ID */
    private int jnitmediaId;
    
    /** ORG_NM */
    private java.lang.String orgNm;
    
    /** DST_NM */
    private java.lang.String dstNm;
    
    /** SUCCESS_FLAG */
    private int successFlag;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private int isdel;

	/**
	 * @return the jnitmediaId
	 */
	public int getJnitmediaId() {
		return jnitmediaId;
	}

	/**
	 * @param jnitmediaId the jnitmediaId to set
	 */
	public void setJnitmediaId(int jnitmediaId) {
		this.jnitmediaId = jnitmediaId;
	}

	/**
	 * @return the orgNm
	 */
	public java.lang.String getOrgNm() {
		return orgNm;
	}

	/**
	 * @param orgNm the orgNm to set
	 */
	public void setOrgNm(java.lang.String orgNm) {
		this.orgNm = orgNm;
	}

	/**
	 * @return the dstNm
	 */
	public java.lang.String getDstNm() {
		return dstNm;
	}

	/**
	 * @param dstNm the dstNm to set
	 */
	public void setDstNm(java.lang.String dstNm) {
		this.dstNm = dstNm;
	}

	/**
	 * @return the successFlag
	 */
	public int getSuccessFlag() {
		return successFlag;
	}

	/**
	 * @param successFlag the successFlag to set
	 */
	public void setSuccessFlag(int successFlag) {
		this.successFlag = successFlag;
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
	 * @return the modified
	 */
	public java.util.Date getModified() {
		return modified;
	}

	/**
	 * @param modified the modified to set
	 */
	public void setModified(java.util.Date modified) {
		this.modified = modified;
	}
	/**
	 * @return the isdel
	 */
	public int getIsdel() {
		return isdel;
	}

	/**
	 * @param isdel the isdel to set
	 */
	public void setIsdel(int isdel) {
		this.isdel = isdel;
	}
    
}
