/**
 * @version 3.2.0.1
 */
package jnit.cms.disseminate;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : JnitcmsdisseminateDefaultVO.java
 * @Description : Jnitcmsdisseminate Default VO class
 * @Modification Information
 *
 * @author JNITCMSDISSEMINATE
 * @since 2013.11.05
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsdisseminateDefaultVO implements Serializable {
	
	/** 검색조건 */
    private String searchCondition = "";
    
    private String cntId = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 검색Keyword */
    private String searchKeyword2 = "";
    
    /** 검색Keyword */
    private String searchKeyword3 = "";
    
    /** 검색Keyword */
    private String searchKeyword4 = "";
    
    /** 검색Keyword */
    private String searchKeyword5 = "";
    
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
    
    /** 오늘 날짜 */
    private java.util.Date toDay;
    
    /** 페이지 네비 사용여부 */
    private java.lang.String pageYn ="Y";
    
    /** isdelYn 사용여부 */
    private java.lang.String isdelYn = "Y";
    
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
	 * @return the toDay
	 */
	public java.util.Date getToDay() {
		return toDay;
	}

	/**
	 * @param toDay the toDay to set
	 */
	public void setToDay(java.util.Date toDay) {
		this.toDay = toDay;
	}

	/**
	 * @return the cntId
	 */
	public String getCntId() {
		return cntId;
	}

	/**
	 * @param cntId the cntId to set
	 */
	public void setCntId(String cntId) {
		this.cntId = cntId;
	}

	/**
	 * @return the searchKeyword2
	 */
	public String getSearchKeyword2() {
		return searchKeyword2;
	}

	/**
	 * @param searchKeyword2 the searchKeyword2 to set
	 */
	public void setSearchKeyword2(String searchKeyword2) {
		this.searchKeyword2 = searchKeyword2;
	}

	/**
	 * @return the searchKeyword3
	 */
	public String getSearchKeyword3() {
		return searchKeyword3;
	}

	/**
	 * @param searchKeyword3 the searchKeyword3 to set
	 */
	public void setSearchKeyword3(String searchKeyword3) {
		this.searchKeyword3 = searchKeyword3;
	}

	/**
	 * @return the searchKeyword4
	 */
	public String getSearchKeyword4() {
		return searchKeyword4;
	}

	/**
	 * @param searchKeyword4 the searchKeyword4 to set
	 */
	public void setSearchKeyword4(String searchKeyword4) {
		this.searchKeyword4 = searchKeyword4;
	}

	/**
	 * @return the searchKeyword5
	 */
	public String getSearchKeyword5() {
		return searchKeyword5;
	}

	/**
	 * @param searchKeyword5 the searchKeyword5 to set
	 */
	public void setSearchKeyword5(String searchKeyword5) {
		this.searchKeyword5 = searchKeyword5;
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
