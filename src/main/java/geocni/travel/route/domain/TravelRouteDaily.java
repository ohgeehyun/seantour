package geocni.travel.route.domain;

import java.util.List;

import geocni.travel.common.TravelDefaultVO;

public class TravelRouteDaily extends TravelDefaultVO {

    private static final long serialVersionUID = 1L;

    /*일정 ID*/
    private String routId;

    /*일차*/
    private int routDays = 1;

    /*출발지*/
    private String routStartPoint;

    /*출발지 좌표*/
    private String routStartAxis;

    /*도착지*/
    private String routDestPoint;

    /*도착지 좌표*/
    private String routDestAxis;

    /*여행 일정 및 경로*/
    private String routWayPoint;

    private List<TravelDestination> wayPointList;

	public String getRoutId() {
		return routId;
	}

	public void setRoutId(String routId) {
		this.routId = routId;
	}

	public int getRoutDays() {
		return routDays;
	}

	public void setRoutDays(int routDays) {
		this.routDays = routDays;
	}

	public String getRoutStartPoint() {
		return routStartPoint;
	}

	public void setRoutStartPoint(String routStartPoint) {
		this.routStartPoint = routStartPoint;
	}

	public String getRoutStartAxis() {
		return routStartAxis;
	}

	public void setRoutStartAxis(String routStartAxis) {
		this.routStartAxis = routStartAxis;
	}

	public String getRoutDestPoint() {
		return routDestPoint;
	}

	public void setRoutDestPoint(String routDestPoint) {
		this.routDestPoint = routDestPoint;
	}

	public String getRoutDestAxis() {
		return routDestAxis;
	}

	public void setRoutDestAxis(String routDestAxis) {
		this.routDestAxis = routDestAxis;
	}

	public String getRoutWayPoint() {
		return routWayPoint;
	}

	public void setRoutWayPoint(String routWayPoint) {
		this.routWayPoint = routWayPoint;
	}

	public List<TravelDestination> getWayPointList() {
		return wayPointList;
	}

	public void setWayPointList(List<TravelDestination> wayPointList) {
		this.wayPointList = wayPointList;
	}

}
