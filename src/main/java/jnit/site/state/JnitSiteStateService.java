/**
 * @version 3.2.0.1
 */
package jnit.site.state;

import org.apache.commons.collections.map.CaseInsensitiveMap;

/**
 * @Class Name : JnitsitestatelistService.java
 * @Description : Jnitsitestatelist Business class
 * @Modification Information
 *
 * @author JNITSITESTATE
 * @since 2014.07.10
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitSiteStateService {
	
	
	void insertIp(CaseInsensitiveMap ciMap) throws Exception;
	
	void deleteIp(CaseInsensitiveMap ciMap) throws Exception;
	
	int selectIp_Date(CaseInsensitiveMap ciMap) throws Exception;
	
	int selectIp_Ip(CaseInsensitiveMap ciMap) throws Exception;
	
	
	void insertState(CaseInsensitiveMap ciMap) throws Exception;
	
	void updateState(CaseInsensitiveMap ciMap) throws Exception;
	
	CaseInsensitiveMap selectState_Column(CaseInsensitiveMap ciMap) throws Exception;
	
	int selectState_Date(CaseInsensitiveMap cimap) throws Exception;
	
	CaseInsensitiveMap selectTotal(CaseInsensitiveMap ciMap) throws Exception;
}
