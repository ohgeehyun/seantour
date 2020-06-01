/**
 * @version 3.2.0.1
 */
package jnit.scrap;

/**
 * @Class Name : JnitscrapVO.java
 * @Description : Jnitscrap VO class
 * @Modification Information
 *
 * @author tactful
 * @since 2013.03.03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitscrapVO extends JnitscrapDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SCRAP_ID */
    private java.lang.String scrapId;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** TITLE */
    private java.lang.String title;
    
    /** URL */
    private java.lang.String url;
    
    /** CREATED */
    private java.util.Date created;
    
    public java.lang.String getScrapId() {
        return this.scrapId;
    }
    
    public void setScrapId(java.lang.String scrapId) {
        this.scrapId = scrapId;
    }
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.lang.String getTitle() {
        return this.title;
    }
    
    public void setTitle(java.lang.String title) {
        this.title = title;
    }
    
    public java.lang.String getUrl() {
        return this.url;
    }
    
    public void setUrl(java.lang.String url) {
        this.url = url;
    }
    
    public java.util.Date getCreated() {
        return this.created;
    }
    
    public void setCreated(java.util.Date created) {
        this.created = created;
    }
    
}
