/**
 * @version 3.2.0.1
 */
package jnit.cms.mbr;

import jnit.cms.mbrtype.JnitcmsmbrtypeVO;

/**
 * @Class Name : JnitcmsmbrVO.java
 * @Description : Jnitcmsmbr VO class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class JnitcmsmbrVO extends JnitcmsmbrDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** MBR_ID */
    private java.lang.String mbrId;
    
    /** ORG_ID */
    private java.lang.String orgId;
    
    /** POS_ID */
    private java.lang.String posId;
    
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
    
    /** TYPE_VO */
    private JnitcmsmbrtypeVO typeVO = new JnitcmsmbrtypeVO();    
    
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
    
    /** 신주소 */
    private java.lang.String addressNew;
    
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
    
    /** 사업장 신주소 */
    private java.lang.String businessAddrNew;
    
    /** 대표 종목 */
    private java.lang.String groupKind;
    
    /** 대표 전화번호 */
    private java.lang.String groupTel;
    
    /** 대표 팩스 */
    private java.lang.String groupPax;    
    
    /** CREATED */
    private java.util.Date created;
    
    /** MODIFIED */
    private java.util.Date modified;
    
    /** ISDEL */
    private byte isdel = 0;
    
    /** 단체가입 승인 여부 */
    private java.lang.String grpConfirm;
    
    /** orgSubId */
    private java.lang.String orgSubId;
    
    /** orgSubNm */
    private java.lang.String orgSubNm;
    
    /** orgSubIsdel */
    private java.lang.String orgSubIsdel;
    
    /** posSubId */
    private java.lang.String posSubId;
    
    /** posSubNm */
    private java.lang.String posSubNm;
    
    /** posSubIsdel */
    private java.lang.String posSubIsdel;
    
    /** RANK_ID */
    private java.lang.String rankId;
    
    /** 업무내용 */
    private java.lang.String workContents;
    
    /** 정렬순서 */ 
    private int odr;
    
    /** DB 연결 타입 */
    private java.lang.String connectType;
    
    /** 그룹타이틀 */
    private java.lang.String groupTitle;
    
    /** 패스워트 틀린 횟수 */
    private int pwMiscnt;   
    
    /** selectCondition */
    private java.lang.String selectCondition = "0";
    
    /** updateCondition */
    private java.lang.String updateCondition = "0";
    
    /** deleteCondition */
    private java.lang.String deleteCondition = "0";
    
    /** isdelYn isdel사용여부 */
    private java.lang.String isdelYn = "Y";
    
    /** SITE_ID */
    private java.lang.String siteId;
    
    /** SITE_ID_YN */
    private java.lang.String siteIdYn = "N";
    
    /** GRADE_NM */
    private java.lang.String gradeNm;
    
    /** EX01 */
    private java.lang.String ex01;
    
    /** EX02 */
    private java.lang.String ex02;
    
    /** EX03 */
    private java.lang.String ex03;
    
    /** CMS메뉴트리 */
    private java.lang.String cmsMenutree;
    
    /** unlockTim */
    private java.lang.String unlockTime;
    
    /** LOCK_DATE */
    private java.util.Date lockDate;
    
	public java.lang.String getCmsMenutree() {
		return cmsMenutree;
	}

	public void setCmsMenutree(java.lang.String cmsMenutree) {
		this.cmsMenutree = cmsMenutree;
	}

	/**
	 * @return the ex01
	 */
	public java.lang.String getEx01() {
		return ex01;
	}

	/**
	 * @return the ex02
	 */
	public java.lang.String getEx02() {
		return ex02;
	}

	/**
	 * @return the ex03
	 */
	public java.lang.String getEx03() {
		return ex03;
	}

	/**
	 * @param ex01 the ex01 to set
	 */
	public void setEx01(java.lang.String ex01) {
		this.ex01 = ex01;
	}

	/**
	 * @param ex02 the ex02 to set
	 */
	public void setEx02(java.lang.String ex02) {
		this.ex02 = ex02;
	}

	/**
	 * @param ex03 the ex03 to set
	 */
	public void setEx03(java.lang.String ex03) {
		this.ex03 = ex03;
	}

	/**
	 * @return the gradeNm
	 */
	public java.lang.String getGradeNm() {
		return gradeNm;
	}

	/**
	 * @param gradeNm the gradeNm to set
	 */
	public void setGradeNm(java.lang.String gradeNm) {
		this.gradeNm = gradeNm;
	}

	/**
	 * @return the siteIdYn
	 */
	public java.lang.String getSiteIdYn() {
		return siteIdYn;
	}

	/**
	 * @param siteIdYn the siteIdYn to set
	 */
	public void setSiteIdYn(java.lang.String siteIdYn) {
		this.siteIdYn = siteIdYn;
	}

	/**
	 * @return the siteId
	 */
	public java.lang.String getSiteId() {
		return siteId;
	}

	/**
	 * @param siteId the siteId to set
	 */
	public void setSiteId(java.lang.String siteId) {
		this.siteId = siteId;
	}

	/**
	 * @return the odr
	 */
	public int getOdr() {
		return odr;
	}

	/**
	 * @param odr the odr to set
	 */
	public void setOdr(int odr) {
		this.odr = odr;
	}

	/**
	 * @return the businessAddrNew
	 */
	public java.lang.String getBusinessAddrNew() {
		return businessAddrNew;
	}

	/**
	 * @param businessAddrNew the businessAddrNew to set
	 */
	public void setBusinessAddrNew(java.lang.String businessAddrNew) {
		this.businessAddrNew = businessAddrNew;
	}

	/**
	 * @return the addressNew
	 */
	public java.lang.String getAddressNew() {
		return addressNew;
	}

	/**
	 * @param addressNew the addressNew to set
	 */
	public void setAddressNew(java.lang.String addressNew) {
		this.addressNew = addressNew;
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
	 * @return the pwMiscnt
	 */
	public int getPwMiscnt() {
		return pwMiscnt;
	}

	/**
	 * @param pwMiscnt the pwMiscnt to set
	 */
	public void setPwMiscnt(int pwMiscnt) {
		this.pwMiscnt = pwMiscnt;
	}

	/**
	 * @return the groupTitle
	 */
	public java.lang.String getGroupTitle() {
		return groupTitle;
	}

	/**
	 * @param groupTitle the groupTitle to set
	 */
	public void setGroupTitle(java.lang.String groupTitle) {
		this.groupTitle = groupTitle;
	}

	/**
	 * @return the connectType
	 */
	public java.lang.String getConnectType() {
		return connectType;
	}

	/**
	 * @param connectType the connectType to set
	 */
	public void setConnectType(java.lang.String connectType) {
		this.connectType = connectType;
	}

	/**
	 * @return the workContents
	 */
	public java.lang.String getWorkContents() {
		return workContents;
	}

	/**
	 * @param workContents the workContents to set
	 */
	public void setWorkContents(java.lang.String workContents) {
		this.workContents = workContents;
	}

	/**
	 * @return the rankId
	 */
	public java.lang.String getRankId() {
		return rankId;
	}

	/**
	 * @param rankId the rankId to set
	 */
	public void setRankId(java.lang.String rankId) {
		this.rankId = rankId;
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

	public java.lang.String getcorporateName() {
		return corporateName;
	}

	public void setcorporateName(java.lang.String corporateName) {
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

	public java.lang.String getMbrId() {
        return this.mbrId;
    }
    
    public void setMbrId(java.lang.String mbrId) {
        this.mbrId = mbrId;
    }
    
    public java.lang.String getOrgId() {
        return this.orgId;
    }
    
    public void setOrgId(java.lang.String orgId) {
        this.orgId = orgId;
    }
    
    public java.lang.String getPosId() {
        return this.posId;
    }
    
    public void setPosId(java.lang.String posId) {
        this.posId = posId;
    }
    
    public java.lang.String getMbrLogin() {
        return this.mbrLogin;
    }
    
    public void setMbrLogin(java.lang.String mbrLogin) {
        this.mbrLogin = mbrLogin;
    }
    
    public java.lang.String getMbrNm() {
        return this.mbrNm;
    }
    
    public void setMbrNm(java.lang.String mbrNm) {
        this.mbrNm = mbrNm;
    }
    
    public java.lang.String getMbrPhoto() {
        return this.mbrPhoto;
    }
    
    public void setMbrPhoto(java.lang.String mbrPhoto) {
        this.mbrPhoto = mbrPhoto;
    }
    
    public java.lang.String getPasswd() {
        return this.passwd;
    }
    
    public void setPasswd(java.lang.String passwd) {
        this.passwd = passwd;
    }
    
    public java.lang.String getTypeId() {
        return this.typeId;
    }
    
    public void setTypeId(java.lang.String typeId) {
        this.typeId = typeId;
    }
    
    public java.lang.String getTel() {
        return this.tel;
    }
    
    public void setTel(java.lang.String tel) {
        this.tel = tel;
    }
    
    public java.lang.String getMobile() {
        return this.mobile;
    }
    
    public void setMobile(java.lang.String mobile) {
        this.mobile = mobile;
    }
    
    public java.lang.String getEmail() {
        return this.email;
    }
    
    public void setEmail(java.lang.String email) {
        this.email = email;
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
    
    public byte getIsdel() {
        return this.isdel;
    }
    
    public void setIsdel(byte isdel) {
        this.isdel = isdel;
    }

	public void setHomepage(java.lang.String homepage) {
		this.homepage = homepage;
	}

	public java.lang.String getHomepage() {
		return homepage;
	}

	public void setPostcode(java.lang.String postcode) {
		this.postcode = postcode;
	}

	public java.lang.String getPostcode() {
		return postcode;
	}

	public void setAddress(java.lang.String address) {
		this.address = address;
	}

	public java.lang.String getAddress() {
		return address;
	}

	public void setEmailRecv(java.lang.Byte emailRecv) {
		this.emailRecv = emailRecv;
	}

	public java.lang.Byte getEmailRecv() {
		return emailRecv;
	}

	public void setSmsRecv(java.lang.Byte smsRecv) {
		this.smsRecv = smsRecv;
	}

	public java.lang.Byte getSmsRecv() {
		return smsRecv;
	}

	public void setSn(java.lang.String sn) {
		this.sn = sn;
	}

	public java.lang.String getSn() {
		return sn;
	}

	public void setDp(java.lang.String dp) {
		this.dp = dp;
	}

	public java.lang.String getDp() {
		return dp;
	}

	public void setTypeVO(JnitcmsmbrtypeVO typeVO) {
		this.typeVO = typeVO;
	}

	public JnitcmsmbrtypeVO getTypeVO() {
		return typeVO;
	}

	public java.lang.String getCorporateName() {
		return corporateName;
	}

	public void setCorporateName(java.lang.String corporateName) {
		this.corporateName = corporateName;
	}

	public java.lang.String getOrgSubId() {
		return orgSubId;
	}

	public void setOrgSubId(java.lang.String orgSubId) {
		this.orgSubId = orgSubId;
	}

	public java.lang.String getOrgSubNm() {
		return orgSubNm;
	}

	public void setOrgSubNm(java.lang.String orgSubNm) {
		this.orgSubNm = orgSubNm;
	}

	public java.lang.String getOrgSubIsdel() {
		return orgSubIsdel;
	}

	public void setOrgSubIsdel(java.lang.String orgSubIsdel) {
		this.orgSubIsdel = orgSubIsdel;
	}

	public java.lang.String getPosSubId() {
		return posSubId;
	}

	public void setPosSubId(java.lang.String posSubId) {
		this.posSubId = posSubId;
	}

	public java.lang.String getPosSubNm() {
		return posSubNm;
	}

	public void setPosSubNm(java.lang.String posSubNm) {
		this.posSubNm = posSubNm;
	}

	public java.lang.String getPosSubIsdel() {
		return posSubIsdel;
	}

	public void setPosSubIsdel(java.lang.String posSubIsdel) {
		this.posSubIsdel = posSubIsdel;
	}

	public java.lang.String getGrpConfirm() {
		return grpConfirm;
	}

	public void setGrpConfirm(java.lang.String grpConfirm) {
		this.grpConfirm = grpConfirm;
	}

	
	public java.lang.String getUnlockTime() {
		return unlockTime;
	}

	
	public void setUnlockTime(java.lang.String unlockTime) {
		this.unlockTime = unlockTime;
	}

	
	public java.util.Date getLockDate() {
		return lockDate;
	}

	
	public void setLockDate(java.util.Date lockDate) {
		this.lockDate = lockDate;
	}
    
}
