/**
 * @version 3.2.0.1
 */
package jnit.board.db;

public class JnitboarddbManageVO extends JnitboarddbVO {
    private static final long serialVersionUID = 1L;
    
    /** 대상 게시판 아이디 */
    String targetBoardId = "";

	public String getTargetBoardId() {
		return targetBoardId;
	}

	public void setTargetBoardId(String targetBoardId) {
		this.targetBoardId = targetBoardId;
	}
}
