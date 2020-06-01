package jnit.filego.enums;


public enum JnitFilegoFileType {

	CONTENT("CONTENT", 0, true),
	UPLOAD("UPLOAD", 1, true),
	CONFIG("CONFIG", 2, true),
	BOARD("BOARD", 3, true),
	CRON("CRON", 4, false);
	
	private String fileTypeName;		//파일명
	private int fileType;				//파일유형
	private boolean isSend;				//전송여부
	
	JnitFilegoFileType(String fileTypeName, int fileType, boolean isSend){
		this.fileTypeName = fileTypeName;
		this.fileType = fileType;
		this.isSend = isSend;
	}
	
	/**
	 * 파일유형명 가져오기
	 */
	public String getFileTypeName(){
		return this.fileTypeName;
	}
	
	/**
	 * 파일유형 가져오기
	 */
	public int getFileType(){
		return this.fileType;
	}
	
	/**
	 * 전송여부 가져오기
	 */
	public boolean getIsSend(){
		return this.isSend;
	}
}