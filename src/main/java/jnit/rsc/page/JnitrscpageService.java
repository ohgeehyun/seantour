/**
 * @version 3.2.0.1
 */
package jnit.rsc.page;

import java.util.List;

/**
 * @Class Name : JnitrscpageService.java
 * @Description : Jnitrscpage Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitrscpageService {
	
	/**
	 * jnitrscpage을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitrscpageVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitrscpage(JnitrscpageVO vo) throws Exception;
    
    /**
	 * jnitrscpage을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitrscpageVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitrscpage(JnitrscpageVO vo) throws Exception;
    
    /**
	 * jnitrscpage을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitrscpageVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitrscpage(JnitrscpageVO vo) throws Exception;
    
    /**
	 * jnitrscpage을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpageVO
	 * @return 조회한 jnitrscpage
	 * @exception Exception
	 */
    JnitrscpageVO selectJnitrscpage(JnitrscpageVO vo) throws Exception;
    
    /**
	 * jnitrscpageView을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpageVO
	 * @see JnitrscpageController  
	 * {@link jnit.rsc.page.JnitrscpageController # addJnitrscpageView }
	 * @return 조회한 jnitrscpage
	 * @exception Exception
	 */
    JnitrscpageViewVO selectJnitrscpageView(JnitrscpageVO vo) throws Exception;
    
    /**
	 * jnitrscpageView을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpageVO
	 * @see JnitrscpageController  
	 * {@link jnit.rsc.page.JnitrscpageController # addJnitrscpageView }
	 * @return 조회한 jnitrscpage
	 * @exception Exception
	 */
    JnitrscpageViewVO selectJnitrscexpageView(JnitrscpageViewVO vo) throws Exception;
    
    /**
	 * jnitrscpage 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitrscpage 목록
	 * @exception Exception
	 */
    List selectJnitrscpageList(JnitrscpageDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitrscpage 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitrscpage 총 갯수
	 * @exception
	 */
    int selectJnitrscpageListTotCnt(JnitrscpageDefaultVO searchVO);
    
    /**
     * jnitrscpage 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitrscpage() throws Exception;

    /**
	 * jnitrscpage을 Url로 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpageVO
	 * @return 조회한 jnitrscpage
	 * @exception Exception
	 */
    JnitrscpageVO selectJnitrscpageByUrl(JnitrscpageVO vo) throws Exception;
}
