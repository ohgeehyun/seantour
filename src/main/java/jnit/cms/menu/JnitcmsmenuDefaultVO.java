/**
 * @version 3.2.0.1
 */
package jnit.cms.menu;

import java.io.Serializable;
import java.util.ArrayList;

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
public class JnitcmsmenuDefaultVO implements Serializable {
	
	/** 검색조건 */
    private String searchCondition = "";
    
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
    
    /** isdelYn */
    private java.lang.String isdelYn = "Y";
    
    /** siteIdYn */ 
    private java.lang.String siteIdYn = "Y";
    
    /** pageYn */
    private java.lang.String pageYn = "Y";
    
    /** orderCondition */
    private java.lang.String orderCondition = "0";
    
    /** leftYn */
    private java.lang.String leftYn = "N";
    
    private java.lang.String countCondition = "0";
    
    private java.util.ArrayList<String> selectList = new ArrayList<String>();

    public java.util.ArrayList<String> getSelectList() {
		return selectList;
	}

	public void setSelectList(java.util.ArrayList<String> selectList) {
		this.selectList = selectList;
	}

	public java.lang.String getCountCondition() {
		return countCondition;
	}

	public void setCountCondition(java.lang.String countCondition) {
		this.countCondition = countCondition;
	}

	/**
	 * @return the leftYn
	 */
	public java.lang.String getLeftYn() {
		return leftYn;
	}

	/**
	 * @param leftYn the leftYn to set
	 */
	public void setLeftYn(java.lang.String leftYn) {
		this.leftYn = leftYn;
	}

	/**
	 * @return the orderCondition
	 */
	public java.lang.String getOrderCondition() {
		return orderCondition;
	}

	/**
	 * @param orderCondition the orderCondition to set
	 */
	public void setOrderCondition(java.lang.String orderCondition) {
		this.orderCondition = orderCondition;
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

	/** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    /** SITE_ID */
    private java.lang.String siteId;
        
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
    
    public java.lang.String getSiteId() {
        return this.siteId;
    }
    
    public void setSiteId(java.lang.String siteId) {
        this.siteId = siteId;
    }

}
