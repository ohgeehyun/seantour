/**
 * @version 3.2.0.1
 */
package jnit.board.info;

/**
 * @Class Name : JnitboardinfoVO.java
 * @Description : Jnitboardinfo VO class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2013.01.21
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitboardinfoVO extends JnitboardinfoDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** BOARD_ID */
    private java.lang.String boardId;
    
    /** BOARD_GROUP */
    private java.lang.String boardGroup;
    
    /** BOARD_TITLE */
    private java.lang.String boardTitle;
    
    /** LATEST_CONFIG */
    private java.lang.String latestConfig;
    
    /** LATEST_VALUE */
    private java.lang.String latestValue;
    
    /** BOARD_TYPE */
    private java.lang.String boardType;
    
    /** BOARD_SKIN */
    private java.lang.String boardSkin;
    
    /** ROW_CNT */
    private int rowCnt;

    /** ROW_CNT */
    private int useReply=1;
    
    /** BOARD_SORT */
    private java.lang.String boardSort;
    
    /** BOARD_LBL */
    private java.lang.String boardLbl;
    
    /** FIELD_SORT_LIST */
    private java.lang.String fieldSortList;
    
    /** FIELD_SORT_VIEW */
    private java.lang.String fieldSortView;
    
    /** FIELD_SORT_WRITE */
    private java.lang.String fieldSortWrite;

    /** USE_INTERNAL */
    private int useInternal; 
    
	/** USE_CMT */
    private int useCmt;
    
    /** USE_LIST_REPLY */
    private int useListReply;
    
    /** USE_VIEW_REPLY */
    private int useViewReply;
    
    /** USE_ACTIVE */
    private int useActive;
    
    /** USE_SECRET */
    private int useSecret;
    
    /** USE_NOTICE */
    private int useNotice;
    
    /** USE_FILTER */
    private int useFilter;
    
    /** FILTER_ACTION */
    private java.lang.String filterAction;
    
    /** USE_WYSWYG */
    private int useWyswyg = 1;
    
    /** USE_FILE */
    private int useFile = 1;
    
    /** USE_IMAGE */
    private int useImage = 1;
    
    /** USE_MOVIE */
    private int useMovie;
    
    /** USE_SMS */
    private int useSms;
    
    /** SMS_NUM */
    private java.lang.String smsNum;
    
    /** USE_CATEGORY */
    private int useCategory;
    
    /** CATEGORY */
    private java.lang.String category;
    
    /** USE_EXT01 */
    private int useExt01;
    
    /** EXT01_OPT */
    private java.lang.String ext01Opt;
    
    /** EXT01_LBL */
    private java.lang.String ext01Lbl;
    
    /** USE_EXT02 */
    private int useExt02;
    
    /** EXT02_OPT */
    private java.lang.String ext02Opt;
    
    /** EXT02_LBL */
    private java.lang.String ext02Lbl;
    
    /** USE_EXT03 */
    private int useExt03;
    
    /** EXT03_OPT */
    private java.lang.String ext03Opt;
    
    /** EXT03_LBL */
    private java.lang.String ext03Lbl;
    
    /** USE_EXT04 */
    private int useExt04;
    
    /** EXT04_OPT */
    private java.lang.String ext04Opt;
    
    /** EXT04_LBL */
    private java.lang.String ext04Lbl;
    
    /** USE_EXT05 */
    private int useExt05;
    
    /** EXT05_OPT */
    private java.lang.String ext05Opt;
    
    /** EXT05_LBL */
    private java.lang.String ext05Lbl;
    
    /** USE_EXT06 */
    private int useExt06;
    
    /** EXT06_OPT */
    private java.lang.String ext06Opt;
    
    /** EXT06_LBL */
    private java.lang.String ext06Lbl;
    
    /** USE_EXT07 */
    private int useExt07;
    
    /** EXT07_OPT */
    private java.lang.String ext07Opt;
    
    /** EXT07_LBL */
    private java.lang.String ext07Lbl;
    
    /** USE_EXT08 */
    private int useExt08;
    
    /** EXT08_OPT */
    private java.lang.String ext08Opt;
    
    /** EXT08_LBL */
    private java.lang.String ext08Lbl;
    
    /** USE_EXT09 */
    private int useExt09;
    
    /** EXT09_OPT */
    private java.lang.String ext09Opt;
    
    /** EXT09_LBL */
    private java.lang.String ext09Lbl;
    
    /** USE_EXT10 */
    private int useExt10;
    
    /** EXT10_OPT */
    private java.lang.String ext10Opt;
    
    /** EXT10_LBL */
    private java.lang.String ext10Lbl;
    
    /** USE_EXT11 */
    private int useExt11;
    
    /** EXT11_OPT */
    private java.lang.String ext11Opt;
    
    /** EXT11_LBL */
    private java.lang.String ext11Lbl;
    
    /** USE_EXT12 */
    private int useExt12;
    
    /** EXT12_OPT */
    private java.lang.String ext12Opt;
    
    /** EXT12_LBL */
    private java.lang.String ext12Lbl;
    
    /** USE_EXT13 */
    private int useExt13;
    
    /** EXT13_OPT */
    private java.lang.String ext13Opt;
    
    /** EXT13_LBL */
    private java.lang.String ext13Lbl;
    
    /** USE_EXT14 */
    private int useExt14;
    
    /** EXT14_OPT */
    private java.lang.String ext14Opt;
    
    /** EXT14_LBL */
    private java.lang.String ext14Lbl;
    
    /** USE_EXT15 */
    private int useExt15;
    
    /** EXT15_OPT */
    private java.lang.String ext15Opt;
    
    /** EXT15_LBL */
    private java.lang.String ext15Lbl;
    
    /** USE_EXT16 */
    private int useExt16;
    
    /** EXT16_OPT */
    private java.lang.String ext16Opt;
    
    /** EXT16_LBL */
    private java.lang.String ext16Lbl;
    
    /** USE_EXT17 */
    private int useExt17;
    
    /** EXT17_OPT */
    private java.lang.String ext17Opt;
    
    /** EXT17_LBL */
    private java.lang.String ext17Lbl;
    
    /** USE_EXT18 */
    private int useExt18;
    
    /** EXT18_OPT */
    private java.lang.String ext18Opt;
    
    /** EXT18_LBL */
    private java.lang.String ext18Lbl;
    
    /** USE_EXT19 */
    private int useExt19;
    
    /** EXT19_OPT */
    private java.lang.String ext19Opt;
    
    /** EXT19_LBL */
    private java.lang.String ext19Lbl;
    
    /** USE_EXT20 */
    private int useExt20;
    
    /** EXT20_OPT */
    private java.lang.String ext20Opt;
    
    /** EXT20_LBL */
    private java.lang.String ext20Lbl;
    
    /** USE_DATE01 */
    private int useDate01;
    
    /** DATE01_OPT */
    private java.lang.String date01Opt;
    
    /** DATE01_LBL */
    private java.lang.String date01Lbl;
    
    /** USE_DATE02 */
    private int useDate02;
    
    /** DATE02_OPT */
    private java.lang.String date02Opt;
    
    /** DATE02_LBL */
    private java.lang.String date02Lbl;
    
    /** ADM_EXT */
    private java.lang.String admExt;
    
    /** ADM_LIST */
    private java.lang.String admList;
    
    /** PERM_LIST */
    private java.lang.String permList;
    
    /** PERM_VIEW */
    private java.lang.String permView;
    
    /** PERM_WRITE */
    private java.lang.String permWrite;
    
    /** PERM_REPLY */
    private java.lang.String permReply;
    
    /** PERM_CMT */
    private java.lang.String permCmt;
    
    /** PERM_LIST_TYPE */
    private java.lang.String permListType;
    
    /** PERM_VIEW_TYPE */
    private java.lang.String permViewType;
    
    /** PERM_WRITE_TYPE */
    private java.lang.String permWriteType;
    
    /** PERM_REPLY_TYPE */
    private java.lang.String permReplyType;
    
    /** PERM_CMT_TYPE */
    private java.lang.String permCmtType;
    
    /** ANON_PERM_LIST */
    private int anonPermList;
    
    /** ANON_PERM_VIEW */
    private int anonPermView;
    
    /** ANON_PERM_WRITE */
    private int anonPermWrite;

	/** HIDE_WRITE */
    private int hideWrite;
    
    /** ACTIVE */
    private int active;
    
    /** BOARD_URL */
    private java.lang.String boardUrl;
    
    private java.lang.String fileBlacklist;
    
    private int fileLimitSize;
    
    private int fileLimitCount;
    
    /** TMP1 */
    private java.lang.String tmp1;
    
    /** TMP2 */
    private java.lang.String tmp2;
    
    /** TMP3 */
    private java.lang.String tmp3;
    
    /** TMP4 */
    private java.lang.String tmp4;
    
    /** TMP5 */
    private java.lang.String tmp5;    
    
    /** ISDEL */
    private int isdel;
    
    /** USE_SOCIAL*/
    private int useSocial;
    
    /** USE_LANGUAGE */
    private java.lang.String useLanguage;
    
    /** USE_REACT */
    private int useReact;
    
    /** USE_LATESTLIST */
    private int useLatestlist;
    
    /** THUMB_WIDTH */
    private int thumbWidth = 300;
    
    /** THUMB_HEIGHT */
    private int thumbHeight = 200;
   
    /** THUMB_MAXDIM */
    private int thumbMaxdim = 150;
    
    /** PERM_DOWN */
    private java.lang.String permFileDown;
    
    /** PERM_DOWN_TYPE */
    private java.lang.String permFileDownType;
    
    /** USE_WYSWYG_TYPE */
    private java.lang.String useWyswygType;

	public java.lang.String getUseWyswygType() {
		return useWyswygType;
	}

	public void setUseWyswygType(java.lang.String useWyswygType) {
		this.useWyswygType = useWyswygType;
	}

	public java.lang.String getPermFileDown() {
		return permFileDown;
	}

	public void setPermFileDown(java.lang.String permFileDown) {
		this.permFileDown = permFileDown;
	}

	public java.lang.String getPermFileDownType() {
		return permFileDownType;
	}

	public void setPermFileDownType(java.lang.String permFileDownType) {
		this.permFileDownType = permFileDownType;
	}

	/**
	 * @return the thumbMaxdim
	 */
	public int getThumbMaxdim() {
		return thumbMaxdim;
	}

	/**
	 * @param thumbMaxdim the thumbMaxdim to set
	 */
	public void setThumbMaxdim(int thumbMaxdim) {
		this.thumbMaxdim = thumbMaxdim;
	}

	/**
	 * @return the thumbWidth
	 */
	public int getThumbWidth() {
		return thumbWidth;
	}

	/**
	 * @return the thumbHeight
	 */
	public int getThumbHeight() {
		return thumbHeight;
	}	

	/**
	 * @param thumbWidth the thumbWidth to set
	 */
	public void setThumbWidth(int thumbWidth) {
		this.thumbWidth = thumbWidth;
	}

	/**
	 * @param thumbHeight the thumbHeight to set
	 */
	public void setThumbHeight(int thumbHeight) {
		this.thumbHeight = thumbHeight;
	}	

	/**
	 * @return the useLatestlist
	 */
	public int getUseLatestlist() {
		return useLatestlist;
	}

	/**
	 * @param useLatestlist the useLatestlist to set
	 */
	public void setUseLatestlist(int useLatestlist) {
		this.useLatestlist = useLatestlist;
	}

	/**
	 * @return the useReact
	 */
	public int getUseReact() {
		return useReact;
	}

	/**
	 * @param useReact the useReact to set
	 */
	public void setUseReact(int useReact) {
		this.useReact = useReact;
	}

	/**
	 * @return the useLanguage
	 */
	public java.lang.String getUseLanguage() {
		return useLanguage;
	}

	/**
	 * @param useLanguage the useLanguage to set
	 */
	public void setUseLanguage(java.lang.String useLanguage) {
		this.useLanguage = useLanguage;
	}

	/**
	 * @return the useSocial
	 */
	public int getUseSocial() {
		return useSocial;
	}

	/**
	 * @param useSocial the useSocial to set
	 */
	public void setUseSocial(int useSocial) {
		this.useSocial = useSocial;
	}

	/**
	 * @return the boardUrl
	 */
	public java.lang.String getBoardUrl() {
		return boardUrl;
	}

	/**
	 * @param boardUrl the boardUrl to set
	 */
	public void setBoardUrl(java.lang.String boardUrl) {
		this.boardUrl = boardUrl;
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
	 * @return the tmp3
	 */
	public java.lang.String getTmp3() {
		return tmp3;
	}

	/**
	 * @param tmp3 the tmp3 to set
	 */
	public void setTmp3(java.lang.String tmp3) {
		this.tmp3 = tmp3;
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

	public java.lang.String getBoardId() {
        return this.boardId;
    }
    
    public void setBoardId(java.lang.String boardId) {
        this.boardId = boardId;
    }
    
    public java.lang.String getBoardGroup() {
        return this.boardGroup;
    }
    
    public void setBoardGroup(java.lang.String boardGroup) {
        this.boardGroup = boardGroup;
    }
    
    public java.lang.String getBoardTitle() {
        return this.boardTitle;
    }
    
    public void setBoardTitle(java.lang.String boardTitle) {
        this.boardTitle = boardTitle;
    }
    
    public java.lang.String getLatestConfig() {
		return latestConfig;
	}

	public void setLatestConfig(java.lang.String latestConfig) {
		this.latestConfig = latestConfig;
	}
	
	public java.lang.String getLatestValue() {
		return latestValue;
	}

	public void setLatestValue(java.lang.String latestValue) {
		this.latestValue = latestValue;
	}

	public java.lang.String getBoardType() {
        return this.boardType;
    }
    
    public void setBoardType(java.lang.String boardType) {
        this.boardType = boardType;
    }
    
    public java.lang.String getBoardSkin() {
        return this.boardSkin;
    }
    
    public void setBoardSkin(java.lang.String boardSkin) {
        this.boardSkin = boardSkin;
    }
    
    public int getRowCnt() {
        return this.rowCnt;
    }
    
    public void setRowCnt(int rowCnt) {
        this.rowCnt = rowCnt;
    }
    
    public java.lang.String getBoardSort() {
        return this.boardSort;
    }
    
    public void setBoardSort(java.lang.String boardSort) {
        this.boardSort = boardSort;
    }
    
    public java.lang.String getBoardLbl() {
        return this.boardLbl;
    }
    
    public void setBoardLbl(java.lang.String boardLbl) {
        this.boardLbl = boardLbl;
    }
    
    public java.lang.String getFieldSortList() {
        return this.fieldSortList;
    }
    
    public void setFieldSortList(java.lang.String fieldSortList) {
        this.fieldSortList = fieldSortList;
    }
    
    public java.lang.String getFieldSortView() {
        return this.fieldSortView;
    }
    
    public void setFieldSortView(java.lang.String fieldSortView) {
        this.fieldSortView = fieldSortView;
    }
    
    public java.lang.String getFieldSortWrite() {
		return fieldSortWrite;
	}

	public void setFieldSortWrite(java.lang.String fieldSortWrite) {
		this.fieldSortWrite = fieldSortWrite;
	}

	public int getUseCmt() {
        return this.useCmt;
    }
    
    public void setUseCmt(int useCmt) {
        this.useCmt = useCmt;
    }
    
    public int getUseListReply() {
		return useListReply;
	}

	public void setUseListReply(int useListReply) {
		this.useListReply = useListReply;
	}

	public int getUseViewReply() {
		return useViewReply;
	}

	public void setUseViewReply(int useViewReply) {
		this.useViewReply = useViewReply;
	}

	public int getUseActive() {
        return this.useActive;
    }
    
    public void setUseActive(int useActive) {
        this.useActive = useActive;
    }
    
    public int getUseSecret() {
        return this.useSecret;
    }
    
    public void setUseSecret(int useSecret) {
        this.useSecret = useSecret;
    }
    
    public int getUseNotice() {
        return this.useNotice;
    }
    
    public void setUseNotice(int useNotice) {
        this.useNotice = useNotice;
    }
    
    public int getUseFilter() {
        return this.useFilter;
    }
    
    public void setUseFilter(int useFilter) {
        this.useFilter = useFilter;
    }
    
    public java.lang.String getFilterAction() {
		return filterAction;
	}

	public void setFilterAction(java.lang.String filterAction) {
		this.filterAction = filterAction;
	}

	public int getUseWyswyg() {
        return this.useWyswyg;
    }
    
    public void setUseWyswyg(int useWyswyg) {
        this.useWyswyg = useWyswyg;
    }
    
    public int getUseFile() {
        return this.useFile;
    }
    
    public void setUseFile(int useFile) {
        this.useFile = useFile;
    }
    
    public int getUseImage() {
        return this.useImage;
    }
    
    public void setUseImage(int useImage) {
        this.useImage = useImage;
    }
    
    public int getUseMovie() {
        return this.useMovie;
    }
    
    public void setUseMovie(int useMovie) {
        this.useMovie = useMovie;
    }
    
    public int getUseSms() {
        return this.useSms;
    }
    
    public void setUseSms(int useSms) {
        this.useSms = useSms;
    }
    
    public java.lang.String getSmsNum() {
        return this.smsNum;
    }
    
    public void setSmsNum(java.lang.String smsNum) {
        this.smsNum = smsNum;
    }
    
    public int getUseCategory() {
        return this.useCategory;
    }
    
    public void setUseCategory(int useCategory) {
        this.useCategory = useCategory;
    }
    
    public java.lang.String getCategory() {
        return this.category;
    }
    
    public void setCategory(java.lang.String category) {
        this.category = category;
    }
    
    public int getUseExt01() {
        return this.useExt01;
    }
    
    public void setUseExt01(int useExt01) {
        this.useExt01 = useExt01;
    }
    
    public java.lang.String getExt01Opt() {
        return this.ext01Opt;
    }
    
    public void setExt01Opt(java.lang.String ext01Opt) {
        this.ext01Opt = ext01Opt;
    }
    
    public java.lang.String getExt01Lbl() {
        return this.ext01Lbl;
    }
    
    public void setExt01Lbl(java.lang.String ext01Lbl) {
        this.ext01Lbl = ext01Lbl;
    }
    
    public int getUseExt02() {
        return this.useExt02;
    }
    
    public void setUseExt02(int useExt02) {
        this.useExt02 = useExt02;
    }
    
    public java.lang.String getExt02Opt() {
        return this.ext02Opt;
    }
    
    public void setExt02Opt(java.lang.String ext02Opt) {
        this.ext02Opt = ext02Opt;
    }
    
    public java.lang.String getExt02Lbl() {
        return this.ext02Lbl;
    }
    
    public void setExt02Lbl(java.lang.String ext02Lbl) {
        this.ext02Lbl = ext02Lbl;
    }
    
    public int getUseExt03() {
        return this.useExt03;
    }
    
    public void setUseExt03(int useExt03) {
        this.useExt03 = useExt03;
    }
    
    public java.lang.String getExt03Opt() {
        return this.ext03Opt;
    }
    
    public void setExt03Opt(java.lang.String ext03Opt) {
        this.ext03Opt = ext03Opt;
    }
    
    public java.lang.String getExt03Lbl() {
        return this.ext03Lbl;
    }
    
    public void setExt03Lbl(java.lang.String ext03Lbl) {
        this.ext03Lbl = ext03Lbl;
    }
    
    public int getUseExt04() {
        return this.useExt04;
    }
    
    public void setUseExt04(int useExt04) {
        this.useExt04 = useExt04;
    }
    
    public java.lang.String getExt04Opt() {
        return this.ext04Opt;
    }
    
    public void setExt04Opt(java.lang.String ext04Opt) {
        this.ext04Opt = ext04Opt;
    }
    
    public java.lang.String getExt04Lbl() {
        return this.ext04Lbl;
    }
    
    public void setExt04Lbl(java.lang.String ext04Lbl) {
        this.ext04Lbl = ext04Lbl;
    }
    
    public int getUseExt05() {
        return this.useExt05;
    }
    
    public void setUseExt05(int useExt05) {
        this.useExt05 = useExt05;
    }
    
    public java.lang.String getExt05Opt() {
        return this.ext05Opt;
    }
    
    public void setExt05Opt(java.lang.String ext05Opt) {
        this.ext05Opt = ext05Opt;
    }
    
    public java.lang.String getExt05Lbl() {
        return this.ext05Lbl;
    }
    
    public void setExt05Lbl(java.lang.String ext05Lbl) {
        this.ext05Lbl = ext05Lbl;
    }
    
    public int getUseExt06() {
        return this.useExt06;
    }
    
    public void setUseExt06(int useExt06) {
        this.useExt06 = useExt06;
    }
    
    public java.lang.String getExt06Opt() {
        return this.ext06Opt;
    }
    
    public void setExt06Opt(java.lang.String ext06Opt) {
        this.ext06Opt = ext06Opt;
    }
    
    public java.lang.String getExt06Lbl() {
        return this.ext06Lbl;
    }
    
    public void setExt06Lbl(java.lang.String ext06Lbl) {
        this.ext06Lbl = ext06Lbl;
    }
    
    public int getUseExt07() {
        return this.useExt07;
    }
    
    public void setUseExt07(int useExt07) {
        this.useExt07 = useExt07;
    }
    
    public java.lang.String getExt07Opt() {
        return this.ext07Opt;
    }
    
    public void setExt07Opt(java.lang.String ext07Opt) {
        this.ext07Opt = ext07Opt;
    }
    
    public java.lang.String getExt07Lbl() {
        return this.ext07Lbl;
    }
    
    public void setExt07Lbl(java.lang.String ext07Lbl) {
        this.ext07Lbl = ext07Lbl;
    }
    
    public int getUseExt08() {
        return this.useExt08;
    }
    
    public void setUseExt08(int useExt08) {
        this.useExt08 = useExt08;
    }
    
    public java.lang.String getExt08Opt() {
        return this.ext08Opt;
    }
    
    public void setExt08Opt(java.lang.String ext08Opt) {
        this.ext08Opt = ext08Opt;
    }
    
    public java.lang.String getExt08Lbl() {
        return this.ext08Lbl;
    }
    
    public void setExt08Lbl(java.lang.String ext08Lbl) {
        this.ext08Lbl = ext08Lbl;
    }
    
    public int getUseExt09() {
        return this.useExt09;
    }
    
    public void setUseExt09(int useExt09) {
        this.useExt09 = useExt09;
    }
    
    public java.lang.String getExt09Opt() {
        return this.ext09Opt;
    }
    
    public void setExt09Opt(java.lang.String ext09Opt) {
        this.ext09Opt = ext09Opt;
    }
    
    public java.lang.String getExt09Lbl() {
        return this.ext09Lbl;
    }
    
    public void setExt09Lbl(java.lang.String ext09Lbl) {
        this.ext09Lbl = ext09Lbl;
    }
    
    public int getUseExt10() {
        return this.useExt10;
    }
    
    public void setUseExt10(int useExt10) {
        this.useExt10 = useExt10;
    }
    
    public java.lang.String getExt10Opt() {
        return this.ext10Opt;
    }
    
    public void setExt10Opt(java.lang.String ext10Opt) {
        this.ext10Opt = ext10Opt;
    }
    
    public java.lang.String getExt10Lbl() {
        return this.ext10Lbl;
    }
    
    public void setExt10Lbl(java.lang.String ext10Lbl) {
        this.ext10Lbl = ext10Lbl;
    }
    
    public int getUseExt11() {
        return this.useExt11;
    }
    
    public void setUseExt11(int useExt11) {
        this.useExt11 = useExt11;
    }
    
    public java.lang.String getExt11Opt() {
        return this.ext11Opt;
    }
    
    public void setExt11Opt(java.lang.String ext11Opt) {
        this.ext11Opt = ext11Opt;
    }
    
    public java.lang.String getExt11Lbl() {
        return this.ext11Lbl;
    }
    
    public void setExt11Lbl(java.lang.String ext11Lbl) {
        this.ext11Lbl = ext11Lbl;
    }
    
    public int getUseExt12() {
        return this.useExt12;
    }
    
    public void setUseExt12(int useExt12) {
        this.useExt12 = useExt12;
    }
    
    public java.lang.String getExt12Opt() {
        return this.ext12Opt;
    }
    
    public void setExt12Opt(java.lang.String ext12Opt) {
        this.ext12Opt = ext12Opt;
    }
    
    public java.lang.String getExt12Lbl() {
        return this.ext12Lbl;
    }
    
    public void setExt12Lbl(java.lang.String ext12Lbl) {
        this.ext12Lbl = ext12Lbl;
    }
    
    public int getUseExt13() {
        return this.useExt13;
    }
    
    public void setUseExt13(int useExt13) {
        this.useExt13 = useExt13;
    }
    
    public java.lang.String getExt13Opt() {
        return this.ext13Opt;
    }
    
    public void setExt13Opt(java.lang.String ext13Opt) {
        this.ext13Opt = ext13Opt;
    }
    
    public java.lang.String getExt13Lbl() {
        return this.ext13Lbl;
    }
    
    public void setExt13Lbl(java.lang.String ext13Lbl) {
        this.ext13Lbl = ext13Lbl;
    }
    
    public int getUseExt14() {
        return this.useExt14;
    }
    
    public void setUseExt14(int useExt14) {
        this.useExt14 = useExt14;
    }
    
    public java.lang.String getExt14Opt() {
        return this.ext14Opt;
    }
    
    public void setExt14Opt(java.lang.String ext14Opt) {
        this.ext14Opt = ext14Opt;
    }
    
    public java.lang.String getExt14Lbl() {
        return this.ext14Lbl;
    }
    
    public void setExt14Lbl(java.lang.String ext14Lbl) {
        this.ext14Lbl = ext14Lbl;
    }
    
    public int getUseExt15() {
        return this.useExt15;
    }
    
    public void setUseExt15(int useExt15) {
        this.useExt15 = useExt15;
    }
    
    public java.lang.String getExt15Opt() {
        return this.ext15Opt;
    }
    
    public void setExt15Opt(java.lang.String ext15Opt) {
        this.ext15Opt = ext15Opt;
    }
    
    public java.lang.String getExt15Lbl() {
        return this.ext15Lbl;
    }
    
    public void setExt15Lbl(java.lang.String ext15Lbl) {
        this.ext15Lbl = ext15Lbl;
    }
    
    public int getUseExt16() {
        return this.useExt16;
    }
    
    public void setUseExt16(int useExt16) {
        this.useExt16 = useExt16;
    }
    
    public java.lang.String getExt16Opt() {
        return this.ext16Opt;
    }
    
    public void setExt16Opt(java.lang.String ext16Opt) {
        this.ext16Opt = ext16Opt;
    }
    
    public java.lang.String getExt16Lbl() {
        return this.ext16Lbl;
    }
    
    public void setExt16Lbl(java.lang.String ext16Lbl) {
        this.ext16Lbl = ext16Lbl;
    }
    
    public int getUseExt17() {
        return this.useExt17;
    }
    
    public void setUseExt17(int useExt17) {
        this.useExt17 = useExt17;
    }
    
    public java.lang.String getExt17Opt() {
        return this.ext17Opt;
    }
    
    public void setExt17Opt(java.lang.String ext17Opt) {
        this.ext17Opt = ext17Opt;
    }
    
    public java.lang.String getExt17Lbl() {
        return this.ext17Lbl;
    }
    
    public void setExt17Lbl(java.lang.String ext17Lbl) {
        this.ext17Lbl = ext17Lbl;
    }
    
    public int getUseExt18() {
        return this.useExt18;
    }
    
    public void setUseExt18(int useExt18) {
        this.useExt18 = useExt18;
    }
    
    public java.lang.String getExt18Opt() {
        return this.ext18Opt;
    }
    
    public void setExt18Opt(java.lang.String ext18Opt) {
        this.ext18Opt = ext18Opt;
    }
    
    public java.lang.String getExt18Lbl() {
        return this.ext18Lbl;
    }
    
    public void setExt18Lbl(java.lang.String ext18Lbl) {
        this.ext18Lbl = ext18Lbl;
    }
    
    public int getUseExt19() {
        return this.useExt19;
    }
    
    public void setUseExt19(int useExt19) {
        this.useExt19 = useExt19;
    }
    
    public java.lang.String getExt19Opt() {
        return this.ext19Opt;
    }
    
    public void setExt19Opt(java.lang.String ext19Opt) {
        this.ext19Opt = ext19Opt;
    }
    
    public java.lang.String getExt19Lbl() {
        return this.ext19Lbl;
    }
    
    public void setExt19Lbl(java.lang.String ext19Lbl) {
        this.ext19Lbl = ext19Lbl;
    }
    
    public int getUseExt20() {
        return this.useExt20;
    }
    
    public void setUseExt20(int useExt20) {
        this.useExt20 = useExt20;
    }
    
    public java.lang.String getExt20Opt() {
        return this.ext20Opt;
    }
    
    public void setExt20Opt(java.lang.String ext20Opt) {
        this.ext20Opt = ext20Opt;
    }
    
    public java.lang.String getExt20Lbl() {
        return this.ext20Lbl;
    }
    
    public void setExt20Lbl(java.lang.String ext20Lbl) {
        this.ext20Lbl = ext20Lbl;
    }
    
    public int getUseDate01() {
        return this.useDate01;
    }
    
    public void setUseDate01(int useDate01) {
        this.useDate01 = useDate01;
    }
    
    public java.lang.String getDate01Opt() {
        return this.date01Opt;
    }
    
    public void setDate01Opt(java.lang.String date01Opt) {
        this.date01Opt = date01Opt;
    }
    
    public java.lang.String getDate01Lbl() {
        return this.date01Lbl;
    }
    
    public void setDate01Lbl(java.lang.String date01Lbl) {
        this.date01Lbl = date01Lbl;
    }
    
    public int getUseDate02() {
        return this.useDate02;
    }
    
    public void setUseDate02(int useDate02) {
        this.useDate02 = useDate02;
    }
    
    public java.lang.String getDate02Opt() {
        return this.date02Opt;
    }
    
    public void setDate02Opt(java.lang.String date02Opt) {
        this.date02Opt = date02Opt;
    }
    
    public java.lang.String getDate02Lbl() {
        return this.date02Lbl;
    }
    
    public void setDate02Lbl(java.lang.String date02Lbl) {
        this.date02Lbl = date02Lbl;
    }
    
    public java.lang.String getAdmExt() {
        return this.admExt;
    }
    
    public void setAdmExt(java.lang.String admExt) {
        this.admExt = admExt;
    }
    
    public java.lang.String getAdmList() {
        return this.admList;
    }
    
    public void setAdmList(java.lang.String admList) {
        this.admList = admList;
    }
    
    public java.lang.String getPermList() {
        return this.permList;
    }
    
    public void setPermList(java.lang.String permList) {
        this.permList = permList;
    }
    
    public java.lang.String getPermView() {
        return this.permView;
    }
    
    public void setPermView(java.lang.String permView) {
        this.permView = permView;
    }
    
    public java.lang.String getPermWrite() {
        return this.permWrite;
    }
    
    public void setPermWrite(java.lang.String permWrite) {
        this.permWrite = permWrite;
    }
    
    public java.lang.String getPermReply() {
		return permReply;
	}

	public void setPermReply(java.lang.String permReply) {
		this.permReply = permReply;
	}

	public java.lang.String getPermCmt() {
        return this.permCmt;
    }
    
    public void setPermCmt(java.lang.String permCmt) {
        this.permCmt = permCmt;
    }
    
    public java.lang.String getPermListType() {
		return permListType;
	}

	public void setPermListType(java.lang.String permListType) {
		this.permListType = permListType;
	}

	public java.lang.String getPermViewType() {
		return permViewType;
	}

	public void setPermViewType(java.lang.String permViewType) {
		this.permViewType = permViewType;
	}

	public java.lang.String getPermWriteType() {
		return permWriteType;
	}

	public void setPermWriteType(java.lang.String permWriteType) {
		this.permWriteType = permWriteType;
	}

	public java.lang.String getPermReplyType() {
		return permReplyType;
	}

	public void setPermReplyType(java.lang.String permReplyType) {
		this.permReplyType = permReplyType;
	}

	public java.lang.String getPermCmtType() {
		return permCmtType;
	}

	public void setPermCmtType(java.lang.String permCmtType) {
		this.permCmtType = permCmtType;
	}

	public int getAnonPermList() {
        return this.anonPermList;
    }
    
    public void setAnonPermList(int anonPermList) {
        this.anonPermList = anonPermList;
    }
    
    public int getAnonPermView() {
        return this.anonPermView;
    }
    
    public void setAnonPermView(int anonPermView) {
        this.anonPermView = anonPermView;
    }
    
    public int getHideWrite() {
		return hideWrite;
	}

	public void setHideWrite(int hideWrite) {
		this.hideWrite = hideWrite;
	}

	public int getActive() {
        return this.active;
    }
    
    public void setActive(int active) {
        this.active = active;
    }
    
    public int getAnonPermWrite() {
		return anonPermWrite;
	}

	public void setAnonPermWrite(int anonPermWrite) {
		this.anonPermWrite = anonPermWrite;
	}
	
	public java.lang.String getFileBlacklist() {
		return fileBlacklist;
	}

	public void setFileBlacklist(java.lang.String fileBlacklist) {
		this.fileBlacklist = fileBlacklist;
	}

	public int getFileLimitSize() {
		return fileLimitSize;
	}

	public void setFileLimitSize(int fileLimitSize) {
		this.fileLimitSize = fileLimitSize;
	}

	public int getFileLimitCount() {
		return fileLimitCount;
	}

	public void setFileLimitCount(int fileLimitCount) {
		this.fileLimitCount = fileLimitCount;
	}

	public int getIsdel() {
		return isdel;
	}

	public void setIsdel(int isdel) {
		this.isdel = isdel;
	}

	public int getUseReply() {
		return useReply;
	}

	public void setUseReply(int useReply) {
		this.useReply = useReply;
	}

	public int getUseInternal() {
		return useInternal;
	}

	public void setUseInternal(int useInternal) {
		this.useInternal = useInternal;
	}
    
}
