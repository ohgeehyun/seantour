/**
 * @version 3.2.0.1
 */
package jnit.rsc.page.data;

/**
 * @Class Name : JnitrscpagedataVO.java
 * @Description : Jnitrscpagedata VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitrscpagedataVO extends JnitrscpagedataDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** PDATA_ID */
    private java.lang.String pdataId;
    
    /** RSCP_ID */
    private java.lang.String rscpId;
    
    /** MEMO */
    private java.lang.String memo;
    
    /** HIT1 */
    private int hit1;
    
    /** HIT2 */
    private int hit2;
    
    /** HIT3 */
    private int hit3;
    
    /** HIT4 */
    private int hit4;
    
    /** HIT5 */
    private int hit5;
    
    /** REMOTE_ADDR */
    private java.lang.String remoteAddr;
    
    /** CREATED */
    private java.util.Date created;
    
    /** DATE01 */
    private java.util.Date date01;
    
    /** DATE02 */
    private java.util.Date date02;
    
    /** 페이지 네비 사용여부 */
    private java.lang.String pageYn = "Y";
    
    /**
	 * @return the pageYn
	 */
	public java.lang.String getPageYn() {
		return pageYn;
	}

	/**
	 * @param pageYn the pageYn to set
	 */
	public void setPageYn(java.lang.String pageYn) {
		this.pageYn = pageYn;
	}

	/**
	 * @return the date01
	 */
	public java.util.Date getDate01() {
		return date01;
	}

	/**
	 * @param date01 the date01 to set
	 */
	public void setDate01(java.util.Date date01) {
		this.date01 = date01;
	}

	/**
	 * @return the date02
	 */
	public java.util.Date getDate02() {
		return date02;
	}

	/**
	 * @param date02 the date02 to set
	 */
	public void setDate02(java.util.Date date02) {
		this.date02 = date02;
	}

	public java.lang.String getPdataId() {
        return this.pdataId;
    }
    
    public void setPdataId(java.lang.String pdataId) {
        this.pdataId = pdataId;
    }
    
    public java.lang.String getRscpId() {
        return this.rscpId;
    }
    
    public void setRscpId(java.lang.String rscpId) {
        this.rscpId = rscpId;
    }
    
    public java.lang.String getMemo() {
        return this.memo;
    }
    
    public void setMemo(java.lang.String memo) {
        this.memo = memo;
    }
    
    public int getHit1() {
        return this.hit1;
    }
    
    public void setHit1(int hit1) {
        this.hit1 = hit1;
    }
    
    public int getHit2() {
        return this.hit2;
    }
    
    public void setHit2(int hit2) {
        this.hit2 = hit2;
    }
    
    public int getHit3() {
        return this.hit3;
    }
    
    public void setHit3(int hit3) {
        this.hit3 = hit3;
    }
    
    public int getHit4() {
        return this.hit4;
    }
    
    public void setHit4(int hit4) {
        this.hit4 = hit4;
    }
    
    public int getHit5() {
        return this.hit5;
    }
    
    public void setHit5(int hit5) {
        this.hit5 = hit5;
    }
    
    public java.lang.String getRemoteAddr() {
        return this.remoteAddr;
    }
    
    public void setRemoteAddr(java.lang.String remoteAddr) {
        this.remoteAddr = remoteAddr;
    }
    
    public java.util.Date getCreated() {
        return this.created;
    }
    
    public void setCreated(java.util.Date created) {
        this.created = created;
    }
    
}
