package jnit.cms.menutree;

import java.util.List;

/**
 * @Class Name : JnitcmsmenutreeVO.java
 * @Description : Jnitcmsmenutree VO class
 * @Modification Information
 *
 * @author jnitcmsmenutree
 * @since 2018.01.03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmenutreeVO extends JnitcmsmenutreeDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** MENU_CODE_ID */
    private java.lang.String menuCodeId;
    
    /** MENU_ID */
    private java.lang.String menuId;
    
    /** MENU_NAME */
    private java.lang.String menuName;
    
    /** MENU_LINK */
    private java.lang.String menuLink;
    
    /** MENU_DEPTH */
    private int menuDepth;
    
    /** MENU_ICON */
    private java.lang.String menuIcon;
    
    /** MENU_ACTIVE */
    private int menuActive;
    
    /** MENU_PARENT */
    private java.lang.String menuParent;
    
    /** MENU_CHILD */
    private int menuChild;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private int isdel;
    
    private List<JnitcmsmenutreeVO> child;
    
    public java.lang.String getMenuCodeId() {
        return this.menuCodeId;
    }
    
    public void setMenuCodeId(java.lang.String menuCodeId) {
        this.menuCodeId = menuCodeId;
    }
    
    public java.lang.String getMenuId() {
        return this.menuId;
    }
    
    public void setMenuId(java.lang.String menuId) {
        this.menuId = menuId;
    }
    
    public java.lang.String getMenuName() {
        return this.menuName;
    }
    
    public void setMenuName(java.lang.String menuName) {
        this.menuName = menuName;
    }
    
    public java.lang.String getMenuLink() {
        return this.menuLink;
    }
    
    public void setMenuLink(java.lang.String menuLink) {
        this.menuLink = menuLink;
    }
    
    public int getMenuDepth() {
        return this.menuDepth;
    }
    
    public void setMenuDepth(int menuDepth) {
        this.menuDepth = menuDepth;
    }
    
    public java.lang.String getMenuIcon() {
        return this.menuIcon;
    }
    
    public void setMenuIcon(java.lang.String menuIcon) {
        this.menuIcon = menuIcon;
    }
    
    public int getMenuActive() {
        return this.menuActive;
    }
    
    public void setMenuActive(int menuActive) {
        this.menuActive = menuActive;
    }
    
    public java.lang.String getMenuParent() {
        return this.menuParent;
    }
    
    public void setMenuParent(java.lang.String menuParent) {
        this.menuParent = menuParent;
    }
    
    public int getMenuChild() {
        return this.menuChild;
    }
    
    public void setMenuChild(int menuChild) {
        this.menuChild = menuChild;
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

	public List<JnitcmsmenutreeVO> getChild() {
		return child;
	}

	public void setChild(List<JnitcmsmenutreeVO> child) {
		this.child = child;
	}

}
