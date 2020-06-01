/**
 * @version 3.2.0.1
 */
package jnit.cms.search;

public class JnitcmssearchVO {
	/** 금칙어 */
	private java.lang.String limitNm;	
	
	/** 검색 제외 게시판 ID */
	private java.lang.String limitBoardId;
	
	/** 검색 제외 게시판 타이틀 */
	private java.lang.String limitBoardTitle;
	
	/** 검색 제외 게시판 내용 */
	private java.lang.String limitBoardContent;
	
	/** 검색 제외 회원ID */
	private java.lang.String limitMbrId;
	
	/** 검색 제외 회원유형 */
	private java.lang.String limitMbrType;
	
	/** 검색 제외 콘텐츠 ID */
	private java.lang.String limitCntId;
	
	/** 검색 제외 콘텐츠명 */
	private java.lang.String limitCntNm;
	
	/** 검색 제외 콘텐츠 내용 */
	private java.lang.String limitCntSrc;
	
	/** 검색 정확성 여부 */
	private java.lang.String limitExactYn = "Y";
	
	/** 검색 소문자,대문자 여부 */
	private java.lang.String limitSearch;
	
	/** 주석 검색 여부 */
	private java.lang.String limitCommentYn = "Y";
	
	/** 스크립트 검색 여부 */
	private java.lang.String limitScriptYn = "Y";
	
	/** 직원 검색 사용여부 */
	private java.lang.String limitmbrYn = "Y";
	
	/** 콘텐츠 검색 사용여부 */
	private java.lang.String limitCntYn = "Y";
	
	/** 게시판 검색 사용여부 */
	private java.lang.String limitBoardYn = "Y";
	
	/** 게시판 사이트 기반 검색 */
	private java.lang.String limitBoardSiteYn = "Y";
	
	/** 콘텐츠 사이트 기반 검색 */
	private java.lang.String limitCntSite = "Y";
	
	/**
	 * @return the limitmbrYn
	 */
	public java.lang.String getLimitmbrYn() {
		return limitmbrYn;
	}

	/**
	 * @return the limitCntYn
	 */
	public java.lang.String getLimitCntYn() {
		return limitCntYn;
	}

	/**
	 * @return the limitBoardYn
	 */
	public java.lang.String getLimitBoardYn() {
		return limitBoardYn;
	}

	/**
	 * @param limitmbrYn the limitmbrYn to set
	 */
	public void setLimitmbrYn(java.lang.String limitmbrYn) {
		this.limitmbrYn = limitmbrYn;
	}

	/**
	 * @param limitCntYn the limitCntYn to set
	 */
	public void setLimitCntYn(java.lang.String limitCntYn) {
		this.limitCntYn = limitCntYn;
	}

	/**
	 * @param limitBoardYn the limitBoardYn to set
	 */
	public void setLimitBoardYn(java.lang.String limitBoardYn) {
		this.limitBoardYn = limitBoardYn;
	}

	/**
	 * @return the limitScriptYn
	 */
	public java.lang.String getLimitScriptYn() {
		return limitScriptYn;
	}

	/**
	 * @param limitScriptYn the limitScriptYn to set
	 */
	public void setLimitScriptYn(java.lang.String limitScriptYn) {
		this.limitScriptYn = limitScriptYn;
	}

	/**
	 * @return the limitCntSrc
	 */
	public java.lang.String getLimitCntSrc() {
		return limitCntSrc;
	}

	/**
	 * @param limitCntSrc the limitCntSrc to set
	 */
	public void setLimitCntSrc(java.lang.String limitCntSrc) {
		this.limitCntSrc = limitCntSrc;
	}

	/**
	 * @return the limitBoardId
	 */
	public java.lang.String getLimitBoardId() {
		return limitBoardId;
	}

	/**
	 * @param limitBoardId the limitBoardId to set
	 */
	public void setLimitBoardId(java.lang.String limitBoardId) {
		this.limitBoardId = limitBoardId;
	}

	/**
	 * @return the limitCommentYn
	 */
	public java.lang.String getLimitCommentYn() {
		return limitCommentYn;
	}

	/**
	 * @param limitCommentYn the limitCommentYn to set
	 */
	public void setLimitCommentYn(java.lang.String limitCommentYn) {
		this.limitCommentYn = limitCommentYn;
	}

	/**
	 * @return the limitMbrType
	 */
	public java.lang.String getLimitMbrType() {
		return limitMbrType;
	}

	/**
	 * @param limitMbrType the limitMbrType to set
	 */
	public void setLimitMbrType(java.lang.String limitMbrType) {
		this.limitMbrType = limitMbrType;
	}

	/**
	 * @return the limitCntId
	 */
	public java.lang.String getLimitCntId() {
		return limitCntId;
	}

	/**
	 * @param limitCntId the limitCntId to set
	 */
	public void setLimitCntId(java.lang.String limitCntId) {
		this.limitCntId = limitCntId;
	}

	/**
	 * @return the limitBoardContent
	 */
	public java.lang.String getLimitBoardContent() {
		return limitBoardContent;
	}

	/**
	 * @param limitBoardContent the limitBoardContent to set
	 */
	public void setLimitBoardContent(java.lang.String limitBoardContent) {
		this.limitBoardContent = limitBoardContent;
	}

	/**
	 * @return the limitNm
	 */
	public java.lang.String getLimitNm() {
		return limitNm;
	}

	/**
	 * @return the limitBoardTitle
	 */
	public java.lang.String getLimitBoardTitle() {
		return limitBoardTitle;
	}

	/**
	 * @return the limitMbrId
	 */
	public java.lang.String getLimitMbrId() {
		return limitMbrId;
	}

	/**
	 * @return the limitCntNm
	 */
	public java.lang.String getLimitCntNm() {
		return limitCntNm;
	}

	/**
	 * @return the limitExactYn
	 */
	public java.lang.String getLimitExactYn() {
		return limitExactYn;
	}

	/**
	 * @return the limitSearch
	 */
	public java.lang.String getLimitSearch() {
		return limitSearch;
	}

	/**
	 * @param limitNm the limitNm to set
	 */
	public void setLimitNm(java.lang.String limitNm) {
		this.limitNm = limitNm;
	}	

	/**
	 * @param limitBoardTitle the limitBoardTitle to set
	 */
	public void setLimitBoardTitle(java.lang.String limitBoardTitle) {
		this.limitBoardTitle = limitBoardTitle;
	}

	/**
	 * @param limitMbrId the limitMbrId to set
	 */
	public void setLimitMbrId(java.lang.String limitMbrId) {
		this.limitMbrId = limitMbrId;
	}

	/**
	 * @param limitCntNm the limitCntNm to set
	 */
	public void setLimitCntNm(java.lang.String limitCntNm) {
		this.limitCntNm = limitCntNm;
	}

	/**
	 * @param limitExactYn the limitExactYn to set
	 */
	public void setLimitExactYn(java.lang.String limitExactYn) {
		this.limitExactYn = limitExactYn;
	}

	/**
	 * @param limitSearch the limitSearch to set
	 */
	public void setLimitSearch(java.lang.String limitSearch) {
		this.limitSearch = limitSearch;
	}

	public java.lang.String getLimitBoardSiteYn() {
		return limitBoardSiteYn;
	}

	public void setLimitBoardSiteYn(java.lang.String limitBoardSiteYn) {
		this.limitBoardSiteYn = limitBoardSiteYn;
	}

	public java.lang.String getLimitCntSite() {
		return limitCntSite;
	}

	public void setLimitCntSite(java.lang.String limitCntSite) {
		this.limitCntSite = limitCntSite;
	}
	
	
}
