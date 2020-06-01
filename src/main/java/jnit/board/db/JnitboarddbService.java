/**
 * @version 3.2.0.1
 */
package jnit.board.db;

import java.util.List;

/**
 * @Class Name : JnitboardtplService.java
 * @Description : Jnitboardtpl Business class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2013.01.22
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitboarddbService {
	
	/**
	 * jnitboardtpl을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardtplVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    int insert(JnitboarddbVO vo) throws Exception;
    
    /**
	 * jnitboardtpl을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardtplVO
	 * @return void형
	 * @exception Exception
	 */
    void update(JnitboarddbVO vo) throws Exception;
    
    /**
	 * jnitboardtpl의 조회수를 올린다.
	 * @param vo - 수정할 정보가 담긴 JnitboardtplVO
	 * @return void형
	 * @exception Exception
	 */
    void hit(JnitboarddbVO vo) throws Exception;
    
    /**
	 * jnitboardtpl을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardtplVO
	 * @return void형 
	 * @exception Exception
	 */
    void delete(JnitboarddbVO vo) throws Exception;
    
    /**
	 * 해당 게시판의 데이터를 전체 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardtplVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteAll(JnitboarddbVO vo) throws Exception;
    
    /**
	 * 해당 게시판의 데이터를 전체 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardtplVO
	 * @return void형 
	 * @exception Exception
	 */
    void dataDeleteAll(String boardId, int id) throws Exception;;
    
    /**
	 * jnitboardtpl을 복구한다.
	 * @param vo - 복구할 정보가 담긴 JnitboardtplVO
	 * @return void형 
	 * @exception Exception
	 */
    void recovery(JnitboarddbVO vo) throws Exception;
    
    /**
	 * jnitboardtpl을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardtplVO
	 * @return 조회한 jnitboardtpl
	 * @exception Exception
	 */
    JnitboarddbVO select(JnitboarddbVO vo) throws Exception;
    
    /**
	 * jnitboardtpl조회 데이터중 익명의 사용자가 올린 글을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardtplVO
	 * @return 조회한 jnitboardtpl
	 * @exception Exception
	 */
    JnitboarddbVO selectAnonymous(JnitboarddbVO vo) throws Exception;
    
    /**
	 * jnitboardtpl 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardtpl 목록
	 * @exception Exception
	 */
    List selectList(JnitboarddbDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitboardtpl 이전글,다음글, 현재글의 답글 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardtpl 목록
	 * @exception Exception
	 */
    List selectPNList(JnitboarddbDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitboardtpl 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardtpl 총 갯수
	 * @exception
	 */
    int selectListTotCnt(JnitboarddbDefaultVO searchVO);
    
    /**
     * jnitboardtpl 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    int getLastId(JnitboarddbDefaultVO searchVO) throws Exception;
    
    /**
     * jnitboardtpl 다음 등록 IDX를 조회한다
     * @param vo - 등록할 정보가 담긴 JnitboardtplVO
     * @return 다음 등록 Idx
     * @exception Exception
     */
    String getNextIdx(JnitboarddbVO dbVO) throws Exception;
}
