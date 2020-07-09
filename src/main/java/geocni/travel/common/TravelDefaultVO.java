package geocni.travel.common;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;

public class TravelDefaultVO implements Serializable {
	Calendar cal = Calendar.getInstance();

    private static final long serialVersionUID = 1L;

    /** 검색조건 */
    private String searchCondition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 게시판 아이디 검색Keyword */
    private String cmtBoardId = "";
    
    /** 게시물 아이디 검색Keyword */
    private int cmtBoardCntId;
      
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
    private int firstIndex = 0;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    private String ssyear = String.valueOf(cal.get(Calendar.YEAR));
    
    private String ssmonth =  String.format("%02d",cal.get(Calendar.MONTH) + 1);
    
    private String ssdate =  String.format("%02d",cal.get(Calendar.DAY_OF_MONTH));


	public String getSsmonth() {
		return ssmonth;
	}

	public void setSsmonth(String ssmonth) {
		this.ssmonth = ssmonth;
	}

	public String getSsdate() {
		return ssdate;
	}

	public void setSsdate(String ssdate) {
		this.ssdate = ssdate;
	}

	public String getSsyear() {
		return ssyear;
	}

	public void setSsyear(String ssyear) {
		this.ssyear = ssyear;
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

	public String getCmtBoardId() {
		return cmtBoardId;
	}

	public void setCmtBoardId(String cmtBoardId) {
		this.cmtBoardId = cmtBoardId;
	}

	public int getCmtBoardCntId() {
		return cmtBoardCntId;
	}

	public void setCmtBoardCntId(int cmtBoardCntId) {
		this.cmtBoardCntId = cmtBoardCntId;
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
}
