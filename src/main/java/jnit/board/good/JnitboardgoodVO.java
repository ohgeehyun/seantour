/**
 * @version 3.2.0.1
 */
package jnit.board.good;

/**
 * @Class Name : JnitboardgoodVO.java
 * @Description : Jnitboardgood VO class
 * @Modification Information
 *
 * @author JNITBOARADGOOD
 * @since 2013.11.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitboardgoodVO extends JnitboardgoodDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** IDX */
    private java.lang.String idx;
    
    /** BOARD_ID */
    private java.lang.String boardId;
    
    /** BOARD_CNT_ID */
    private int boardCntId;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** IPADDR */
    private java.lang.String ipaddr;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** EXT01 */
    private java.lang.String ext01;
    
    /** EXT02 */
    private java.lang.String ext02;
    
    /** ISDEL */
    private int isdel;
    
    public java.lang.String getIdx() {
        return this.idx;
    }
    
    public void setIdx(java.lang.String idx) {
        this.idx = idx;
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
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.lang.String getIpaddr() {
        return this.ipaddr;
    }
    
    public void setIpaddr(java.lang.String ipaddr) {
        this.ipaddr = ipaddr;
    }
    
    public java.util.Date getCreated() {
        return this.created;
    }
    
    public void setCreated(java.util.Date created) {
        this.created = created;
    }
    
    public java.util.Date getModified() {
        return this.modified;
    }
    
    public void setModified(java.util.Date modified) {
        this.modified = modified;
    }
    
    public java.lang.String getExt01() {
        return this.ext01;
    }
    
    public void setExt01(java.lang.String ext01) {
        this.ext01 = ext01;
    }
    
    public java.lang.String getExt02() {
        return this.ext02;
    }
    
    public void setExt02(java.lang.String ext02) {
        this.ext02 = ext02;
    }
    
    public int getIsdel() {
        return this.isdel;
    }
    
    public void setIsdel(int isdel) {
        this.isdel = isdel;
    }
    
}
