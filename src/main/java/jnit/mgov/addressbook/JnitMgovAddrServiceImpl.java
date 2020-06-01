/**
 * @version 3.2.0.1
 */
package jnit.mgov.addressbook;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitsmsaddressbookServiceImpl.java
 * @Description : Jnitsmsaddressbook Business Implement class
 * @Modification Information
 *
 * @author JNITSMSADDRESSBOOK
 * @since 2013.12.06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitMgovAddrService")
public class JnitMgovAddrServiceImpl extends EgovAbstractServiceImpl implements
        JnitMgovAddrService {

    @Resource(name="jnitMgovAddrDAO")
    private JnitMgovAddrDAO jnitMgovAddrDAO;
    
    /** ID Generation */
    @Resource(name="jnitMgovAddrGrpIdGnrService")    
    private EgovIdGnrService grpIdGnrService;
    
    /** ID Generation */
    @Resource(name="jnitMgovAddrListIdGnrService")    
    private EgovIdGnrService listIdGnrService;

    public void insertJnitMgovAddrGrp(JnitMgovAddrGrpVO vo) throws Exception{
    	String id = grpIdGnrService.getNextStringId();
    	vo.setGrpId(id);
    	jnitMgovAddrDAO.insertJnitMgovAddrGrp(vo);
    }
    
    public void insertJnitMgovAddrList(JnitMgovAddrListVO vo) throws Exception{
    	String id = listIdGnrService.getNextStringId();
    	vo.setListId(id);
    	jnitMgovAddrDAO.insertJnitMgovAddrList(vo);
    }
    
    public void deleteJnitMgovAddrGrp(JnitMgovAddrGrpVO vo) throws Exception{
    	jnitMgovAddrDAO.deleteJnitMgovAddrGrp(vo);
    }
	
    public void deleteJnitMgovAddrList(JnitMgovAddrListVO vo) throws Exception{
    	jnitMgovAddrDAO.deleteJnitMgovAddrList(vo);
    }
    
    public List<?> selectJnitMgovAddrGrp(JnitMgovAddrDefaultVO searchVO) throws Exception{
    	return (List)jnitMgovAddrDAO.selectJnitMgovAddrGrp(searchVO);
    }
    
    public List<?> selectJnitMgovAddrList(JnitMgovAddrDefaultVO searchVO) throws Exception{
    	return (List)jnitMgovAddrDAO.selectJnitMgovAddrList(searchVO);
    }
	
    public String getLastIdJnitMgovAddrGrp() throws Exception{
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
    	return (String)jnitMgovAddrDAO.getLastIdJnitMgovAddrGrp();
    }
    
    public String getLastIdJnitMgovAddrList() throws Exception{
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
    	return (String)jnitMgovAddrDAO.getLastIdJnitMgovAddrList();
    }
	
	
    /*
    public String insertJnitsmsaddressbook(JnitsmsaddressbookVO vo) throws Exception {
    	
    	String id = egovIdGnrService.getNextStringId();
    	vo.setAddrId(id);
    	log.debug(vo.toString());
    	
    	jnitsmsaddressbookDAO.insertJnitsmsaddressbook(vo);
        return null;
    }

    public void updateJnitsmsaddressbook(JnitsmsaddressbookVO vo) throws Exception {
        jnitsmsaddressbookDAO.updateJnitsmsaddressbook(vo);
    }

    public void deleteJnitsmsaddressbook(JnitsmsaddressbookVO vo) throws Exception {
        jnitsmsaddressbookDAO.deleteJnitsmsaddressbook(vo);
    }

    public JnitsmsaddressbookVO selectJnitsmsaddressbook(JnitsmsaddressbookVO vo) throws Exception {
        JnitsmsaddressbookVO resultVO = jnitsmsaddressbookDAO.selectJnitsmsaddressbook(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    public List selectJnitsmsaddressbookList(JnitMgovAddrDefaultVO searchVO) throws Exception {
        return jnitsmsaddressbookDAO.selectJnitsmsaddressbookList(searchVO);
    }

    public int selectJnitsmsaddressbookListTotCnt(JnitMgovAddrDefaultVO searchVO) {
		return jnitsmsaddressbookDAO.selectJnitsmsaddressbookListTotCnt(searchVO);
	}
    
    public String getLastIdJnitsmsaddressbook() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitsmsaddressbookDAO.getLastIdJnitsmsaddressbook() );
    }
    */
}
