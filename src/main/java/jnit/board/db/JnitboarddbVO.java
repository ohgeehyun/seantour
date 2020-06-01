/**
 * @version 3.2.0.1
 */
package jnit.board.db;

/**
 * @Class Name : JnitboardtplVO.java
 * @Description : Jnitboardtpl VO class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2013.01.22
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitboarddbVO extends JnitboarddbDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** ID */
    private int id;
    
    /** GRP */
    private int grp;
    
    /** IDX */
    private java.lang.String idx;
    
    /** IS_SECRET */
    private int isSecret;
    
    /** IS_NOTICE */
    private int isNotice;
    
    /** IS_HTML */
    private int isHtml;
    
    /** CATEGORY */
    private java.lang.String category;
    
    /** TITLE */
    private java.lang.String title;
    
    /** CONTENT */
    private java.lang.String content;
    
    /* PASSWORD*/
    private java.lang.String password;

	/** EXT01 */
    private java.lang.String ext01;
    
    /** EXT02 */
    private java.lang.String ext02;
    
    /** EXT03 */
    private java.lang.String ext03;
    
    /** EXT04 */
    private java.lang.String ext04;
    
    /** EXT05 */
    private java.lang.String ext05;
    
    /** EXT06 */
    private java.lang.String ext06;
    
    /** EXT07 */
    private java.lang.String ext07;
    
    /** EXT08 */
    private java.lang.String ext08;
    
    /** EXT09 */
    private java.lang.String ext09;
    
    /** EXT10 */
    private java.lang.String ext10;
    
    /** EXT11 */
    private java.lang.String ext11;
    
    /** EXT12 */
    private java.lang.String ext12;
    
    /** EXT13 */
    private java.lang.String ext13;
    
    /** EXT14 */
    private java.lang.String ext14;
    
    /** EXT15 */
    private java.lang.String ext15;
    
    /** EXT16 */
    private java.lang.String ext16;
    
    /** EXT17 */
    private java.lang.String ext17;
    
    /** EXT18 */
    private java.lang.String ext18;
    
    /** EXT19 */
    private java.lang.String ext19;
    
    /** EXT20 */
    private java.lang.String ext20;
    
    /** DATE01 */
    private java.util.Date date01;
    
    /** DATE02 */
    private java.util.Date date02;
    
    /** HIT */
    private int hit;
    
    /** WRITER */
    private java.lang.String writer;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** MBR_IP */
    private java.lang.String mbrIp;
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ACTIVE */
    private int active;
    
    /** ISDEL */
    private int isdel;
    
    /** TMP1 */
    private java.lang.String tmp1;
    
    /** TMP2 */
    private java.lang.String tmp2;
    
    /** TMP3 */
    private int tmp3;
    
    /** TMP4 */
    private java.lang.String tmp4;
    
    /** TMP5 */
    private java.lang.String tmp5;
    
    /** isdelYn */
    private java.lang.String isdelYn = "Y";
    
    /** selectCondition */ 
    private java.lang.String selectCondition = "0";
    
    /** updateConditon */
    private java.lang.String updateCondition = "0";
    
    /** deleteCondition */
    private java.lang.String deleteCondition = "0";
    
    /** recoveryCondition */
    private java.lang.String recoveryCondition = "0";

	/**
	 * @return the recoveryCondition
	 */
	public java.lang.String getRecoveryCondition() {
		return recoveryCondition;
	}

	/**
	 * @param recoveryCondition the recoveryCondition to set
	 */
	public void setRecoveryCondition(java.lang.String recoveryCondition) {
		this.recoveryCondition = recoveryCondition;
	}

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
	 * @return the tmp3
	 */
	public int getTmp3() {
		return tmp3;
	}

	/**
	 * @param tmp3 the tmp3 to set
	 */
	public void setTmp3(int tmp3) {
		this.tmp3 = tmp3;
	}

	/**
	 * @return the selectCondition
	 */
	public java.lang.String getSelectCondition() {
		return selectCondition;
	}

	/**
	 * @param selectCondition the selectCondition to set
	 */
	public void setSelectCondition(java.lang.String selectCondition) {
		this.selectCondition = selectCondition;
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
	 * @return the tmp1
	 */
	public java.lang.String getTmp1() {
		return tmp1;
	}

	/**
	 * @param tmp1 the tmp1 to set
	 */
	public void setTmp1(java.lang.String tmp1) {
		this.tmp1 = tmp1;
	}

	/**
	 * @return the tmp2
	 */
	public java.lang.String getTmp2() {
		return tmp2;
	}

	/**
	 * @param tmp2 the tmp2 to set
	 */
	public void setTmp2(java.lang.String tmp2) {
		this.tmp2 = tmp2;
	}

	/**
	 * @return the tmp4
	 */
	public java.lang.String getTmp4() {
		return tmp4;
	}

	/**
	 * @param tmp4 the tmp4 to set
	 */
	public void setTmp4(java.lang.String tmp4) {
		this.tmp4 = tmp4;
	}

	/**
	 * @return the tmp5
	 */
	public java.lang.String getTmp5() {
		return tmp5;
	}

	/**
	 * @param tmp5 the tmp5 to set
	 */
	public void setTmp5(java.lang.String tmp5) {
		this.tmp5 = tmp5;
	}

	public int getId() {
        return this.id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getGrp() {
        return this.grp;
    }
    
    public void setGrp(int grp) {
        this.grp = grp;
    }
    
    public java.lang.String getIdx() {
        return this.idx;
    }
    
    public void setIdx(java.lang.String idx) {
        this.idx = idx;
    }
    
    public int getIsSecret() {
        return this.isSecret;
    }
    
    public void setIsSecret(int isSecret) {
        this.isSecret = isSecret;
    }
    
    public int getIsNotice() {
        return this.isNotice;
    }
    
    public void setIsNotice(int isNotice) {
        this.isNotice = isNotice;
    }
    
    public int getIsHtml() {
        return this.isHtml;
    }
    
    public void setIsHtml(int isHtml) {
        this.isHtml = isHtml;
    }
    
    public java.lang.String getCategory() {
        return this.category;
    }
    
    public void setCategory(java.lang.String category) {
        this.category = category;
    }
    
    public java.lang.String getTitle() {
        return this.title;
    }
    
    public void setTitle(java.lang.String title) {
        this.title = title;
    }
    
    public java.lang.String getContent() {
        return this.content;
    }
    
    public void setContent(java.lang.String content) {
        this.content = content;
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
    
    public java.lang.String getExt03() {
        return this.ext03;
    }
    
    public void setExt03(java.lang.String ext03) {
        this.ext03 = ext03;
    }
    
    public java.lang.String getExt04() {
        return this.ext04;
    }
    
    public void setExt04(java.lang.String ext04) {
        this.ext04 = ext04;
    }
    
    public java.lang.String getExt05() {
        return this.ext05;
    }
    
    public void setExt05(java.lang.String ext05) {
        this.ext05 = ext05;
    }
    
    public java.lang.String getExt06() {
        return this.ext06;
    }
    
    public void setExt06(java.lang.String ext06) {
        this.ext06 = ext06;
    }
    
    public java.lang.String getExt07() {
        return this.ext07;
    }
    
    public void setExt07(java.lang.String ext07) {
        this.ext07 = ext07;
    }
    
    public java.lang.String getExt08() {
        return this.ext08;
    }
    
    public void setExt08(java.lang.String ext08) {
        this.ext08 = ext08;
    }
    
    public java.lang.String getExt09() {
		return ext09;
	}

	public void setExt09(java.lang.String ext09) {
		this.ext09 = ext09;
	}

	public java.lang.String getExt10() {
		return ext10;
	}

	public void setExt10(java.lang.String ext10) {
		this.ext10 = ext10;
	}

	public java.lang.String getExt11() {
		return ext11;
	}

	public void setExt11(java.lang.String ext11) {
		this.ext11 = ext11;
	}

	public java.lang.String getExt12() {
		return ext12;
	}

	public void setExt12(java.lang.String ext12) {
		this.ext12 = ext12;
	}

	public java.lang.String getExt13() {
		return ext13;
	}

	public void setExt13(java.lang.String ext13) {
		this.ext13 = ext13;
	}

	public java.lang.String getExt14() {
		return ext14;
	}

	public void setExt14(java.lang.String ext14) {
		this.ext14 = ext14;
	}

	public java.lang.String getExt15() {
		return ext15;
	}

	public void setExt15(java.lang.String ext15) {
		this.ext15 = ext15;
	}

	public java.lang.String getExt16() {
		return ext16;
	}

	public void setExt16(java.lang.String ext16) {
		this.ext16 = ext16;
	}

	public java.lang.String getExt17() {
		return ext17;
	}

	public void setExt17(java.lang.String ext17) {
		this.ext17 = ext17;
	}

	public java.lang.String getExt18() {
		return ext18;
	}

	public void setExt18(java.lang.String ext18) {
		this.ext18 = ext18;
	}

	public java.lang.String getExt19() {
		return ext19;
	}

	public void setExt19(java.lang.String ext19) {
		this.ext19 = ext19;
	}

	public java.lang.String getExt20() {
		return ext20;
	}

	public void setExt20(java.lang.String ext20) {
		this.ext20 = ext20;
	}

	public java.util.Date getDate01() {
        return this.date01;
    }
    
    public void setDate01(java.util.Date date01) {
        this.date01 = date01;
    }
    
    public java.util.Date getDate02() {
        return this.date02;
    }
    
    public void setDate02(java.util.Date date02) {
        this.date02 = date02;
    }
    
    public int getHit() {
        return this.hit;
    }
    
    public void setHit(int hit) {
        this.hit = hit;
    }
    
    public java.lang.String getWriter() {
        return this.writer;
    }
    
    public void setWriter(java.lang.String writer) {
        this.writer = writer;
    }
    
    public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.lang.String getMbrIp() {
        return this.mbrIp;
    }
    
    public void setMbrIp(java.lang.String mbrIp) {
        this.mbrIp = mbrIp;
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
    
    public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public int getIsdel() {
        return this.isdel;
    }
    
    public void setIsdel(int isdel) {
        this.isdel = isdel;
    }
    public java.lang.String getPassword() {
		return password;
	}

	public void setPassword(java.lang.String password) {
		this.password = password;
	}
}
