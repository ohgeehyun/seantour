/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmtitem;

/**
 * @Class Name : JnitcmsmgmtitemVO.java
 * @Description : Jnitcmsmgmtitem VO class
 * @Modification Information
 *
 * @author JNITCMSMGMTITEM
 * @since 2014.09.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmgmtitemVO extends JnitcmsmgmtitemDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** MGMT_CATEGORY_ID */
    private java.lang.String mgmtCategoryId;
    
    /** CATEGORY_NM */
    private java.lang.String categoryNm;
    
    /** CATEGORY_VAL */
    private java.lang.String categoryVal;
    
    /** CATEGORY_SORT */
    private int categorySort;
    
    /** ISDEL */
    private int isdel;
    
    /** CATEGORY_ID */
    private java.lang.String categoryId;
    
    /** ISDEL_YN */
    private java.lang.String isdelYn = "Y";
    
    /** CATEGORY_SOURCE */
    private java.lang.String categorySource;
    
    /** MODIFI_YN */
    private int modifiYn;
    
    /** updateCondition */
    private java.lang.String updateCondition = "0";
    
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

	/**
	 * @return the updateCondition
	 */
	public java.lang.String getUpdateCondition() {
		return updateCondition;
	}

	/**
	 * @param updateCondition the updateCondition to set
	 */
	public void setUpdateCondition(java.lang.String updateCondition) {
		this.updateCondition = updateCondition;
	}

	/**
	 * @return the categorySource
	 */
	public java.lang.String getCategorySource() {
		return categorySource;
	}

	/**
	 * @return the modifiYn
	 */
	public int getModifiYn() {
		return modifiYn;
	}

	/**
	 * @param categorySource the categorySource to set
	 */
	public void setCategorySource(java.lang.String categorySource) {
		this.categorySource = categorySource;
	}

	/**
	 * @param modifiYn the modifiYn to set
	 */
	public void setModifiYn(int modifiYn) {
		this.modifiYn = modifiYn;
	}

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
	 * @return the categoryId
	 */
	public java.lang.String getCategoryId() {
		return categoryId;
	}

	/**
	 * @param categoryId the categoryId to set
	 */
	public void setCategoryId(java.lang.String categoryId) {
		this.categoryId = categoryId;
	}

	/**
	 * @return the categorySort
	 */
	public int getCategorySort() {
		return categorySort;
	}

	/**
	 * @return the isdel
	 */
	public int getIsdel() {
		return isdel;
	}

	/**
	 * @param categorySort the categorySort to set
	 */
	public void setCategorySort(int categorySort) {
		this.categorySort = categorySort;
	}

	/**
	 * @param isdel the isdel to set
	 */
	public void setIsdel(int isdel) {
		this.isdel = isdel;
	}

	public java.lang.String getMgmtCategoryId() {
        return this.mgmtCategoryId;
    }
    
    public void setMgmtCategoryId(java.lang.String mgmtCategoryId) {
        this.mgmtCategoryId = mgmtCategoryId;
    }
    
    public java.lang.String getCategoryNm() {
        return this.categoryNm;
    }
    
    public void setCategoryNm(java.lang.String categoryNm) {
        this.categoryNm = categoryNm;
    }
    
    public java.lang.String getCategoryVal() {
        return this.categoryVal;
    }
    
    public void setCategoryVal(java.lang.String categoryVal) {
        this.categoryVal = categoryVal;
    }    
}
