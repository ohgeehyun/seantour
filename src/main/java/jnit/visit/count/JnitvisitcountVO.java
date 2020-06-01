/**
 * @version 3.2.0.1
 */
package jnit.visit.count;

import java.util.Date;

/**
 * @Class Name : JnitvisitcountVO.java
 * @Description : Jnitvisitcount VO class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.11.30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitvisitcountVO extends JnitvisitcountDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SITE */
    private java.lang.String site;
    
    /** VDATE */
    private Date vdate;
    
    /** VHOUR */
    private int vhour;
    
    /** USER_OS */
    private java.lang.String userOs;
    
    /** BROWSER */
    private java.lang.String browser;
    
    /** HIT */
    private int hit;
    
    /** where 조건 whereAllYn 사용여부 */
    private java.lang.String whereAllYn = "N";
    
    /** where 조건 whereSiteYn 사용여부 */
    private java.lang.String whereSiteYn = "Y";

	/**
	 * @return the whereAllYn
	 */
	public java.lang.String getWhereAllYn() {
		return whereAllYn;
	}

	/**
	 * @param whereAllYn the whereAllYn to set
	 */
	public void setWhereAllYn(java.lang.String whereAllYn) {
		this.whereAllYn = whereAllYn;
	}

	/**
	 * @return the whereSiteYn
	 */
	public java.lang.String getWhereSiteYn() {
		return whereSiteYn;
	}

	/**
	 * @param whereSiteYn the whereSiteYn to set
	 */
	public void setWhereSiteYn(java.lang.String whereSiteYn) {
		this.whereSiteYn = whereSiteYn;
	}

	public java.lang.String getSite() {
		return site;
	}

	public void setSite(java.lang.String site) {
		this.site = site;
	}

	public java.util.Date getVdate() {
        return this.vdate;
    }
    
    public void setVdate(java.util.Date vdate) {
        this.vdate = vdate;
    }
    
    public int getVhour() {
        return this.vhour;
    }
    
    public void setVhour(int vhour) {
        this.vhour = vhour;
    }
    
    public java.lang.String getUserOs() {
        return this.userOs;
    }
    
    public void setUserOs(java.lang.String userOs) {
        this.userOs = userOs;
    }
    
    public java.lang.String getBrowser() {
        return this.browser;
    }
    
    public void setBrowser(java.lang.String browser) {
        this.browser = browser;
    }
    
    public int getHit() {
        return this.hit;
    }
    
    public void setHit(int hit) {
        this.hit = hit;
    }
    
}
