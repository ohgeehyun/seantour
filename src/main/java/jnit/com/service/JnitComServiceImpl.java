package jnit.com.service;

import jnit.cms.mbr.JnitcmsmbrVO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

/**
 * JNIT 공통기능 ServiceImpl 클래스
 * @author JNIT
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
@Service("jnitComService")
public class JnitComServiceImpl extends JnitDefaultServiceImpl implements JnitComService {

	private Logger log	= Logger.getLogger(this.getClass());
	
	public boolean isLogin(){return super.isLogin();}

	public String getLoginID(){return super.getLoginID();}

	public JnitcmsmbrVO getLoginVO(){return super.getLoginVO();}

	public boolean isAdmin(){return super.isAdmin();}
	
	public boolean isCmsAccess(){return super.isCmsAccess();}
	
	public String getMessage(String code) {return super.getMessage(code, null);}
	
	public String getMessage(String code, String[] args) {return super.getMessage(code, args);}
}
