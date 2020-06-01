/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.io.Serializable;

/**
 * CMS세션 VO 클래스
 * @author CMS서비스
 * @version 1.0
 * @see
 */
public class CmsSessionVO implements Serializable {
	
	/** 사이트 */
	private String siteId;
	private String SiteNm;
	private java.lang.String lang;
	
	/**
	 * @return the lang
	 */
	public java.lang.String getLang() {
		return lang;
	}
	/**
	 * @param lang the lang to set
	 */
	public void setLang(java.lang.String lang) {
		this.lang = lang;
	}
	/**
	 * siteId attribute 를 리턴한다.
	 * @return String
	 */
	public String getSiteId() {
		return siteId;
	}
	/**
	 * siteId attribute 값을 설정한다.
	 * @param siteId String
	 */
	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	public String getSiteNm() {
		return SiteNm;
	}
	public void setSiteNm(String siteNm) {
		SiteNm = siteNm;
	}
}
