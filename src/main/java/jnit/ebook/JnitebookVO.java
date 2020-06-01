/**
 * @version 3.2.0.1
 */
package jnit.ebook;

/**
 * @Class Name : JnitebookVO.java
 * @Description : Jnitebook VO class
 * @Modification Information
 *
 * @author JNITEBOOK
 * @since 2014.02.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitebookVO extends JnitebookDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** EBOOK_ID */
    private java.lang.String ebookId;
    
    /** EBOOK_TITLE */
    private java.lang.String ebookTitle;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private int isdel;
    
    /** isdelYn 사용여부 */
    private java.lang.String isdelYn = "Y";
    
    /** pageYn 사용여부 */
    private java.lang.String pageYn = "Y";
    
    /** EXT01 */
    private java.lang.String ext01;
    
    /** EXT02 */
    int ext02;
    
    /** EXT03 */
    private java.lang.String ext03;
    
    /** EXT04 */
    private java.lang.String ext04;
    
    /** EXT05 */
    private java.lang.String ext05;
    
    /** PAGE_WIDTH */
    int pageWidth;
    
    /** PAGE_HEIGHT */
    int pageHeight;
    
    /** THUMB_YN */
    private java.lang.String thumbYn = "true";
    
    /** THUMB_AOTO_HIDE */
    int thumbAotoHide;
    
    /** THUMB_WIDTH */
    int thumbWidth;
    
    /** THUMB_HEIGHT */
    int thumbHeight;
    
    /** SHARE_LINK */
    private java.lang.String shareLink;
    
    /** SHARE_TEXT */
    private java.lang.String shareText;
    
    /** SHARE_VIA */
    private java.lang.String shareVia;
    
    /**
	 * @return the pageWidth
	 */
	public int getPageWidth() {
		return pageWidth;
	}

	/**
	 * @return the pageHeight
	 */
	public int getPageHeight() {
		return pageHeight;
	}

	/**
	 * @return the thumbYn
	 */
	public java.lang.String getThumbYn() {
		return thumbYn;
	}

	/**
	 * @return the thumbAotoHide
	 */
	public int getThumbAotoHide() {
		return thumbAotoHide;
	}

	/**
	 * @return the thumbWidth
	 */
	public int getThumbWidth() {
		return thumbWidth;
	}

	/**
	 * @return the thumbHeight
	 */
	public int getThumbHeight() {
		return thumbHeight;
	}

	/**
	 * @return the shareLink
	 */
	public java.lang.String getShareLink() {
		return shareLink;
	}

	/**
	 * @return the shareText
	 */
	public java.lang.String getShareText() {
		return shareText;
	}

	/**
	 * @return the shareVia
	 */
	public java.lang.String getShareVia() {
		return shareVia;
	}

	/**
	 * @param pageWidth the pageWidth to set
	 */
	public void setPageWidth(int pageWidth) {
		this.pageWidth = pageWidth;
	}

	/**
	 * @param pageHeight the pageHeight to set
	 */
	public void setPageHeight(int pageHeight) {
		this.pageHeight = pageHeight;
	}

	/**
	 * @param thumbYn the thumbYn to set
	 */
	public void setThumbYn(java.lang.String thumbYn) {
		this.thumbYn = thumbYn;
	}

	/**
	 * @param thumbAotoHide the thumbAotoHide to set
	 */
	public void setThumbAotoHide(int thumbAotoHide) {
		this.thumbAotoHide = thumbAotoHide;
	}

	/**
	 * @param thumbWidth the thumbWidth to set
	 */
	public void setThumbWidth(int thumbWidth) {
		this.thumbWidth = thumbWidth;
	}

	/**
	 * @param thumbHeight the thumbHeight to set
	 */
	public void setThumbHeight(int thumbHeight) {
		this.thumbHeight = thumbHeight;
	}

	/**
	 * @param shareLink the shareLink to set
	 */
	public void setShareLink(java.lang.String shareLink) {
		this.shareLink = shareLink;
	}

	/**
	 * @param shareText the shareText to set
	 */
	public void setShareText(java.lang.String shareText) {
		this.shareText = shareText;
	}

	/**
	 * @param shareVia the shareVia to set
	 */
	public void setShareVia(java.lang.String shareVia) {
		this.shareVia = shareVia;
	}

	/**
	 * @return the ext02
	 */
	public int getExt02() {
		return ext02;
	}

	/**
	 * @param ext02 the ext02 to set
	 */
	public void setExt02(int ext02) {
		this.ext02 = ext02;
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
    
    public java.lang.String getEbookId() {
        return this.ebookId;
    }
    
    public void setEbookId(java.lang.String ebookId) {
        this.ebookId = ebookId;
    }
    
    public java.lang.String getEbookTitle() {
        return this.ebookTitle;
    }
    
    public void setEbookTitle(java.lang.String ebookTitle) {
        this.ebookTitle = ebookTitle;
    } 
    
    public java.lang.String getExt01() {
        return this.ext01;
    }
    
    public void setExt01(java.lang.String ext01) {
        this.ext01 = ext01;
    }
    
    public java.lang.String getExt03() {
        return this.ext03;
    }
    
    public void setExt03(java.lang.String ext03) {
        this.ext03 = ext03;
    }
    
    public java.lang.String getExt04() {
        return this.ext04;
    }
    
    public void setExt04(java.lang.String ext04) {
        this.ext04 = ext04;
    }
    
    public java.lang.String getExt05() {
        return this.ext05;
    }
    
    public void setExt05(java.lang.String ext05) {
        this.ext05 = ext05;
    }
    
}
