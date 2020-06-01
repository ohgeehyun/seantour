/**
 * @version 3.2.0.1
 */
package jnit.mgov.module;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitvisitlogServiceImpl.java
 * @Description : Jnitvisitlog Business Implement class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.10.29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitmgovService")
public class JnitMgovServiceImpl extends EgovAbstractServiceImpl implements
	JnitMgovService {

    @Resource(name="jnitmgovDAO")
    private JnitMgovDAO jnitmgovDAO;
    
    public String insertJnitmgov(JnitMsgdataVO vo) throws Exception {
    	
    	
    	jnitmgovDAO.insertJnitmgov(vo);
        return null;
    }
    
    public String insertJnitLtskoreaSms(JnitMsgdataVO vo) throws Exception {
    	
    	
    	jnitmgovDAO.insertJnitLtskoreaSms(vo);
        return null;
    }
    
    public void insertJnitmgovMMS(JnitMmsContentsInfoVO vo) throws Exception {
    	jnitmgovDAO.insertJnitmgovMMS(vo);
    }
    
    public void deleteJnitmgov(JnitMsgdataVO vo) throws Exception {
    	jnitmgovDAO.deleteJnitmgov(vo);
    }
    
    public void updateMgovSeq() throws Exception{
    	jnitmgovDAO.updateMgovSeq();
    }

    public int getMgovSeq() throws Exception {
    	return jnitmgovDAO.getMgovSeq();
    }
    
    public int getMgovNextId() throws Exception {
    	return jnitmgovDAO.getMgovNextId();
    }
    
    public JnitMsgdataVO selectJnitmgov(JnitMsgdataVO vo) throws Exception {
    	JnitMsgdataVO resultVO = jnitmgovDAO.selectJnitmgov(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    public List<?> selectJnitmgovList(JnitMgovDefaultVO searchVO) throws Exception {
        return jnitmgovDAO.selectJnitmgovList(searchVO);
    }
    
    public List<?> selectJnitmgovState(JnitMgovDefaultVO searchVO) throws Exception {
        return jnitmgovDAO.selectJnitmgovState(searchVO);
    }
    
    public List<?> selectJnitmgovLMSList(JnitMgovDefaultVO searchVO) throws Exception {
        return jnitmgovDAO.selectJnitmgovLMSList(searchVO);
    }

    public int selectJnitmgovListTotCnt(JnitMgovDefaultVO searchVO) {
		return jnitmgovDAO.selectJnitmgovListTotCnt(searchVO);
	}
    
    public int selectJnitmgovLMSListTotCnt(JnitMgovDefaultVO searchVO) {
		return jnitmgovDAO.selectJnitmgovLMSListTotCnt(searchVO);
	}
    
    public String getLastIdJnitmgov() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitmgovDAO.getLastIdJnitmgov() );
    }
}
