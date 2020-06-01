/**
 * @version 3.2.0.1
 */
package jnit.mgov.addressbook;

public class JnitMgovAddrGrpVO {
	
	private java.lang.String grpId = "";
	private java.lang.String grpNm = "";
	private java.lang.String userMbr = "";
	private java.util.Date created = null;
	private java.util.Date modified = null;
	private int isdel = 0;
	
	
	public java.lang.String getGrpId() {
		return grpId;
	}
	public void setGrpId(java.lang.String grpId) {
		this.grpId = grpId;
	}
	public java.lang.String getGrpNm() {
		return grpNm;
	}
	public void setGrpNm(java.lang.String grpNm) {
		this.grpNm = grpNm;
	}
	public java.lang.String getUserMbr() {
		return userMbr;
	}
	public void setUserMbr(java.lang.String userMbr) {
		this.userMbr = userMbr;
	}
	public java.util.Date getCreated() {
		return created;
	}
	public void setCreated(java.util.Date created) {
		this.created = created;
	}
	public java.util.Date getModified() {
		return modified;
	}
	public void setModified(java.util.Date modified) {
		this.modified = modified;
	}
	public int getIsdel() {
		return isdel;
	}
	public void setIsdel(int isdel) {
		this.isdel = isdel;
	}
	
}
