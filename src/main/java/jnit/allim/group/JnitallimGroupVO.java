/**
 * @version 3.2.0.1
 */
package jnit.allim.group;

/**
 * @Class Name : JnitallimGroupVO.java
 * @Description : JnitallimGroup VO class
 * @Modification Information
 *
 * @author JNITALLIM_GROUP
 * @since 2012.04.24
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */
public class JnitallimGroupVO extends JnitallimGroupDefaultVO{
    private static final long serialVersionUID = 1L;

    /** GROUP_ID */
    private java.lang.String groupId = "";

    /** GROUP_NM */
    private java.lang.String groupNm = "";

    /** GROUP_WIDTH */
    private java.lang.String groupWidth = "";

    /** GROUP_HEIGHT */
    private java.lang.String groupHeight = "";

    /** CREATED */
    private java.util.Date created;

    /** MODIFIED */
    private java.util.Date modified;

    /** ISDEL */
    private int isdel = 0;

    /** GROUP_EXT01 */
    private java.lang.String groupExt01 = "";

    /** GROUP_EXT02 */
    private java.lang.String groupExt02 = "";

    /** GROUP_EXT03 */
    private int groupExt03 = 0;

    /** GROUP_EXT04 */
    private int groupExt04 = 0;

    /** GROUP_TYPE */
    private java.lang.String groupType = "";

    /** GROUP_CLASSNAME */
    private java.lang.String groupClassName = "";

    /** GROUP_DIRECTION */
    private int groupDirection = 0;

    /** GROUP_CHANGETIME */
    private java.lang.String groupChangeTime = "";

    /** GROUP_SHOWITEMS */
    private int groupShowItems = 0;

    /** GROUP_TIMERDELAY */
    private int groupTimerDelay = 0;

    /** GROUP_ANIMATIONDELAY */
    private int groupAnimationDelay = 0;

    /** GROUP_AUTO */
    private int groupAuto = 0;

    /** GROUP_CATEGORY */
    private java.lang.String groupCategory;

    /**
	 * @return the groupCategory
	 */
	public String getGroupCategory() {
		return groupCategory;
	}

	/**
	 * @param groupCategory the groupCategory to set
	 */
	public void setGroupCategory(String groupCategory) {
		this.groupCategory = groupCategory;
	}

	public int getGroupShowItems() {
		return groupShowItems;
	}

	public void setGroupShowItems(int groupShowItems) {
		this.groupShowItems = groupShowItems;
	}

	public int getGroupTimerDelay() {
		return groupTimerDelay;
	}

	public void setGroupTimerDelay(int groupTimerDelay) {
		this.groupTimerDelay = groupTimerDelay;
	}

	public int getGroupAnimationDelay() {
		return groupAnimationDelay;
	}

	public void setGroupAnimationDelay(int groupAnimationDelay) {
		this.groupAnimationDelay = groupAnimationDelay;
	}

	public int getGroupAuto() {
		return groupAuto;
	}

	public void setGroupAuto(int groupAuto) {
		this.groupAuto = groupAuto;
	}

	public int getGroupDirection() {
		return groupDirection;
	}

	public void setGroupDirection(int groupDirection) {
		this.groupDirection = groupDirection;
	}

	public java.lang.String getGroupClassName() {
		return groupClassName;
	}

	public void setGroupClassName(java.lang.String groupClassName) {
		this.groupClassName = groupClassName;
	}

	public java.lang.String getGroupId() {
        return this.groupId;
    }

    public void setGroupId(java.lang.String groupId) {
        this.groupId = groupId;
    }

    public java.lang.String getGroupNm() {
        return this.groupNm;
    }

    public void setGroupNm(java.lang.String groupNm) {
        this.groupNm = groupNm;
    }

    public java.lang.String getGroupWidth() {
        return this.groupWidth;
    }

    public void setGroupWidth(java.lang.String groupWidth) {
        this.groupWidth = groupWidth;
    }

    public java.lang.String getGroupHeight() {
        return this.groupHeight;
    }

    public void setGroupHeight(java.lang.String groupHeight) {
        this.groupHeight = groupHeight;
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

    public int getIsdel() {
        return this.isdel;
    }

    public void setIsdel(int isdel) {
        this.isdel = isdel;
    }

    public java.lang.String getGroupExt01() {
        return this.groupExt01;
    }

    public void setGroupExt01(java.lang.String groupExt01) {
        this.groupExt01 = groupExt01;
    }

    public java.lang.String getGroupExt02() {
        return this.groupExt02;
    }

    public void setGroupExt02(java.lang.String groupExt02) {
        this.groupExt02 = groupExt02;
    }

    public int getGroupExt03() {
        return this.groupExt03;
    }

    public void setGroupExt03(int groupExt03) {
        this.groupExt03 = groupExt03;
    }

    public int getGroupExt04() {
        return this.groupExt04;
    }

    public void setGroupExt04(int groupExt04) {
        this.groupExt04 = groupExt04;
    }

	public java.lang.String getGroupType() {
		return groupType;
	}

	public void setGroupType(java.lang.String groupType) {
		this.groupType = groupType;
	}

	public java.lang.String getGroupChangeTime() {
		return groupChangeTime;
	}

	public void setGroupChangeTime(java.lang.String groupChangeTime) {
		this.groupChangeTime = groupChangeTime;
	}


}
