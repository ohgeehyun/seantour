/**
 * @version 3.2.0.1
 */
package jnit.rsc.page;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitrscpageDAO.java
 * @Description : Jnitrscpage DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitrscpageDAO")
public class JnitrscpageDAO extends EgovComAbstractDAO {

	/**
	 * jnitrscpage을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitrscpageVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitrscpage(JnitrscpageVO vo) throws Exception {
        return (String)insert("jnitrscpageDAO.insertJnitrscpage_S", vo);
    }

    /**
	 * jnitrscpage을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitrscpageVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitrscpage(JnitrscpageVO vo) throws Exception {
        update("jnitrscpageDAO.updateJnitrscpage_S", vo);
    }

    /**
	 * jnitrscpage을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitrscpageVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitrscpage(JnitrscpageVO vo) throws Exception {
        delete("jnitrscpageDAO.deleteJnitrscpage_S", vo);
    }

    /**
	 * jnitrscpage을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpageVO
	 * @return 조회한 jnitrscpage
	 * @exception Exception
	 */
    public JnitrscpageVO selectJnitrscpage(JnitrscpageVO vo) throws Exception {
        return (JnitrscpageVO) select("jnitrscpageDAO.selectJnitrscpage_S", vo);
    }

    /**
	 * jnitrscpage을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpageVO
	 * @see JnitrscpageController
	 * {@link jnit.rsc.page.JnitrscpageController # addJnitrscpageView }
	 * @return 조회한 jnitrscpage
	 * @exception Exception
	 */
    public JnitrscpageViewVO selectJnitrscpageView(JnitrscpageVO vo) throws Exception {
        return (JnitrscpageViewVO) select("jnitrscpageDAO.selectPageView", vo);
    }
    
    /**
	 * jnitrscpage을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpageVO
	 * @see JnitrscpageController
	 * {@link jnit.rsc.page.JnitrscpageController # addJnitrscpageView }
	 * @return 조회한 jnitrscpage
	 * @exception Exception
	 */
    public JnitrscpageViewVO selectJnitexpageView(JnitrscpageViewVO vo) throws Exception {
        return (JnitrscpageViewVO) select("jnitrscpageDAO.selectexPageView", vo);
    }
    
    /**
	 * jnitrscpage 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitrscpage 목록
	 * @exception Exception
	 */
    public List<?> selectJnitrscpageList(JnitrscpageDefaultVO searchVO) throws Exception {
        return list("jnitrscpageDAO.selectJnitrscpageList_D", searchVO);
    }

    /**
	 * jnitrscpage 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitrscpage 총 갯수
	 * @exception
	 */
    public int selectJnitrscpageListTotCnt(JnitrscpageDefaultVO searchVO) {
        return (Integer)select("jnitrscpageDAO.selectJnitrscpageListTotCnt_S", searchVO);
    }

    /**
	 * jnitrscpage 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitrscpage() {
    	return (String)select("jnitrscpageDAO.getLastIdJnitrscpage_S");
    }

    /**
	 * jnitrscpage을 Url로 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpageVO
	 * @return 조회한 jnitrscpage
	 * @exception Exception
	 */
    public JnitrscpageVO selectJnitrscpageByUrl(JnitrscpageVO vo) throws Exception {
        return (JnitrscpageVO) select("jnitrscpageDAO.selectJnitrscpageByUrl_S", vo);
    }
}
