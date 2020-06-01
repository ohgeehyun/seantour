/**
 * @version 3.2.0.1
 */
package jnit.cms.hist;

/**
 * @Class Name : JnitcmshistVO.java
 * @Description : Jnitcmshist VO class
 * @Modification Information
 *
 * @author tactful
 * @since 2012.12.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmshistVO extends JnitcmshistDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** HIST_ID */
    private java.lang.String histId;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** MENU_ID */
    private java.lang.String menuId;
    
    /** CNT_ID */
    private java.lang.String cntId;
    
    /** CNT_DESC */
    private java.lang.String cntDesc;
    
    /** CNT_SRC */
    private java.lang.String cntSrc;
    
    /** TPL_ID */
    private java.lang.String tplId;
    
    /** CREATED */
    private java.util.Date created;
    
    /** RESERVED */
    private java.util.Date reserved;
    
    public java.lang.String getHistId() {
        return this.histId;
    }
    
    public void setHistId(java.lang.String histId) {
        this.histId = histId;
    }
    
    public java.lang.String getSiteId() {
        return this.siteId;
    }
    
    public void setSiteId(java.lang.String siteId) {
        this.siteId = siteId;
    }
    
    public java.lang.String getMenuId() {
        return this.menuId;
    }
    
    public void setMenuId(java.lang.String menuId) {
        this.menuId = menuId;
    }
    
    public java.lang.String getCntId() {
        return this.cntId;
    }
    
    public void setCntId(java.lang.String cntId) {
        this.cntId = cntId;
    }
    
    public java.lang.String getCntDesc() {
        return this.cntDesc;
    }
    
    public void setCntDesc(java.lang.String cntDesc) {
        this.cntDesc = cntDesc;
    }
    
    public java.lang.String getCntSrc() {
        return this.cntSrc;
    }
    
    public void setCntSrc(java.lang.String cntSrc) {
        this.cntSrc = cntSrc;
    }
    
    public java.lang.String getTplId() {
        return this.tplId;
    }
    
    public void setTplId(java.lang.String tplId) {
        this.tplId = tplId;
    }
    
    public java.util.Date getCreated() {
        return this.created;
    }
    
    public void setCreated(java.util.Date created) {
        this.created = created;
    }
    
    public java.util.Date getReserved() {
        return this.reserved;
    }
    
    public void setReserved(java.util.Date reserved) {
        this.reserved = reserved;
    }
    
}
