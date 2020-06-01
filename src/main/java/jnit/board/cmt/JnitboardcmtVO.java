/**
 * @version 3.2.0.1
 */
package jnit.board.cmt;

/**
 * @Class Name : JnitboardcmtVO.java
 * @Description : Jnitboardcmt VO class
 * @Modification Information
 *
 * @author JNITBOARDCMT
 * @since 2013.07.11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitboardcmtVO extends JnitboardcmtDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** CMT_ID */
    private java.lang.String cmtId;
    
    /** BOARD_ID */
    private java.lang.String boardId;
    
    /** BOARD_CNT_ID */
    private int boardCntId;
    
    /** CMT_TEXT */
    private java.lang.String cmtText;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private byte isdel;
    
    /** updateConditon */
    private java.lang.String updateCondition = "0";
    
    /** isdelYn */
    private java.lang.String isdelYn = "Y";
    
    
    /**
	 * @return the isdelYn
	 */
	public java.lang.String getIsdelYn() {
		return isdelYn;
	}

	/**
	 * @param isdelYn the isdelYn to set
	 */
	public void setIsdelYn(java.lang.String isdelYn) {
		this.isdelYn = isdelYn;
	}

	/**
	 * @return the updateCondition
	 */
	public java.lang.String getUpdateCondition() {
		return updateCondition;
	}

	/**
	 * @param updateCondition the updateCondition to set
	 */
	public void setUpdateCondition(java.lang.String updateCondition) {
		this.updateCondition = updateCondition;
	}

	public java.lang.String getCmtId() {
        return this.cmtId;
    }
    
    public void setCmtId(java.lang.String cmtId) {
        this.cmtId = cmtId;
    }
    
    public java.lang.String getBoardId() {
        return this.boardId;
    }
    
    public void setBoardId(java.lang.String boardId) {
        this.boardId = boardId;
    }
    
    public int getBoardCntId() {
        return this.boardCntId;
    }
    
    public void setBoardCntId(int boardCntId) {
        this.boardCntId = boardCntId;
    }
    
    public java.lang.String getCmtText() {
        return this.cmtText;
    }
    
    public void setCmtText(java.lang.String cmtText) {
        this.cmtText = cmtText;
    }
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.util.Date getCreated() {
        return this.created;
    }
    
    public void setCreated(java.util.Date created) {
        this.created = created;
    }
    
    public byte getIsdel() {
        return this.isdel;
    }
    
    public void setIsdel(byte isdel) {
        this.isdel = isdel;
    }

	public java.util.Date getModicied() {
		return modified;
	}

	public void setModicied(java.util.Date modicied) {
		this.modified = modicied;
	}
    
    
}
