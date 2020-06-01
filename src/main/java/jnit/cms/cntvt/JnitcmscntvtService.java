/**
 * @version 3.2.0.1
 */
package jnit.cms.cntvt;

import java.util.List;

/**
 * @Class Name : JnitcmscntvtService.java
 * @Description : Jnitcmscntvt Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmscntvtService {
	

    /**
	 * JNITCMSCNTVT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmscntvtVO
	 * @return 조회한 JNITCMSCNTVT
	 * @exception Exception
	 */
    JnitcmscntvtVO selectJnitcmscntvt(JnitcmscntvtVO vo) throws Exception;
    
    /**
	 * JNITCMSCNTVT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNTVT 목록
	 * @exception Exception
	 */
    List selectJnitcmscntvtList(JnitcmscntvtDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSCNTVT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNTVT 총 갯수
	 * @exception
	 */
    int selectJnitcmscntvtListTotCnt(JnitcmscntvtDefaultVO searchVO);
 
}
