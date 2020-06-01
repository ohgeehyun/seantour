package geocni.travel.common.files.domain;

import geocni.travel.common.TravelDefaultVO;

public class TravelFiles extends TravelDefaultVO {

    private static final long serialVersionUID = 1L;

    /*외부참조 ID*/
    private String imgRefId;

    /*이미지 시리얼 넘버*/
    private int imgFileNo;

    /*이미지 파일 원본 이름*/
    private String imgFileName;

    /*이미지 파일 저장 경로*/
    private String imgFilePath;

    /*이미지 파일 용량*/
    private long imgFileSize;

    /*이미지 파일 확장자*/
    private String imgFileExt;

    /*이미지 파일 생성일시*/
    private String imgCreatedAt;

	public String getImgRefId() {
		return imgRefId;
	}

	public void setImgRefId(String imgRefId) {
		this.imgRefId = imgRefId;
	}

	public int getImgFileNo() {
		return imgFileNo;
	}

	public void setImgFileNo(int imgFileNo) {
		this.imgFileNo = imgFileNo;
	}

	public String getImgFileName() {
		return imgFileName;
	}

	public void setImgFileName(String imgFileName) {
		this.imgFileName = imgFileName;
	}

	public String getImgFilePath() {
		return imgFilePath;
	}

	public void setImgFilePath(String imgFilePath) {
		this.imgFilePath = imgFilePath;
	}

	public long getImgFileSize() {
		return imgFileSize;
	}

	public void setImgFileSize(long imgFileSize) {
		this.imgFileSize = imgFileSize;
	}

	public String getImgFileExt() {
		return imgFileExt;
	}

	public void setImgFileExt(String imgFileExt) {
		this.imgFileExt = imgFileExt;
	}

	public String getImgCreatedAt() {
		return imgCreatedAt;
	}

	public void setImgCreatedAt(String imgCreatedAt) {
		this.imgCreatedAt = imgCreatedAt;
	}

}
