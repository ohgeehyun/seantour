/**
 * @version 3.2.0.1
 */
package jnit.cms.config;

public class JnitmbrInfoVO {
	/** 전화번호 */
	int tel = 1;
	
	/** 핸드폰 */	
	int phone = 1;
	
	/** 이메일 */	
	int email = 1;
	
	/** 우편번호 */
	int post = 1;
	
	/** 주소 */
	int addr = 1;
	
	/** 메일수신동의 */	
	int emailRecv = 1;
	
	/** sms수신동의 */
	int smsRecv =1;
	
	/** 개인사업자 */	
	int personal =1;
	
	/** 영리법인 */
	int profit = 1;
	
	/** 비영리법인 */
	int nonprofit = 1;
	
	/** 공식단체 */
	int organization = 1;
	
	/** 상호 */
	int mutual = 1;
	
	/** 법인명 */
	int corporateName = 1;
	
	/** 대표자명 */
	int groupName = 1;
	
	/** 사업장 우편번호 */
	int businessPlace = 1;
	
	/** 사업장 주소 */
	int businessAddr = 1;
	
	/** 대표종목 */
	int groupKind = 1;
	
	/** 대표전화 */
	int groupTel = 1;
	
	/** 대표팩스 */
	int groupPax = 1;
	
	/* 여분필드1 종류 */
	private java.lang.String ex01Type = "0";
	
	/** 여분필드1 사용여부 */
	int ex01Add = 0;
	
	/** 여분필드1 값 */
	private java.lang.String ex01TypeFields = "";
	
	/* 여분필드2 종류 */
	private java.lang.String ex02Type = "0";
	
	/** 여분필드2 사용여부 */
	int ex02Add = 0;
	
	/** 여분필드2 값 */
	private java.lang.String ex02TypeFields = "";
	
	/* 여분필드3 종류 */
	private java.lang.String ex03Type = "0";
	
	/** 여분필드3 사용여부 */
	int ex03Add = 0;
	
	/** 여분필드3 값 */
	private java.lang.String ex03TypeFields = "";
	
	/** 여분필드1 이름 */
	private java.lang.String ex01 = "여분필드1";
	
	/** 여분필드2 이름 */
	private java.lang.String ex02 = "여분필드2";
	
	/** 여분필드3 이름 */
	private java.lang.String ex03 = "여분필드3";
	
	/** 회사명 */
	int groupTitle = 1;
	
	/** 직책 */
	int gradeNm = 1;
	
	/** 자동가입 방지*/
	private java.lang.String captcha = "0";
	
	/**
	 * @return the groupTitle
	 */
	public int getGroupTitle() {
		return groupTitle;
	}
	/**
	 * @return the gradeNm
	 */
	public int getGradeNm() {
		return gradeNm;
	}
	/**
	 * @param groupTitle the groupTitle to set
	 */
	public void setGroupTitle(int groupTitle) {
		this.groupTitle = groupTitle;
	}
	/**
	 * @param gradeNm the gradeNm to set
	 */
	public void setGradeNm(int gradeNm) {
		this.gradeNm = gradeNm;
	}
	/**
	 * @return the ex01Type
	 */
	public java.lang.String getEx01Type() {
		return ex01Type;
	}
	/**
	 * @return the ex02Type
	 */
	public java.lang.String getEx02Type() {
		return ex02Type;
	}
	/**
	 * @return the ex03Type
	 */
	public java.lang.String getEx03Type() {
		return ex03Type;
	}
	/**
	 * @param ex01Type the ex01Type to set
	 */
	public void setEx01Type(java.lang.String ex01Type) {
		this.ex01Type = ex01Type;
	}
	/**
	 * @param ex02Type the ex02Type to set
	 */
	public void setEx02Type(java.lang.String ex02Type) {
		this.ex02Type = ex02Type;
	}
	/**
	 * @param ex03Type the ex03Type to set
	 */
	public void setEx03Type(java.lang.String ex03Type) {
		this.ex03Type = ex03Type;
	}
	
	/**
	 * @return the tel
	 */
	public int getTel() {
		return tel;
	}
	/**
	 * @return the phone
	 */
	public int getPhone() {
		return phone;
	}
	/**
	 * @return the email
	 */
	public int getEmail() {
		return email;
	}
	/**
	 * @return the post
	 */
	public int getPost() {
		return post;
	}
	/**
	 * @return the addr
	 */
	public int getAddr() {
		return addr;
	}
	/**
	 * @return the emailRecv
	 */
	public int getEmailRecv() {
		return emailRecv;
	}
	/**
	 * @return the smsRecv
	 */
	public int getSmsRecv() {
		return smsRecv;
	}
	/**
	 * @return the personal
	 */
	public int getPersonal() {
		return personal;
	}
	/**
	 * @return the profit
	 */
	public int getProfit() {
		return profit;
	}
	/**
	 * @return the nonprofit
	 */
	public int getNonprofit() {
		return nonprofit;
	}
	/**
	 * @return the organization
	 */
	public int getOrganization() {
		return organization;
	}
	/**
	 * @return the mutual
	 */
	public int getMutual() {
		return mutual;
	}
	/**
	 * @return the corporateName
	 */
	public int getCorporateName() {
		return corporateName;
	}
	/**
	 * @return the groupName
	 */
	public int getGroupName() {
		return groupName;
	}
	/**
	 * @return the businessPlace
	 */
	public int getBusinessPlace() {
		return businessPlace;
	}
	/**
	 * @return the businessAddr
	 */
	public int getBusinessAddr() {
		return businessAddr;
	}
	/**
	 * @return the groupKind
	 */
	public int getGroupKind() {
		return groupKind;
	}
	/**
	 * @return the groupTel
	 */
	public int getGroupTel() {
		return groupTel;
	}
	/**
	 * @return the groupPax
	 */
	public int getGroupPax() {
		return groupPax;
	}	
	
	/**
	 * @return the ex01Add
	 */
	public int getEx01Add() {
		return ex01Add;
	}
	/**
	 * @return the ex01TypeFields
	 */
	public java.lang.String getEx01TypeFields() {
		return ex01TypeFields;
	}	
	
	/**
	 * @return the ex02Add
	 */
	public int getEx02Add() {
		return ex02Add;
	}
	/**
	 * @return the ex02TypeFields
	 */
	public java.lang.String getEx02TypeFields() {
		return ex02TypeFields;
	}
	
	/**
	 * @return the ex03Add
	 */
	public int getEx03Add() {
		return ex03Add;
	}
	/**
	 * @return the ex03TypeFields
	 */
	public java.lang.String getEx03TypeFields() {
		return ex03TypeFields;
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
	 * @param tel the tel to set
	 */
	public void setTel(int tel) {
		this.tel = tel;
	}
	/**
	 * @param phone the phone to set
	 */
	public void setPhone(int phone) {
		this.phone = phone;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(int email) {
		this.email = email;
	}
	/**
	 * @param post the post to set
	 */
	public void setPost(int post) {
		this.post = post;
	}
	/**
	 * @param addr the addr to set
	 */
	public void setAddr(int addr) {
		this.addr = addr;
	}
	/**
	 * @param emailRecv the emailRecv to set
	 */
	public void setEmailRecv(int emailRecv) {
		this.emailRecv = emailRecv;
	}
	/**
	 * @param smsRecv the smsRecv to set
	 */
	public void setSmsRecv(int smsRecv) {
		this.smsRecv = smsRecv;
	}
	/**
	 * @param personal the personal to set
	 */
	public void setPersonal(int personal) {
		this.personal = personal;
	}
	/**
	 * @param profit the profit to set
	 */
	public void setProfit(int profit) {
		this.profit = profit;
	}
	/**
	 * @param nonprofit the nonprofit to set
	 */
	public void setNonprofit(int nonprofit) {
		this.nonprofit = nonprofit;
	}
	/**
	 * @param organization the organization to set
	 */
	public void setOrganization(int organization) {
		this.organization = organization;
	}
	/**
	 * @param mutual the mutual to set
	 */
	public void setMutual(int mutual) {
		this.mutual = mutual;
	}
	/**
	 * @param corporateName the corporateName to set
	 */
	public void setCorporateName(int corporateName) {
		this.corporateName = corporateName;
	}
	/**
	 * @param groupName the groupName to set
	 */
	public void setGroupName(int groupName) {
		this.groupName = groupName;
	}
	/**
	 * @param businessPlace the businessPlace to set
	 */
	public void setBusinessPlace(int businessPlace) {
		this.businessPlace = businessPlace;
	}
	/**
	 * @param businessAddr the businessAddr to set
	 */
	public void setBusinessAddr(int businessAddr) {
		this.businessAddr = businessAddr;
	}
	/**
	 * @param groupKind the groupKind to set
	 */
	public void setGroupKind(int groupKind) {
		this.groupKind = groupKind;
	}
	/**
	 * @param groupTel the groupTel to set
	 */
	public void setGroupTel(int groupTel) {
		this.groupTel = groupTel;
	}
	/**
	 * @param groupPax the groupPax to set
	 */
	public void setGroupPax(int groupPax) {
		this.groupPax = groupPax;
	}
	
	/**
	 * @param ex01Add the ex01Add to set
	 */
	public void setEx01Add(int ex01Add) {
		this.ex01Add = ex01Add;
	}
	/**
	 * @param ex01TypeFields the ex01TypeFields to set
	 */
	public void setEx01TypeFields(java.lang.String ex01TypeFields) {
		this.ex01TypeFields = ex01TypeFields;
	}
	
	/**
	 * @param ex02Add the ex02Add to set
	 */
	public void setEx02Add(int ex02Add) {
		this.ex02Add = ex02Add;
	}
	/**
	 * @param ex02TypeFields the ex02TypeFields to set
	 */
	public void setEx02TypeFields(java.lang.String ex02TypeFields) {
		this.ex02TypeFields = ex02TypeFields;
	}
	
	/**
	 * @param ex03Add the ex03Add to set
	 */
	public void setEx03Add(int ex03Add) {
		this.ex03Add = ex03Add;
	}
	/**
	 * @param ex03TypeFields the ex03TypeFields to set
	 */
	public void setEx03TypeFields(java.lang.String ex03TypeFields) {
		this.ex03TypeFields = ex03TypeFields;
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
	public java.lang.String getCaptcha() {
		return captcha;
	}
	public void setCaptcha(java.lang.String captcha) {
		this.captcha = captcha;
	}	
	
	
}
