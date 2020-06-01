package geocni.travel.member.domain;

import geocni.travel.common.TravelDefaultVO;

public class TravelClipboard extends TravelDefaultVO {

    private static final long serialVersionUID = 1L;

    private String clipId;

    private String clipTitle;

    private String clipPageId;

    private String clipPageUrl;

    private String clipThumbPath;

    private String clipUserId;
    
    private String clipUserNm;

	public String getClipId() {
		return clipId;
	}

	public void setClipId(String clipId) {
		this.clipId = clipId;
	}

	public String getClipTitle() {
		return clipTitle;
	}

	public void setClipTitle(String clipTitle) {
		this.clipTitle = clipTitle;
	}

	public String getClipPageId() {
		return clipPageId;
	}

	public void setClipPageId(String clipPageId) {
		this.clipPageId = clipPageId;
	}

	public String getClipPageUrl() {
		return clipPageUrl;
	}

	public void setClipPageUrl(String clipPageUrl) {
		this.clipPageUrl = clipPageUrl;
	}

	public String getClipThumbPath() {
		return clipThumbPath;
	}

	public void setClipThumbPath(String clipThumbPath) {
		this.clipThumbPath = clipThumbPath;
	}

	public String getClipUserId() {
		return clipUserId;
	}

	public void setClipUserId(String clipUserId) {
		this.clipUserId = clipUserId;
	}

	public String getClipUserNm() {
		return clipUserNm;
	}

	public void setClipUserNm(String clipUserNm) {
		this.clipUserNm = clipUserNm;
	}

}
