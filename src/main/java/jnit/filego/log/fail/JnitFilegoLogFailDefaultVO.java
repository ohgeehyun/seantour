package jnit.filego.log.fail;


public class JnitFilegoLogFailDefaultVO {

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
    
    private String pageYn = "";

    private String searchDateCondition;
    
    private String searchStartDate;
    
    private String searchEndDate;

	
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

	
	public String getScreenMode() {
		return screenMode;
	}

	
	public void setScreenMode(String screenMode) {
		this.screenMode = screenMode;
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

	
	public String getPageYn() {
		return pageYn;
	}

	
	public void setPageYn(String pageYn) {
		this.pageYn = pageYn;
	}

	
	public String getSearchDateCondition() {
		return searchDateCondition;
	}

	
	public void setSearchDateCondition(String searchDateCondition) {
		this.searchDateCondition = searchDateCondition;
	}

	
	public String getSearchStartDate() {
		return searchStartDate;
	}

	
	public void setSearchStartDate(String searchStartDate) {
		this.searchStartDate = searchStartDate;
	}

	
	public String getSearchEndDate() {
		return searchEndDate;
	}

	
	public void setSearchEndDate(String searchEndDate) {
		this.searchEndDate = searchEndDate;
	}
}