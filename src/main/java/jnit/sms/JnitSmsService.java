/**
 * @version 3.2.0.1
 */
package jnit.sms;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import jnit.sms.mgov.JnitsmsmgovService;
import jnit.sms.mgov.JnitsmsmgovVO;

@Service("jnitSmsService")
public class JnitSmsService extends EgovAbstractServiceImpl {
	
	private Log log = LogFactory.getLog(getClass());
	
	private String vendor = "";
    private String hostname = "";
    private String sid = "";
    private String passwd = "";
    private String errorMsg = "";
    private int limitCnt = 0;
    
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");
    
    public void init() throws Exception {
    	setVendor(EgovProperties.getProperty("Globals.SMS.vendor"));
    	
    	if(vendor.equals("ltskorea")) {
	    	setHostname(EgovProperties.getProperty("Globals.SMS.hostname"));
	    	setSid(EgovProperties.getProperty("Globals.SMS.sid"));
	    	setPasswd(EgovProperties.getProperty("Globals.SMS.passwd"));
	    	
	    	log.info("init");
    	}
    }
    
    public int getStatus() throws Exception {
    	
    	log.debug("Vendor:" + getVendor());
    	
    	if(vendor.equals("ltskorea")) {
	    	log.debug("Hostname:" + getHostname());
	    	log.debug("Sid:" + getSid());
	    	log.debug("Passwd:" + getPasswd());
    	}
    	
    	return 0;
    }

	public void setVendor(String vendor) {
		this.vendor = vendor;
	}

	public String getVendor() {
		return vendor;
	}
    
	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getSid() {
		return sid;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setHostname(String hostname) {
		this.hostname = hostname;
	}

	public String getHostname() {
		return hostname;
	}
	
	public boolean sendMsg(String toTel, String fromTel, String msg) {
		
		if(vendor.equals("egov")) {
			if("true".equals(deDug)){
				log.debug("=======SMS Service=======");
				log.debug("Vendor :: " + vendor);
				log.debug("From   :: " + fromTel);
				log.debug("To     :: " + toTel);
				log.debug("Msg    :: " + msg);
			}
	    	if(!NullUtil.nullString(toTel).equals("")) {
	    		toTel = toTel.replaceAll("-", "");
	    	}else{
	    		return false;
	    	}
	    	if(!NullUtil.nullString(fromTel).equals("")) {
	    		fromTel = fromTel.replaceAll("-", "");
	    	}else{
	    		return false;
	    	}
	    	if(NullUtil.nullString(msg).equals("")) {
	    		return false;
	    	}
	    	JnitsmsmgovVO jnitsmsmgovVO = new JnitsmsmgovVO();
	    	jnitsmsmgovVO.setMsgUid("JNITCMS");
	    	jnitsmsmgovVO.setMsgSendNo(toTel);
	    	jnitsmsmgovVO.setMsgRcvNo(fromTel);
	    	jnitsmsmgovVO.setMsgTxt(msg);
	    	jnitsmsmgovVO.setMsgType("SMS");
	    	jnitsmsmgovVO.setMsgType2("SMS");
	    	jnitsmsmgovVO.setMsgTransDt(new Date());
	    	jnitsmsmgovVO.setMsgDate(new Date());
	    	jnitsmsmgovVO.setMsgStatus("0000");
	    	try {
	    		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	    		HttpSession session = request.getSession();
	    		ServletContext conext = session.getServletContext();
	    		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(conext);
	    		JnitsmsmgovService jnitsmsmgovService = (JnitsmsmgovService)wContext.getBean("jnitsmsmgovService");
				jnitsmsmgovService.insertJnitsmsmgov(jnitsmsmgovVO);
	    	} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			return false;
		}
		
		if(vendor.equals("ltskorea")) {
			if("true".equals(deDug)){
				log.debug("=======SMS Service=======");
				log.debug("Vendor :: " + vendor);
				log.debug("From   :: " + fromTel);
				log.debug("To     :: " + toTel);
				log.debug("Msg    :: " + msg);
			}
			
			StringBuffer sb = null;
			
			String url = "http://"+hostname+"/smsApi/request.php";
			
			HttpClient client = new DefaultHttpClient();
			HttpPost request = new HttpPost(url);
			
			ArrayList<BasicNameValuePair> params = new ArrayList<BasicNameValuePair>();
			params.add(new BasicNameValuePair("sid", sid));
			params.add(new BasicNameValuePair("passwd", passwd));
			params.add(new BasicNameValuePair("tel", toTel));
			params.add(new BasicNameValuePair("from", fromTel));
			params.add(new BasicNameValuePair("msg", msg));
			
			try {
				// Form Encoding 설정
				UrlEncodedFormEntity formEntity = new UrlEncodedFormEntity(params,"UTF-8");
				request.setEntity(formEntity);
				
				// Request
				HttpResponse response = client.execute(request);
				
				// Request 결과 처리
				InputStream in = response.getEntity().getContent();
				sb = getStringBufferByReading(in, "UTF-8");
			} catch (ClientProtocolException e) {
				// TODO Auto-generated catch block
				log.error(e.getMessage());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				log.error(e.getMessage());
			}
			
			return checkErrors(sb);
		}
		
		return false;
	}
	
	public boolean sendMsg2(String toTel, String fromTel, String fromNm, String msg) {
		
		if(vendor.equals("egov")) {
			if("true".equals(deDug)){
				log.debug("=======SMS Service(egov)=======");
				log.debug("Vendor :: " + vendor);
				log.debug("FromTel   :: " + fromTel);
				log.debug("FromNm   :: " + fromNm);
				log.debug("To     :: " + toTel);
				log.debug("Msg    :: " + msg);
			}
	    	if(!NullUtil.nullString(toTel).equals("")) {
	    		toTel = toTel.replaceAll("-", "");
	    	}else{
	    		return false;
	    	}
	    	if(!NullUtil.nullString(fromTel).equals("")) {
	    		fromTel = fromTel.replaceAll("-", "");
	    	}else{
	    		return false;
	    	}
	    	if(NullUtil.nullString(msg).equals("")) {
	    		return false;
	    	}
	    	JnitsmsmgovVO jnitsmsmgovVO = new JnitsmsmgovVO();
	    	jnitsmsmgovVO.setMsgUid("JNITCMS");
	    	jnitsmsmgovVO.setMsgSendNo(toTel);
	    	jnitsmsmgovVO.setMsgRcvNo(fromTel);
	    	jnitsmsmgovVO.setMsgRcvName(fromNm);
	    	jnitsmsmgovVO.setMsgTxt(msg);
	    	jnitsmsmgovVO.setMsgType("SMS");
	    	jnitsmsmgovVO.setMsgType2("SMS");
	    	jnitsmsmgovVO.setMsgTransDt(new Date());
	    	jnitsmsmgovVO.setMsgDate(new Date());
	    	jnitsmsmgovVO.setMsgStatus("0000");
	    	try {
	    		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	    		HttpSession session = request.getSession();
	    		ServletContext conext = session.getServletContext();
	    		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(conext);
	    		JnitsmsmgovService jnitsmsmgovService = (JnitsmsmgovService)wContext.getBean("jnitsmsmgovService");
				jnitsmsmgovService.insertJnitsmsmgov(jnitsmsmgovVO);
	    	} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			return false;
		}
		
		if(vendor.equals("ltskorea")) {
			if("true".equals(deDug)){
				log.debug("=======SMS Service(ltskorea)=======");
				log.debug("Vendor :: " + vendor);
				log.debug("From   :: " + fromTel);
				log.debug("To     :: " + toTel);
				log.debug("Msg    :: " + msg);
			}
			
			StringBuffer sb = null;
			
			String url = "http://"+hostname+"/smsApi/request.php";
			
			HttpClient client = new DefaultHttpClient();
			HttpPost request = new HttpPost(url);
			
			ArrayList<BasicNameValuePair> params = new ArrayList<BasicNameValuePair>();
			params.add(new BasicNameValuePair("sid", sid));
			params.add(new BasicNameValuePair("passwd", passwd));
			params.add(new BasicNameValuePair("tel", toTel));
			params.add(new BasicNameValuePair("from", fromTel));
			params.add(new BasicNameValuePair("msg", msg));
			
			try {
				// Form Encoding 설정
				UrlEncodedFormEntity formEntity = new UrlEncodedFormEntity(params,"UTF-8");
				request.setEntity(formEntity);
				
				// Request
				HttpResponse response = client.execute(request);
				
				// Request 결과 처리
				InputStream in = response.getEntity().getContent();
				sb = getStringBufferByReading(in, "UTF-8");
			} catch (ClientProtocolException e) {
				// TODO Auto-generated catch block
				log.error(e.getMessage());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				log.error(e.getMessage());
			}
			
			return checkErrors(sb);
		}
		
		return false;
	}
	
	//예약문자 추가. 2012.10.04 by.Dael
	public boolean sendMsg(String toTel, String fromTel, String msg, java.util.Date rsvdate) {
		
		if(vendor.equals("ltskorea")) {
			StringBuffer sb = null;
			
			String url = "http://"+hostname+"/smsApi/request.php";
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			
			
			HttpClient client = new DefaultHttpClient();
			HttpPost request = new HttpPost(url);
			
			ArrayList<BasicNameValuePair> params = new ArrayList<BasicNameValuePair>();
			params.add(new BasicNameValuePair("sid", sid));
			params.add(new BasicNameValuePair("passwd", passwd));
			params.add(new BasicNameValuePair("tel", toTel));
			params.add(new BasicNameValuePair("from", fromTel));
			params.add(new BasicNameValuePair("msg", msg));
			params.add(new BasicNameValuePair("rsvdate", sdf.format(rsvdate)));
			
			try {
				// Form Encoding 설정
				UrlEncodedFormEntity formEntity = new UrlEncodedFormEntity(params,"UTF-8");
				request.setEntity(formEntity);
				
				// Request
				HttpResponse response = client.execute(request);
				
				// Request 결과 처리
				InputStream in = response.getEntity().getContent();
				sb = getStringBufferByReading(in, "UTF-8");
			} catch (ClientProtocolException e) {
				// TODO Auto-generated catch block
				log.error(e.getMessage());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				log.error(e.getMessage());
			}
			
			return checkErrors(sb);
		}
		
		return false;
	}	
	private boolean checkErrors(StringBuffer resBf) {
		String res = resBf.toString().trim();
		log.debug( res );
		
		if(res.substring(0, 1).equals("E")) {
			if(res.equals("E11")) {
				setErrorMsg("sid Param Fail!");	
			}
			if(res.equals("E12")) {
				setErrorMsg("passwd Param Fail!");	
			}
			if(res.equals("E13")) {
				setErrorMsg("Access Deny!");	
			}
			
			if(res.equals("E01")) {
				setErrorMsg("toTel Param Fail!");	
			}
			if(res.equals("E02")) {
				setErrorMsg("fromTel Param Fail!");	
			}
			if(res.equals("E03")) {
				setErrorMsg("msg Param Fail!");	
			}
			if(res.equals("E04")) {
				setErrorMsg("Over Length! (Limit 80 byte)");	
			}
			
			return false;
		}else {
			setLimitCnt(Integer.parseInt( res.replaceAll("OK\\|", "").toString() ));
			return true;
		}		
	}
	
	private StringBuffer getStringBufferByReading(InputStream is, String encodeType) throws IOException{
	        StringBuffer sb = new StringBuffer();
	        BufferedReader br=null;
	        try{
	         br = new BufferedReader(new InputStreamReader(is,"UTF-8"));
	        String str = br.readLine();
	        while (str != null) {
	            sb.append(str + "\n");
	            str = br.readLine();
	        }
	        }finally{
	            closeAll(br,is);
	        }
	        //Log.d("mylog", sb.toString());
	        return sb;
	    }
	 
	    private void closeAll(BufferedReader br, InputStream in){
	        try {
	            if (br != null)
	                br.close();
	            if (in != null)
	                in.close();
	        } catch (IOException e) {
	        	log.error(e.getMessage());
	        }
	    }

		public void setLimitCnt(int limitCnt) {
			this.limitCnt = limitCnt;
		}

		public int getLimitCnt() {
			return limitCnt;
		}

		public void setErrorMsg(String errorMsg) {
			this.errorMsg = errorMsg;
		}

		public String getErrorMsg() {
			return errorMsg;
		}
}
