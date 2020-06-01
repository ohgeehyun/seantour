/**
 * @version 3.2.0.1
 */
package jnit.allim.group;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitallimGroupDAO.java
 * @Description : JnitallimGroup DAO Class
 * @Modification Information
 *
 * @author JNITALLIM_GROUP
 * @since 2012.04.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitallimGroupDAO")
public class JnitallimGroupDAO extends EgovComAbstractDAO {

	/**
	 * jnitallim_group을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitallimGroupVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitallimGroup(JnitallimGroupVO vo) throws Exception {
        return (String)insert("jnitallimGroupDAO.insertJnitallimGroup_S", vo);
    }

    /**
	 * jnitallim_group을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitallimGroupVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitallimGroup(JnitallimGroupVO vo) throws Exception {
        update("jnitallimGroupDAO.updateJnitallimGroup_S", vo);
    }

    /**
	 * jnitallim_group을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitallimGroupVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitallimGroup(JnitallimGroupVO vo) throws Exception {
        delete("jnitallimGroupDAO.deleteJnitallimGroup_S", vo);
    }

    /**
	 * jnitallim_group을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitallimGroupVO
	 * @return 조회한 jnitallim_group
	 * @exception Exception
	 */
    public JnitallimGroupVO selectJnitallimGroup(JnitallimGroupVO vo) throws Exception {
        return (JnitallimGroupVO) select("jnitallimGroupDAO.selectJnitallimGroup_S", vo);
    }

    /**
	 * jnitallim_group 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitallim_group 목록
	 * @exception Exception
	 */
    public List<?> selectJnitallimGroupList(JnitallimGroupDefaultVO searchVO) throws Exception {
        return list("jnitallimGroupDAO.selectJnitallimGroupList_D", searchVO);
    }
    
    /**
	 * jnitallim_group 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitallim_group 목록
	 * @exception Exception
	 */
    public List<?> selectGroupList(JnitallimGroupDefaultVO searchVO) throws Exception {
        return list("jnitallimGroupDAO.selectGroupList_D", searchVO);
    }
    
    /**
	 * jnitallim_group 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitallim_group 목록
	 * @exception Exception
	 */
    public List<?> selectMoreList(JnitallimGroupDefaultVO searchVO) throws Exception {
        return list("jnitallimGroupDAO.selectMoreList_D", searchVO);
    }

    /**
	 * jnitallim_group 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitallim_group 총 갯수
	 * @exception
	 */
    public int selectJnitallimGroupListTotCnt(JnitallimGroupDefaultVO searchVO) {
        return (Integer)select("jnitallimGroupDAO.selectJnitallimGroupListTotCnt_S", searchVO);
    }
    
    /**
	 * jnitallim_group 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitallim_group 총 갯수
	 * @exception
	 */
    public int selectGroupListTotCnt(JnitallimGroupDefaultVO searchVO) {
        return (Integer)select("jnitallimGroupDAO.selectGroupListTotCnt_S", searchVO);
    }

    /**
	 * jnitallim_group 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitallimGroup() {
    	return (String)select("jnitallimGroupDAO.getLastIdJnitallimGroup_S");
    }
}
