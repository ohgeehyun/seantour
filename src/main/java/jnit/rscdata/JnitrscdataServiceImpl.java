/**
 * @version 3.2.0.1
 */
package jnit.rscdata;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitrscdataServiceImpl.java
 * @Description : Jnitrscdata Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.04
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitrscdataService")
public class JnitrscdataServiceImpl extends EgovAbstractServiceImpl implements
        JnitrscdataService {

    @Resource(name="jnitrscdataDAO")
    private JnitrscdataDAO jnitrscdataDAO;
    
    /** ID Generation */
    @Resource(name="jnitRSCDATAIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITRSCDATA을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitrscdataVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitrscdata(JnitrscdataVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setDataId(id);
    	
    	
    	jnitrscdataDAO.insertJnitrscdata(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }

    /**
	 * JNITRSCDATA을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitrscdataVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitrscdata(JnitrscdataVO vo) throws Exception {
        jnitrscdataDAO.updateJnitrscdata(vo);
    }

    /**
	 * JNITRSCDATA을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitrscdataVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitrscdata(JnitrscdataVO vo) throws Exception {
        jnitrscdataDAO.deleteJnitrscdata(vo);
    }

    /**
	 * JNITRSCDATA을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscdataVO
	 * @return 조회한 JNITRSCDATA
	 * @exception Exception
	 */
    public JnitrscdataVO selectJnitrscdata(JnitrscdataVO vo) throws Exception {
        JnitrscdataVO resultVO = jnitrscdataDAO.selectJnitrscdata(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITRSCDATA 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITRSCDATA 목록
	 * @exception Exception
	 */
    public List<?> selectJnitrscdataList(JnitrscdataDefaultVO searchVO) throws Exception {
        return jnitrscdataDAO.selectJnitrscdataList(searchVO);
    }

    /**
	 * JNITRSCDATA 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITRSCDATA 총 갯수
	 * @exception
	 */
    public int selectJnitrscdataListTotCnt(JnitrscdataDefaultVO searchVO) {
		return jnitrscdataDAO.selectJnitrscdataListTotCnt(searchVO);
	}
    
    /**
     * JNITRSCDATA 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitrscdata() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("DATA_");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(15);
    	
        return egovIdGnrStrategy.makeId( (String)jnitrscdataDAO.getLastIdJnitrscdata() );
    }
}
