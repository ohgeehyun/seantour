/**
 * @version 3.2.0.1
 */
package jnit.cms.menu;

/**
 * @Class Name : JnitcmsmenuVO.java
 * @Description : Jnitcmsmenu VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.08
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmenuVO extends JnitcmsmenuDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** MENU_ID */
    private java.lang.String menuId;
    
    /** MENU_ID */
    private java.lang.String menuSearchId;
    
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
    
    /** ISLINK */
    private int islink;
    
    /** ISCNT */
    private int iscnt;
    
    /** LINKURL */
    private java.lang.String linkurl;
    
    /** LINKTGT */
    private java.lang.String linktgt;
    
    /** TPL_ID */
    private java.lang.String tplId;
    
    /** CNT_ID */
    private java.lang.String cntId;
    
    /** DEF_MENU */
    private java.lang.String defMenu;
    
    /** MENU_IMG_FILE */
    private java.lang.String menuImgFile;
    
    /** MENU_IMG_PATH */
    private java.lang.String menuImgPath;
    
    /** MENU_IMG_ONM */
    private java.lang.String menuImgOnm;
    
    /** MENU_IMG_URL */
    private java.lang.String menuImgUrl;
    
    /** ADM_MBR_ID */
    private java.lang.String admMbrId;
    
    /** ACTIVE */
    private int active;
    
    /** CCL */
    private java.lang.String ccl;
    
    /** ORIGIN_URL */
    private java.lang.String originUrl;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private int isdel;
    
    /** CONTENT_SEARCH_CHK */
    private int contentSearchChk;
    
    /** 로봇검색 유무 */
    private int robotYn;
    
    /** 상단메뉴 표출 여부 */
    private java.lang.String hDel;
    
    /** 레프트메뉴 표출 여부 */
    private java.lang.String lDel;
    
    /** 사이트맵 표출 여부 */
    private java.lang.String sDel;
    
    /** isdelYn */
    private java.lang.String isdelYn = "Y";
    
    /** siteIdYn */ 
    private java.lang.String siteIdYn = "Y";
    
    /** pageYn */
    private java.lang.String pageYn = "Y";
    
    /** 강제 이동 URL 여부 */
    private java.lang.String redirectUrl;
    
    /** updateCondition */
    private java.lang.String updateCondition = "0";
    
    /** selectCondition */
    private java.lang.String selectCondition = "0";
    
    /** MATA_TITLE */
    private java.lang.String metaTitle;
    
    /** MATA_SUBJECT */
    private java.lang.String metaSubject;
    
    /** MATA_KEYWORD */
    private java.lang.String metaKeyword;
    
    /** MATA_DESCRIPTION */
    private java.lang.String metaDescription;
    
    /** MATA_CLASSIFICATION */
    private java.lang.String metaClassification;
    
    /** MATA_REPLY */
    private java.lang.String metaRePly;
    
    /** MATA_LANGUAGE */
    private java.lang.String metaLanguage;
    
    /** MATA_BUILD */
    private java.lang.String metaBuild;

	/**
	 * @return the metaTitle
	 */
	public java.lang.String getMetaTitle() {
		return metaTitle;
	}

	/**
	 * @return the metaSubject
	 */
	public java.lang.String getMetaSubject() {
		return metaSubject;
	}

	/**
	 * @return the metaKeyword
	 */
	public java.lang.String getMetaKeyword() {
		return metaKeyword;
	}

	/**
	 * @return the metaDescription
	 */
	public java.lang.String getMetaDescription() {
		return metaDescription;
	}

	/**
	 * @return the metaClassification
	 */
	public java.lang.String getMetaClassification() {
		return metaClassification;
	}

	/**
	 * @return the metaRePly
	 */
	public java.lang.String getMetaRePly() {
		return metaRePly;
	}

	/**
	 * @return the metaLanguage
	 */
	public java.lang.String getMetaLanguage() {
		return metaLanguage;
	}

	/**
	 * @return the metaBuild
	 */
	public java.lang.String getMetaBuild() {
		return metaBuild;
	}

	/**
	 * @param metaTitle the metaTitle to set
	 */
	public void setMetaTitle(java.lang.String metaTitle) {
		this.metaTitle = metaTitle;
	}

	/**
	 * @param metaSubject the metaSubject to set
	 */
	public void setMetaSubject(java.lang.String metaSubject) {
		this.metaSubject = metaSubject;
	}

	/**
	 * @param metaKeyword the metaKeyword to set
	 */
	public void setMetaKeyword(java.lang.String metaKeyword) {
		this.metaKeyword = metaKeyword;
	}

	/**
	 * @param metaDescription the metaDescription to set
	 */
	public void setMetaDescription(java.lang.String metaDescription) {
		this.metaDescription = metaDescription;
	}

	/**
	 * @param metaClassification the metaClassification to set
	 */
	public void setMetaClassification(java.lang.String metaClassification) {
		this.metaClassification = metaClassification;
	}

	/**
	 * @param metaRePly the metaRePly to set
	 */
	public void setMetaRePly(java.lang.String metaRePly) {
		this.metaRePly = metaRePly;
	}

	/**
	 * @param metaLanguage the metaLanguage to set
	 */
	public void setMetaLanguage(java.lang.String metaLanguage) {
		this.metaLanguage = metaLanguage;
	}

	/**
	 * @param metaBuild the metaBuild to set
	 */
	public void setMetaBuild(java.lang.String metaBuild) {
		this.metaBuild = metaBuild;
	}

	/**
	 * @return the updateCondition
	 */
	public java.lang.String getUpdateCondition() {
		return updateCondition;
	}

	/**
	 * @return the selectCondition
	 */
	public java.lang.String getSelectCondition() {
		return selectCondition;
	}

	/**
	 * @param updateCondition the updateCondition to set
	 */
	public void setUpdateCondition(java.lang.String updateCondition) {
		this.updateCondition = updateCondition;
	}

	/**
	 * @param selectCondition the selectCondition to set
	 */
	public void setSelectCondition(java.lang.String selectCondition) {
		this.selectCondition = selectCondition;
	}

	/**
	 * @return the redirectUrl
	 */
	public java.lang.String getRedirectUrl() {
		return redirectUrl;
	}

	/**
	 * @param redirectUrl the redirectUrl to set
	 */
	public void setRedirectUrl(java.lang.String redirectUrl) {
		this.redirectUrl = redirectUrl;
	}

	/**
	 * @return the isdelYn
	 */
	public java.lang.String getIsdelYn() {
		return isdelYn;
	}

	/**
	 * @param isdelYn the isdelYn to set
	 */
	public void setIsdelYn(java.lang.String isdelYn) {
		this.isdelYn = isdelYn;
	}

	/**
	 * @return the siteIdYn
	 */
	public java.lang.String getSiteIdYn() {
		return siteIdYn;
	}

	/**
	 * @param siteIdYn the siteIdYn to set
	 */
	public void setSiteIdYn(java.lang.String siteIdYn) {
		this.siteIdYn = siteIdYn;
	}

	/**
	 * @return the pageYn
	 */
	public java.lang.String getPageYn() {
		return pageYn;
	}

	/**
	 * @param pageYn the pageYn to set
	 */
	public void setPageYn(java.lang.String pageYn) {
		this.pageYn = pageYn;
	}

	/**
	 * @return the sDel
	 */
	public java.lang.String getsDel() {
		return sDel;
	}

	/**
	 * @param sDel the sDel to set
	 */
	public void setsDel(java.lang.String sDel) {
		this.sDel = sDel;
	}

	/**
	 * @return the robotYn
	 */
	public int getRobotYn() {
		return robotYn;
	}

	/**
	 * @param robotYn the robotYn to set
	 */
	public void setRobotYn(int robotYn) {
		this.robotYn = robotYn;
	}

	/**
	 * @return the contentSearchChk
	 */
	public int getContentSearchChk() {
		return contentSearchChk;
	}

	/**
	 * @param contentSearchChk the contentSearchChk to set
	 */
	public void setContentSearchChk(int contentSearchChk) {
		this.contentSearchChk = contentSearchChk;
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
    
    public java.lang.String getMenuSearchId() {
		return menuSearchId;
	}

	public void setMenuSearchId(java.lang.String menuSearchId) {
		this.menuSearchId = menuSearchId;
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
    
    public int getIslink() {
        return this.islink;
    }
    
    public void setIslink(int islink) {
        this.islink = islink;
    }
    
    public int getIscnt() {
        return this.iscnt;
    }
    
    public void setIscnt(int iscnt) {
        this.iscnt = iscnt;
    }
    
    public java.lang.String getMenuImgFile() {
        return this.menuImgFile;
    }
    
    public void setMenuImgFile(java.lang.String menuImgFile) {
        this.menuImgFile = menuImgFile;
    }
    
    public java.lang.String getMenuImgPath() {
        return this.menuImgPath;
    }
    
    public void setMenuImgPath(java.lang.String menuImgPath) {
        this.menuImgPath = menuImgPath;
    }
    
    public java.lang.String getMenuImgOnm() {
        return this.menuImgOnm;
    }
    
    public void setMenuImgOnm(java.lang.String menuImgOnm) {
        this.menuImgOnm = menuImgOnm;
    }
    
    public java.lang.String getMenuImgUrl() {
        return this.menuImgUrl;
    }
    
    public void setMenuImgUrl(java.lang.String menuImgUrl) {
        this.menuImgUrl = menuImgUrl;
    }
    
    public java.lang.String getLinkurl() {
        return this.linkurl;
    }
    
    public void setLinkurl(java.lang.String linkurl) {
        this.linkurl = linkurl;
    }
    
    public java.lang.String getLinktgt() {
        return this.linktgt;
    }
    
    public void setLinktgt(java.lang.String linktgt) {
        this.linktgt = linktgt;
    }
    
    public java.lang.String getTplId() {
        return this.tplId;
    }
    
    public void setTplId(java.lang.String tplId) {
        this.tplId = tplId;
    }
    
    public java.lang.String getCntId() {
        return this.cntId;
    }
    
    public void setCntId(java.lang.String cntId) {
        this.cntId = cntId;
    }
    
    public java.lang.String getAdmMbrId() {
        return this.admMbrId;
    }
    
    public void setAdmMbrId(java.lang.String admMbrId) {
        this.admMbrId = admMbrId;
    }
    
    public int getActive() {
        return this.active;
    }
    
    public void setActive(int active) {
        this.active = active;
    }
    
    public java.lang.String getCcl() {
		return ccl;
	}

	public void setCcl(java.lang.String ccl) {
		this.ccl = ccl;
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

	public void setDefMenu(java.lang.String defMenu) {
		this.defMenu = defMenu;
	}

	public java.lang.String getDefMenu() {
		return defMenu;
	}

	public java.lang.String gethDel() {
		return hDel;
	}

	public void sethDel(java.lang.String hDel) {
		this.hDel = hDel;
	}

	public java.lang.String getlDel() {
		return lDel;
	}

	public void setlDel(java.lang.String lDel) {
		this.lDel = lDel;
	}
	
}
