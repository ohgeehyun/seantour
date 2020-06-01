/**
 * @version 3.2.0.1
 */
package jnit.rsc.page;


/**
 * @Class Name : JnitrscpageVO.java
 * @Description : Jnitrscpage VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitrscpageViewVO extends JnitrscpageDefaultVO{
    
	/** TYPE_ID */
    private java.lang.String mbrTypeId;
    
    /** TYPE_NM */
    private java.lang.String mbrTypeNm;
    
    /** TYPE_LV */
    private java.lang.String mbrTypeLv;
	
    /** ORG_ID */
    private java.lang.String orgId;
    
    /** ORG_NM */
    private java.lang.String orgNm;
    
    /** GROUP_TYPE */
    private java.lang.String groupType;
    
    /** GROUP_CONFIRM */
    private java.lang.String grpConfirm;
    
    /** POS_LV */
    private int posLv;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** POS_ID */
    private java.lang.String posId;
    
    /** POS_NM */
    private java.lang.String posNm;
    
    /** MBR_LOGIN */
    private java.lang.String mbrLogin;
    
    /** MBR_NM */
    private java.lang.String mbrNm;
    
    /** MBR_PHOTO */
    private java.lang.String mbrPhoto;
    
    /** PASSWD */
    private java.lang.String passwd;
    
    /** TYPE_ID */
    private java.lang.String typeId;
    
    /** TEL */
    private java.lang.String tel;
    
    /** MOBILE */
    private java.lang.String mobile;
    
    /** EMAIL */
    private java.lang.String email;
    
    /** HOMEPAGE */
    private java.lang.String homepage;
    
    /** POSTCODE */
    private java.lang.String postcode;
    
    /** ADDRESS */
    private java.lang.String address;
    
    /** EMAIL_RECV */
    private java.lang.Byte emailRecv = 0;
    
    /** SMS_RECV */
    private java.lang.Byte smsRecv = 0;
    
    /** SN */
    private java.lang.String sn;
    
    /** DP */
    private java.lang.String dp;
    
    /** 사업자번호 */
    private java.lang.String establishment;
    
    /** 법인등록번호 */
    private java.lang.String corporation;
    
    /** 고유번호 */
    private java.lang.String primaryKey;
    
    /** 상호 */
    private java.lang.String mutual;
    
    /** 법인명 */ 
    private java.lang.String corporateName;
    
    /** 대표자명 */
    private java.lang.String groupName;
    
    /** 사업장 소재지*/
    private java.lang.String businessPlace;
    
    /** 사업장 주소 */
    private java.lang.String businessAddr;
    
    /** 대표 종목 */
    private java.lang.String groupKind;
    
    /** 대표 전화번호 */
    private java.lang.String groupTel;
    
    /** 대표 팩스 */
    private java.lang.String groupPax;
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** MENU_ID */
    private java.lang.String menuId;
    
    /** MENU_ID */
    private java.lang.String menuSearchId;
    
    /** MENU_NM */
    private java.lang.String menuNm;
    
    /** MENU_PATH */
    private java.lang.String menuPath;
    
    /** PID */
    private java.lang.String pid;
    
    /** DEPTH */
    private int depth;
    
    /** METHOD */
    private int method;
    
    /** ISLINK */
    private int islink;
    
    /** ISCNT */
    private int iscnt;
    
    /** LINKURL */
    private java.lang.String linkurl;
    
    /** LINKTGT */
    private java.lang.String linktgt;
    
    /** TPL_ID */
    private java.lang.String tplId;
    
    /** CNT_ID */
    private java.lang.String cntId;
    
    /** DEF_MENU */
    private java.lang.String defMenu;
    
    /** MENU_IMG_FILE */
    private java.lang.String menuImgFile;
    
    /** MENU_IMG_PATH */
    private java.lang.String menuImgPath;
    
    /** MENU_IMG_ONM */
    private java.lang.String menuImgOnm;
    
    /** MENU_IMG_URL */
    private java.lang.String menuImgUrl;
    
    /** ADM_MBR_ID */
    private java.lang.String admMbrId;
    
    /** ACTIVE */
    private int active;
    
    /** CCL */
    private java.lang.String ccl;
    
    /** ISDEL */
    private int mbrIsdel = 0;
    
    /** ISDEL */
    private int posIsdel = 0;
    
    /** ISDEL */
    private int orgIsdel = 0;
    
    /** ISDEL */
    private int menuIsdel = 0;
    
    /** ISDEL */
    private int mbrTypeIsdel = 0;

	public java.lang.String getMbrTypeId() {
		return mbrTypeId;
	}

	public void setMbrTypeId(java.lang.String mbrTypeId) {
		this.mbrTypeId = mbrTypeId;
	}

	public java.lang.String getMbrTypeNm() {
		return mbrTypeNm;
	}

	public void setMbrTypeNm(java.lang.String mbrTypeNm) {
		this.mbrTypeNm = mbrTypeNm;
	}

	public java.lang.String getMbrTypeLv() {
		return mbrTypeLv;
	}

	public void setMbrTypeLv(java.lang.String mbrTypeLv) {
		this.mbrTypeLv = mbrTypeLv;
	}

	public java.lang.String getOrgId() {
		return orgId;
	}

	public void setOrgId(java.lang.String orgId) {
		this.orgId = orgId;
	}

	public java.lang.String getOrgNm() {
		return orgNm;
	}

	public void setOrgNm(java.lang.String orgNm) {
		this.orgNm = orgNm;
	}

	public int getPosLv() {
		return posLv;
	}

	public void setPosLv(int posLv) {
		this.posLv = posLv;
	}
	
	public java.lang.String getPosNm() {
		return posNm;
	}

	public void setPosNm(java.lang.String posNm) {
		this.posNm = posNm;
	}

	public java.lang.String getGroupType() {
		return groupType;
	}

	public void setGroupType(java.lang.String groupType) {
		this.groupType = groupType;
	}

	public java.lang.String getGrpConfirm() {
		return grpConfirm;
	}

	public void setGrpConfirm(java.lang.String grpConfirm) {
		this.grpConfirm = grpConfirm;
	}

	public java.lang.String getMbrId() {
		return mbrId;
	}

	public void setMbrId(java.lang.String mbrId) {
		this.mbrId = mbrId;
	}

	public java.lang.String getPosId() {
		return posId;
	}

	public void setPosId(java.lang.String posId) {
		this.posId = posId;
	}

	public java.lang.String getMbrLogin() {
		return mbrLogin;
	}

	public void setMbrLogin(java.lang.String mbrLogin) {
		this.mbrLogin = mbrLogin;
	}

	public java.lang.String getMbrNm() {
		return mbrNm;
	}

	public void setMbrNm(java.lang.String mbrNm) {
		this.mbrNm = mbrNm;
	}

	public java.lang.String getMbrPhoto() {
		return mbrPhoto;
	}

	public void setMbrPhoto(java.lang.String mbrPhoto) {
		this.mbrPhoto = mbrPhoto;
	}

	public java.lang.String getPasswd() {
		return passwd;
	}

	public void setPasswd(java.lang.String passwd) {
		this.passwd = passwd;
	}

	public java.lang.String getTypeId() {
		return typeId;
	}

	public void setTypeId(java.lang.String typeId) {
		this.typeId = typeId;
	}

	public java.lang.String getTel() {
		return tel;
	}

	public void setTel(java.lang.String tel) {
		this.tel = tel;
	}

	public java.lang.String getMobile() {
		return mobile;
	}

	public void setMobile(java.lang.String mobile) {
		this.mobile = mobile;
	}

	public java.lang.String getEmail() {
		return email;
	}

	public void setEmail(java.lang.String email) {
		this.email = email;
	}

	public java.lang.String getHomepage() {
		return homepage;
	}

	public void setHomepage(java.lang.String homepage) {
		this.homepage = homepage;
	}

	public java.lang.String getPostcode() {
		return postcode;
	}

	public void setPostcode(java.lang.String postcode) {
		this.postcode = postcode;
	}

	public java.lang.String getAddress() {
		return address;
	}

	public void setAddress(java.lang.String address) {
		this.address = address;
	}

	public java.lang.Byte getEmailRecv() {
		return emailRecv;
	}

	public void setEmailRecv(java.lang.Byte emailRecv) {
		this.emailRecv = emailRecv;
	}

	public java.lang.Byte getSmsRecv() {
		return smsRecv;
	}

	public void setSmsRecv(java.lang.Byte smsRecv) {
		this.smsRecv = smsRecv;
	}

	public java.lang.String getSn() {
		return sn;
	}

	public void setSn(java.lang.String sn) {
		this.sn = sn;
	}

	public java.lang.String getDp() {
		return dp;
	}

	public void setDp(java.lang.String dp) {
		this.dp = dp;
	}

	public java.lang.String getEstablishment() {
		return establishment;
	}

	public void setEstablishment(java.lang.String establishment) {
		this.establishment = establishment;
	}

	public java.lang.String getCorporation() {
		return corporation;
	}

	public void setCorporation(java.lang.String corporation) {
		this.corporation = corporation;
	}

	public java.lang.String getPrimaryKey() {
		return primaryKey;
	}

	public void setPrimaryKey(java.lang.String primaryKey) {
		this.primaryKey = primaryKey;
	}

	public java.lang.String getMutual() {
		return mutual;
	}

	public void setMutual(java.lang.String mutual) {
		this.mutual = mutual;
	}

	public java.lang.String getCorporateName() {
		return corporateName;
	}

	public void setCorporateName(java.lang.String corporateName) {
		this.corporateName = corporateName;
	}

	public java.lang.String getGroupName() {
		return groupName;
	}

	public void setGroupName(java.lang.String groupName) {
		this.groupName = groupName;
	}

	public java.lang.String getBusinessPlace() {
		return businessPlace;
	}

	public void setBusinessPlace(java.lang.String businessPlace) {
		this.businessPlace = businessPlace;
	}

	public java.lang.String getBusinessAddr() {
		return businessAddr;
	}

	public void setBusinessAddr(java.lang.String businessAddr) {
		this.businessAddr = businessAddr;
	}

	public java.lang.String getGroupKind() {
		return groupKind;
	}

	public void setGroupKind(java.lang.String groupKind) {
		this.groupKind = groupKind;
	}

	public java.lang.String getGroupTel() {
		return groupTel;
	}

	public void setGroupTel(java.lang.String groupTel) {
		this.groupTel = groupTel;
	}

	public java.lang.String getGroupPax() {
		return groupPax;
	}

	public void setGroupPax(java.lang.String groupPax) {
		this.groupPax = groupPax;
	}

	public java.lang.String getSiteId() {
		return siteId;
	}

	public void setSiteId(java.lang.String siteId) {
		this.siteId = siteId;
	}

	public java.lang.String getMenuId() {
		return menuId;
	}

	public void setMenuId(java.lang.String menuId) {
		this.menuId = menuId;
	}

	public java.lang.String getMenuSearchId() {
		return menuSearchId;
	}

	public void setMenuSearchId(java.lang.String menuSearchId) {
		this.menuSearchId = menuSearchId;
	}

	public java.lang.String getMenuNm() {
		return menuNm;
	}

	public void setMenuNm(java.lang.String menuNm) {
		this.menuNm = menuNm;
	}

	public java.lang.String getMenuPath() {
		return menuPath;
	}

	public void setMenuPath(java.lang.String menuPath) {
		this.menuPath = menuPath;
	}

	public java.lang.String getPid() {
		return pid;
	}

	public void setPid(java.lang.String pid) {
		this.pid = pid;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getMethod() {
		return method;
	}

	public void setMethod(int method) {
		this.method = method;
	}

	public int getIslink() {
		return islink;
	}

	public void setIslink(int islink) {
		this.islink = islink;
	}

	public int getIscnt() {
		return iscnt;
	}

	public void setIscnt(int iscnt) {
		this.iscnt = iscnt;
	}

	public java.lang.String getLinkurl() {
		return linkurl;
	}

	public void setLinkurl(java.lang.String linkurl) {
		this.linkurl = linkurl;
	}

	public java.lang.String getLinktgt() {
		return linktgt;
	}

	public void setLinktgt(java.lang.String linktgt) {
		this.linktgt = linktgt;
	}

	public java.lang.String getTplId() {
		return tplId;
	}

	public void setTplId(java.lang.String tplId) {
		this.tplId = tplId;
	}

	public java.lang.String getCntId() {
		return cntId;
	}

	public void setCntId(java.lang.String cntId) {
		this.cntId = cntId;
	}

	public java.lang.String getDefMenu() {
		return defMenu;
	}

	public void setDefMenu(java.lang.String defMenu) {
		this.defMenu = defMenu;
	}

	public java.lang.String getMenuImgFile() {
		return menuImgFile;
	}

	public void setMenuImgFile(java.lang.String menuImgFile) {
		this.menuImgFile = menuImgFile;
	}

	public java.lang.String getMenuImgPath() {
		return menuImgPath;
	}

	public void setMenuImgPath(java.lang.String menuImgPath) {
		this.menuImgPath = menuImgPath;
	}

	public java.lang.String getMenuImgOnm() {
		return menuImgOnm;
	}

	public void setMenuImgOnm(java.lang.String menuImgOnm) {
		this.menuImgOnm = menuImgOnm;
	}

	public java.lang.String getMenuImgUrl() {
		return menuImgUrl;
	}

	public void setMenuImgUrl(java.lang.String menuImgUrl) {
		this.menuImgUrl = menuImgUrl;
	}

	public java.lang.String getAdmMbrId() {
		return admMbrId;
	}

	public void setAdmMbrId(java.lang.String admMbrId) {
		this.admMbrId = admMbrId;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public java.lang.String getCcl() {
		return ccl;
	}

	public void setCcl(java.lang.String ccl) {
		this.ccl = ccl;
	}

	public int getMbrIsdel() {
		return mbrIsdel;
	}

	public void setMbrIsdel(int mbrIsdel) {
		this.mbrIsdel = mbrIsdel;
	}

	public int getPosIsdel() {
		return posIsdel;
	}

	public void setPosIsdel(int posIsdel) {
		this.posIsdel = posIsdel;
	}

	public int getOrgIsdel() {
		return orgIsdel;
	}

	public void setOrgIsdel(int orgIsdel) {
		this.orgIsdel = orgIsdel;
	}

	public int getMenuIsdel() {
		return menuIsdel;
	}

	public void setMenuIsdel(int menuIsdel) {
		this.menuIsdel = menuIsdel;
	}

	public int getMbrTypeIsdel() {
		return mbrTypeIsdel;
	}

	public void setMbrTypeIsdel(int mbrTypeIsdel) {
		this.mbrTypeIsdel = mbrTypeIsdel;
	}
    
}
