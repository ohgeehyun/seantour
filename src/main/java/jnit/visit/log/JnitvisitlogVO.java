/**
 * @version 3.2.0.1
 */
package jnit.visit.log;

/**
 * @Class Name : JnitvisitlogVO.java
 * @Description : Jnitvisitlog VO class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.10.29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitvisitlogVO extends JnitvisitlogDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** WHEN_DATETIME */
    private java.util.Date whenDatetime;
    
    /** WHEN_DATE */
    private java.lang.String whenDate;
    
    /** SITE */
    private java.lang.String site;
    
    /** IPADDR */
    private java.lang.String ipaddr;
    
    /** REFERER */
    private java.lang.String referer;
    
    /** USER_OS */
    private java.lang.String userOs;
    
    /** BROWSER */
    private java.lang.String browser;
    
    /** USER_AGENT */
    private java.lang.String userAgent;
    
    /** PAGE */
    private java.lang.String page;
    
    /** USER */
    private java.lang.String user;
    
    /** USER_ACTION */
    private java.lang.String userAction;
    
    
   

	public java.util.Date getWhenDatetime() {
        return this.whenDatetime;
    }
    
    public void setWhenDatetime(java.util.Date whenDatetime) {
        this.whenDatetime = whenDatetime;
    }
    
    public java.lang.String getWhenDate() {
        return this.whenDate;
    }
    
    public void setWherDate(java.lang.String whenDate) {
        this.whenDate = whenDate;
    }
    
    public java.lang.String getSite() {
        return this.site;
    }
    
    public void setSite(java.lang.String site) {
        this.site = site;
    }
    
    public java.lang.String getIpaddr() {
        return this.ipaddr;
    }
    
    public void setIpaddr(java.lang.String ipaddr) {
        this.ipaddr = ipaddr;
    }
    
    public java.lang.String getReferer() {
        return this.referer;
    }
    
    public void setReferer(java.lang.String referer) {
        this.referer = referer;
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
    
    public java.lang.String getUserAgent() {
        return this.userAgent;
    }
    
    public void setUserAgent(java.lang.String userAgent) {
        this.userAgent = userAgent;
    }
    
    public java.lang.String getPage() {
        return this.page;
    }
    
    public void setPage(java.lang.String page) {
        this.page = page;
    }
    
    public java.lang.String getUser() {
        return this.user;
    }
    
    public void setUser(java.lang.String user) {
        this.user = user;
    }

	public java.lang.String getUserAction() {
		return userAction;
	}

	public void setUserAction(java.lang.String userAction) {
		this.userAction = userAction;
	}
    
    
}
