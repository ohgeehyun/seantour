/**
 * @version 3.2.0.1
 */
package jnit.cms.menu;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : JnitcmsmenuDefaultVO.java
 * @Description : Jnitcmsmenu Default VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.08
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmenuChMethodVO implements Serializable {
	
	/** src 시작 순서 **/
    private int srcSMethod = 1;
    
    /** src 끝 순서 **/
    private int srcEMethod = 1;

    /** src menuid **/
    private String srcMenuId = "";
    
    /** dst 시작 순서 **/
    private int dstSMethod = 1;
    
    /** dst 끝 순서 **/
    private int dstEMethod = 1;
    
    /** dst menuid **/
    private String dstMenuId = "";
    
    /** up / down */
    private String moveMode = "up";

    /** siteid **/
    private String siteId = "";
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
    public int getSrcSMethod() {
        return this.srcSMethod;
    }
    
    public void setSrcSMethod(int srcSMethod) {
        this.srcSMethod = srcSMethod;
    }
    
    public int getSrcEMethod() {
        return this.srcEMethod;
    }
    
    public void setSrcEMethod(int srcEMethod) {
        this.srcEMethod = srcEMethod;
    }
    
    public java.lang.String getSrcMenuId() {
        return this.srcMenuId;
    }
    
    public void setSrcMenuId(java.lang.String srcMenuId) {
        this.srcMenuId = srcMenuId;
    }

    public int getDstSMethod() {
        return this.dstSMethod;
    }
    
    public void setDstSMethod(int dstSMethod) {
        this.dstSMethod = dstSMethod;
    }
    
    public int getDstEMethod() {
        return this.dstEMethod;
    }
    
    public void setDstEMethod(int dstEMethod) {
        this.dstEMethod = dstEMethod;
    }
    
    public java.lang.String getDstMenuId() {
        return this.dstMenuId;
    }
    
    public void setDstMenuId(java.lang.String dstMenuId) {
        this.dstMenuId = dstMenuId;
    }
    
    public java.lang.String getMoveMode() {
        return this.moveMode;
    }
    
    public void setMoveMode(java.lang.String moveMode) {
        this.moveMode = moveMode;
    }
    
    public java.lang.String getSiteId() {
        return this.siteId;
    }
    
    public void setSiteId(java.lang.String siteId) {
        this.siteId = siteId;
    }
}
