/**
 * @version 3.2.0.1
 */
package jnit.mgov.module;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;
import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.mbrpackage.MbrpackageUtil;
import jnit.com.util.DBType;
import jnit.util.PathUtil;

public class JnitMgovUtil {

	public static Log log = LogFactory.getLog(JnitMgovUtil.class);
	
	/** 첨부 최대 파일 크기 지정 */
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    private static final int BUFFER_SIZE = 8192;
    
	private static final int msgSizeLimit = 80;
	private static final String changeName = "[성명]";
	
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
	
	public static JnitcmsmbrVO getLoginMember(){
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
		
		return loginVO;
	}
	
	private static JnitMgovService getService(){
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
		
		JnitMgovService jnitMgovService = (JnitMgovService) wContext.getBean("jnitmgovService");
		
		return jnitMgovService;
	}
	
	/**
	 * <b>SMS 전송 메소드</b><br /><br />
	 * <b>진행도 		:</b> MMS와 예약전송은 개발 구현중...<br /><br />
	 * <b>fromNm		:</b> 보내는 사람 이름 ( 직접 입력 또는 "defaultTel0~9" cms 설정에서 지정 가능 ) <br />
	 * <b>toNm			:</b> 받는 사람 이름 ( 직접 입력 또는 "defaultNm0~9" cms 설정에서 지정 가능 <br />
	 * <b>fromPhohe		:</b> 보내는 사람 번호 ( 직접 입력 또는 "defaultNm0~9" cms 설정에서 지정 가능 <br />&nbsp;&nbsp;<b>ㄴ</b> 숫자 8자 이상 <br />
	 * <b>toPhone		:</b> 받는 사람 번호 ( 직접 입력 또는 "defaultFromNm0~9" cms 설정에서 지정 가능 <br />&nbsp;&nbsp;<b>ㄴ</b> 숫자 10자 이상 ( 핸드폰 앞자리 010,011,016,017,018,019 만 가능) <br />
	 * <b>subject		:</b> 메세지 제목 ( LMS, MMS 보낼때만 사용 ) <br />
	 * <b>message		:</b> 메세지 내용 <br />
	 * <b>fixMsgType	:</b> SMS, LMS, AUTO ( AUTO는 메세지 길이에 따라 자동으로 SMS or LMS로 전환 ) <br />&nbsp;&nbsp;<b>ㄴ</b> null 일땐 SMS로 자동으로 전환 <br />
	 * <b>reserveDateTime :</b> 예약 전송은 아직 구현되어 있지 않음 <br /><br />
	 * @throws IOException 
	 */
	public static String sendMessage(String fromNm, String toNm, String fromPhone, String toPhone, String subject, String message, String fixMsgType, String reserveDateTime) throws IOException{
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		if(request.getSession().getAttribute("smsConfig") == null){		//SmsConfig 세션 체크 ( 중복으로 가져오는걸 방지 )
			JnitMgovUtil.getSmsProperties();
		}
		
		JnitMgovService jnitMgovService = JnitMgovUtil.getService();
		
		Properties smsConfig = (Properties)request.getSession().getAttribute("smsConfig");
		
		String smsId = NullUtil.nullString(smsConfig.getProperty("smsId"));					//SMS ID
		String smsPw = NullUtil.nullString(smsConfig.getProperty("smsPw"));					//SMS 패스워드
		String smsType = NullUtil.nullString(smsConfig.getProperty("smsType"));				//SMS 사용할 유형 		( MGOV, LTS 등 ... )
		String memberTypeUse = NullUtil.nullString(smsConfig.getProperty("memberTypeUse"));	//회원 유형 사용 여부 		( 사용 : Y, 비사용 : Y가 아닌 나머지값 )
		String memberType = NullUtil.nullString(smsConfig.getProperty("memberType"));			//회원 유형				( EX : 30020, 30021 )
		String loginMemberUse = NullUtil.nullString(smsConfig.getProperty("loginMemberUse"));		//로그인 회원 사용 여부 	( 사용 : Y, 비사용 : Y가 아닌 나머지값 )
		String smsMaxCount = NullUtil.nullString(smsConfig.getProperty("smsMaxCount"));		//SMS 분할 전송시 최대 분할 갯수
		
		String defaultTel0 = NullUtil.nullString(smsConfig.getProperty("defaultTel0"));		//보내는 사람의 기본으로 지정한 번호0
		String defaultTel1 = NullUtil.nullString(smsConfig.getProperty("defaultTel1"));		//보내는 사람의 기본으로 지정한 번호1
		String defaultTel2 = NullUtil.nullString(smsConfig.getProperty("defaultTel2"));		//보내는 사람의 기본으로 지정한 번호2
		String defaultTel3 = NullUtil.nullString(smsConfig.getProperty("defaultTel3"));		//보내는 사람의 기본으로 지정한 번호3
		String defaultTel4 = NullUtil.nullString(smsConfig.getProperty("defaultTel4"));		//보내는 사람의 기본으로 지정한 번호4
		String defaultTel5 = NullUtil.nullString(smsConfig.getProperty("defaultTel5"));		//보내는 사람의 기본으로 지정한 번호5
		String defaultTel6 = NullUtil.nullString(smsConfig.getProperty("defaultTel6"));		//보내는 사람의 기본으로 지정한 번호6
		String defaultTel7 = NullUtil.nullString(smsConfig.getProperty("defaultTel7"));		//보내는 사람의 기본으로 지정한 번호7
		String defaultTel8 = NullUtil.nullString(smsConfig.getProperty("defaultTel8"));		//보내는 사람의 기본으로 지정한 번호8
		String defaultTel9 = NullUtil.nullString(smsConfig.getProperty("defaultTel9"));		//보내는 사람의 기본으로 지정한 번호9
		
		String defaultNm0 = NullUtil.nullString(smsConfig.getProperty("defaultNm0"));			//보내는 사람의 기본으로 지정한 이름0
		String defaultNm1 = NullUtil.nullString(smsConfig.getProperty("defaultNm1"));			//보내는 사람의 기본으로 지정한 이름1
		String defaultNm2 = NullUtil.nullString(smsConfig.getProperty("defaultNm2"));			//보내는 사람의 기본으로 지정한 이름2
		String defaultNm3 = NullUtil.nullString(smsConfig.getProperty("defaultNm3"));			//보내는 사람의 기본으로 지정한 이름3
		String defaultNm4 = NullUtil.nullString(smsConfig.getProperty("defaultNm4"));			//보내는 사람의 기본으로 지정한 이름4
		String defaultNm5 = NullUtil.nullString(smsConfig.getProperty("defaultNm5"));			//보내는 사람의 기본으로 지정한 이름5
		String defaultNm6 = NullUtil.nullString(smsConfig.getProperty("defaultNm6"));			//보내는 사람의 기본으로 지정한 이름6
		String defaultNm7 = NullUtil.nullString(smsConfig.getProperty("defaultNm7"));			//보내는 사람의 기본으로 지정한 이름7
		String defaultNm8 = NullUtil.nullString(smsConfig.getProperty("defaultNm8"));			//보내는 사람의 기본으로 지정한 이름8
		String defaultNm9 = NullUtil.nullString(smsConfig.getProperty("defaultNm9"));			//보내는 사람의 기본으로 지정한 이름9
		
		String defaultFromNm0 = NullUtil.nullString(smsConfig.getProperty("defaultFromNm0"));		//받는 사람의 기본으로 지정한 이름0
		String defaultFromNm1 = NullUtil.nullString(smsConfig.getProperty("defaultFromNm1"));		//받는 사람의 기본으로 지정한 이름1
		String defaultFromNm2 = NullUtil.nullString(smsConfig.getProperty("defaultFromNm2"));		//받는 사람의 기본으로 지정한 이름2
		
		String result = null;											//결과값 초기화
		JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();			//회원정보 Load
		
		String mbrLogin = NullUtil.nullString(loginVO.getMbrLogin());	//회원 ID
		String mbrId 	= NullUtil.nullString(loginVO.getMbrId());		//회원 고유값
		String mbrType	= NullUtil.nullString(loginVO.getTypeId());		//회원 유형
		
		/** 로그인 회원 사용여부 */
		if(loginMemberUse.equals("Y")){

			String memberCheck = "";
			try {
				memberCheck = MbrpackageUtil.getMbrpackageResult("PACK_00003 ");
			} catch (NullPointerException e){
				log.error(e.getMessage());
				memberCheck = "N";
			} catch (Exception e) {
				log.error(e.getMessage());
				memberCheck = "N";
			}
			
			/* 조건1. 로그인 유저
			if(loginVO == null){
				log.debug("Err.1 Not Login User");
				return "Err.1";
			}
			 */
			
			/* 조건2. 회원ID와 회원고유값이 존재해야 한다. */
			if(mbrLogin.equals("") || mbrId.equals("")){
				if("true".equals(deDug)) log.debug("Err.2 Not Exist User");
				return "Err.2";
			}else if(memberTypeUse.equals("Y") && !memberCheck.equals("Y")){
				if("true".equals(deDug)) log.debug("Err.3 Not Include Member Type");
				return "Err.3";
			}
			
		}
		
		/** 메세지 전송 프로세스 */
		
		fromNm			= NullUtil.nullString(fromNm);
		toNm			= NullUtil.nullString(toNm);
		toPhone			= NullUtil.nullString(toPhone);
		fromPhone		= NullUtil.nullString(fromPhone);
		subject			= NullUtil.nullString(subject);
		message			= NullUtil.nullString(message);
		fixMsgType		= NullUtil.nullString(fixMsgType);
		reserveDateTime	= NullUtil.nullString(reserveDateTime);
		
		/* 메세지 전송요소 필수 항목 체크 */
		if(toPhone.equals("")){								//받는사람 핸드폰 번호
			if("true".equals(deDug)) log.debug("Err.4 Not Exist fromPhone");
			return "Err.4";
		}else if(message.equals("")){							//메세지 내용
			if("true".equals(deDug)) log.debug("Err.5 Not Exist message");
			return "Err.5";
		}
		
		/* fixMsgType 메세지 타입이 없으면 기본 설정 */
		if(fixMsgType.equals("")){
			fixMsgType = "SMS";
		}else if(fixMsgType.toUpperCase().equals("SMS")){
			fixMsgType = "SMS";
		}else if(fixMsgType.toUpperCase().equals("LMS")){
			fixMsgType = "LMS";
		}else if(fixMsgType.toUpperCase().equals("MMS")){
			fixMsgType = "MMS";
		}else if(fixMsgType.toUpperCase().equals("AUTO")){
			fixMsgType = "AUTO";
		}else{
			if("true".equals(deDug)) log.debug("Err. fixMsgType : " + fixMsgType);
			fixMsgType = "SMS";
		}
		
		/* 기본설정의 이름을 가져온다. ( 보내는 사람의 이름 ) */
		if(toNm.equals("") || toNm.indexOf("defaultNm") != -1){
			
			if(toNm.equals("")){
				toNm = defaultNm0;
			}else if(toNm.equals("defaultNm0")){
				toNm = defaultNm0;
			}else if(toNm.equals("defaultNm1")){
				toNm = defaultNm1;
			}else if(toNm.equals("defaultNm2")){
				toNm = defaultNm2;
			}else if(toNm.equals("defaultNm3")){
				toNm = defaultNm3;
			}else if(toNm.equals("defaultNm4")){
				toNm = defaultNm4;
			}else if(toNm.equals("defaultNm5")){
				toNm = defaultNm5;
			}else if(toNm.equals("defaultNm6")){
				toNm = defaultNm6;
			}else if(toNm.equals("defaultNm7")){
				toNm = defaultNm7;
			}else if(toNm.equals("defaultNm8")){
				toNm = defaultNm8;
			}else if(toNm.equals("defaultNm9")){
				toNm = defaultNm9;
			}else{
				toNm = "";
			}
			
		}
		
		/* 기본설정의 번호를 가져온다. ( 보내는 사람의 번호 ) */
		if(fromPhone.equals("") || fromPhone.indexOf("defaultTel") != -1){
			
			if(fromPhone.equals("")){
				fromPhone = defaultTel0;
			}else if(fromPhone.equals("defaultTel0")){
				fromPhone = defaultTel0;
			}else if(fromPhone.equals("defaultTel1")){
				fromPhone = defaultTel1;
			}else if(fromPhone.equals("defaultTel2")){
				fromPhone = defaultTel2;
			}else if(fromPhone.equals("defaultTel3")){
				fromPhone = defaultTel3;
			}else if(fromPhone.equals("defaultTel4")){
				fromPhone = defaultTel4;
			}else if(fromPhone.equals("defaultTel5")){
				fromPhone = defaultTel5;
			}else if(fromPhone.equals("defaultTel6")){
				fromPhone = defaultTel6;
			}else if(fromPhone.equals("defaultTel7")){
				fromPhone = defaultTel7;
			}else if(fromPhone.equals("defaultTel8")){
				fromPhone = defaultTel8;
			}else if(fromPhone.equals("defaultTel9")){
				fromPhone = defaultTel9;
			}else{
				fromPhone = "";
			}
			
		}
		
		/* 기본설정의 받는사람 이름을 가져온다. */
		if(fromNm.equals("") || fromNm.indexOf("defaultFromNm") != -1){
			
			if(fromNm.equals("")){
				fromNm = defaultFromNm0;
			}else if(fromNm.equals("defaultFromNm0")){
				fromNm = defaultFromNm0;
			}else if(fromNm.equals("defaultFromNm1")){
				fromNm = defaultFromNm1;
			}else if(fromNm.equals("defaultFromNm2")){
				fromNm = defaultFromNm2;
			}
			
		}
		
		/* 보내는 사람의 번호 무결성 검사 */
		fromPhone = JnitMgovUtil.replacePhone(fromPhone, "from");
		if(fromPhone == null){
			if("true".equals(deDug)) log.debug("Err.6 fromPhone Number Error");
			return "Err.6";
		}
		
		/* 받는 사람의 번호 무결성 검사 */
		toPhone = JnitMgovUtil.replacePhone(toPhone, "to");
		if(toPhone == null){
			if("true".equals(deDug)) log.debug("Err.7 toPhone Number Error");
			return "Err.7";
		}
		
		/* [성명]단어를 받는사람 이름으로 변환 */
		if(message.indexOf(changeName) != -1){
			message = message.replace(changeName, toNm);
		}
		
		String[] msgArr = null;
		try {
			msgArr = JnitMgovUtil.messageArrResult(message);
		} catch (UnsupportedEncodingException e1) {
			log.error(e1.getMessage());
			if("true".equals(deDug)) log.debug("Err.8 Message Spliting Error");
			return "Err.8";
		}
		int msgSendLimit = 1;
		
		if(fixMsgType.equals("AUTO")){
			
			Pattern msgPt = Pattern.compile("\\[성명\\]");
			Matcher msgMc = msgPt.matcher(message);
			int count = 0;
			for(int i=0; msgMc.find(i); i=msgMc.end()){
				count++;
			}
			
			int msgByteChk = 0;
			
			try {
				msgByteChk = message.getBytes("euc-kr").length + (count*2);
			} catch (UnsupportedEncodingException e) {
				log.error(e.getMessage());
			}
			
			if(msgByteChk <= 80){
				fixMsgType = "SMS";
			}else{
				fixMsgType = "LMS";
			}
			
		}
		
		/*
		if(fixMsgType.equals("AUTO")){
			if(msgArr.length > Integer.parseInt(smsMaxCount)){
				msgSendLimit = Integer.parseInt(smsMaxCount);
			}else{
				msgSendLimit = msgArr.length;
			}
		}
		*/
		
		
		
		try{
			
			if(smsType.equals("mgov")){
				
				if(fixMsgType.equals("SMS")){
					for(int i=0; i<msgSendLimit; i++){
						
						/* Insert문 삽입. */
						
						int contSeq = 0;
						if(DBType.getDbTypeBoolean("cubrid") || DBType.getDbTypeBoolean("oracle")|| DBType.getDbTypeBoolean("tibero")){
							contSeq = jnitMgovService.getMgovNextId();	//CUBRID or ORACLE 전용
						}else if(DBType.getDbTypeBoolean("mysql")){
							jnitMgovService.updateMgovSeq();
							contSeq = jnitMgovService.getMgovSeq();
						}
						
						JnitMsgdataVO vo = new JnitMsgdataVO();
							vo.setMsgSeq(contSeq);
							vo.setCurState(0);
							vo.setCallTo(toPhone);
							vo.setCallFrom(fromPhone);
							vo.setSmsTxt(msgArr[i]);
							vo.setMsgType(4);			//4 - SMS
							
						jnitMgovService.insertJnitmgov(vo);
					}
				}else if(fixMsgType.equals("LMS")){
					
					int contSeq = 0;
					if(DBType.getDbTypeBoolean("cubrid") || DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
						contSeq = jnitMgovService.getMgovNextId();	//CUBRID or ORACLE 전용
					}else if(DBType.getDbTypeBoolean("mysql")){
						jnitMgovService.updateMgovSeq();
						contSeq = jnitMgovService.getMgovSeq();
					}
					
					JnitMmsContentsInfoVO mmsVO = new JnitMmsContentsInfoVO();
						mmsVO.setContSeq(contSeq);
						mmsVO.setFileCnt(1);
						mmsVO.setMmsSubject(subject);
						mmsVO.setMmsBody(message);
						mmsVO.setServiceDep1("ALL");
					
					JnitMsgdataVO vo = new JnitMsgdataVO();
						vo.setContSeq(contSeq);
						vo.setMsgSeq(contSeq);
						vo.setCurState(0);
						vo.setCallTo(toPhone);
						vo.setCallFrom(fromPhone);
						vo.setMsgType(6);				//6 - LMS
						
					jnitMgovService.insertJnitmgov(vo);
					jnitMgovService.insertJnitmgovMMS(mmsVO);
					
				}else if(fixMsgType.equals("MMS")){
					
				}
			}else if(smsType.equals("ltskorea")){
				
				StringBuffer sb = null;
				String smsResult = "";
				
				String url = "http://"+"ltskorea.co.kr"+"/smsApi/request.php";
				
				/* ltskorea 모듈에서는 sms 분할전송 */
				if(msgArr.length > Integer.parseInt(smsMaxCount)){
					msgSendLimit = Integer.parseInt(smsMaxCount);
				}else{
					msgSendLimit = msgArr.length;
				}
				
				ArrayList<BasicNameValuePair> params = new ArrayList<BasicNameValuePair>();
				String msg = "";
				for(int i=0; i<msgSendLimit; i++){
					
					msg = msgArr[i].toString().trim();
					
					HttpClient client = new DefaultHttpClient();
					HttpPost ltsRequest = new HttpPost(url);
					
					params = new ArrayList<BasicNameValuePair>();
					params.add(new BasicNameValuePair("sid", "ltskorea"));
					params.add(new BasicNameValuePair("passwd", "gusdnd75"));
					params.add(new BasicNameValuePair("tel", toPhone));
					params.add(new BasicNameValuePair("from", fromPhone));
					params.add(new BasicNameValuePair("msg", msg));
				
				
					try {
						// Form Encoding 설정
						UrlEncodedFormEntity formEntity = new UrlEncodedFormEntity(params,"UTF-8");
						ltsRequest.setEntity(formEntity);
						
						// Request
						HttpResponse response = client.execute(ltsRequest);
						
						// Request 결과 처리
						InputStream in = response.getEntity().getContent();
						sb = getStringBufferByReading(in, "UTF-8");
					} catch (ClientProtocolException e) {
						log.error(e.getMessage());
						result = "Err. ClientProtocolException";
					} catch (IOException e) {
						log.error(e.getMessage());
						result = "Err. IOException";
					}
					
					if(sb.indexOf("OK") != -1){
						smsResult = "0";		//성공
					}else{
						smsResult = "1";		//실패
					}
					
					int contSeq = 0;
					if(DBType.getDbTypeBoolean("cubrid") || DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
						contSeq = jnitMgovService.getMgovNextId();	//CUBRID or ORACLE 전용
					}else if(DBType.getDbTypeBoolean("mysql")){
						jnitMgovService.updateMgovSeq();
						contSeq = jnitMgovService.getMgovSeq();
					}
					
					JnitMsgdataVO vo = new JnitMsgdataVO();
					vo.setMsgSeq(contSeq);
					vo.setCurState(0);
					vo.setCallTo(toPhone);
					vo.setCallFrom(fromPhone);
					vo.setSmsTxt(msgArr[i].toString().trim());
					vo.setRsltCode2(smsResult);
					vo.setMsgType(4);			//4 - SMS
					
					jnitMgovService.insertJnitLtskoreaSms(vo);
				}
				
				return result;
				
			}
		} catch (IOException e){
			log.error(e.getMessage());
			if("true".equals(deDug)) log.debug("Err.9 Send Message Error");
			return "Err.9";
		}catch(Exception e){
			log.error(e.getMessage());
			if("true".equals(deDug)) log.debug("Err.9 Send Message Error");
			return "Err.9";
		}
		
		return result;
	}
	
	
	/**
	 * 
	 * @param phone
	 * @info - 핸드폰 앞자리가 010,011,016,017,018,019를 제외한 나머지들은 return ""
	 *       - 핸드폰 자릿수가 10~11자릿수가 아니면 return ""
	 * @return arr[0] - 핸드폰 앞번호
	 		   arr[1] - 핸드폰 중간 번호
	  		   arr[2] - 핸드폰 끝 번호
	 */
	public static String replacePhone(String phone, String type){

		if(NullUtil.nullString(phone).equals("")){
			return null;
		}
		
		String tel0 = "";
		String tel1 = "";
		String tel2 = "";
		String resultPhone = "";
		phone = phone.replace(" ", "").replace("-", "").replace(".", "");
		
		Pattern phoneChk = Pattern.compile("^(01){1,2}[0,1,6,7,8,9]{1}[0-9]{7,8}+$");
			
		if(!phone.equals("")){
			try{
				if(type.equals("from") && phone.length() > 8 || phoneChk.matcher(phone).matches()){
				
					tel0 = phone.substring(0,3);
					tel1 = phone.substring(3,phone.length()-4);
					tel2 = phone.substring(phone.length()-4, phone.length());
					
					resultPhone = tel0 + tel1 + tel2;  
					
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
		return resultPhone;
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
			arr[i] = JnitMgovUtil.strCut(message, null, k, msgMax, false, false).substring(strSize);
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
	
	public static void getSmsProperties() throws IOException{
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	String smsPropPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/smsProp.prop";
		
		Properties smsProp = new Properties();
		File smsPropFile = new File(smsPropPath);
		InputStreamReader isr = null;
		FileInputStream fis = null;
		if(smsPropFile.exists()){
			try {
				fis = new FileInputStream(smsPropFile);
				isr = new InputStreamReader(fis, "UTF-8");
			} catch (IOException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			
			try {
				smsProp.load(isr);
			} catch (IOException e) {
				log.error(e.getMessage());
				smsProp = new Properties();
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
			
			request.getSession().setAttribute("smsConfig", smsProp);
			
		}
	}
	
	public static String getSmsType() throws IOException{
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	String smsPropPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/smsProp.prop";
		
		Properties smsProp = new Properties();
		File smsPropFile = new File(smsPropPath);
		InputStreamReader isr = null;
		FileInputStream fis = null;
		if(smsPropFile.exists()){
			try {
				fis = new FileInputStream(smsPropFile);
				isr = new InputStreamReader(fis, "UTF-8");
			} catch (IOException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			
			try {
				smsProp.load(isr);
			} catch (IOException e) {
				log.error(e.getMessage());
				smsProp = new Properties();
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
		}
		return smsProp.getProperty("smsType");
	}
	
	public static void initSmsProp(){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		request.getSession().setAttribute("smsConfig", null);
	}
	
	/* upload function */
    public static String uploadFormWorkFiles(String where, HttpServletRequest request) throws Exception {
    	
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest)request;
	
		String result = "";
		final Map<String, MultipartFile> files = mptRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
		    MultipartFile mFile = entry.getValue(); // mptRequest.getFile((String)fileIter.next());
	
		    EgovFormBasedFileVo vo = new EgovFormBasedFileVo();
	
		    String tmp = mFile.getOriginalFilename();
		    String ext = tmp.substring(tmp.lastIndexOf("."));
		    
		    if(ext.equals(".xls") || ext.equals(".xlsx")){
	
		    	result = ext;
	            if (tmp.lastIndexOf("\\") >= 0) {
	        	tmp = tmp.substring(tmp.lastIndexOf("\\") + 1);
	            }
	
	            vo.setFileName(tmp);
	            vo.setSize(mFile.getSize());
	
	            if (tmp.lastIndexOf(".") >= 0) {
	       	 	vo.setPhysicalName(vo.getPhysicalName() + tmp.substring(tmp.lastIndexOf(".")));
	            }
	
	            if (mFile.getSize() > 0) {
	            	saveFile(mFile.getInputStream(), new File(EgovWebUtil.filePathBlackList(where)));
	            }
			}
		}
		
		return result;
    }
    
    public static long saveFile(InputStream is, File file) throws IOException {
    	// 디렉토리 생성
    	File parentFile = file.getParentFile();
    	if (parentFile != null && ! parentFile.exists()) {
    		parentFile.mkdirs();
    	}

    	OutputStream os = null;
    	long size = 0L;

    	try {
    	    os = new FileOutputStream(file);

    	    int bytesRead = 0;
    	    byte[] buffer = new byte[BUFFER_SIZE];

    	    while ((bytesRead = is.read(buffer, 0, BUFFER_SIZE)) != -1) {
    		size += bytesRead;
    		os.write(buffer, 0, bytesRead);
    	    }
    	} finally {
    	    if (os != null) {
    		os.close();
    	    }
    	}

    	return size;
    } 
    
    public static HashMap<String,List<String>> fileToMap(String path) throws FileNotFoundException, IOException{
    	
    	File filePath = new File(path);
    	FileInputStream fis = null;
    	HashMap<String,List<String>> resultMap = new HashMap<String,List<String>>();
    	List<String> nameList = new ArrayList<String>();
    	List<String> phoneList = new ArrayList<String>();
    	try {
    		fis = new FileInputStream(filePath);
        	XSSFWorkbook workbook = new XSSFWorkbook(fis);
        	XSSFSheet sheet = workbook.getSheetAt(0);
        	
        	int rows = sheet.getPhysicalNumberOfRows();
        	int cells = sheet.getRow(0).getPhysicalNumberOfCells();
        	
        	String value = "";
        	
        	if(rows >= 2){
        		for(int i=1; i<rows; i++){
        			XSSFRow row = sheet.getRow(i);
        			if(row != null || !"".equals(row.getCell(0).getStringCellValue())){
        				for(int c=0; c<cells; c++){
        					XSSFCell cell = row.getCell(c);
        					if(cell != null){
    							switch(cell.getCellType()){
    							case XSSFCell.CELL_TYPE_FORMULA:
    	                            value=cell.getCellFormula();
    	                            break;
    	                        case XSSFCell.CELL_TYPE_NUMERIC:
    	                            value=""+cell.getNumericCellValue();
    	                            break;
    	                        case XSSFCell.CELL_TYPE_STRING:
    	                            value=""+cell.getStringCellValue();
    	                            break;
    	                        case XSSFCell.CELL_TYPE_BLANK:
    	                            value=""+cell.getBooleanCellValue();
    	                            //value="";
    	                            break;
    	                        case XSSFCell.CELL_TYPE_ERROR:
    	                            value=""+cell.getErrorCellValue();
    	                            break;
    	                        case XSSFCell.CELL_TYPE_BOOLEAN:
    	                        	value=""+cell.getBooleanCellValue();
    	                        	break;
    	                        default:
    							}
        					}
        					if(c == 0){
        						nameList.add(value);
        					}else if(c == 1){
        						phoneList.add(value);
        					}
        				}
        			}
        		}
        	}
    	} catch (IOException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		} finally {
			if(fis != null){
				fis.close();
			}
		}
		resultMap.put("nameList", nameList);
    	resultMap.put("phoneList", phoneList);
    	return resultMap;
    }
    
    private static StringBuffer getStringBufferByReading(InputStream is, String encodeType) throws IOException{
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
    
    private static void closeAll(BufferedReader br, InputStream in){
        try {
            if (br != null)
                br.close();
            if (in != null)
                in.close();
        } catch (IOException e) {
        	//log.error(e.getMessage());
        }
    }
}