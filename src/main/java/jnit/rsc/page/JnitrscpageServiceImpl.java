/**
 * @version 3.2.0.1
 */
package jnit.rsc.page;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitrscpageServiceImpl.java
 * @Description : Jnitrscpage Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitrscpageService")
public class JnitrscpageServiceImpl extends EgovAbstractServiceImpl implements
        JnitrscpageService {

    @Resource(name="jnitrscpageDAO")
    private JnitrscpageDAO jnitrscpageDAO;
    
    /** ID Generation */
    @Resource(name="jnitRSCPAGEIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitrscpage을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitrscpageVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitrscpage(JnitrscpageVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setRscpId(id);
    	
    	
    	jnitrscpageDAO.insertJnitrscpage(vo);
    	//TODO 해당 테이블 정보에 맞게 수정   
        return id;
    }

    /**
	 * jnitrscpage을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitrscpageVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitrscpage(JnitrscpageVO vo) throws Exception {
        jnitrscpageDAO.updateJnitrscpage(vo);
    }

    /**
	 * jnitrscpage을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitrscpageVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitrscpage(JnitrscpageVO vo) throws Exception {
        jnitrscpageDAO.deleteJnitrscpage(vo);
    }

    /**
	 * jnitrscpage을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpageVO
	 * @return 조회한 jnitrscpage
	 * @exception Exception
	 */
    public JnitrscpageVO selectJnitrscpage(JnitrscpageVO vo) throws Exception {
        JnitrscpageVO resultVO = jnitrscpageDAO.selectJnitrscpage(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
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
    	JnitrscpageViewVO resultVO = jnitrscpageDAO.selectJnitrscpageView(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }
    
    /**
	 * jnitrscpage을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpageVO
	 * @see JnitrscpageController
	 * {@link jnit.rsc.page.JnitrscpageController # addJnitrscpageView }
	 * @return 조회한 jnitrscpage
	 * @exception Exception
	 */
    public JnitrscpageViewVO selectJnitrscexpageView(JnitrscpageViewVO vo) throws Exception {
    	JnitrscpageViewVO resultVO = jnitrscpageDAO.selectJnitexpageView(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }
  

    /**
	 * jnitrscpage 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitrscpage 목록
	 * @exception Exception
	 */
    public List<?> selectJnitrscpageList(JnitrscpageDefaultVO searchVO) throws Exception {
        return jnitrscpageDAO.selectJnitrscpageList(searchVO);
    }

    /**
	 * jnitrscpage 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitrscpage 총 갯수
	 * @exception
	 */
    public int selectJnitrscpageListTotCnt(JnitrscpageDefaultVO searchVO) {
		return jnitrscpageDAO.selectJnitrscpageListTotCnt(searchVO);
	}
    
    /**
     * jnitrscpage 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitrscpage() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitrscpageDAO.getLastIdJnitrscpage() );
    }
    
    /**
	 * jnitrscpage을 Url로 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpageVO
	 * @return 조회한 jnitrscpage
	 * @exception Exception
	 */
    public JnitrscpageVO selectJnitrscpageByUrl(JnitrscpageVO vo) throws Exception {
        JnitrscpageVO resultVO = jnitrscpageDAO.selectJnitrscpageByUrl(vo);
        /*
        if (resultVO == null)
            throw processException("info.nodata.msg");
        */
        return resultVO;
    }
}
