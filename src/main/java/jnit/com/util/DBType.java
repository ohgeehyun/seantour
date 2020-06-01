/**
 * @version 3.2.0.1
 */
package jnit.com.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.com.cmm.service.EgovProperties;

public class DBType {

	public static Log log = LogFactory.getLog(DBType.class);
	
	/**
	 * 
	 * @param dbType = cubrid, oracle, mysql ...
	 * @return boolean
	 */
	public static boolean getDbTypeBoolean(String type){
		
		String dbType = "";
		type = type.toUpperCase();
		boolean confirm = false;
		
		try{
			dbType = EgovProperties.getProperty("Globals.DbType").toUpperCase();
		} catch (NullPointerException e){
			log.error(e.getMessage());
			return false;
		}catch(Exception e){
			log.error(e.getMessage());
			return false;
		}
		
		try{
			if(dbType.equals(type)){
				confirm = true;
			}else{
				confirm = false;
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			return false;
		}catch(Exception e){
			log.error(e.getMessage());
			return false;
		}
		
		return confirm;
	}
	
	/**
	 * 
	 * @return toUpper DBType(대문자)
	 */
	public static String getDbTypeString(){
		
		String dbType = "";
		try{
			dbType = EgovProperties.getProperty("Globals.DbType").toUpperCase();
		} catch (NullPointerException e){
			log.error(e.getMessage());
			return "";
		}catch(Exception e){
			log.error(e.getMessage());
			return "";
		}
		return dbType;
	}
	
	/**
	 * 납품업체 정보
	 * @return toUpper DBType(소문자)
	 */
	public static String getGlobalInfoString(){
		
		String info = "";
		try{
			info = EgovProperties.getProperty("Globals.info").toLowerCase();
		} catch (NullPointerException e){
			log.error(e.getMessage());
			return "";
		}catch(Exception e){
			log.error(e.getMessage());
			return "";
		}
		return info;
	}
}
