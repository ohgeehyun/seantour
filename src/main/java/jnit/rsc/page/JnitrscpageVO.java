/**
 * @version 3.2.0.1
 */
package jnit.rsc.page;

/**
 * @Class Name : JnitrscpageVO.java
 * @Description : Jnitrscpage VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitrscpageVO extends JnitrscpageDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** RSCP_ID */
    private java.lang.String rscpId;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** MENU_ID */
    private java.lang.String menuId;   
    
    /** PAGE_URL */
    private java.lang.String pageUrl;
    
    /** PAGE_VIEW */
    private int pageView;
    
    /** HIT1 */
    private int hit1;
    
    /** HIT2 */
    private int hit2;
    
    /** HIT3 */
    private int hit3;
    
    /** HIT4 */
    private int hit4;
    
    /** HIT5 */
    private int hit5;
    
    /** DATE01 */
    private java.util.Date date01;
    
    /** DATE02 */
    private java.util.Date date02;    
    
    /** pageYn 사용여부 */
    private java.lang.String pageYn = "Y";
    
    /*/ isdelYn 사용여부 */
    private java.lang.String isdelYn = "Y";

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
	 * @return the date01
	 */
	public java.util.Date getDate01() {
		return date01;
	}

	/**
	 * @param date01 the date01 to set
	 */
	public void setDate01(java.util.Date date01) {
		this.date01 = date01;
	}

	/**
	 * @return the date02
	 */
	public java.util.Date getDate02() {
		return date02;
	}

	/**
	 * @param date02 the date02 to set
	 */
	public void setDate02(java.util.Date date02) {
		this.date02 = date02;
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

	public java.lang.String getRscpId() {
        return this.rscpId;
    }
    
    public void setRscpId(java.lang.String rscpId) {
        this.rscpId = rscpId;
    }
    
    public java.lang.String getMenuId() {
        return this.menuId;
    }
    
    public void setMenuId(java.lang.String menuId) {
        this.menuId = menuId;
    }
    
    public java.lang.String getPageUrl() {
        return this.pageUrl;
    }
    
    public void setPageUrl(java.lang.String pageUrl) {
        this.pageUrl = pageUrl;
    }
    
    public int getHit1() {
        return this.hit1;
    }
    
    public void setHit1(int hit1) {
        this.hit1 = hit1;
    }
    
    public int getHit2() {
        return this.hit2;
    }
    
    public void setHit2(int hit2) {
        this.hit2 = hit2;
    }
    
    public int getHit3() {
        return this.hit3;
    }
    
    public void setHit3(int hit3) {
        this.hit3 = hit3;
    }
    
    public int getHit4() {
        return this.hit4;
    }
    
    public void setHit4(int hit4) {
        this.hit4 = hit4;
    }
    
    public int getHit5() {
        return this.hit5;
    }
    
    public void setHit5(int hit5) {
        this.hit5 = hit5;
    }

	public void setPageView(int pageView) {
		this.pageView = pageView;
	}

	public int getPageView() {
		return pageView;
	}

	public void setSiteId(java.lang.String siteId) {
		this.siteId = siteId;
	}

	public java.lang.String getSiteId() {
		return siteId;
	}
    
}
