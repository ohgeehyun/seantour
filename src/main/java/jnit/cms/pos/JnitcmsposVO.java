/**
 * @version 3.2.0.1
 */
package jnit.cms.pos;

/**
 * @Class Name : JnitcmsposVO.java
 * @Description : Jnitcmspos VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsposVO extends JnitcmsposDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** POS_ID */
    private java.lang.String posId;
    
    /** POS_NM */
    private java.lang.String posNm;
    
    /** POS_LV */
    private int posLv;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private byte isdel;
    
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

	public java.lang.String getPosId() {
        return this.posId;
    }
    
    public void setPosId(java.lang.String posId) {
        this.posId = posId;
    }
    
    public java.lang.String getPosNm() {
        return this.posNm;
    }
    
    public void setPosNm(java.lang.String posNm) {
        this.posNm = posNm;
    }
    
    public int getPosLv() {
        return this.posLv;
    }
    
    public void setPosLv(int posLv) {
        this.posLv = posLv;
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
