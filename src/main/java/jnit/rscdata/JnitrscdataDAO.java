/**
 * @version 3.2.0.1
 */
package jnit.rscdata;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitrscdataDAO.java
 * @Description : Jnitrscdata DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.04
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitrscdataDAO")
public class JnitrscdataDAO extends EgovComAbstractDAO {

	/**
	 * JNITRSCDATA을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitrscdataVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitrscdata(JnitrscdataVO vo) throws Exception {
        return (String)insert("jnitrscdataDAO.insertJnitrscdata_S", vo);
    }

    /**
	 * JNITRSCDATA을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitrscdataVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitrscdata(JnitrscdataVO vo) throws Exception {
        update("jnitrscdataDAO.updateJnitrscdata_S", vo);
    }

    /**
	 * JNITRSCDATA을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitrscdataVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitrscdata(JnitrscdataVO vo) throws Exception {
        delete("jnitrscdataDAO.deleteJnitrscdata_S", vo);
    }

    /**
	 * JNITRSCDATA을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscdataVO
	 * @return 조회한 JNITRSCDATA
	 * @exception Exception
	 */
    public JnitrscdataVO selectJnitrscdata(JnitrscdataVO vo) throws Exception {
        return (JnitrscdataVO) select("jnitrscdataDAO.selectJnitrscdata_S", vo);
    }

    /**
	 * JNITRSCDATA 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITRSCDATA 목록
	 * @exception Exception
	 */
    public List<?> selectJnitrscdataList(JnitrscdataDefaultVO searchVO) throws Exception {
        return list("jnitrscdataDAO.selectJnitrscdataList_D", searchVO);
    }

    /**
	 * JNITRSCDATA 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITRSCDATA 총 갯수
	 * @exception
	 */
    public int selectJnitrscdataListTotCnt(JnitrscdataDefaultVO searchVO) {
        return (Integer)select("jnitrscdataDAO.selectJnitrscdataListTotCnt_S", searchVO);
    }

    /**
	 * JNITRSCDATA 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitrscdata() {
    	return (String)select("jnitrscdataDAO.getLastIdJnitrscdata_S");
    }
}
