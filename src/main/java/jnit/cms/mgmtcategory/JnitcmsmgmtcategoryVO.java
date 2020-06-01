/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmtcategory;

/**
 * @Class Name : JnitcmsmgmtcategoryVO.java
 * @Description : Jnitcmsmgmtcategory VO class
 * @Modification Information
 *
 * @author JNITCMSMGMTCATEGORY
 * @since 2014.09.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmgmtcategoryVO extends JnitcmsmgmtcategoryDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** MGMT_CATEGORY_ID */
    private java.lang.String mgmtCategoryId;
    
    /** selectCondition */
    private java.lang.String selectCondition = "0";

	/**
	 * @return the selectCondition
	 */
	public java.lang.String getSelectCondition() {
		return selectCondition;
	}

	/**
	 * @param selectCondition the selectCondition to set
	 */
	public void setSelectCondition(java.lang.String selectCondition) {
		this.selectCondition = selectCondition;
	}

	public java.lang.String getSiteId() {
        return this.siteId;
    }
    
    public void setSiteId(java.lang.String siteId) {
        this.siteId = siteId;
    }
    
    public java.lang.String getMgmtCategoryId() {
        return this.mgmtCategoryId;
    }
    
    public void setMgmtCategoryId(java.lang.String mgmtCategoryId) {
        this.mgmtCategoryId = mgmtCategoryId;
    }
    
}
