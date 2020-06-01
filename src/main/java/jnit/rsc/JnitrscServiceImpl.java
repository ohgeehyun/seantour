/**
 * @version 3.2.0.1
 */
package jnit.rsc;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitrscServiceImpl.java
 * @Description : Jnitrsc Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.04
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitrscService")
public class JnitrscServiceImpl extends EgovAbstractServiceImpl implements
        JnitrscService {

    @Resource(name="jnitrscDAO")
    private JnitrscDAO jnitrscDAO;
    
    /** ID Generation */
    @Resource(name="jnitRSCIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITRSC을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitrscVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitrsc(JnitrscVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setRscId(id);
    	
    	
    	jnitrscDAO.insertJnitrsc(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }

    /**
	 * JNITRSC을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitrscVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitrsc(JnitrscVO vo) throws Exception {
        jnitrscDAO.updateJnitrsc(vo);
    }

    /**
	 * JNITRSC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitrscVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitrsc(JnitrscVO vo) throws Exception {
        jnitrscDAO.deleteJnitrsc(vo);
    }

    /**
	 * JNITRSC을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscVO
	 * @return 조회한 JNITRSC
	 * @exception Exception
	 */
    public JnitrscVO selectJnitrsc(JnitrscVO vo) throws Exception {
        JnitrscVO resultVO = jnitrscDAO.selectJnitrsc(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITRSC 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITRSC 목록
	 * @exception Exception
	 */
    public List<?> selectJnitrscList(JnitrscDefaultVO searchVO) throws Exception {
        return jnitrscDAO.selectJnitrscList(searchVO);
    }

    /**
	 * JNITRSC 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITRSC 총 갯수
	 * @exception
	 */
    public int selectJnitrscListTotCnt(JnitrscDefaultVO searchVO) {
		return jnitrscDAO.selectJnitrscListTotCnt(searchVO);
	}
    
    /**
     * JNITRSC 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitrsc() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("RSC_");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(16);
    	
        return egovIdGnrStrategy.makeId( (String)jnitrscDAO.getLastIdJnitrsc() );
    }

	public JnitrscVO selectJnitrscByUrl(String url) {
		return jnitrscDAO.selectJnitrscByUrl(url);
	}
}
