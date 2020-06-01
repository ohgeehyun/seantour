/**
 * @version 3.2.0.1
 */
package jnit.mgov.module;


public class JnitMsgdataVO {
	
	private int userdata = 0;
	private int msgSeq = 0;
	private java.lang.String subId = "";
	private int curState = 0;
	private java.util.Date sentDate = null;
	private java.util.Date rsltDate = null;
	private java.util.Date reqDate = null;
	private int rsltCode = 0;
	private java.lang.String rsltCode2 = "";
	private java.lang.String rsltNet = "";
	private java.lang.String callTo = "";
	private java.lang.String callFrom = "";
	private java.lang.String smsTxt = "";
	private int msgType = 0;
	private int contSeq = 0;

	
	
	public int getUserdata() {
		return userdata;
	}

	public void setUserdata(int userdata) {
		this.userdata = userdata;
	}

	public int getMsgSeq() {
		return msgSeq;
	}

	public void setMsgSeq(int msgSeq) {
		this.msgSeq = msgSeq;
	}

	public java.lang.String getSubId() {
		return subId;
	}

	public void setSubId(java.lang.String subId) {
		this.subId = subId;
	}

	public int getCurState() {
		return curState;
	}

	public void setCurState(int curState) {
		this.curState = curState;
	}

	public java.util.Date getSentDate() {
		return sentDate;
	}

	public void setSentDate(java.util.Date sentDate) {
		this.sentDate = sentDate;
	}

	public java.util.Date getRsltDate() {
		return rsltDate;
	}

	public void setRsltDate(java.util.Date rsltDate) {
		this.rsltDate = rsltDate;
	}

	public java.util.Date getReqDate() {
		return reqDate;
	}

	public void setReqDate(java.util.Date reqDate) {
		this.reqDate = reqDate;
	}

	public int getRsltCode() {
		return rsltCode;
	}

	public void setRsltCode(int rsltCode) {
		this.rsltCode = rsltCode;
	}

	public java.lang.String getRsltCode2() {
		return rsltCode2;
	}

	public void setRsltCode2(java.lang.String rsltCode2) {
		this.rsltCode2 = rsltCode2;
	}

	public java.lang.String getRsltNet() {
		return rsltNet;
	}

	public void setRsltNet(java.lang.String rsltNet) {
		this.rsltNet = rsltNet;
	}

	public java.lang.String getCallTo() {
		return callTo;
	}

	public void setCallTo(java.lang.String callTo) {
		this.callTo = callTo;
	}

	public java.lang.String getCallFrom() {
		return callFrom;
	}

	public void setCallFrom(java.lang.String callFrom) {
		this.callFrom = callFrom;
	}

	public java.lang.String getSmsTxt() {
		return smsTxt;
	}

	public void setSmsTxt(java.lang.String smsTxt) {
		this.smsTxt = smsTxt;
	}

	public int getMsgType() {
		return msgType;
	}

	public void setMsgType(int msgType) {
		this.msgType = msgType;
	}

	public int getContSeq() {
		return contSeq;
	}

	public void setContSeq(int contSeq) {
		this.contSeq = contSeq;
	}

}
