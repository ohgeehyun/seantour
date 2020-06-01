package geocni.travel.member.domain;

import geocni.travel.common.TravelDefaultVO;

public class TravelFameHistory extends TravelDefaultVO {

    private static final long serialVersionUID = 1L;

    /*명성 적립 ID*/
    private String fameHisId;
    
    /*명성 적립 포인트(L-10, R-100, S-50, F-200)*/
    private int fameHisPoint = 0;
    
    /*명성 적립 타입(L-홈페이지로그인접속, R-여행일정추천됨, S-여행지SNS공유함, F-인기추천여행일정으로선정됨)*/
    private String fameHisType;
    
    /*명성 적립 내역*/
    private String fameHisItem;
    
    /*명성 적립 아이디*/
    private String fameHisRecUser;
    
    /*명성 적립 일시*/
    private String fameHisDate;
    
    /*명성 추천인 이름*/
    private String fameHisRecUserNm;
    
	public String getFameHisId() {
		return fameHisId;
	}
	public void setFameHisId(String fameHisId) {
		this.fameHisId = fameHisId;
	}
	public int getFameHisPoint() {
		return fameHisPoint;
	}
	public void setFameHisPoint(int fameHisPoint) {
		this.fameHisPoint = fameHisPoint;
	}
	public String getFameHisType() {
		return fameHisType;
	}
	public void setFameHisType(String fameHisType) {
		this.fameHisType = fameHisType;
	}
	public String getFameHisItem() {
		return fameHisItem;
	}
	public void setFameHisItem(String fameHisItem) {
		this.fameHisItem = fameHisItem;
	}
	public String getFameHisRecUser() {
		return fameHisRecUser;
	}
	public void setFameHisRecUser(String fameHisRecUser) {
		this.fameHisRecUser = fameHisRecUser;
	}
	public String getFameHisDate() {
		return fameHisDate;
	}
	public void setFameHisDate(String fameHisDate) {
		this.fameHisDate = fameHisDate;
	}
	public String getFameHisRecUserNm() {
		return fameHisRecUserNm;
	}
	public void setFameHisRecUserNm(String fameHisRecUserNm) {
		this.fameHisRecUserNm = fameHisRecUserNm;
	}

}
