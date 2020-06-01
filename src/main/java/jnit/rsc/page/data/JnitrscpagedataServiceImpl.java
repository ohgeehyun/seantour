/**
 * @version 3.2.0.1
 */
package jnit.rsc.page.data;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitrscpagedataServiceImpl.java
 * @Description : Jnitrscpagedata Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitrscpagedataService")
public class JnitrscpagedataServiceImpl extends EgovAbstractServiceImpl implements
        JnitrscpagedataService {

    @Resource(name="jnitrscpagedataDAO")
    private JnitrscpagedataDAO jnitrscpagedataDAO;
    
    /** ID Generation */
    @Resource(name="jnitRSCPAGEDATAIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitrscpagedata을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitrscpagedataVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitrscpagedata(JnitrscpagedataVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setPdataId(id);
    	
    	
    	jnitrscpagedataDAO.insertJnitrscpagedata(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * jnitrscpagedata을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitrscpagedataVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitrscpagedata(JnitrscpagedataVO vo) throws Exception {
        jnitrscpagedataDAO.updateJnitrscpagedata(vo);
    }

    /**
	 * jnitrscpagedata을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitrscpagedataVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitrscpagedata(JnitrscpagedataVO vo) throws Exception {
        jnitrscpagedataDAO.deleteJnitrscpagedata(vo);
    }

    /**
	 * jnitrscpagedata을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpagedataVO
	 * @return 조회한 jnitrscpagedata
	 * @exception Exception
	 */
    public JnitrscpagedataVO selectJnitrscpagedata(JnitrscpagedataVO vo) throws Exception {
        JnitrscpagedataVO resultVO = jnitrscpagedataDAO.selectJnitrscpagedata(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitrscpagedata 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitrscpagedata 목록
	 * @exception Exception
	 */
    public List<?> selectJnitrscpagedataList(JnitrscpagedataDefaultVO searchVO) throws Exception {
        return jnitrscpagedataDAO.selectJnitrscpagedataList(searchVO);
    }

    /**
	 * jnitrscpagedata 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitrscpagedata 총 갯수
	 * @exception
	 */
    public int selectJnitrscpagedataListTotCnt(JnitrscpagedataDefaultVO searchVO) {
		return jnitrscpagedataDAO.selectJnitrscpagedataListTotCnt(searchVO);
	}
    
    /**
     * jnitrscpagedata 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitrscpagedata() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitrscpagedataDAO.getLastIdJnitrscpagedata() );
    }
}
