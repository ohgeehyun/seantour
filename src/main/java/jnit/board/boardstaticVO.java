/**
 * @version 3.2.0.1
 */
package jnit.board;

import jnit.board.db.JnitboarddbVO;
import jnit.board.info.JnitboardinfoVO;

public class boardstaticVO {
	//추가확장
	public static Boolean isAdmin;
	public static Boolean PermList;
	public static Boolean permView;
	public static Boolean permWrite;
	public static Boolean permReply;
	public static Boolean permCmt;
	public static Boolean isMobile;
	
	public static JnitboardinfoVO jnitboardinfoVO = new JnitboardinfoVO();
	public static JnitboarddbVO jnitboarddbVO = new JnitboarddbVO();
	
	/**
	 * @return the isMobile
	 */
	public static Boolean getIsMobile() {
		return isMobile;
	}
	/**
	 * @param isMobile the isMobile to set
	 */
	public static void setIsMobile(Boolean isMobile) {
		boardstaticVO.isMobile = isMobile;
	}
	/**
	 * @return the jnitboarddbVO
	 */
	public static JnitboarddbVO getJnitboarddbVO() {
		return jnitboarddbVO;
	}
	/**
	 * @param jnitboarddbVO the jnitboarddbVO to set
	 */
	public static void setJnitboarddbVO(JnitboarddbVO jnitboarddbVO) {
		boardstaticVO.jnitboarddbVO = jnitboarddbVO;
	}
	/**
	 * @return the jnitboardinfoVO
	 */
	public static JnitboardinfoVO getJnitboardinfoVO() {
		return jnitboardinfoVO;
	}
	/**
	 * @param jnitboardinfoVO the jnitboardinfoVO to set
	 */
	public static void setJnitboardinfoVO(JnitboardinfoVO jnitboardinfoVO) {
		boardstaticVO.jnitboardinfoVO = jnitboardinfoVO;
	}
	/**
	 * @return the isAdmin
	 */
	public static Boolean getIsAdmin() {
		return isAdmin;
	}
	/**
	 * @return the permList
	 */
	public static Boolean getPermList() {
		return PermList;
	}
	/**
	 * @return the permView
	 */
	public static Boolean getPermView() {
		return permView;
	}
	/**
	 * @return the permWrite
	 */
	public static Boolean getPermWrite() {
		return permWrite;
	}
	/**
	 * @return the permReply
	 */
	public static Boolean getPermReply() {
		return permReply;
	}
	/**
	 * @return the permCmt
	 */
	public static Boolean getPermCmt() {
		return permCmt;
	}
	/**
	 * @param isAdmin the isAdmin to set
	 */
	public static void setIsAdmin(Boolean isAdmin) {
		boardstaticVO.isAdmin = isAdmin;
	}
	/**
	 * @param permList the permList to set
	 */
	public static void setPermList(Boolean permList) {
		PermList = permList;
	}
	/**
	 * @param permView the permView to set
	 */
	public static void setPermView(Boolean permView) {
		boardstaticVO.permView = permView;
	}
	/**
	 * @param permWrite the permWrite to set
	 */
	public static void setPermWrite(Boolean permWrite) {
		boardstaticVO.permWrite = permWrite;
	}
	/**
	 * @param permReply the permReply to set
	 */
	public static void setPermReply(Boolean permReply) {
		boardstaticVO.permReply = permReply;
	}
	/**
	 * @param permCmt the permCmt to set
	 */
	public static void setPermCmt(Boolean permCmt) {
		boardstaticVO.permCmt = permCmt;
	}
	
	
}
