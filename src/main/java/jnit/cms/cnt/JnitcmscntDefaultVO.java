/**
 * @version 3.2.0.1
 */
package jnit.cms.cnt;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : JnitcmscntDefaultVO.java
 * @Description : Jnitcmscnt Default VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmscntDefaultVO implements Serializable {
	
	/** 검색조건 */
    private String searchCondition = "";
    
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
    
    /** 검색Keyword */
    private String searchKeyword6 = "";
    
    /** 검색Keyword */
    private String searchKeyword7 = "";
    
    /** 검색Keyword */
    private String searchKeyword8 = "";
    
    /** 검색사용여부 */
    private String searchUseYn = "";
    
    /** PAGE NAVI 사용여부 */
    private String pageUseYn = "Y";
    
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
    
    /** siteId */
    private java.lang.String siteId = "";
    
    /** menuId */
    private java.lang.String menuId;
    
    /** pageYn 사용여부 */
    private java.lang.String pageYn = "Y";
    
    /** isdelYn */
    private java.lang.String isdelYn = "Y";
    
    /** siteIdYn */
    private java.lang.String siteYn = "Y";
    
    /** QueryYn */
    private java.lang.String QueryYn = "N";
    
    /** Query */
    private java.lang.String Query;
    
    /**
	 * @return the queryYn
	 */
	public java.lang.String getQueryYn() {
		return QueryYn;
	}

	/**
	 * @return the query
	 */
	public java.lang.String getQuery() {
		return Query;
	}

	/**
	 * @param queryYn the queryYn to set
	 */
	public void setQueryYn(java.lang.String queryYn) {
		QueryYn = queryYn;
	}

	/**
	 * @param query the query to set
	 */
	public void setQuery(java.lang.String query) {
		Query = query;
	}

	/**
	 * @return the siteYn
	 */
	public java.lang.String getSiteYn() {
		return siteYn;
	}

	/**
	 * @param siteYn the siteYn to set
	 */
	public void setSiteYn(java.lang.String siteYn) {
		this.siteYn = siteYn;
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

	/** orderbyCondition */
    private java.lang.String orderbyCondition;
    
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
	 * @return the searchKeyword6
	 */
	public String getSearchKeyword6() {
		return searchKeyword6;
	}

	/**
	 * @param searchKeyword6 the searchKeyword6 to set
	 */
	public void setSearchKeyword6(String searchKeyword6) {
		this.searchKeyword6 = searchKeyword6;
	}

	/**
	 * @return the searchKeyword7
	 */
	public String getSearchKeyword7() {
		return searchKeyword7;
	}

	/**
	 * @param searchKeyword7 the searchKeyword7 to set
	 */
	public void setSearchKeyword7(String searchKeyword7) {
		this.searchKeyword7 = searchKeyword7;
	}

	/**
	 * @return the searchKeyword8
	 */
	public String getSearchKeyword8() {
		return searchKeyword8;
	}

	/**
	 * @param searchKeyword8 the searchKeyword8 to set
	 */
	public void setSearchKeyword8(String searchKeyword8) {
		this.searchKeyword8 = searchKeyword8;
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

	/**
	 * @return the menuId
	 */
	public java.lang.String getMenuId() {
		return menuId;
	}

	/**
	 * @param menuId the menuId to set
	 */
	public void setMenuId(java.lang.String menuId) {
		this.menuId = menuId;
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
	 * @return the pageUseYn
	 */
	public String getPageUseYn() {
		return pageUseYn;
	}

	/**
	 * @param pageUseYn the pageUseYn to set
	 */
	public void setPageUseYn(String pageUseYn) {
		this.pageUseYn = pageUseYn;
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
