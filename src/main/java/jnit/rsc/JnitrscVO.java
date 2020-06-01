/**
 * @version 3.2.0.1
 */
package jnit.rsc;

/**
 * @Class Name : JnitrscVO.java
 * @Description : Jnitrsc VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.04
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitrscVO extends JnitrscDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** RSC_ID */
    private java.lang.String rscId;
    
    /** RSC_MENU */
    private java.lang.String rscMenu;
    
    /** RSC_URL */
    private java.lang.String rscUrl;
    
    /** RSC_TOT_SCORE */
    private int rscTotScore;
    
    public java.lang.String getRscId() {
        return this.rscId;
    }
    
    public void setRscId(java.lang.String rscId) {
        this.rscId = rscId;
    }
    
    public java.lang.String getRscMenu() {
        return this.rscMenu;
    }
    
    public void setRscMenu(java.lang.String rscMenu) {
        this.rscMenu = rscMenu;
    }
    
    public java.lang.String getRscUrl() {
        return this.rscUrl;
    }
    
    public void setRscUrl(java.lang.String rscUrl) {
        this.rscUrl = rscUrl;
    }
    
    public int getRscTotScore() {
        return this.rscTotScore;
    }
    
    public void setRscTotScore(int rscTotScore) {
        this.rscTotScore = rscTotScore;
    }
    
}
