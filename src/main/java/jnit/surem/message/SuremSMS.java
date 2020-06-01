/**
 * @version 3.2.0.1
 */
package jnit.surem.message;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.sms.data.SmsdataService;
import jnit.sms.data.SmsdataVO;

public class SuremSMS {

	public static Log log = LogFactory.getLog(SuremSMS.class);
	
	private static final String defaultPhone = EgovProperties.getProperty("Globals.surem.defaultPhone");
	private static final int memberId = Integer.parseInt(EgovProperties.getProperty("Globals.surem.memberId"));
	private static final String userId = EgovProperties.getProperty("Globals.surem.userId");
	//private static final String deptId = EgovProperties.getProperty("Globals.surem.deptId");
	private static final String smsCount = EgovProperties.getProperty("Globals.surem.smsCount");
	private static final String fromDefaultNm = "사용자";
	private static final String toDefaultNm = "항만공사";
	private static final String defaultChk = "DEFAULT";
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");

	/**
	 * 전화번호에 특수문자 "-", "." 자동으로 제거 Ex : 010-1111.2222 => 01011112222 | 061.000.1111 => 0610001111
	 * @param fromNm		- 받는 사람의 이름 ( "DEFAULT" : 기본설정에 잡힌 사람의 이름 )
	 * @param toNm			- 보낼 사람의 이름 ( "DEFAULT" : 기본설정에 잡힌 사람의 이름 )
	 * @param fromPhone		- 받는 사람의 번호 ( 010,011,016,017,018,019 으로 시작하고 10~11자리 )
	 * @param toPhone		- 보낼 사람의 번호 ( "DEFAULT" : 기본설정에 잡힌 사람의 번호 or 061로 시작하고 10자 이상 EX|061-000-0000 | 숫자 10글자 이상 )
	 * @param subject		- 메세지 제목
	 * @param message		- 메세지 내용
	 * @param fixMsgType	- 메세지 타입 ( "AUTO" : SMS 분할전송 | "SMS" : SMS 1건만 전송 )
	 * @param reserveDateTime - 예약 날짜 ( Ex : 1.[201401031230] or 2.[20140103123055] or 3.[(datetimepicker)2014-03-08 16:43] // Description : 1.[2014년 01월 03일 12시 30분 00초] or 2.[2014년 01월 03일 12시 30분 55초] or 3.[2014년 03월 08일 16시 43분 00초])
	 * @return				- boolean 전송완료 true | 전송 실패 false
	 */
	public static boolean suremSendMessage(String fromNm, String toNm, String fromPhone, String toPhone, String subject, String message, String fixMsgType, String reserveDateTime){
		
		try{
			
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			HttpSession session = request.getSession();
			ServletContext context = session.getServletContext();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			
			JnitcmsmbrVO mbrVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
			
			String mbrLogin = NullUtil.nullString(mbrVO.getMbrLogin());
			String mbrId = NullUtil.nullString(mbrVO.getMbrId());
			
			String rDate = "";
			String rTime = "";
			
			if(mbrLogin.equals("") && mbrId.equals("")){
				if("true".equals(deDug)) log.debug("Not Exist SMS Send User");
				return false;
			}
			
			SmsdataService smsdataService = (SmsdataService)wContext.getBean("smsdataService");
			
			fromPhone = NullUtil.nullString(fromPhone);
			toPhone = NullUtil.nullString(toPhone);
			
			if(!toPhone.equals("")){
				toPhone = toPhone.toUpperCase();
			}
			if(!fromNm.equals("")){
				fromNm = fromNm.toUpperCase();
			}
			if(!toNm.equals("")){
				toNm = toNm.toUpperCase();
			}
			
			int size = 0;
			boolean validate = true;

			String[] toArr = {};
			String[] fromArr = SuremUtil.replacePhone(fromPhone, "from");
			
			if(toPhone.equals(defaultChk)){
				toArr = SuremUtil.replacePhone(defaultPhone, "to");
			}else{
				toArr = SuremUtil.replacePhone(toPhone, "to");
			}
			
			if(fromNm.equals(defaultChk)){
				fromNm = fromDefaultNm;
			}
			if(toNm.equals(defaultChk)){
				toNm = toDefaultNm;
			}
			
			//예약 전송 일
			if(NullUtil.nullString(reserveDateTime).equals("")){
				rDate = "00000000";
				rTime = "000000";
			}else{
				reserveDateTime = reserveDateTime.replace(" ", "").replace("-", "").replace(":", "").replace(".", "");
				int length = reserveDateTime.length();
				if(length == 12){
					rDate = reserveDateTime.substring(0,8);
					rTime = reserveDateTime.substring(8) + "00";
				}else if(length == 13){
					rDate = reserveDateTime.substring(0,8);
					rTime = reserveDateTime.substring(8) + "0";
				}else if(length > 13){
					rDate = reserveDateTime.substring(0,8);
					rTime = reserveDateTime.substring(8, 14);
				}else{
					if("true".equals(deDug)) log.debug("Err. Reserve Not Validate");
					return false;
				}
			}
			
			if(fromArr == null){
				if("true".equals(deDug)) log.debug("fromPhone err : " + fromPhone);
				validate = false;
			}else if(toArr == null){
				if("true".equals(deDug)) log.debug("toPhone err : " + toPhone);
				validate = false;
			}
			size = message.getBytes("euc-kr").length;
			
			if(validate == true && fixMsgType.toUpperCase().equals("SMS")){			//SMS 1건

				//SureSMSSendReport sr = sms.sendMain(memberId, userId, deptId, fromNm, fromArr[0], fromArr[1], fromArr[2], toNm, toArr[0], toArr[1], toArr[2], message, "00000000", "00000000");
				SmsdataVO smsVO = new SmsdataVO();
				
				smsVO.setMember(memberId);
				smsVO.setIndate(SuremUtil.smsGetDate());
				smsVO.setIntime(SuremUtil.smsGetTime());
				smsVO.setSendid(userId);
				
				smsVO.setSendname(fromNm);
				smsVO.setRphone1(fromArr[0]);
				smsVO.setRphone2(fromArr[1]);
				smsVO.setRphone3(fromArr[2]);
				
				smsVO.setRecvname(toNm);
				smsVO.setSphone1(toArr[0]);
				smsVO.setSphone2(toArr[1]);
				smsVO.setSphone3(toArr[2]);
				
				smsVO.setMsg(message);
				smsVO.setResult("0");
				smsVO.setKind("S");
				smsVO.setRdate(rDate);
				smsVO.setRtime(rTime);
				
				smsVO.setTargetLogin(mbrLogin);
				smsVO.setTargetId(mbrId);
				
				smsdataService.insertSmsdata(smsVO);
				
			}else if(validate == true && fixMsgType.toUpperCase().equals("AUTO")){		//SMS 분할 전송

				SmsdataVO smsVO = new SmsdataVO();
				String[] msgArr = SuremUtil.messageArrResult(message);
				int msgSendLimit = 1;
				
				if(msgArr.length > Integer.parseInt(smsCount)){
					msgSendLimit = Integer.parseInt(smsCount);
				}else{
					msgSendLimit = msgArr.length;
				}
				
				for(int i=0; i<msgSendLimit; i++){
					
					//SureSMSSendReport sr = sms.sendMain(memberId, userId, deptId, fromNm, fromArr[0], fromArr[1], fromArr[2], toNm, toArr[0], toArr[1], toArr[2], msgArr[i], "00000000", "00000000");
					smsVO.setMember(memberId);
					smsVO.setIndate(SuremUtil.smsGetDate());
					smsVO.setIntime(SuremUtil.smsGetTime());
					smsVO.setSendid(userId);
					
					smsVO.setSendname(fromNm);
					smsVO.setRphone1(fromArr[0]);
					smsVO.setRphone2(fromArr[1]);
					smsVO.setRphone3(fromArr[2]);
					
					smsVO.setRecvname(toNm);
					smsVO.setSphone1(toArr[0]);
					smsVO.setSphone2(toArr[1]);
					smsVO.setSphone3(toArr[2]);
					
					smsVO.setMsg(msgArr[i]);
					smsVO.setResult("0");
					smsVO.setKind("S");
					smsVO.setRdate(rDate);
					smsVO.setRtime(rTime);
					
					smsVO.setTargetLogin(mbrLogin);
					smsVO.setTargetId(mbrId);
					
					smsdataService.insertSmsdata(smsVO);
				}
			}
		} catch (IllegalArgumentException e){
			log.error(e.getMessage());
			if("true".equals(deDug)) log.debug("TryCatch.SMS");
			return false;
		}catch(Exception e){
			log.error(e.getMessage());
			if("true".equals(deDug)) log.debug("TryCatch.SMS");
			return false;
		}
		return true;
	}
	
}

