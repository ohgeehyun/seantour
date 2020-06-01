/**
 * @version 3.2.0.1
 */
package jnit.login.log;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitloginlogServiceImpl.java
 * @Description : Jnitloginlog Business Implement class
 * @Modification Information
 *
 * @author JNITLOGINLOG
 * @since 2013.07.30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitloginlogService")
public class JnitloginlogServiceImpl extends EgovAbstractServiceImpl implements
        JnitloginlogService {

    @Resource(name="jnitloginlogDAO")
    private JnitloginlogDAO jnitloginlogDAO;
    
    /** ID Generation */
    @Resource(name="jnitLOGINLOG_IDGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitloginlog을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitloginlogVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitloginlog(JnitloginlogVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setIpId(id);
    	
    	
    	jnitloginlogDAO.insertJnitloginlog(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * jnitloginlog을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitloginlogVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitloginlog(JnitloginlogVO vo) throws Exception {
        jnitloginlogDAO.updateJnitloginlog(vo);
    }

    /**
	 * jnitloginlog을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitloginlogVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitloginlog(JnitloginlogVO vo) throws Exception {
        jnitloginlogDAO.deleteJnitloginlog(vo);
    }

    /**
	 * jnitloginlog을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitloginlogVO
	 * @return 조회한 jnitloginlog
	 * @exception Exception
	 */
    public JnitloginlogVO selectJnitloginlog(JnitloginlogVO vo) throws Exception {
        JnitloginlogVO resultVO = jnitloginlogDAO.selectJnitloginlog(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitloginlog 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitloginlog 목록
	 * @exception Exception
	 */
    public List<?> selectJnitloginlogList(JnitloginlogDefaultVO searchVO) throws Exception {
        return jnitloginlogDAO.selectJnitloginlogList(searchVO);
    }
    /**
     * LEFT JOIN
     * JNITCMSMBR b
     * JNITCMSORG c
     * JNITCMSPOS d 
	 * jnitloginlog 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitloginlog 목록
	 * @exception Exception
	 */
    public List<?> selectLeftJoinloginlogList(JnitloginlogDefaultVO searchVO) throws Exception {
        return jnitloginlogDAO.selectLeftJoinloginlogList(searchVO);
    }

    /**
	 * jnitloginlog 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitloginlog 총 갯수
	 * @exception
	 */
    public int selectJnitloginlogListTotCnt(JnitloginlogDefaultVO searchVO) {
		return jnitloginlogDAO.selectJnitloginlogListTotCnt(searchVO);
	}
    
    /**
     * LEFT JOIN
     * JNITCMSMBR b
     * JNITCMSORG c
     * JNITCMSPOS d
	 * jnitloginlog 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitloginlog 총 갯수
	 * @exception
	 */
    public int selectLeftJoinloginlogListTotCnt(JnitloginlogDefaultVO searchVO) {
		return jnitloginlogDAO.selectLeftJoinloginlogListTotCnt(searchVO);
	}
    
    /**
     * jnitloginlog 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitloginlog() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitloginlogDAO.getLastIdJnitloginlog() );
    }
}
