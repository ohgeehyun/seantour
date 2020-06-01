/**
 * @version 3.2.0.1
 */
package jnit.cms.cntvt;

/**
 * @Class Name : JnitcmscntvtVO.java
 * @Description : Jnitcmscntvt VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmscntvtVO extends JnitcmscntvtDefaultVO{
    private static final long serialVersionUID = 1L;

    /** CNT_ID */
    private java.lang.String cntId;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** MENU_ID */
    private java.lang.String menuId;
    
    /** ISMAIN */
    private byte ismain;
    
    /** MENU_NM */
    private java.lang.String menuNm;
    
    /** MENU_PATH */
    private java.lang.String menuPath;
    
    /** PID */
    private java.lang.String pid;
    
    /** DEPTH */
    private int depth;
    
    /** METHOD */
    private int method;
    
    /** CNT_DESC */
    private java.lang.String cntDesc;
    
    /** CNT_SRC */
    private java.lang.String cntSrc;
    
    /** TPL_ID */
    private java.lang.String tplId;

    /** TPL_NM */
	private String tplNm;
	
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private byte isdel;

    
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
    
    public byte getIsmain() {
        return this.ismain;
    }
    
    public void setIsmain(byte ismain) {
        this.ismain = ismain;
    }
    
    public java.lang.String getMenuNm() {
        return this.menuNm;
    }
    
    public void setMenuNm(java.lang.String menuNm) {
        this.menuNm = menuNm;
    }
    
    public java.lang.String getMenuPath() {
        return this.menuPath;
    }
    
    public void setMenuPath(java.lang.String menuPath) {
        this.menuPath = menuPath;
    }
    
    public java.lang.String getPid() {
        return this.pid;
    }
    
    public void setPid(java.lang.String pid) {
        this.pid = pid;
    }
    
    public int getDepth() {
        return this.depth;
    }
    
    public void setDepth(int depth) {
        this.depth = depth;
    }
    
    public int getMethod() {
        return this.method;
    }
    
    public void setMethod(int method) {
        this.method = method;
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
    
    public java.lang.String getTplNm() {
        return this.tplNm;
    }
    
    public void setTplNm(java.lang.String tplNm) {
        this.tplNm = tplNm;
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
        return this.isdel;
    }
    
    public void setIsdel(byte isdel) {
        this.isdel = isdel;
    }
    
}
