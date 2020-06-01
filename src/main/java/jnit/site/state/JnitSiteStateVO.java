/**
 * @version 3.2.0.1
 */
package jnit.site.state;

/**
 * @Class Name : JnitsitestatelistVO.java
 * @Description : Jnitsitestatelist VO class
 * @Modification Information
 *
 * @author JNITSITESTATE
 * @since 2014.07.10
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitSiteStateVO extends JnitSiteStateDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** WHEN_DATE */
    private java.lang.String whenDate;
    
    /** IP */
    private java.lang.String ip;
    
    public java.lang.String getWhenDate() {
        return this.whenDate;
    }
    
    public void setWhenDate(java.lang.String whenDate) {
        this.whenDate = whenDate;
    }
    
    public java.lang.String getIp() {
        return this.ip;
    }
    
    public void setIp(java.lang.String ip) {
        this.ip = ip;
    }
    
}
