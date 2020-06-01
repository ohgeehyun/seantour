package jnit.menu;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

import jnit.menu.JnitmenuService;
import jnit.menu.JnitmenuDefaultVO;
import jnit.menu.JnitmenuVO;
import jnit.menu.JnitmenuDAO;

/**
 * @Class Name : JnitmenuServiceImpl.java
 * @Description : Jnitmenu Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.28
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitmenuService")
public class JnitmenuServiceImpl extends EgovAbstractServiceImpl implements
        JnitmenuService {

    @Resource(name="jnitmenuDAO")
    private JnitmenuDAO jnitmenuDAO;
    
    /** ID Generation */
    //@Resource(name="{egovJnitmenuIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITMENU을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitmenuVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitmenu(JnitmenuVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	
    	
    	jnitmenuDAO.insertJnitmenu(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * JNITMENU을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitmenuVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitmenu(JnitmenuVO vo) throws Exception {
        jnitmenuDAO.updateJnitmenu(vo);
    }

    /**
	 * JNITMENU을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitmenuVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitmenu(JnitmenuVO vo) throws Exception {
        jnitmenuDAO.deleteJnitmenu(vo);
    }

    /**
	 * JNITMENU을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitmenuVO
	 * @return 조회한 JNITMENU
	 * @exception Exception
	 */
    public JnitmenuVO selectJnitmenu(JnitmenuVO vo) throws Exception {
        JnitmenuVO resultVO = jnitmenuDAO.selectJnitmenu(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }
    
    /**
	 * JNITMENUMAP을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitmenuVO
	 * @return 조회한 JNITMENU
	 * @exception Exception
	 */
    @SuppressWarnings("rawtypes")
	public HashMap selectJnitmenuMap(JnitmenuVO vo) throws Exception {
    	HashMap resultVO = jnitmenuDAO.selectJnitmenuMap(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITMENU 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITMENU 목록
	 * @exception Exception
	 */
    public List<?> selectJnitmenuList(JnitmenuDefaultVO searchVO) throws Exception {
        return jnitmenuDAO.selectJnitmenuList(searchVO);
    }

    /**
	 * JNITMENU 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITMENU 총 갯수
	 * @exception
	 */
    public int selectJnitmenuListTotCnt(JnitmenuDefaultVO searchVO) {
		return jnitmenuDAO.selectJnitmenuListTotCnt(searchVO);
	}
    
    /**
     * JNITMENU 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitmenu() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitmenuDAO.getLastIdJnitmenu() );
    }
}
