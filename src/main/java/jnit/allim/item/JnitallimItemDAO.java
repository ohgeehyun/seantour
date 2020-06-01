/**
 * @version 3.2.0.1
 */
package jnit.allim.item;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitallimItemDAO.java
 * @Description : JnitallimItem DAO Class
 * @Modification Information
 *
 * @author JNITALLIMITEM
 * @since 2012.04.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitallimItemDAO")
public class JnitallimItemDAO extends EgovComAbstractDAO {

	/**
	 * jnitallim_item을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitallimItemVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitallimItem(JnitallimItemVO vo) throws Exception {
        return (String)insert("jnitallimItemDAO.insertJnitallimItem_S", vo);
    }

    /**
	 * jnitallim_item을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitallimItemVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitallimItem(JnitallimItemVO vo) throws Exception {
        update("jnitallimItemDAO.updateJnitallimItem_S", vo);
    }
    
    public void updateSort(JnitallimItemVO vo) throws Exception {
        update("jnitallimItemDAO.updateSort", vo);
    }

    /**
	 * jnitallim_item을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitallimItemVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitallimItem(JnitallimItemVO vo) throws Exception {
        delete("jnitallimItemDAO.deleteJnitallimItem_S", vo);
    }

    /**
	 * jnitallim_item을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitallimItemVO
	 * @return 조회한 jnitallim_item
	 * @exception Exception
	 */
    public JnitallimItemVO selectJnitallimItem(JnitallimItemVO vo) throws Exception {
        return (JnitallimItemVO) select("jnitallimItemDAO.selectJnitallimItem_S", vo);
    }

    /**
	 * jnitallim_item 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitallim_item 목록
	 * @exception Exception
	 */
    public List<?> selectJnitallimItemList(JnitallimItemDefaultVO searchVO) throws Exception {
        return list("jnitallimItemDAO.selectJnitallimItemList_D", searchVO);
    }
    
    /**
	 * jnitallim_item 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitallim_item 목록
	 * @exception Exception
	 */
    public List<?> selectSortMax(JnitallimItemDefaultVO searchVO) throws Exception {
        return list("jnitallimItemDAO.selectSortMax_D", searchVO);
    }

    /**
	 * jnitallim_item 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitallim_item 총 갯수
	 * @exception
	 */
    public int selectJnitallimItemListTotCnt(JnitallimItemDefaultVO searchVO) {
        return (Integer)select("jnitallimItemDAO.selectJnitallimItemListTotCnt_S", searchVO);
    }

    /**
	 * jnitallim_item 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitallimItem() {
    	return (String)select("jnitallimItemDAO.getLastIdJnitallimItem_S");
    }
}
