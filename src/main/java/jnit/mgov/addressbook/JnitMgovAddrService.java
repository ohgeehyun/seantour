/**
 * @version 3.2.0.1
 */
package jnit.mgov.addressbook;

import java.util.List;

/**
 * @Class Name : JnitsmsaddressbookService.java
 * @Description : Jnitsmsaddressbook Business class
 * @Modification Information
 *
 * @author JNITSMSADDRESSBOOK
 * @since 2013.12.06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitMgovAddrService {
	
	void insertJnitMgovAddrGrp(JnitMgovAddrGrpVO vo) throws Exception;
	
	void insertJnitMgovAddrList(JnitMgovAddrListVO vo) throws Exception;
	
	void deleteJnitMgovAddrGrp(JnitMgovAddrGrpVO vo) throws Exception;
	
	void deleteJnitMgovAddrList(JnitMgovAddrListVO vo) throws Exception;
	
	List selectJnitMgovAddrGrp(JnitMgovAddrDefaultVO searchVO) throws Exception;
	
	List selectJnitMgovAddrList(JnitMgovAddrDefaultVO searchVO) throws Exception;
	
	String getLastIdJnitMgovAddrGrp() throws Exception;
	
	String getLastIdJnitMgovAddrList() throws Exception;
	
}
