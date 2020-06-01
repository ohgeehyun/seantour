package jnit.board.media;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.net.util.Base64;
import org.bouncycastle.util.encoders.Base64Encoder;
import org.springframework.stereotype.Service;

import sun.misc.BASE64Encoder;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

import jnit.board.media.JnitboardmediaService;
import jnit.board.media.JnitboardmediaDefaultVO;
import jnit.board.media.JnitboardmediaVO;
import jnit.board.media.JnitboardmediaDAO;

/**
 * @Class Name : JnitboardmediaServiceImpl.java
 * @Description : Jnitboardmedia Business Implement class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.01.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("JnitboardmediaService")
public class JnitboardmediaServiceImpl extends EgovAbstractServiceImpl implements
        JnitboardmediaService {

    @Resource(name="JnitboardmediaDAO")
    private JnitboardmediaDAO JnitboardmediaDAO;
    
    /** ID Generation */
    @Resource(name="jnitBOARDMEDIAIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

    public static final String SEPERATOR = File.separator;
    
	/**
	 * Jnitboardmedia을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardmediaVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitboardmedia(JnitboardmediaVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	String id = egovIdGnrService.getNextStringId();
    	vo.setJnitmediaId(Integer.valueOf(id));
    	    	
    	JnitboardmediaDAO.insertJnitboardmedia(vo);    	
        return id;
    }
    
    /**
	 * Jnitboardmedia을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardmediaVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitboardmedia(JnitboardmediaVO vo) throws Exception {
        JnitboardmediaDAO.updateJnitboardmedia(vo);
    }

    /**
	 * Jnitboardmedia을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardmediaVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboardmedia(JnitboardmediaVO vo) throws Exception {
        JnitboardmediaDAO.deleteJnitboardmedia(vo);
    }

    /**
	 * Jnitboardmedia을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardmediaVO
	 * @return 조회한 Jnitboardmedia
	 * @exception Exception
	 */
    public JnitboardmediaVO selectJnitboardmedia(JnitboardmediaVO vo) throws Exception {
        JnitboardmediaVO resultVO = JnitboardmediaDAO.selectJnitboardmedia(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * Jnitboardmedia 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return Jnitboardmedia 목록
	 * @exception Exception
	 */
    public List<?> selectJnitboardmediaList(JnitboardmediaDefaultVO searchVO) throws Exception {
        return JnitboardmediaDAO.selectJnitboardmediaList(searchVO);
    }

    /**
	 * Jnitboardmedia 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return Jnitboardmedia 총 갯수
	 * @exception
	 */
    public int selectJnitboardmediaListTotCnt(JnitboardmediaDefaultVO searchVO) {
		return JnitboardmediaDAO.selectJnitboardmediaListTotCnt(searchVO);
	}
    
    /**
     * Jnitboardmedia 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitboardmedia() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)JnitboardmediaDAO.getLastIdJnitboardmedia() );
    }

}
