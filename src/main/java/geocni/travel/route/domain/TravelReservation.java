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
	private String reseRegDate;			//등록일자
	private String seq_id;
	private String poi_nm;
	private String max_uniq_pop;
	private String max_time;
	private String time0000;
	private String time0030;
	private String time0100;
	private String time0130;
	private String time0200;
	private String time0230;
	private String time0300;
	private String time0330;
	private String time0400;
	private String time0430;
	private String time0500;
	private String time0530;
	private String time0600;
	private String time0630;
	private String time0700;
	private String time0730;
	private String time0800;
	private String time0830;
	private String time0900;
	private String time0930;
	private String time1000;
	private String time1030;
	private String time1100;
	private String time1130;
	private String time1200;
	private String time1230;
	private String time1300;
	private String time1330;
	private String time1400;
	private String time1430;
	private String time1500;
	private String time1530;
	private String time1600;
	private String time1630;
	private String time1700;
	private String time1730;
	private String time1800;
	private String time1830;
	private String time1900;
	private String time1930;
	private String time2000;
	private String time2030;
	private String time2100;
	private String time2130;
	private String time2200;
	private String time2230;
	private String time2300;
	private String time2330;
	
	
	public String getTime0000() {
		return time0000;
	}
	public void setTime0000(String time0000) {
		this.time0000 = time0000;
	}
	public String getTime0030() {
		return time0030;
	}
	public void setTime0030(String time0030) {
		this.time0030 = time0030;
	}
	public String getTime0100() {
		return time0100;
	}
	public void setTime0100(String time0100) {
		this.time0100 = time0100;
	}
	public String getTime0130() {
		return time0130;
	}
	public void setTime0130(String time0130) {
		this.time0130 = time0130;
	}
	public String getTime0200() {
		return time0200;
	}
	public void setTime0200(String time0200) {
		this.time0200 = time0200;
	}
	public String getTime0230() {
		return time0230;
	}
	public void setTime0230(String time0230) {
		this.time0230 = time0230;
	}
	public String getTime0300() {
		return time0300;
	}
	public void setTime0300(String time0300) {
		this.time0300 = time0300;
	}
	public String getTime0330() {
		return time0330;
	}
	public void setTime0330(String time0330) {
		this.time0330 = time0330;
	}
	public String getTime0400() {
		return time0400;
	}
	public void setTime0400(String time0400) {
		this.time0400 = time0400;
	}
	public String getTime0430() {
		return time0430;
	}
	public void setTime0430(String time0430) {
		this.time0430 = time0430;
	}
	public String getTime0500() {
		return time0500;
	}
	public void setTime0500(String time0500) {
		this.time0500 = time0500;
	}
	public String getTime0530() {
		return time0530;
	}
	public void setTime0530(String time0530) {
		this.time0530 = time0530;
	}
	public String getTime0600() {
		return time0600;
	}
	public void setTime0600(String time0600) {
		this.time0600 = time0600;
	}
	public String getTime0630() {
		return time0630;
	}
	public void setTime0630(String time0630) {
		this.time0630 = time0630;
	}
	public String getTime0700() {
		return time0700;
	}
	public void setTime0700(String time0700) {
		this.time0700 = time0700;
	}
	public String getTime0730() {
		return time0730;
	}
	public void setTime0730(String time0730) {
		this.time0730 = time0730;
	}
	public String getTime0800() {
		return time0800;
	}
	public void setTime0800(String time0800) {
		this.time0800 = time0800;
	}
	public String getTime0830() {
		return time0830;
	}
	public void setTime0830(String time0830) {
		this.time0830 = time0830;
	}
	public String getTime0900() {
		return time0900;
	}
	public void setTime0900(String time0900) {
		this.time0900 = time0900;
	}
	public String getTime0930() {
		return time0930;
	}
	public void setTime0930(String time0930) {
		this.time0930 = time0930;
	}
	public String getTime1000() {
		return time1000;
	}
	public void setTime1000(String time1000) {
		this.time1000 = time1000;
	}
	public String getTime1030() {
		return time1030;
	}
	public void setTime1030(String time1030) {
		this.time1030 = time1030;
	}
	public String getTime1100() {
		return time1100;
	}
	public void setTime1100(String time1100) {
		this.time1100 = time1100;
	}
	public String getTime1130() {
		return time1130;
	}
	public void setTime1130(String time1130) {
		this.time1130 = time1130;
	}
	public String getTime1200() {
		return time1200;
	}
	public void setTime1200(String time1200) {
		this.time1200 = time1200;
	}
	public String getTime1230() {
		return time1230;
	}
	public void setTime1230(String time1230) {
		this.time1230 = time1230;
	}
	public String getTime1300() {
		return time1300;
	}
	public void setTime1300(String time1300) {
		this.time1300 = time1300;
	}
	public String getTime1330() {
		return time1330;
	}
	public void setTime1330(String time1330) {
		this.time1330 = time1330;
	}
	public String getTime1400() {
		return time1400;
	}
	public void setTime1400(String time1400) {
		this.time1400 = time1400;
	}
	public String getTime1430() {
		return time1430;
	}
	public void setTime1430(String time1430) {
		this.time1430 = time1430;
	}
	public String getTime1500() {
		return time1500;
	}
	public void setTime1500(String time1500) {
		this.time1500 = time1500;
	}
	public String getTime1530() {
		return time1530;
	}
	public void setTime1530(String time1530) {
		this.time1530 = time1530;
	}
	public String getTime1600() {
		return time1600;
	}
	public void setTime1600(String time1600) {
		this.time1600 = time1600;
	}
	public String getTime1630() {
		return time1630;
	}
	public void setTime1630(String time1630) {
		this.time1630 = time1630;
	}
	public String getTime1700() {
		return time1700;
	}
	public void setTime1700(String time1700) {
		this.time1700 = time1700;
	}
	public String getTime1730() {
		return time1730;
	}
	public void setTime1730(String time1730) {
		this.time1730 = time1730;
	}
	public String getTime1800() {
		return time1800;
	}
	public void setTime1800(String time1800) {
		this.time1800 = time1800;
	}
	public String getTime1830() {
		return time1830;
	}
	public void setTime1830(String time1830) {
		this.time1830 = time1830;
	}
	public String getTime1900() {
		return time1900;
	}
	public void setTime1900(String time1900) {
		this.time1900 = time1900;
	}
	public String getTime1930() {
		return time1930;
	}
	public void setTime1930(String time1930) {
		this.time1930 = time1930;
	}
	public String getTime2000() {
		return time2000;
	}
	public void setTime2000(String time2000) {
		this.time2000 = time2000;
	}
	public String getTime2030() {
		return time2030;
	}
	public void setTime2030(String time2030) {
		this.time2030 = time2030;
	}
	public String getTime2100() {
		return time2100;
	}
	public void setTime2100(String time2100) {
		this.time2100 = time2100;
	}
	public String getTime2130() {
		return time2130;
	}
	public void setTime2130(String time2130) {
		this.time2130 = time2130;
	}
	public String getTime2200() {
		return time2200;
	}
	public void setTime2200(String time2200) {
		this.time2200 = time2200;
	}
	public String getTime2230() {
		return time2230;
	}
	public void setTime2230(String time2230) {
		this.time2230 = time2230;
	}
	public String getTime2300() {
		return time2300;
	}
	public void setTime2300(String time2300) {
		this.time2300 = time2300;
	}
	public String getTime2330() {
		return time2330;
	}
	public void setTime2330(String time2330) {
		this.time2330 = time2330;
	}	
	
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
	public String getReseRegDate() {
		return reseRegDate;
	}
	public void setReseRegDate(String reseRegDate) {
		this.reseRegDate = reseRegDate;
	}
}
