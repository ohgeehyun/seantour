/**
 * @version 3.2.0.1
 */
package jnit.visit.count;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : JnitvisitcountDefaultVO.java
 * @Description : Jnitvisitcount Default VO class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.11.30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
/**
 * @author dael
 *
 */
public class JnitvisitcountDefaultVO implements Serializable {
	
	/** 검색 사이트 */
    private String searchSite;
	
	/** 검색날짜(date객체에서 년월일 다 씀) */
    private Date searchDate;
	
	/** 검색기간(1:일, 2:월, 3:년) */
    private int searchTerm = 1;
	
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
    
    /**
     * @return 검색사이트객체
     */
    public String getSearchSite() {
		return searchSite;
	}

	public void setSearchSite(String searchSite) {
		this.searchSite = searchSite;
	}

	/**
     * @return 검색날짜객체
     */
    public java.util.Date getSearchDate() {
        return this.searchDate;
    }
    
    /**
     * @param 검색날짜
     */
    public void setSearchDate(java.util.Date searchDate) {
        this.searchDate = searchDate;
    }
           
    /**
     * @return 검색기간 (1:일, 2:월, 3:년)
     */
    public int getSearchTerm() {
        return this.searchTerm;
    }
    
    /**
     * @param 검색기간 (1:일, 2:월, 3:년)
     */
    public void setSearchTerm(int searchTerm) {
        this.searchTerm = searchTerm;
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
    /**
     * @return 검색조건 (1:시간별, 2:브라우저별, 3:사용자OS별)
     */
	public String getSearchCondition() {
        return searchCondition;
    }
    /**
     * @return 검색조건 (1:시간별, 2:브라우저별, 3:사용자OS별)
     */
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
