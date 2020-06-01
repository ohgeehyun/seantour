/**
 * @version 3.2.0.1
 */
package jnit.surem.message;

import java.io.UnsupportedEncodingException;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;

public class SuremUtil {
	public static Log log = LogFactory.getLog(SuremUtil.class);	
	private static final int msgSizeLimit = 88;
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
	/**
	 * 
	 * @param phone
	 * @info - 핸드폰 앞자리가 010,011,016,017,018,019를 제외한 나머지들은 return ""
	 *       - 핸드폰 자릿수가 10~11자릿수가 아니면 return ""
	 * @return arr[0] - 핸드폰 앞번호
	 		   arr[1] - 핸드폰 중간 번호
	  		   arr[2] - 핸드폰 끝 번호
	 */
	public static String[] replacePhone(String phone, String type){

		if(NullUtil.nullString(phone).equals("")){
			return null;
		}
		
		String tel0 = "";
		String tel1 = "";
		String tel2 = "";
		String[] phoneArr = new String[3];
		phone = phone.replace(" ", "").replace("-", "").replace(".", "");
		
		Pattern phoneChk = Pattern.compile("^(01){1,2}[0,1,6,7,8,9]{1}[0-9]{7,8}+$");
			
		if(!phone.equals("")){
			try{
				if(type.equals("to") && phone.length() > 9 || phoneChk.matcher(phone).matches()){
				
					tel0 = phone.substring(0,3);
					tel1 = phone.substring(3,phone.length()-4);
					tel2 = phone.substring(phone.length()-4, phone.length());
					
					phoneArr[0] = tel0;
					phoneArr[1] = tel1;
					phoneArr[2] = tel2;
					
				}else{
					if("true".equals(deDug)) log.debug("Err.SMS Phone Number : " + phone);
					return null;
				}
			} catch (NullPointerException e){
				if("true".equals(deDug)) log.debug("TryCath.SMS Phone Number : " + phone);
				return null;
			}catch(Exception e){
				if("true".equals(deDug)) log.debug("TryCath.SMS Phone Number : " + phone);
				return null;
			}
		}else{
			if("true".equals(deDug)) log.debug("Phone Number Null");
			return null;
		}
		return phoneArr;
	}
	
	public static String[] messageArrResult(String message) throws UnsupportedEncodingException{
		
		int msgMax = msgSizeLimit;
		
		int length = message.getBytes("euc-kr").length;
		int msgCount = (length)/msgMax;
		
		int tail = 0;
		
		tail = length-((msgCount)*msgMax);
		if(tail == 0 && msgCount > 0){
			msgCount--;
		}
		
		String[] arr = new String[msgCount+1];
		int strSize = 0;
		for(int i=0; i<=msgCount; i++){
			int k = (i+1)*msgSizeLimit;
			arr[i] = SuremUtil.strCut(message, null, k, msgMax, false, false).substring(strSize);
			strSize += arr[i].length();
		}
		
		return arr;
		
	}
	
	public static String strCut(String szText, String szKey, int nLength, int nPrev,boolean isNotag, boolean isAdddot){  // 문자열 자르기
		 
		String r_val = szText;
		int oF = 0, oL = 0, rF = 0, rL = 0; 
		int nLengthPrev = 0;
		/*
		Pattern p = Pattern.compile("<(/?)([^<>]*)?>", Pattern.CASE_INSENSITIVE);  // 태그제거 패턴
		   
		if(isNotag) {
			r_val = p.matcher(r_val).replaceAll("");
		}  // 태그 제거
		r_val = r_val.replaceAll("&amp;", "&");
		r_val = r_val.replaceAll("(!/|\r|\n|&nbsp;)", "");  // 공백제거
		*/
		try {
			
			byte[] bytes = r_val.getBytes("UTF-8");     // 바이트로 보관
			
			if(szKey != null && !szKey.equals("")) {
				
				nLengthPrev = (r_val.indexOf(szKey) == -1)? 0: r_val.indexOf(szKey);  // 일단 위치찾고
				nLengthPrev = r_val.substring(0, nLengthPrev).getBytes("MS949").length;  // 위치까지길이를 byte로 다시 구한다
				nLengthPrev = (nLengthPrev-nPrev >= 0)? nLengthPrev-nPrev:0;    // 좀 앞부분부터 가져오도록한다.
			
			}
			
			// x부터 y길이만큼 잘라낸다. 한글안깨지게.
			int j = 0;
			if(nLengthPrev > 0){
				while(j < bytes.length) {
					if((bytes[j] & 0x80) != 0) {
						oF+=2; rF+=3; 
							if(oF+2 > nLengthPrev) {
								break;
							} 
						j+=3;
					} else {
						if(oF+1 > nLengthPrev) {
							break;
						} 
						++oF; 
						++rF; 
						++j;
					}
				}
			}
			j = rF;
			while(j < bytes.length) {
				if((bytes[j] & 0x80) != 0) {
					if(oL+2 > nLength) {
						break;
					}
					oL+=2; rL+=3; j+=3;
				} else {
					if(oL+1 > nLength) {
						break;
					} 
					++oL; 
					++rL; 
					++j;
				}
			}
			r_val = new String(bytes, rF, rL, "UTF-8");  // charset 옵션
			
			if(isAdddot && rF+rL+3 <= bytes.length) {
				r_val+="...";
			}  // ...을 붙일지말지 옵션 
		
		} catch(UnsupportedEncodingException e){
			log.error(e.getMessage()); 
		}
		return r_val;
	}
	
	public static String smsGetDate(){
		String resultDate = "";
		
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		resultDate = format.format(Calendar.getInstance().getTime());
		
		return resultDate;
	}
	
	public static String smsGetTime(){
		String resultTime = "";
		
		SimpleDateFormat format = new SimpleDateFormat("HHmmss");
		resultTime = format.format(Calendar.getInstance().getTime());
		
		return resultTime;
	}

}
