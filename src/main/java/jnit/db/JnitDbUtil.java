/**
 * @version 3.2.0.1
 */
package jnit.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import jnit.com.util.DBType;

public class JnitDbUtil {
	public static Log log = LogFactory.getLog(JnitDbUtil.class);
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
	public JnitDbUtil(){
		
	}
	
	
	
	/**
	 * @param type			- ADD or MODIFY or DROP 3개중 1개 선택 ( 현재 DROP은 구현하지 않음 )
	 * @param tableNm		- 테이블 명
	 * @param column		- 컬럼 명
	 * @param columnType	- 컬럼 타입을 넣어주세요.
	 * @param size			- 컬럼 사이즈
	 * @param defaultValue	- 기본값 문자열을 기본값으로 하려면 <b>'1'</b> 숫자를 기본값으로 하려면 <b>1</b> 문자와 숫자는 홑따옴표로 구분한다.
	 * @return	boolean 성공하면 true 실패하면 false;
	 */
	public static boolean alterTable(String type, String tableNm, String column, String columnType, String size, String defaultValue){

		type = NullUtil.nullString(type);
		tableNm = NullUtil.nullString(tableNm);
		column = NullUtil.nullString(column);
		columnType = NullUtil.nullString(columnType);
		size = NullUtil.nullString(size);
		defaultValue = NullUtil.nullString(defaultValue);
		
		if(type.equals("")){
			if("true".equals(deDug)) log.debug("Err1. Type Is Null");
			return false;
		}else if(tableNm.equals("")){
			if("true".equals(deDug)) log.debug("Err2. TableName Is Null");
			return false;
		}else if(column.equals("")){
			if("true".equals(deDug)) log.debug("Err3. Column Is Null");
			return false;
		}else if(columnType.equals("")){
			if("true".equals(deDug)) log.debug("Err4. ColumnType Is Null");
			return false;
		}
		
		
		type = type.toUpperCase();
		//tableNm = tableNm.toUpperCase();
		if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
			column = "\""+column+"\"";
		}
		columnType = JnitDbUtil.dbTypeAutoChange(columnType.toUpperCase());
		
		
		Pattern pattern = Pattern.compile("^[0-9]*$");
		Matcher matcher = pattern.matcher(size);
		
		if(!matcher.find()){
			if("true".equals(deDug)) log.debug("Err5. Numberic Only || Input : " + size);
			return false;
		}
		
		if(!type.equals("ADD") && !type.equals("MODIFY") && !type.equals("DROP")){
			if("true".equals(deDug)) log.debug("Err6. Type Only : ADD or MODIFY or DROP || Input : " + type);
			return false;
		}
		
		String className = NullUtil.nullString(EgovProperties.getProperty("Globals.DriverClassName"));
		String url = NullUtil.nullString(EgovProperties.getProperty("Globals.Url"));
		String id = NullUtil.nullString(EgovProperties.getProperty("Globals.UserName"));
		String passwd = NullUtil.nullString(EgovProperties.getProperty("Globals.Password"));
		String dbType = NullUtil.nullString(EgovProperties.getProperty("Globals.DbType"));
		
		String query = "";
		
		if(!className.equals("") && !url.equals("") && !id.equals("") && !id.equals("") && !passwd.equals("") && !dbType.equals("")){
			dbType = dbType.toUpperCase();
		}else{
			return false;
		}
		
		if(type.equals("ADD")){
			
			if("CUBRID".equals(dbType)){
				type = type + " COLUMN";
			}
			
			query = "ALTER TABLE " + tableNm + " " + type + " " + column + " " + columnType;
			
			if(!size.equals("")){
				query = query + " ("+size+")";
			}
			if(!defaultValue.equals("")){
				query = query + " DEFAULT " + defaultValue;
			}
			
		}else if(type.equals("MODIFY")){
			
			query = "ALTER TABLE " + tableNm + " " + type + " " + column + " " + columnType;
			if(!defaultValue.equals("")){
				query = query + " DEFAULT " + defaultValue;
			}
			
		}else if(type.equals("DROP")){
			
			//데이터 손실 우려가 있어서 개발하지 않음.
			return false;
		}else{
			
			return false;
			
		}
		
    	try {
			Class.forName(className);
			Connection conn = DriverManager.getConnection(url, id, passwd);
			
			Statement stmt = conn.createStatement();			
			stmt.execute(query);
			stmt.close();
		} catch (ClassNotFoundException e) {
			log.error(e.getMessage());
			return false;
		} catch (SQLException e) {
			log.error(e.getMessage());
			return false;
		}
    	
    	return true;
    }
	
	/**
	 * @param tableNm	- 테이블 명
	 * @param column	- 컬럼 명
	 * @param value		- 값 문자와 숫자는 홑따옴표로 구분한다. ex) 숫자 : <b>1</b> or 문자 : <b>'1'</b>
	 * @return	boolean 성공하면 true 실패하면 false;
	 */
	public static boolean insertInto(String tableNm, String column, String value){

		tableNm = NullUtil.nullString(tableNm);
		column = NullUtil.nullString(column);
		value = NullUtil.nullString(value);
		
		if(tableNm.equals("")){
			if("true".equals(deDug)) log.debug("Err1. TableName Is Null");
			return false;
		}else if(column.equals("")){
			if("true".equals(deDug)) log.debug("Err2. Column Is Null");
			return false;
		}else if(value.equals("")){
			if("true".equals(deDug)) log.debug("Err3. Value Is Null");
			return false;
		}
		
		String className = NullUtil.nullString(EgovProperties.getProperty("Globals.DriverClassName"));
		String url = NullUtil.nullString(EgovProperties.getProperty("Globals.Url"));
		String id = NullUtil.nullString(EgovProperties.getProperty("Globals.UserName"));
		String passwd = NullUtil.nullString(EgovProperties.getProperty("Globals.Password"));
		String dbType = NullUtil.nullString(EgovProperties.getProperty("Globals.DbType"));
		
		String query = "";
		
		if(!className.equals("") && !url.equals("") && !id.equals("") && !id.equals("") && !passwd.equals("") && !dbType.equals("")){
			dbType = dbType.toUpperCase();
		}else{
			return false;
		}
		
		query = "INSERT INTO " + tableNm + " ( " + column + " ) VALUES( " + value + " )" ;
		
    	try {
			Class.forName(className);
			Connection conn = DriverManager.getConnection(url, id, passwd);
			
			Statement stmt = conn.createStatement();
			stmt.execute(query);
			stmt.close();
		} catch (ClassNotFoundException e) {
			log.error(e.getMessage());
			return false;
		} catch (SQLException e) {
			log.error(e.getMessage());
			return false;
		}
		
    	return true;
    }
	
	public static String dbTypeAutoChange(String columnType){
		
		String dbType = DBType.getDbTypeString();
		HashMap<String, String> dbTypeMap = new HashMap<String, String>();
		
		dbType = NullUtil.nullString(dbType);
		columnType = NullUtil.nullString(columnType);
		if(dbType.equals("")){
			if("true".equals(deDug)) log.debug("Err1. dbType Is Null");
			return columnType;
		}else if(columnType.equals("")){
			if("true".equals(deDug)) log.debug("Err2. columnType Is Null");
			return columnType;
		}
		
		dbType = dbType.toUpperCase();
		columnType = columnType.toUpperCase();
		
		if(dbType.equals("ORACLE")||dbType.equals("TIBERO")){
			dbTypeMap.put("VARCHAR", "VARCHAR2");
			dbTypeMap.put("STRING", "CLOB");
			dbTypeMap.put("TEXT", "CLOB");
			dbTypeMap.put("INT", "NUMBER");
			dbTypeMap.put("INTEGER", "NUMBER");
			dbTypeMap.put("DATETIME", "DATE");
		}else if(dbType.equals("CUBRID")){
			dbTypeMap.put("VARCHAR2", "VARCHAR");
			dbTypeMap.put("CLOB", "STRING");
			dbTypeMap.put("TEXT", "STRING");
			dbTypeMap.put("INT", "INTEGER");
			dbTypeMap.put("NUMBER", "INTEGER");
		}else if(dbType.equals("MYSQL")){
			dbTypeMap.put("VARCHAR2", "VARCHAR");
			dbTypeMap.put("CLOB", "TEXT");
			dbTypeMap.put("STRING", "TEXT");
			dbTypeMap.put("NUMBER", "INT");
			dbTypeMap.put("INTEGER", "INT");
		}
		
		if(dbTypeMap.get(columnType) != null){
			columnType = dbTypeMap.get(columnType);
		}
		
		return columnType;
		
	}
}
