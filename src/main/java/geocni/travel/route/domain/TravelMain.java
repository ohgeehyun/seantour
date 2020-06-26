package geocni.travel.route.domain;

import java.util.List;

import geocni.travel.common.TravelDefaultVO;

public class TravelMain extends TravelDefaultVO {

    private static final long serialVersionUID = 1L;

    /*데이터생성시각*/
    private String etlDt;

    /*해수욕장 번호*/
    private String seqId;

    /*해수욕장 명칭*/
    private String poiNm;

    /*해수욕장별 인구수*/
    private String uniqPop;

	public String getEtlDt() {
		return etlDt;
	}

	public void setEtlDt(String etlDt) {
		this.etlDt = etlDt;
	}

	public String getSeqId() {
		return seqId;
	}

	public void setSeqId(String seqId) {
		this.seqId = seqId;
	}

	public String getPoiNm() {
		return poiNm;
	}

	public void setPoiNm(String poiNm) {
		this.poiNm = poiNm;
	}

	public String getUniqPop() {
		return uniqPop;
	}

	public void setUniqPop(String uniqPop) {
		this.uniqPop = uniqPop;
	}
    
    
}
