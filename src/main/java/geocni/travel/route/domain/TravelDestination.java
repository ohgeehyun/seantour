package geocni.travel.route.domain;

import java.util.ArrayList;
import java.util.List;

import geocni.travel.common.TravelDefaultVO;
import geocni.travel.common.files.domain.TravelFiles;

public class TravelDestination extends TravelDefaultVO {

    private static final long serialVersionUID = 1L;

    private String destId;

    private String destTitle;
    
    private String destAdSlogan;
    
    private String destRegion;
    
    private String destCategory;
    
    private String destTag;
    
    private String destWebsiteUrl;
    
    private String destImgPath;
    
    private String destPhone;
    
    private String destAddress;
    
    private String destAxisX;
    
    private String destAxisY;

    private String destFeature;
    
    private String destInformation;
    
    private String destDescription;
    
    private int destRecommPoint = 0;
    
    private int destClipPoint = 0;
    
    private String destWriter;
    
    private String destRegDatetime;
    
    private int destHit = 0;
    
    private String destSeason;

    private int myRecommCount = 0;
    
    private int myClipCount = 0;

    private int distance = 10000;
    
    private String destUserId;

    private List<String> destTagList;
    
    private List<TravelFiles> travelFileList;
    
	public String getDestId() {
		return destId;
	}

	public void setDestId(String destId) {
		this.destId = destId;
	}

	public String getDestTitle() {
		return destTitle;
	}

	public void setDestTitle(String destTitle) {
		this.destTitle = destTitle;
	}

	public String getDestAdSlogan() {
		return destAdSlogan;
	}

	public void setDestAdSlogan(String destAdSlogan) {
		this.destAdSlogan = destAdSlogan;
	}

	public String getDestRegion() {
		return destRegion;
	}

	public void setDestRegion(String destRegion) {
		this.destRegion = destRegion;
	}

	public String getDestCategory() {
		return destCategory;
	}

	public void setDestCategory(String destCategory) {
		this.destCategory = destCategory;
	}

	public String getDestTag() {
		return destTag;
	}

	public void setDestTag(String destTag) {
		this.destTag = destTag;
	}

	public String getDestWebsiteUrl() {
		return destWebsiteUrl;
	}

	public void setDestWebsiteUrl(String destWebsiteUrl) {
		this.destWebsiteUrl = destWebsiteUrl;
	}

	public String getDestImgPath() {
		return destImgPath;
	}

	public void setDestImgPath(String destImgPath) {
		this.destImgPath = destImgPath;
	}

	public String getDestPhone() {
		return destPhone;
	}

	public void setDestPhone(String destPhone) {
		this.destPhone = destPhone;
	}

	public String getDestAddress() {
		return destAddress;
	}

	public void setDestAddress(String destAddress) {
		this.destAddress = destAddress;
	}

	public String getDestAxisX() {
		return destAxisX;
	}

	public void setDestAxisX(String destAxisX) {
		this.destAxisX = destAxisX;
	}

	public String getDestAxisY() {
		return destAxisY;
	}

	public void setDestAxisY(String destAxisY) {
		this.destAxisY = destAxisY;
	}

	public String getDestFeature() {
		return destFeature;
	}

	public void setDestFeature(String destFeature) {
		this.destFeature = destFeature;
	}

	public String getDestInformation() {
		return destInformation;
	}

	public void setDestInformation(String destInformation) {
		this.destInformation = destInformation;
	}

	public String getDestDescription() {
		return destDescription;
	}

	public void setDestDescription(String destDescription) {
		this.destDescription = destDescription;
	}

	public int getDestRecommPoint() {
		return destRecommPoint;
	}

	public void setDestRecommPoint(int destRecommPoint) {
		this.destRecommPoint = destRecommPoint;
	}

	public int getDestClipPoint() {
		return destClipPoint;
	}

	public void setDestClipPoint(int destClipPoint) {
		this.destClipPoint = destClipPoint;
	}

	public String getDestWriter() {
		return destWriter;
	}

	public void setDestWriter(String destWriter) {
		this.destWriter = destWriter;
	}

	public String getDestRegDatetime() {
		return destRegDatetime;
	}

	public void setDestRegDatetime(String destRegDatetime) {
		this.destRegDatetime = destRegDatetime;
	}

	public int getDestHit() {
		return destHit;
	}

	public void setDestHit(int destHit) {
		this.destHit = destHit;
	}

	public String getDestSeason() {
		return destSeason;
	}

	public void setDestSeason(String destSeason) {
		this.destSeason = destSeason;
	}

	public int getMyRecommCount() {
		return myRecommCount;
	}

	public void setMyRecommCount(int myRecommCount) {
		this.myRecommCount = myRecommCount;
	}

	public int getMyClipCount() {
		return myClipCount;
	}

	public void setMyClipCount(int myClipCount) {
		this.myClipCount = myClipCount;
	}

	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	public String getDestUserId() {
		return destUserId;
	}

	public void setDestUserId(String destUserId) {
		this.destUserId = destUserId;
	}

	public List<String> getDestTagList() {
		return destTagList;
	}

	public void setDestTagList(String destTagList) {
		String[] aplIdxArr = destTagList.split(",");
		
		List<String> list = new ArrayList<String>();
		for(int i=0;aplIdxArr.length > i ;i++){
			list.add(aplIdxArr[i]);
		}
		
		this.destTagList = list;
	}

	public List<TravelFiles> getTravelFileList() {
		return travelFileList;
	}

	public void setTravelFileList(List<TravelFiles> travelFileList) {
		this.travelFileList = travelFileList;
	}

}
