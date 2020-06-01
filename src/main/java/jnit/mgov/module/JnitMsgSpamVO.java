/**
 * @version 3.2.0.1
 */
package jnit.mgov.module;

public class JnitMsgSpamVO {

	private int spam_seq = 0;
	private java.lang.String spam_flag = "";
	private java.lang.String spam_id = "";
	private java.util.Date spam_date = null;
	private java.lang.String spam_call_to = "";
	private java.lang.String spam_call_from = "";
	private java.lang.String spam_sms_txt = "";
	
	
	
	public int getSpam_seq() {
		return spam_seq;
	}
	public void setSpam_seq(int spam_seq) {
		this.spam_seq = spam_seq;
	}
	public java.lang.String getSpam_flag() {
		return spam_flag;
	}
	public void setSpam_flag(java.lang.String spam_flag) {
		this.spam_flag = spam_flag;
	}
	public java.lang.String getSpam_id() {
		return spam_id;
	}
	public void setSpam_id(java.lang.String spam_id) {
		this.spam_id = spam_id;
	}
	public java.util.Date getSpam_date() {
		return spam_date;
	}
	public void setSpam_date(java.util.Date spam_date) {
		this.spam_date = spam_date;
	}
	public java.lang.String getSpam_call_to() {
		return spam_call_to;
	}
	public void setSpam_call_to(java.lang.String spam_call_to) {
		this.spam_call_to = spam_call_to;
	}
	public java.lang.String getSpam_call_from() {
		return spam_call_from;
	}
	public void setSpam_call_from(java.lang.String spam_call_from) {
		this.spam_call_from = spam_call_from;
	}
	public java.lang.String getSpam_sms_txt() {
		return spam_sms_txt;
	}
	public void setSpam_sms_txt(java.lang.String spam_sms_txt) {
		this.spam_sms_txt = spam_sms_txt;
	}
	
}
