/**
 * @version 3.2.0.1
 */
package jnit.cms.cnt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmscntServiceImpl.java
 * @Description : Jnitcmscnt Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmscntService")
public class JnitcmscntServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmscntService {

    @Resource(name="jnitcmscntDAO")
    private JnitcmscntDAO jnitcmscntDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSCNTIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSCNT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmscntVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmscnt(JnitcmscntVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setCntId(id);
    	
    	jnitcmscntDAO.insertJnitcmscnt(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }
    
    /**
	 * JNITCMSCNT을 등록한다.(INSERT SELECT)COPY
	 * @param vo - 등록할 정보가 담긴 JnitcmscntVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertSelectJnitcmscnt(JnitcmscntVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setCntId(id);
    	
    	jnitcmscntDAO.insertSelectJnitcmscnt(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }
    
    public String cntNextId() throws Exception{
    	String id = egovIdGnrService.getNextStringId();
    	
    	return id;
    }

    /**
	 * JNITCMSCNT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmscntVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmscnt(JnitcmscntVO vo) throws Exception {
        jnitcmscntDAO.updateJnitcmscnt(vo);
    }
    
    /**
	 * JNITCMSCNT OPT를 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmscntVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmscntOpt(JnitcmscntVO vo) throws Exception {
        jnitcmscntDAO.updateJnitcmscntOpt(vo);
    }
    
    /**
	 * JNITCMSCNT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmscntVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateWebcnt(JnitcmscntVO vo) throws Exception {
        jnitcmscntDAO.updateWebcnt(vo);
    }
    
    /** 외국어 사이트 동시 변경 */
    public void updateJnitcmscntLanguage(JnitcmscntVO vo) throws Exception{
    	jnitcmscntDAO.updateJnitcmscntLanguage(vo);
    }
    
    /**
	 * JNITCMSCNT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmscntVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmscnt(JnitcmscntVO vo) throws Exception {
        jnitcmscntDAO.deleteJnitcmscnt(vo);
    }

    /**
	 * JNITCMSCNT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmscntVO
	 * @return 조회한 JNITCMSCNT
	 * @exception Exception
	 */
    public JnitcmscntVO selectJnitcmscnt(JnitcmscntVO vo) throws Exception {
        JnitcmscntVO resultVO = jnitcmscntDAO.selectJnitcmscnt(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSCNT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNT 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmscntList(JnitcmscntDefaultVO searchVO) throws Exception {
        return jnitcmscntDAO.selectJnitcmscntList(searchVO);
    }
    
    /**
	 * JNITCMSCNT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNT 목록
	 * @exception Exception
	 */
    public List<?> selectLeftcntMenuList(JnitcmscntDefaultVO searchVO) throws Exception {
        return jnitcmscntDAO.selectLeftcntMenuList(searchVO);
    }
    
    /**
	 * JNITCMSCNT 목록을 조회한다.
	 * LEFT JOIN JNITCMSMENU
	 * LEFT JOIN JNITCMSTPL
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNT 목록
	 * @exception Exception
	 */
    public List<?> selectLeftJoincntList(JnitcmscntDefaultVO searchVO) throws Exception {
        return jnitcmscntDAO.selectLeftJoincntList(searchVO);
    }

    /**
	 * JNITCMSCNT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNT 총 갯수
	 * @exception
	 */
    public int selectJnitcmscntListTotCnt(JnitcmscntDefaultVO searchVO) {
		return jnitcmscntDAO.selectJnitcmscntListTotCnt(searchVO);
	}
    
    /**
	 * JNITCMSCNT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNT 총 갯수
	 * @exception
	 */
    public int selectLeftcntMenuListTotCnt(JnitcmscntDefaultVO searchVO) {
		return jnitcmscntDAO.selectLeftcntMenuListTotCnt(searchVO);
	}
    
    /**
	 * JNITCMSCNT 총 갯수를 조회한다.
	 * LEFT JOIN JNITCMSMENU.
	 * LEFT JOIN JNITCMSTPL.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNT 총 갯수
	 * @exception
	 */
    public int selectLeftJoincntListTotCnt(JnitcmscntDefaultVO searchVO) {
		return jnitcmscntDAO.selectLeftJoincntListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSCNT 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmscnt() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmscntDAO.getLastIdJnitcmscnt() );
    }
}
