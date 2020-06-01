/**
 * @version 3.2.0.1
 */
package jnit.login.log;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : JnitloginlogDefaultVO.java
 * @Description : Jnitloginlog Default VO class
 * @Modification Information
 *
 * @author JNITLOGINLOG
 * @since 2013.07.30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitloginlogDefaultVO implements Serializable {
	
	/** 검색조건 */
    private String searchCondition = "";
    
    /** 검색조건 */
    private String condition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 검색Keyword */
    private String conditionKeyword = "";
    
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
    
    /** 검색Keyword */
    private String pageYn = "Y";    
    
    private java.util.Date searchDate;
    
    private java.util.Date searchDate2;
    
    /** isdelYn 사용여부 */
    private java.lang.String isdelYn = "Y";
    
    /** fieldConditon */    
    private java.lang.String fieldConditon = "0";
        
	/**
	 * @return the fieldConditon
	 */
	public java.lang.String getFieldConditon() {
		return fieldConditon;
	}

	/**
	 * @param fieldConditon the fieldConditon to set
	 */
	public void setFieldConditon(java.lang.String fieldConditon) {
		this.fieldConditon = fieldConditon;
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
	 * @return the conditionKeyword
	 */
	public String getConditionKeyword() {
		return conditionKeyword;
	}

	/**
	 * @param conditionKeyword the conditionKeyword to set
	 */
	public void setConditionKeyword(String conditionKeyword) {
		this.conditionKeyword = conditionKeyword;
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
	 * @return the pageYn
	 */
	public String getPageYn() {
		return pageYn;
	}

	/**
	 * @param pageYn the pageYn to set
	 */
	public void setPageYn(String pageYn) {
		this.pageYn = pageYn;
	}

	/**
	 * @return the searchDate2
	 */
	public java.util.Date getSearchDate2() {
		return searchDate2;
	}

	/**
	 * @param searchDate2 the searchDate2 to set
	 */
	public void setSearchDate2(java.util.Date searchDate2) {
		this.searchDate2 = searchDate2;
	}

	/**
	 * @return the searchDate
	 */
	public java.util.Date getSearchDate() {
		return searchDate;
	}

	/**
	 * @param searchDate the searchDate to set
	 */
	public void setSearchDate(java.util.Date searchDate) {
		this.searchDate = searchDate;
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
