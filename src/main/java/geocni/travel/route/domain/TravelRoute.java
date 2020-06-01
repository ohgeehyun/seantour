package geocni.travel.route.domain;

import java.util.List;

import geocni.travel.common.TravelDefaultVO;

public class TravelRoute extends TravelDefaultVO {

    private static final long serialVersionUID = 1L;

	private String routId;

	private String routGroup;
	
	private String routTitle;
    
	private String routRegMember;
    
	private String routDays;
    
	private String routRegion;
    
	private String routStartPoint;
    
	private String routDestPoint;
    
	private String routDescription;
    
	private String routStartAxis;
	
	private String routDestAxis;

	private int routRecomm;
	
	private int routHit;
	
	private String routType;
	
	private String routOpen;
	
	private String routRegDate;
	
	private List<TravelDestination> routePointList;
	
	private String routImgPath;
	
	private String routRegMemberNm;
	
	private boolean adminMode;

    public String getRoutId() {
		return routId;
	}
	public void setRoutId(String routId) {
		this.routId = routId;
	}
	public String getRoutGroup() {
		return routGroup;
	}
	public void setRoutGroup(String routGroup) {
		this.routGroup = routGroup;
	}
	public String getRoutTitle() {
		return routTitle;
	}
	public void setRoutTitle(String routTitle) {
		this.routTitle = routTitle;
	}
	public String getRoutRegMember() {
		return routRegMember;
	}
	public void setRoutRegMember(String routRegMember) {
		this.routRegMember = routRegMember;
	}
	public String getRoutDays() {
		return routDays;
	}
	public void setRoutDays(String routDays) {
		this.routDays = routDays;
	}
	public String getRoutRegion() {
		return routRegion;
	}
	public void setRoutRegion(String routRegion) {
		this.routRegion = routRegion;
	}
	public String getRoutStartPoint() {
		return routStartPoint;
	}
	public void setRoutStartPoint(String routStartPoint) {
		this.routStartPoint = routStartPoint;
	}
	public String getRoutDestPoint() {
		return routDestPoint;
	}
	public void setRoutDestPoint(String routDestPoint) {
		this.routDestPoint = routDestPoint;
	}
	public String getRoutDescription() {
		return routDescription;
	}
	public void setRoutDescription(String routDescription) {
		this.routDescription = routDescription;
	}
	public String getRoutStartAxis() {
		return routStartAxis;
	}
	public void setRoutStartAxis(String routStartAxis) {
		this.routStartAxis = routStartAxis;
	}
	public String getRoutDestAxis() {
		return routDestAxis;
	}
	public void setRoutDestAxis(String routDestAxis) {
		this.routDestAxis = routDestAxis;
	}
	public String getRoutRegDate() {
		return routRegDate;
	}
	public void setRoutRegDate(String routRegDate) {
		this.routRegDate = routRegDate;
	}
	public int getRoutRecomm() {
		return routRecomm;
	}
	public void setRoutRecomm(int routRecomm) {
		this.routRecomm = routRecomm;
	}
	public int getRoutHit() {
		return routHit;
	}
	public void setRoutHit(int routHit) {
		this.routHit = routHit;
	}
	public String getRoutType() {
		return routType;
	}
	public void setRoutType(String routType) {
		this.routType = routType;
	}
	public String getRoutOpen() {
		return routOpen;
	}
	public void setRoutOpen(String routOpen) {
		this.routOpen = routOpen;
	}
	public List<TravelDestination> getRoutePointList() {
		return routePointList;
	}
	public void setRoutePointList(List<TravelDestination> routePointList) {
		this.routePointList = routePointList;
	}
	public String getRoutImgPath() {
		return routImgPath;
	}
	public void setRoutImgPath(String routImgPath) {
		this.routImgPath = routImgPath;
	}
	public String getRoutRegMemberNm() {
		return routRegMemberNm;
	}
	public void setRoutRegMemberNm(String routRegMemberNm) {
		this.routRegMemberNm = routRegMemberNm;
	}
	public boolean isAdminMode() {
		return adminMode;
	}
	public void setAdminMode(boolean adminMode) {
		this.adminMode = adminMode;
	}
}
