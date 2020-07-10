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
    
    private String congestion;
    
    private String capacity;
    
    private String area;
    
    private String beach_name;
    
    private String length;
    
    private String width;
    
    
    public String Width() {
    	return width;
    }
    
    public void setWidth(String width) {
    	this.width = width;
    }
    
    public String getLength() {
    	return length;
    }
    
    public void setLength(String length) {
    	this.length = length;
    }
    
    
    
    public String getBeach_name() {
    	return beach_name;
    }
    
    public void setBeach_name(String beach_name) {
    	this.beach_name = beach_name;
    }
    
    
    public String getArea() {
    	return area;
    }
    
    public void setArea(String area) {
    	this.area = area;
    }
    
    
    public String getCapacity() {
    	return capacity;
    }
    
    public void setCapacity(String capacity) {
    	this.capacity = capacity;
    }
    
    
    public String getCongestion() {
    	return congestion;
    }
    
    public void setCongestion(String congestion) {
    	this.congestion = congestion;
    }

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
