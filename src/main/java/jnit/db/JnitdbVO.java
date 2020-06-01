/**
 * @version 3.2.0.1
 */
package jnit.db;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : JnitdbVO.java
 * @Description : 사용자 Query 처리
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitdbVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
    /** 현재페이지 */
    private int pageIndex = 1;
    
    /** 페이지갯수 */
    private int pageUnit = 10;
    
    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    /** 페이지 사용여부 */
    private String isPaging = "";
    
    /** Query **/
    private String query = "";

    /** addQuery **/
    private String addQuery = "";
    
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

    public String getQuery() {
    	return this.query;
    }
    
    public void setQuery(String query) {
    	this.query = query;
    }
    
    public String getIsPaging() {
    	return this.isPaging;
    }
    
    public void setIsPaging(String isPaging) {
    	this.isPaging = isPaging;
    }

	public void setAddQuery(String addQuery) {
		this.addQuery = addQuery;
	}

	public String getAddQuery() {
		return addQuery;
	}
}
