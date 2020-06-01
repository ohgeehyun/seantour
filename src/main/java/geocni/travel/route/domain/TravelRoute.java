package geocni.travel.route.domain;

import java.util.List;

import geocni.travel.common.TravelDefaultVO;

public class TravelRoute extends TravelDefaultVO {

    private static final long serialVersionUID = 1L;

    /*일정 I*/
    private String routId;

    /*일정 제목*/
    private String routTitle;

    /*일정 생성자*/
    private String routRegMember;

    /*일정 지역*/
    private String routRegion;

    /*일정 썸네일*/
    private String routThumbPath;

    /*일정 메모*/
    private String routMemo;
    
    /*추천수*/
    private int routRecomm;

    /*조회수*/
    private int routHit;

    /*일정 타입(''U''-사용자, ''W''-작가)*/
    private String routType;

    /*공개 여부("Y"-공개, "N"-비공개)*/
    private String routOpen;

    /*일정 생성일*/
    private String routRegDate;

    private List<TravelRouteDaily> routeDailyList;

	private String routRegMemberNm;
	
	private boolean adminMode;

    public String getRoutId() {
		return routId;
	}

	public void setRoutId(String routId) {
		this.routId = routId;
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

	public String getRoutRegion() {
		return routRegion;
	}

	public void setRoutRegion(String routRegion) {
		this.routRegion = routRegion;
	}

	public String getRoutThumbPath() {
		return routThumbPath;
	}

	public void setRoutThumbPath(String routThumbPath) {
		this.routThumbPath = routThumbPath;
	}

	public String getRoutMemo() {
		return routMemo;
	}

	public void setRoutMemo(String routMemo) {
		this.routMemo = routMemo;
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

	public String getRoutRegDate() {
		return routRegDate;
	}

	public void setRoutRegDate(String routRegDate) {
		this.routRegDate = routRegDate;
	}

	public List<TravelRouteDaily> getRouteDailyList() {
		return routeDailyList;
	}

	public void setRouteDailyList(List<TravelRouteDaily> routeDailyList) {
		this.routeDailyList = routeDailyList;
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
