/**
 * @version 3.2.0.1
 */
package jnit.allim.group;

import java.util.List;

/**
 * @Class Name : JnitallimGroupService.java
 * @Description : JnitallimGroup Business class
 * @Modification Information
 *
 * @author JNITALLIM_GROUP
 * @since 2012.04.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitallimGroupService {
	
	/**
	 * jnitallim_group을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitallimGroupVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitallimGroup(JnitallimGroupVO vo) throws Exception;
    
    /**
	 * jnitallim_group을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitallimGroupVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitallimGroup(JnitallimGroupVO vo) throws Exception;
    
    /**
	 * jnitallim_group을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitallimGroupVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitallimGroup(JnitallimGroupVO vo) throws Exception;
    
    /**
	 * jnitallim_group을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitallimGroupVO
	 * @return 조회한 jnitallim_group
	 * @exception Exception
	 */
    JnitallimGroupVO selectJnitallimGroup(JnitallimGroupVO vo) throws Exception;
    
    /**
	 * jnitallim_group 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_group 목록
	 * @exception Exception
	 */
    List selectJnitallimGroupList(JnitallimGroupDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitallim_group 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_group 목록
	 * @exception Exception
	 */
    List selectGroupList(JnitallimGroupDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitallim_group 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_group 목록
	 * @exception Exception
	 */
    List selectMoreList(JnitallimGroupDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitallim_group 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_group 총 갯수
	 * @exception
	 */
    int selectJnitallimGroupListTotCnt(JnitallimGroupDefaultVO searchVO);
    
    /**
	 * jnitallim_group 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_group 총 갯수
	 * @exception
	 */
    int selectGroupListTotCnt(JnitallimGroupDefaultVO searchVO);
    
    /**
     * jnitallim_group 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitallimGroup() throws Exception;
}
