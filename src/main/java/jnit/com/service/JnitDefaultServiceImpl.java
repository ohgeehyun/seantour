package jnit.com.service;

import java.util.Locale;

import javax.annotation.Resource;

import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.com.util.SpringHelperUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;

/**
 * JNIT 기본 ServiceImpl 클래스
 * 
 * @author meddogi1
 * @since 2015.02.18
 * @version 1.0
 * @see
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *	수정일		수정자		수정내용
 *	-------		--------	---------------------------
 *  2015.02.18	meddogi1	 최초 생성
 *
 * </pre>
 */
public class JnitDefaultServiceImpl {

	protected Log log = LogFactory.getLog(this.getClass());

	final String admLevelProp = EgovProperties.getProperty(EgovProperties.getProperty("Webadm.Properties"), "Webadm.Levels");		//CMS 접근권한
	
	@Resource(name = "messageSource")
	protected MessageSource messageSource;

	/**
	 * 로그인 여부
	 * 
	 * @return
	 */
	public boolean isLogin() {
		return !getLoginID().equals("");
	}

	/**
	 * 로그인 아이디가져오기
	 * 
	 * @return
	 */
	public String getLoginID() {
		String ret = "";

		JnitcmsmbrVO m = getLoginVO();
		if (m != null && !"".equals(NullUtil.nullString(m.getMbrId())))
			ret = m.getMbrId();
		return ret;
	}

	/**
	 * 로그인 정보가져오기
	 * 
	 * @return
	 */
	public JnitcmsmbrVO getLoginVO() {
		return (JnitcmsmbrVO) CmsHelper.getAuthMbr(SpringHelperUtil.getRequest());
	}

	/**
	 * 관리자 여부
	 * 
	 * @return
	 */
	public boolean isAdmin() {
		JnitcmsmbrVO loginVO = getLoginVO();
		if (loginVO == null || loginVO.getTypeVO() == null)
			return false;
		return "A".equals(loginVO.getTypeVO().getTypeLv());
	}
	
	/**
	 * CMS 접근권한 여부
	 * 
	 * @return
	 */
	public boolean isCmsAccess(){
		boolean isPass = false;
		JnitcmsmbrVO loginVO = getLoginVO();
		if (loginVO == null || loginVO.getTypeVO() == null)
			return false;
		
		String thisLevel = NullUtil.nullString(loginVO.getTypeVO().getTypeLv());
		String[] adminLevelsArr = NullUtil.nullString(admLevelProp).split(",");
		for(String adminLevel : adminLevelsArr){
			if(thisLevel.equals(adminLevel)){
				isPass = true;
				break;
			}
		}
		return isPass;
	}

	/**
	 * msgKey를 통한 메세지 가져오기
	 * 
	 * @param msgKey
	 * @return
	 */
	protected String getMessage(final String msgKey) {
		return getMessage(msgKey, null);
	}

	/**
	 * msgKey를 통한 메세지 가져오기
	 * 
	 * @param msgKey
	 * @param msgArgs
	 * @return
	 */
	protected String getMessage(final String msgKey, String[] msgArgs) {
		return getMessage(msgKey, msgArgs, Locale.getDefault());
	}

	/**
	 * msgKey를 통한 메세지 가져오기
	 * 
	 * @param msgKey
	 * @param msgArgs
	 * @param locale
	 * @return
	 */
	protected String getMessage(final String msgKey, String[] msgArgs, Locale locale) {
		return messageSource.getMessage(msgKey, msgArgs, locale);
	}

	/**
	 * msgKey를 통한 메세지 가져오기
	 * 
	 * @param msgKey
	 * @param msgArgs
	 * @param defaultMessage
	 * @param locale
	 * @return
	 */
	protected String getMessage(final String msgKey, String[] msgArgs, String defaultMessage, Locale locale) {
		return messageSource.getMessage(msgKey, msgArgs, defaultMessage, locale);
	}

	/**
	 * EgovBizException 발생을 위한 메소드
	 * 
	 * @param msgKey 메세지리소스에서 제공되는 메세지의 키값
	 * @return Exception EgovBizException 객체
	 */
	protected Exception processException(final String msgKey) {
		return processException(msgKey, new String[] {});
	}

	/**
	 * EgovBizException 발생을 위한 메소드
	 * 
	 * @param msgKey 메세지리소스에서 제공되는 메세지의 키값
	 * @param exception 발생한 Exception(내부적으로 취하고 있다가 에러핸들링시 사용)
	 * @return Exception EgovBizException 객체
	 */
	protected Exception processException(final String msgKey, Exception e) {
		return processException(msgKey, new String[] {}, e);
	}

	/**
	 * EgovBizException 발생을 위한 메소드
	 * 
	 * @param msgKey 메세지리소스에서 제공되는 메세지의 키값
	 * @param msgArgs msgKey의 메세지에서 변수에 취환되는 값들
	 * @return Exception EgovBizException 객체
	 */
	protected Exception processException(final String msgKey, final String[] msgArgs) {
		return processException(msgKey, msgArgs, null);
	}

	/**
	 * EgovBizException 발생을 위한 메소드
	 * 
	 * @param msgKey 메세지리소스에서 제공되는 메세지의 키값
	 * @param msgArgs msgKey의 메세지에서 변수에 취환되는 값들
	 * @param exception 발생한 Exception(내부적으로 취하고 있다가 에러핸들링시 사용)
	 * @return Exception EgovBizException 객체
	 */
	protected Exception processException(final String msgKey, final String[] msgArgs, final Exception e) {
		return processException(msgKey, msgArgs, e, LocaleContextHolder.getLocale());
	}

	/**
	 * EgovBizException 발생을 위한 메소드
	 * 
	 * @param msgKey 메세지리소스에서 제공되는 메세지의 키값
	 * @param msgArgs msgKey의 메세지에서 변수에 취환되는 값들
	 * @param exception 발생한 Exception(내부적으로 취하고 있다가 에러핸들링시 사용)
	 * @param locale 명시적 국가/언어지정
	 * @return Exception EgovBizException 객체
	 */
	protected Exception processException(final String msgKey, final String[] msgArgs, final Exception e, Locale locale) {
		return processException(msgKey, msgArgs, e, locale, null);
	}

	/**
	 * EgovBizException 발생을 위한 메소드
	 * 
	 * @param msgKey 메세지리소스에서 제공되는 메세지의 키값
	 * @param msgArgs msgKey의 메세지에서 변수에 취환되는 값들
	 * @param exception 발생한 Exception(내부적으로 취하고 있다가 에러핸들링시 사용)
	 * @param locale 명시적 국가/언어지정
	 * @param exceptionCreator 외부에서 별도의 Exception 생성기 지정
	 * @return Exception EgovBizException 객체
	 */
	protected Exception processException(final String msgKey, final String[] msgArgs, final Exception e,
			final Locale locale, ExceptionCreator exceptionCreator) {
		ExceptionCreator eC = null;
		if (exceptionCreator == null) {
			eC = new ExceptionCreator() {

				public Exception createBizException(MessageSource messageSource) {
					return new EgovBizException(messageSource, msgKey, msgArgs, locale, e);
				}
			};
		}
		return eC.createBizException(messageSource);
	}

	protected interface ExceptionCreator {

		Exception createBizException(MessageSource messageSource);
	}

}
