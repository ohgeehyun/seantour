/**
 * @version 3.2.0.1
 */
package jnit.cms.cnt;

import java.util.List;

/**
 * @Class Name : JnitcmscntService.java
 * @Description : Jnitcmscnt Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmscntService {
	
	/**
	 * JNITCMSCNT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmscntVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmscnt(JnitcmscntVO vo) throws Exception;
    
    /**
	 * JNITCMSCNT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmscntVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertSelectJnitcmscnt(JnitcmscntVO vo) throws Exception;
    
    /**
     * JNITCMSCNT NEXT ID를 알아온다
     */
    String cntNextId() throws Exception;
    
    /**
	 * JNITCMSCNT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmscntVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmscnt(JnitcmscntVO vo) throws Exception;
    
    /**
	 * JNITCMSCNT OPT를 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmscntVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmscntOpt(JnitcmscntVO vo) throws Exception;
    
    /**
	 * JNITCMSCNT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmscntVO
	 * @param cntWebStandard - 웹표준
	 * @param cntWebStandardCss - 웹표준css
	 * @param cntWebAccess - 웹접근성
	 * @return void형
	 * @exception Exception
	 */
    void updateWebcnt(JnitcmscntVO vo) throws Exception;
    
    /** 외국어 사이트 동시 변경 */
    void updateJnitcmscntLanguage(JnitcmscntVO vo) throws Exception;
    
    /**
	 * JNITCMSCNT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmscntVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmscnt(JnitcmscntVO vo) throws Exception;
    
    /**
	 * JNITCMSCNT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmscntVO
	 * @return 조회한 JNITCMSCNT
	 * @exception Exception
	 */
    JnitcmscntVO selectJnitcmscnt(JnitcmscntVO vo) throws Exception;
    
    /**
	 * JNITCMSCNT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNT 목록
	 * @exception Exception
	 */
    List selectJnitcmscntList(JnitcmscntDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSCNT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNT 목록
	 * @exception Exception
	 */
    List selectLeftcntMenuList(JnitcmscntDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSCNT 목록을 조회한다.
	 * LEFT JOIN JNITCMSMENU
	 * LEFT JOIN JNITCMSTPL
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNT 목록
	 * @exception Exception
	 */
    List selectLeftJoincntList(JnitcmscntDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSCNT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNT 총 갯수
	 * @exception
	 */
    int selectJnitcmscntListTotCnt(JnitcmscntDefaultVO searchVO);
    
    /**
	 * JNITCMSCNT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNT 총 갯수
	 * @exception
	 */
    int selectLeftcntMenuListTotCnt(JnitcmscntDefaultVO searchVO);
    
    /**
	 * JNITCMSCNT 총 갯수를 조회한다.
	 * LEFT JOIN JNITCMSMENU.
	 * LEFT JOIN JNITCMSTPL
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNT 총 갯수
	 * @exception
	 */
    int selectLeftJoincntListTotCnt(JnitcmscntDefaultVO searchVO);
    
    /**
     * JNITCMSCNT 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmscnt() throws Exception;
}
