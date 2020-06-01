package jnit.menu;

import java.util.HashMap;
import java.util.List;
import jnit.menu.JnitmenuDefaultVO;
import jnit.menu.JnitmenuVO;

/**
 * @Class Name : JnitmenuService.java
 * @Description : Jnitmenu Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.28
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitmenuService {
	
	/**
	 * JNITMENU을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitmenuVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitmenu(JnitmenuVO vo) throws Exception;
    
    /**
	 * JNITMENU을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitmenuVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitmenu(JnitmenuVO vo) throws Exception;
    
    /**
	 * JNITMENU을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitmenuVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitmenu(JnitmenuVO vo) throws Exception;
    
    /**
	 * JNITMENU을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitmenuVO
	 * @return 조회한 JNITMENU
	 * @exception Exception
	 */
    JnitmenuVO selectJnitmenu(JnitmenuVO vo) throws Exception;
    
    
    /**
	 * JNITMENUMAP을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitmenuVO
	 * @return 조회한 JNITMENU
	 * @exception Exception
	 */
    @SuppressWarnings("rawtypes")
	HashMap selectJnitmenuMap(JnitmenuVO vo) throws Exception;
    
    /**
	 * JNITMENU 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITMENU 목록
	 * @exception Exception
	 */
    List selectJnitmenuList(JnitmenuDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITMENU 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITMENU 총 갯수
	 * @exception
	 */
    int selectJnitmenuListTotCnt(JnitmenuDefaultVO searchVO);
    
    /**
     * JNITMENU 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitmenu() throws Exception;
}
