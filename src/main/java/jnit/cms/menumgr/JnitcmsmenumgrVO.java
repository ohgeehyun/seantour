/**
 * @version 3.2.0.1
 */
package jnit.cms.menumgr;

/**
 * @Class Name : JnitcmsmenumgrVO.java
 * @Description : Jnitcmsmenumgr VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmenumgrVO extends JnitcmsmenumgrDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** MENU_ID */
    private java.lang.String menuId;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** MGR_LV */
    private int mgrLv;
    
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
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public int getMgrLv() {
        return this.mgrLv;
    }
    
    public void setMgrLv(int mgrLv) {
        this.mgrLv = mgrLv;
    }
    
}
