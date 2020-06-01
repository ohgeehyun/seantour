/**
 * @version 3.2.0.1
 */
package jnit.cms.mbr;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : JnitcmsmbrDefaultVO.java
 * @Description : Jnitcmsmbr Default VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmbrDefaultVO implements Serializable {
	
	/** 검색조건 */
    private String searchCondition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 검색Keyword */
    private String searchKeyword1 = "";
    
    /** 검색Keyword */
    private String searchKeyword2 = "";
    
    /** 검색Keyword */
    private String searchConnectKeyword = "";    
    
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

    /** 검색 유형 */
    private String schTypeId = "";
    
    /** 검색 이름 */
    private String schMbrNm = "";
    
    /** 검색 이메일 */
    private String schEmail = "";
    
    /** 이전 패스워드 */
    private String oldPasswd = "";
    
    /** 사업자번호 */
    private String establishment = "";
    
    /** 법인등록번호 */
    private String corporation = "";
    
    /** 고유번호 */
    private String primaryKey = "";
    
    /** 단체종류 */
    private String groupType = "";
    
    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10; 
    
    /** connectYn 사용여부 */
    private java.lang.String connectYn = "N";
    
    /** orderByMbrIdYn 사용여부 */
    private java.lang.String orderByMbrIdYn = "Y";
    
    /** orderByRankIdYn 사용여부 */
    private java.lang.String orderByRankIdYn = "N";
    
    /** pageYn 페이지 사용여부 */
    private java.lang.String pageYn = "Y";
    
    /** typeNmYn 사용여부 */
    private java.lang.String typeNmYn = "N";
    
    /** orderbyCondition */
    private java.lang.String orderbyCondition;
    
    /** orgIdYn */
    private java.lang.String orgIdYn = "N";
    
    /** orgId */
    private java.lang.String orgId = "";
    
    /** typeIdCondition */
    private java.lang.String typeIdCondition = "";
    
    /** typeIdKeyword */
    private java.lang.String typeIdKeyword = "";
    
    /** typeIdKeyword2 */
    private java.lang.String typeIdKeyword2 = "";
    
    /** typeIdKeyword3 */
    private java.lang.String typeIdKeyword3 = "";
    
    /** typeIdKeyword4 */
    private java.lang.String typeIdKeyword4 = "";
    
    /** typeIdKeyword5 */
    private java.lang.String typeIdKeyword5 = "";
    
    /** condition */
    private java.lang.String condition = "";
    
    /** QueryYn */
    private java.lang.String QueryYn = "N";
    
    /** Qeury */
    private java.lang.String Query;
    
    /** grpConfirmYn */
    private java.lang.String grpConfirmYn = "N";
    
    /** grpConfirm */
    private java.lang.String grpConfirm = "";
    
	/**
	 * @return the grpConfirm
	 */
	public java.lang.String getGrpConfirm() {
		return grpConfirm;
	}

	/**
	 * @param grpConfirm the grpConfirm to set
	 */
	public void setGrpConfirm(java.lang.String grpConfirm) {
		this.grpConfirm = grpConfirm;
	}

	/**
	 * @return the grpConfirmYn
	 */
	public java.lang.String getGrpConfirmYn() {
		return grpConfirmYn;
	}

	/**
	 * @param grpConfirmYn the grpConfirmYn to set
	 */
	public void setGrpConfirmYn(java.lang.String grpConfirmYn) {
		this.grpConfirmYn = grpConfirmYn;
	}

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
	 * @return the condition
	 */
	public java.lang.String getCondition() {
		return condition;
	}

	/**
	 * @param condition the condition to set
	 */
	public void setCondition(java.lang.String condition) {
		this.condition = condition;
	}

	/**
	 * @return the typeIdCondition
	 */
	public java.lang.String getTypeIdCondition() {
		return typeIdCondition;
	}

	/**
	 * @param typeIdCondition the typeIdCondition to set
	 */
	public void setTypeIdCondition(java.lang.String typeIdCondition) {
		this.typeIdCondition = typeIdCondition;
	}

	/**
	 * @return the typeIdKeyword5
	 */
	public java.lang.String getTypeIdKeyword5() {
		return typeIdKeyword5;
	}

	/**
	 * @param typeIdKeyword5 the typeIdKeyword5 to set
	 */
	public void setTypeIdKeyword5(java.lang.String typeIdKeyword5) {
		this.typeIdKeyword5 = typeIdKeyword5;
	}

	/**
	 * @return the typeIdKeyword4
	 */
	public java.lang.String getTypeIdKeyword4() {
		return typeIdKeyword4;
	}

	/**
	 * @param typeIdKeyword4 the typeIdKeyword4 to set
	 */
	public void setTypeIdKeyword4(java.lang.String typeIdKeyword4) {
		this.typeIdKeyword4 = typeIdKeyword4;
	}

	/**
	 * @return the typeIdKeyword3
	 */
	public java.lang.String getTypeIdKeyword3() {
		return typeIdKeyword3;
	}

	/**
	 * @param typeIdKeyword3 the typeIdKeyword3 to set
	 */
	public void setTypeIdKeyword3(java.lang.String typeIdKeyword3) {
		this.typeIdKeyword3 = typeIdKeyword3;
	}

	/**
	 * @return the typeIdKeyword
	 */
	public java.lang.String getTypeIdKeyword() {
		return typeIdKeyword;
	}

	/**
	 * @param typeIdKeyword the typeIdKeyword to set
	 */
	public void setTypeIdKeyword(java.lang.String typeIdKeyword) {
		this.typeIdKeyword = typeIdKeyword;
	}

	/**
	 * @return the typeIdKeyword2
	 */
	public java.lang.String getTypeIdKeyword2() {
		return typeIdKeyword2;
	}

	/**
	 * @param typeIdKeyword2 the typeIdKeyword2 to set
	 */
	public void setTypeIdKeyword2(java.lang.String typeIdKeyword2) {
		this.typeIdKeyword2 = typeIdKeyword2;
	}

	/**
	 * @return the orgIdYn
	 */
	public java.lang.String getOrgIdYn() {
		return orgIdYn;
	}

	/**
	 * @param orgIdYn the orgIdYn to set
	 */
	public void setOrgIdYn(java.lang.String orgIdYn) {
		this.orgIdYn = orgIdYn;
	}

	/**
	 * @return the orgId
	 */
	public java.lang.String getOrgId() {
		return orgId;
	}

	/**
	 * @param orgId the orgId to set
	 */
	public void setOrgId(java.lang.String orgId) {
		this.orgId = orgId;
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
	 * @return the typeNmYn
	 */
	public java.lang.String getTypeNmYn() {
		return typeNmYn;
	}

	/**
	 * @param typeNmYn the typeNmYn to set
	 */
	public void setTypeNmYn(java.lang.String typeNmYn) {
		this.typeNmYn = typeNmYn;
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
	 * @return the orderByMbrIdYn
	 */
	public java.lang.String getOrderByMbrIdYn() {
		return orderByMbrIdYn;
	}

	/**
	 * @param orderByMbrIdYn the orderByMbrIdYn to set
	 */
	public void setOrderByMbrIdYn(java.lang.String orderByMbrIdYn) {
		this.orderByMbrIdYn = orderByMbrIdYn;
	}

	/**
	 * @return the orderByRankIdYn
	 */
	public java.lang.String getOrderByRankIdYn() {
		return orderByRankIdYn;
	}

	/**
	 * @param orderByRankIdYn the orderByRankIdYn to set
	 */
	public void setOrderByRankIdYn(java.lang.String orderByRankIdYn) {
		this.orderByRankIdYn = orderByRankIdYn;
	}

	/**
	 * @return the connectYn
	 */
	public java.lang.String getConnectYn() {
		return connectYn;
	}

	/**
	 * @param connectYn the connectYn to set
	 */
	public void setConnectYn(java.lang.String connectYn) {
		this.connectYn = connectYn;
	}

	/**
	 * @return the searchConnectKeyword
	 */
	public String getSearchConnectKeyword() {
		return searchConnectKeyword;
	}

	/**
	 * @param searchConnectKeyword the searchConnectKeyword to set
	 */
	public void setSearchConnectKeyword(String searchConnectKeyword) {
		this.searchConnectKeyword = searchConnectKeyword;
	}

	public String getGroupType() {
		return groupType;
	}

	public void setGroupType(String groupType) {
		this.groupType = groupType;
	}

	public String getEstablishment() {
		return establishment;
	}

	public void setEstablishment(String establishment) {
		this.establishment = establishment;
	}

	public String getCorporation() {
		return corporation;
	}

	public void setCorporation(String corporation) {
		this.corporation = corporation;
	}

	public String getPrimaryKey() {
		return primaryKey;
	}

	public void setPrimaryKey(String primaryKey) {
		this.primaryKey = primaryKey;
	}

	public String getSearchKeyword1() {
		return searchKeyword1;
	}

	public void setSearchKeyword1(String searchKeyword1) {
		this.searchKeyword1 = searchKeyword1;
	}

	public String getSearchKeyword2() {
		return searchKeyword2;
	}

	public void setSearchKeyword2(String searchKeyword2) {
		this.searchKeyword2 = searchKeyword2;
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

	public String getSchTypeId() {
		return schTypeId;
	}

	public void setSchTypeId(String schTypeId) {
		this.schTypeId = schTypeId;
	}

	public void setSchMbrNm(String schMbrNm) {
		this.schMbrNm = schMbrNm;
	}

	public String getSchMbrNm() {
		return schMbrNm;
	}

	public void setSchEmail(String schEmail) {
		this.schEmail = schEmail;
	}

	public String getSchEmail() {
		return schEmail;
	}

	public void setOldPasswd(String oldPasswd) {
		this.oldPasswd = oldPasswd;
	}

	public String getOldPasswd() {
		return oldPasswd;
	}

}
