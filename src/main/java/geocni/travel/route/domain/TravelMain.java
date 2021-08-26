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
    
    private String destId;
    
    private String datestrtemp;
    
    private String datestrtemp2;
    
    //해수욕장 오픈일
    private String open;
    //해수욕장 폐장일
    private String closing;
    
    
    //도
    private String area_name;
    //시
    private String area_name2;
    
    
    
    
    
    public String getOpen() {
		return open;
	}

	public void setOpen(String open) {
		this.open = open;
	}

	public String getClosing() {
		return closing;
	}

	public void setClosing(String closing) {
		this.closing = closing;
	}

	public String getArea_name2() {
		return area_name2;
	}

	public void setArea_name2(String area_name2) {
		this.area_name2 = area_name2;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getArea_name() {
		return area_name;
	}

	public void setArea_name(String area_name) {
		this.area_name = area_name;
	}

	public String getDatestrtemp2() {
    	return datestrtemp2;
    }
    
    public void setDatestrtemp2(String datestrtemp2) {
    	this.datestrtemp2 = datestrtemp2;
    }
    
    
    public String getDatestrtemp() {
    	return datestrtemp;
    }
    
    public void setDatestrtemp(String datestrtemp) {
    	this.datestrtemp = datestrtemp;
    }
    
    public String getDestId() {
    	return destId;
    }
    
    public void setDestId(String destId) {
    	this.destId = destId;
    }
    
    
    public String getWidth() {
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
