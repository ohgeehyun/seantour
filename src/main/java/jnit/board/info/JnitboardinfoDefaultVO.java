/**
 * @version 3.2.0.1
 */
package jnit.board.info;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : JnitboardinfoDefaultVO.java
 * @Description : Jnitboardinfo Default VO class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2013.01.21
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */
public class JnitboardinfoDefaultVO implements Serializable {

	/** 검색그룹 */
    private String searchBoardGroup = "";

	/** 검색조건 */
    private String searchCondition = "";

    /** 검색조건 */
    private String orderByCondition = "";

    /** 검색Keyword */
    private String searchKeyword = "";

    /** 검색Keyword */
    private String searchKeyword2 = "";

    /** 검색Keyword */
    private String searchKeyword3 = "";

    /** 검색Keyword */
    private String searchKeyword4 = "";

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

    /** pageYn */
    private java.lang.String pageYn = "Y";

    /** LATEST_CONFIG */
    private java.lang.String latestConfig;

    /** LATEST_VALUE */
    private java.lang.String latestValue;

    /** selectList */
    private java.util.ArrayList<String> selectList = new java.util.ArrayList();

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

	public String getSearchBoardGroup() {
		return searchBoardGroup;
	}

	public void setSearchBoardGroup(String searchBoardGroup) {
		this.searchBoardGroup = searchBoardGroup;
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

	public String getOrderByCondition() {
		return orderByCondition;
	}

	public void setOrderByCondition(String orderByCondition) {
		this.orderByCondition = orderByCondition;
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

	public java.lang.String getLatestConfig() {
		return latestConfig;
	}

	public void setLatestConfig(java.lang.String latestConfig) {
		this.latestConfig = latestConfig;
	}

	public java.lang.String getLatestValue() {
		return latestValue;
	}

	public void setLatestValue(java.lang.String latestValue) {
		this.latestValue = latestValue;
	}

	public String getSearchKeyword2() {
		return searchKeyword2;
	}

	public void setSearchKeyword2(String searchKeyword2) {
		this.searchKeyword2 = searchKeyword2;
	}

	public String getSearchKeyword3() {
		return searchKeyword3;
	}

	public void setSearchKeyword3(String searchKeyword3) {
		this.searchKeyword3 = searchKeyword3;
	}

	public String getSearchKeyword4() {
		return searchKeyword4;
	}

	public void setSearchKeyword4(String searchKeyword4) {
		this.searchKeyword4 = searchKeyword4;
	}

	public java.util.ArrayList<String> getSelectList() {
		return selectList;
	}

	public void setSelectList(java.util.ArrayList<String> selectList) {
		this.selectList = selectList;
	}


}
