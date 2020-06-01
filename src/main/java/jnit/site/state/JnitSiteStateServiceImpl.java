/**
 * @version 3.2.0.1
 */
package jnit.site.state;

import javax.annotation.Resource;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : JnitsitestatelistServiceImpl.java
 * @Description : Jnitsitestatelist Business Implement class
 * @Modification Information
 *
 * @author JNITSITESTATE
 * @since 2014.07.10
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitSiteStateService")
public class JnitSiteStateServiceImpl extends EgovAbstractServiceImpl implements
        JnitSiteStateService {

    @Resource(name="jnitsitestateDAO")
    private JnitSiteStateDAO jnitsitestatelistDAO;
    
    /** ID Generation */
    //@Resource(name="{egovJnitsitestatelistIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	
    public void insertIp(CaseInsensitiveMap ciMap) throws Exception{
    	jnitsitestatelistDAO.insertIp(ciMap);
    }
    
    public void deleteIp(CaseInsensitiveMap ciMap) throws Exception{
    	jnitsitestatelistDAO.deleteIp(ciMap);
    }
    
    public int selectIp_Date(CaseInsensitiveMap ciMap) throws Exception{
    	return (Integer)jnitsitestatelistDAO.selectIp_Date(ciMap);
    }
    
    public int selectIp_Ip(CaseInsensitiveMap ciMap) throws Exception{
    	return (Integer)jnitsitestatelistDAO.selectIp_Ip(ciMap);
    }
    
    
    public void insertState(CaseInsensitiveMap ciMap) throws Exception{
    	jnitsitestatelistDAO.insertState(ciMap);
    }
    
    public void updateState(CaseInsensitiveMap ciMap) throws Exception{
    	jnitsitestatelistDAO.updateState(ciMap);
    }
    
    public CaseInsensitiveMap selectState_Column(CaseInsensitiveMap ciMap) throws Exception{
    	return (CaseInsensitiveMap) jnitsitestatelistDAO.selectState_Column(ciMap);
    }
    
    public int selectState_Date(CaseInsensitiveMap ciMap) throws Exception{
    	return (Integer) jnitsitestatelistDAO.selectState_Date(ciMap);
    }
    
    public CaseInsensitiveMap selectTotal(CaseInsensitiveMap ciMap) throws Exception{
    	return (CaseInsensitiveMap) jnitsitestatelistDAO.selectTotal(ciMap);
    }
    
}
