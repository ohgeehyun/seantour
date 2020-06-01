/**
 * @version 3.2.0.1
 */
package jnit.cms.tpl;

import java.util.List;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;

/**
 * @Class Name : JnitcmstplService.java
 * @Description : Jnitcmstpl Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmstplService {
	
	/**
	 * JNITCMSTPL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmstplVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmstpl(JnitcmstplVO vo) throws Exception;
    
    /**
	 * JNITCMSTPL을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmstplVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmstpl(JnitcmstplVO vo) throws Exception;
    
    /**
	 * JNITCMSTPL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmstplVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmstpl(JnitcmstplVO vo) throws Exception;
    
    /**
	 * JNITCMSTPL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmstplVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmssitetpl(JnitcmstplVO vo) throws Exception;
    
    /**
	 * JNITCMSTPL을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmstplVO
	 * @return 조회한 JNITCMSTPL
	 * @exception Exception
	 */
    JnitcmstplVO selectJnitcmstpl(JnitcmstplVO vo) throws Exception;

    /**
	 * JNITCMSTPL을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 조회한 JNITCMSTPL
	 * @exception Exception
	 */
    JnitcmstplVO selectJnitcmstpltype(JnitcmstplDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSTPL 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSTPL 목록
	 * @exception Exception
	 */
    List selectJnitcmstplList(JnitcmstplDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSTPL 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSTPL 총 갯수
	 * @exception
	 */
    int selectJnitcmstplListTotCnt(JnitcmstplDefaultVO searchVO);
    
    /**
	 * JNITCMSTPL 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSTPL 목록
	 * @exception Exception
	 */
    List selectJnitcmstplCopyList(JnitcmstplDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSTPL 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSTPL 총 갯수
	 * @exception
	 */
    int selectJnitcmstplCopyListTotCnt(JnitcmstplDefaultVO searchVO);
    
    /**
     * JNITCMSTPL 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmstpl() throws Exception;
    
    /**
     * 템플릿 정보를 코드형태로 리턴한다.
     * 
     * @param 조회조건정보 vo
     * @return 그룹정보 List
     * @throws Exception
     */
    List<CmmnDetailCode> selectTplIdDetail(ComDefaultCodeVO vo) throws Exception;
}
