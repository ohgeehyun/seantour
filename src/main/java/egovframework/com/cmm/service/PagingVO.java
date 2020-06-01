/**
 * @version 3.2.0.1
 */
package egovframework.com.cmm.service;


/**
 * @Class Name : Paging.java
 * @Description : 페이징 처리를 위한 VO 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2011. 10. 21.     김문기
 *
 * @author Affis 개발팀 김문기
 * @since 2011. 10. 21.
 * @version
 * @see
 *
 */
public class PagingVO{
	//총 데이터 수
	private int totalRecord = 0;
	//1페이지당 데이터 수
	private int recordPerPage = 0;
	//페이징에 출력될 페이지 수
	private int pagingPerPage = 0;
	//현재 페이지
	private int curPage = 0;
	//페이징에서 첫번째 페이지번호
	private int startPage = 0;
	//페이징에서 마지막 페이지번호
	private int endPage = 0;
	//총 페이지
	private int totalPage = 0;
	//처음으로 버튼 출력여부
	private boolean existFirstBtn = false;
	//마지막으로 버튼 출력여부
	private boolean existLastBtn = false;
	//이전 페이지 버튼 출력여부
	private boolean existPrevBtn = false;
	//다음 페이지 버튼 출력여부
	private boolean existNextBtn = false;
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	public int getRecordPerPage() {
		return recordPerPage;
	}
	public void setRecordPerPage(int recordPerPage) {
		this.recordPerPage = recordPerPage;
	}
	public int getPagingPerPage() {
		return pagingPerPage;
	}
	public void setPagingPerPage(int pagingPerPage) {
		this.pagingPerPage = pagingPerPage;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public boolean getExistFirstBtn() {
		return existFirstBtn;
	}
	public void setExistFirstBtn(boolean existFirstBtn) {
		this.existFirstBtn = existFirstBtn;
	}
	public boolean getExistLastBtn() {
		return existLastBtn;
	}
	public void setExistLastBtn(boolean existLastBtn) {
		this.existLastBtn = existLastBtn;
	}
	public boolean getExistPrevBtn() {
		return existPrevBtn;
	}
	public void setExistPrevBtn(boolean existPrevBtn) {
		this.existPrevBtn = existPrevBtn;
	}
	public boolean getExistNextBtn() {
		return existNextBtn;
	}
	public void setExistNextBtn(boolean existNextBtn) {
		this.existNextBtn = existNextBtn;
	}
}
