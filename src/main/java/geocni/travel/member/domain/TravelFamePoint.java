package geocni.travel.member.domain;

import java.util.List;

import geocni.travel.common.TravelDefaultVO;

public class TravelFamePoint extends TravelDefaultVO {

    private static final long serialVersionUID = 1L;

    /*명성 지수 고유 회원 ID*/
    private String fameUserId;
    
    /*명성 지수 순위*/
    private int fameRanking = 0;
    
    /*명성 지수 합계*/
    private int famePointSum = 0;
    
    /*명성 지수 내글 추천수*/
    private int fameRecoCase = 0;
    
    /*명성 지수 내글 공유 수*/
    private int fameSharedCase = 0;
    
    /*명성 지수 회원 이름*/
    private String fameUserNm;
    
    /*명성 지수 회원 플픽*/
    private String fameUserPic;
    
    private List<TravelFameHistory> recommHistory;

	public String getFameUserId() {
		return fameUserId;
	}

	public void setFameUserId(String fameUserId) {
		this.fameUserId = fameUserId;
	}

	public int getFameRanking() {
		return fameRanking;
	}

	public void setFameRanking(int fameRanking) {
		this.fameRanking = fameRanking;
	}

	public int getFamePointSum() {
		return famePointSum;
	}

	public void setFamePointSum(int famePointSum) {
		this.famePointSum = famePointSum;
	}

	public int getFameRecoCase() {
		return fameRecoCase;
	}

	public void setFameRecoCase(int fameRecoCase) {
		this.fameRecoCase = fameRecoCase;
	}

	public int getFameSharedCase() {
		return fameSharedCase;
	}

	public void setFameSharedCase(int fameSharedCase) {
		this.fameSharedCase = fameSharedCase;
	}

	public String getFameUserNm() {
		return fameUserNm;
	}

	public void setFameUserNm(String fameUserNm) {
		this.fameUserNm = fameUserNm;
	}

	public String getFameUserPic() {
		return fameUserPic;
	}

	public void setFameUserPic(String fameUserPic) {
		this.fameUserPic = fameUserPic;
	}

	public List<TravelFameHistory> getRecommHistory() {
		return recommHistory;
	}

	public void setRecommHistory(List<TravelFameHistory> recommHistory) {
		this.recommHistory = recommHistory;
	}
}
