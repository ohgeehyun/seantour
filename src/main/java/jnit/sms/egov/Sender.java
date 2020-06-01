/**
 * @version 3.2.0.1
 */
/***************************************
* 최종 수정일자 : 2008-08-25
* 파일 : SenderExample.java
****************************************/
package jnit.sms.egov;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.com.cmm.service.EgovProperties;
import x3.client.smeapi.SMEConnection;
import x3.client.smeapi.SMEConnectionFactory;
import x3.client.smeapi.SMEException;
import x3.client.smeapi.SMERequest;
import x3.client.smeapi.SMEResponse;
import x3.client.smeapi.SMESender;
import x3.client.smeapi.SMESession;
import x3.client.smeapi.impl.SMEConfig;
import x3.client.smeapi.impl.SMEConnectionFactoryImpl;
import x3.client.smeapi.impl.SMELogger;

public class Sender {
	private Log log = LogFactory.getLog(getClass());
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
	public static final String SEPERATOR = File.separator;
	
	// Single SMG server
	// final static String connstring = "sme://127.0.0.1:9090";
	//신규 버젼에서는 SMEConfig.
	String connstring = "sme://000.000.000.131:20000";
	String smsId = "test";
	String smsPwd = "test";

	SMEConnectionFactory factSender = null;
	SMEConnection connSender = null;
	SMESession sessSender = null;
	SMESender sender = null;

	public Sender(String smeConfigPath) throws Exception {
		if(smeConfigPath != null) {
			SMEConfig.configSet(smeConfigPath);
			this.readPropertyFile();
			
			connstring = SMEConfig.getSmsUrl();
			smsId = SMEConfig.getSmsId();
			smsPwd = SMEConfig.getSmsPwd();
			
			if("true".equals(deDug)) log.debug("smsId : " + smsId + "\n" + "smsPwd : " + smsPwd);
			
			writeLog("smsId : " + smsId);
			writeLog("smsPwd : " + smsPwd);
			
			
		}
	}

	public void senderOpen() throws SMEException {		
		this.factSender = new SMEConnectionFactoryImpl(connstring);
		this.connSender = factSender.createConnection(smsId, smsPwd); // 아이디와 패스워드입니다.
		this.sessSender = connSender.createSession();
		this.sender = sessSender.createSender();
		// 현재 발송한 호에 대해서 리포트 수신을 위해서는 true 로 설정해야
		// 리포트 수신을 할 수 있다. 만약 false 로 세팅하고 발송을 하면
		// 현재 발송한 호에 대해서는 결과수신을 할 수 없다.
		// 리포트가 필요없는 기관에서는 아래 디폴트값인 false를 유지한다.
		// false 로 설정을 하면 보내는 메시지에 대해서 결과를 수신할 수 없습니다.
		//-- [2008-08-25] -- 리포트 수신 필수조건으로 변경
		this.sessSender.setReceiverCreated(true);
		this.connSender.start();
	}

	//연결,세션생성
	public void senderClose() {
		try {
			if (sender != null)
				sender.close();
		} catch (SMEException e) {
			log.error(e.getMessage());
		}

		try {
			if (sessSender != null)
				sessSender.close();
		} catch (SMEException e) {
			log.error(e.getMessage());
		}

		try {
			if (connSender != null)
				connSender.close();
		} catch (SMEException e) {
			log.error(e.getMessage());
		}
	}

    public int sendText(String callto, String callback, String msg)
    {
    	String msgid = System.currentTimeMillis()+"";
    	String callbackurl = "";
    	SMERequest request = null;
    	
    	int nRes = 0;
    	
        try
        {
            //================================================================================//
            // 메시지 처리과정 순서 (출발지 : 기관  ,  목적지: 센터SMS G/W )
            //1.기관   : 메시지 전송요청        -> 센터SMS: 번호 및 메시지 형식확인
            //2.센터SMS: 이통사로 전달          -> 이통사 : 번호 및 메시지 형식확인
            //3.이통사 : 폰에 메시지 전송      <-> Phone  :실제수신전화 에서 응답
            //4.이통사 : 발신결과 값 전송       -> 센터SMS: 이통사 처리결과 값 수신 처리
            //5.센터SMS: 기관에 발신결과 전송   -> 기관   : 최종 전송 결과 수신 처리
            //6.메시지 처리 종료
            //================================================================================//
            request = sessSender.createRequest();  //객체 생성
            request.setTo(callto);  //수신번호  // destination
            request.setFrom(callback); //발신번호(회신번호) // request.setCallback(callback); //회신번호
            request.setCallbackURL(callbackurl); //CallbackURL 은 선택사항 입니다.
            //**********************************************************ㅁㅊㅊㄷㄴㄴ766***************
            // callbackurl (스마트폰 미지원)
            // - 무선인터넷 주소  휴대전화 인터넷 (WAP) 페이지 접속용 URL
            // - 단문자메시지 외의 별도 과금이 되므로 WAP 페이지가 있는 기관에서만 사용
            // - 수신자가 해당 URL 접속시 데이타 요금으로  과금 되므로 주의.
            // - 콜백url을 보낼때는 본문 포함 전체 90byte를 초과 하면 안됨
            //*************************************************************************
            request.setText(msg); // message (메시지내용) 80 byte 이하

			// serial *MUST* be unique number in single SME.
			// 반드시 메시지 발송시 연속되는 일련번호 형식을 띈 고유값이어야 함
			// SMS G/W로 전송누적 일련번호
			// 예) 'TestMessage-000000' 숫자 또는 문자 + 숫자로 조합 가능 ( 39 byte )
			// 예) '200808251259590001'
			//request.setMessageId("MgovTest" + msgid );

			if (msgid.length() <= 39) {
				request.setMessageId(msgid);   //일련번호 고유값
            // serial *MUST* be unique number in single SME.
            // 반드시 메시지 발송시 연속되는 일련번호 형식을 띈 고유값이어야 함
            // 이 값은 기관으로 되돌려주는 값으로 식별번호
            // SMS G/W로 전송누적 되는 일련번호(숫자)
			//****** 중요 반드시 40byte 미만으로 생성*********
            // 예) '200808251259590001'(권장)
            // 예) 'TestMessage-000000' 숫자 또는 문자 + 숫자로 조합 가능 ( 40 byte 미만, 권장38 byte 이하 숫자 )
            // request.setMessageId("MgovTest" + msgid );

				sender = sessSender.createSender();
				SMEResponse res = sender.send(request);
			
				nRes = res.getResult(); //결과코드 수신
            //==========================================================================================//
            // G/W 전달 결과 확인(기관에서 센터로 전송되었는지에 대한 결과 , 휴대전화 수신 결과와는  무관)
            //==========================================================================================//
            // 결과 값 수신  Sender에서의 SMS G/W 로 전송한 메시지형식에 따른 결과값 수신
            // 코드 :  '0' = 성공 , 이외의 코드 오류 코드 참조 (G/W로 전송 성공을 의미)
            // 예)5000 : 접속실패, 3000 :착발신 포멧오류, 4005: 스팸처리 거부,
            //==========================================================================================//
            //log.debug("Send Result : " + nRes);  // 전송 결과 ( 기관-> SMS G/W)
			} else {
				if("true".equals(deDug)) log.debug("Send Result : msgid length 에러 ( 39byte 미만 가능 ");  //주석
			}

		}
		catch (SMEException e)
		{
			writeLog(e.getMessage());
			log.error(e.getMessage());
		}
		writeLog("Result : " + nRes);
		return nRes;
    }
    
    public void testSimpleText(String msgid, String callto,String callback, String msg, String callbackurl )
    {
        SMERequest request = null;
        try
        {
            //================================================================================//
            // 메시지 처리과정 순서 (출발지 : 기관  ,  목적지: 센터SMS G/W )
            //1.기관   : 메시지 전송요청        -> 센터SMS: 번호 및 메시지 형식확인
            //2.센터SMS: 이통사로 전달          -> 이통사 : 번호 및 메시지 형식확인
            //3.이통사 : 폰에 메시지 전송      <-> Phone  :실제수신전화 에서 응답
            //4.이통사 : 발신결과 값 전송       -> 센터SMS: 이통사 처리결과 값 수신 처리
            //5.센터SMS: 기관에 발신결과 전송   -> 기관   : 최종 전송 결과 수신 처리
            //6.메시지 처리 종료
            //================================================================================//
            request = sessSender.createRequest();  //객체 생성
            request.setTo(callto);  //수신번호  // destination
            request.setFrom(callback); //발신번호(회신번호) // request.setCallback(callback); //회신번호
            request.setCallbackURL(callbackurl); //CallbackURL 은 선택사항 입니다.
            //**********************************************************ㅁㅊㅊㄷㄴㄴ766***************
            // callbackurl (스마트폰 미지원)
            // - 무선인터넷 주소  휴대전화 인터넷 (WAP) 페이지 접속용 URL
            // - 단문자메시지 외의 별도 과금이 되므로 WAP 페이지가 있는 기관에서만 사용
            // - 수신자가 해당 URL 접속시 데이타 요금으로  과금 되므로 주의.
            // - 콜백url을 보낼때는 본문 포함 전체 90byte를 초과 하면 안됨
            //*************************************************************************
            request.setText(msg); // message (메시지내용) 80 byte 이하

			// serial *MUST* be unique number in single SME.
			// 반드시 메시지 발송시 연속되는 일련번호 형식을 띈 고유값이어야 함
			// SMS G/W로 전송누적 일련번호
			// 예) 'TestMessage-000000' 숫자 또는 문자 + 숫자로 조합 가능 ( 39 byte )
			// 예) '200808251259590001'
			//request.setMessageId("MgovTest" + msgid );

			if (msgid.length() <= 39) {
				request.setMessageId(msgid);   //일련번호 고유값
            // serial *MUST* be unique number in single SME.
            // 반드시 메시지 발송시 연속되는 일련번호 형식을 띈 고유값이어야 함
            // 이 값은 기관으로 되돌려주는 값으로 식별번호
            // SMS G/W로 전송누적 되는 일련번호(숫자)
			//****** 중요 반드시 40byte 미만으로 생성*********
            // 예) '200808251259590001'(권장)
            // 예) 'TestMessage-000000' 숫자 또는 문자 + 숫자로 조합 가능 ( 40 byte 미만, 권장38 byte 이하 숫자 )
            // request.setMessageId("MgovTest" + msgid );

				sender = sessSender.createSender();
				SMEResponse res = sender.send(request);
            int nRes = res.getResult(); //결과코드 수신
            //==========================================================================================//
            // G/W 전달 결과 확인(기관에서 센터로 전송되었는지에 대한 결과 , 휴대전화 수신 결과와는  무관)
            //==========================================================================================//
            // 결과 값 수신  Sender에서의 SMS G/W 로 전송한 메시지형식에 따른 결과값 수신
            // 코드 :  '0' = 성공 , 이외의 코드 오류 코드 참조 (G/W로 전송 성공을 의미)
            // 예)5000 : 접속실패, 3000 :착발신 포멧오류, 4005: 스팸처리 거부,
            //==========================================================================================//
            if("true".equals(deDug)) log.debug("Send Result : " + nRes);  // 전송 결과 ( 기관-> SMS G/W)
			} else {
				if("true".equals(deDug)) log.debug("Send Result : msgid length 에러 ( 39byte 미만 가능 ");  //주석
			}

		}
		catch (SMEException e)
		{
			log.error(e.getMessage());
		}
	}

	//	Config 파일내용읽기
	public void readPropertyFile() {

		String tmp = SMEConfig.getSmsUrl();

		if (tmp != null && !tmp.equals("")) {
			connstring = tmp;
			//log.debug(tmp);
		}

		tmp = SMEConfig.getSmsId();
		if (tmp != null && !tmp.equals("")) {
			smsId = tmp;
			//log.debug(tmp);
		}

		tmp = SMEConfig.getSmsPwd();
		if (tmp != null && !tmp.equals("")) {
			smsPwd = tmp;
			//log.debug(tmp);
		}

		tmp = SMEConfig.getLogLevel();
		if (tmp != null && !tmp.equals("")) {
			SMELogger.setLogLevel(tmp);
			//log.debug(tmp);
		}

		tmp = SMEConfig.getLogLayout();
		if (tmp != null && !tmp.equals("")) {
			SMELogger.setLogLayout(tmp);
			//log.debug(tmp);
		}

		tmp = SMEConfig.getLogPath();
		if (tmp != null && !tmp.equals("")) {
			SMELogger.setLogPath(tmp);
			//log.debug(tmp);
		}

		SMELogger.setUseConsoleLogger(SMEConfig.getUseConsoleLogger());
		SMELogger.setUseFileLogger(SMEConfig.getUseFileLogger());
	}

	private StringBuffer times;
    private String getDate()
    {
    	Calendar calendar = Calendar.getInstance();
    	
    	times = new StringBuffer();
        times.append(Integer.toString(calendar.get(Calendar.YEAR)));
		if((calendar.get(Calendar.MONTH)+1)<10)
        { 
            times.append("0"); 
        }
		times.append(Integer.toString(calendar.get(Calendar.MONTH)+1));
		if((calendar.get(Calendar.DATE))<10) 
        { 
            times.append("0");	
        } 
		times.append(Integer.toString(calendar.get(Calendar.DATE)));
    	
    	return times.toString();
    }
    
    private String getTime()
    {
    	Calendar calendar = Calendar.getInstance();
    	
    	times = new StringBuffer();

    	times.append("[");
    	if((calendar.get(Calendar.HOUR_OF_DAY))<10) 
        { 
            times.append("0"); 
        } 
 		times.append(Integer.toString(calendar.get(Calendar.HOUR_OF_DAY)));
 		times.append(":");
 		if((calendar.get(Calendar.MINUTE))<10) 
        { 
            times.append("0"); 
        }
 		times.append(Integer.toString(calendar.get(Calendar.MINUTE)));
 		times.append(":");
 		if((calendar.get(Calendar.SECOND))<10) 
        { 
            times.append("0"); 
        }
 		times.append(Integer.toString(calendar.get(Calendar.SECOND)));
 		times.append("]");
 		
 		return times.toString();
    }
    private void writeLog(String msg)
    {
    	try{
    	if (EgovProperties.getProperty("Globals.SMS.log").equals("true")){
	    	String file_path = EgovProperties.getProperty("Globals.fileStorePath") + SEPERATOR + "_log" + SEPERATOR;
	        File file = new File(file_path);
	        file.mkdir();
	
	        FileWriter file2 = new FileWriter(file_path+"smsLog_"+getDate()+".log", true);
	
	
	        file2.write("\n************************************************\n");
	        file2.write("Call time : " + getTime() +"\n");
	        file2.write(msg);
	
	        file2.close();
    	}
    	} catch (IOException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
    }
}