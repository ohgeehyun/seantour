/**
 * @version 3.2.0.1
 */
package jnit.cms.tpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmstplServiceImpl.java
 * @Description : Jnitcmstpl Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmstplService")
public class JnitcmstplServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmstplService {

    @Resource(name="jnitcmstplDAO")
    private JnitcmstplDAO jnitcmstplDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSTPLIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSTPL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmstplVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmstpl(JnitcmstplVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setTplId(id);
    	
    	
    	jnitcmstplDAO.insertJnitcmstpl(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }

    /**
	 * JNITCMSTPL을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmstplVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmstpl(JnitcmstplVO vo) throws Exception {
        jnitcmstplDAO.updateJnitcmstpl(vo);
    }

    /**
	 * JNITCMSTPL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmstplVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmstpl(JnitcmstplVO vo) throws Exception {
        jnitcmstplDAO.deleteJnitcmstpl(vo);
    }

    /**
	 * JNITCMSTPL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmstplVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmssitetpl(JnitcmstplVO vo) throws Exception {
        jnitcmstplDAO.deleteJnitcmssitetpl(vo);
    }
    
    /**
	 * JNITCMSTPL을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmstplVO
	 * @return 조회한 JNITCMSTPL
	 * @exception Exception
	 */
    public JnitcmstplVO selectJnitcmstpl(JnitcmstplVO vo) throws Exception {
        JnitcmstplVO resultVO = jnitcmstplDAO.selectJnitcmstpl(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSTPL을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 조회한 JNITCMSTPL
	 * @exception Exception
	 */
    public JnitcmstplVO selectJnitcmstpltype(JnitcmstplDefaultVO searchVO) throws Exception {
        JnitcmstplVO resultVO = jnitcmstplDAO.selectJnitcmstpltype(searchVO);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }
    
    /**
	 * JNITCMSTPL 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSTPL 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmstplList(JnitcmstplDefaultVO searchVO) throws Exception {
        return jnitcmstplDAO.selectJnitcmstplList(searchVO);
    }

    /**
	 * JNITCMSTPL 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSTPL 총 갯수
	 * @exception
	 */
    public int selectJnitcmstplListTotCnt(JnitcmstplDefaultVO searchVO) {
		return jnitcmstplDAO.selectJnitcmstplListTotCnt(searchVO);
	}
    /**
	 * JNITCMSTPL 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSTPL 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmstplCopyList(JnitcmstplDefaultVO searchVO) throws Exception {
        return jnitcmstplDAO.selectJnitcmstplCopyList(searchVO);
    }

    /**
	 * JNITCMSTPL 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSTPL 총 갯수
	 * @exception
	 */
    public int selectJnitcmstplCopyListTotCnt(JnitcmstplDefaultVO searchVO) {
		return jnitcmstplDAO.selectJnitcmstplCopyListTotCnt(searchVO);
	}
    
    
    /**
     * JNITCMSTPL 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmstpl() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("TPL_");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(6);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmstplDAO.getLastIdJnitcmstpl() );
    }
    
    /**
     * 템플릿 정보를 코드형태로 리턴한다.
     * 
     * @param 조회조건정보 vo
     * @return 그룹정보 List
     * @throws Exception
     */
    public List<CmmnDetailCode> selectTplIdDetail(ComDefaultCodeVO vo) throws Exception {
   		return jnitcmstplDAO.selectTplIdDetail(vo);
    }
}
