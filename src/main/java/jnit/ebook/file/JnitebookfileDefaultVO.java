/**
 * @version 3.2.0.1
 */
package jnit.ebook.file;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : JnitebookfileDefaultVO.java
 * @Description : Jnitebookfile Default VO class
 * @Modification Information
 *
 * @author JNITEBOOKFILE
 * @since 2014.02.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitebookfileDefaultVO implements Serializable {
	
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
    
    /** isdelYn 사용여부 */
    private java.lang.String isdelYn = "Y";
    
    /** pageYn 사용여부 */
    private java.lang.String pageYn = "Y";
    
    /** ebookFileIdYn 사용여부*/
    private java.lang.String ebookFileIdYn = "N";
    
    /** fileIdYn 사용여부 */
    private java.lang.String fileIdYn = "Y";
    
    /** selectCondition */
    private java.lang.String selectCondition;
    
    /** orderbyCondition */
    private java.lang.String orderbyCondition;
    
    /** orderbyFileId */
    private java.lang.String orderbyFileId = "Y";
        
	/**
	 * @return the orderbyFileId
	 */
	public java.lang.String getOrderbyFileId() {
		return orderbyFileId;
	}

	/**
	 * @param orderbyFileId the orderbyFileId to set
	 */
	public void setOrderbyFileId(java.lang.String orderbyFileId) {
		this.orderbyFileId = orderbyFileId;
	}

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
	 * @return the ebookFileIdYn
	 */
	public java.lang.String getEbookFileIdYn() {
		return ebookFileIdYn;
	}

	/**
	 * @param ebookFileIdYn the ebookFileIdYn to set
	 */
	public void setEbookFileIdYn(java.lang.String ebookFileIdYn) {
		this.ebookFileIdYn = ebookFileIdYn;
	}

	/**
	 * @return the fileIdYn
	 */
	public java.lang.String getFileIdYn() {
		return fileIdYn;
	}

	/**
	 * @param fileIdYn the fileIdYn to set
	 */
	public void setFileIdYn(java.lang.String fileIdYn) {
		this.fileIdYn = fileIdYn;
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
