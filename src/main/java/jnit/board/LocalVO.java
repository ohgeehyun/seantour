/**
 * @version 3.2.0.1
 */
package jnit.board;

import java.io.Serializable;

import jnit.board.info.JnitboardinfoVO;
import jnit.cms.mbr.JnitcmsmbrVO;

/**
 * @Class Name : JnitboardtplDefaultVO.java
 * @Description : Jnitboardtpl Default VO class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2013.01.22
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class LocalVO implements Serializable {
	
	private  JnitboardinfoVO boardinfoVO = new JnitboardinfoVO();
	private JnitcmsmbrVO loginVO = new JnitcmsmbrVO();
	
	private boolean permList = false;
	private boolean permView = false;
	private boolean permWrite = false;
	private boolean permReply = false;
	private boolean permCmt = false;	
	private boolean isAdmin = false;
	private boolean permFileDown = true;	
	
	public Boolean getPermFileDown() {
		return permFileDown;
	}
	public void setPermFileDown(Boolean permFileDown) {
		this.permFileDown = permFileDown;
	}
	public JnitboardinfoVO getBoardinfoVO() {
		return boardinfoVO;
	}
	public void setBoardinfoVO(JnitboardinfoVO boardinfoVO) {
		this.boardinfoVO = boardinfoVO;
	}
	public JnitcmsmbrVO getLoginVO() {
		return loginVO;
	}
	public void setLoginVO(JnitcmsmbrVO loginVO) {
		this.loginVO = loginVO;
	}
	public boolean getPermList() {
		return permList;
	}
	public void setPermList(boolean permList) {
		this.permList = permList;
	}
	public boolean getPermView() {
		return permView;
	}
	public void setPermView(boolean permView) {
		this.permView = permView;
	}
	public boolean getPermWrite() {
		return permWrite;
	}
	public void setPermWrite(boolean permWrite) {
		this.permWrite = permWrite;
	}
	public boolean getPermReply() {
		return permReply;
	}
	public void setPermReply(boolean permReply) {
		this.permReply = permReply;
	}
	public boolean getPermCmt() {
		return permCmt;
	}
	public void setPermCmt(boolean permCmt) {
		this.permCmt = permCmt;
	}
	public boolean getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
    


}
