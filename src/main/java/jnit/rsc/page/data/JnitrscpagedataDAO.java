/**
 * @version 3.2.0.1
 */
package jnit.rsc.page.data;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitrscpagedataDAO.java
 * @Description : Jnitrscpagedata DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitrscpagedataDAO")
public class JnitrscpagedataDAO extends EgovComAbstractDAO {

	/**
	 * jnitrscpagedata을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitrscpagedataVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitrscpagedata(JnitrscpagedataVO vo) throws Exception {
        return (String)insert("jnitrscpagedataDAO.insertJnitrscpagedata_S", vo);
    }

    /**
	 * jnitrscpagedata을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitrscpagedataVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitrscpagedata(JnitrscpagedataVO vo) throws Exception {
        update("jnitrscpagedataDAO.updateJnitrscpagedata_S", vo);
    }

    /**
	 * jnitrscpagedata을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitrscpagedataVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitrscpagedata(JnitrscpagedataVO vo) throws Exception {
        delete("jnitrscpagedataDAO.deleteJnitrscpagedata_S", vo);
    }

    /**
	 * jnitrscpagedata을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpagedataVO
	 * @return 조회한 jnitrscpagedata
	 * @exception Exception
	 */
    public JnitrscpagedataVO selectJnitrscpagedata(JnitrscpagedataVO vo) throws Exception {
        return (JnitrscpagedataVO) select("jnitrscpagedataDAO.selectJnitrscpagedata_S", vo);
    }

    /**
	 * jnitrscpagedata 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitrscpagedata 목록
	 * @exception Exception
	 */
    public List<?> selectJnitrscpagedataList(JnitrscpagedataDefaultVO searchVO) throws Exception {
        return list("jnitrscpagedataDAO.selectJnitrscpagedataList_D", searchVO);
    }

    /**
	 * jnitrscpagedata 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitrscpagedata 총 갯수
	 * @exception
	 */
    public int selectJnitrscpagedataListTotCnt(JnitrscpagedataDefaultVO searchVO) {
        return (Integer)select("jnitrscpagedataDAO.selectJnitrscpagedataListTotCnt_S", searchVO);
    }

    /**
	 * jnitrscpagedata 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitrscpagedata() {
    	return (String)select("jnitrscpagedataDAO.getLastIdJnitrscpagedata_S");
    }
}
