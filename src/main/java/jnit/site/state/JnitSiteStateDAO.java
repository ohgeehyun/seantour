/**
 * @version 3.2.0.1
 */
package jnit.site.state;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitsitestatelistDAO.java
 * @Description : Jnitsitestatelist DAO Class
 * @Modification Information
 *
 * @author JNITSITESTATE
 * @since 2014.07.10
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitsitestateDAO")
public class JnitSiteStateDAO extends EgovComAbstractDAO {

	
	public void insertIp(CaseInsensitiveMap ciMap) throws Exception{
		insert("jnitSiteStateDAO.insertIp", ciMap);
	}
	
	public void deleteIp(CaseInsensitiveMap ciMap) throws Exception{
		delete("jnitSiteStateDAO.deleteIp", ciMap);
	}
	
	public int selectIp_Date(CaseInsensitiveMap ciMap) throws Exception{
		return (Integer) select("jnitSiteStateDAO.selectIp_Date", ciMap);
	}
	
	public int selectIp_Ip(CaseInsensitiveMap ciMap) throws Exception{
		return (Integer) select("jnitSiteStateDAO.selectIp_Ip", ciMap);
	}
	
	
	
	public void insertState(CaseInsensitiveMap ciMap) throws Exception{
		insert("jnitSiteStateDAO.insertState", ciMap);
	}
	
	public void updateState(CaseInsensitiveMap ciMap) throws Exception{
		update("jnitSiteStateDAO.updateState", ciMap);
	}
	
	public CaseInsensitiveMap selectState_Column(CaseInsensitiveMap ciMap) throws Exception{
		return (CaseInsensitiveMap) select("jnitSiteStateDAO.selectState_Column", ciMap);
	}
	
	public int selectState_Date(CaseInsensitiveMap ciMap) throws Exception{
		return (Integer) select("jnitSiteStateDAO.selectState_Date", ciMap);
	}
	
	public CaseInsensitiveMap selectTotal(CaseInsensitiveMap ciMap) throws Exception{
		return (CaseInsensitiveMap) select("jnitSiteStateDAO.selectTotal", ciMap);
	}
	
}
