/**
 * @version 3.2.0.1
 */
package jnit.rscdata;

/**
 * @Class Name : JnitrscdataVO.java
 * @Description : Jnitrscdata VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.04
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitrscdataVO extends JnitrscdataDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** DATA_ID */
    private java.lang.String dataId;
    
    /** RSC_ID */
    private java.lang.String rscId;
    
    /** DATA_MEMO */
    private java.lang.String dataMemo;
    
    /** DATA_SCORE */
    private int dataScore;
    
    /** CREATED */
    private java.util.Date created;
    
    /** REMOTE_ADDR */
    private java.lang.String remoteAddr;
    
    public java.lang.String getDataId() {
        return this.dataId;
    }
    
    public void setDataId(java.lang.String dataId) {
        this.dataId = dataId;
    }
    
    public java.lang.String getRscId() {
        return this.rscId;
    }
    
    public void setRscId(java.lang.String rscId) {
        this.rscId = rscId;
    }
    
    public java.lang.String getDataMemo() {
        return this.dataMemo;
    }
    
    public void setDataMemo(java.lang.String dataMemo) {
        this.dataMemo = dataMemo;
    }
    
    public int getDataScore() {
        return this.dataScore;
    }
    
    public void setDataScore(int dataScore) {
        this.dataScore = dataScore;
    }
    
    public java.util.Date getCreated() {
        return this.created;
    }
    
    public void setCreated(java.util.Date created) {
        this.created = created;
    }
    
    public java.lang.String getRemoteAddr() {
        return this.remoteAddr;
    }
    
    public void setRemoteAddr(java.lang.String remoteAddr) {
        this.remoteAddr = remoteAddr;
    }
    
}
