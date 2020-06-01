/**
 * @version 3.2.0.1
 */
package jnit.cms.scripthist;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : JnitcmsscripthistDefaultVO.java
 * @Description : Jnitcmsscripthist Default VO class
 * @Modification Information
 *
 * @author JNITCMSSCRIPTHIST
 * @since 2014.04.18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsscripthistDefaultVO implements Serializable {
	
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

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    /** SITEID 사용여부 */
    private java.lang.String siteIdYn = "N";
    
    /** MGMTID 사용여부 */
    private java.lang.String mgmtIdYn = "N";
    
    /** SITE_ID */
    private java.lang.String siteId = "";
    
    /** MGMT_ID */
    private java.lang.String mgmtId = "";
        
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
	 * @return the mgmtIdYn
	 */
	public java.lang.String getMgmtIdYn() {
		return mgmtIdYn;
	}

	/**
	 * @param mgmtIdYn the mgmtIdYn to set
	 */
	public void setMgmtIdYn(java.lang.String mgmtIdYn) {
		this.mgmtIdYn = mgmtIdYn;
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
	 * @return the mgmtId
	 */
	public java.lang.String getMgmtId() {
		return mgmtId;
	}

	/**
	 * @param mgmtId the mgmtId to set
	 */
	public void setMgmtId(java.lang.String mgmtId) {
		this.mgmtId = mgmtId;
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
