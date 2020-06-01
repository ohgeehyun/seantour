/**
 * @version 3.2.0.1
 */
package jnit.board.file;

/**
 * @Class Name : JnitboardfileVO.java
 * @Description : Jnitboardfile VO class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.01.24
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */
public class JnitboardfileVO extends JnitboardfileDefaultVO{
    private static final long serialVersionUID = 1L;

    /** FILE_ID */
    private java.lang.String fileId;

    /** BOARD_ID */
    private java.lang.String boardId;

    /** BOARD_CNT_ID */
    private int boardCntId;

    /** FILE_URL */
    private java.lang.String fileUrl;

    /** FILE_PATH */
    private java.lang.String filePath;

    /** FILE_NM */
    private java.lang.String fileNm;

    /** FILE_ONM */
    private java.lang.String fileOnm;

    /** ISMAIN */
    private int ismain;

    private long fileSize;

    private String fileCode;

    /** EXT01 */
    private java.lang.String ext01;

    /** EXT02 */
    private java.lang.String ext02;

    /** FILE_DOWNLOAD_COUNT */
    private int fileDownloadCount;

    /** updateCondition */
    private java.lang.String updateCondition = "0";

    /** mainFileYn */
    private java.lang.String mainFileYn = "Y";

    /** boardIdYn */
    private java.lang.String boardIdYn = "N";

    /** boardCntIdYn */
    private java.lang.String boardCntIdYn = "N";

    /** isdelYn */
    private java.lang.String isdelYn = "Y";

    /** deleteCondition */
    private java.lang.String deleteCondition = "0";

    private String url;

    /**
	 * @return the deleteCondition
	 */
	public java.lang.String getDeleteCondition() {
		return deleteCondition;
	}

	/**
	 * @param deleteCondition the deleteCondition to set
	 */
	public void setDeleteCondition(java.lang.String deleteCondition) {
		this.deleteCondition = deleteCondition;
	}

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
	 * @return the boardCntIdYn
	 */
	public java.lang.String getBoardCntIdYn() {
		return boardCntIdYn;
	}

	/**
	 * @param boardCntIdYn the boardCntIdYn to set
	 */
	public void setBoardCntIdYn(java.lang.String boardCntIdYn) {
		this.boardCntIdYn = boardCntIdYn;
	}

	/**
	 * @return the boardIdYn
	 */
	public java.lang.String getBoardIdYn() {
		return boardIdYn;
	}

	/**
	 * @param boardIdYn the boardIdYn to set
	 */
	public void setBoardIdYn(java.lang.String boardIdYn) {
		this.boardIdYn = boardIdYn;
	}

	/**
	 * @return the mainFileYn
	 */
	public java.lang.String getMainFileYn() {
		return mainFileYn;
	}

	/**
	 * @param mainFileYn the mainFileYn to set
	 */
	public void setMainFileYn(java.lang.String mainFileYn) {
		this.mainFileYn = mainFileYn;
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

	/**
	 * @return the fileDownloadCount
	 */
	public int getFileDownloadCount() {
		return fileDownloadCount;
	}

	/**
	 * @param fileDownloadCount the fileDownloadCount to set
	 */
	public void setFileDownloadCount(int fileDownloadCount) {
		this.fileDownloadCount = fileDownloadCount;
	}

	/** ISDEL */
    private int isdel;

    public java.lang.String getFileId() {
        return this.fileId;
    }

    public void setFileId(java.lang.String fileId) {
        this.fileId = fileId;
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

    public java.lang.String getFileUrl() {
        return this.fileUrl;
    }

    public void setFileUrl(java.lang.String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public java.lang.String getFilePath() {
        return this.filePath;
    }

    public void setFilePath(java.lang.String filePath) {
        this.filePath = filePath;
    }

    public java.lang.String getFileNm() {
        return this.fileNm;
    }

    public void setFileNm(java.lang.String fileNm) {
        this.fileNm = fileNm;
    }

    public java.lang.String getFileOnm() {
        return this.fileOnm;
    }

    public void setFileOnm(java.lang.String fileOnm) {
        this.fileOnm = fileOnm;
    }

    public int getIsmain() {
        return this.ismain;
    }

    public void setIsmain(int ismain) {
        this.ismain = ismain;
    }

    public java.lang.String getExt01() {
		return ext01;
	}

	public void setExt01(java.lang.String ext01) {
		this.ext01 = ext01;
	}

	public java.lang.String getExt02() {
		return ext02;
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

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileCode() {
		return fileCode;
	}

	public void setFileCode(String fileCode) {
		this.fileCode = fileCode;
	}




}
