/**
 * @version 3.2.0.1
 */
package jnit.ebook.file;

import java.util.List;

/**
 * @Class Name : JnitebookfileService.java
 * @Description : Jnitebookfile Business class
 * @Modification Information
 *
 * @author JNITEBOOKFILE
 * @since 2014.02.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitebookfileService {
	
	/**
	 * JNITEBOOKFILE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitebookfileVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitebookfile(JnitebookfileVO vo) throws Exception;
    
    /**
	 * JNITEBOOKFILE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitebookfileVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitebookfile(JnitebookfileVO vo) throws Exception;
    
    /**
	 * JNITEBOOKFILE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitebookfileVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitebookfile(JnitebookfileVO vo) throws Exception;
    
    /**
	 * JNITEBOOKFILE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitebookfileVO
	 * @return 조회한 JNITEBOOKFILE
	 * @exception Exception
	 */
    JnitebookfileVO selectJnitebookfile(JnitebookfileVO vo) throws Exception;
    
    /**
	 * JNITEBOOKFILE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITEBOOKFILE 목록
	 * @exception Exception
	 */
    List selectJnitebookfileList(JnitebookfileDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITEBOOKFILE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITEBOOKFILE 총 갯수
	 * @exception
	 */
    int selectJnitebookfileListTotCnt(JnitebookfileDefaultVO searchVO);
    
    /**
     * JNITEBOOKFILE 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitebookfile() throws Exception;
}
