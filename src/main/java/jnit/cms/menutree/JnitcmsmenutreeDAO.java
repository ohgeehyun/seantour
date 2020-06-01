package jnit.cms.menutree;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import jnit.cms.menutree.JnitcmsmenutreeDefaultVO;
import jnit.cms.menutree.JnitcmsmenutreeVO;

/**
 * @Class Name : JnitcmsmenutreeDAO.java
 * @Description : Jnitcmsmenutree DAO Class
 * @Modification Information
 *
 * @author jnitcmsmenutree
 * @since 2018.01.03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsmenutreeDAO")
public class JnitcmsmenutreeDAO extends EgovAbstractDAO {

	/**
	 * jnitcmsmenutree을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenutreeVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmenutree(JnitcmsmenutreeVO vo) throws Exception {
        return (String)insert("jnitcmsmenutreeDAO.insertJnitcmsmenutree_S", vo);
    }

    /**
	 * jnitcmsmenutree을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenutreeVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmenutree(JnitcmsmenutreeVO vo) throws Exception {
        update("jnitcmsmenutreeDAO.updateJnitcmsmenutree_S", vo);
    }

    /**
	 * jnitcmsmenutree을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmenutreeVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmenutree(JnitcmsmenutreeVO vo) throws Exception {
        delete("jnitcmsmenutreeDAO.deleteJnitcmsmenutree_S", vo);
    }

    /**
	 * jnitcmsmenutree을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmenutreeVO
	 * @return 조회한 jnitcmsmenutree
	 * @exception Exception
	 */
    public JnitcmsmenutreeVO selectJnitcmsmenutree(JnitcmsmenutreeVO vo) throws Exception {
        return (JnitcmsmenutreeVO) select("jnitcmsmenutreeDAO.selectJnitcmsmenutree_S", vo);
    }

    /**
	 * jnitcmsmenutree 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsmenutree 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmenutreeList(JnitcmsmenutreeDefaultVO searchVO) throws Exception {
        return list("jnitcmsmenutreeDAO.selectJnitcmsmenutreeList_D", searchVO);
    }

    /**
	 * jnitcmsmenutree 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsmenutree 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmenutreeListTotCnt(JnitcmsmenutreeDefaultVO searchVO) {
        return (Integer)select("jnitcmsmenutreeDAO.selectJnitcmsmenutreeListTotCnt_S", searchVO);
    }

	/**
	 * 린크 기준 ID가져오기
	 * 
	 * @return
	 * @throws Exception
	 */
	public JnitcmsmenutreeVO linkselect(JnitcmsmenutreeDefaultVO searchVO) throws Exception {
		return  (JnitcmsmenutreeVO) select("jnitcmsmenutreeDao.linkselect",searchVO);
	}

	public List selectsubset(JnitcmsmenutreeDefaultVO searchVO)throws Exception{
		return list("jnitcmsmenutreeDAO.selectsubset",searchVO);
	}

	public int getlastId(JnitcmsmenutreeVO searchVO){
		//System.out.println("searchVO ::: "+searchVO);
		return (Integer) select("jnitCmsmenutreeDAO.getlastId",searchVO);
	}
	
	public List<?> selectupdatedList(JnitcmsmenutreeDefaultVO searchVO) throws Exception {
        return list("jnitcmsmenutreeDAO.selectupdatedList", searchVO);
    }
	
	public void updatedmenu(JnitcmsmenutreeDefaultVO searchVO) throws Exception {
        update("jnitcmsmenutreeDAO.updatedmenu", searchVO);
    }
	
	

    /**
	 * jnitcmsmenutree 모든 활성화된 목록을 조회.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsmenutree 목록
	 * @exception Exception
	 */
    public List selectListAllActive(JnitcmsmenutreeDefaultVO searchVO) throws Exception {
        return list("jnitcmsmenutreeDAO.selectListAllActive", searchVO);
    }
}
