package geocni.travel.route.domain;

import geocni.travel.common.TravelDefaultVO;

public class TravelReservation extends TravelDefaultVO {
	private static final long serialVersionUID = 1L;
	private String reseBeachId;			//해수욕장 ID
	private String reseBeachRegionCd;	//해수욕장 지역코드
	private String reseBeachNameCd;		//해수욕장 이름코드
	private String reseBeachRegion;		//해수욕장 지역명
	private String reseBeachName;		//해수욕장 이름
	private String reseBeachMax;		//해수욕장 최대수용 인원
	private String useYn;				//사용여부
	private String reseDate;			//예약 일자
	private String reseTime;			//예약 시간대
	private String reseNo;				//예약 번호
	private String resePersonnel;		//예약 인원
	private String reseName;			//예약자 이름
	private String reseTel;				//예약자 전화번호
	private String month;				//예약 일자 - 월
	private String day;					//예약 일자 - 일
	private String reseTel_01;			//예약자 전화번호 - 첫번째
	private String reseTel_02;			//예약자 전화번호 - 두번째
	private String reseTel_03;			//예약자 전화번호 - 세번째
	private String reservationYn;		//예약 가능여부
	private String openYn;				//해수욕장 개장여부
	private String duplicationYn;		//예약 중복여부
	private String reseAdminId;			//관리자 ID
	private String reseAdminPw;			//관리자 PW
	private String searchCondition;		//관리자페이지 검색조건
	private String searchKeyword;		//관리자페이지 검색어
	private String resePossCnt;			//예약 가능인원
	private String isExcelDown;			//관리자페이지 엑셀다운 or 조회여부 판단 플래그
	private String reseAreaCd;			//예약자 시/도 코드
	private String reseAreaName;		//예약자 시/도 이름
	private String reseAreaCd_2;		//예약자 구/군 코드
	private String reseAreaName_2;		//예약자 구/군 이름
	private String seq_id;
	private String poi_nm;
	private String max_uniq_pop;
	private String max_time;
	
	public String getSeq_id() {
		return seq_id;
	}
	public void setSeq_id(String seq_id) {
		this.seq_id = seq_id;
	}
	public String getPoi_nm() {
		return poi_nm;
	}
	public void setPoi_nm(String poi_nm) {
		this.poi_nm = poi_nm;
	}
	public String getMax_uniq_pop() {
		return max_uniq_pop;
	}
	public void setMax_uniq_pop(String max_uniq_pop) {
		this.max_uniq_pop = max_uniq_pop;
	}
	public String getMax_time() {
		return max_time;
	}
	public void setMax_time(String max_time) {
		this.max_time = max_time;
	}
	public String getReseBeachId() {
		return reseBeachId;
	}
	public void setReseBeachId(String reseBeachId) {
		this.reseBeachId = reseBeachId;
	}
	public String getReseBeachRegionCd() {
		return reseBeachRegionCd;
	}
	public void setReseBeachRegionCd(String reseBeachRegionCd) {
		this.reseBeachRegionCd = reseBeachRegionCd;
	}
	public String getReseBeachNameCd() {
		return reseBeachNameCd;
	}
	public void setReseBeachNameCd(String reseBeachNameCd) {
		this.reseBeachNameCd = reseBeachNameCd;
	}
	public String getReseBeachRegion() {
		return reseBeachRegion;
	}
	public void setReseBeachRegion(String reseBeachRegion) {
		this.reseBeachRegion = reseBeachRegion;
	}
	public String getReseBeachName() {
		return reseBeachName;
	}
	public void setReseBeachName(String reseBeachName) {
		this.reseBeachName = reseBeachName;
	}
	public String getReseBeachMax() {
		return reseBeachMax;
	}
	public void setReseBeachMax(String reseBeachMax) {
		this.reseBeachMax = reseBeachMax;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getReseDate() {
		return reseDate;
	}
	public void setReseDate(String reseDate) {
		this.reseDate = reseDate;
	}
	public String getReseTime() {
		return reseTime;
	}
	public void setReseTime(String reseTime) {
		this.reseTime = reseTime;
	}
	public String getReseNo() {
		return reseNo;
	}
	public void setReseNo(String reseNo) {
		this.reseNo = reseNo;
	}
	public String getResePersonnel() {
		return resePersonnel;
	}
	public void setResePersonnel(String resePersonnel) {
		this.resePersonnel = resePersonnel;
	}
	public String getReseName() {
		return reseName;
	}
	public void setReseName(String reseName) {
		this.reseName = reseName;
	}
	public String getReseTel() {
		return reseTel;
	}
	public void setReseTel(String reseTel) {
		this.reseTel = reseTel;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getReseTel_01() {
		return reseTel_01;
	}
	public void setReseTel_01(String reseTel_01) {
		this.reseTel_01 = reseTel_01;
	}
	public String getReseTel_02() {
		return reseTel_02;
	}
	public void setReseTel_02(String reseTel_02) {
		this.reseTel_02 = reseTel_02;
	}
	public String getReseTel_03() {
		return reseTel_03;
	}
	public void setReseTel_03(String reseTel_03) {
		this.reseTel_03 = reseTel_03;
	}
	public String getReservationYn() {
		return reservationYn;
	}
	public void setReservationYn(String reservationYn) {
		this.reservationYn = reservationYn;
	}
	public String getOpenYn() {
		return openYn;
	}
	public void setOpenYn(String openYn) {
		this.openYn = openYn;
	}
	public String getDuplicationYn() {
		return duplicationYn;
	}
	public void setDuplicationYn(String duplicationYn) {
		this.duplicationYn = duplicationYn;
	}
	public String getReseAdminId() {
		return reseAdminId;
	}
	public void setReseAdminId(String reseAdminId) {
		this.reseAdminId = reseAdminId;
	}
	public String getReseAdminPw() {
		return reseAdminPw;
	}
	public void setReseAdminPw(String reseAdminPw) {
		this.reseAdminPw = reseAdminPw;
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
	public String getResePossCnt() {
		return resePossCnt;
	}
	public void setResePossCnt(String resePossCnt) {
		this.resePossCnt = resePossCnt;
	}
	public String getIsExcelDown() {
		return isExcelDown;
	}
	public void setIsExcelDown(String isExcelDown) {
		this.isExcelDown = isExcelDown;
	}
	public String getReseAreaCd() {
		return reseAreaCd;
	}
	public void setReseAreaCd(String reseAreaCd) {
		this.reseAreaCd = reseAreaCd;
	}
	public String getReseAreaName() {
		return reseAreaName;
	}
	public void setReseAreaName(String reseAreaName) {
		this.reseAreaName = reseAreaName;
	}
	public String getReseAreaCd_2() {
		return reseAreaCd_2;
	}
	public void setReseAreaCd_2(String reseAreaCd_2) {
		this.reseAreaCd_2 = reseAreaCd_2;
	}
	public String getReseAreaName_2() {
		return reseAreaName_2;
	}
	public void setReseAreaName_2(String reseAreaName_2) {
		this.reseAreaName_2 = reseAreaName_2;
	}
}
