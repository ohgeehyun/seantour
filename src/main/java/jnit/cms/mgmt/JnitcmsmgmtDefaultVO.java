/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmt;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : JnitcmsmgmtDefaultVO.java
 * @Description : Jnitcmsmgmt Default VO class
 * @Modification Information
 *
 * @author JNITCMSMGMT
 * @since 2014.04.16
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmgmtDefaultVO implements Serializable {
	
	/** 검색조건 */
    private String searchCondition = "";
    
    /** 검색조건 */
    private String condition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 검색사용여부 */
    private String searchUseYn = "";
    
    /** 현재페이지 */
    private int pageIndex = 1;
    
    /** 페이지갯수 */
    private int pageUnit = 10;
    
    /** 페이지사이즈 */
    private int pageSize = 10;

    /** 화면모드 */
    private String screenMode = "";

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    /** isdelYn */
    private java.lang.String isdelYn = "Y";
    
    /** siteIdYn */
    private java.lang.String siteIdYn = "Y";
    
    /** siteId */ 
    private java.lang.String siteId = "";
    
    /** mgmtTypeYn */
    private java.lang.String mgmtTypeYn = "N";
    
    /** mgmtType */
    private java.lang.String mgmtType = "";
    
    /** pageYn */
    private java.lang.String pageYn = "Y";
    
    /** orderbyCondition */ 
    private java.lang.String orderbyCondition = "0";
    
	/**
	 * @return the orderbyCondition
	 */
	public java.lang.String getOrderbyCondition() {
		return orderbyCondition;
	}

	/**
	 * @param orderbyCondition the orderbyCondition to set
	 */
	public void setOrderbyCondition(java.lang.String orderbyCondition) {
		this.orderbyCondition = orderbyCondition;
	}

	/**
	 * @return the pageYn
	 */
	public java.lang.String getPageYn() {
		return pageYn;
	}

	/**
	 * @param pageYn the pageYn to set
	 */
	public void setPageYn(java.lang.String pageYn) {
		this.pageYn = pageYn;
	}

	/**
	 * @return the mgmtTypeYn
	 */
	public java.lang.String getMgmtTypeYn() {
		return mgmtTypeYn;
	}

	/**
	 * @param mgmtTypeYn the mgmtTypeYn to set
	 */
	public void setMgmtTypeYn(java.lang.String mgmtTypeYn) {
		this.mgmtTypeYn = mgmtTypeYn;
	}

	/**
	 * @return the mgmtType
	 */
	public java.lang.String getMgmtType() {
		return mgmtType;
	}

	/**
	 * @param mgmtType the mgmtType to set
	 */
	public void setMgmtType(java.lang.String mgmtType) {
		this.mgmtType = mgmtType;
	}

	/**
	 * @return the siteIdYn
	 */
	public java.lang.String getSiteIdYn() {
		return siteIdYn;
	}

	/**
	 * @param siteIdYn the siteIdYn to set
	 */
	public void setSiteIdYn(java.lang.String siteIdYn) {
		this.siteIdYn = siteIdYn;
	}

	/**
	 * @return the siteId
	 */
	public java.lang.String getSiteId() {
		return siteId;
	}

	/**
	 * @param siteId the siteId to set
	 */
	public void setSiteId(java.lang.String siteId) {
		this.siteId = siteId;
	}

	/**
	 * @return the condition
	 */
	public String getCondition() {
		return condition;
	}

	/**
	 * @param condition the condition to set
	 */
	public void setCondition(String condition) {
		this.condition = condition;
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

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public String getSearchCondition() {
        return searchCondition;
    }

    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public String getSearchUseYn() {
        return searchUseYn;
    }

    public void setSearchUseYn(String searchUseYn) {
        this.searchUseYn = searchUseYn;
    }

    public String getScreenMode() {
        return screenMode;
    }

    public void setScreenMode(String screenMode) {
        this.screenMode = screenMode;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getPageUnit() {
        return pageUnit;
    }

    public void setPageUnit(int pageUnit) {
        this.pageUnit = pageUnit;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

}
