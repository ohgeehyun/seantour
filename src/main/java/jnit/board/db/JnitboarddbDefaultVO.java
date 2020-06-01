/**
 * @version 3.2.0.1
 */
package jnit.board.db;

import java.io.Serializable;
import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : JnitboardtplDefaultVO.java
 * @Description : Jnitboardtpl Default VO class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2013.01.22
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitboarddbDefaultVO implements Serializable {
	
	/** 관리자여부 */
    private Boolean isAdmin = false;
    
	/** 게시판 아이디 */
    private String boardId = "";
    
	/** 게시판 답글 GRP */
    private int grp;
    
	/** 부모글만 검색 */
    private String searchParents = "";
    
	/** 게시판 카테고리 */
    private String searchCategory = "";
    
	/** 첨부파일포함 */
    private String withFile = "0";
    
	/** 내용포함 */
    private String WithContent = "0";
    
	/** 검색일자 */
    private java.util.Date searchDate;
    
	/** 월별검색 */
    private java.util.Date searchMonth;
    
    /** 작성일 검색 시작일자 */
    private java.util.Date createdStartDate;
    
	/** 작성일 검색 종료일자 */
    private java.util.Date createdEndDate;

	/** 검색조건 */
    private String searchCondition = "";
    
    /** 검색조건 */
    private String condition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 검색사용여부 */
    private String searchUseYn = "";
    
    /** 검색EXT01 */
    private String searchext01 = "";
    
    /** 검색EXT02 */
    private String searchext02 = "";
    
    /** 검색EXT03 */
    private String searchext03 = "";
    
    /** 검색EXT04 */
    private String searchext04 = "";
    
    /** 검색EXT05 */
    private String searchext05 = "";
    
    /** 검색EXT06 */
    private String searchext06 = "";
    
    /** 검색EXT07 */
    private String searchext07 = "";
    
    /** 검색EXT08 */
    private String searchext08 = "";
    
    /** 검색EXT09 */
    private String searchext09 = "";
    
    /** 검색EXT10 */
    private String searchext10 = "";
    
    /** 검색EXT11 */
    private String searchext11 = "";
    
    /** 검색EXT12 */
    private String searchext12 = "";
    
    /** 검색EXT13 */
    private String searchext13 = "";
    
    /** 검색EXT14 */
    private String searchext14 = "";
    
    /** 검색EXT15 */
    private String searchext15 = "";
    
    /** 검색EXT16 */
    private String searchext16 = "";
    
    /** 검색EXT17 */
    private String searchext17 = "";
    
    /** 검색EXT18 */
    private String searchext18 = "";
    
    /** 검색EXT19 */
    private String searchext19 = "";
    
    /** 검색EXT20 */
    private String searchext20 = "";
    
    /** 검색 유형조건 */
    private String searchType = "";
    
    /** mbrYn */ 
    private java.lang.String mbrYn = "";
    
    /** mbrId */ 
    private java.lang.String searchMbrId = "";
    
    /** 현재페이지 */
    private int pageIdx = 1;
    
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
    
    /** QueryYn */
    private java.lang.String QueryYn = "N";
    
    /** 쿼리 */
    private java.lang.String Query;
    
    /** orderbyCondition */
    private java.lang.String orderbyCondition = "0";
    
    /** file 쿼리 */
    private java.lang.String fileQuery;
    
    /** fileQueryYn */
    private java.lang.String fileQueryYn = "N";
    
    /** latestYn */
    private java.lang.String latestYn = "N";
    
    /** orderbyHitYn */
    private java.lang.String orderbyHitYn = "N";
    
    /** latestConfig */
    private java.lang.String latestConfig = "";
    
    /** latestValue */
    private java.lang.String latestValue = "";
    
	/** selectList */
    private java.util.ArrayList<String> selectList = new java.util.ArrayList();
    
    /**  MyBoardList*/
    private java.lang.String myBoardList = "";
    
    /** categoryCondition */
    private java.lang.String categoryCondition = "0";
    
    private java.lang.String idxCondition = "";

    private java.lang.String inquiry = "";
    
    private java.lang.String searchSite = "";
    
	public java.lang.String getIdxCondition() {
		return idxCondition;
	}

	public void setIdxCondition(java.lang.String idxCondition) {
		this.idxCondition = idxCondition;
	}

	public java.util.ArrayList<String> getSelectList() {
		return selectList;
	}

	public void setSelectList(java.util.ArrayList<String> selectList) {
		this.selectList = selectList;
	}

	public java.lang.String getCategoryCondition() {
		return categoryCondition;
	}

	public void setCategoryCondition(java.lang.String categoryCondition) {
		this.categoryCondition = categoryCondition;
	}
	/**
	 * @return the orderbyHitYn
	 */
	public java.lang.String getOrderbyHitYn() {
		return orderbyHitYn;
	}

	/**
	 * @param orderbyHitYn the orderbyHitYn to set
	 */
	public void setOrderbyHitYn(java.lang.String orderbyHitYn) {
		this.orderbyHitYn = orderbyHitYn;
	}

	/**
	 * @return the latestYn
	 */
	public java.lang.String getLatestYn() {
		return latestYn;
	}

	/**
	 * @param latestYn the latestYn to set
	 */
	public void setLatestYn(java.lang.String latestYn) {
		this.latestYn = latestYn;
	}

	/**
	 * @return the fileQuery
	 */
	public java.lang.String getFileQuery() {
		return fileQuery;
	}

	/**
	 * @return the fileQueryYn
	 */
	public java.lang.String getFileQueryYn() {
		return fileQueryYn;
	}

	/**
	 * @param fileQuery the fileQuery to set
	 */
	public void setFileQuery(java.lang.String fileQuery) {
		this.fileQuery = fileQuery;
	}

	/**
	 * @param fileQueryYn the fileQueryYn to set
	 */
	public void setFileQueryYn(java.lang.String fileQueryYn) {
		this.fileQueryYn = fileQueryYn;
	}

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
	 * @return the queryYn
	 */
	public java.lang.String getQueryYn() {
		return QueryYn;
	}

	/**
	 * @param queryYn the queryYn to set
	 */
	public void setQueryYn(java.lang.String queryYn) {
		QueryYn = queryYn;
	}

	/**
	 * @return the query
	 */
	public java.lang.String getQuery() {
		return Query;
	}

	/**
	 * @param query the query to set
	 */
	public void setQuery(java.lang.String query) {
		Query = query;
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
	 * @return the searchMbrId
	 */
	public java.lang.String getSearchMbrId() {
		return searchMbrId;
	}

	/**
	 * @param searchMbrId the searchMbrId to set
	 */
	public void setSearchMbrId(java.lang.String searchMbrId) {
		this.searchMbrId = searchMbrId;
	}

	/**
	 * @return the mbrYn
	 */
	public String getMbrYn() {
		return mbrYn;
	}

	/**
	 * @param mbrYn the mbrYn to set
	 */
	public void setMbrYn(String mbrYn) {
		this.mbrYn = mbrYn;
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

	public String getIsAdmin() {
		return isAdmin.toString();
	}

	public void setIsAdmin(Boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getBoardId() {
		return boardId;
	}

	public void setBoardId(String boardId) {
		this.boardId = boardId;
	}

	public int getGrp() {
		return grp;
	}

	public void setGrp(int grp) {
		this.grp = grp;
	}

	public String getSearchParents() {
		return searchParents;
	}

	public void setSearchParents(String searchParents) {
		this.searchParents = searchParents;
	}

	public String getWithFile() {
		return withFile;
	}

	public void setWithFile(String withFile) {
		this.withFile = withFile;
	}

	public String getWithContent() {
		return WithContent;
	}

	public void setWithContent(String withContent) {
		WithContent = withContent;
	}

	public String getSearchCategory() {
		return searchCategory;
	}

	public void setSearchCategory(String searchCategory) {
		this.searchCategory = searchCategory;
	}

	public java.util.Date getSearchDate() {
		return searchDate;
	}

	public void setSearchDate(java.util.Date searchDate) {
		this.searchDate = searchDate;
	}

	public java.util.Date getSearchMonth() {
		return searchMonth;
	}

	public void setSearchMonth(java.util.Date searchMonth) {
		this.searchMonth = searchMonth;
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

	public String getSearchExt01() {
		return searchext01;
	}

	public void setSearchExt01(String searchExt01) {
		this.searchext01 = searchExt01;
	}

	public String getSearchExt02() {
		return searchext02;
	}

	public void setSearchExt02(String searchExt02) {
		this.searchext02 = searchExt02;
	}

	public String getSearchExt03() {
		return searchext03;
	}

	public void setSearchExt03(String searchExt03) {
		this.searchext03 = searchExt03;
	}

	public String getSearchExt04() {
		return searchext04;
	}

	public void setSearchExt04(String searchExt04) {
		this.searchext04 = searchExt04;
	}

	public String getSearchExt05() {
		return searchext05;
	}

	public void setSearchExt05(String searchExt05) {
		this.searchext05 = searchExt05;
	}

	public String getSearchExt06() {
		return searchext06;
	}

	public void setSearchExt06(String searchExt06) {
		this.searchext06 = searchExt06;
	}

	public String getSearchExt07() {
		return searchext07;
	}

	public void setSearchExt07(String searchExt07) {
		this.searchext07 = searchExt07;
	}

	public String getSearchExt08() {
		return searchext08;
	}

	public void setSearchExt08(String searchExt08) {
		this.searchext08 = searchExt08;
	}

	public String getSearchExt09() {
		return searchext09;
	}

	public void setSearchExt09(String searchExt09) {
		this.searchext09 = searchExt09;
	}

	public String getSearchExt10() {
		return searchext10;
	}

	public void setSearchExt10(String searchExt10) {
		this.searchext10 = searchExt10;
	}

	public String getSearchExt11() {
		return searchext11;
	}

	public void setSearchExt11(String searchExt11) {
		this.searchext11 = searchExt11;
	}

	public String getSearchExt12() {
		return searchext12;
	}

	public void setSearchExt12(String searchExt12) {
		this.searchext12 = searchExt12;
	}

	public String getSearchExt13() {
		return searchext13;
	}

	public void setSearchExt13(String searchExt13) {
		this.searchext13 = searchExt13;
	}

	public String getSearchExt14() {
		return searchext14;
	}

	public void setSearchExt14(String searchExt14) {
		this.searchext14 = searchExt14;
	}

	public String getSearchExt15() {
		return searchext15;
	}

	public void setSearchExt15(String searchExt15) {
		this.searchext15 = searchExt15;
	}

	public String getSearchExt16() {
		return searchext16;
	}

	public void setSearchExt16(String searchExt16) {
		this.searchext16 = searchExt16;
	}

	public String getSearchExt17() {
		return searchext17;
	}

	public void setSearchExt17(String searchExt17) {
		this.searchext17 = searchExt17;
	}

	public String getSearchExt18() {
		return searchext18;
	}

	public void setSearchExt18(String searchExt18) {
		this.searchext18 = searchExt18;
	}

	public String getSearchExt19() {
		return searchext19;
	}

	public void setSearchExt19(String searchExt19) {
		this.searchext19 = searchExt19;
	}

	public String getSearchExt20() {
		return searchext20;
	}

	public void setSearchExt20(String searchExt20) {
		this.searchext20 = searchExt20;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getScreenMode() {
        return screenMode;
    }

    public void setScreenMode(String screenMode) {
        this.screenMode = screenMode;
    }

    public int getPageIdx() {
        return pageIdx;
    }

    public void setPageIdx(int pageIdx) {
        this.pageIdx = pageIdx;
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
	public java.util.Date getCreatedStartDate() {
		return createdStartDate;
	}

	public void setCreatedStartDate(java.util.Date createdStartDate) {
		this.createdStartDate = createdStartDate;
	}

	public java.util.Date getCreatedEndDate() {
		return createdEndDate;
	}

	public void setCreatedEndDate(java.util.Date createdEndDate) {
		this.createdEndDate = createdEndDate;
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

	public java.lang.String getInquiry() {
		return inquiry;
	}

	public void setInquiry(java.lang.String inquiry) {
		this.inquiry = inquiry;
	}

	public java.lang.String getMyBoardList() {
		return myBoardList;
	}

	public void setMyBoardList(java.lang.String myBoardList) {
		this.myBoardList = myBoardList;
	}

	public java.lang.String getSearchSite() {
		return searchSite;
	}

	public void setSearchSite(java.lang.String searchSite) {
		this.searchSite = searchSite;
	}
	
	
}
