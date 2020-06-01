/**
 * @version 3.2.0.1
 */
package jnit.com.vo;

import java.util.Date;

import com.google.gson.Gson;

/**
 * JNIT 기본 모델 클래스
 * 
 * @author JNIT
 * @since 2012.06.22
 * @version 1.0
 * @see
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2012.06.22  JNIT          최초 생성
 *
 * </pre>
 */
public class JnitDefaultVO {

	/** 삭제여부 */
	private boolean isdel = false;

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

	/** firstIndex */
	private int firstIndex = 1;

	/** lastIndex */
	private int lastIndex = 1;

	/** recordCountPerPage */
	private int recordCountPerPage = 10;

	private String orderSql;

	private Date created;
	private String createdMbrId;
	private Date modified;
	private String modifiedMbrId;

	private String retUrl;

	public boolean isIsdel() {
		return isdel;
	}

	public void setIsdel(boolean isdel) {
		this.isdel = isdel;
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

	public String getOrderSql() {
		return orderSql;
	}

	public void setOrderSql(String orderSql) {
		this.orderSql = orderSql;
	}

	public Date getCreated() {
		return created;
	}

	public void setCreated(Date created) {
		this.created = created;
	}

	public String getCreatedMbrId() {
		return createdMbrId;
	}

	public void setCreatedMbrId(String createdMbrId) {
		this.createdMbrId = createdMbrId;
	}

	public Date getModified() {
		return modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}

	public String getModifiedMbrId() {
		return modifiedMbrId;
	}

	public void setModifiedMbrId(String modifiedMbrId) {
		this.modifiedMbrId = modifiedMbrId;
	}

	public String getRetUrl() {
		return retUrl;
	}

	public void setRetUrl(String retUrl) {
		this.retUrl = retUrl;
	}


	private static final Gson gson = new Gson();
	
	@Override
	public String toString() {
		return gson.toJson(this);
	}

}
