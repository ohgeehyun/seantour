package geocni.travel.member.domain;

import geocni.travel.common.TravelDefaultVO;

public class TravelReaction extends TravelDefaultVO {

    private static final long serialVersionUID = 1L;

    /*리액션 ID*/
    private String rxnId;

    /*리액션 유저 ID*/
    private String rxnUserId;

    /*리액션 대상 ID*/
    private String rxnTargetId;

    /*리액션 타입(LIKE-좋아요, RECO-추천)*/
    private String rxnType;

    /*리액션 생성일시*/
    private String rxnRegDate;

	public String getRxnId() {
		return rxnId;
	}

	public void setRxnId(String rxnId) {
		this.rxnId = rxnId;
	}

	public String getRxnUserId() {
		return rxnUserId;
	}

	public void setRxnUserId(String rxnUserId) {
		this.rxnUserId = rxnUserId;
	}

	public String getRxnTargetId() {
		return rxnTargetId;
	}

	public void setRxnTargetId(String rxnTargetId) {
		this.rxnTargetId = rxnTargetId;
	}

	public String getRxnType() {
		return rxnType;
	}

	public void setRxnType(String rxnType) {
		this.rxnType = rxnType;
	}

	public String getRxnRegDate() {
		return rxnRegDate;
	}

	public void setRxnRegDate(String rxnRegDate) {
		this.rxnRegDate = rxnRegDate;
	}

}
