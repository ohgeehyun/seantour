/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrsess;

/**
 * @Class Name : JnitcmsmbrsessVO.java
 * @Description : Jnitcmsmbrsess VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmbrsessVO extends JnitcmsmbrsessDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** MBR_SESS */
    private java.lang.String mbrSess;
    
    /** SESS_LOCK */
    private java.math.BigDecimal sessLock;
    
    /** SESS_DATE */
    private java.sql.Date sessDate;
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.lang.String getMbrSess() {
        return this.mbrSess;
    }
    
    public void setMbrSess(java.lang.String mbrSess) {
        this.mbrSess = mbrSess;
    }
    
    public java.math.BigDecimal getSessLock() {
        return this.sessLock;
    }
    
    public void setSessLock(java.math.BigDecimal sessLock) {
        this.sessLock = sessLock;
    }
    
    public java.sql.Date getSessDate() {
        return this.sessDate;
    }
    
    public void setSessDate(java.sql.Date sessDate) {
        this.sessDate = sessDate;
    }
    
}
