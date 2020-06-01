package jnit.com.service;

import jnit.cms.mbr.JnitcmsmbrVO;



/**
 * JNIT 공통 Service 클래스
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
public interface JnitComService{
	//로그인 여부
	boolean isLogin();
	//로그인 아이디 가져오기
	String getLoginID();//MEMBER_ID
	//로그인 정보가져오기
	JnitcmsmbrVO getLoginVO() ;
	
	//관리자 여부
	boolean isAdmin();
	
	//CMS 접근권한 여부
	boolean isCmsAccess();

	//메세지 properties에 있는 메세지 불러오기
	String getMessage(String code);
	String getMessage(String code, String[] args);
}