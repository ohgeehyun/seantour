/**
 * @version 3.2.0.1
 */
package jnit.rsc;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitrscDAO.java
 * @Description : Jnitrsc DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.04
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitrscDAO")
public class JnitrscDAO extends EgovComAbstractDAO {

	/**
	 * JNITRSC을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitrscVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitrsc(JnitrscVO vo) throws Exception {
        return (String)insert("jnitrscDAO.insertJnitrsc_S", vo);
    }

    /**
	 * JNITRSC을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitrscVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitrsc(JnitrscVO vo) throws Exception {
        update("jnitrscDAO.updateJnitrsc_S", vo);
    }

    /**
	 * JNITRSC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitrscVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitrsc(JnitrscVO vo) throws Exception {
        delete("jnitrscDAO.deleteJnitrsc_S", vo);
    }

    /**
	 * JNITRSC을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscVO
	 * @return 조회한 JNITRSC
	 * @exception Exception
	 */
    public JnitrscVO selectJnitrsc(JnitrscVO vo) throws Exception {
        return (JnitrscVO) select("jnitrscDAO.selectJnitrsc_S", vo);
    }

    /**
	 * JNITRSC 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITRSC 목록
	 * @exception Exception
	 */
    public List<?> selectJnitrscList(JnitrscDefaultVO searchVO) throws Exception {
        return list("jnitrscDAO.selectJnitrscList_D", searchVO);
    }

    /**
	 * JNITRSC 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITRSC 총 갯수
	 * @exception
	 */
    public int selectJnitrscListTotCnt(JnitrscDefaultVO searchVO) {
        return (Integer)select("jnitrscDAO.selectJnitrscListTotCnt_S", searchVO);
    }

    /**
	 * JNITRSC 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitrsc() {
    	return (String)select("jnitrscDAO.getLastIdJnitrsc_S");
    }

	public JnitrscVO selectJnitrscByUrl(String url) {
		JnitrscVO vo = new JnitrscVO();
		vo.setRscUrl(url);
		return (JnitrscVO)select("jnitrscDAO.selectJnitrscByUrl_S", vo);
	}
}
