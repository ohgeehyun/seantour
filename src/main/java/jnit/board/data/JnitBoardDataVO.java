package jnit.board.data;

import jnit.com.vo.JnitDefaultVO;

/**
 * @Class Name : JnitBoardDataVO.java
 * @Description : VO
 * @Modification Information
 *
 * @author
 * @since 2016. 12.22
 * @version 1.0
 * @see Copyright (C) by 김문기 All right reserved.
 */
public class JnitBoardDataVO extends JnitDefaultVO {

	private String dataId;
	private String dataNm;
	private String dataBoardIds;
	private String dataCategory;
	private int dataOrder = 0;
	private int dataLimit = 5;
	//분기
	private String saMode;

	public String getDataId() {
		return dataId;
	}

	public void setDataId(String dataId) {
		this.dataId = dataId;
	}

	public String getDataNm() {
		return dataNm;
	}

	public void setDataNm(String dataNm) {
		this.dataNm = dataNm;
	}

	public String getSaMode() {
		return saMode;
	}

	public void setSaMode(String saMode) {
		this.saMode = saMode;
	}

	public String getDataBoardIds() {
		return dataBoardIds;
	}

	public void setDataBoardIds(String dataBoardIds) {
		this.dataBoardIds = dataBoardIds;
	}

	public int getDataOrder() {
		return dataOrder;
	}

	public void setDataOrder(int dataOrder) {
		this.dataOrder = dataOrder;
	}

	public int getDataLimit() {
		return dataLimit;
	}

	public void setDataLimit(int dataLimit) {
		this.dataLimit = dataLimit;
	}

	public String getDataCategory() {
		return dataCategory;
	}

	public void setDataCategory(String dataCategory) {
		this.dataCategory = dataCategory;
	}



}