/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrtype;

/**
 * @Class Name : JnitcmsmbrtypeVO.java
 * @Description : Jnitcmsmbrtype VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmbrtypeVO extends JnitcmsmbrtypeDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** TYPE_ID */
    private java.lang.String typeId;
    
    /** TYPE_NM */
    private java.lang.String typeNm;
    
    /** TYPE_LV */
    private java.lang.String typeLv;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private byte isdel;
    
    /** MENU_LIST*/
    private java.lang.String menuActive;
    
    
    public java.lang.String getTypeId() {
        return this.typeId;
    }
    
    public void setTypeId(java.lang.String typeId) {
        this.typeId = typeId;
    }
    
    public java.lang.String getTypeNm() {
        return this.typeNm;
    }
    
    public void setTypeNm(java.lang.String typeNm) {
        this.typeNm = typeNm;
    }
    
    public java.lang.String getTypeLv() {
        return this.typeLv;
    }
    
    public void setTypeLv(java.lang.String typeLv) {
        this.typeLv = typeLv;
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

	public java.lang.String getMenuActive() {
		return menuActive;
	}

	public void setMenuActive(java.lang.String menuActive) {
		this.menuActive = menuActive;
	}
    
}
